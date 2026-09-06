local UIManager = CS.PixelNeko.UI.UIManager
local LogicCell = require("framework.ui.frame.grid.logiccell")
local VerticalGridFrameImpl = class("VerticalGridFrameImpl")

function VerticalGridFrameImpl:Ctor(interface, container, delegate, columnNums, canSlide, viewportName, rightToLeft)
  self._interface = interface
  self._container = container
  self._delegate = delegate
  self._canSlide = canSlide
  self._columnNums = columnNums
  self._rightToLeft = rightToLeft
  self._recycleCells = {}
  self._logicCells = {}
  self._baseCells = {}
  if CS.PixelNeko.Lua.UI.FrameStaticFunctions.GetFrameChildCount(container._uiObject) > 0 then
    LogErrorFormat("VerticalGridFrameImpl", "非法操作: container [%s] 已经创建过frame Viewport", container._uiObject)
  end
  self._viewport = CS.PixelNeko.UI.UIManager.CreateLuaWindow("ui/widgets.assetbundle", viewportName, container._uiObject)
  CS.PixelNeko.Lua.UI.FrameStaticFunctions.AddFrameChild(container._uiObject, self._viewport._uiObject)
  self._viewcontainer = CS.PixelNeko.UI.UIManager.GetChildLuaWindow(self._viewport._uiObject, "_Containter")
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
  self._viewcontainer_sx, self._viewcontainer_sox = self._viewcontainer:GetSize()
  self._upMargin, self._downMargin, self._leftMargin, self._rightMargin = CS.PixelNeko.Lua.UI.FrameStaticFunctions.GetMargin(container._uiObject)
  self._cellSizeX = 0
  self._cellSizeY = 0
  self._currentPosition = 0
  self._dragDelta = 0
  self._totalLength = 0
  self._needUpdate = false
  self._moveTopTask = nil
  self._moveBottomTask = nil
  self._moveTopIndexTask = nil
  self._moveDownIndexTask = nil
  self._moveTopIndexDes = nil
  self._moveDownIndexDes = nil
  self._moveToAssignedPosTask = nil
  self._moveToAssignedPosDes = nil
end

function VerticalGridFrameImpl:Destroy()
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
  self._currentPosition = 0
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

function VerticalGridFrameImpl:GetTotalLength()
  return self._totalLength
end

function VerticalGridFrameImpl:GetCurrentPosition()
  return self._currentPosition
end

function VerticalGridFrameImpl:ReloadAllCell()
  for i, logicCell in ipairs(self._logicCells) do
    if logicCell._cell then
      self:RecycleCell(logicCell)
    end
  end
  self._logicCells = {}
  self._currentPosition = 0 - self._upMargin
  self._totalLength = 0
  local cellNums = self._delegate:NumberOfCell(self._interface)
  for i = 1, cellNums do
    local logicCell = LogicCell.Create()
    logicCell._dialogName = self._delegate:CellAtIndex(self._interface, i)
    if not self._baseCells[logicCell._dialogName] then
      local dialogDefine = require("logic.dialog." .. logicCell._dialogName)
      self._baseCells[logicCell._dialogName] = UIManager.CreateLuaWindow(dialogDefine.AssetBundleName .. ".assetbundle", dialogDefine.AssetName, self._viewcontainer._uiObject)
      self._baseCells[logicCell._dialogName]:SetPosition(0, 0, 0, -10000)
    end
    logicCell._data = self._delegate:DataAtIndex(self._interface, i)
    self._logicCells[i] = logicCell
  end
  for i, logicCell in ipairs(self._logicCells) do
    local row, column = (i - 1) // self._columnNums, (i - 1) % self._columnNums
    if self._rightToLeft then
      column = self._columnNums - column - 1
    end
    logicCell._row = row
    logicCell._col = column
    if self._cellSizeX == 0 or self._cellSizeY == 0 then
      self:GetCellDialog(logicCell)
      logicCell._cell._delegate = self._delegate
      logicCell._cell._cellData = logicCell._data
      logicCell._cell:RefreshCell(logicCell._data)
      self._cellSizeX, self._cellSizeY = logicCell._cell:GetRootWindow():GetRectSize()
      self:RecycleCell(logicCell)
    end
    logicCell._posX = column * self._cellSizeX
    logicCell._posY = row * self._cellSizeY
    self._totalLength = (row + 1) * self._cellSizeY
  end
  self._needUpdate = true
  self:UpdateView(0)
