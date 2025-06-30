-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/frame/looptable/loophorizontaltableframeimpl.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local LogicCell = require("framework.ui.frame.looptable.looplogiccell")
local LoopHorizontalTableFrameImpl = class("LoopHorizontalTableFrameImpl")
LoopHorizontalTableFrameImpl.Ctor = function(self, interface, container, delegate, canSlide, autoAlign, loop, viewportName)
  -- function num : 0_0 , upvalues : _ENV, UIManager
  self._interface = interface
  self._container = container
  self._delegate = delegate
  self._canSlide = canSlide
  self._autoAlign = autoAlign
  self._canLoop = loop
  self._recycleCells = {}
  self._logicCells = {}
  self._baseCells = {}
  if (((((CS.PixelNeko).Lua).UI).FrameStaticFunctions).GetFrameChildCount)(container._uiObject) > 0 then
    LogErrorFormat("LoopHorizontalTableFrameImpl", "非法操作: container [%s] 已经创建过frame Viewport", container._uiObject)
  end
  self._viewport = (UIManager.CreateLuaWindow)("ui/widgets.assetbundle", viewportName, container._uiObject)
  ;
  (((((CS.PixelNeko).Lua).UI).FrameStaticFunctions).AddFrameChild)(container._uiObject, (self._viewport)._uiObject)
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
  self._upMargin = (((((CS.PixelNeko).Lua).UI).FrameStaticFunctions).GetMargin)(container._uiObject)
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

LoopHorizontalTableFrameImpl.Destroy = function(self)
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
    self._currentDrag = 0
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

LoopHorizontalTableFrameImpl.ReloadAllCell = function(self)
  -- function num : 0_2 , upvalues : _ENV, LogicCell, UIManager
  for i,logicCell in ipairs(self._logicCells) do
    if logicCell._cell then
      self:RecycleCell(logicCell)
    end
  end
  self._logicCells = {}
  self._currentDrag = -self._leftMargin
  self._totalLength = 0
  self._needUpdate = true
  self._taskBeginLogicPos = {}
  local cellNums = (self._delegate):NumberOfCell(self._interface)
  for i = 1, cellNums do
    local logicCell = (LogicCell.Create)()
    logicCell._dialogName = (self._delegate):CellAtIndex(self._interface, i)
    do
      do
        if not (self._baseCells)[logicCell._dialogName] then
          local dialogDefine = require("logic.dialog." .. logicCell._dialogName)
          -- DECOMPILER ERROR at PC57: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (self._baseCells)[logicCell._dialogName] = (UIManager.CreateLuaWindow)(dialogDefine.AssetBundleName .. ".assetbundle", dialogDefine.AssetName, (self._viewport)._uiObject)
          ;
          ((self._baseCells)[logicCell._dialogName]):SetPosition(0, -10000, 0, 0)
        end
        logicCell._data = (self._delegate):DataAtIndex(self._interface, i)
        -- DECOMPILER ERROR at PC74: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (self._logicCells)[i] = logicCell
        -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  local tempSize = {}
  for i,logicCell in ipairs(self._logicCells) do
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
        logicCell._pos = self._totalLength
        self._totalLength = self._totalLength + logicCell._size
        logicCell._index = i
        self:GetCellDialog(logicCell)
        -- DECOMPILER ERROR at PC137: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (logicCell._cell)._delegate = self._delegate
        -- DECOMPILER ERROR at PC140: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (logicCell._cell)._cellData = logicCell._data
        ;
        (logicCell._cell):RefreshCell(logicCell._data)
        do
          local w, h = ((logicCell._cell):GetRootWindow()):GetRectSize()
          self:RecycleCell(logicCell)
          logicCell._size = w
          logicCell._pos = self._totalLength
          self._totalLength = self._totalLength + logicCell._size
          logicCell._index = i
          -- DECOMPILER ERROR at PC161: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC161: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC161: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  -- DECOMPILER ERROR at PC171: Confused about usage of register: R3 in 'UnsetPending'

  if self._canLoop and cellNums > 0 then
    (self._logicCells)[0] = (LogicCell.Create)()
    -- DECOMPILER ERROR at PC177: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self._logicCells)[0])._dialogName = ((self._logicCells)[cellNums])._dialogName
    -- DECOMPILER ERROR at PC183: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self._logicCells)[0])._data = ((self._logicCells)[cellNums])._data
    self:GetCellDialog((self._logicCells)[0])
    -- DECOMPILER ERROR at PC192: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (((self._logicCells)[0])._cell)._delegate = self._delegate
    -- DECOMPILER ERROR at PC199: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (((self._logicCells)[0])._cell)._cellData = ((self._logicCells)[0])._data
    ;
    (((self._logicCells)[0])._cell):RefreshCell(((self._logicCells)[0])._data)
    self:RecycleCell((self._logicCells)[0])
    -- DECOMPILER ERROR at PC217: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self._logicCells)[0])._index = ((self._logicCells)[cellNums])._index
    -- DECOMPILER ERROR at PC220: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self._logicCells)[0])._isLogicCell = false
    -- DECOMPILER ERROR at PC226: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self._logicCells)[0])._size = ((self._logicCells)[cellNums])._size
    -- DECOMPILER ERROR at PC233: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self._logicCells)[0])._pos = -((self._logicCells)[0])._size
    -- DECOMPILER ERROR at PC238: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._logicCells)[cellNums + 1] = (LogicCell.Create)()
    -- DECOMPILER ERROR at PC245: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self._logicCells)[cellNums + 1])._dialogName = ((self._logicCells)[1])._dialogName
    -- DECOMPILER ERROR at PC252: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self._logicCells)[cellNums + 1])._data = ((self._logicCells)[1])._data
    self:GetCellDialog((self._logicCells)[cellNums + 1])
    -- DECOMPILER ERROR at PC263: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (((self._logicCells)[cellNums + 1])._cell)._delegate = self._delegate
    -- DECOMPILER ERROR at PC272: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (((self._logicCells)[cellNums + 1])._cell)._cellData = ((self._logicCells)[cellNums + 1])._data
    ;
    (((self._logicCells)[cellNums + 1])._cell):RefreshCell(((self._logicCells)[cellNums + 1])._data)
    self:RecycleCell((self._logicCells)[cellNums + 1])
    -- DECOMPILER ERROR at PC294: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self._logicCells)[cellNums + 1])._index = ((self._logicCells)[1])._index
    -- DECOMPILER ERROR at PC298: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self._logicCells)[cellNums + 1])._isLogicCell = false
    -- DECOMPILER ERROR at PC305: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self._logicCells)[cellNums + 1])._size = ((self._logicCells)[1])._size
    -- DECOMPILER ERROR at PC317: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self._logicCells)[cellNums + 1])._pos = ((self._logicCells)[cellNums])._pos + ((self._logicCells)[cellNums + 1])._size
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

