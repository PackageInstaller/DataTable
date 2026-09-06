local UIManager = CS.PixelNeko.UI.UIManager
local LogicCell = require("framework.ui.frame.looptable.looplogiccell")
local LoopHorizontalTableFrameImpl = class("LoopHorizontalTableFrameImpl")

function LoopHorizontalTableFrameImpl:Ctor(interface, container, delegate, canSlide, autoAlign, loop, viewportName)
  self._interface = interface
  self._container = container
  self._delegate = delegate
  self._canSlide = canSlide
  self._autoAlign = autoAlign
  self._canLoop = loop
  self._recycleCells = {}
  self._logicCells = {}
  self._baseCells = {}
  if CS.PixelNeko.Lua.UI.FrameStaticFunctions.GetFrameChildCount(container._uiObject) > 0 then
    LogErrorFormat("LoopHorizontalTableFrameImpl", "非法操作: container [%s] 已经创建过frame Viewport", container._uiObject)
  end
  self._viewport = UIManager.CreateLuaWindow("ui/widgets.assetbundle", viewportName, container._uiObject)
  CS.PixelNeko.Lua.UI.FrameStaticFunctions.AddFrameChild(container._uiObject, self._viewport._uiObject)
  if self._canSlide then
    self._beginDragHandler = self._viewport:Subscribe_BeginDragEvent(self.OnBeginDrag, self)
    self._dragHandler = self._viewport:Subscribe_DragEvent(self.OnDrag, self)
    self._endDragHandler = self._viewport:Subscribe_EndDragEvent(self.OnEndDrag, self)
    self._cancelDragHandler = self._viewport:Subscribe_CancelDragEvent(self.OnEndDrag, self)
  end
  self._viewport:Subscribe_PointerDownEvent(self.OnPointerDown, self)
  self._viewport:Subscribe_PointerUpEvent(self.OnPointerUp, self)
  self._viewport:Subscribe_PointerCancelEvent(self.OnPointerUp, self)
  LuaNotificationCenter.AddObserver(self, self.OnLateUpdate, Common.n_LateUpdate, nil)
  self._upMargin, self._downMargin, self._leftMargin, self._rightMargin = CS.PixelNeko.Lua.UI.FrameStaticFunctions.GetMargin(container._uiObject)
  self._currentDrag = 0
  self._totalLength = 0
  self._needUpdate = false
  self._slideInertiaTask = nil
  self._sprintTask = nil
  self._sprintTime = nil
  self._insertTask = {}
  self._insertDes = {}
  self._removeTask = {}
  self._removeDes = {}
  self._moveLeftTask = nil
  self._moveLeftDes = nil
  self._moveRightTask = nil
  self._moveRightDes = nil
  self._moveLeftIndexTask = nil
  self._moveRightIndexTask = nil
  self._moveLeftIndexDes = nil
  self._moveRightIndexDes = nil
  self._leftIndex = nil
  self._rightIndex = nil
  self._alignTask = nil
  self._alignDes = nil
  self._dragPercent = 1
  self._logicCellUpIndex = 0
  self._logicCellDownIndex = -1
end

function LoopHorizontalTableFrameImpl:Destroy()
  if self._baseCells then
    for i, cell in pairs(self._baseCells) do
      UIManager.Destroy(cell._uiObject)
    end
  end
  for i, logicCell in ipairs(self._logicCells) do
    if logicCell._cell then
      self:RecycleCell(logicCell)
    end
  end
  self._logicCells = {}
  self._currentDrag = 0
  self._totalLength = 0
  for k, cells in pairs(self._recycleCells) do
    for i, cell in ipairs(cells) do
      cell:Destroy()
      cell:RootWindowDestroy()
    end
  end
  self._recycleCells = {}
  CS.PixelNeko.Lua.UI.FrameStaticFunctions.RemoveFrameChild(self._container._uiObject, self._viewport._uiObject)
  CS.PixelNeko.UI.UIManager.Destroy(self._viewport._uiObject)
  LuaNotificationCenter.RemoveObserver(self)
end

