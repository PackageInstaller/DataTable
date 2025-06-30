-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/frame/tab/tabframe.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TabFrame = class("TabFrame")
local LogicCell = require("framework.ui.frame.tab.logiccell")
TabFrame.Ctor = function(self, window, delegate)
  -- function num : 0_0 , upvalues : _ENV
  if not window then
    LogError("TabFrame", "tab must init with window")
    return 
  end
  if not delegate then
    LogError("TabFrame", "tab must have delegate")
    return 
  end
  self._window = window
  self._delegate = delegate
  self._cellList = {}
  self._cellNumber = 0
  self._pageIndex = nil
end

TabFrame.Destroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  for _,cell in pairs(self._cellList) do
    cell:Destroy()
    cell:RootWindowDestroy()
  end
  self._cellList = {}
end

TabFrame.ToPage = function(self, orderIndex)
  -- function num : 0_2 , upvalues : _ENV
  if not (self._delegate).CellAtIndex then
    LogError("TabFrame", "tab delegate need function CellAtIndex")
    return 
  end
  if orderIndex == self._pageIndex then
    return (self._cellList)[orderIndex]
  else
    if self._pageIndex then
      (((self._cellList)[self._pageIndex]):GetRootWindow()):SetActive(false)
    end
  end
  if not (self._cellList)[orderIndex] then
    self:GetCellAtIndex(orderIndex)
  end
  ;
  (((self._cellList)[orderIndex]):GetRootWindow()):SetActive(true)
  self._pageIndex = orderIndex
  if (self._delegate).DidToPage then
    (self._delegate):DidToPage(self, orderIndex)
  end
  return (self._cellList)[orderIndex]
end

TabFrame.GetCellAtIndex = function(self, index)
  -- function num : 0_3 , upvalues : _ENV, LogicCell
  if (self._cellList)[index] then
    return (self._cellList)[index]
  else
    if not (self._delegate).CellAtIndex then
      LogError("TabFrame", "tab delegate need function CellAtIndex")
      return 
    end
    local logicCell = (LogicCell.Create)()
    logicCell._dialogName = (self._delegate):CellAtIndex(self, index)
    self:GetCellDialog(logicCell)
    ;
    ((logicCell._cell):GetRootWindow()):SetActive(false)
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (logicCell._cell)._delegate = self._delegate
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._cellList)[index] = logicCell._cell
    return (self._cellList)[index]
  end
end

TabFrame.IsCellExist = function(self, index)
  -- function num : 0_4
  do return (self._cellList)[index] ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

TabFrame.GetCellDialog = function(self, logicCell)
  -- function num : 0_5 , upvalues : _ENV
  if logicCell._cell then
    return 
  end
  logicCell._cell = (DialogManager.CreateDialog)(logicCell._dialogName, (self._window)._uiObject)
end

TabFrame.GetCurrentIndex = function(self)
  -- function num : 0_6
  return self._pageIndex
end

return TabFrame

