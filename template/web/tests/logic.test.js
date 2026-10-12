import { test } from 'node:test';
import assert from 'node:assert/strict';
import { addItem, removeItem } from '../src/logic.js';

test('addItem voegt toe en trimt', () => {
  const r = addItem([], '  melk ');
  assert.equal(r.length, 1);
  assert.equal(r[0].text, 'melk');
});

test('addItem negeert lege invoer', () => {
  assert.deepEqual(addItem([], '   '), []);
});

test('removeItem verwijdert op id', () => {
  const items = [{ id: 'a', text: 'x' }, { id: 'b', text: 'y' }];
  assert.deepEqual(removeItem(items, 'a'), [{ id: 'b', text: 'y' }]);
});