function LoopHorizontalTableFrameImpl:ReloadAllCell()
  for i, logicCell in ipairs(self._logicCells) do
    if logicCell._cell then
      self:RecycleCell(logicCell)
    end
  end
  self._logicCells = {}
  self._currentDrag = -self._leftMargin
  self._totalLength = 0
  self._needUpdate = true
  self._taskBeginLogicPos = {}
  local cellNums = self._delegate:NumberOfCell(self._interface)
  for i = 1, cellNums do
    local logicCell = LogicCell.Create()
    logicCell._dialogName = self._delegate:CellAtIndex(self._interface, i)
    if not self._baseCells[logicCell._dialogName] then
      local dialogDefine = require("logic.dialog." .. logicCell._dialogName)
      self._baseCells[logicCell._dialogName] = UIManager.CreateLuaWindow(dialogDefine.AssetBundleName .. ".assetbundle", dialogDefine.AssetName, self._viewport._uiObject)
      self._baseCells[logicCell._dialogName]:SetPosition(0, -10000, 0, 0)
    end
    logicCell._data = self._delegate:DataAtIndex(self._interface, i)
    self._logicCells[i] = logicCell
  end
  local tempSize = {}
  for i, logicCell in ipairs(self._logicCells) do
    if not self._delegate.ShouldLengthChange or not self._delegate:ShouldLengthChange(self._interface, i) then
      if not tempSize[logicCell._dialogName] then
        self:GetCellDialog(logicCell)
        logicCell._cell._delegate = self._delegate
        logicCell._cell._cellData = logicCell._data
        logicCell._cell:RefreshCell(logicCell._data)
        local _ = 0
        tempSize[logicCell._dialogName], _ = logicCell._cell:GetRootWindow():GetRectSize()
        self:RecycleCell(logicCell)
      end
      logicCell._size = tempSize[logicCell._dialogName]
      logicCell._pos = self._totalLength
      self._totalLength = self._totalLength + logicCell._size
      logicCell._index = i
    else
      self:GetCellDialog(logicCell)
      logicCell._cell._delegate = self._delegate
      logicCell._cell._cellData = logicCell._data
      logicCell._cell:RefreshCell(logicCell._data)
      local w, h = logicCell._cell:GetRootWindow():GetRectSize()
      self:RecycleCell(logicCell)
      logicCell._size = w
      logicCell._pos = self._totalLength
      self._totalLength = self._totalLength + logicCell._size
      logicCell._index = i
    end
  end
  if self._canLoop and 0 < cellNums then
    self._logicCells[0] = LogicCell.Create()
    self._logicCells[0]._dialogName = self._logicCells[cellNums]._dialogName
    self._logicCells[0]._data = self._logicCells[cellNums]._data
    self:GetCellDialog(self._logicCells[0])
    self._logicCells[0]._cell._delegate = self._delegate
    self._logicCells[0]._cell._cellData = self._logicCells[0]._data
    self._logicCells[0]._cell:RefreshCell(self._logicCells[0]._data)
    self:RecycleCell(self._logicCells[0])
    self._logicCells[0]._index = self._logicCells[cellNums]._index
    self._logicCells[0]._isLogicCell = false
    self._logicCells[0]._size = self._logicCells[cellNums]._size
    self._logicCells[0]._pos = -self._logicCells[0]._size
    self._logicCells[cellNums + 1] = LogicCell.Create()
    self._logicCells[cellNums + 1]._dialogName = self._logicCells[1]._dialogName
    self._logicCells[cellNums + 1]._data = self._logicCells[1]._data
    self:GetCellDialog(self._logicCells[cellNums + 1])
    self._logicCells[cellNums + 1]._cell._delegate = self._delegate
    self._logicCells[cellNums + 1]._cell._cellData = self._logicCells[cellNums + 1]._data
    self._logicCells[cellNums + 1]._cell:RefreshCell(self._logicCells[cellNums + 1]._data)
    self:RecycleCell(self._logicCells[cellNums + 1])
    self._logicCells[cellNums + 1]._index = self._logicCells[1]._index
    self._logicCells[cellNums + 1]._isLogicCell = false
    self._logicCells[cellNums + 1]._size = self._logicCells[1]._size
    self._logicCells[cellNums + 1]._pos = self._logicCells[cellNums]._pos + self._logicCells[cellNums + 1]._size
  end
  if self._canLoop then
    self._logicCellUpIndex = 0
    self._logicCellDownIndex = cellNums + 1
  else
    self._logicCellUpIndex = 1
    self._logicCellDownIndex = cellNums
  end
  self:UpdateView(0)
end

function LoopHorizontalTableFrameImpl:MoveToLeft(isAnimate)
  if self._logicCells and #self._logicCells ~= 0 then
    self._needUpdate = true
    local delta = 0 - self._leftMargin
    for i = self._logicCellUpIndex, self._logicCellDownIndex do
      local logicCell = self._logicCells[i]
      if logicCell._isLogicCell and logicCell._index == 1 then
        delta = logicCell._pos
        break
      end
    end
    self._moveLeftDes = -delta
    self._taskBeginLogicPos = {}
    for i = self._logicCellUpIndex, self._logicCellDownIndex do
      self._taskBeginLogicPos[i] = self._logicCells[i]._pos
    end
    if isAnimate then
      local first = {pos = 0}
      local last = {
        pos = self._moveLeftDes
      }
      self._moveLeftTask = Tween.new(0.5, first, last, "linear")
    else
      self._currentDrag = 0
      for i = self._logicCellUpIndex, self._logicCellDownIndex do
        self._logicCells[i]._pos = self._taskBeginLogicPos[i] + self._moveLeftDes
      end
      self._taskBeginLogicPos = {}
    end
  end
end

function LoopHorizontalTableFrameImpl:MoveToRight(isAnimate)
  if self._logicCells and #self._logicCells ~= 0 then
    self._needUpdate = true
    local width, height = self._viewport:GetRectSize()
    local delta = self._totalLength - width + self._rightMargin
    for i = self._logicCellUpIndex, self._logicCellDownIndex do
      local logicCell = self._logicCells[i]
      if logicCell._isLogicCell and logicCell._index == self._delegate:NumberOfCell(self._interface) then
        delta = logicCell._pos
        break
      end
    end
    self._moveRightDes = -delta
    self._taskBeginLogicPos = {}
    for i = self._logicCellUpIndex, self._logicCellDownIndex do
      self._taskBeginLogicPos[i] = self._logicCells[i]._pos
    end
    if width <= self._totalLength then
      if isAnimate then
        local first = {pos = 0}
        local last = {
          pos = self._moveRightDes
        }
        self._moveRightTask = Tween.new(0.5, first, last, "linear")
      else
        self._currentDrag = 0
        for i = self._logicCellUpIndex, self._logicCellDownIndex do
          self._logicCells[i]._pos = self._taskBeginLogicPos[i] + self._moveRightDes
        end
        self._taskBeginLogicPos = {}
      end
    end
  end
end

function LoopHorizontalTableFrameImpl:MoveLeftToIndex(desIndex, isAnimate)
  self._needUpdate = true
  self._moveRightIndexTask = nil
  self._slideInertiaTask = nil
  self._sprintTask = nil
  if self._moveLeftIndexTask then
    self._currentDrag = 0
    if #self._taskBeginLogicPos == 0 then
      for i = self._logicCellUpIndex, self._logicCellDownIndex do
        self._taskBeginLogicPos[i] = self._logicCells[i]._pos
      end
    end
    for i = self._logicCellUpIndex, self._logicCellDownIndex do
      self._logicCells[i]._pos = self._taskBeginLogicPos[i] + self._moveLeftIndexDes
    end
  end
  local width, height = self._viewport:GetRectSize()
  local temp = self._logicCells[desIndex]
  local delta = temp._pos
  self._taskBeginLogicPos = {}
  for i = self._logicCellUpIndex, self._logicCellDownIndex do
    self._taskBeginLogicPos[i] = self._logicCells[i]._pos
  end
  self._moveLeftIndexDes = -delta
  if isAnimate then
    local first = {pos = 0}
    local last = {
      pos = self._moveLeftIndexDes
    }
    self._moveLeftIndexTask = Tween.new(0.2, first, last, "linear")
  else
    self._currentDrag = 0
    for i = self._logicCellUpIndex, self._logicCellDownIndex do
      self._logicCells[i]._pos = self._taskBeginLogicPos[i] + self._moveLeftIndexDes
    end
    self._taskBeginLogicPos = {}
  end
