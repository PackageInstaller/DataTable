-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/frame/table/horizontaltableframeinverseimpl.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local LogicCell = require("framework.ui.frame.table.logiccell")
local AutoAlignMaxSpeed = 10
local HorizontalTableFrameInverseImpl = class("HorizontalTableFrameInverseImpl")
HorizontalTableFrameInverseImpl.Ctor = function(self, interface, container, delegate, canSlide, autoAlign, viewportName)
  -- function num : 0_0 , upvalues : _ENV, UIManager
  self._interface = interface
  self._container = container
  self._delegate = delegate
  self._canSlide = canSlide
  self._autoAlign = autoAlign
  self._recycleCells = {}
  self._logicCells = {}
  self._baseCells = {}
  if (((((CS.PixelNeko).Lua).UI).FrameStaticFunctions).GetFrameChildCount)(container._uiObject) > 0 then
    LogErrorFormat("HorizontalTableFrameInverseImpl", "非法操作: container [%s] 已经创建过frame Viewport", container._uiObject)
  end
  self._viewport = (UIManager.CreateLuaWindow)("ui/widgets.assetbundle", viewportName, container._uiObject)
  ;
  (((((CS.PixelNeko).Lua).UI).FrameStaticFunctions).AddFrameChild)(container._uiObject, (self._viewport)._uiObject)
  self._viewcontainer = (UIManager.GetChildLuaWindow)((self._viewport)._uiObject, "_Containter")
  if self._canSlide then
    self._beginDragHandler = (self._viewport):Subscribe_BeginDragEvent(self.OnBeginDrag, self)
    self._dragHandler = (self._viewport):Subscribe_DragEvent(self.OnDrag, self)
    self._endDragHandler = (self._viewport):Subscribe_EndDragEvent(self.OnEndDrag, self)
    self._cancelDragHandler = (self._viewport):Subscribe_CancelDragEvent(self.OnEndDrag, self)
  end
  ;
  (self._viewport):Subscribe_PointerDownEvent(self.OnPointerDown, self)
  ;
  (self._viewport):Subscribe_PointerUpEvent(self.OnPointerUp, self)
  ;
  (self._viewport):Subscribe_PointerCancelEvent(self.OnPointerUp, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnLateUpdate, Common.n_LateUpdate, nil)
  local _ = 0
  -- DECOMPILER ERROR at PC105: Overwrote pending register: R7 in 'AssignReg'

  self._upMargin = (((((CS.PixelNeko).Lua).UI).FrameStaticFunctions).GetMargin)(container._uiObject)
  self._currentPosition = 0
  self._dragDelta = 0
  self._totalLength = 0
  self._needUpdate = false
  self._sprintTask = nil
  self._slideInertiaTask = nil
  self._insertTask = {}
  self._insertDes = {}
  self._removeTask = {}
  self._removeDes = {}
  self._removeCurTask = nil
  self._removeCurDes = nil
  self._removeTolTask = nil
  self._removeTolDes = nil
  self._moveLeftTask = nil
  self._moveRightTask = nil
  self._moveRightIndexTask = nil
  self._moveLeftIndexTask = nil
  self._moveRightIndexDes = nil
  self._moveLeftIndexDes = nil
  self._leftIndex = nil
  self._rightIndex = nil
  self._alignTask = nil
  self._alignDes = nil
  self._moveToAssignedPosTask = nil
  self._moveToAssignedPosDes = nil
end

HorizontalTableFrameInverseImpl.Destroy = function(self)
  -- function num : 0_1 , upvalues : _ENV, UIManager
  if self._baseCells then
    for i,cell in pairs(self._baseCells) do
      (UIManager.Destroy)(cell._uiObject)
    end
  end
  do
    for i,logicCell in ipairs(self._logicCells) do
      if logicCell._cell then
        self:RecycleCell(logicCell)
      end
    end
    self._logicCells = {}
    self._currentPosition = 0
    self._totalLength = 0
    for k,cells in pairs(self._recycleCells) do
      for i,cell in ipairs(cells) do
        cell:Destroy()
        cell:RootWindowDestroy()
      end
    end
    self._recycleCells = {}
    ;
    (((((CS.PixelNeko).Lua).UI).FrameStaticFunctions).RemoveFrameChild)((self._container)._uiObject, (self._viewport)._uiObject)
    ;
    ((((CS.PixelNeko).UI).UIManager).Destroy)((self._viewport)._uiObject)
    ;
    (LuaNotificationCenter.RemoveObserver)(self)
  end
end

HorizontalTableFrameInverseImpl.ReloadAllCell = function(self)
  -- function num : 0_2 , upvalues : _ENV, LogicCell, UIManager
  for i,logicCell in ipairs(self._logicCells) do
    if logicCell._cell then
      self:RecycleCell(logicCell)
    end
  end
  self._logicCells = {}
  self._currentPosition = 0 - self._leftMargin
  self._totalLength = 0
  self._needUpdate = true
  local cellNums = (self._delegate):NumberOfCell(self._interface)
  for i = 1, cellNums do
    local logicCell = (LogicCell.Create)()
    logicCell._dialogName = (self._delegate):CellAtIndex(self._interface, i)
    do
      do
        if not (self._baseCells)[logicCell._dialogName] then
          local dialogDefine = require("logic.dialog." .. logicCell._dialogName)
          -- DECOMPILER ERROR at PC55: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (self._baseCells)[logicCell._dialogName] = (UIManager.CreateLuaWindow)(dialogDefine.AssetBundleName .. ".assetbundle", dialogDefine.AssetName, (self._viewcontainer)._uiObject)
          ;
          ((self._baseCells)[logicCell._dialogName]):SetPosition(0, -10000, 0, 0)
        end
        logicCell._data = (self._delegate):DataAtIndex(self._interface, i)
        -- DECOMPILER ERROR at PC72: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (self._logicCells)[i] = logicCell
        -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  local tempSize = {}
  for i = cellNums, 1, -1 do
    local logicCell = (self._logicCells)[i]
    if not (self._delegate).ShouldLengthChange or not (self._delegate):ShouldLengthChange(self._interface, i) then
      if not tempSize[logicCell._dialogName] then
        self:GetCellDialog(logicCell)
        -- DECOMPILER ERROR at PC101: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (logicCell._cell)._delegate = self._delegate
        -- DECOMPILER ERROR at PC104: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (logicCell._cell)._cellData = logicCell._data
        ;
        (logicCell._cell):RefreshCell(logicCell._data)
        local _ = 0
        tempSize[logicCell._dialogName] = ((logicCell._cell):GetRootWindow()):GetRectSize()
        self:RecycleCell(logicCell)
      end
      do
        -- DECOMPILER ERROR at PC121: Overwrote pending register: R8 in 'AssignReg'

        logicCell._size = tempSize[_]
        self:GetCellDialog(logicCell)
        -- DECOMPILER ERROR at PC130: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (logicCell._cell)._delegate = self._delegate
        -- DECOMPILER ERROR at PC133: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (logicCell._cell)._cellData = logicCell._data
        ;
        (logicCell._cell):RefreshCell(logicCell._data)
        do
          do
            local w, h = ((logicCell._cell):GetRootWindow()):GetRectSize()
            self:RecycleCell(logicCell)
            logicCell._size = w
            logicCell._pos = self._totalLength
            self._totalLength = self._totalLength + logicCell._size
            -- DECOMPILER ERROR at PC153: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC153: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC153: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC153: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  self:UpdateView(0)
