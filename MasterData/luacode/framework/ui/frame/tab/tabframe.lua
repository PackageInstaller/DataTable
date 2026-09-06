local TabFrame = class("TabFrame")
local LogicCell = require("framework.ui.frame.tab.logiccell")

function TabFrame:Ctor(window, delegate)
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

function TabFrame:Destroy()
  for _, cell in pairs(self._cellList) do
    cell:Destroy()
    cell:RootWindowDestroy()
  end
  self._cellList = {}
end

function TabFrame:ToPage(orderIndex)
  if not self._delegate.CellAtIndex then
    LogError("TabFrame", "tab delegate need function CellAtIndex")
    return
  end
  if orderIndex == self._pageIndex then
    return self._cellList[orderIndex]
  elseif self._pageIndex then
    self._cellList[self._pageIndex]:GetRootWindow():SetActive(false)
  end
  if not self._cellList[orderIndex] then
    self:GetCellAtIndex(orderIndex)
  end
  self._cellList[orderIndex]:GetRootWindow():SetActive(true)
  self._pageIndex = orderIndex
  if self._delegate.DidToPage then
    self._delegate:DidToPage(self, orderIndex)
  end
  return self._cellList[orderIndex]
end

function TabFrame:GetCellAtIndex(index)
  if self._cellList[index] then
    return self._cellList[index]
  else
    if not self._delegate.CellAtIndex then
      LogError("TabFrame", "tab delegate need function CellAtIndex")
      return
    end
    local logicCell = LogicCell.Create()
    logicCell._dialogName = self._delegate:CellAtIndex(self, index)
    self:GetCellDialog(logicCell)
    logicCell._cell:GetRootWindow():SetActive(false)
    logicCell._cell._delegate = self._delegate
    self._cellList[index] = logicCell._cell
    return self._cellList[index]
  end
end

function TabFrame:IsCellExist(index)
  return self._cellList[index] ~= nil
end

function TabFrame:GetCellDialog(logicCell)
  if logicCell._cell then
    return
  end
  logicCell._cell = DialogManager.CreateDialog(logicCell._dialogName, self._window._uiObject)
end

function TabFrame:GetCurrentIndex()
  return self._pageIndex
end

return TabFrame