end

function LoopHorizontalTableFrameImpl:MoveRightToIndex(desIndex, isAnimate)
  self._needUpdate = true
  self._moveLeftIndexTask = nil
  self._slideInertiaTask = nil
  self._sprintTask = nil
  if self._moveRightIndexTask then
    self._currentDrag = 0
    if #self._taskBeginLogicPos == 0 then
      for i = self._logicCellUpIndex, self._logicCellDownIndex do
        self._taskBeginLogicPos[i] = self._logicCells[i]._pos
      end
    end
    for i = self._logicCellUpIndex, self._logicCellDownIndex do
      self._logicCells[i]._pos = self._taskBeginLogicPos[i] + self._moveRightIndexDes
    end
  end
  local width, height = self._viewport:GetRectSize()
  local temp = self._logicCells[desIndex]
  local delta = temp._pos + temp._size - width
  self._taskBeginLogicPos = {}
  for i = self._logicCellUpIndex, self._logicCellDownIndex do
    self._taskBeginLogicPos[i] = self._logicCells[i]._pos
  end
  self._moveRightIndexDes = -delta
  if isAnimate then
    local first = {pos = 0}
    local last = {
      pos = self._moveRightIndexDes
    }
    self._moveRightIndexTask = Tween.new(0.2, first, last, "linear")
  else
    self._currentDrag = 0
    for i = self._logicCellUpIndex, self._logicCellDownIndex do
      self._logicCells[i]._pos = self._taskBeginLogicPos[i] + self._moveRightIndexDes
    end
    self._taskBeginLogicPos = {}
  end
end

function LoopHorizontalTableFrameImpl:GetTotalLength()
  return self._totalLength
end

function LoopHorizontalTableFrameImpl:ReloadCellsAtIndex(indexList, isAnimate)
  if type(indexList) ~= "table" then
    LogError("LoopHorizontalTableFrameImpl", "please input a table value")
    return
  end
  self._needUpdate = true
  local cellNums = self._delegate:NumberOfCell(self._interface)
  for _, index in ipairs(indexList) do
    if not index or index > cellNums then
      LogErrorFormat("LoopHorizontalTableFrameImpl", "the index %d is out of range", index)
      return
    end
    local logicCell = self._logicCells[index]
    logicCell._dialogName = self._delegate:CellAtIndex(self._interface, index)
    if not self._baseCells[logicCell._dialogName] then
      local dialogDefine = require("logic.dialog." .. logicCell._dialogName)
      self._baseCells[logicCell._dialogName] = UIManager.CreateLuaWindow(dialogDefine.AssetBundleName .. ".assetbundle", dialogDefine.AssetName, self._viewport._uiObject)
      self._baseCells[logicCell._dialogName]:SetPosition(0, -10000, 0, 0)
    end
    logicCell._data = self._delegate:DataAtIndex(self._interface, index)
    self:GetCellDialog(logicCell)
    logicCell._cell._delegate = self._delegate
    logicCell._cell._cellData = logicCell._data
    logicCell._cell:RefreshCell(logicCell._data)
    local w = logicCell._cell:GetRootWindow():GetRectSize()
    local delta = w - logicCell._size
    logicCell._size = w
    self._logicCells[index] = logicCell
    if self._canLoop then
      if index == 1 then
        local temp = self._logicCells[self._logicCellDownIndex]
        temp._dialogName = logicCell._dialogName
        temp._data = logicCell._data
        self:GetCellDialog(temp)
        temp._cell._delegate = logicCell._cell._delegate
        temp._cell._cellData = logicCell._cell._cellData
        temp._cell:RefreshCell(temp._data)
        self:RecycleCell(temp)
        temp._size = logicCell._size
        self._logicCells[self._logicCellDownIndex] = temp
      elseif index == cellNums then
        local temp = self._logicCells[self._logicCellUpIndex]
        temp._dialogName = logicCell._dialogName
        temp._data = logicCell._data
        self:GetCellDialog(temp)
        temp._cell._delegate = logicCell._cell._delegate
        temp._cell._cellData = logicCell._cell._cellData
        temp._cell:RefreshCell(temp._data)
        self:RecycleCell(temp)
        temp._size = logicCell._size
        self._logicCells[self._logicCellUpIndex] = temp
      end
    end
    for i = index + 1, self._logicCellDownIndex do
      self._logicCells[i]._pos = self._logicCells[i]._pos + delta
    end
    self:RecycleCell(logicCell)
    self._totalLength = self._totalLength + delta
  end
  self:UpdateView(0)
end

function LoopHorizontalTableFrameImpl:RemoveCellsAtIndex(indexList, isAnimate)
  if type(indexList) ~= "table" then
    LogError("LoopHorizontalTableFrameImpl", "please input a table value")
    return
  end
  self._needUpdate = true
  local cellNums = #self._logicCells
  local width, height = self._viewport:GetRectSize()
  local currentDrag = self._currentDrag
  for _, index in ipairs(indexList) do
    cellNums = #self._logicCells
    if index > cellNums then
      LogErrorFormat("LoopHorizontalTableFrameImpl", "Wrong index %d", index)
      return
    end
    local gap = self._logicCells[index]._size
    local pos = self._logicCells[index]._pos
    self:RecycleCell(self._logicCells[index])
    if #self._insertTask ~= 0 then
      for i, task in pairs(self._insertTask) do
        local logicCell = self._logicCells[i + self._insertIndex - 1]
        logicCell._pos = self._insertDes[i]
        self._insertDes[i] = nil
        self._insertTask[i] = nil
      end
    end
    if #self._removeTask ~= 0 then
      for i, task in pairs(self._removeTask) do
        self._logicCells[i + self._removeIndex - 1]._pos = self._removeDes[i]
        self._removeDes[i] = nil
        self._removeTask[i] = nil
      end
    end
    if isAnimate and currentDrag < pos + gap and pos < currentDrag + width then
      self._removeTask = {}
      self._removeIndex = index
      for i = index + 1, cellNums do
        self._removeDes[i - index] = self._logicCells[i]._pos - gap
        local first = {
          pos = self._logicCells[i]._pos
        }
        local last = {
          pos = self._removeDes[i - index]
        }
        self._removeTask[i - index] = Tween.new(0.1, first, last, "linear")
      end
    else
      for i = index + 1, cellNums do
        self._logicCells[i]._pos = self._logicCells[i]._pos - gap
      end
    end
    table.remove(self._logicCells, index)
    self._totalLength = self._totalLength - gap
  end