LoopHorizontalTableFrameImpl.MoveToLeft = function(self, isAnimate)
  -- function num : 0_3 , upvalues : _ENV
  if self._logicCells and #self._logicCells ~= 0 then
    self._needUpdate = true
    local delta = 0 - self._leftMargin
    for i = self._logicCellUpIndex, self._logicCellDownIndex do
      local logicCell = (self._logicCells)[i]
      if logicCell._isLogicCell and logicCell._index == 1 then
        delta = logicCell._pos
        break
      end
    end
    do
      self._moveLeftDes = -delta
      self._taskBeginLogicPos = {}
      for i = self._logicCellUpIndex, self._logicCellDownIndex do
        -- DECOMPILER ERROR at PC37: Confused about usage of register: R7 in 'UnsetPending'

        (self._taskBeginLogicPos)[i] = ((self._logicCells)[i])._pos
      end
      if isAnimate then
        local first = {pos = 0}
        local last = {pos = self._moveLeftDes}
        self._moveLeftTask = (Tween.new)(0.5, first, last, "linear")
      else
        do
          self._currentDrag = 0
          for i = self._logicCellUpIndex, self._logicCellDownIndex do
            -- DECOMPILER ERROR at PC66: Confused about usage of register: R7 in 'UnsetPending'

            ((self._logicCells)[i])._pos = (self._taskBeginLogicPos)[i] + self._moveLeftDes
          end
          self._taskBeginLogicPos = {}
        end
      end
    end
  end
end

LoopHorizontalTableFrameImpl.MoveToRight = function(self, isAnimate)
  -- function num : 0_4 , upvalues : _ENV
  if self._logicCells and #self._logicCells ~= 0 then
    self._needUpdate = true
    local width, height = (self._viewport):GetRectSize()
    local delta = self._totalLength - width + self._rightMargin
    for i = self._logicCellUpIndex, self._logicCellDownIndex do
      local logicCell = (self._logicCells)[i]
      if logicCell._isLogicCell and logicCell._index == (self._delegate):NumberOfCell(self._interface) then
        delta = logicCell._pos
        break
      end
    end
    do
      self._moveRightDes = -delta
      self._taskBeginLogicPos = {}
      for i = self._logicCellUpIndex, self._logicCellDownIndex do
        -- DECOMPILER ERROR at PC46: Confused about usage of register: R9 in 'UnsetPending'

        (self._taskBeginLogicPos)[i] = ((self._logicCells)[i])._pos
      end
      if width <= self._totalLength then
        if isAnimate then
          local first = {pos = 0}
          local last = {pos = self._moveRightDes}
          self._moveRightTask = (Tween.new)(0.5, first, last, "linear")
        else
          do
            self._currentDrag = 0
            for i = self._logicCellUpIndex, self._logicCellDownIndex do
              -- DECOMPILER ERROR at PC78: Confused about usage of register: R9 in 'UnsetPending'

              ((self._logicCells)[i])._pos = (self._taskBeginLogicPos)[i] + self._moveRightDes
            end
            self._taskBeginLogicPos = {}
          end
        end
      end
    end
  end
end

LoopHorizontalTableFrameImpl.MoveLeftToIndex = function(self, desIndex, isAnimate)
  -- function num : 0_5 , upvalues : _ENV
  self._needUpdate = true
  self._moveRightIndexTask = nil
  self._slideInertiaTask = nil
  self._sprintTask = nil
  if self._moveLeftIndexTask then
    self._currentDrag = 0
    if #self._taskBeginLogicPos == 0 then
      for i = self._logicCellUpIndex, self._logicCellDownIndex do
        -- DECOMPILER ERROR at PC20: Confused about usage of register: R7 in 'UnsetPending'

        (self._taskBeginLogicPos)[i] = ((self._logicCells)[i])._pos
      end
    end
    do
      for i = self._logicCellUpIndex, self._logicCellDownIndex do
        -- DECOMPILER ERROR at PC32: Confused about usage of register: R7 in 'UnsetPending'

        ((self._logicCells)[i])._pos = (self._taskBeginLogicPos)[i] + self._moveLeftIndexDes
      end
      do
        local width, height = (self._viewport):GetRectSize()
        local temp = (self._logicCells)[desIndex]
        local delta = temp._pos
        self._taskBeginLogicPos = {}
        for i = self._logicCellUpIndex, self._logicCellDownIndex do
          -- DECOMPILER ERROR at PC50: Confused about usage of register: R11 in 'UnsetPending'

          (self._taskBeginLogicPos)[i] = ((self._logicCells)[i])._pos
        end
        self._moveLeftIndexDes = -delta
        if isAnimate then
          local first = {pos = 0}
          local last = {pos = self._moveLeftIndexDes}
          self._moveLeftIndexTask = (Tween.new)(0.2, first, last, "linear")
        else
          do
            self._currentDrag = 0
            for i = self._logicCellUpIndex, self._logicCellDownIndex do
              -- DECOMPILER ERROR at PC81: Confused about usage of register: R11 in 'UnsetPending'

              ((self._logicCells)[i])._pos = (self._taskBeginLogicPos)[i] + self._moveLeftIndexDes
            end
            self._taskBeginLogicPos = {}
          end
        end
      end
    end
  end
end

LoopHorizontalTableFrameImpl.MoveRightToIndex = function(self, desIndex, isAnimate)
  -- function num : 0_6 , upvalues : _ENV
  self._needUpdate = true
  self._moveLeftIndexTask = nil
  self._slideInertiaTask = nil
  self._sprintTask = nil
  if self._moveRightIndexTask then
    self._currentDrag = 0
    if #self._taskBeginLogicPos == 0 then
      for i = self._logicCellUpIndex, self._logicCellDownIndex do
        -- DECOMPILER ERROR at PC20: Confused about usage of register: R7 in 'UnsetPending'

        (self._taskBeginLogicPos)[i] = ((self._logicCells)[i])._pos
      end
    end
    do
      for i = self._logicCellUpIndex, self._logicCellDownIndex do
        -- DECOMPILER ERROR at PC32: Confused about usage of register: R7 in 'UnsetPending'

        ((self._logicCells)[i])._pos = (self._taskBeginLogicPos)[i] + self._moveRightIndexDes
      end
      do
        local width, height = (self._viewport):GetRectSize()
        local temp = (self._logicCells)[desIndex]
        local delta = temp._pos + temp._size - width
        self._taskBeginLogicPos = {}
        for i = self._logicCellUpIndex, self._logicCellDownIndex do
          -- DECOMPILER ERROR at PC53: Confused about usage of register: R11 in 'UnsetPending'

          (self._taskBeginLogicPos)[i] = ((self._logicCells)[i])._pos
        end
        self._moveRightIndexDes = -delta
        if isAnimate then
          local first = {pos = 0}
          local last = {pos = self._moveRightIndexDes}
          self._moveRightIndexTask = (Tween.new)(0.2, first, last, "linear")
        else
          do
            self._currentDrag = 0
            for i = self._logicCellUpIndex, self._logicCellDownIndex do
              -- DECOMPILER ERROR at PC84: Confused about usage of register: R11 in 'UnsetPending'

              ((self._logicCells)[i])._pos = (self._taskBeginLogicPos)[i] + self._moveRightIndexDes
            end
            self._taskBeginLogicPos = {}
          end
        end
      end
    end
  end
end

LoopHorizontalTableFrameImpl.GetTotalLength = function(self)
  -- function num : 0_7
  return self._totalLength