end

function VerticalGridFrameImpl:MoveToTop(isAnimate)
  self._needUpdate = true
  if isAnimate then
    local first = {
      pos = self._currentPosition
    }
    local last = {
      pos = 0 - self._upMargin
    }
    self._moveTopTask = Tween.new(0.5, first, last, "outQuad")
  else
    self:ClearAllPositionChangeTask()
    self._currentPosition = 0 - self._upMargin
  end
end

function VerticalGridFrameImpl:MoveToBottom(isAnimate)
  self._needUpdate = true
  local width, height = self._viewport:GetRectSize()
  if height < self._totalLength then
    if isAnimate then
      local first = {
        pos = self._currentPosition
      }
      local last = {
        pos = self._totalLength - height + self._downMargin
      }
      self._moveBottomTask = Tween.new(0.5, first, last, "outQuad")
    else
      self:ClearAllPositionChangeTask()
      self._currentPosition = self._totalLength - height + self._downMargin
    end
  end
end

function VerticalGridFrameImpl:MoveTopToIndex(desIndex, isAnimate)
  self._needUpdate = true
  self._moveDownIndexTask = nil
  local destination = self._logicCells[desIndex]._posY
  local width, height = self._viewport:GetRectSize()
  if destination > self._totalLength - height + self._downMargin then
    destination = self._totalLength - height + self._downMargin
  else
    destination = destination - self._upMargin
  end
  if destination < 0 - self._upMargin then
    destination = 0 - self._upMargin
  end
  self._moveTopIndexDes = destination
  if isAnimate then
    local first = {
      pos = self._currentPosition
    }
    local last = {pos = destination}
    self._moveTopIndexTask = Tween.new(0.5, first, last, "linear")
  else
    self:ClearAllPositionChangeTask()
    self._currentPosition = destination
  end
end

function VerticalGridFrameImpl:MoveDownToIndex(desIndex, isAnimate)
  self._needUpdate = true
  self._moveTopIndexTask = nil
  local width, height = self._viewport:GetRectSize()
  local destination = self._logicCells[desIndex]._posY + self._cellSizeY - height
  if destination > self._totalLength - height + self._downMargin then
    destination = self._totalLength - height + self._downMargin
  else
    destination = destination + self._downMargin
  end
  if destination < 0 - self._upMargin then
    destination = 0 - self._upMargin
  end
  self._moveDownIndexDes = destination
  if isAnimate then
    local first = {
      pos = self._currentPosition
    }
    local last = {pos = destination}
    self._moveDownIndexTask = Tween.new(0.5, first, last, "linear")
  else
    self:ClearAllPositionChangeTask()
    self._currentPosition = destination
  end
end

function VerticalGridFrameImpl:MoveToAssignedPos(pos, isAnimate)
  self._needUpdate = true
  self._moveToAssignedPosDes = pos
  if isAnimate then
    local first = {
      pos = self._currentPosition
    }
    local last = {
      pos = self._moveToAssignedPosDes
    }
    self._moveToAssignedPosTask = Tween.new(0.5, first, last, "linear")
  else
    self:ClearAllPositionChangeTask()
    self._currentPosition = pos
  end
end

