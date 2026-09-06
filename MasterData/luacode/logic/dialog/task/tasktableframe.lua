local VerticalTableFrameInverseImpl = require("framework.ui.frame.table.verticaltableframeinverseimpl")
local UIManager = CS.PixelNeko.UI.UIManager
local LogicCell = require("framework.ui.frame.table.logiccell")
local TaskTableFrame = class("TaskTableFrame", VerticalTableFrameInverseImpl)

function TaskTableFrame:RemoveCellsAtIndex(indexList, isAnimate)
  if type(indexList) ~= "table" then
    LogError("VerticalTableFrameInverseImpl", "please input a table value")
    return
  end
  self._needUpdate = true
  local cellNums = #self._logicCells
  local width, height = self._viewport:GetRectSize()
  local currentPosition = self._currentPosition
  for _, index in pairs(indexList) do
    if index > cellNums then
      LogErrorFormat("VerticalTableFrameInverseImpl", "Wrong index %d", index)
      return
    end
    local gap = self._logicCells[index]._size
    local pos = self._logicCells[index]._pos
    self:RecycleCell(self._logicCells[index])
    if #self._insertTask ~= 0 then
      for i, task in pairs(self._insertTask) do
        local logicCell = self._logicCells[i]
        logicCell._pos = self._insertDes[i]
        self._insertDes[i] = nil
        self._insertTask[i] = nil
      end
    end
    if #self._removeTask ~= 0 then
      for i, task in pairs(self._removeTask) do
        self._logicCells[i]._pos = self._removeDes[i]
        self._removeDes[i] = nil
        self._removeTask[i] = nil
      end
    end
    if self._removeCurTask then
      self._currentPosition = self._removeCurDes
      self._removeCurTask = nil
      self._removeCurDes = nil
    end
    if self._removeTolTask then
      self._totalLength = self._removeTolDes
      self._removeTolTask = nil
      self._removeTolDes = nil
    end
    local totalHasChange = false
    if isAnimate and currentPosition < pos + gap and pos < currentPosition + height then
      self._removeTask = {}
      for i = 1, index - 1 do
        self._removeDes[i] = self._logicCells[i]._pos - gap
        local first = {
          pos = self._logicCells[i]._pos
        }
        local last = {
          pos = self._removeDes[i]
        }
        self._removeTask[i] = Tween.new(0.1, first, last, "linear")
        self._needUpdate = true
      end
      local delta = self._totalLength - height - currentPosition
      if gap > delta or height > self._totalLength then
        self._removeTolDes = self._totalLength - gap
        local first = {
          pos = self._totalLength
        }
        local last = {
          pos = self._removeTolDes
        }
        local time = 0.1
        local easing = "linear"
        if self._delegate.RemoveTweenParamsAtIndex then
          time, easing = self._delegate:RemoveTweenParamsAtIndex(index)
        end
        self._removeTolTask = Tween.new(time, first, last, easing)
        self._needUpdate = true
        totalHasChange = true
      end
      local curValue = currentPosition - currentPosition % 0.01
      local latestValue = 0 - self._downMargin - (0 - self._downMargin) % 0.01
      if curValue ~= latestValue then
        self._removeCurDes = self._currentPosition - gap
        local first = {
          pos = self._currentPosition
        }
        local last = {
          pos = self._removeCurDes
        }
        local time = 0.1
        local easing = "linear"
        if self._delegate.RemoveTweenParamsAtIndex then
          time, easing = self._delegate:RemoveTweenParamsAtIndex(index)
        end
        self._removeCurTask = Tween.new(time, first, last, easing)
      end
    else
      for i = 1, index - 1 do
        self._logicCells[i]._pos = self._logicCells[i]._pos - gap
      end
    end
    table.remove(self._logicCells, index)
    if not totalHasChange then
      self._totalLength = self._totalLength - gap
    end
  end
end