end

LoopHorizontalTableFrameImpl.ReloadCellsAtIndex = function(self, indexList, isAnimate)
  -- function num : 0_8 , upvalues : _ENV, UIManager
  if type(indexList) ~= "table" then
    LogError("LoopHorizontalTableFrameImpl", "please input a table value")
    return 
  end
  self._needUpdate = true
  local cellNums = (self._delegate):NumberOfCell(self._interface)
  for _,index in ipairs(indexList) do
    if not index or cellNums < index then
      LogErrorFormat("LoopHorizontalTableFrameImpl", "the index %d is out of range", index)
      return 
    end
    local logicCell = (self._logicCells)[index]
    logicCell._dialogName = (self._delegate):CellAtIndex(self._interface, index)
    do
      if not (self._baseCells)[logicCell._dialogName] then
        local dialogDefine = require("logic.dialog." .. logicCell._dialogName)
        -- DECOMPILER ERROR at PC57: Confused about usage of register: R11 in 'UnsetPending'

        ;
        (self._baseCells)[logicCell._dialogName] = (UIManager.CreateLuaWindow)(dialogDefine.AssetBundleName .. ".assetbundle", dialogDefine.AssetName, (self._viewport)._uiObject)
        ;
        ((self._baseCells)[logicCell._dialogName]):SetPosition(0, -10000, 0, 0)
      end
      logicCell._data = (self._delegate):DataAtIndex(self._interface, index)
      self:GetCellDialog(logicCell)
      -- DECOMPILER ERROR at PC78: Confused about usage of register: R10 in 'UnsetPending'

      ;
      (logicCell._cell)._delegate = self._delegate
      -- DECOMPILER ERROR at PC81: Confused about usage of register: R10 in 'UnsetPending'

      ;
      (logicCell._cell)._cellData = logicCell._data
      ;
      (logicCell._cell):RefreshCell(logicCell._data)
      local w = ((logicCell._cell):GetRootWindow()):GetRectSize()
      local delta = w - logicCell._size
      logicCell._size = w
      -- DECOMPILER ERROR at PC95: Confused about usage of register: R12 in 'UnsetPending'

      ;
      (self._logicCells)[index] = logicCell
      if self._canLoop then
        if index == 1 then
          local temp = (self._logicCells)[self._logicCellDownIndex]
          temp._dialogName = logicCell._dialogName
          temp._data = logicCell._data
          self:GetCellDialog(temp)
          -- DECOMPILER ERROR at PC114: Confused about usage of register: R13 in 'UnsetPending'

          ;
          (temp._cell)._delegate = (logicCell._cell)._delegate
          -- DECOMPILER ERROR at PC118: Confused about usage of register: R13 in 'UnsetPending'

          ;
          (temp._cell)._cellData = (logicCell._cell)._cellData
          ;
          (temp._cell):RefreshCell(temp._data)
          self:RecycleCell(temp)
          temp._size = logicCell._size
          -- DECOMPILER ERROR at PC130: Confused about usage of register: R13 in 'UnsetPending'

          ;
          (self._logicCells)[self._logicCellDownIndex] = temp
        else
          do
            do
              do
                if index == cellNums then
                  local temp = (self._logicCells)[self._logicCellUpIndex]
                  temp._dialogName = logicCell._dialogName
                  temp._data = logicCell._data
                  self:GetCellDialog(temp)
                  -- DECOMPILER ERROR at PC147: Confused about usage of register: R13 in 'UnsetPending'

                  ;
                  (temp._cell)._delegate = (logicCell._cell)._delegate
                  -- DECOMPILER ERROR at PC151: Confused about usage of register: R13 in 'UnsetPending'

                  ;
                  (temp._cell)._cellData = (logicCell._cell)._cellData
                  ;
                  (temp._cell):RefreshCell(temp._data)
                  self:RecycleCell(temp)
                  temp._size = logicCell._size
                  -- DECOMPILER ERROR at PC163: Confused about usage of register: R13 in 'UnsetPending'

                  ;
                  (self._logicCells)[self._logicCellUpIndex] = temp
                end
                for i = index + 1, self._logicCellDownIndex do
                  -- DECOMPILER ERROR at PC174: Confused about usage of register: R16 in 'UnsetPending'

                  ((self._logicCells)[i])._pos = ((self._logicCells)[i])._pos + delta
                end
                self:RecycleCell(logicCell)
                self._totalLength = self._totalLength + delta
                -- DECOMPILER ERROR at PC182: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC182: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC182: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC182: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC182: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC182: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC182: LeaveBlock: unexpected jumping out DO_STMT

              end
            end
          end
        end
      end
    end
  end
  self:UpdateView(0)
end

LoopHorizontalTableFrameImpl.RemoveCellsAtIndex = function(self, indexList, isAnimate)
  -- function num : 0_9 , upvalues : _ENV
  if type(indexList) ~= "table" then
    LogError("LoopHorizontalTableFrameImpl", "please input a table value")
    return 
  end
  self._needUpdate = true
  local cellNums = #self._logicCells
  local width, height = (self._viewport):GetRectSize()
  local currentDrag = self._currentDrag
  for _,index in ipairs(indexList) do
    cellNums = #self._logicCells
    if cellNums < index then
      LogErrorFormat("LoopHorizontalTableFrameImpl", "Wrong index %d", index)
      return 
    end
    local gap = ((self._logicCells)[index])._size
    local pos = ((self._logicCells)[index])._pos
    self:RecycleCell((self._logicCells)[index])
    if #self._insertTask ~= 0 then
      for i,task in pairs(self._insertTask) do
        local logicCell = (self._logicCells)[i + self._insertIndex - 1]
        logicCell._pos = (self._insertDes)[i]
        -- DECOMPILER ERROR at PC58: Confused about usage of register: R20 in 'UnsetPending'

        ;
        (self._insertDes)[i] = nil
        -- DECOMPILER ERROR at PC60: Confused about usage of register: R20 in 'UnsetPending'

        ;
        (self._insertTask)[i] = nil
      end
    end
    do
      if #self._removeTask ~= 0 then
        for i,task in pairs(self._removeTask) do
          -- DECOMPILER ERROR at PC78: Confused about usage of register: R19 in 'UnsetPending'

          ((self._logicCells)[i + self._removeIndex - 1])._pos = (self._removeDes)[i]
          -- DECOMPILER ERROR at PC80: Confused about usage of register: R19 in 'UnsetPending'

          ;
          (self._removeDes)[i] = nil
          -- DECOMPILER ERROR at PC82: Confused about usage of register: R19 in 'UnsetPending'

          ;
          (self._removeTask)[i] = nil
        end
      end
      do
        if isAnimate and currentDrag < pos + gap and pos < currentDrag + width then
          self._removeTask = {}
          self._removeIndex = index
          for i = index + 1, cellNums do
            -- DECOMPILER ERROR at PC106: Confused about usage of register: R18 in 'UnsetPending'

            (self._removeDes)[i - index] = ((self._logicCells)[i])._pos - gap
            local first = {pos = ((self._logicCells)[i])._pos}
            local last = {pos = (self._removeDes)[i - index]}
            -- DECOMPILER ERROR at PC126: Confused about usage of register: R20 in 'UnsetPending'

            ;
            (self._removeTask)[i - index] = (Tween.new)(0.1, first, last, "linear")
          end
        else
          do
            for i = index + 1, cellNums do
              -- DECOMPILER ERROR at PC139: Confused about usage of register: R18 in 'UnsetPending'

              ((self._logicCells)[i])._pos = ((self._logicCells)[i])._pos - gap
            end
            do
              do
                ;
                (table.remove)(self._logicCells, index)
                self._totalLength = self._totalLength - gap
                -- DECOMPILER ERROR at PC149: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC149: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC149: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC149: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC149: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC149: LeaveBlock: unexpected jumping out DO_STMT

              end
            end
          end
        end
      end
    end
  end
