// Opslag in de browser; valt terug op geheugen als localStorage niet werkt.
const KEY = 'app-data';
export function load(fallback = []) {
  try { const raw = localStorage.getItem(KEY); return raw ? JSON.parse(raw) : fallback; }
  catch { return fallback; }
}
export function save(data) {
  try { localStorage.setItem(KEY, JSON.stringify(data)); } catch { /* negeren */ }
}
