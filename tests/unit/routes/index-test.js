import {
  moduleFor,
  test
} from 'ember-qunit';

moduleFor('route:index');

test('it handles image uploads', function (assert) {
  const route = this.subject();
  assert.ok(route);
});
