// UI: koppelt de logica aan de pagina.
import { addItem, removeItem } from './logic.js';

const KEY = 'app-data';
let items = [];
try { items = JSON.parse(localStorage.getItem(KEY)) || []; } catch { items = []; }

const form = document.getElementById('form');
const input = document.getElementById('invoer');
const list = document.getElementById('lijst');

function render() {
  list.replaceChildren(...items.map((item) => {
    const li = document.createElement('li');
    li.textContent = item.text;
    const del = document.createElement('button');
    del.textContent = '✕';
    del.ariaLabel = 'Verwijderen';
    del.onclick = () => update(removeItem(items, item.id));
    li.append(del);
    return li;
  }));
}

function update(next) {
  items = next;
  try { localStorage.setItem(KEY, JSON.stringify(items)); } catch { /* negeren */ }
  render();
}

form.addEventListener('submit', (e) => {
  e.preventDefault();
  update(addItem(items, input.value));
  input.value = '';
});

render();
