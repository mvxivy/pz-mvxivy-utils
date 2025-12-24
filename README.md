# MVXIVY Utilities

Utility library for Project Zomboid mods (Build 42) by MaxIvy.

## Description

MVXIVY Utilities provides a set of useful functions to simplify mod development for Project Zomboid. The library includes utilities for working with UI elements, time, players, and Sandbox settings.

## Installation

1. Subscribe to the mod on Steam Workshop
2. Activate the mod in the game's mod menu
3. Ensure the mod loads before other mods that use it

## Requirements

- Project Zomboid Build 42.0.0 or higher

## API Documentation

### UI Utilities

#### `MVXIVY_Utils.addComboBoxItems(comboBox, items, defaultItem)`

Adds items to a combo box.

**Parameters:**
- `comboBox` - combo box object
- `items` - table of strings with items to add
- `defaultItem` - index of the item that should be selected by default (1-based)

**Example:**
```lua
local items = {"Option 1", "Option 2", "Option 3"}
MVXIVY_Utils.addComboBoxItems(comboBox, items, 1)
```

#### `MVXIVY_Utils.useComboBoxFactory(comboBoxNamespace, localizeNamespace, UI)`

Creates a factory function for generating combo boxes with specified options.

**Parameters:**
- `comboBoxNamespace` - namespace to use for the combo box
- `localizeNamespace` - namespace to use for localization
- `UI` - UI object to which the combo box will be added

**Returns:** A function that takes an options table and returns a combo box.

**Example:**
```lua
local createComboBox = MVXIVY_Utils.useComboBoxFactory(
  "MyMod.ComboBox.",
  "UI_MyMod_",
  UI
)

local comboBox = createComboBox({
  name = "Difficulty",
  label = "DifficultyLabel",
  items = {"Easy", "Normal", "Hard"},
  defaultItem = 2,
  description = "DifficultyDescription"
})
```

### Time Utilities

#### `MVXIVY_Utils.nowSeconds()`

Gets the current time in seconds.

**Returns:** `number` - current time in seconds (uses `getTimestamp()` if available, otherwise `os.time()`)

**Example:**
```lua
local currentTime = MVXIVY_Utils.nowSeconds()
```

### Player Utilities

#### `MVXIVY_Utils.getPlayerUniqueId(player)`

Gets a unique identifier for a player.

**Parameters:**
- `player` - `IsoPlayer` object

**Returns:** `string` - unique player ID (username or online ID)

**Example:**
```lua
local playerId = MVXIVY_Utils.getPlayerUniqueId(player)
```

### Performance Utilities

#### `MVXIVY_Utils.throttledFnByTicks(fn, ticks)`

Creates a throttled version of a function that executes only every N ticks.

**Parameters:**
- `fn` - function to throttle
- `ticks` - number of ticks between executions

**Returns:** `function` - throttled function

**Example:**
```lua
local expensiveFunction = function()
  -- expensive operation
end

local throttled = MVXIVY_Utils.throttledFnByTicks(expensiveFunction, 60)
-- function will execute only once every 60 ticks
```

### Sandbox Utilities

#### `MVXIVY_Utils.sandbox.getOptionValue(path, fallback)`

Gets the value of a Sandbox option by its path.

**Parameters:**
- `path` - table representing the path to the option (e.g., `{"STNIMBLE_B42", "XPPerPulse"}`)
- `fallback` - default value if the option is not found

**Returns:** Option value or `fallback` if the option is not found

**Example:**
```lua
local xpPerPulse = MVXIVY_Utils.sandbox.getOptionValue(
  {"STNIMBLE_B42", "XPPerPulse"},
  1
)
```

## Usage in Other Mods

To use this library in your mod, simply ensure that MVXIVY Utilities loads before your mod and use the global `MVXIVY_Utils` object:

```lua
-- In your mod
if MVXIVY_Utils then
  local currentTime = MVXIVY_Utils.nowSeconds()
  -- use other functions...
end
```

## Version

- **Current version:** 1.0.0
- **Build:** 42

## Author

MaxIvy

## License

[MIT](LICENSE.md)
Feel free to use in your Project Zomboid mods.

## Support

If you have questions or issues, please create an issue in the mod repository.