function TaskTableFrame:InsertCellsAtIndex(indexList, isAnimate)
  if indexList and type(indexList) ~= "table" then
    LogError("VerticalTableFrameInverseImpl", "please input a table value")
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
      LogError("VerticalTableFrameInverseImpl", "no additional data")
      return
    end
  end
  for _, index in pairs(indexList) do
    cellNums = #self._logicCells
    if not index or index > cellNums + 1 and not lastinsert then
      LogErrorFormat("VerticalTableFrameInverseImpl", "Wrong index %d", index)
      return
    end
    local logicCell = LogicCell.Create()
    logicCell._dialogName = self._delegate:CellAtIndex(self._interface, index)
    if not self._baseCells[logicCell._dialogName] then
      local dialogDefine = require("logic.dialog." .. logicCell._dialogName)
      self._baseCells[logicCell._dialogName] = UIManager.CreateLuaWindow(dialogDefine.AssetBundleName .. ".assetbundle", dialogDefine.AssetName, self._viewcontainer._uiObject)
      local width, height = self._viewport:GetRectSize()
      self._baseCells[logicCell._dialogName]:SetPosition(0, 0, 0, -10 * height)
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
        local _ = 0
        _, tempSize[logicCell._dialogName] = logicCell._cell:GetRootWindow():GetRectSize()
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
      logicCell._size = h
    end
    if #self._removeTask ~= 0 then
      for i, task in pairs(self._removeTask) do
        self._logicCells[i]._pos = self._removeDes[i]
        self._removeDes[i] = nil
        self._removeTask[i] = nil
      end
    end
    if self._removeCurTask then
      self._currentPosition = self._removeCurDes
      self._removeCurTask = nil
      self._removeCurDes = nil
    end
    if self._removeTolTask then
      self._totalLength = self._removeTolDes
      self._removeTolTask = nil
      self._removeTolDes = nil
    end
    if #self._insertTask ~= 0 then
      for i, task in pairs(self._insertTask) do
        local logicCell = self._logicCells[i]
        logicCell._pos = self._insertDes[i]
        self._insertDes[i] = nil
        self._insertTask[i] = nil
      end
    end
    table.insert(self._logicCells, index, logicCell)
    local curValue = self._currentPosition - self._currentPosition % 0.01
    local latestValue = -self._downMargin - (0 - self._downMargin) % 0.01
    local time = 0.1
    local easing = "linear"
    if curValue == latestValue and isAnimate then
      self._insertTask = {}
      for i = 1, index - 1 do
        if height < self._totalLength + logicCell._size then
          self._insertDes[i] = self._logicCells[i]._pos + logicCell._size
          local first = {
            pos = self._logicCells[i]._pos
          }
          local last = {
            pos = self._insertDes[i]
          }
          if self._delegate.InsertTweenParamsAtIndex then
            time, easing = self._delegate:InsertTweenParamsAtIndex(i - index + 1)
          end
          self._insertTask[i] = Tween.new(time, first, last, easing)
          self._needUpdate = true
        else
          self._logicCells[i]._pos = self._logicCells[i]._pos + logicCell._size
        end
      end
      if #self._insertTask ~= 0 then
        if index <= cellNums then
          self._insertDes[index] = self._logicCells[index + 1]._pos + self._logicCells[index + 1]._size
          local first = {
            pos = self._logicCells[index + 1]._pos
          }
          local last = {
            pos = self._insertDes[index]
          }
          if self._delegate.InsertTweenParamsAtIndex then
            time, easing = self._delegate:InsertTweenParamsAtIndex(1)
          end
          self._insertTask[index] = Tween.new(time, first, last, easing)
        else
          self._insertDes[index] = 0
          local first = {
            pos = -self._logicCells[index]._size
          }
          local last = {
            pos = self._insertDes[index]
          }
          if self._delegate.InsertTweenParamsAtIndex then
            time, easing = self._delegate:InsertTweenParamsAtIndex(1)
          end
          self._insertTask[index] = Tween.new(time, first, last, easing)
        end
        self._needUpdate = true
      elseif index <= cellNums then
        self._logicCells[index]._pos = self._logicCells[index + 1]._pos + self._logicCells[index + 1]._size
      else
        self._logicCells[index]._pos = 0
      end
    else
      for i = 1, index - 1 do
        self._logicCells[i]._pos = self._logicCells[i]._pos + logicCell._size
      end
      if index <= cellNums then
        self._logicCells[index]._pos = self._logicCells[index + 1]._pos + self._logicCells[index + 1]._size
      else
        self._logicCells[index]._pos = 0
      end
    end
    self._totalLength = self._totalLength + logicCell._size
    if curValue ~= latestValue then
      self._currentPosition = self._currentPosition + logicCell._size
    end
  end
end

