-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/staticuitableframe.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local StaticUITableFrame = class("StaticUITableFrame")
StaticUITableFrame.Ctor = function(self)
  -- function num : 0_0
  self._logicCellList = {}
end

StaticUITableFrame.Init = function(self, window, delegate)
  -- function num : 0_1 , upvalues : _ENV
  if not window then
    (Log.error)("simple uitablehelper must init with window")
    return 
  end
  self._interface = self
  self._delegate = delegate
  if type(window) == "userdata" then
    self._content = window
  else
    self._content = window._uiObject
  end
  self._init = true
  return self
end

StaticUITableFrame.Destroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  for cellIndex,logicCell in pairs(self._logicCellList) do
    if logicCell and logicCell.instance then
      (logicCell.instance):Destroy()
      logicCell.instance = nil
    end
  end
  self._logicCellList = {}
end

StaticUITableFrame.ReloadAllCell = function(self)
  -- function num : 0_3 , upvalues : _ENV
  for cellIndex,logicCell in pairs(self._logicCellList) do
    if logicCell and logicCell.instance then
      (logicCell.instance):Destroy()
      logicCell.instance = nil
    end
  end
  self._logicCellList = {}
  self._totalCellCount = (self._delegate):NumberOfCell(self._interface)
  if not self._totalCellCount or self._totalCellCount <= 0 then
    return 
  end
  for cellIndex = 1, self._totalCellCount do
    local cellName = (self._delegate):CellAtIndex(self._interface, cellIndex)
    local logicCell = {}
    logicCell.instance = self:CreateInstance(cellName)
    ;
    (table.insert)(self._logicCellList, cellIndex, logicCell)
    ;
    (((logicCell.instance):GetRoot()).transform):SetParent((self._content).transform, false)
  end
  for cellIndex,logicCell in ipairs(self._logicCellList) do
    -- DECOMPILER ERROR at PC69: Confused about usage of register: R6 in 'UnsetPending'

    (logicCell.instance)._cellData = (self._delegate):DataAtIndex(self._interface, cellIndex)
    if logicCell and logicCell.instance and (logicCell.instance).RefreshCell then
      (logicCell.instance):RefreshCell()
    end
  end
end

StaticUITableFrame.ReloadCellAtIndex = function(self, reloadIndex)
  -- function num : 0_4 , upvalues : _ENV
  local reloadLogicCell = (self._logicCellList)[reloadIndex]
  if not reloadLogicCell then
    (Log.error)("can not find reload index cell")
    return 
  end
  local cellName = (self._delegate):CellAtIndex(self._interface, reloadIndex)
  if reloadLogicCell.cellName ~= cellName then
    if reloadLogicCell.instance then
      (reloadLogicCell.instance):Destroy()
      reloadLogicCell.instance = nil
    end
    reloadLogicCell.cellName = cellName
    reloadLogicCell.instance = self:CreateInstance(cellName)
    ;
    (((reloadLogicCell.instance):GetRoot()).transform):SetParent((self._content).transform, false)
    local sort = nil
    for cellIndex,logicCell in ipairs(self._logicCellList) do
      sort = cellIndex - 1
      ;
      (((logicCell.instance):GetRoot()).transform):SetSiblingIndex(sort)
    end
  end
  do
    reloadLogicCell.cellData = (self._delegate):DataAtIndex(self._interface, reloadIndex)
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R4 in 'UnsetPending'

    if reloadLogicCell.instance then
      (reloadLogicCell.instance)._cellData = reloadLogicCell.cellData
      ;
      (reloadLogicCell.instance):RefreshCell()
    end
  end
end

StaticUITableFrame.CreateInstance = function(self, cellName)
  -- function num : 0_5 , upvalues : _ENV
  local uniqueWindowName, cell = tostring((math.random)((os.time)()))
  cell = (DialogManager.CreateDialog)(cellName, uniqueWindowName)
  cell._delegate = self._delegate
  return cell
end

StaticUITableFrame.SendMessageToInstance = function(self, name, args)
  -- function num : 0_6 , upvalues : _ENV
  for _,logicCell in ipairs(self._logicCellList) do
    if logicCell.instance and (logicCell.instance).HandleFrameMessage then
      ((logicCell.instance).HandleFrameMessage)(logicCell.instance, name, args)
    end
  end
end

return StaticUITableFrame