end

function LoopHorizontalTableFrameImpl:InsertCellsAtIndex(indexList, isAnimate)
  if indexList and type(indexList) ~= "table" then
    LogError("LoopHorizontalTableFrameImpl", "please input a table value")
    return
  end
  local cellNums = #self._logicCells
  self._needUpdate = true
  local lastinsert = false
  if not indexList or #indexList == 0 then
    indexList = {}
    if self._delegate:NumberOfCell(self._interface) >= cellNums + 1 then
      for i = cellNums + 1, self._delegate:NumberOfCell(self._interface) do
        table.insert(indexList, i)
      end
      lastinsert = true
    else
      LogError("LoopHorizontalTableFrameImpl", "no additional data")
      return
    end
  end
  for _, index in ipairs(indexList) do
    cellNums = #self._logicCells
    if not index or index > cellNums + 1 and not lastinsert then
      LogErrorFormat("LoopHorizontalTableFrameImpl", "Wrong index %d", index)
      return
    end
    local logicCell = LogicCell.Create()
    logicCell._dialogName = self._delegate:CellAtIndex(self._interface, index)
    if not self._baseCells[logicCell._dialogName] then
      local dialogDefine = require("logic.dialog." .. logicCell._dialogName)
      self._baseCells[logicCell._dialogName] = UIManager.CreateLuaWindow(dialogDefine.AssetBundleName .. ".assetbundle", dialogDefine.AssetName, self._viewport._uiObject)
      self._baseCells[logicCell._dialogName]:SetPosition(0, -10000, 0, 0)
    end
    logicCell._data = self._delegate:DataAtIndex(self._interface, index)
    local tempSize = {}
    local width, height = self._viewport:GetRectSize()
    if not self._delegate.ShouldLengthChange or not self._delegate:ShouldLengthChange(self._interface, i) then
      if not tempSize[logicCell._dialogName] then
        self:GetCellDialog(logicCell)
        logicCell._cell._delegate = self._delegate
        logicCell._cell._cellData = logicCell._data
        logicCell._cell:RefreshCell(logicCell._data)
        tempSize[logicCell._dialogName] = logicCell._cell:GetRootWindow():GetRectSize()
        self:RecycleCell(logicCell)
      end
      logicCell._size = tempSize[logicCell._dialogName]
    else
      self:GetCellDialog(logicCell)
      logicCell._cell._delegate = self._delegate
      logicCell._cell._cellData = logicCell._data
      logicCell._cell:RefreshCell(logicCell._data)
      local w, h = logicCell._cell:GetRootWindow():GetRectSize()
      self:RecycleCell(logicCell)
      logicCell._size = w
    end
    if #self._removeTask ~= 0 then
      for i, task in pairs(self._removeTask) do
        self._logicCells[i + self._removeIndex - 1]._pos = self._removeDes[i]
        self._removeDes[i] = nil
        self._removeTask[i] = nil
      end
    end
    if #self._insertTask ~= 0 then
      for i, task in pairs(self._insertTask) do
        local logicCell = self._logicCells[i + self._insertIndex - 1]
        logicCell._pos = self._insertDes[i]
        self._insertDes[i] = nil
        self._insertTask[i] = nil
      end
    end
    table.insert(self._logicCells, index, logicCell)
    cellNums = #self._logicCells
    if isAnimate then
      self._insertTask = {}
      self._insertIndex = index
      for i = index + 1, cellNums do
        self._insertDes[i - index + 1] = self._logicCells[i]._pos + logicCell._size
        local first = {
          pos = self._logicCells[i]._pos
        }
        local last = {
          pos = self._insertDes[i - index + 1]
        }
        self._insertTask[i - index + 1] = Tween.new(0.2, first, last, "linear")
      end
      if 0 < index - 1 then
        self._insertDes[1] = self._logicCells[index - 1]._pos + self._logicCells[index - 1]._size
        local first = {
          pos = self._logicCells[index - 1]._pos
        }
        local last = {
          pos = self._insertDes[1]
        }
        self._insertTask[1] = Tween.new(0.2, first, last, "linear")
      else
        self._insertDes[1] = 0
        local first = {
          pos = -logicCell._size
        }
        local last = {
          pos = self._insertDes[1]
        }
        self._insertTask[1] = Tween.new(0.2, first, last, "linear")
      end
    else
      for i = index + 1, cellNums do
        self._logicCells[i]._pos = self._logicCells[i]._pos + logicCell._size
      end
      if 0 < index - 1 then
        self._logicCells[index]._pos = self._logicCells[index - 1]._pos + self._logicCells[index - 1]._size
      else
        self._logicCells[index]._pos = 0
      end
    end
    self._totalLength = self._totalLength + logicCell._size
  end
end

function LoopHorizontalTableFrameImpl:FireEvent(eventName, ...)
  for i, logicCell in ipairs(self._logicCells) do
    if logicCell._cell and logicCell._cell.OnEvent then
      logicCell._cell:OnEvent(eventName, ...)
    end
  end
end

function LoopHorizontalTableFrameImpl:GetLeftIndex()
  return self._leftIndex
end

function LoopHorizontalTableFrameImpl:GetRightIndex()
  return self._rightIndex
