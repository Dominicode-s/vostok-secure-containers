# Secure Container — Changelog

## v1.0.6

### Changes

- **Pouch textures shrunk by ~1.6 MB** (VMZ payload), no visual change. `field_pouch_tex.png` and `secure_pouch_tex.png` downscaled from 1024×1024 → 512×512 and recompressed. Both textures wrap small in-hand 3D pouch models that never sample at 1:1 during gameplay, so the visual result is indistinguishable.

## v1.0.5

### Bug Fixes
- **Items lost on level transition** — secured items (notably cash from Cash System) could vanish when loading into a new scene. During a level transition the pouch item briefly unloads from its equipment slot while the new scene's inventory rebuilds, and `_poll_equipped_state` treated that transient gap as an unequip and ran the drop/return-and-delete-session path. A 45-frame grace period is now required before an empty slot is treated as a genuine unequip, and `_load_session` is called eagerly when a tier is re-detected with empty in-memory contents so session-persisted items are recovered even when the panel is never opened after the transition.
- **Stackable amounts showed `.0` suffix** — ammo and cash displayed as `30.0` / `752.0` after a session reload because `JSON.parse_string` returns every number as a float and the amount label stringified the float directly. `_deserialize_slot_data` now coerces `amount`, `condition`, `position`, `mode`, and `zoom` back to `int`.

### Features
- **Cash System bridge** — while trading, cash stored in the pouch is mirrored into the inventory so Cash System's `CountCash` / `RemoveCash` pick it up for purchases, and proceeds reclaim to the pouch slots at trade close (leftover stays in inventory as change). Toggleable from MCM (`Integrations` → `Cash System Bridge`, default on). Death mid-trade is handled by restoring the original cash slots before the death save, so respawn recovers the pouch cash.
- **Weapon restrictions (MCM)** — new `Restrictions` category with `Allow Weapons` (default on) and `Pistols Only` (default off). Firearms that fail the filter are rejected from both shift+click and drag-drop into any tier's pouch.

## v1.0.4

### Bug Fixes
- **Items from other mods (e.g. Cash System) disappeared after shift-clicking them into a pouch** — `_resolve_item_data` only checked our own internal dict and a `gameData.items` field that doesn't exist on `GameData`, so any item whose in-memory `ItemData` instance carried no `resource_path` (common when a mod creates an `ItemData` via `ResourceSaver.save` without a subsequent reload) couldn't be re-resolved on panel reopen and the session-loaded slot became null. The lookup now also searches `Database.master.items`, `res://Loot/LT_Master.tres`, and — as a last resort — any live `Item`-group node in the scene tree, so cash and any similarly-registered mod item survive a panel close/reopen.

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
