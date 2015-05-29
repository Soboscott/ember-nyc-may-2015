import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['photo-uploader'],
  classNameBindings: ['dropzone.active:active',
                      'dropzone.valid:valid:invalid']
});