end

function LoopHorizontalTableFrameImpl:SetMargin(leftValue, rightValue)
  if self._leftMargin == 0 then
    self._leftMargin = leftValue
  end
  if self._rightMargin == 0 then
    self._rightMargin = rightValue
  end
end

function LoopHorizontalTableFrameImpl:OnBeginDrag(args)
  self._slideInertiaTime = 0.8
  self._slideInertiaTask = nil
  self._sprintTask = nil
  self._moveSpeed = {x = 0, y = 0}
  self._dragPercent = 1
  local width, height = self._viewport:GetRectSize()
  if not self._canLoop then
    local lastLogicCell = self._logicCells[self._delegate:NumberOfCell(self._interface)]
    if 0 <= self._logicCells[1]._pos or width >= lastLogicCell._pos + lastLogicCell._size then
      self._dragPercent = 3
    end
  end
  if self._delegate.OnFrameBeginDrag then
    self._delegate:OnFrameBeginDrag(self._interface)
  end
end

function LoopHorizontalTableFrameImpl:OnDrag(args)
  local pressPosition = args.pressPosition
  local position = args.position
  local localPressX, _ = UIManager.ScreenPointToLocalPointInRectangle(self._viewport._uiObject, pressPosition.x, pressPosition.y)
  local localX, _ = UIManager.ScreenPointToLocalPointInRectangle(self._viewport._uiObject, position.x, position.y)
  self._moveSpeed.x = args.xSpeed / 60
  self._moveSpeed.y = args.ySpeed / 60
  local currentDrag = self._currentDrag
  self._currentDrag = args.delta.x
  self._dragDirectionIsRight = args.delta.x > 0
  if args.delta.x == 0 then
    self._dragDirectionIsRight = 0 < localX - localPressX
  end
  if not self._canLoop then
    if 0 <= self._logicCells[1]._pos and not self._dragDirectionIsRight then
      self._dragPercent = 1
    end
    local width, height = self._viewport:GetRectSize()
    local lastLogicCell = self._logicCells[self._delegate:NumberOfCell(self._interface)]
    if width >= lastLogicCell._pos + lastLogicCell._size and self._dragDirectionIsRight then
      self._dragPercent = 1
    end
  end
  if currentDrag ~= self._currentDrag then
    self._needUpdate = true
    self:UpdateView(0)
  end
end

function LoopHorizontalTableFrameImpl:OnEndDrag(args)
  local dirIsRight = self._dragDirectionIsRight
  local original, _ = UIManager.ScreenPointToLocalPointInRectangle(self._viewport._uiObject, 0, 0)
  local speed, _ = UIManager.ScreenPointToLocalPointInRectangle(self._viewport._uiObject, self._moveSpeed.x, self._moveSpeed.y)
  speed = speed - original
  local currentDrag = self._currentDrag
  local width, height = self._viewport:GetRectSize()
  if speed == 0 then
    if self._autoAlign then
      if dirIsRight then
        self._needUpdate = true
        local lesshalf = self._logicCells[self._leftIndex]._pos < -self._logicCells[self._leftIndex]._size / 2
        if lesshalf then
          local delta = 0 - self._logicCells[self._leftIndex + 1]._pos
          local first = {pos = 0}
          self._taskBeginLogicPos = {}
          for i = self._logicCellUpIndex, self._logicCellDownIndex do
            self._taskBeginLogicPos[i] = self._logicCells[i]._pos
          end
          self._alignDes = delta
          local last = {
            pos = self._alignDes
          }
          self._alignTask = Tween.new(0.2, first, last, "inQuad")
        else
          self._needUpdate = true
          local delta = 0 - self._logicCells[self._leftIndex]._pos
          local first = {pos = 0}
          self._taskBeginLogicPos = {}
          for i = self._logicCellUpIndex, self._logicCellDownIndex do
            self._taskBeginLogicPos[i] = self._logicCells[i]._pos
          end
          self._alignDes = delta
          local last = {
            pos = self._alignDes
          }
          self._alignTask = Tween.new(0.2, first, last, "inQuad")
        end
      else
        self._needUpdate = true
        local morehalf = width >= self._logicCells[self._rightIndex]._pos + self._logicCells[self._rightIndex]._size / 2
        if morehalf then
          local delta = self._logicCells[self._rightIndex]._pos + self._logicCells[self._rightIndex]._size - width
          local first = {pos = 0}
          self._taskBeginLogicPos = {}
          for i = self._logicCellUpIndex, self._logicCellDownIndex do
            self._taskBeginLogicPos[i] = self._logicCells[i]._pos
          end
          self._alignDes = -delta
          local last = {
            pos = self._alignDes
          }
          self._alignTask = Tween.new(0.2, first, last, "inQuad")
        else
          local delta = self._logicCells[self._rightIndex - 1]._pos + self._logicCells[self._rightIndex - 1]._size - width
          local first = {pos = 0}
          self._taskBeginLogicPos = {}
          for i = self._logicCellUpIndex, self._logicCellDownIndex do
            self._taskBeginLogicPos[i] = self._logicCells[i]._pos
          end
          self._alignDes = -delta
          local last = {
            pos = self._alignDes
          }
          self._alignTask = Tween.new(0.2, first, last, "inQuad")
        end
      end
    elseif not self._canLoop then
      local cellNum = self._delegate:NumberOfCell(self._interface)
      self:EstablishSprintTask(0)
    end
  elseif self._autoAlign then
    if dirIsRight then
      self._needUpdate = true
      local delta = 0 - self._logicCells[self._leftIndex]._pos
      local first = {pos = 0}
      self._taskBeginLogicPos = {}
      for i = self._logicCellUpIndex, self._logicCellDownIndex do
        self._taskBeginLogicPos[i] = self._logicCells[i]._pos
      end
      self._alignDes = delta
      local last = {
        pos = self._alignDes
      }
      self._alignTask = Tween.new(0.2, first, last, "inQuad")
    else
      self._needUpdate = true
      local delta = self._logicCells[self._rightIndex]._pos + self._logicCells[self._rightIndex]._size - width
      local first = {pos = 0}
      self._taskBeginLogicPos = {}
      for i = self._logicCellUpIndex, self._logicCellDownIndex do
        self._taskBeginLogicPos[i] = self._logicCells[i]._pos
      end
      self._alignDes = -delta
      local last = {
        pos = self._alignDes
      }
      self._alignTask = Tween.new(0.2, first, last, "inQuad")
    end
  else
    self._needUpdate = true
    self._sprintTask = nil
    self._sprintTime = nil
    self._slideInertiaSpeed = speed * 20
    local cellNum = self._delegate:NumberOfCell(self._interface)
    self._taskBeginLogicPos = {}
    for i = self._logicCellUpIndex, self._logicCellDownIndex do
      self._taskBeginLogicPos[i] = self._logicCells[i]._pos
    end
    local first = {
      pos = self._slideInertiaSpeed
    }
    local last = {pos = 0}
    self._slideInertiaTask = Tween.new(self._slideInertiaTime, first, last, "linear")
  end
  if self._delegate.OnFrameEndDrag then
    self._delegate:OnFrameEndDrag(self._interface)
  end
