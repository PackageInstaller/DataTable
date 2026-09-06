local StaticUITableFrame = class("StaticUITableFrame")

function StaticUITableFrame:Ctor()
  self._logicCellList = {}
end

function StaticUITableFrame:Init(window, delegate)
  if not window then
    Log.error("simple uitablehelper must init with window")
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

function StaticUITableFrame:Destroy()
  for cellIndex, logicCell in pairs(self._logicCellList) do
    if logicCell and logicCell.instance then
      logicCell.instance:Destroy()
      logicCell.instance = nil
    end
  end
  self._logicCellList = {}
end

function StaticUITableFrame:ReloadAllCell()
  for cellIndex, logicCell in pairs(self._logicCellList) do
    if logicCell and logicCell.instance then
      logicCell.instance:Destroy()
      logicCell.instance = nil
    end
  end
  self._logicCellList = {}
  self._totalCellCount = self._delegate:NumberOfCell(self._interface)
  if not self._totalCellCount or self._totalCellCount <= 0 then
    return
  end
  for cellIndex = 1, self._totalCellCount do
    local cellName = self._delegate:CellAtIndex(self._interface, cellIndex)
    local logicCell = {}
    logicCell.instance = self:CreateInstance(cellName)
    table.insert(self._logicCellList, cellIndex, logicCell)
    logicCell.instance:GetRoot().transform:SetParent(self._content.transform, false)
  end
  for cellIndex, logicCell in ipairs(self._logicCellList) do
    logicCell.instance._cellData = self._delegate:DataAtIndex(self._interface, cellIndex)
    if logicCell and logicCell.instance and logicCell.instance.RefreshCell then
      logicCell.instance:RefreshCell()
    end
  end
end

function StaticUITableFrame:ReloadCellAtIndex(reloadIndex)
  local reloadLogicCell = self._logicCellList[reloadIndex]
  if not reloadLogicCell then
    Log.error("can not find reload index cell")
    return
  end
  local cellName = self._delegate:CellAtIndex(self._interface, reloadIndex)
  if reloadLogicCell.cellName ~= cellName then
    if reloadLogicCell.instance then
      reloadLogicCell.instance:Destroy()
      reloadLogicCell.instance = nil
    end
    reloadLogicCell.cellName = cellName
    reloadLogicCell.instance = self:CreateInstance(cellName)
    reloadLogicCell.instance:GetRoot().transform:SetParent(self._content.transform, false)
    local sort
    for cellIndex, logicCell in ipairs(self._logicCellList) do
      sort = cellIndex - 1
      logicCell.instance:GetRoot().transform:SetSiblingIndex(sort)
    end
  end
  reloadLogicCell.cellData = self._delegate:DataAtIndex(self._interface, reloadIndex)
  if reloadLogicCell.instance then
    reloadLogicCell.instance._cellData = reloadLogicCell.cellData
    reloadLogicCell.instance:RefreshCell()
  end
end

function StaticUITableFrame:CreateInstance(cellName)
  local uniqueWindowName, cell = tostring(math.random(os.time()))
  cell = DialogManager.CreateDialog(cellName, uniqueWindowName)
  cell._delegate = self._delegate
  return cell
end

function StaticUITableFrame:SendMessageToInstance(name, args)
  for _, logicCell in ipairs(self._logicCellList) do
    if logicCell.instance and logicCell.instance.HandleFrameMessage then
      logicCell.instance.HandleFrameMessage(logicCell.instance, name, args)
    end
  end
end

return StaticUITableFrame
