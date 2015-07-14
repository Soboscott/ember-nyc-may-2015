import Ember from 'ember';

const reads = Ember.computed.reads;
const get = Ember.get;

export default Ember.Component.extend({
  classNames: ['progress-bar'],
  attributeBindings: ['aria-valuemin',
                      'aria-valuemax',
                      'aria-valuenow'],

  value: 0,

  ariaRole: 'progressbar',
  'aria-valuemin': 0,
  'aria-valuemax': 100,
  'aria-valuenow': reads('value'),

  style: function () {
    return `width: ${get(this, 'value')}%`.htmlSafe();
  }.property('width')
});
