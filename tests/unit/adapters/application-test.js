import {
  moduleFor,
  test
} from 'ember-qunit';

moduleFor('adapter:application', 'ApplicationAdapter');

test('it has the correct namespace', function(assert) {
  const adapter = this.subject();
  assert.equal(adapter.get('namespace'), 'api');
});