end

function LoopHorizontalTableFrameImpl:OnPointerDown(deltaTime)
  if self._slideInertiaTask then
    self._slideInertiaTask = nil
  end
end

function LoopHorizontalTableFrameImpl:OnPointerUp(deltaTime)
  self:UpdateView(0)
end

function LoopHorizontalTableFrameImpl:OnLateUpdate(notification)
  local deltaTime = notification.userInfo.deltaTime
  local width, height = self._viewport:GetRectSize()
  if self._needUpdate then
    if self._slideInertiaTask then
      if self._slideInertiaTask:update(deltaTime) then
        self._currentDrag = (self._slideInertiaSpeed + 0) * self._slideInertiaTime / 2
        if #self._taskBeginLogicPos == 0 then
          for i = self._logicCellUpIndex, self._logicCellDownIndex do
            self._taskBeginLogicPos[i] = self._logicCells[i]._pos
          end
        end
        for i = self._logicCellUpIndex, self._logicCellDownIndex do
          self._logicCells[i]._pos = self._taskBeginLogicPos[i] + self._currentDrag / self._dragPercent
        end
        if not self._canLoop then
          self:EstablishSprintTask(0)
        end
        self._currentDrag = 0
        self._slideInertiaTask = nil
        self._slideInertiaPosition = nil
        self._taskBeginLogicPos = {}
      else
        self._currentDrag = (self._slideInertiaSpeed + self._slideInertiaTask.subject.pos) * self._slideInertiaTask.clock / 2
      end
      if self._slideInertiaTask then
        self._slideInertiaTask.clock = self._slideInertiaTask.clock + 2 * deltaTime
      end
    end
    if not self._slideInertiaTask and self._sprintTask and not self._sprintclickdown then
      self._taskBeginLogicPos = self._taskBeginLogicPosForSprint
      if self._sprintTask:update(deltaTime) then
        self._dragPercent = 1
        self._currentDrag = (self._sprintSpeed + 0) * self._sprintTime / 2
        if #self._taskBeginLogicPos == 0 then
          for i = self._logicCellUpIndex, self._logicCellDownIndex do
            self._taskBeginLogicPos[i] = self._logicCells[i]._pos
          end
        end
        for i = self._logicCellUpIndex, self._logicCellDownIndex do
          self._logicCells[i]._pos = self._taskBeginLogicPos[i] + self._currentDrag
        end
        self._currentDrag = 0
        self._sprintTask = nil
        self._sprintTime = nil
        self._taskBeginLogicPos = {}
      else
        self._dragPercent = 1
        self._currentDrag = (self._sprintSpeed + self._sprintTask.subject.pos) * self._sprintTask.clock / 2
      end
    end
    if self._alignTask then
      if self._alignTask:update(deltaTime) then
        self._currentDrag = 0
        if #self._taskBeginLogicPos == 0 then
          for i = self._logicCellUpIndex, self._logicCellDownIndex do
            self._taskBeginLogicPos[i] = self._logicCells[i]._pos
          end
        end
        for i = self._logicCellUpIndex, self._logicCellDownIndex do
          self._logicCells[i]._pos = self._taskBeginLogicPos[i] + self._alignDes
        end
        self._alignTask = nil
        self._taskBeginLogicPos = {}
      else
        self._currentDrag = self._alignTask.subject.pos
      end
    end
    if self._moveLeftTask then
      if self._moveLeftTask:update(deltaTime) then
        self._currentDrag = 0
        if #self._taskBeginLogicPos == 0 then
          for i = self._logicCellUpIndex, self._logicCellDownIndex do
            self._taskBeginLogicPos[i] = self._logicCells[i]._pos
          end
        end
        for i = self._logicCellUpIndex, self._logicCellDownIndex do
          self._logicCells[i]._pos = self._taskBeginLogicPos[i] + self._moveLeftDes
        end
        self._moveLeftTask = nil
        self._taskBeginLogicPos = {}
      else
        self._currentDrag = self._moveLeftTask.subject.pos
      end
    end
    if self._moveRightTask then
      if self._moveRightTask:update(deltaTime) then
        self._currentDrag = 0
        if #self._taskBeginLogicPos == 0 then
          for i = self._logicCellUpIndex, self._logicCellDownIndex do
            self._taskBeginLogicPos[i] = self._logicCells[i]._pos
          end
        end
        for i = self._logicCellUpIndex, self._logicCellDownIndex do
          self._logicCells[i]._pos = self._taskBeginLogicPos[i] + self._moveRightDes
        end
        self._moveRightTask = nil
        self._taskBeginLogicPos = {}
      else
        self._currentDrag = self._moveRightTask.subject.pos
      end
    end
    if self._moveLeftIndexTask then
      if self._moveLeftIndexTask:update(deltaTime) then
        self._currentDrag = 0
        if #self._taskBeginLogicPos == 0 then
          for i = self._logicCellUpIndex, self._logicCellDownIndex do
            self._taskBeginLogicPos[i] = self._logicCells[i]._pos
          end
        end
        for i = self._logicCellUpIndex, self._logicCellDownIndex do
          self._logicCells[i]._pos = self._taskBeginLogicPos[i] + self._moveLeftIndexDes
        end
        self._moveLeftIndexTask = nil
        self._taskBeginLogicPos = {}
      else
        self._currentDrag = self._moveLeftIndexTask.subject.pos
      end
    end
    if self._moveRightIndexTask then
      if self._moveRightIndexTask:update(deltaTime) then
        self._currentDrag = 0
        if #self._taskBeginLogicPos == 0 then
          for i = self._logicCellUpIndex, self._logicCellDownIndex do
            self._taskBeginLogicPos[i] = self._logicCells[i]._pos
          end
        end
        for i = self._logicCellUpIndex, self._logicCellDownIndex do
          self._logicCells[i]._pos = self._taskBeginLogicPos[i] + self._moveRightIndexDes
        end
        self._moveRightIndexTask = nil
        self._taskBeginLogicPos = {}
      else
        self._currentDrag = self._moveRightIndexTask.subject.pos
      end
    end
    self:UpdateView(deltaTime)
  end
  if self._logicCells and #self._logicCells ~= 0 and self._delegate.visibleChangeDo then
    self._delegate:visibleChangeDo(self._logicCells[self._leftIndex]._index)
  end