end

LoopHorizontalTableFrameImpl.InsertCellsAtIndex = function(self, indexList, isAnimate)
  -- function num : 0_10 , upvalues : _ENV, LogicCell, UIManager
  if indexList and type(indexList) ~= "table" then
    LogError("LoopHorizontalTableFrameImpl", "please input a table value")
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
      LogError("LoopHorizontalTableFrameImpl", "no additional data")
      return 
    end
  end
  for _,index in ipairs(indexList) do
    cellNums = #self._logicCells
    if not index or cellNums + 1 < index and not lastinsert then
      LogErrorFormat("LoopHorizontalTableFrameImpl", "Wrong index %d", index)
      return 
    end
    local logicCell = (LogicCell.Create)()
    logicCell._dialogName = (self._delegate):CellAtIndex(self._interface, index)
    do
      if not (self._baseCells)[logicCell._dialogName] then
        local dialogDefine = require("logic.dialog." .. logicCell._dialogName)
        -- DECOMPILER ERROR at PC97: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (self._baseCells)[logicCell._dialogName] = (UIManager.CreateLuaWindow)(dialogDefine.AssetBundleName .. ".assetbundle", dialogDefine.AssetName, (self._viewport)._uiObject)
        ;
        ((self._baseCells)[logicCell._dialogName]):SetPosition(0, -10000, 0, 0)
      end
      logicCell._data = (self._delegate):DataAtIndex(self._interface, index)
      local tempSize = {}
      local width, height = (self._viewport):GetRectSize()
      if not (self._delegate).ShouldLengthChange or not (self._delegate):ShouldLengthChange(self._interface, i) then
        if not tempSize[logicCell._dialogName] then
          self:GetCellDialog(logicCell)
          -- DECOMPILER ERROR at PC137: Confused about usage of register: R14 in 'UnsetPending'

          ;
          (logicCell._cell)._delegate = self._delegate
          -- DECOMPILER ERROR at PC140: Confused about usage of register: R14 in 'UnsetPending'

          ;
          (logicCell._cell)._cellData = logicCell._data
          ;
          (logicCell._cell):RefreshCell(logicCell._data)
          tempSize[logicCell._dialogName] = ((logicCell._cell):GetRootWindow()):GetRectSize()
          self:RecycleCell(logicCell)
        end
        logicCell._size = tempSize[logicCell._dialogName]
      else
        self:GetCellDialog(logicCell)
        -- DECOMPILER ERROR at PC164: Confused about usage of register: R14 in 'UnsetPending'

        ;
        (logicCell._cell)._delegate = self._delegate
        -- DECOMPILER ERROR at PC167: Confused about usage of register: R14 in 'UnsetPending'

        ;
        (logicCell._cell)._cellData = logicCell._data
        ;
        (logicCell._cell):RefreshCell(logicCell._data)
        local w, h = ((logicCell._cell):GetRootWindow()):GetRectSize()
        self:RecycleCell(logicCell)
        logicCell._size = w
      end
      do
        if #self._removeTask ~= 0 then
          for i,task in pairs(self._removeTask) do
            -- DECOMPILER ERROR at PC196: Confused about usage of register: R19 in 'UnsetPending'

            ((self._logicCells)[i + self._removeIndex - 1])._pos = (self._removeDes)[i]
            -- DECOMPILER ERROR at PC198: Confused about usage of register: R19 in 'UnsetPending'

            ;
            (self._removeDes)[i] = nil
            -- DECOMPILER ERROR at PC200: Confused about usage of register: R19 in 'UnsetPending'

            ;
            (self._removeTask)[i] = nil
          end
        end
        do
          if #self._insertTask ~= 0 then
            for i,task in pairs(self._insertTask) do
              local logicCell = (self._logicCells)[i + self._insertIndex - 1]
              logicCell._pos = (self._insertDes)[i]
              -- DECOMPILER ERROR at PC220: Confused about usage of register: R20 in 'UnsetPending'

              ;
              (self._insertDes)[i] = nil
              -- DECOMPILER ERROR at PC222: Confused about usage of register: R20 in 'UnsetPending'

              ;
              (self._insertTask)[i] = nil
            end
          end
          do
            ;
            (table.insert)(self._logicCells, index, logicCell)
            cellNums = #self._logicCells
            if isAnimate then
              self._insertTask = {}
              self._insertIndex = index
              for i = index + 1, cellNums do
                -- DECOMPILER ERROR at PC250: Confused about usage of register: R18 in 'UnsetPending'

                (self._insertDes)[i - index + 1] = ((self._logicCells)[i])._pos + logicCell._size
                local first = {pos = ((self._logicCells)[i])._pos}
                local last = {pos = (self._insertDes)[i - index + 1]}
                -- DECOMPILER ERROR at PC272: Confused about usage of register: R20 in 'UnsetPending'

                ;
                (self._insertTask)[i - index + 1] = (Tween.new)(0.2, first, last, "linear")
              end
              -- DECOMPILER ERROR at PC287: Confused about usage of register: R14 in 'UnsetPending'

              if index - 1 > 0 then
                (self._insertDes)[1] = ((self._logicCells)[index - 1])._pos + ((self._logicCells)[index - 1])._size
                local first = {pos = ((self._logicCells)[index - 1])._pos}
                local last = {pos = (self._insertDes)[1]}
                -- DECOMPILER ERROR at PC306: Confused about usage of register: R16 in 'UnsetPending'

                ;
                (self._insertTask)[1] = (Tween.new)(0.2, first, last, "linear")
              else
                do
                  -- DECOMPILER ERROR at PC309: Confused about usage of register: R14 in 'UnsetPending'

                  ;
                  (self._insertDes)[1] = 0
                  local first = {pos = -logicCell._size}
                  do
                    do
                      local last = {pos = (self._insertDes)[1]}
                      -- DECOMPILER ERROR at PC326: Confused about usage of register: R16 in 'UnsetPending'

                      ;
                      (self._insertTask)[1] = (Tween.new)(0.2, first, last, "linear")
                      for i = index + 1, cellNums do
                        -- DECOMPILER ERROR at PC339: Confused about usage of register: R18 in 'UnsetPending'

                        ((self._logicCells)[i])._pos = ((self._logicCells)[i])._pos + logicCell._size
                      end
                      -- DECOMPILER ERROR at PC355: Confused about usage of register: R14 in 'UnsetPending'

                      if index - 1 > 0 then
                        ((self._logicCells)[index])._pos = ((self._logicCells)[index - 1])._pos + ((self._logicCells)[index - 1])._size
                      else
                        -- DECOMPILER ERROR at PC359: Confused about usage of register: R14 in 'UnsetPending'

                        ;
                        ((self._logicCells)[index])._pos = 0
                      end
                      self._totalLength = self._totalLength + logicCell._size
                      -- DECOMPILER ERROR at PC364: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC364: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC364: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                      -- DECOMPILER ERROR at PC364: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC364: LeaveBlock: unexpected jumping out IF_THEN_STMT

                      -- DECOMPILER ERROR at PC364: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC364: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC364: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC364: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC364: LeaveBlock: unexpected jumping out DO_STMT

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