function VerticalGridFrameImpl:ReloadCellsAtIndex(indexList, isAnimate)
  if type(indexList) ~= "table" then
    LogError("VerticalGridFrameImpl", "please input a table value")
    return
  end
  local cellNums = self._delegate:NumberOfCell(self._interface)
  for _, index in pairs(indexList) do
    if not index or index > cellNums then
      LogErrorFormat("VerticalGridFrameImpl", "the index %d is out of range", index)
      return
    end
    local logicCell = self._logicCells[index]
    logicCell._dialogName = self._delegate:CellAtIndex(self._interface, index)
    if not self._baseCells[logicCell._dialogName] then
      local dialogDefine = require("logic.dialog." .. logicCell._dialogName)
      self._baseCells[logicCell._dialogName] = UIManager.CreateLuaWindow(dialogDefine.AssetBundleName .. ".assetbundle", dialogDefine.AssetName, self._viewcontainer._uiObject)
      self._baseCells[logicCell._dialogName]:SetPosition(0, 0, 0, -10000)
    end
    logicCell._data = self._delegate:DataAtIndex(self._interface, index)
    self:GetCellDialog(logicCell)
    logicCell._cell._cellData = logicCell._data
    logicCell._cell:RefreshCell(logicCell._data)
    self:RecycleCell(logicCell)
    self._logicCells[index] = logicCell
  end
  self:UpdateView(0)
end