function TaskTableFrame:OnLateUpdate(notification)
  local deltaTime = notification.userInfo.deltaTime
  local width, height = self._viewport:GetRectSize()
  if self._needUpdate then
    if self._slideInertiaTask then
      if self._slideInertiaTask:update(deltaTime) then
        self._currentPosition = self._slideInertiaPosition - (self._slideInertiaSpeed + self._slideInertiaTask.subject.pos) * self._slideInertiaTime / 2
        if self._autoAlign then
          if self._slideInertiaSpeed < 0 then
            local half = self._logicCells[self._topIndex]._pos + self._logicCells[self._topIndex]._size / 2
            if half > self._currentPosition + height then
              local first = {
                pos = self._currentPosition
              }
              local cellNums = #self._logicCells
              if cellNums >= self._topIndex + 1 then
                self._alignDes = self._logicCells[self._topIndex + 1]._pos + self._logicCells[self._topIndex + 1]._size - height
                local last = {
                  pos = self._alignDes
                }
                self._alignTask = Tween.new(0.3, first, last, "linear")
              end
            elseif half <= self._currentPosition + height then
              local first = {
                pos = self._currentPosition
              }
              self._alignDes = self._logicCells[self._topIndex]._pos + self._logicCells[self._topIndex]._size - height
              local last = {
                pos = self._alignDes
              }
              self._alignTask = Tween.new(0.3, first, last, "linear")
            end
          elseif self._slideInertiaSpeed > 0 then
            local half = self._logicCells[self._downIndex]._pos + self._logicCells[self._downIndex]._size / 2
            if half >= self._currentPosition then
              local first = {
                pos = self._currentPosition
              }
              self._alignDes = self._logicCells[self._downIndex]._pos
              local last = {
                pos = self._alignDes
              }
              self._alignTask = Tween.new(0.3, first, last, "linear")
            elseif half < self._currentPosition then
              local first = {
                pos = self._currentPosition
              }
              if 0 < self._downIndex - 1 then
                self._alignDes = self._logicCells[self._downIndex - 1]._pos
                local last = {
                  pos = self._alignDes
                }
                self._alignTask = Tween.new(0.3, first, last, "linear")
              end
            end
          end
        end
        self._slideInertiaTask = nil
        self._slideInertiaPosition = nil
        self._viewcontainer:SetBlocksRaycasts(true)
      else
        self._currentPosition = self._slideInertiaPosition - (self._slideInertiaSpeed + self._slideInertiaTask.subject.pos) * self._slideInertiaTask.clock / 2
      end
      if self._slideInertiaTask and (self._currentPosition > self._totalLength - height + self._upMargin or self._currentPosition < 0 - self._downMargin) then
        self._slideInertiaTask.clock = self._slideInertiaTask.clock + 2 * deltaTime
      end
      if self._currentPosition > self._totalLength - height + height / 3 + self._upMargin then
        self._currentPosition = self._totalLength - height + height / 3 + self._upMargin
        self._slideInertiaTask = nil
        self._slideInertiaPosition = nil
        self._viewcontainer:SetBlocksRaycasts(true)
      end
      if self._currentPosition < -height / 3 - self._downMargin then
        self._currentPosition = -height / 3 - self._downMargin
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
    if self._alignTask then
      if self._alignTask:update(deltaTime) then
        self._currentPosition = self._alignDes
        self._alignTask = nil
      else
        self._currentPosition = self._alignTask.subject.pos
      end
    end
    if self._insertTask then
      local clear
      for i, task in pairs(self._insertTask) do
        local logicCell = self._logicCells[i]
        if task:update(deltaTime) then
          logicCell._pos = self._insertDes[i]
          self._insertDes[i] = nil
          self._insertTask[i] = nil
          if self._delegate.OnInsertTweenFinish then
            self._delegate:OnInsertTweenFinish(i)
          end
          clear = true
        else
          logicCell._pos = task.subject.pos
        end
      end
      if clear and table.nums(self._insertTask) == 0 and self._delegate.OnInsertTweenFinish then
        self._delegate:OnInsertTweenFinish()
      end
    end
    if self._removeTask then
      local clear
      for i, task in pairs(self._removeTask) do
        local logicCell = self._logicCells[i]
        if task:update(deltaTime) then
          logicCell._pos = self._removeDes[i]
          self._removeDes[i] = nil
          self._removeTask[i] = nil
          if self._delegate.OnRemoveTweenFinish then
            self._delegate:OnRemoveTweenFinish(i)
          end
          clear = true
        else
          logicCell._pos = task.subject.pos
        end
      end
      if clear and table.nums(self._removeTask) == 0 and self._delegate.OnRemoveTweenFinish then
        self._delegate:OnRemoveTweenFinish()
      end
    end
    if self._removeCurTask then
      if self._removeCurTask:update(deltaTime) then
        self._currentPosition = self._removeCurDes
        self._removeCurTask = nil
        self._removeCurDes = nil
        if self._delegate.OnRemoveTweenFinish then
          self._delegate:OnRemoveTweenFinish()
        end
      else
        self._currentPosition = self._removeCurTask.subject.pos
      end
      if height < self._totalLength + self._upMargin and self._currentPosition > self._totalLength + self._upMargin - height then
        self._currentPosition = self._totalLength + self._upMargin - height
      end
      if self._currentPosition < 0 - self._downMargin then
        self._currentPosition = 0 - self._downMargin
      end
    end
    if self._removeTolTask then
      if self._removeTolTask:update(deltaTime) then
        self._totalLength = self._removeTolDes
        self._removeTolTask = nil
        self._removeTolDes = nil
        if self._delegate.OnRemoveTweenFinish then
          self._delegate:OnRemoveTweenFinish()
        end
      else
        self._totalLength = self._removeTolTask.subject.pos
      end
    end
    if self._moveTopTask then
      if self._moveTopTask:update(deltaTime) then
        self._currentPosition = self._totalLength - height + self._upMargin
        self._moveTopTask = nil
      else
        self._currentPosition = self._moveTopTask.subject.pos
      end
    end
    if self._moveBottomTask then
      if self._moveBottomTask:update(deltaTime) then
        self._currentPosition = 0 - self._downMargin
        self._moveBottomTask = nil
      else
        self._currentPosition = self._moveBottomTask.subject.pos
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
    if self._moveTopIndexTask then
      if self._moveTopIndexTask:update(deltaTime) then
        self._currentPosition = self._moveTopIndexDes
        self._moveTopIndexTask = nil
      else
        self._currentPosition = self._moveTopIndexTask.subject.pos
      end
    end
    self:UpdateView(deltaTime)
  end
end

return TaskTableFrame
