import Ember from 'ember';
import { request } from 'ic-ajax';

const { get, set, RSVP } = Ember;

export default Ember.Route.extend({
  loadPhoto(url) {
    const { resolve, reject, promise } = RSVP.defer();
    const img = new Image();
    img.src = url;
    img.onload = () => { resolve(img); };
    img.onerror = reject;

    return promise;
  },

  actions: {
    uploadPhoto: function (file) {
      var image = this.store.createRecord('image', {
        name: get(file, 'name'),
        uploadedAt: new Date()
      });

      file.read().then((url) => {
        return this.loadPhoto(url);
      }).then(function (img) {
        set(image, 'width', img.width);
        set(image, 'height', img.height);
      });

      request('/api/images/s3_direct', {
        data: {
          filename: get(file, 'name')
        }
      }).then(function (s3Direct) {
        return file.upload(s3Direct.url, {
          data: s3Direct.credentials
        });
      }).then(function (result) {
        set(image, 'url', result.headers.Location);
        image.save();
      });
    }
  },

  model: function () {
    return this.store.findAll('image');
  }
});
