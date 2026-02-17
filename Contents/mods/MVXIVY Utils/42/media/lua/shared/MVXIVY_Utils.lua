local MVXIVY_Utils = {}

function MVXIVY_Utils.addComboBoxItems(comboBox, items, defaultItem)
  for i, item in ipairs(items) do
    comboBox:addItem(item, i == defaultItem)
  end
end

--- Creates a factory function for generating combo boxes with specified options.
-- @param comboBoxNamespace The namespace to use for the combo box.
-- @param localizeNamespace The namespace to use for localization.
-- @param UI The UI object to which the combo box will be added.
-- @return A function that takes an options table and returns a combo box.
function MVXIVY_Utils.useComboBoxFactory(comboBoxNamespace, localizeNamespace, UI)
  --- Creates and returns a combo box UI element using the provided options table.
  -- @param options table Table with the following fields:
  --   name (string): Suffix for the combo box key (used as: comboBoxNamespace .. name).
  --   label (string): Localization key (without namespace) for the label text.
  --   items (table): Array of strings, the items to populate the combo box.
  --   defaultItem (number): The index of the item that should be selected by default (1-based).
  --   description (string, optional): Localization key (without namespace) for an additional description (if provided).
  -- @return table: The created combo box UI element.
  return function (options)
    local comboBox = UI:addComboBox(
      comboBoxNamespace .. options.name,
      getText(localizeNamespace .. options.label)
    )

    MVXIVY_Utils.addComboBoxItems(
      comboBox,
      options.items,
      options.defaultItem
    )

    if options.description then
      UI:addDescription(getText(localizeNamespace .. options.description))
    end

    return comboBox
  end
end

--- get current time in seconds
---@return number
function MVXIVY_Utils.nowSeconds()
  return getTimestamp and getTimestamp() or os.time()
end

--- get unique key for player
---@param player IsoPlayer
---@return string
function MVXIVY_Utils.getPlayerUniqueId(player)
  if player.getUsername then
    return player:getUsername()
  end
  return tostring(player:getOnlineID())
end

--- throttle a function by ticks
---@param fn function
---@param ticks number
---@return function
function MVXIVY_Utils.throttledFnByTicks(fn, ticks)
  local lastRun = 0
  return function() 
    lastRun = lastRun + 1
    if lastRun % ticks ~= 0 then return end
    fn()
  end
end

MVXIVY_Utils.sandbox = {}

--- Get the value of a Sandbox option by its path.
-- @param path table A table representing the path to the option (e.g., {"STNIMBLE_B42","XPPerPulse"}).
-- @param fallback any A fallback value to return if the option is not found.
function MVXIVY_Utils.sandbox.getOptionValue(path, fallback)
  local t = SandboxVars
  for i = 1, #path do
    if type(t) ~= "table" then
      return fallback
    end
    t = t[path[i]]
  end
  if t == nil then
    return fallback
  end
  return t
end

local function gameVersionIsAtLeast4213()
	local gameVersion = tostring(getCore():getGameVersion())
  local major, minor = gameVersion:match("^(%d+)%.(%d+)")
  major = tonumber(major)
  minor = tonumber(minor)
  if not major or not minor then return false end
  if major == 42 and minor >= 13 then
    return true
  else
    return false
  end
end

MVXIVY_Utils.gameVersionIsAtLeast4213 = gameVersionIsAtLeast4213

return MVXIVY_Utils