LoopHorizontalTableFrameImpl.FireEvent = function(self, eventName, ...)
  -- function num : 0_11 , upvalues : _ENV
  for i,logicCell in ipairs(self._logicCells) do
    if logicCell._cell and (logicCell._cell).OnEvent then
      (logicCell._cell):OnEvent(eventName, ...)
    end
  end
end

LoopHorizontalTableFrameImpl.GetLeftIndex = function(self)
  -- function num : 0_12
  return self._leftIndex
end

LoopHorizontalTableFrameImpl.GetRightIndex = function(self)
  -- function num : 0_13
  return self._rightIndex
end

LoopHorizontalTableFrameImpl.SetMargin = function(self, leftValue, rightValue)
  -- function num : 0_14
  if self._leftMargin == 0 then
    self._leftMargin = leftValue
  end
  if self._rightMargin == 0 then
    self._rightMargin = rightValue
  end
end

LoopHorizontalTableFrameImpl.OnBeginDrag = function(self, args)
  -- function num : 0_15
  self._slideInertiaTime = 0.8
  self._slideInertiaTask = nil
  self._sprintTask = nil
  self._moveSpeed = {x = 0, y = 0}
  self._dragPercent = 1
  local width, height = (self._viewport):GetRectSize()
  do
    if not self._canLoop then
      local lastLogicCell = (self._logicCells)[(self._delegate):NumberOfCell(self._interface)]
      if ((self._logicCells)[1])._pos >= 0 or lastLogicCell._pos + lastLogicCell._size <= width then
        self._dragPercent = 3
      end
    end
    if (self._delegate).OnFrameBeginDrag then
      (self._delegate):OnFrameBeginDrag(self._interface)
    end
  end
end

LoopHorizontalTableFrameImpl.OnDrag = function(self, args)
  -- function num : 0_16 , upvalues : UIManager
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
  local currentDrag = self._currentDrag
  self._currentDrag = (args.delta).x
  self._dragDirectionIsRight = (args.delta).x > 0
  if localX - localPressX <= 0 then
    self._dragDirectionIsRight = (args.delta).x ~= 0
    if not self._canLoop then
      if ((self._logicCells)[1])._pos >= 0 and not self._dragDirectionIsRight then
        self._dragPercent = 1
      end
      local width, height = (self._viewport):GetRectSize()
      local lastLogicCell = (self._logicCells)[(self._delegate):NumberOfCell(self._interface)]
      if lastLogicCell._pos + lastLogicCell._size <= width and self._dragDirectionIsRight then
        self._dragPercent = 1
      end
    end
    if currentDrag ~= self._currentDrag then
      self._needUpdate = true
      self:UpdateView(0)
    end
    -- DECOMPILER ERROR: 6 unprocessed JMP targets
  end
end

LoopHorizontalTableFrameImpl.OnEndDrag = function(self, args)
  -- function num : 0_17 , upvalues : UIManager, _ENV
  local dirIsRight = self._dragDirectionIsRight
  local original, _ = (UIManager.ScreenPointToLocalPointInRectangle)((self._viewport)._uiObject, 0, 0)
  local speed, _ = (UIManager.ScreenPointToLocalPointInRectangle)((self._viewport)._uiObject, (self._moveSpeed).x, (self._moveSpeed).y)
  speed = speed - original
  local currentDrag = self._currentDrag
  local width, height = (self._viewport):GetRectSize()
  if speed == 0 then
    if self._autoAlign then
      if dirIsRight then
        self._needUpdate = true
        local lesshalf = ((self._logicCells)[self._leftIndex])._pos < -((self._logicCells)[self._leftIndex])._size / 2
        if lesshalf then
          local delta = 0 - ((self._logicCells)[self._leftIndex + 1])._pos
          local first = {pos = 0}
          self._taskBeginLogicPos = {}
          for i = self._logicCellUpIndex, self._logicCellDownIndex do
            -- DECOMPILER ERROR at PC62: Confused about usage of register: R17 in 'UnsetPending'

            (self._taskBeginLogicPos)[i] = ((self._logicCells)[i])._pos
          end
          self._alignDes = delta
          local last = {pos = self._alignDes}
          self._alignTask = (Tween.new)(0.2, first, last, "inQuad")
        else
          self._needUpdate = true
          local delta = 0 - ((self._logicCells)[self._leftIndex])._pos
          local first = {pos = 0}
          self._taskBeginLogicPos = {}
          for i = self._logicCellUpIndex, self._logicCellDownIndex do
            -- DECOMPILER ERROR at PC95: Confused about usage of register: R17 in 'UnsetPending'

            (self._taskBeginLogicPos)[i] = ((self._logicCells)[i])._pos
          end
          self._alignDes = delta
          local last = {pos = self._alignDes}
          self._alignTask = (Tween.new)(0.2, first, last, "inQuad")
        end
      else
        self._needUpdate = true
        local morehalf = ((self._logicCells)[self._rightIndex])._pos + ((self._logicCells)[self._rightIndex])._size / 2 <= width
        if morehalf then
          local delta = ((self._logicCells)[self._rightIndex])._pos + ((self._logicCells)[self._rightIndex])._size - width
          local first = {pos = 0}
          self._taskBeginLogicPos = {}
          for i = self._logicCellUpIndex, self._logicCellDownIndex do
            -- DECOMPILER ERROR at PC149: Confused about usage of register: R17 in 'UnsetPending'

            (self._taskBeginLogicPos)[i] = ((self._logicCells)[i])._pos
          end
          self._alignDes = -delta
          local last = {pos = self._alignDes}
          self._alignTask = (Tween.new)(0.2, first, last, "inQuad")
        else
          local delta = ((self._logicCells)[self._rightIndex - 1])._pos + ((self._logicCells)[self._rightIndex - 1])._size - width
          local first = {pos = 0}
          self._taskBeginLogicPos = {}
          for i = self._logicCellUpIndex, self._logicCellDownIndex do
            -- DECOMPILER ERROR at PC189: Confused about usage of register: R17 in 'UnsetPending'

            (self._taskBeginLogicPos)[i] = ((self._logicCells)[i])._pos
          end
          self._alignDes = -delta
          local last = {pos = self._alignDes}
          self._alignTask = (Tween.new)(0.2, first, last, "inQuad")
        end
      end
    elseif not self._canLoop then
      local cellNum = (self._delegate):NumberOfCell(self._interface)
      self:EstablishSprintTask(0)
    end
  elseif self._autoAlign then
    if dirIsRight then
      self._needUpdate = true
      local delta = 0 - ((self._logicCells)[self._leftIndex])._pos
      local first = {pos = 0}
      self._taskBeginLogicPos = {}
      for i = self._logicCellUpIndex, self._logicCellDownIndex do
        -- DECOMPILER ERROR at PC239: Confused about usage of register: R16 in 'UnsetPending'

        (self._taskBeginLogicPos)[i] = ((self._logicCells)[i])._pos
      end
      self._alignDes = delta
      local last = {pos = self._alignDes}
      self._alignTask = (Tween.new)(0.2, first, last, "inQuad")
    else
      self._needUpdate = true
      local delta = ((self._logicCells)[self._rightIndex])._pos + ((self._logicCells)[self._rightIndex])._size - width
      local first = {pos = 0}
      self._taskBeginLogicPos = {}
      for i = self._logicCellUpIndex, self._logicCellDownIndex do
        -- DECOMPILER ERROR at PC277: Confused about usage of register: R16 in 'UnsetPending'

        (self._taskBeginLogicPos)[i] = ((self._logicCells)[i])._pos
      end
      self._alignDes = -delta
      local last = {pos = self._alignDes}
      self._alignTask = (Tween.new)(0.2, first, last, "inQuad")
    end
  else
    self._needUpdate = true
    self._sprintTask = nil
    self._sprintTime = nil
    self._slideInertiaSpeed = (speed) * 20
    local cellNum = (self._delegate):NumberOfCell(self._interface)
    self._taskBeginLogicPos = {}
    for i = self._logicCellUpIndex, self._logicCellDownIndex do
      -- DECOMPILER ERROR at PC312: Confused about usage of register: R15 in 'UnsetPending'

      (self._taskBeginLogicPos)[i] = ((self._logicCells)[i])._pos
    end
    local first = {pos = self._slideInertiaSpeed}
    local last = {pos = 0}
    self._slideInertiaTask = (Tween.new)(self._slideInertiaTime, first, last, "linear")
  end
  if (self._delegate).OnFrameEndDrag then
    (self._delegate):OnFrameEndDrag(self._interface)
  end
  -- DECOMPILER ERROR: 11 unprocessed JMP targets
