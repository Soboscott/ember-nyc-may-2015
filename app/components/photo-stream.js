import Ember from 'ember';

const { get } = Ember;
const { sort, min, mapBy } = Ember.computed;

export default Ember.Component.extend({
  classNames: ['photo-stream'],
  attributeBindings: ['style'],

  sortPhotosBy: ['uploadedAt:desc'],
  sortedPhotos: sort('photos', 'sortPhotosBy'),
  widths: mapBy('photos', 'width'),
  width: min('widths'),

  style: function () {
    return `max-width: ${get(this, 'width')}px`.htmlSafe();
  }.property('width')
});