end

HorizontalTableFrameInverseImpl.MoveToRight = function(self, isAnimate)
  -- function num : 0_3 , upvalues : _ENV
  self._needUpdate = true
  local width, height = (self._viewport):GetRectSize()
  if width <= self._totalLength then
    if isAnimate then
      local first = {pos = self._currentPosition}
      local last = {pos = self._totalLength - width + self._rightMargin}
      self._moveLeftTask = (Tween.new)(0.5, first, last, "outQuad")
    else
      do
        self:ClearAllPositionChangeTask()
        self._currentPosition = self._totalLength - width + self._rightMargin
      end
    end
  end
end

HorizontalTableFrameInverseImpl.MoveToLeft = function(self, isAnimate)
  -- function num : 0_4 , upvalues : _ENV
  self._needUpdate = true
  if isAnimate then
    local first = {pos = self._currentPosition}
    local last = {pos = 0 - self._leftMargin}
    self._moveRightTask = (Tween.new)(0.5, first, last, "outQuad")
  else
    do
      self:ClearAllPositionChangeTask()
      self._currentPosition = 0 - self._leftMargin
    end
  end
end

HorizontalTableFrameInverseImpl.MoveRightToIndex = function(self, desIndex, isAnimate)
  -- function num : 0_5 , upvalues : _ENV
  self._needUpdate = true
  self._moveLeftIndexTask = nil
  self._slideInertiaTask = nil
  if self._moveRightIndexTask then
    self._currentPosition = self._moveRightIndexDes
  end
  local destination = ((self._logicCells)[desIndex])._pos
  local width, height = (self._viewport):GetRectSize()
  if self._totalLength - width + self._rightMargin < destination then
    destination = self._totalLength - width + self._rightMargin
  else
    destination = destination - self._rightMargin
  end
  if destination < 0 - self._leftMargin then
    destination = 0 - self._leftMargin
  end
  self._moveRightIndexDes = destination
  if isAnimate then
    local first = {pos = self._currentPosition}
    local last = {pos = destination}
    self._moveRightIndexTask = (Tween.new)(0.5, first, last, "linear")
  else
    do
      self:ClearAllPositionChangeTask()
      self._currentPosition = destination
    end
  end
end

HorizontalTableFrameInverseImpl.MoveIndexToCentreInTime = function(self, desIndex, time)
  -- function num : 0_6 , upvalues : _ENV
  self._needUpdate = true
  self._moveRightIndexTask = nil
  self._slideInertiaTask = nil
  if self._moveLeftIndexTask then
    self._currentPosition = self._moveLeftIndexDes
  end
  local destination = ((self._logicCells)[desIndex])._pos
  local logicCellWidth = ((self._logicCells)[desIndex])._size
  local width, height = (self._viewport):GetRectSize()
  local halfShowPos = width / 2
  destination = destination - halfShowPos + logicCellWidth / 2
  if self._totalLength - width + self._rightMargin < destination then
    destination = self._totalLength - width + self._rightMargin
  else
    destination = destination + self._leftMargin
  end
  if destination < 0 - self._leftMargin then
    destination = 0 - self._leftMargin
  end
  self._moveLeftIndexDes = destination
  local first = {pos = self._currentPosition}
  local last = {pos = destination}
  self._moveLeftIndexTask = (Tween.new)(time, first, last, "linear")
end

HorizontalTableFrameInverseImpl.MoveLeftToIndex = function(self, desIndex, isAnimate)
  -- function num : 0_7 , upvalues : _ENV
  self._needUpdate = true
  self._moveRightIndexTask = nil
  self._slideInertiaTask = nil
  if self._moveLeftIndexTask then
    self._currentPosition = self._moveLeftIndexDes
  end
  local width, height = (self._viewport):GetRectSize()
  local destination = ((self._logicCells)[desIndex])._pos + ((self._logicCells)[desIndex])._size - width
  if self._totalLength - width + self._rightMargin < destination then
    destination = self._totalLength - width + self._rightMargin
  else
    destination = destination + self._leftMargin
  end
  if destination < 0 - self._leftMargin then
    destination = 0 - self._leftMargin
  end
  self._moveLeftIndexDes = destination
  if isAnimate then
    local first = {pos = self._currentPosition}
    local last = {pos = destination}
    self._moveLeftIndexTask = (Tween.new)(0.5, first, last, "linear")
  else
    do
      self:ClearAllPositionChangeTask()
      self._currentPosition = destination
    end
  end
end

HorizontalTableFrameInverseImpl.MoveToAssignedPos = function(self, pos, isAnimate)
  -- function num : 0_8 , upvalues : _ENV
  self._needUpdate = true
  self._moveToAssignedPosDes = pos
  if isAnimate then
    local first = {pos = self._currentPosition}
    local last = {pos = self._moveToAssignedPosDes}
    self._moveToAssignedPosTask = (Tween.new)(0.5, first, last, "linear")
  else
    do
      self:ClearAllPositionChangeTask()
      self._currentPosition = pos
    end
  end
end

HorizontalTableFrameInverseImpl.GetTotalLength = function(self)
  -- function num : 0_9
  return self._totalLength
end

HorizontalTableFrameInverseImpl.GetCurrentPosition = function(self)
  -- function num : 0_10
  return self._currentPosition
end

HorizontalTableFrameInverseImpl.ReloadCellsAtIndex = function(self, indexList, isAnimate)
  -- function num : 0_11 , upvalues : _ENV, UIManager
  if type(indexList) ~= "table" then
    LogError("HorizontalTableFrameInverseImpl", "please input a table value")
    return 
  end
  local cellNums = (self._delegate):NumberOfCell(self._interface)
  for _,index in pairs(indexList) do
    if not index or cellNums < index then
      LogErrorFormat("HorizontalTableFrameInverseImpl", "the index %d is out of range", index)
      return 
    end
    local logicCell = (self._logicCells)[index]
    logicCell._dialogName = (self._delegate):CellAtIndex(self._interface, index)
    do
      if not (self._baseCells)[logicCell._dialogName] then
        local dialogDefine = require("logic.dialog." .. logicCell._dialogName)
        -- DECOMPILER ERROR at PC56: Confused about usage of register: R11 in 'UnsetPending'

        ;
        (self._baseCells)[logicCell._dialogName] = (UIManager.CreateLuaWindow)(dialogDefine.AssetBundleName .. ".assetbundle", dialogDefine.AssetName, (self._viewcontainer)._uiObject)
        ;
        ((self._baseCells)[logicCell._dialogName]):SetPosition(0, -10000, 0, 0)
      end
      logicCell._data = (self._delegate):DataAtIndex(self._interface, index)
      self:GetCellDialog(logicCell)
      -- DECOMPILER ERROR at PC77: Confused about usage of register: R10 in 'UnsetPending'

      ;
      (logicCell._cell)._delegate = self._delegate
      -- DECOMPILER ERROR at PC80: Confused about usage of register: R10 in 'UnsetPending'

      ;
      (logicCell._cell)._cellData = logicCell._data
      ;
      (logicCell._cell):RefreshCell(logicCell._data)
      local _, h = ((logicCell._cell):GetRootWindow()):GetRectSize()
      self:RecycleCell(logicCell)
      local delta = h - logicCell._size
      logicCell._size = h
      -- DECOMPILER ERROR at PC97: Confused about usage of register: R13 in 'UnsetPending'

      ;
      (self._logicCells)[index] = logicCell
      for i = 1, index - 1 do
        -- DECOMPILER ERROR at PC108: Confused about usage of register: R17 in 'UnsetPending'

        ((self._logicCells)[i])._pos = ((self._logicCells)[i])._pos + delta
      end
      local width, height = (self._viewport):GetRectSize()
      local topDelta = self._totalLength - width - self._currentPosition
      local totalHasChange = false
      if topDelta < delta or self._totalLength < width then
        self._totalLength = self._totalLength + delta
        totalHasChange = true
      end
      local curValue = self._currentPosition - self._currentPosition % 0.01
      do
        local latestValue = 0 - self._leftMargin - (0 - self._leftMargin) % 0.01
        if curValue ~= latestValue then
          self._currentPosition = self._currentPosition + delta
          if width < self._totalLength + self._rightMargin and self._totalLength + self._rightMargin - width < self._currentPosition then
            self._currentPosition = self._totalLength + self._rightMargin - width
          end
          if self._currentPosition < 0 - self._leftMargin then
            self._currentPosition = 0 - self._leftMargin
          end
        end
        if not totalHasChange then
          self._totalLength = self._totalLength + delta
        end
        self._needUpdate = true
        -- DECOMPILER ERROR at PC173: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  self:UpdateView(0)