end

function LoopHorizontalTableFrameImpl:UpdateView(deltaTime)
  if self._needUpdate then
    local currentDrag = self._currentDrag / self._dragPercent
    local width, height = self._viewport:GetRectSize()
    local cellNum = self._delegate:NumberOfCell(self._interface)
    local flag = true
    if 0 < cellNum then
      for i = self._logicCellUpIndex, self._logicCellDownIndex do
        local logicCell = self._logicCells[i]
        if self._taskBeginLogicPos and #self._taskBeginLogicPos ~= 0 then
          logicCell._pos = self._taskBeginLogicPos[i] + currentDrag
        else
          logicCell._pos = logicCell._pos + currentDrag
        end
        if logicCell._pos > -logicCell._size and width > logicCell._pos then
          if flag then
            flag = false
            self._leftIndex = i
          end
          self._rightIndex = i
          if not logicCell._visible then
            self._refreshPosY = true
          end
          logicCell._visible = true
        else
          if logicCell._visible then
            self._refreshPosY = true
          end
          logicCell._visible = false
          if logicCell._cell then
            self:RecycleCell(logicCell)
          end
        end
      end
    end
    if self._canLoop then
      if self._leftIndex == 0 then
        for i = cellNum, 0, -1 do
          self._logicCells[i + 1] = self._logicCells[i]
        end
        self._logicCells[0] = LogicCell.Create()
        self._logicCells[0]._dialogName = self._logicCells[cellNum]._dialogName
        self._logicCells[0]._data = self._logicCells[cellNum]._data
        self._logicCells[0]._size = self._logicCells[cellNum]._size
        self._logicCells[0]._index = self._logicCells[cellNum]._index
        self._logicCells[0]._pos = self._logicCells[1]._pos - self._logicCells[0]._size
        if self._taskBeginLogicPos and #self._taskBeginLogicPos ~= 0 then
          for i = cellNum, 0, -1 do
            self._taskBeginLogicPos[i + 1] = self._taskBeginLogicPos[i]
          end
          self._taskBeginLogicPos[0] = self._taskBeginLogicPos[1] - self._logicCells[0]._size
        end
        self._leftIndex = 1
      end
      if self._rightIndex == cellNum + 1 then
        for i = 1, cellNum + 1 do
          self._logicCells[i - 1] = self._logicCells[i]
        end
        self._logicCells[cellNum + 1] = LogicCell.Create()
        self._logicCells[cellNum + 1]._dialogName = self._logicCells[1]._dialogName
        self._logicCells[cellNum + 1]._data = self._logicCells[1]._data
        self._logicCells[cellNum + 1]._size = self._logicCells[1]._size
        self._logicCells[cellNum + 1]._index = self._logicCells[1]._index
        self._logicCells[cellNum + 1]._pos = self._logicCells[cellNum]._pos + self._logicCells[cellNum]._size
        if self._taskBeginLogicPos and #self._taskBeginLogicPos ~= 0 then
          for i = 1, cellNum + 1 do
            self._taskBeginLogicPos[i - 1] = self._taskBeginLogicPos[i]
          end
          self._taskBeginLogicPos[cellNum + 1] = self._taskBeginLogicPos[cellNum] + self._logicCells[cellNum]._size
        end
        self._rightIndex = cellNum
        self._leftIndex = self._leftIndex - 1
      end
      if self._rightIndex == 0 then
        self._rightIndex = 1
      end
      if self._leftIndex == cellNum + 1 then
        self._leftIndex = cellNum
      end
    else
      if self._slideInertiaTask then
        if self._logicCells[1]._pos >= width * 1 / 3 then
          self._slideInertiaTask = nil
          self._currentDrag = 0
          self._sprintTime = 0.3
        elseif self._logicCells[cellNum]._pos + self._logicCells[cellNum]._size <= width * 2 / 3 then
          self._slideInertiaTask = nil
          self._currentDrag = 0
          self._sprintTime = 0.3
        end
      end
      if self._sprintTime and not self._slideInertiaTask and not self._sprintTask then
        self:EstablishSprintTask(0)
      end
    end
    for i, logicCell in ipairs(self._logicCells) do
      if logicCell._visible then
        if not logicCell._cell then
          self:GetCellDialog(logicCell)
          logicCell._cell._delegate = self._delegate
          logicCell._cell._cellData = logicCell._data
          logicCell._cell:RefreshCell(logicCell._data)
        end
        logicCell._cell:GetRootWindow():SetPosition(0, logicCell._pos, 0, 0)
      end
    end
    if self._refreshUIParticleClipper and self._refreshPosY then
      self._refreshPosY = false
      CS.PixelNeko.Render.ShaderUtility.UIParticleClipper.RefreshUIParticleClipper(self._viewport:GetUIObject())
    end
    for dialogName, cells in pairs(self._recycleCells) do
      for i, cell in ipairs(cells) do
        cell:GetRootWindow():SetPosition(0, -10000, 0, 0)
      end
    end
    if not self._slideInertiaTask and not self._sprintTask and #self._insertTask == 0 and #self._removeTask == 0 and not self._moveLeftTask and not self._moveRightTask and not self._moveLeftIndexTask and not self._moveRightIndexTask and not self._alignTask then
      self._needUpdate = false
    end
    if not self._canLoop and self._delegate.OnCurPosChange then
      local width, height = self._viewport:GetRectSize()
      local ratio = 0
      if width < self._totalLength then
        local base = self._logicCells[1]._pos
        ratio = base / -(self._totalLength - width)
        if ratio < 0 then
          ratio = 0
        end
        if 1 < ratio then
          ratio = 1
        end
        if 1 - ratio < 0.001 then
          ratio = 1
        elseif ratio < 0.001 then
          ratio = 0
        end
      else
        ratio = 0
      end
      self._delegate:OnCurPosChange(self._interface, ratio)
    end
  end