end

LoopHorizontalTableFrameImpl.OnPointerDown = function(self, deltaTime)
  -- function num : 0_18
  if self._slideInertiaTask then
    self._slideInertiaTask = nil
  end
end

LoopHorizontalTableFrameImpl.OnPointerUp = function(self, deltaTime)
  -- function num : 0_19
  self:UpdateView(0)
end

LoopHorizontalTableFrameImpl.OnLateUpdate = function(self, notification)
  -- function num : 0_20
  local deltaTime = (notification.userInfo).deltaTime
  local width, height = (self._viewport):GetRectSize()
  if self._needUpdate then
    if self._slideInertiaTask then
      if (self._slideInertiaTask):update(deltaTime) then
        self._currentDrag = (self._slideInertiaSpeed + 0) * self._slideInertiaTime / 2
        if #self._taskBeginLogicPos == 0 then
          for i = self._logicCellUpIndex, self._logicCellDownIndex do
            -- DECOMPILER ERROR at PC35: Confused about usage of register: R9 in 'UnsetPending'

            (self._taskBeginLogicPos)[i] = ((self._logicCells)[i])._pos
          end
        end
        do
          for i = self._logicCellUpIndex, self._logicCellDownIndex do
            -- DECOMPILER ERROR at PC49: Confused about usage of register: R9 in 'UnsetPending'

            ((self._logicCells)[i])._pos = (self._taskBeginLogicPos)[i] + self._currentDrag / self._dragPercent
          end
          if not self._canLoop then
            self:EstablishSprintTask(0)
          end
          self._currentDrag = 0
          self._slideInertiaTask = nil
          self._slideInertiaPosition = nil
          self._taskBeginLogicPos = {}
          self._currentDrag = (self._slideInertiaSpeed + ((self._slideInertiaTask).subject).pos) * (self._slideInertiaTask).clock / 2
          -- DECOMPILER ERROR at PC81: Confused about usage of register: R5 in 'UnsetPending'

          if self._slideInertiaTask then
            (self._slideInertiaTask).clock = (self._slideInertiaTask).clock + 2 * deltaTime
          end
          if not self._slideInertiaTask and self._sprintTask and not self._sprintclickdown then
            self._taskBeginLogicPos = self._taskBeginLogicPosForSprint
            if (self._sprintTask):update(deltaTime) then
              self._dragPercent = 1
              self._currentDrag = (self._sprintSpeed + 0) * self._sprintTime / 2
              if #self._taskBeginLogicPos == 0 then
                for i = self._logicCellUpIndex, self._logicCellDownIndex do
                  -- DECOMPILER ERROR at PC118: Confused about usage of register: R9 in 'UnsetPending'

                  (self._taskBeginLogicPos)[i] = ((self._logicCells)[i])._pos
                end
              end
              do
                for i = self._logicCellUpIndex, self._logicCellDownIndex do
                  -- DECOMPILER ERROR at PC130: Confused about usage of register: R9 in 'UnsetPending'

                  ((self._logicCells)[i])._pos = (self._taskBeginLogicPos)[i] + self._currentDrag
                end
                self._currentDrag = 0
                self._sprintTask = nil
                self._sprintTime = nil
                self._taskBeginLogicPos = {}
                self._dragPercent = 1
                self._currentDrag = (self._sprintSpeed + ((self._sprintTask).subject).pos) * (self._sprintTask).clock / 2
                if self._alignTask then
                  if (self._alignTask):update(deltaTime) then
                    self._currentDrag = 0
                    if #self._taskBeginLogicPos == 0 then
                      for i = self._logicCellUpIndex, self._logicCellDownIndex do
                        -- DECOMPILER ERROR at PC171: Confused about usage of register: R9 in 'UnsetPending'

                        (self._taskBeginLogicPos)[i] = ((self._logicCells)[i])._pos
                      end
                    end
                    do
                      for i = self._logicCellUpIndex, self._logicCellDownIndex do
                        -- DECOMPILER ERROR at PC183: Confused about usage of register: R9 in 'UnsetPending'

                        ((self._logicCells)[i])._pos = (self._taskBeginLogicPos)[i] + self._alignDes
                      end
                      self._alignTask = nil
                      self._taskBeginLogicPos = {}
                      self._currentDrag = ((self._alignTask).subject).pos
                      if self._moveLeftTask then
                        if (self._moveLeftTask):update(deltaTime) then
                          self._currentDrag = 0
                          if #self._taskBeginLogicPos == 0 then
                            for i = self._logicCellUpIndex, self._logicCellDownIndex do
                              -- DECOMPILER ERROR at PC215: Confused about usage of register: R9 in 'UnsetPending'

                              (self._taskBeginLogicPos)[i] = ((self._logicCells)[i])._pos
                            end
                          end
                          do
                            for i = self._logicCellUpIndex, self._logicCellDownIndex do
                              -- DECOMPILER ERROR at PC227: Confused about usage of register: R9 in 'UnsetPending'

                              ((self._logicCells)[i])._pos = (self._taskBeginLogicPos)[i] + self._moveLeftDes
                            end
                            self._moveLeftTask = nil
                            self._taskBeginLogicPos = {}
                            self._currentDrag = ((self._moveLeftTask).subject).pos
                            if self._moveRightTask then
                              if (self._moveRightTask):update(deltaTime) then
                                self._currentDrag = 0
                                if #self._taskBeginLogicPos == 0 then
                                  for i = self._logicCellUpIndex, self._logicCellDownIndex do
                                    -- DECOMPILER ERROR at PC259: Confused about usage of register: R9 in 'UnsetPending'

                                    (self._taskBeginLogicPos)[i] = ((self._logicCells)[i])._pos
                                  end
                                end
                                do
                                  for i = self._logicCellUpIndex, self._logicCellDownIndex do
                                    -- DECOMPILER ERROR at PC271: Confused about usage of register: R9 in 'UnsetPending'

                                    ((self._logicCells)[i])._pos = (self._taskBeginLogicPos)[i] + self._moveRightDes
                                  end
                                  self._moveRightTask = nil
                                  self._taskBeginLogicPos = {}
                                  self._currentDrag = ((self._moveRightTask).subject).pos
                                  if self._moveLeftIndexTask then
                                    if (self._moveLeftIndexTask):update(deltaTime) then
                                      self._currentDrag = 0
                                      if #self._taskBeginLogicPos == 0 then
                                        for i = self._logicCellUpIndex, self._logicCellDownIndex do
                                          -- DECOMPILER ERROR at PC303: Confused about usage of register: R9 in 'UnsetPending'

                                          (self._taskBeginLogicPos)[i] = ((self._logicCells)[i])._pos
                                        end
                                      end
                                      do
                                        for i = self._logicCellUpIndex, self._logicCellDownIndex do
                                          -- DECOMPILER ERROR at PC315: Confused about usage of register: R9 in 'UnsetPending'

                                          ((self._logicCells)[i])._pos = (self._taskBeginLogicPos)[i] + self._moveLeftIndexDes
                                        end
                                        self._moveLeftIndexTask = nil
                                        self._taskBeginLogicPos = {}
                                        self._currentDrag = ((self._moveLeftIndexTask).subject).pos
                                        if self._moveRightIndexTask then
                                          if (self._moveRightIndexTask):update(deltaTime) then
                                            self._currentDrag = 0
                                            if #self._taskBeginLogicPos == 0 then
                                              for i = self._logicCellUpIndex, self._logicCellDownIndex do
                                                -- DECOMPILER ERROR at PC347: Confused about usage of register: R9 in 'UnsetPending'

                                                (self._taskBeginLogicPos)[i] = ((self._logicCells)[i])._pos
                                              end
                                            end
                                            do
                                              for i = self._logicCellUpIndex, self._logicCellDownIndex do
                                                -- DECOMPILER ERROR at PC359: Confused about usage of register: R9 in 'UnsetPending'

                                                ((self._logicCells)[i])._pos = (self._taskBeginLogicPos)[i] + self._moveRightIndexDes
                                              end
                                              self._moveRightIndexTask = nil
                                              self._taskBeginLogicPos = {}
                                              self._currentDrag = ((self._moveRightIndexTask).subject).pos
                                              self:UpdateView(deltaTime)
                                              if self._logicCells and #self._logicCells ~= 0 and (self._delegate).visibleChangeDo then
                                                (self._delegate):visibleChangeDo(((self._logicCells)[self._leftIndex])._index)
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
    end
  end
