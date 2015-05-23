require 'openssl'
require 'base64'
require 'json'

#
# Generates signed parameters to upload files directly to S3.
#
# json = S3Direct.new({
#   bucket: 'my-bucket',
#   acl: 'public-read',
#   key: 'uploads/${filename}',
#   expiration: Date.new + 1
# }).to_json
#
class S3Direct
  def initialize(options = {})
    require_options(options, :bucket, :expiration, :key, :acl)
    @access_key = ENV['AWS_ACCESS_KEY_ID']
    @secret_key = ENV['AWS_SECRET_ACCESS_KEY']
    @options = options
  end

  def signature
    Base64.strict_encode64(
      OpenSSL::HMAC.digest('sha1', @secret_key, policy)
    )
  end

  def policy
    Base64.strict_encode64({
      expiration: @options[:expiration].utc.iso8601,
      conditions: conditions
    }.to_json)
  end

  def to_json
    {
      url: "https://#{@options[:bucket]}.s3.amazonaws.com",
      credentials: {
        AWSAccessKeyId: @access_key,
        policy:         policy,
        signature:      signature,
        acl:            @options[:acl],
        key:            @options[:key]
      }
    }.to_json
  end

  private

  def conditions
    dynamic_key = @options[:key].include?('${filename}')
    if dynamic_key
      prefix = @options[:key][0..(@options[:key].index('${filename}') - 1)]
    end

    conditions = (@options[:conditions] || []).map(&:clone)
    conditions << { bucket: @options[:bucket] }
    conditions << { acl: @options[:acl] }
    conditions << { key: @options[:key] } unless dynamic_key
    conditions << ['starts-with', '$key', prefix] if dynamic_key
    conditions << ['starts-with', '$Content-Type', '']
  end

  private

  def require_options(options, *keys)
    missing_keys = keys.select { |key| !options.key?(key) }
    return unless missing_keys.any?
    raise ArgumentError, missing_keys.map { |key| ":#{key} is required to generate a S3 upload policy." }.join('\n')
  end
end