end

HorizontalTableFrameInverseImpl.RemoveCellsAtIndex = function(self, indexList, isAnimate)
  -- function num : 0_12 , upvalues : _ENV
  if type(indexList) ~= "table" then
    LogError("HorizontalTableFrameInverseImpl", "please input a table value")
    return 
  end
  self._needUpdate = true
  local cellNums = #self._logicCells
  local width, height = (self._viewport):GetRectSize()
  local currentPosition = self._currentPosition
  for _,index in pairs(indexList) do
    if cellNums < index then
      LogErrorFormat("HorizontalTableFrameInverseImpl", "Wrong index %d", index)
      return 
    end
    local gap = ((self._logicCells)[index])._size
    local pos = ((self._logicCells)[index])._pos
    self:RecycleCell((self._logicCells)[index])
    if #self._insertTask ~= 0 then
      for i,task in pairs(self._insertTask) do
        local logicCell = (self._logicCells)[i]
        logicCell._pos = (self._insertDes)[i]
        -- DECOMPILER ERROR at PC53: Confused about usage of register: R20 in 'UnsetPending'

        ;
        (self._insertDes)[i] = nil
        -- DECOMPILER ERROR at PC55: Confused about usage of register: R20 in 'UnsetPending'

        ;
        (self._insertTask)[i] = nil
      end
    end
    do
      if #self._removeTask ~= 0 then
        for i,task in pairs(self._removeTask) do
          -- DECOMPILER ERROR at PC70: Confused about usage of register: R19 in 'UnsetPending'

          ((self._logicCells)[i])._pos = (self._removeDes)[i]
          -- DECOMPILER ERROR at PC72: Confused about usage of register: R19 in 'UnsetPending'

          ;
          (self._removeDes)[i] = nil
          -- DECOMPILER ERROR at PC74: Confused about usage of register: R19 in 'UnsetPending'

          ;
          (self._removeTask)[i] = nil
        end
      end
      do
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
        if currentPosition < pos + gap and pos < currentPosition + width then
          if isAnimate then
            self._removeTask = {}
            for i = 1, index - 1 do
              -- DECOMPILER ERROR at PC111: Confused about usage of register: R19 in 'UnsetPending'

              (self._removeDes)[i] = ((self._logicCells)[i])._pos - gap
              local first = {pos = ((self._logicCells)[i])._pos}
              local last = {pos = (self._removeDes)[i]}
              -- DECOMPILER ERROR at PC129: Confused about usage of register: R21 in 'UnsetPending'

              ;
              (self._removeTask)[i] = (Tween.new)(0.1, first, last, "linear")
              self._needUpdate = true
            end
            local delta = self._totalLength - width - currentPosition
            if delta < gap or self._totalLength < width then
              self._removeTolDes = self._totalLength - gap
              local first = {pos = self._totalLength}
              local last = {pos = self._removeTolDes}
              self._removeTolTask = (Tween.new)(0.1, first, last, "linear")
              self._needUpdate = true
              totalHasChange = true
            end
            do
              local curValue = currentPosition - currentPosition % 0.01
              local latestValue = 0 - self._leftMargin - (0 - self._leftMargin) % 0.01
              if curValue ~= latestValue then
                self._removeCurDes = self._currentPosition - gap
                local first = {pos = self._currentPosition}
                local last = {pos = self._removeCurDes}
                self._removeCurTask = (Tween.new)(0.1, first, last, "linear")
              end
              do
                local delta = self._totalLength - width - currentPosition
                if delta < gap or self._totalLength < width then
                  self._totalLength = self._totalLength - gap
                  totalHasChange = true
                end
                local curValue = currentPosition - currentPosition % 0.01
                do
                  local latestValue = 0 - self._leftMargin - (0 - self._leftMargin) % 0.01
                  if curValue ~= latestValue then
                    self._currentPosition = self._currentPosition - gap
                    if width < self._totalLength + self._rightMargin and self._totalLength + self._rightMargin - width < self._currentPosition then
                      self._currentPosition = self._totalLength + self._rightMargin - width
                    end
                    if self._currentPosition < 0 - self._leftMargin then
                      self._currentPosition = 0 - self._leftMargin
                    end
                  end
                  for i = 1, index - 1 do
                    -- DECOMPILER ERROR at PC248: Confused about usage of register: R19 in 'UnsetPending'

                    ((self._logicCells)[i])._pos = ((self._logicCells)[i])._pos - gap
                  end
                  local curValue = currentPosition - currentPosition % 0.01
                  do
                    do
                      local latestValue = 0 - self._leftMargin - (0 - self._leftMargin) % 0.01
                      if curValue ~= latestValue then
                        self._currentPosition = self._currentPosition - gap
                        if width < self._totalLength + self._rightMargin and self._totalLength + self._rightMargin - width < self._currentPosition then
                          self._currentPosition = self._totalLength + self._rightMargin - width
                        end
                        if self._currentPosition < 0 - self._leftMargin then
                          self._currentPosition = 0 - self._leftMargin
                        end
                      end
                      ;
                      (table.remove)(self._logicCells, index)
                      if not totalHasChange then
                        self._totalLength = self._totalLength - gap
                      end
                      -- DECOMPILER ERROR at PC298: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC298: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC298: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC298: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC298: LeaveBlock: unexpected jumping out IF_THEN_STMT

                      -- DECOMPILER ERROR at PC298: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC298: LeaveBlock: unexpected jumping out IF_THEN_STMT

                      -- DECOMPILER ERROR at PC298: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC298: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC298: LeaveBlock: unexpected jumping out DO_STMT

                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

