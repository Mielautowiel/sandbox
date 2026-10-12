// Pure logica zonder DOM: dit is wat je test.
export function addItem(items, text) {
  const clean = String(text ?? '').trim();
  if (!clean) return items;
  return [...items, { id: crypto.randomUUID(), text: clean }];
}

export function removeItem(items, id) {
  return items.filter((item) => item.id !== id);
}