end

function LoopHorizontalTableFrameImpl:GetCellDialog(logicCell)
  if logicCell._cell then
    return
  end
  if not self._recycleCells[logicCell._dialogName] then
    self._recycleCells[logicCell._dialogName] = {}
  end
  local recycleList = self._recycleCells[logicCell._dialogName]
  if 0 < #recycleList then
    logicCell._cell = recycleList[#recycleList]
    recycleList[#recycleList] = nil
  else
    logicCell._cell = DialogManager.CopyDialog(logicCell._dialogName, self._baseCells[logicCell._dialogName]._uiObject, self._viewport._uiObject)
  end
end

function LoopHorizontalTableFrameImpl:RecycleCell(logicCell)
  if logicCell._cell then
    if not self._recycleCells[logicCell._dialogName] then
      self._recycleCells[logicCell._dialogName] = {}
    end
    table.insert(self._recycleCells[logicCell._dialogName], logicCell._cell)
    logicCell._cell = nil
  end
end

function LoopHorizontalTableFrameImpl:EstablishSprintTask(deltaData)
  local width, height = self._viewport:GetRectSize()
  local cellNum = self._delegate:NumberOfCell(self._interface)
  if self._logicCells[1]._pos + deltaData > 0 then
    self._sprintTime = 0.3
    self._needUpdate = true
    local lenofend = -(self._logicCells[1]._pos + deltaData)
    self._sprintSpeed = lenofend * 2 / self._sprintTime
    self._taskBeginLogicPosForSprint = {}
    for i = self._logicCellUpIndex, self._logicCellDownIndex do
      self._taskBeginLogicPosForSprint[i] = self._logicCells[i]._pos + deltaData
    end
    local first = {
      pos = self._sprintSpeed
    }
    local last = {pos = 0}
    self._sprintTask = Tween.new(self._sprintTime, first, last, "linear")
  elseif width > self._logicCells[cellNum]._pos + self._logicCells[cellNum]._size + deltaData then
    self._sprintTime = 0.3
    self._needUpdate = true
    local lenofend = width - (self._logicCells[cellNum]._pos + self._logicCells[cellNum]._size + deltaData)
    self._sprintSpeed = lenofend * 2 / self._sprintTime
    self._taskBeginLogicPosForSprint = {}
    for i = self._logicCellUpIndex, self._logicCellDownIndex do
      self._taskBeginLogicPosForSprint[i] = self._logicCells[i]._pos + deltaData
    end
    local first = {
      pos = self._sprintSpeed
    }
    local last = {pos = 0}
    self._sprintTask = Tween.new(self._sprintTime, first, last, "linear")
  end
end

function LoopHorizontalTableFrameImpl:SetSlide(slide, showSoftMask)
  if slide then
    if self._beginDragHandler then
      self._viewport:Unsubscribe_BeginDragEvent(self._beginDragHandler)
    end
    if self._dragHandler then
      self._viewport:Unsubscribe_DragEvent(self._dragHandler)
    end
    if self._endDragHandler then
      self._viewport:Unsubscribe_EndDragEvent(self._endDragHandler)
    end
    if self._cancelDragHandler then
      self._viewport:Unsubscribe_CancelDragEvent(self._cancelDragHandler)
    end
    self._beginDragHandler = self._viewport:Subscribe_BeginDragEvent(self.OnBeginDrag, self)
    self._dragHandler = self._viewport:Subscribe_DragEvent(self.OnDrag, self)
    self._endDragHandler = self._viewport:Subscribe_EndDragEvent(self.OnEndDrag, self)
    self._cancelDragHandler = self._viewport:Subscribe_CancelDragEvent(self.OnEndDrag, self)
    CS.PixelNeko.Lua.SoftMaskStaticFunctions.SetSoftMaskActive(self._viewport._uiObject, true)
  else
    CS.PixelNeko.Lua.SoftMaskStaticFunctions.SetSoftMaskActive(self._viewport._uiObject, showSoftMask)
    self._viewport:Unsubscribe_BeginDragEvent(self._beginDragHandler)
    self._viewport:Unsubscribe_DragEvent(self._dragHandler)
    self._viewport:Unsubscribe_EndDragEvent(self._endDragHandler)
    self._viewport:Unsubscribe_CancelDragEvent(self._cancelDragHandler)
  end
end

function LoopHorizontalTableFrameImpl:SetSoftMaskActive(showSoftMask)
  CS.PixelNeko.Lua.SoftMaskStaticFunctions.SetSoftMaskActive(self._viewport._uiObject, showSoftMask)
end

function LoopHorizontalTableFrameImpl:RefreshUIParticleClipper()
  self._refreshUIParticleClipper = true
  CS.PixelNeko.Render.ShaderUtility.UIParticleClipper.RefreshUIParticleClipper(self._viewport:GetUIObject())
end

return LoopHorizontalTableFrameImpl