end

LoopHorizontalTableFrameImpl.UpdateView = function(self, deltaTime)
  -- function num : 0_21 , upvalues : LogicCell, _ENV
  if self._needUpdate then
    local currentDrag = self._currentDrag / self._dragPercent
    local width, height = (self._viewport):GetRectSize()
    local cellNum = (self._delegate):NumberOfCell(self._interface)
    local flag = true
    if cellNum > 0 then
      for i = self._logicCellUpIndex, self._logicCellDownIndex do
        local logicCell = (self._logicCells)[i]
        if self._taskBeginLogicPos and #self._taskBeginLogicPos ~= 0 then
          logicCell._pos = (self._taskBeginLogicPos)[i] + currentDrag
        else
          logicCell._pos = logicCell._pos + currentDrag
        end
        if -logicCell._size < logicCell._pos and logicCell._pos < width then
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
    do
      if self._canLoop then
        if self._leftIndex == 0 then
          for i = cellNum, 0, -1 do
            -- DECOMPILER ERROR at PC82: Confused about usage of register: R11 in 'UnsetPending'

            (self._logicCells)[i + 1] = (self._logicCells)[i]
          end
          -- DECOMPILER ERROR at PC87: Confused about usage of register: R7 in 'UnsetPending'

          ;
          (self._logicCells)[0] = (LogicCell.Create)()
          -- DECOMPILER ERROR at PC93: Confused about usage of register: R7 in 'UnsetPending'

          ;
          ((self._logicCells)[0])._dialogName = ((self._logicCells)[cellNum])._dialogName
          -- DECOMPILER ERROR at PC99: Confused about usage of register: R7 in 'UnsetPending'

          ;
          ((self._logicCells)[0])._data = ((self._logicCells)[cellNum])._data
          -- DECOMPILER ERROR at PC105: Confused about usage of register: R7 in 'UnsetPending'

          ;
          ((self._logicCells)[0])._size = ((self._logicCells)[cellNum])._size
          -- DECOMPILER ERROR at PC111: Confused about usage of register: R7 in 'UnsetPending'

          ;
          ((self._logicCells)[0])._index = ((self._logicCells)[cellNum])._index
          -- DECOMPILER ERROR at PC121: Confused about usage of register: R7 in 'UnsetPending'

          ;
          ((self._logicCells)[0])._pos = ((self._logicCells)[1])._pos - ((self._logicCells)[0])._size
          if self._taskBeginLogicPos and #self._taskBeginLogicPos ~= 0 then
            for i = cellNum, 0, -1 do
              -- DECOMPILER ERROR at PC137: Confused about usage of register: R11 in 'UnsetPending'

              (self._taskBeginLogicPos)[i + 1] = (self._taskBeginLogicPos)[i]
            end
            -- DECOMPILER ERROR at PC146: Confused about usage of register: R7 in 'UnsetPending'

            ;
            (self._taskBeginLogicPos)[0] = (self._taskBeginLogicPos)[1] - ((self._logicCells)[0])._size
          end
          self._leftIndex = 1
        end
        if self._rightIndex == cellNum + 1 then
          for i = 1, cellNum + 1 do
            -- DECOMPILER ERROR at PC160: Confused about usage of register: R11 in 'UnsetPending'

            (self._logicCells)[i - 1] = (self._logicCells)[i]
          end
          -- DECOMPILER ERROR at PC166: Confused about usage of register: R7 in 'UnsetPending'

          ;
          (self._logicCells)[cellNum + 1] = (LogicCell.Create)()
          -- DECOMPILER ERROR at PC173: Confused about usage of register: R7 in 'UnsetPending'

          ;
          ((self._logicCells)[cellNum + 1])._dialogName = ((self._logicCells)[1])._dialogName
          -- DECOMPILER ERROR at PC180: Confused about usage of register: R7 in 'UnsetPending'

          ;
          ((self._logicCells)[cellNum + 1])._data = ((self._logicCells)[1])._data
          -- DECOMPILER ERROR at PC187: Confused about usage of register: R7 in 'UnsetPending'

          ;
          ((self._logicCells)[cellNum + 1])._size = ((self._logicCells)[1])._size
          -- DECOMPILER ERROR at PC194: Confused about usage of register: R7 in 'UnsetPending'

          ;
          ((self._logicCells)[cellNum + 1])._index = ((self._logicCells)[1])._index
          -- DECOMPILER ERROR at PC205: Confused about usage of register: R7 in 'UnsetPending'

          ;
          ((self._logicCells)[cellNum + 1])._pos = ((self._logicCells)[cellNum])._pos + ((self._logicCells)[cellNum])._size
          if self._taskBeginLogicPos and #self._taskBeginLogicPos ~= 0 then
            for i = 1, cellNum + 1 do
              -- DECOMPILER ERROR at PC221: Confused about usage of register: R11 in 'UnsetPending'

              (self._taskBeginLogicPos)[i - 1] = (self._taskBeginLogicPos)[i]
            end
            -- DECOMPILER ERROR at PC231: Confused about usage of register: R7 in 'UnsetPending'

            ;
            (self._taskBeginLogicPos)[cellNum + 1] = (self._taskBeginLogicPos)[cellNum] + ((self._logicCells)[cellNum])._size
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
          if width * 1 / 3 <= ((self._logicCells)[1])._pos then
            self._slideInertiaTask = nil
            self._currentDrag = 0
            self._sprintTime = 0.3
          else
            if ((self._logicCells)[cellNum])._pos + ((self._logicCells)[cellNum])._size <= width * 2 / 3 then
              self._slideInertiaTask = nil
              self._currentDrag = 0
              self._sprintTime = 0.3
            end
          end
        end
        if self._sprintTime and not self._slideInertiaTask and not self._sprintTask then
          self:EstablishSprintTask(0)
        end
      end
      for i,logicCell in ipairs(self._logicCells) do
        if logicCell._visible then
          if not logicCell._cell then
            self:GetCellDialog(logicCell)
            -- DECOMPILER ERROR at PC301: Confused about usage of register: R12 in 'UnsetPending'

            ;
            (logicCell._cell)._delegate = self._delegate
            -- DECOMPILER ERROR at PC304: Confused about usage of register: R12 in 'UnsetPending'

            ;
            (logicCell._cell)._cellData = logicCell._data
            ;
            (logicCell._cell):RefreshCell(logicCell._data)
          end
          ;
          ((logicCell._cell):GetRootWindow()):SetPosition(0, logicCell._pos, 0, 0)
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
      if not self._slideInertiaTask and not self._sprintTask and #self._insertTask == 0 and #self._removeTask == 0 and not self._moveLeftTask and not self._moveRightTask and not self._moveLeftIndexTask and not self._moveRightIndexTask and not self._alignTask then
        self._needUpdate = false
      end
      if not self._canLoop and (self._delegate).OnCurPosChange then
        local width, height = (self._viewport):GetRectSize()
        local ratio = 0
        if width < self._totalLength then
          local base = ((self._logicCells)[1])._pos
          ratio = base / -(self._totalLength - width)
          if ratio < 0 then
            ratio = 0
          end
          if ratio > 1 then
            ratio = 1
          end
          if 1 - ratio < 0.001 then
            ratio = 1
          else
            if ratio < 0.001 then
              ratio = 0
            end
          end
        else
          do
            ratio = 0
            ;
            (self._delegate):OnCurPosChange(self._interface, ratio)
          end
        end
      end
    end
  end
