# Secure Container — Changelog

## v1.0.3

### Bug Fixes
- **Guns lose attachments / magazines when secured** — firearm state (attachments, magazine contents, chamber, casing, fire mode, state) is now preserved through the pouch. Previously the session save only persisted `amount` and `condition`, and since the panel reloads from session on every open, attachments were silently stripped.
- **Item duplication when inventory is full** — clicking a pouch item with a full inventory no longer drops a second copy to the ground. The item now stays in the pouch (matching the existing "Inventory full — can't return" behaviour) instead of `AutoPlace` dropping it while the pouch also kept it.
- **Clicks passing through the pouch panel** — clicks on the pouch panel no longer also grab or equip the inventory item visually behind it. The Interface hover lookup is blocked while the cursor is inside the panel rect.

### Features
- **Movable pouch panel** — click and drag the panel's header bar to reposition it anywhere on screen. Position persists across panel open/close, scene changes, and the main menu (saved to `SecureContainer_session.json`).

---

## v1.0.2

### Bug Fixes
- **Secure Case texture** — updated to darker, more tactical appearance
- **Secure Case world rotation** — corrected rotation when dropped or spawned in the world

---

## v1.0.1

### Bug Fixes
- **MCM settings not applying** — container sizes, keybind, and other MCM options now take effect correctly
- **MCM keybind type mismatch** — explicitly binding a mouse button in MCM now works; previously only the default value was recognised
- **On death, container re-equips automatically** — the pouch is restored directly into the equipment slot on respawn rather than appearing loose in the inventory; secured items remain inside
- **Dragging container out of slot with "Drop on Unequip" disabled** — items now correctly return to inventory (or drop if inventory is full) instead of staying locked in the container
- **Overflow items drop to ground** — when "Drop on Unequip" is disabled and inventory is full, any items that don't fit are dropped at the player's feet

---

## v1.0.0

### Features
- Three container tiers with unique 3D world models and textures:
  - **Field Pouch** — 2 slots, Common rarity, spawns in civilian loot
  - **Secure Pouch** — 4 slots, Rare rarity, spawns in industrial loot
  - **Secure Case** — 6 slots, Legendary rarity, spawns in military loot
- Dedicated **Pouch** equipment slot injected into the equipment panel
- **Middle-click** the equipped pouch to open or close the secure panel
- **Shift+click** any inventory item to move it into the container
- **Drag and drop** items onto the panel to secure them
- **Click an occupied slot** to return the item to inventory
- Items **drop on the ground** when the pouch is moved out of the equipment slot
- All three tiers spawn naturally in world loot by rarity tier
- Custom inventory icons per tier

### Persistence
- Container contents **survive death** — items are restored to inventory on respawn
- Contents persist across **scene changes** (cabin ↔ exterior) without loss
- Contents persist across **main menu** and full game restarts via session save file

### MCM Integration (optional — requires Mod Configuration Menu)
- **Open Button** — rebind the panel toggle to any mouse button or key
- **Drop Items on Unequip** — toggle between dropping to world or returning to inventory
- **Container Sizes** — configure slot count per tier (1–9 slots each)
- **Spawn in Loot** — enable or disable loot pool injection per playthrough

### Developer API
- Autoload accessible via `Engine.get_meta("SecureContainer")`
- Signals: `item_secured`, `item_removed`, `container_restored`, `pouch_equipped`, `pouch_unequipped`
