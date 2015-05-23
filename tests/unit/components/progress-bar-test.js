import Ember from 'ember';
import {
  moduleForComponent,
  test
} from 'ember-qunit';

moduleForComponent('progress-bar');

test('it is accessible by screen readers', function (assert) {
  assert.expect(4);

  const component = this.subject();
  this.render();

  const $component = component.$();
  assert.equal($component.attr('role'), 'progressbar');
  assert.equal($component.attr('aria-valuemin'), '0');
  assert.equal($component.attr('aria-valuemax'), '100');
  assert.equal($component.attr('aria-valuenow'), '0');
});

test('it updates the bar width when the progress changes', function (assert) {
  assert.expect(4);

  const component = this.subject();
  this.render();

  const $component = component.$();
  const $bar = component.$('div');
  assert.equal($component.attr('aria-valuenow'), '0');
  assert.equal($bar.attr('style'), 'width: 0%');

  Ember.run(component, 'set', 'value', 50);

  assert.equal($component.attr('aria-valuenow'), '50');
  assert.equal($bar.attr('style'), 'width: 50%');
});
