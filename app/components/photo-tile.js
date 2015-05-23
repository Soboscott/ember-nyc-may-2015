import Ember from 'ember';

const { get } = Ember;

export default Ember.Component.extend({
  classNames: ['photo-tile'],
  attributeBindings: ['style'],

  style: function () {
    return `max-width: ${get(this, 'photo.width')}px`.htmlSafe();
  }.property('photo.width')
});