HorizontalTableFrameInverseImpl.InsertCellsAtIndex = function(self, indexList, isAnimate, dontMoveCurrentPosition)
  -- function num : 0_13 , upvalues : _ENV, LogicCell, UIManager
  if indexList and type(indexList) ~= "table" then
    LogError("HorizontalTableFrameInverseImpl", "please input a table value")
    return 
  end
  local cellNums = #self._logicCells
  self._needUpdate = true
  local lastinsert = false
  if not indexList or #indexList == 0 then
    indexList = {}
    if cellNums + 1 <= (self._delegate):NumberOfCell(self._interface) then
      for i = cellNums + 1, (self._delegate):NumberOfCell(self._interface) do
        (table.insert)(indexList, i)
      end
      lastinsert = true
    else
      LogError("HorizontalTableFrameInverseImpl", "no additional data")
      return 
    end
  end
  for _,index in pairs(indexList) do
    cellNums = #self._logicCells
    if not index or cellNums + 1 < index and not lastinsert then
      LogErrorFormat("HorizontalTableFrameInverseImpl", "Wrong index %d", index)
      return 
    end
    local logicCell = (LogicCell.Create)()
    logicCell._dialogName = (self._delegate):CellAtIndex(self._interface, index)
    do
      if not (self._baseCells)[logicCell._dialogName] then
        local dialogDefine = require("logic.dialog." .. logicCell._dialogName)
        -- DECOMPILER ERROR at PC97: Confused about usage of register: R13 in 'UnsetPending'

        ;
        (self._baseCells)[logicCell._dialogName] = (UIManager.CreateLuaWindow)(dialogDefine.AssetBundleName .. ".assetbundle", dialogDefine.AssetName, (self._viewcontainer)._uiObject)
        ;
        ((self._baseCells)[logicCell._dialogName]):SetPosition(0, -10000, 0, 0)
      end
      logicCell._data = (self._delegate):DataAtIndex(self._interface, index)
      local tempSize = {}
      local width, height = (self._viewport):GetRectSize()
      if not (self._delegate).ShouldLengthChange or not (self._delegate):ShouldLengthChange(self._interface, i) then
        if not tempSize[logicCell._dialogName] then
          self:GetCellDialog(logicCell)
          -- DECOMPILER ERROR at PC137: Confused about usage of register: R15 in 'UnsetPending'

          ;
          (logicCell._cell)._delegate = self._delegate
          -- DECOMPILER ERROR at PC140: Confused about usage of register: R15 in 'UnsetPending'

          ;
          (logicCell._cell)._cellData = logicCell._data
          ;
          (logicCell._cell):RefreshCell(logicCell._data)
          local _ = 0
          _ = ((logicCell._cell):GetRootWindow()):GetRectSize()
          self:RecycleCell(logicCell)
        end
        do
          logicCell._size = tempSize[logicCell._dialogName]
          self:GetCellDialog(logicCell)
          -- DECOMPILER ERROR at PC166: Confused about usage of register: R15 in 'UnsetPending'

          ;
          (logicCell._cell)._delegate = self._delegate
          -- DECOMPILER ERROR at PC169: Confused about usage of register: R15 in 'UnsetPending'

          ;
          (logicCell._cell)._cellData = logicCell._data
          ;
          (logicCell._cell):RefreshCell(logicCell._data)
          do
            local w, h = ((logicCell._cell):GetRootWindow()):GetRectSize()
            self:RecycleCell(logicCell)
            logicCell._size = h
            if #self._removeTask ~= 0 then
              for i,task in pairs(self._removeTask) do
                -- DECOMPILER ERROR at PC195: Confused about usage of register: R20 in 'UnsetPending'

                ((self._logicCells)[i])._pos = (self._removeDes)[i]
                -- DECOMPILER ERROR at PC197: Confused about usage of register: R20 in 'UnsetPending'

                ;
                (self._removeDes)[i] = nil
                -- DECOMPILER ERROR at PC199: Confused about usage of register: R20 in 'UnsetPending'

                ;
                (self._removeTask)[i] = nil
              end
            end
            do
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
                for i,task in pairs(self._insertTask) do
                  local logicCell = (self._logicCells)[i]
                  logicCell._pos = (self._insertDes)[i]
                  -- DECOMPILER ERROR at PC230: Confused about usage of register: R21 in 'UnsetPending'

                  ;
                  (self._insertDes)[i] = nil
                  -- DECOMPILER ERROR at PC232: Confused about usage of register: R21 in 'UnsetPending'

                  ;
                  (self._insertTask)[i] = nil
                end
              end
              do
                ;
                (table.insert)(self._logicCells, index, logicCell)
                local curValue = self._currentPosition - self._currentPosition % 0.01
                local latestValue = -self._leftMargin - (0 - self._leftMargin) % 0.01
                if curValue == latestValue and isAnimate then
                  self._insertTask = {}
                  for i = 1, index - 1 do
                    -- DECOMPILER ERROR at PC272: Confused about usage of register: R21 in 'UnsetPending'

                    if width < self._totalLength + logicCell._size then
                      (self._insertDes)[i] = ((self._logicCells)[i])._pos + logicCell._size
                      local first = {pos = ((self._logicCells)[i])._pos}
                      local last = {pos = (self._insertDes)[i]}
                      -- DECOMPILER ERROR at PC290: Confused about usage of register: R23 in 'UnsetPending'

                      ;
                      (self._insertTask)[i] = (Tween.new)(0.2, first, last, "linear")
                      self._needUpdate = true
                    else
                      do
                        do
                          -- DECOMPILER ERROR at PC300: Confused about usage of register: R21 in 'UnsetPending'

                          ;
                          ((self._logicCells)[i])._pos = ((self._logicCells)[i])._pos + logicCell._size
                          -- DECOMPILER ERROR at PC301: LeaveBlock: unexpected jumping out DO_STMT

                          -- DECOMPILER ERROR at PC301: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                          -- DECOMPILER ERROR at PC301: LeaveBlock: unexpected jumping out IF_STMT

                        end
                      end
                    end
                  end
                  -- DECOMPILER ERROR at PC318: Confused about usage of register: R17 in 'UnsetPending'

                  if #self._insertTask ~= 0 then
                    if index <= cellNums then
                      (self._insertDes)[index] = ((self._logicCells)[index + 1])._pos + ((self._logicCells)[index + 1])._size
                      local first = {pos = ((self._logicCells)[index + 1])._pos}
                      local last = {pos = (self._insertDes)[index]}
                      -- DECOMPILER ERROR at PC337: Confused about usage of register: R19 in 'UnsetPending'

                      ;
                      (self._insertTask)[index] = (Tween.new)(0.2, first, last, "linear")
                    else
                      do
                        -- DECOMPILER ERROR at PC340: Confused about usage of register: R17 in 'UnsetPending'

                        ;
                        (self._insertDes)[index] = 0
                        local first = {pos = -((self._logicCells)[index])._size}
                        do
                          do
                            local last = {pos = (self._insertDes)[index]}
                            -- DECOMPILER ERROR at PC359: Confused about usage of register: R19 in 'UnsetPending'

                            ;
                            (self._insertTask)[index] = (Tween.new)(0.2, first, last, "linear")
                            self._needUpdate = true
                            -- DECOMPILER ERROR at PC375: Confused about usage of register: R17 in 'UnsetPending'

                            if index <= cellNums then
                              ((self._logicCells)[index])._pos = ((self._logicCells)[index + 1])._pos + ((self._logicCells)[index + 1])._size
                            else
                              -- DECOMPILER ERROR at PC379: Confused about usage of register: R17 in 'UnsetPending'

                              ;
                              ((self._logicCells)[index])._pos = 0
                            end
                            for i = 1, index - 1 do
                              -- DECOMPILER ERROR at PC392: Confused about usage of register: R21 in 'UnsetPending'

                              ((self._logicCells)[i])._pos = ((self._logicCells)[i])._pos + logicCell._size
                            end
                            -- DECOMPILER ERROR at PC407: Confused about usage of register: R17 in 'UnsetPending'

                            if index <= cellNums then
                              ((self._logicCells)[index])._pos = ((self._logicCells)[index + 1])._pos + ((self._logicCells)[index + 1])._size
                            else
                              -- DECOMPILER ERROR at PC411: Confused about usage of register: R17 in 'UnsetPending'

                              ;
                              ((self._logicCells)[index])._pos = 0
                            end
                            self._totalLength = self._totalLength + logicCell._size
                            if not dontMoveCurrentPosition and curValue ~= latestValue then
                              self._currentPosition = self._currentPosition + logicCell._size
                            end
                            -- DECOMPILER ERROR at PC424: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC424: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC424: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                            -- DECOMPILER ERROR at PC424: LeaveBlock: unexpected jumping out IF_STMT

                            -- DECOMPILER ERROR at PC424: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC424: LeaveBlock: unexpected jumping out IF_STMT

                            -- DECOMPILER ERROR at PC424: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC424: LeaveBlock: unexpected jumping out IF_STMT

                            -- DECOMPILER ERROR at PC424: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC424: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC424: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC424: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC424: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC424: LeaveBlock: unexpected jumping out IF_STMT

                            -- DECOMPILER ERROR at PC424: LeaveBlock: unexpected jumping out DO_STMT

                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

