import DS from 'ember-data';

const { attr } = DS;

export default DS.Model.extend({
  url: attr('string'),
  name: attr('string'),
  uploadedAt: attr('date')
});