function VerticalGridFrameImpl:RemoveCellsAtIndex(indexList, isAnimate)
  if type(indexList) ~= "table" then
    LogError("VerticalGridFrameImpl", "please input a table value")
    return
  end
  self._needUpdate = true
  local width, height = self._viewport:GetRectSize()
  for _, index in ipairs(indexList) do
    local cellNums = #self._logicCells
    if index > cellNums then
      LogErrorFormat("VerticalGridFrameImpl", "Wrong index %d", index)
      return
    end
    local posX = self._logicCells[index]._posX
    local posY = self._logicCells[index]._posY
    self:RecycleCell(self._logicCells[index])
    for i = index + 1, cellNums do
      if self._rightToLeft then
        if self._logicCells[i]._col == self._columnNums - 1 then
          self._logicCells[i]._row = self._logicCells[i]._row - 1
          self._logicCells[i]._col = 0
        else
          self._logicCells[i]._col = self._logicCells[i]._col + 1
        end
      elseif self._logicCells[i]._col == 0 then
        self._logicCells[i]._row = self._logicCells[i]._row - 1
        self._logicCells[i]._col = self._columnNums - 1
      else
        self._logicCells[i]._col = self._logicCells[i]._col - 1
      end
      self._logicCells[i]._posX = self._logicCells[i]._col * self._cellSizeX
      self._logicCells[i]._posY = self._logicCells[i]._row * self._cellSizeY
    end
    table.remove(self._logicCells, index)
    self._totalLength = ((cellNums - 1 - 1) // self._columnNums + 1) * self._cellSizeY
  end
end

function VerticalGridFrameImpl:InsertCellsAtIndex(indexList, isAnimate)
  if indexList and type(indexList) ~= "table" then
    LogError("VerticalGridFrameImpl", "please input a table value")
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
      LogError("VerticalGridFrameImpl", "no additional data")
      return
    end
  end
  for _, index in ipairs(indexList) do
    cellNums = #self._logicCells
    if not index or index > cellNums + 1 and not lastinsert then
      LogErrorFormat("VerticalGridFrameImpl", "Wrong index %d", index)
      return
    end
    local logicCell = LogicCell.Create()
    logicCell._dialogName = self._delegate:CellAtIndex(self._interface, index)
    if not self._baseCells[logicCell._dialogName] then
      local dialogDefine = require("logic.dialog." .. logicCell._dialogName)
      self._baseCells[logicCell._dialogName] = UIManager.CreateLuaWindow(dialogDefine.AssetBundleName .. ".assetbundle", dialogDefine.AssetName, self._viewcontainer._uiObject)
      self._baseCells[logicCell._dialogName]:SetPosition(0, 0, 0, -10000)
    end
    logicCell._data = self._delegate:DataAtIndex(self._interface, index)
    local row, column = (index - 1) // self._columnNums, (index - 1) % self._columnNums
    if self._rightToLeft then
      column = self._columnNums - column - 1
    end
    logicCell._row = row
    logicCell._col = column
    self:GetCellDialog(logicCell)
    logicCell._cell._delegate = self._delegate
    logicCell._cell._cellData = logicCell._data
    logicCell._cell:RefreshCell(logicCell._data)
    self._cellSizeX, self._cellSizeY = logicCell._cell:GetRootWindow():GetRectSize()
    self:RecycleCell(logicCell)
    logicCell._posX = column * self._cellSizeX
    logicCell._posY = row * self._cellSizeY
    table.insert(self._logicCells, index, logicCell)
    cellNums = #self._logicCells
    for i = index + 1, cellNums do
      if self._logicCells[i]._col == self._columnNums - 1 then
        self._logicCells[i]._col = 0
        self._logicCells[i]._row = self._logicCells[i]._row + 1
      else
        self._logicCells[i]._col = self._logicCells[i]._col + 1
      end
      self._logicCells[i]._posX = self._logicCells[i]._col * self._cellSizeX
      self._logicCells[i]._posY = self._logicCells[i]._row * self._cellSizeY
    end
    self._totalLength = ((cellNums - 1) // self._columnNums + 1) * self._cellSizeY
  end
end

function VerticalGridFrameImpl:FireEvent(eventName, ...)
  for i, logicCell in ipairs(self._logicCells) do
    if logicCell._cell and logicCell._cell.OnEvent then
      logicCell._cell:OnEvent(eventName, ...)
    end
  end
end

function VerticalGridFrameImpl:FireIndexCellEvent(eventName, index, ...)
  local logicCell = self._logicCells[index]
  if not logicCell then
    return
  end
  if logicCell._cell and logicCell._cell.OnEvent then
    logicCell._cell:OnEvent(eventName, ...)
  end
end

function VerticalGridFrameImpl:SetMargin(upValue, downValue)
  if self._upMargin == 0 then
    self._upMargin = upValue
  end
  if self._downMargin == 0 then
    self._downMargin = downValue
  end
end

function VerticalGridFrameImpl:OnBeginDrag(args)
  self._dragDelta = 0
  self._slideInertiaTime = 0.3
  self._sprintTime = 0.3
  self._slideInertiaTask = nil
  self._sprintTask = nil
  self._sprintclickdown = false
  self._viewcontainer:SetBlocksRaycasts(false)
  self._moveSpeed = {x = 0, y = 0}
  if self._delegate.OnFrameBeginDrag then
    self._delegate:OnFrameBeginDrag(self._interface)
  end
end

function VerticalGridFrameImpl:OnDrag(args)
  local pressPosition = args.pressPosition
  local position = args.position
  local localPressX, localPressY = UIManager.ScreenPointToLocalPointInRectangle(self._viewport._uiObject, pressPosition.x, pressPosition.y)
  local localX, localY = UIManager.ScreenPointToLocalPointInRectangle(self._viewport._uiObject, position.x, position.y)
  self._moveSpeed.x = args.xSpeed / 60
  self._moveSpeed.y = args.ySpeed / 60
  local currentPosition = self._currentPosition
  self._currentPosition = currentPosition - self._dragDelta
  self._dragDelta = localY - localPressY
  self._currentPosition = self._currentPosition + self._dragDelta
  if currentPosition ~= self._currentPosition then
    self._needUpdate = true
    self:UpdateView(0)
  end
end

function VerticalGridFrameImpl:OnEndDrag(args)
  self._dragDelta = 0
  local _, original = UIManager.ScreenPointToLocalPointInRectangle(self._viewport._uiObject, 0, 0)
  local _, speed = UIManager.ScreenPointToLocalPointInRectangle(self._viewport._uiObject, self._moveSpeed.x, self._moveSpeed.y)
  speed = original - speed
  local width, height = self._viewport:GetRectSize()
  local currentPosition = self._currentPosition
  if speed == 0 then
    self._viewcontainer:SetBlocksRaycasts(true)
  elseif currentPosition + height <= self._totalLength + self._downMargin and currentPosition >= 0 - self._upMargin then
    self._needUpdate = true
    self._slideInertiaPosition = currentPosition
    self._slideInertiaSpeed = speed * 20
    self._sprintTask = nil
    self._sprintPosition = nil
    local lenofend = speed * 20 * self._slideInertiaTime / 2
    currentPosition = currentPosition - lenofend
    if currentPosition > self._totalLength - height + height / 3 + self._downMargin then
      currentPosition = self._totalLength - height + height / 3 + self._downMargin
      lenofend = self._slideInertiaPosition - currentPosition
      self._slideInertiaTime = lenofend * 2 / self._slideInertiaSpeed
    end
    if currentPosition < -height / 3 - self._upMargin then
      currentPosition = -height / 3 - self._upMargin
      lenofend = self._slideInertiaPosition - currentPosition
      self._slideInertiaTime = lenofend * 2 / self._slideInertiaSpeed
    end
    local first = {
      pos = self._slideInertiaSpeed
    }
    local last = {pos = 0}
    self._slideInertiaTask = Tween.new(self._slideInertiaTime, first, last, "linear")
  end
  if currentPosition + height > self._totalLength + self._downMargin then
    self._sprintPosition = currentPosition
    self._needUpdate = true
    local lenofend = currentPosition - self._totalLength + height - self._downMargin
    if height > self._totalLength + self._downMargin then
      lenofend = currentPosition + self._upMargin
    end
    self._sprintSpeed = lenofend * 2 / self._sprintTime
    local first = {
      pos = self._sprintSpeed
    }
    local last = {pos = 0}
    self._sprintTask = Tween.new(self._sprintTime, first, last, "linear")
  end
  if currentPosition < 0 - self._upMargin then
    self._sprintPosition = currentPosition
    self._needUpdate = true
    local lenofend = currentPosition + self._upMargin
    self._sprintSpeed = lenofend * 2 / self._sprintTime
    local first = {
      pos = self._sprintSpeed
    }
    local last = {pos = 0}
    self._sprintTask = Tween.new(self._sprintTime, first, last, "linear")
  end
  if self._delegate.OnFrameEndDrag then
    self._delegate:OnFrameEndDrag(self._interface)
  end
end

function VerticalGridFrameImpl:OnPointerDown(deltaTime)
  self._dragDelta = 0
  if self._slideInertiaTask then
    self._slideInertiaTask = nil
    self._viewcontainer:SetBlocksRaycasts(true)
    if self._sprintTask then
      local width, height = self._viewport:GetRectSize()
      local currentPosition = self._currentPosition
      if currentPosition + height > self._totalLength + self._downMargin then
        self._sprintPosition = currentPosition
        self._needUpdate = true
        local lenofend = currentPosition - self._totalLength + height - self._downMargin
        if height > self._totalLength + self._downMargin then
          lenofend = currentPosition + self._upMargin
        end
        self._sprintSpeed = lenofend * 2 / self._sprintTime
        local first = {
          pos = self._sprintSpeed
        }
        local last = {pos = 0}
        self._sprintTask = Tween.new(self._sprintTime, first, last, "linear")
      elseif currentPosition < 0 - self._upMargin then
        self._sprintPosition = currentPosition
        self._needUpdate = true
        local lenofend = currentPosition + self._upMargin
        self._sprintSpeed = lenofend * 2 / self._sprintTime
        local first = {
          pos = self._sprintSpeed
        }
        local last = {pos = 0}
        self._sprintTask = Tween.new(self._sprintTime, first, last, "linear")
      else
        self._sprintTask = nil
      end
    end
  end
  self._sprintclickdown = true
end

function VerticalGridFrameImpl:OnPointerUp(deltaTime)
  self._sprintclickdown = false
  self:UpdateView(0)
end

function VerticalGridFrameImpl:OnLateUpdate(notification)
  local deltaTime = notification.userInfo.unscaledDeltaTime
  local width, height = self._viewport:GetRectSize()
  if self._needUpdate then
    if self._slideInertiaTask then
      if self._slideInertiaTask:update(deltaTime) then
        self._currentPosition = self._slideInertiaPosition - (self._slideInertiaSpeed + self._slideInertiaTask.subject.pos) * self._slideInertiaTime / 2
        self._slideInertiaTask = nil
        self._slideInertiaPosition = nil
        self._viewcontainer:SetBlocksRaycasts(true)
      else
        self._currentPosition = self._slideInertiaPosition - (self._slideInertiaSpeed + self._slideInertiaTask.subject.pos) * self._slideInertiaTask.clock / 2
      end
      if self._slideInertiaTask and (self._currentPosition > self._totalLength - height + self._downMargin or self._currentPosition < 0 - self._upMargin) then
        self._slideInertiaTask.clock = self._slideInertiaTask.clock + 2 * deltaTime
      end
      if self._currentPosition > self._totalLength - height + height / 3 + self._downMargin then
        self._currentPosition = self._totalLength - height + height / 3 + self._downMargin
        self._slideInertiaTask = nil
        self._slideInertiaPosition = nil
        self._viewcontainer:SetBlocksRaycasts(true)
      end
      if self._currentPosition < -height / 3 - self._upMargin then
        self._currentPosition = -height / 3 - self._upMargin
        self._slideInertiaTask = nil
        self._slideInertiaPosition = nil
        self._viewcontainer:SetBlocksRaycasts(true)
      end
    end
    if not self._slideInertiaTask and self._sprintTask and not self._sprintclickdown then
      self._viewcontainer:SetBlocksRaycasts(false)
      if self._sprintTask:update(deltaTime) then
        self._currentPosition = self._sprintPosition - (self._sprintSpeed + self._sprintTask.subject.pos) * self._sprintTime / 2
        self._sprintTask = nil
        self._sprintPosition = nil
        self._viewcontainer:SetBlocksRaycasts(true)
      else
        self._currentPosition = self._sprintPosition - (self._sprintSpeed + self._sprintTask.subject.pos) * self._sprintTask.clock / 2
      end
    end
    if self._moveTopTask then
      if self._moveTopTask:update(deltaTime) then
        self._currentPosition = 0 - self._upMargin
        self._moveTopTask = nil
      else
        self._currentPosition = self._moveTopTask.subject.pos
      end
    end
    if self._moveBottomTask then
      if self._moveBottomTask:update(deltaTime) then
        self._currentPosition = self._totalLength - height + self._downMargin
        self._moveBottomTask = nil
      else
        self._currentPosition = self._moveBottomTask.subject.pos
      end
    end
    if self._moveTopIndexTask then
      if self._moveTopIndexTask:update(deltaTime) then
        self._currentPosition = self._moveTopIndexDes
        self._moveTopIndexTask = nil
      else
        self._currentPosition = self._moveTopIndexTask.subject.pos
      end
    end
    if self._moveDownIndexTask then
      if self._moveDownIndexTask:update(deltaTime) then
        self._currentPosition = self._moveDownIndexDes
        self._moveDownIndexTask = nil
      else
        self._currentPosition = self._moveDownIndexTask.subject.pos
      end
    end
    if self._moveToAssignedPosTask then
      if self._moveToAssignedPosTask:update(deltaTime) then
        self._currentPosition = self._moveToAssignedPosDes
        self._moveToAssignedPosTask = nil
      else
        self._currentPosition = self._moveToAssignedPosTask.subject.pos
      end
    end
    self:UpdateView(deltaTime)
  end
end

function VerticalGridFrameImpl:UpdateView(deltaTime)
  if self._needUpdate then
    local currentPosition = self._currentPosition
    local width, height = self._viewport:GetRectSize()
    if height < self._totalLength + self._upMargin then
      if currentPosition < 0 - self._upMargin then
        currentPosition = currentPosition - 2 * (currentPosition + self._upMargin) / 3
      end
      if currentPosition + height > self._totalLength + self._downMargin then
        currentPosition = currentPosition - 2 * (height - self._totalLength + currentPosition - self._downMargin) / 3
      end
    else
      currentPosition = currentPosition + self._upMargin
      currentPosition = currentPosition / 3
    end
    for i, logicCell in ipairs(self._logicCells) do
      if logicCell._posY + self._cellSizeY >= currentPosition - self._upMargin and logicCell._posY <= currentPosition + height + self._downMargin then
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
    self._cellX = -1
    for i, logicCell in ipairs(self._logicCells) do
      if logicCell._visible then
        if not logicCell._cell then
          self:GetCellDialog(logicCell)
          logicCell._cell._delegate = self._delegate
          logicCell._cell._cellData = logicCell._data
          logicCell._cell:RefreshCell(logicCell._data)
        end
        logicCell._cell:GetRootWindow():SetPosition(0, logicCell._posX, 1, -logicCell._posY - self._cellSizeY)
        if self._cellX == -1 then
          local y
          self._cellX, y = logicCell._cell:GetRootWindow():GetRectSize()
        end
      end
    end
    if self._refreshUIParticleClipper and self._refreshPosY then
      self._refreshPosY = false
      CS.PixelNeko.Render.ShaderUtility.UIParticleClipper.RefreshUIParticleClipper(self._viewport:GetUIObject())
    end
    for dialogName, cells in pairs(self._recycleCells) do
      for i, cell in ipairs(cells) do
        cell:GetRootWindow():SetPosition(0, 0, 0, -10000)
      end
    end
    local vx = self._cellX * self._columnNums
    local viewportX, y = self._viewport:GetRectSize()
    if vx > viewportX then
      vx = viewportX
    end
    self._viewcontainer:SetSize(0, vx, 0, self._totalLength)
    if height >= self._totalLength + self._upMargin then
      self._viewcontainer:SetPosition(0, (viewportX - vx) / 2, 0, currentPosition - self._totalLength + height - self._upMargin)
    else
      self._viewcontainer:SetPosition(0, (viewportX - vx) / 2, 0, currentPosition - self._totalLength + height)
    end
    if self._leftMargin ~= 0 or self._rightMargin ~= 0 then
      local aMinX, aMinY, aMaxX, aMaxY, oMinX, oMinY, oMaxX, oMaxY = self._viewcontainer:GetAnchorAndOffset()
      self._viewcontainer:SetAnchorAndOffset(0, aMinY, 1, aMaxY, self._leftMargin, oMinY, -self._rightMargin, oMaxY)
    end
    if not self._sprintTask and not self._slideInertiaTask and not self._moveTopTask and not self._moveBottomTask and not self._moveTopIndexTask and not self._moveDownIndexTask and not self._moveToAssignedPosTask then
      self._needUpdate = false
    end
    if self._delegate.OnCurPosChange then
      local width, height = self._viewport:GetRectSize()
      local ratio = 0
      if height < self._totalLength then
        ratio = self._currentPosition / (self._totalLength - height)
        if ratio < 0 then
          ratio = (self._currentPosition + self._upMargin) / (self._totalLength - height)
        end
        if 1 < ratio then
          ratio = (self._currentPosition - self._downMargin) / (self._totalLength - height)
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

function VerticalGridFrameImpl:GetCellDialog(logicCell)
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
    logicCell._cell = DialogManager.CopyDialog(logicCell._dialogName, self._baseCells[logicCell._dialogName]._uiObject, self._viewcontainer._uiObject)
  end
end

function VerticalGridFrameImpl:RecycleCell(logicCell)
  if logicCell._cell then
    if not self._recycleCells[logicCell._dialogName] then
      self._recycleCells[logicCell._dialogName] = {}
    end
    table.insert(self._recycleCells[logicCell._dialogName], logicCell._cell)
    logicCell._cell = nil
  end
end

function VerticalGridFrameImpl:SendMessageToInstance(name, args)
  for _, logicCell in ipairs(self._logicCells) do
    if logicCell._cell and logicCell._cell.HandleFrameMessage then
      logicCell._cell.HandleFrameMessage(logicCell._cell, name, args)
    end
  end
end

function VerticalGridFrameImpl:SetSlide(slide, showSoftMask)
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

function VerticalGridFrameImpl:SetSoftMaskActive(showSoftMask)
  CS.PixelNeko.Lua.SoftMaskStaticFunctions.SetSoftMaskActive(self._viewport._uiObject, showSoftMask)
end

function VerticalGridFrameImpl:RefreshUIParticleClipper()
  self._refreshUIParticleClipper = true
  CS.PixelNeko.Render.ShaderUtility.UIParticleClipper.RefreshUIParticleClipper(self._viewport:GetUIObject())
end

function VerticalGridFrameImpl:ClearAllPositionChangeTask()
  self._slideInertiaTask = nil
  self._sprintTask = nil
  self._moveTopTask = nil
  self._moveBottomTask = nil
  self._moveTopIndexTask = nil
  self._moveDownIndexTask = nil
  self._moveToAssignedPosTask = nil
end

return VerticalGridFrameImpl
