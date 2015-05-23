import DS from 'ember-data';

const { attr } = DS;

export default DS.Model.extend({
  url: attr('string'),
  filename: attr('string'),
  uploadedAt: attr('string')
});