HorizontalTableFrameInverseImpl.FireEvent = function(self, eventName, ...)
  -- function num : 0_14 , upvalues : _ENV
  for i,logicCell in ipairs(self._logicCells) do
    if logicCell._cell and (logicCell._cell).OnEvent then
      (logicCell._cell):OnEvent(eventName, ...)
    end
  end
end

HorizontalTableFrameInverseImpl.GetLeftIndex = function(self)
  -- function num : 0_15
  return self._leftIndex
end

HorizontalTableFrameInverseImpl.GetRightIndex = function(self)
  -- function num : 0_16
  return self._rightIndex
end

HorizontalTableFrameInverseImpl.SetMargin = function(self, leftValue, rightValue)
  -- function num : 0_17
  if self._leftMargin == 0 then
    self._leftMargin = leftValue
  end
  if self._rightMargin == 0 then
    self._rightMargin = rightValue
  end
end

HorizontalTableFrameInverseImpl.OnBeginDrag = function(self, args)
  -- function num : 0_18
  self._dragDelta = 0
  self._slideInertiaTime = 0.8
  self._sprintTime = 0.3
  self._slideInertiaTask = nil
  self._sprintTask = nil
  self._sprintclickdown = false
  ;
  (self._viewcontainer):SetBlocksRaycasts(false)
  self._moveSpeed = {x = 0, y = 0}
  if (self._delegate).OnFrameBeginDrag then
    (self._delegate):OnFrameBeginDrag(self._interface)
  end
end

HorizontalTableFrameInverseImpl.OnDrag = function(self, args)
  -- function num : 0_19 , upvalues : UIManager
  local pressPosition = args.pressPosition
  local position = args.position
  local localPressX, _ = (UIManager.ScreenPointToLocalPointInRectangle)((self._viewport)._uiObject, pressPosition.x, pressPosition.y)
  local localX, _ = (UIManager.ScreenPointToLocalPointInRectangle)((self._viewport)._uiObject, position.x, position.y)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self._moveSpeed).x = args.xSpeed / 60
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self._moveSpeed).y = args.ySpeed / 60
  local currentPosition = self._currentPosition
  self._currentPosition = currentPosition + self._dragDelta
  self._dragDelta = localX - localPressX
  self._currentPosition = self._currentPosition - self._dragDelta
  if currentPosition ~= self._currentPosition then
    self._needUpdate = true
    self:UpdateView(0)
  end
end

HorizontalTableFrameInverseImpl.OnEndDrag = function(self, args)
  -- function num : 0_20 , upvalues : UIManager, _ENV, AutoAlignMaxSpeed
  local dragDelta = self._dragDelta
  self._dragDelta = 0
  local original, _ = (UIManager.ScreenPointToLocalPointInRectangle)((self._viewport)._uiObject, 0, 0)
  local speed, _ = (UIManager.ScreenPointToLocalPointInRectangle)((self._viewport)._uiObject, (self._moveSpeed).x, (self._moveSpeed).y)
  speed = speed - original
  local currentPosition = self._currentPosition
  local width, height = (self._viewport):GetRectSize()
  if speed == 0 then
    (self._viewcontainer):SetBlocksRaycasts(true)
    if self._autoAlign then
      if dragDelta < 0 then
        self._needUpdate = true
        local half = ((self._logicCells)[self._leftIndex])._pos + ((self._logicCells)[self._leftIndex])._size / 2
        if self._currentPosition + width < half then
          local first = {pos = self._currentPosition}
          local cellNums = #self._logicCells
          if self._leftIndex + 1 <= cellNums then
            self._alignDes = ((self._logicCells)[self._leftIndex + 1])._pos + ((self._logicCells)[self._leftIndex + 1])._size - width
            local last = {pos = self._alignDes}
            self._alignTask = (Tween.new)(0.2, first, last, "outQuad")
          end
        else
          do
            if half <= self._currentPosition + width then
              local first = {pos = self._currentPosition}
              self._alignDes = ((self._logicCells)[self._leftIndex])._pos + ((self._logicCells)[self._leftIndex])._size - width
              local last = {pos = self._alignDes}
              self._alignTask = (Tween.new)(0.2, first, last, "outQuad")
            end
            do
              if dragDelta > 0 then
                self._needUpdate = true
                local half = ((self._logicCells)[self._rightIndex])._pos + ((self._logicCells)[self._rightIndex])._size / 2
                if self._currentPosition <= half then
                  local first = {pos = self._currentPosition}
                  self._alignDes = ((self._logicCells)[self._rightIndex])._pos
                  local last = {pos = self._alignDes}
                  self._alignTask = (Tween.new)(0.2, first, last, "outQuad")
                else
                  do
                    if half < self._currentPosition then
                      local first = {pos = self._currentPosition}
                      if self._rightIndex - 1 > 0 then
                        self._alignDes = ((self._logicCells)[self._rightIndex - 1])._pos
                        local last = {pos = self._alignDes}
                        self._alignTask = (Tween.new)(0.2, first, last, "outQuad")
                      end
                    end
                    do
                      if currentPosition + width <= self._totalLength + self._rightMargin and 0 - self._leftMargin <= currentPosition then
                        if self._autoAlign then
                          if speed < -AutoAlignMaxSpeed or AutoAlignMaxSpeed < speed then
                            if dragDelta < 0 then
                              self._needUpdate = true
                              local first = {pos = self._currentPosition}
                              self._alignDes = ((self._logicCells)[self._leftIndex])._pos
                              local last = {pos = self._alignDes}
                              self._alignTask = (Tween.new)(0.5, first, last, "outQuad")
                            else
                              do
                                if dragDelta > 0 then
                                  self._needUpdate = true
                                  local first = {pos = self._currentPosition}
                                  self._alignDes = ((self._logicCells)[self._rightIndex])._pos + ((self._logicCells)[self._rightIndex])._size - width
                                  local last = {pos = self._alignDes}
                                  self._alignTask = (Tween.new)(0.5, first, last, "outQuad")
                                end
                                do
                                  ;
                                  (self._viewcontainer):SetBlocksRaycasts(true)
                                  self._needUpdate = true
                                  self._slideInertiaPosition = currentPosition
                                  self._slideInertiaSpeed = (speed) * 20
                                  self._sprintTask = nil
                                  self._sprintPosition = nil
                                  local lenofend = (speed) * 20 * self._slideInertiaTime / 2
                                  currentPosition = currentPosition - lenofend
                                  if self._totalLength - width + width / 3 + self._rightMargin < currentPosition then
                                    currentPosition = self._totalLength - width + width / 3 + self._rightMargin
                                    lenofend = self._slideInertiaPosition - (currentPosition)
                                    self._slideInertiaTime = (lenofend) * 2 / self._slideInertiaSpeed
                                  end
                                  if currentPosition < -width / 3 - self._leftMargin then
                                    currentPosition = -width / 3 - self._leftMargin
                                    lenofend = self._slideInertiaPosition - (currentPosition)
                                    self._slideInertiaTime = (lenofend) * 2 / self._slideInertiaSpeed
                                  end
                                  local first = {pos = self._slideInertiaSpeed}
                                  do
                                    local last = {pos = 0}
                                    self._slideInertiaTask = (Tween.new)(self._slideInertiaTime, first, last, "linear")
                                    if self._totalLength + self._rightMargin < currentPosition + width then
                                      self._sprintPosition = currentPosition
                                      self._needUpdate = true
                                      local lenofend = currentPosition - self._totalLength + width - self._rightMargin
                                      if self._totalLength + self._rightMargin < width then
                                        lenofend = currentPosition + self._leftMargin
                                      end
                                      self._sprintSpeed = (lenofend) * 2 / self._sprintTime
                                      local first = {pos = self._sprintSpeed}
                                      local last = {pos = 0}
                                      self._sprintTask = (Tween.new)(self._sprintTime, first, last, "linear")
                                      if self._alignTask then
                                        self._alignTask = nil
                                      end
                                    end
                                    do
                                      if currentPosition < 0 - self._leftMargin then
                                        self._sprintPosition = currentPosition
                                        self._needUpdate = true
                                        local lenofend = currentPosition + self._leftMargin
                                        self._sprintSpeed = lenofend * 2 / self._sprintTime
                                        local first = {pos = self._sprintSpeed}
                                        local last = {pos = 0}
                                        self._sprintTask = (Tween.new)(self._sprintTime, first, last, "linear")
                                        if self._alignTask then
                                          self._alignTask = nil
                                        end
                                      end
                                      do
                                        if (self._delegate).OnFrameEndDrag then
                                          (self._delegate):OnFrameEndDrag(self._interface)
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