end

LoopHorizontalTableFrameImpl.GetCellDialog = function(self, logicCell)
  -- function num : 0_22 , upvalues : _ENV
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
    logicCell._cell = (DialogManager.CopyDialog)(logicCell._dialogName, ((self._baseCells)[logicCell._dialogName])._uiObject, (self._viewport)._uiObject)
  end
end

LoopHorizontalTableFrameImpl.RecycleCell = function(self, logicCell)
  -- function num : 0_23 , upvalues : _ENV
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

LoopHorizontalTableFrameImpl.EstablishSprintTask = function(self, deltaData)
  -- function num : 0_24 , upvalues : _ENV
  local width, height = (self._viewport):GetRectSize()
  local cellNum = (self._delegate):NumberOfCell(self._interface)
  if ((self._logicCells)[1])._pos + deltaData > 0 then
    self._sprintTime = 0.3
    self._needUpdate = true
    local lenofend = -(((self._logicCells)[1])._pos + deltaData)
    self._sprintSpeed = lenofend * 2 / self._sprintTime
    self._taskBeginLogicPosForSprint = {}
    for i = self._logicCellUpIndex, self._logicCellDownIndex do
      -- DECOMPILER ERROR at PC35: Confused about usage of register: R10 in 'UnsetPending'

      (self._taskBeginLogicPosForSprint)[i] = ((self._logicCells)[i])._pos + deltaData
    end
    local first = {pos = self._sprintSpeed}
    local last = {pos = 0}
    self._sprintTask = (Tween.new)(self._sprintTime, first, last, "linear")
  else
    do
      if ((self._logicCells)[cellNum])._pos + ((self._logicCells)[cellNum])._size + deltaData < width then
        self._sprintTime = 0.3
        self._needUpdate = true
        local lenofend = width - (((self._logicCells)[cellNum])._pos + ((self._logicCells)[cellNum])._size + deltaData)
        self._sprintSpeed = lenofend * 2 / self._sprintTime
        self._taskBeginLogicPosForSprint = {}
        for i = self._logicCellUpIndex, self._logicCellDownIndex do
          -- DECOMPILER ERROR at PC87: Confused about usage of register: R10 in 'UnsetPending'

          (self._taskBeginLogicPosForSprint)[i] = ((self._logicCells)[i])._pos + deltaData
        end
        local first = {pos = self._sprintSpeed}
        local last = {pos = 0}
        self._sprintTask = (Tween.new)(self._sprintTime, first, last, "linear")
      end
    end
  end
end

LoopHorizontalTableFrameImpl.SetSlide = function(self, slide, showSoftMask)
  -- function num : 0_25 , upvalues : _ENV
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

LoopHorizontalTableFrameImpl.SetSoftMaskActive = function(self, showSoftMask)
  -- function num : 0_26 , upvalues : _ENV
  ((((CS.PixelNeko).Lua).SoftMaskStaticFunctions).SetSoftMaskActive)((self._viewport)._uiObject, showSoftMask)
end

LoopHorizontalTableFrameImpl.RefreshUIParticleClipper = function(self)
  -- function num : 0_27 , upvalues : _ENV
  self._refreshUIParticleClipper = true
  ;
  (((((CS.PixelNeko).Render).ShaderUtility).UIParticleClipper).RefreshUIParticleClipper)((self._viewport):GetUIObject())
end

return LoopHorizontalTableFrameImpl

