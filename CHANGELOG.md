# Secure Container — Changelog

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