HorizontalTableFrameInverseImpl.OnPointerDown = function(self, args)
  -- function num : 0_21 , upvalues : _ENV
  self._dragDelta = 0
  if self._slideInertiaTask then
    self._slideInertiaTask = nil
    ;
    (self._viewcontainer):SetBlocksRaycasts(true)
    if self._sprintTask then
      local width, height = (self._viewport):GetRectSize()
      local currentPosition = self._currentPosition
      if self._totalLength + self._rightMargin < currentPosition + width then
        self._sprintPosition = currentPosition
        self._needUpdate = true
        local lenofend = currentPosition - self._totalLength + width - self._rightMargin
        if self._totalLength + self._rightMargin < width then
          lenofend = currentPosition + self._leftMargin
        end
        self._sprintSpeed = (lenofend) * 2 / self._sprintTime
        local first = {pos = self._sprintSpeed}
        local last = {pos = 0}
        self._sprintTask = (Tween.new)(self._sprintTime, first, last, "linear")
      else
        do
          if currentPosition < 0 - self._leftMargin then
            self._sprintPosition = currentPosition
            self._needUpdate = true
            local lenofend = currentPosition + self._leftMargin
            self._sprintSpeed = lenofend * 2 / self._sprintTime
            local first = {pos = self._sprintSpeed}
            local last = {pos = 0}
            self._sprintTask = (Tween.new)(self._sprintTime, first, last, "linear")
          else
            do
              do
                self._sprintTask = nil
                self._sprintclickdown = true
              end
            end
          end
        end
      end
    end
  end
end

HorizontalTableFrameInverseImpl.OnPointerUp = function(self, args)
  -- function num : 0_22
  self._sprintclickdown = false
  self:UpdateView(0)
end

HorizontalTableFrameInverseImpl.OnLateUpdate = function(self, notification)
  -- function num : 0_23 , upvalues : _ENV
  local deltaTime = (notification.userInfo).unscaledDeltaTime
  local width, height = (self._viewport):GetRectSize()
  if self._needUpdate then
    if self._slideInertiaTask then
      if (self._slideInertiaTask):update(deltaTime) then
        self._currentPosition = self._slideInertiaPosition - (self._slideInertiaSpeed + ((self._slideInertiaTask).subject).pos) * self._slideInertiaTime / 2
        if self._autoAlign then
          if self._slideInertiaSpeed < 0 then
            local half = ((self._logicCells)[self._leftIndex])._pos + ((self._logicCells)[self._leftIndex])._size / 2
            if self._currentPosition + width < half then
              local first = {pos = self._currentPosition}
              local cellNums = #self._logicCells
              if self._leftIndex + 1 <= cellNums then
                self._alignDes = ((self._logicCells)[self._leftIndex + 1])._pos + ((self._logicCells)[self._leftIndex + 1])._size - width
                local last = {pos = self._alignDes}
                self._alignTask = (Tween.new)(0.3, first, last, "linear")
              end
            else
              do
                if half <= self._currentPosition + width then
                  local first = {pos = self._currentPosition}
                  self._alignDes = ((self._logicCells)[self._leftIndex])._pos + ((self._logicCells)[self._leftIndex])._size - width
                  local last = {pos = self._alignDes}
                  self._alignTask = (Tween.new)(0.3, first, last, "linear")
                end
                do
                  if self._slideInertiaSpeed > 0 then
                    local half = ((self._logicCells)[self._rightIndex])._pos + ((self._logicCells)[self._rightIndex])._size / 2
                    if self._currentPosition <= half then
                      local first = {pos = self._currentPosition}
                      self._alignDes = ((self._logicCells)[self._rightIndex])._pos
                      local last = {pos = self._alignDes}
                      self._alignTask = (Tween.new)(0.3, first, last, "linear")
                    else
                      do
                        if half < self._currentPosition then
                          local first = {pos = self._currentPosition}
                          if self._rightIndex - 1 > 0 then
                            self._alignDes = ((self._logicCells)[self._rightIndex - 1])._pos
                            local last = {pos = self._alignDes}
                            self._alignTask = (Tween.new)(0.3, first, last, "linear")
                          end
                        end
                        do
                          self._slideInertiaTask = nil
                          self._slideInertiaPosition = nil
                          ;
                          (self._viewcontainer):SetBlocksRaycasts(true)
                          self._currentPosition = self._slideInertiaPosition - (self._slideInertiaSpeed + ((self._slideInertiaTask).subject).pos) * (self._slideInertiaTask).clock / 2
                          -- DECOMPILER ERROR at PC214: Confused about usage of register: R5 in 'UnsetPending'

                          if self._slideInertiaTask and (self._totalLength - width + self._rightMargin < self._currentPosition or self._currentPosition < 0 - self._leftMargin) then
                            (self._slideInertiaTask).clock = (self._slideInertiaTask).clock + 2 * deltaTime
                          end
                          if self._totalLength - width + width / 3 + self._rightMargin < self._currentPosition then
                            self._currentPosition = self._totalLength - width + width / 3 + self._rightMargin
                            self._slideInertiaTask = nil
                            self._slideInertiaPosition = nil
                            ;
                            (self._viewcontainer):SetBlocksRaycasts(true)
                          end
                          if self._currentPosition < -width / 3 - self._leftMargin then
                            self._currentPosition = -width / 3 - self._leftMargin
                            self._slideInertiaTask = nil
                            self._slideInertiaPosition = nil
                            ;
                            (self._viewcontainer):SetBlocksRaycasts(true)
                          end
                          if not self._slideInertiaTask and self._sprintTask and not self._sprintclickdown then
                            (self._viewcontainer):SetBlocksRaycasts(false)
                            if (self._sprintTask):update(deltaTime) then
                              self._currentPosition = self._sprintPosition - (self._sprintSpeed + ((self._sprintTask).subject).pos) * self._sprintTime / 2
                              self._sprintTask = nil
                              self._sprintPosition = nil
                              ;
                              (self._viewcontainer):SetBlocksRaycasts(true)
                            else
                              self._currentPosition = self._sprintPosition - (self._sprintSpeed + ((self._sprintTask).subject).pos) * (self._sprintTask).clock / 2
                            end
                          end
                          if self._alignTask then
                            if (self._alignTask):update(deltaTime) then
                              self._currentPosition = self._alignDes
                              self._alignTask = nil
                              ;
                              (self._viewcontainer):SetBlocksRaycasts(true)
                            else
                              self._currentPosition = ((self._alignTask).subject).pos
                            end
                          end
                          if self._insertTask then
                            for i,task in pairs(self._insertTask) do
                              local logicCell = (self._logicCells)[i]
                              if task:update(deltaTime) then
                                logicCell._pos = (self._insertDes)[i]
                                -- DECOMPILER ERROR at PC343: Confused about usage of register: R11 in 'UnsetPending'

                                ;
                                (self._insertDes)[i] = nil
                                -- DECOMPILER ERROR at PC345: Confused about usage of register: R11 in 'UnsetPending'

                                ;
                                (self._insertTask)[i] = nil
                              else
                                logicCell._pos = (task.subject).pos
                              end
                            end
                          end
                          do
                            if self._removeTask then
                              for i,task in pairs(self._removeTask) do
                                local logicCell = (self._logicCells)[i]
                                if task:update(deltaTime) then
                                  logicCell._pos = (self._removeDes)[i]
                                  -- DECOMPILER ERROR at PC370: Confused about usage of register: R11 in 'UnsetPending'

                                  ;
                                  (self._removeDes)[i] = nil
                                  -- DECOMPILER ERROR at PC372: Confused about usage of register: R11 in 'UnsetPending'

                                  ;
                                  (self._removeTask)[i] = nil
                                else
                                  logicCell._pos = (task.subject).pos
                                end
                              end
                            end
                            do
                              if self._removeCurTask then
                                if (self._removeCurTask):update(deltaTime) then
                                  self._currentPosition = self._removeCurDes
                                  self._removeCurTask = nil
                                  self._removeCurDes = nil
                                else
                                  self._currentPosition = ((self._removeCurTask).subject).pos
                                end
                                if width < self._totalLength + self._rightMargin and self._totalLength + self._rightMargin - width < self._currentPosition then
                                  self._currentPosition = self._totalLength + self._rightMargin - width
                                end
                                if self._currentPosition < 0 - self._leftMargin then
                                  self._currentPosition = 0 - self._leftMargin
                                end
                              end
                              if self._removeTolTask then
                                if (self._removeTolTask):update(deltaTime) then
                                  self._totalLength = self._removeTolDes
                                  self._removeTolTask = nil
                                  self._removeTolDes = nil
                                else
                                  self._totalLength = ((self._removeTolTask).subject).pos
                                end
                              end
                              if self._moveLeftTask then
                                if (self._moveLeftTask):update(deltaTime) then
                                  self._currentPosition = self._totalLength - width + self._rightMargin
                                  self._moveLeftTask = nil
                                else
                                  self._currentPosition = ((self._moveLeftTask).subject).pos
                                end
                              end
                              if self._moveRightTask then
                                if (self._moveRightTask):update(deltaTime) then
                                  self._currentPosition = 0 - self._leftMargin
                                  self._moveRightTask = nil
                                else
                                  self._currentPosition = ((self._moveRightTask).subject).pos
                                end
                              end
                              if self._moveRightIndexTask then
                                if (self._moveRightIndexTask):update(deltaTime) then
                                  self._currentPosition = self._moveRightIndexDes
                                  self._moveRightIndexTask = nil
                                else
                                  self._currentPosition = ((self._moveRightIndexTask).subject).pos
                                end
                              end
                              if self._moveLeftIndexTask then
                                if (self._moveLeftIndexTask):update(deltaTime) then
                                  self._currentPosition = self._moveLeftIndexDes
                                  self._moveLeftIndexTask = nil
                                else
                                  self._currentPosition = ((self._moveLeftIndexTask).subject).pos
                                end
                              end
                              if self._moveToAssignedPosTask then
                                if (self._moveToAssignedPosTask):update(deltaTime) then
                                  self._currentPosition = self._moveToAssignedPosDes
                                  self._moveToAssignedPosTask = nil
                                else
                                  self._currentPosition = ((self._moveToAssignedPosTask).subject).pos
                                end
                              end
                              self:UpdateView(deltaTime)
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

HorizontalTableFrameInverseImpl.UpdateView = function(self, deltaTime)
  -- function num : 0_24 , upvalues : _ENV
  if self._needUpdate then
    local currentPosition = self._currentPosition
    local width, height = (self._viewport):GetRectSize()
    if width < self._totalLength + self._leftMargin then
      if currentPosition < 0 - self._leftMargin then
        currentPosition = currentPosition - 2 * (currentPosition + self._leftMargin) / 3
      end
      if self._totalLength + self._rightMargin < currentPosition + width then
        currentPosition = currentPosition - 2 * (width - self._totalLength + (currentPosition) - self._rightMargin) / 3
      end
    else
      currentPosition = currentPosition + self._leftMargin
      currentPosition = (currentPosition) / 3
    end
    self._flag = true
    for i,logicCell in ipairs(self._logicCells) do
      if width < self._totalLength + self._rightMargin then
        self:SetCellVisible(i, logicCell, currentPosition + width + self._rightMargin, currentPosition - self._leftMargin)
      else
        self:SetCellVisible(i, logicCell, width - self._rightMargin, self._leftMargin)
      end
    end
    self._cellY = -1
    for i,logicCell in ipairs(self._logicCells) do
      if logicCell._visible then
        if not logicCell._cell then
          self:GetCellDialog(logicCell)
          -- DECOMPILER ERROR at PC84: Confused about usage of register: R10 in 'UnsetPending'

          ;
          (logicCell._cell)._delegate = self._delegate
          -- DECOMPILER ERROR at PC87: Confused about usage of register: R10 in 'UnsetPending'

          ;
          (logicCell._cell)._cellData = logicCell._data
          ;
          (logicCell._cell):RefreshCell(logicCell._data)
        end
        ;
        ((logicCell._cell):GetRootWindow()):SetPosition(0, logicCell._pos, 0, 0)
        if self._cellY == -1 then
          local x = nil
          x = ((logicCell._cell):GetRootWindow()):GetRectSize()
        end
      end
    end
    if self._refreshUIParticleClipper and self._refreshPosY then
      self._refreshPosY = false
      ;
      (((((CS.PixelNeko).Render).ShaderUtility).UIParticleClipper).RefreshUIParticleClipper)((self._viewport):GetUIObject())
    end
    for dialogName,cells in pairs(self._recycleCells) do
      for i,cell in ipairs(cells) do
        (cell:GetRootWindow()):SetPosition(0, -10000, 0, 0)
      end
    end
    ;
    (self._viewcontainer):SetSize(0, self._totalLength, 0, self._cellY)
    local x, viewportY = (self._viewport):GetRectSize()
    if width < self._totalLength + self._rightMargin then
      (self._viewcontainer):SetPosition(0, -(currentPosition), 0, (viewportY - self._cellY) / 2)
    else
      ;
      (self._viewcontainer):SetPosition(0, width - self._totalLength - currentPosition - self._rightMargin, 0, (viewportY - self._cellY) / 2)
    end
    do
      if self._upMargin ~= 0 or self._downMargin ~= 0 then
        local aMinX, aMinY, aMaxX, aMaxY, oMinX, oMinY, oMaxX, oMaxY = (self._viewcontainer):GetAnchorAndOffset()
        ;
        (self._viewcontainer):SetAnchorAndOffset(aMinX, 0, aMaxX, 1, oMinX, self._downMargin, oMaxX, -self._upMargin)
      end
      if not self._sprintTask and not self._slideInertiaTask and #self._insertTask == 0 and #self._removeTask == 0 and not self._removeCurTask and not self._removeTolTask and not self._moveLeftTask and not self._moveRightTask and not self._moveRightIndexTask and not self._moveLeftIndexTask and not self._alignTask and not self._moveToAssignedPosTask then
        self._needUpdate = false
      end
      if (self._delegate).OnCurPosChange then
        local width, height = (self._viewport):GetRectSize()
        local ratio = 0
        if width < self._totalLength then
          ratio = self._currentPosition / (self._totalLength - width)
          if ratio < 0 then
            ratio = (self._currentPosition + self._leftMargin) / (self._totalLength - width)
          end
          if ratio > 1 then
            ratio = (self._currentPosition - self._rightMargin) / (self._totalLength - width)
          end
          if 1 - ratio < 0.001 then
            ratio = 1
          else
            if ratio < 0.001 then
              ratio = 0
            end
          end
        else
          ratio = 0
        end
        ;
        (self._delegate):OnCurPosChange(self._interface, ratio)
      end
    end
  end
end

HorizontalTableFrameInverseImpl.SetCellVisible = function(self, i, logicCell, up, down)
  -- function num : 0_25
  if down < logicCell._pos + logicCell._size and logicCell._pos < up then
    if self._flag then
      self._flag = false
      self._leftIndex = i
    end
    if not logicCell._visible then
      self._refreshPosY = true
    end
    logicCell._visible = true
    self._rightIndex = i
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

HorizontalTableFrameInverseImpl.GetCellDialog = function(self, logicCell)
  -- function num : 0_26 , upvalues : _ENV
  if logicCell._cell then
    return 
  end
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  if not (self._recycleCells)[logicCell._dialogName] then
    (self._recycleCells)[logicCell._dialogName] = {}
  end
  local recycleList = (self._recycleCells)[logicCell._dialogName]
  if #recycleList > 0 then
    logicCell._cell = recycleList[#recycleList]
    recycleList[#recycleList] = nil
  else
    logicCell._cell = (DialogManager.CopyDialog)(logicCell._dialogName, ((self._baseCells)[logicCell._dialogName])._uiObject, (self._viewcontainer)._uiObject)
  end
end

HorizontalTableFrameInverseImpl.RecycleCell = function(self, logicCell)
  -- function num : 0_27 , upvalues : _ENV
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  if logicCell._cell then
    if not (self._recycleCells)[logicCell._dialogName] then
      (self._recycleCells)[logicCell._dialogName] = {}
    end
    ;
    (table.insert)((self._recycleCells)[logicCell._dialogName], logicCell._cell)
    logicCell._cell = nil
  end
end

HorizontalTableFrameInverseImpl.SetSlide = function(self, slide, showSoftMask)
  -- function num : 0_28 , upvalues : _ENV
  if slide then
    if self._beginDragHandler then
      (self._viewport):Unsubscribe_BeginDragEvent(self._beginDragHandler)
    end
    if self._dragHandler then
      (self._viewport):Unsubscribe_DragEvent(self._dragHandler)
    end
    if self._endDragHandler then
      (self._viewport):Unsubscribe_EndDragEvent(self._endDragHandler)
    end
    if self._cancelDragHandler then
      (self._viewport):Unsubscribe_CancelDragEvent(self._cancelDragHandler)
    end
    self._beginDragHandler = (self._viewport):Subscribe_BeginDragEvent(self.OnBeginDrag, self)
    self._dragHandler = (self._viewport):Subscribe_DragEvent(self.OnDrag, self)
    self._endDragHandler = (self._viewport):Subscribe_EndDragEvent(self.OnEndDrag, self)
    self._cancelDragHandler = (self._viewport):Subscribe_CancelDragEvent(self.OnEndDrag, self)
    ;
    ((((CS.PixelNeko).Lua).SoftMaskStaticFunctions).SetSoftMaskActive)((self._viewport)._uiObject, true)
  else
    ;
    ((((CS.PixelNeko).Lua).SoftMaskStaticFunctions).SetSoftMaskActive)((self._viewport)._uiObject, showSoftMask)
    ;
    (self._viewport):Unsubscribe_BeginDragEvent(self._beginDragHandler)
    ;
    (self._viewport):Unsubscribe_DragEvent(self._dragHandler)
    ;
    (self._viewport):Unsubscribe_EndDragEvent(self._endDragHandler)
    ;
    (self._viewport):Unsubscribe_CancelDragEvent(self._cancelDragHandler)
  end
end

HorizontalTableFrameInverseImpl.SetSoftMaskActive = function(self, showSoftMask)
  -- function num : 0_29 , upvalues : _ENV
  ((((CS.PixelNeko).Lua).SoftMaskStaticFunctions).SetSoftMaskActive)((self._viewport)._uiObject, showSoftMask)
end

HorizontalTableFrameInverseImpl.RefreshUIParticleClipper = function(self)
  -- function num : 0_30 , upvalues : _ENV
  self._refreshUIParticleClipper = true
  ;
  (((((CS.PixelNeko).Render).ShaderUtility).UIParticleClipper).RefreshUIParticleClipper)((self._viewport):GetUIObject())
end

HorizontalTableFrameInverseImpl.ClearAllPositionChangeTask = function(self)
  -- function num : 0_31
  self._slideInertiaTask = nil
  self._sprintTask = nil
  self._moveLeftTask = nil
  self._moveRightTask = nil
  self._moveLeftIndexTask = nil
  self._moveRightIndexTask = nil
  self._moveToAssignedPosTask = nil
end

return HorizontalTableFrameInverseImpl

