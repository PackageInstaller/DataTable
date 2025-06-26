-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/frame/table/verticaltableframeimpl.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local LogicCell = require("framework.ui.frame.table.logiccell")
local VerticalTableFrameImpl = class("VerticalTableFrameImpl")
VerticalTableFrameImpl.Ctor = function(self, interface, container, delegate, canSlide, autoAlign, viewportName)
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
    LogErrorFormat("VerticalTableFrameImpl", "非法操作: container [%s] 已经创建过frame Viewport", container._uiObject)
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
  self._viewcontainer_sx = (self._viewcontainer):GetSize()
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
  self._moveTopTask = nil
  self._moveBottomTask = nil
  self._moveTopIndexTask = nil
  self._moveDownIndexTask = nil
  self._moveTopIndexDes = nil
  self._moveDownIndexDes = nil
  self._topIndex = nil
  self._downIndex = nil
  self._alignTask = nil
  self._alignDes = nil
  self._moveToAssignedPosTask = nil
  self._moveToAssignedPosDes = nil
end

VerticalTableFrameImpl.Destroy = function(self)
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

VerticalTableFrameImpl.ReloadAllCell = function(self)
  -- function num : 0_2 , upvalues : _ENV, LogicCell, UIManager
  for i,logicCell in ipairs(self._logicCells) do
    if logicCell._cell then
      self:RecycleCell(logicCell)
    end
  end
  self._logicCells = {}
  self._currentPosition = 0 - self._upMargin
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
          ((self._baseCells)[logicCell._dialogName]):SetPosition(0, 0, 0, -10000)
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
        _ = ((logicCell._cell):GetRootWindow()):GetRectSize()
        self:RecycleCell(logicCell)
      end
      do
        logicCell._size = tempSize[logicCell._dialogName]
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
            logicCell._size = h
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

VerticalTableFrameImpl.MoveToTop = function(self, isAnimate)
  -- function num : 0_3 , upvalues : _ENV
  self._needUpdate = true
  if isAnimate then
    local first = {pos = self._currentPosition}
    local last = {pos = 0 - self._upMargin}
    self._moveTopTask = (Tween.new)(0.5, first, last, "outQuad")
  else
    do
      self:ClearAllPositionChangeTask()
      self._currentPosition = 0 - self._upMargin
    end
  end
end

VerticalTableFrameImpl.MoveToBottom = function(self, isAnimate)
  -- function num : 0_4 , upvalues : _ENV
  self._needUpdate = true
  local width, height = (self._viewport):GetRectSize()
  if height < self._totalLength then
    if isAnimate then
      local first = {pos = self._currentPosition}
      local last = {pos = self._totalLength - height + self._downMargin}
      self._moveBottomTask = (Tween.new)(0.5, first, last, "outQuad")
    else
      do
        self:ClearAllPositionChangeTask()
        self._currentPosition = self._totalLength - height + self._downMargin
      end
    end
  end
end

VerticalTableFrameImpl.MoveTopToIndex = function(self, desIndex, isAnimate)
  -- function num : 0_5 , upvalues : _ENV
  self._needUpdate = true
  self._moveDownIndexTask = nil
  local destination = ((self._logicCells)[desIndex])._pos
  local width, height = (self._viewport):GetRectSize()
  if self._totalLength - height + self._downMargin < destination then
    destination = self._totalLength - height + self._downMargin
  else
    destination = destination - self._upMargin
  end
  if destination < 0 - self._upMargin then
    destination = 0 - self._upMargin
  end
  self._moveTopIndexDes = destination
  if isAnimate then
    local first = {pos = self._currentPosition}
    local last = {pos = destination}
    self._moveTopIndexTask = (Tween.new)(0.5, first, last, "linear")
  else
    do
      self:ClearAllPositionChangeTask()
      self._currentPosition = destination
    end
  end
end

VerticalTableFrameImpl.MoveDownToIndex = function(self, desIndex, isAnimate)
  -- function num : 0_6 , upvalues : _ENV
  self._needUpdate = true
  self._moveTopIndexTask = nil
  local width, height = (self._viewport):GetRectSize()
  local destination = ((self._logicCells)[desIndex])._pos + ((self._logicCells)[desIndex])._size - height
  if self._totalLength - height + self._downMargin < destination then
    destination = self._totalLength - height + self._downMargin
  else
    destination = destination + self._downMargin
  end
  if destination < 0 - self._upMargin then
    destination = 0 - self._upMargin
  end
  self._moveDownIndexDes = destination
  if isAnimate then
    local first = {pos = self._currentPosition}
    local last = {pos = destination}
    self._moveDownIndexTask = (Tween.new)(0.5, first, last, "linear")
  else
    do
      self:ClearAllPositionChangeTask()
      self._currentPosition = destination
    end
  end
end

VerticalTableFrameImpl.MoveToAssignedPos = function(self, pos, isAnimate)
  -- function num : 0_7 , upvalues : _ENV
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

VerticalTableFrameImpl.GetTotalLength = function(self)
  -- function num : 0_8
  return self._totalLength
end

VerticalTableFrameImpl.GetCurrentPosition = function(self)
  -- function num : 0_9
  return self._currentPosition
end

VerticalTableFrameImpl.ReloadCellsAtIndex = function(self, indexList, isAnimate)
  -- function num : 0_10 , upvalues : _ENV, UIManager
  if type(indexList) ~= "table" then
    LogError("VerticalTableFrameImpl", "please input a table value")
    return 
  end
  local cellNums = (self._delegate):NumberOfCell(self._interface)
  for _,index in pairs(indexList) do
    if not index or cellNums < index then
      LogErrorFormat("VerticalTableFrameImpl", "the index %d is out of range", index)
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
        ((self._baseCells)[logicCell._dialogName]):SetPosition(0, 0, 0, -10000)
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
      self._totalLength = self._totalLength + delta
      do
        local width, height = (self._viewport):GetRectSize()
        if height < self._totalLength + self._downMargin and self._totalLength - height + self._downMargin < self._currentPosition then
          self._currentPosition = self._totalLength - height + self._downMargin
        else
          if self._totalLength < height then
            self._currentPosition = 0 - self._upMargin
          end
        end
        self._needUpdate = true
        -- DECOMPILER ERROR at PC141: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  self:UpdateView(0)
end

VerticalTableFrameImpl.RemoveCellsAtIndex = function(self, indexList, isAnimate)
  -- function num : 0_11 , upvalues : _ENV
  if type(indexList) ~= "table" then
    LogError("VerticalTableFrameImpl", "please input a table value")
    return 
  end
  self._needUpdate = true
  local width, height = (self._viewport):GetRectSize()
  local currentPosition = self._currentPosition
  for _,index in ipairs(indexList) do
    local cellNums = #self._logicCells
    if cellNums < index then
      LogErrorFormat("VerticalTableFrameImpl", "Wrong index %d", index)
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
        if isAnimate and currentPosition < pos + gap and pos < currentPosition + height then
          self._removeTask = {}
          for i = 1, index - 1 do
            -- DECOMPILER ERROR at PC96: Confused about usage of register: R18 in 'UnsetPending'

            (self._removeDes)[i] = ((self._logicCells)[i])._pos - gap
            local first = {pos = ((self._logicCells)[i])._pos}
            local last = {pos = (self._removeDes)[i]}
            -- DECOMPILER ERROR at PC114: Confused about usage of register: R20 in 'UnsetPending'

            ;
            (self._removeTask)[i] = (Tween.new)(0.1, first, last, "linear")
          end
        else
          do
            for i = 1, index - 1 do
              -- DECOMPILER ERROR at PC127: Confused about usage of register: R18 in 'UnsetPending'

              ((self._logicCells)[i])._pos = ((self._logicCells)[i])._pos - gap
            end
            do
              do
                ;
                (table.remove)(self._logicCells, index)
                self._totalLength = self._totalLength - gap
                if height < self._totalLength and self._totalLength - height < self._currentPosition then
                  self._currentPosition = self._totalLength - height
                else
                  if self._totalLength < height then
                    self._currentPosition = 0
                  end
                end
                -- DECOMPILER ERROR at PC153: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC153: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC153: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC153: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC153: LeaveBlock: unexpected jumping out DO_STMT

              end
            end
          end
        end
      end
    end
  end
end

VerticalTableFrameImpl.InsertCellsAtIndex = function(self, indexList, isAnimate)
  -- function num : 0_12 , upvalues : _ENV, LogicCell, UIManager
  if indexList and type(indexList) ~= "table" then
    LogError("VerticalTableFrameImpl", "please input a table value")
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
      LogError("VerticalTableFrameImpl", "no additional data")
      return 
    end
  end
  for _,index in ipairs(indexList) do
    cellNums = #self._logicCells
    if not index or cellNums + 1 < index and not lastinsert then
      LogErrorFormat("VerticalTableFrameImpl", "Wrong index %d", index)
      return 
    end
    local logicCell = (LogicCell.Create)()
    logicCell._dialogName = (self._delegate):CellAtIndex(self._interface, index)
    do
      if not (self._baseCells)[logicCell._dialogName] then
        local dialogDefine = require("logic.dialog." .. logicCell._dialogName)
        -- DECOMPILER ERROR at PC97: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (self._baseCells)[logicCell._dialogName] = (UIManager.CreateLuaWindow)(dialogDefine.AssetBundleName .. ".assetbundle", dialogDefine.AssetName, (self._viewcontainer)._uiObject)
        ;
        ((self._baseCells)[logicCell._dialogName]):SetPosition(0, 0, 0, -10000)
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
          local _ = 0
          _ = ((logicCell._cell):GetRootWindow()):GetRectSize()
          self:RecycleCell(logicCell)
        end
        do
          logicCell._size = tempSize[logicCell._dialogName]
          self:GetCellDialog(logicCell)
          -- DECOMPILER ERROR at PC166: Confused about usage of register: R14 in 'UnsetPending'

          ;
          (logicCell._cell)._delegate = self._delegate
          -- DECOMPILER ERROR at PC169: Confused about usage of register: R14 in 'UnsetPending'

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
                -- DECOMPILER ERROR at PC195: Confused about usage of register: R19 in 'UnsetPending'

                ((self._logicCells)[i])._pos = (self._removeDes)[i]
                -- DECOMPILER ERROR at PC197: Confused about usage of register: R19 in 'UnsetPending'

                ;
                (self._removeDes)[i] = nil
                -- DECOMPILER ERROR at PC199: Confused about usage of register: R19 in 'UnsetPending'

                ;
                (self._removeTask)[i] = nil
              end
            end
            do
              if #self._insertTask ~= 0 then
                for i,task in pairs(self._insertTask) do
                  local logicCell = (self._logicCells)[i]
                  logicCell._pos = (self._insertDes)[i]
                  -- DECOMPILER ERROR at PC216: Confused about usage of register: R20 in 'UnsetPending'

                  ;
                  (self._insertDes)[i] = nil
                  -- DECOMPILER ERROR at PC218: Confused about usage of register: R20 in 'UnsetPending'

                  ;
                  (self._insertTask)[i] = nil
                end
              end
              do
                ;
                (table.insert)(self._logicCells, index, logicCell)
                if isAnimate then
                  self._insertTask = {}
                  for i = 1, index - 1 do
                    -- DECOMPILER ERROR at PC241: Confused about usage of register: R18 in 'UnsetPending'

                    (self._insertDes)[i] = ((self._logicCells)[i])._pos + logicCell._size
                    local first = {pos = ((self._logicCells)[i])._pos}
                    local last = {pos = (self._insertDes)[i]}
                    -- DECOMPILER ERROR at PC259: Confused about usage of register: R20 in 'UnsetPending'

                    ;
                    (self._insertTask)[i] = (Tween.new)(0.2, first, last, "linear")
                  end
                  -- DECOMPILER ERROR at PC273: Confused about usage of register: R14 in 'UnsetPending'

                  if index <= cellNums then
                    (self._insertDes)[index] = ((self._logicCells)[index + 1])._pos + ((self._logicCells)[index + 1])._size
                    local first = {pos = ((self._logicCells)[index + 1])._pos}
                    local last = {pos = (self._insertDes)[index]}
                    -- DECOMPILER ERROR at PC292: Confused about usage of register: R16 in 'UnsetPending'

                    ;
                    (self._insertTask)[index] = (Tween.new)(0.2, first, last, "linear")
                  else
                    do
                      -- DECOMPILER ERROR at PC295: Confused about usage of register: R14 in 'UnsetPending'

                      ;
                      (self._insertDes)[index] = 0
                      local first = {pos = -((self._logicCells)[index])._size}
                      do
                        local last = {pos = (self._insertDes)[index]}
                        -- DECOMPILER ERROR at PC314: Confused about usage of register: R16 in 'UnsetPending'

                        ;
                        (self._insertTask)[index] = (Tween.new)(0.2, first, last, "linear")
                        if index <= cellNums then
                          logicCell._pos = ((self._logicCells)[index + 1])._pos + ((self._logicCells)[index + 1])._size
                        else
                          logicCell._pos = 0
                        end
                        for i = 1, index - 1 do
                          -- DECOMPILER ERROR at PC341: Confused about usage of register: R18 in 'UnsetPending'

                          ((self._logicCells)[i])._pos = ((self._logicCells)[i])._pos + logicCell._size
                        end
                        do
                          do
                            self._totalLength = self._totalLength + logicCell._size
                            -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                            -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out IF_STMT

                            -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out IF_STMT

                            -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out IF_STMT

                            -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out DO_STMT

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

VerticalTableFrameImpl.GetTopIndex = function(self)
  -- function num : 0_13
  return self._topIndex
end

VerticalTableFrameImpl.GetDownIndex = function(self)
  -- function num : 0_14
  return self._downIndex
end

VerticalTableFrameImpl.SetMargin = function(self, upValue, downValue)
  -- function num : 0_15
  if self._upMargin == 0 then
    self._upMargin = upValue
  end
  if self._downMargin == 0 then
    self._downMargin = downValue
  end
end

VerticalTableFrameImpl.OnBeginDrag = function(self, args)
  -- function num : 0_16
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

VerticalTableFrameImpl.OnDrag = function(self, args)
  -- function num : 0_17 , upvalues : UIManager
  local pressPosition = args.pressPosition
  local position = args.position
  local _, localPressY = (UIManager.ScreenPointToLocalPointInRectangle)((self._viewport)._uiObject, pressPosition.x, pressPosition.y)
  local _, localY = (UIManager.ScreenPointToLocalPointInRectangle)((self._viewport)._uiObject, position.x, position.y)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self._moveSpeed).x = args.xSpeed / 60
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self._moveSpeed).y = args.ySpeed / 60
  local currentPosition = self._currentPosition
  self._currentPosition = currentPosition - self._dragDelta
  self._dragDelta = localY - localPressY
  self._currentPosition = self._currentPosition + self._dragDelta
  if currentPosition ~= self._currentPosition then
    self._needUpdate = true
    self:UpdateView(0)
  end
end

VerticalTableFrameImpl.OnEndDrag = function(self, args)
  -- function num : 0_18 , upvalues : UIManager, _ENV
  local dragDelta = self._dragDelta
  self._dragDelta = 0
  local _, original = (UIManager.ScreenPointToLocalPointInRectangle)((self._viewport)._uiObject, 0, 0)
  local _, speed = (UIManager.ScreenPointToLocalPointInRectangle)((self._viewport)._uiObject, (self._moveSpeed).x, (self._moveSpeed).y)
  speed = original - speed
  local currentPosition = self._currentPosition
  local width, height = (self._viewport):GetRectSize()
  if speed == 0 then
    (self._viewcontainer):SetBlocksRaycasts(true)
    if self._autoAlign then
      if dragDelta < 0 then
        self._needUpdate = true
        local half = ((self._logicCells)[self._topIndex])._pos + ((self._logicCells)[self._topIndex])._size / 2
        if half < self._currentPosition then
          local first = {pos = self._currentPosition}
          if self._topIndex - 1 > 0 then
            self._alignDes = ((self._logicCells)[self._topIndex - 1])._pos
            local last = {pos = self._alignDes}
            self._alignTask = (Tween.new)(0.2, first, last, "outQuad")
          end
        else
          do
            if self._currentPosition <= half then
              local first = {pos = self._currentPosition}
              self._alignDes = ((self._logicCells)[self._topIndex])._pos
              local last = {pos = self._alignDes}
              self._alignTask = (Tween.new)(0.2, first, last, "outQuad")
            end
            do
              if dragDelta > 0 then
                self._needUpdate = true
                local half = ((self._logicCells)[self._downIndex])._pos + ((self._logicCells)[self._downIndex])._size / 2
                if half <= self._currentPosition + height then
                  local first = {pos = self._currentPosition}
                  self._alignDes = ((self._logicCells)[self._downIndex])._pos + ((self._logicCells)[self._downIndex])._size - height
                  local last = {pos = self._alignDes}
                  self._alignTask = (Tween.new)(0.2, first, last, "outQuad")
                else
                  do
                    if self._currentPosition + height < half then
                      local first = {pos = self._currentPosition}
                      local cellNums = #self._logicCells
                      if self._downIndex + 1 <= cellNums then
                        self._alignDes = ((self._logicCells)[self._downIndex + 1])._pos + ((self._logicCells)[self._downIndex + 1])._size - height
                        local last = {pos = self._alignDes}
                        self._alignTask = (Tween.new)(0.2, first, last, "outQuad")
                      end
                    end
                    do
                      if currentPosition + height <= self._totalLength + self._downMargin and 0 - self._upMargin <= currentPosition then
                        self._needUpdate = true
                        self._slideInertiaPosition = currentPosition
                        self._slideInertiaSpeed = (speed) * 20
                        self._sprintTask = nil
                        self._sprintPosition = nil
                        local lenofend = (speed) * 20 * self._slideInertiaTime / 2
                        currentPosition = currentPosition - lenofend
                        if self._totalLength - height + height / 3 + self._downMargin < currentPosition then
                          currentPosition = self._totalLength - height + height / 3 + self._downMargin
                          lenofend = self._slideInertiaPosition - (currentPosition)
                          self._slideInertiaTime = (lenofend) * 2 / self._slideInertiaSpeed
                        end
                        if currentPosition < -height / 3 - self._upMargin then
                          currentPosition = -height / 3 - self._upMargin
                          lenofend = self._slideInertiaPosition - (currentPosition)
                          self._slideInertiaTime = (lenofend) * 2 / self._slideInertiaSpeed
                        end
                        local first = {pos = self._slideInertiaSpeed}
                        local last = {pos = 0}
                        self._slideInertiaTask = (Tween.new)(self._slideInertiaTime, first, last, "linear")
                      end
                      do
                        if self._totalLength + self._downMargin < currentPosition + height then
                          self._sprintPosition = currentPosition
                          self._needUpdate = true
                          local lenofend = currentPosition - self._totalLength + height - self._downMargin
                          if self._totalLength + self._downMargin < height then
                            lenofend = currentPosition + self._upMargin
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
                          if currentPosition < 0 - self._upMargin then
                            self._sprintPosition = currentPosition
                            self._needUpdate = true
                            local lenofend = currentPosition + self._upMargin
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

VerticalTableFrameImpl.OnPointerDown = function(self, args)
  -- function num : 0_19 , upvalues : _ENV
  self._dragDelta = 0
  if self._slideInertiaTask then
    self._slideInertiaTask = nil
    ;
    (self._viewcontainer):SetBlocksRaycasts(true)
    if self._sprintTask then
      local width, height = (self._viewport):GetRectSize()
      local currentPosition = self._currentPosition
      if self._totalLength + self._downMargin < currentPosition + height then
        self._sprintPosition = currentPosition
        self._needUpdate = true
        local lenofend = currentPosition - self._totalLength + height - self._downMargin
        if self._totalLength + self._downMargin < height then
          lenofend = currentPosition + self._upMargin
        end
        self._sprintSpeed = (lenofend) * 2 / self._sprintTime
        local first = {pos = self._sprintSpeed}
        local last = {pos = 0}
        self._sprintTask = (Tween.new)(self._sprintTime, first, last, "linear")
      else
        do
          if currentPosition < 0 - self._upMargin then
            self._sprintPosition = currentPosition
            self._needUpdate = true
            local lenofend = currentPosition + self._upMargin
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

VerticalTableFrameImpl.OnPointerUp = function(self, args)
  -- function num : 0_20
  self._sprintclickdown = false
  self:UpdateView(0)
end

VerticalTableFrameImpl.OnLateUpdate = function(self, notification)
  -- function num : 0_21 , upvalues : _ENV
  local deltaTime = (notification.userInfo).unscaledDeltaTime
  local width, height = (self._viewport):GetRectSize()
  if self._needUpdate then
    if self._slideInertiaTask then
      if (self._slideInertiaTask):update(deltaTime) then
        self._currentPosition = self._slideInertiaPosition - (self._slideInertiaSpeed + ((self._slideInertiaTask).subject).pos) * self._slideInertiaTime / 2
        if self._autoAlign then
          if self._slideInertiaSpeed < 0 then
            local half = ((self._logicCells)[self._topIndex])._pos + ((self._logicCells)[self._topIndex])._size / 2
            if half < self._currentPosition then
              local first = {pos = self._currentPosition}
              if self._topIndex - 1 > 0 then
                self._alignDes = ((self._logicCells)[self._topIndex - 1])._pos
                local last = {pos = self._alignDes}
                self._alignTask = (Tween.new)(0.3, first, last, "linear")
              end
            else
              do
                if self._currentPosition <= half then
                  local first = {pos = self._currentPosition}
                  self._alignDes = ((self._logicCells)[self._topIndex])._pos
                  local last = {pos = self._alignDes}
                  self._alignTask = (Tween.new)(0.3, first, last, "linear")
                end
                do
                  if self._slideInertiaSpeed > 0 then
                    local half = ((self._logicCells)[self._downIndex])._pos + ((self._logicCells)[self._downIndex])._size / 2
                    if half <= self._currentPosition + height then
                      local first = {pos = self._currentPosition}
                      self._alignDes = ((self._logicCells)[self._downIndex])._pos + ((self._logicCells)[self._downIndex])._size - height
                      local last = {pos = self._alignDes}
                      self._alignTask = (Tween.new)(0.3, first, last, "linear")
                    else
                      do
                        if self._currentPosition + height < half then
                          local first = {pos = self._currentPosition}
                          local cellNums = #self._logicCells
                          if self._downIndex + 1 <= cellNums then
                            self._alignDes = ((self._logicCells)[self._downIndex + 1])._pos + ((self._logicCells)[self._downIndex + 1])._size - height
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

                          if self._slideInertiaTask and (self._totalLength - height + self._downMargin < self._currentPosition or self._currentPosition < 0 - self._upMargin) then
                            (self._slideInertiaTask).clock = (self._slideInertiaTask).clock + 2 * deltaTime
                          end
                          if self._totalLength - height + height / 3 + self._downMargin < self._currentPosition then
                            self._currentPosition = self._totalLength - height + height / 3 + self._downMargin
                            self._slideInertiaTask = nil
                            self._slideInertiaPosition = nil
                            ;
                            (self._viewcontainer):SetBlocksRaycasts(true)
                          end
                          if self._currentPosition < -height / 3 - self._upMargin then
                            self._currentPosition = -height / 3 - self._upMargin
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
                              if (self._delegate).OnSprintTaskEndDrag then
                                (self._delegate):OnSprintTaskEndDrag(self._interface)
                              end
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
                                -- DECOMPILER ERROR at PC351: Confused about usage of register: R11 in 'UnsetPending'

                                ;
                                (self._insertDes)[i] = nil
                                -- DECOMPILER ERROR at PC353: Confused about usage of register: R11 in 'UnsetPending'

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
                                  -- DECOMPILER ERROR at PC378: Confused about usage of register: R11 in 'UnsetPending'

                                  ;
                                  (self._removeDes)[i] = nil
                                  -- DECOMPILER ERROR at PC380: Confused about usage of register: R11 in 'UnsetPending'

                                  ;
                                  (self._removeTask)[i] = nil
                                else
                                  logicCell._pos = (task.subject).pos
                                end
                              end
                            end
                            do
                              if self._moveTopTask then
                                if (self._moveTopTask):update(deltaTime) then
                                  self._currentPosition = 0 - self._upMargin
                                  self._moveTopTask = nil
                                else
                                  self._currentPosition = ((self._moveTopTask).subject).pos
                                end
                              end
                              if self._moveBottomTask then
                                if (self._moveBottomTask):update(deltaTime) then
                                  self._currentPosition = self._totalLength - height + self._downMargin
                                  self._moveBottomTask = nil
                                else
                                  self._currentPosition = ((self._moveBottomTask).subject).pos
                                end
                              end
                              if self._moveTopIndexTask then
                                if (self._moveTopIndexTask):update(deltaTime) then
                                  self._currentPosition = self._moveTopIndexDes
                                  self._moveTopIndexTask = nil
                                else
                                  self._currentPosition = ((self._moveTopIndexTask).subject).pos
                                end
                              end
                              if self._moveDownIndexTask then
                                if (self._moveDownIndexTask):update(deltaTime) then
                                  self._currentPosition = self._moveDownIndexDes
                                  self._moveDownIndexTask = nil
                                else
                                  self._currentPosition = ((self._moveDownIndexTask).subject).pos
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

VerticalTableFrameImpl.UpdateView = function(self, deltaTime)
  -- function num : 0_22 , upvalues : _ENV
  if self._needUpdate then
    local currentPosition = self._currentPosition
    local width, height = (self._viewport):GetRectSize()
    if height < self._totalLength + self._upMargin then
      if currentPosition < 0 - self._upMargin then
        currentPosition = currentPosition - 2 * (currentPosition + self._upMargin) / 3
      end
      if self._totalLength + self._downMargin < currentPosition + height then
        currentPosition = currentPosition - 2 * (height - self._totalLength + (currentPosition) - self._downMargin) / 3
      end
    else
      currentPosition = currentPosition + self._upMargin
      currentPosition = (currentPosition) / 3
    end
    local flag = true
    for i,logicCell in ipairs(self._logicCells) do
      if currentPosition - self._upMargin < logicCell._pos + logicCell._size and logicCell._pos < currentPosition + height + self._downMargin then
        if flag then
          flag = false
          self._downIndex = i
        end
        self._topIndex = i
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
    for i,logicCell in ipairs(self._logicCells) do
      if logicCell._visible then
        if not logicCell._cell then
          self:GetCellDialog(logicCell)
          -- DECOMPILER ERROR at PC97: Confused about usage of register: R11 in 'UnsetPending'

          ;
          (logicCell._cell)._delegate = self._delegate
          -- DECOMPILER ERROR at PC100: Confused about usage of register: R11 in 'UnsetPending'

          ;
          (logicCell._cell)._cellData = logicCell._data
          ;
          (logicCell._cell):RefreshCell(logicCell._data)
        end
        ;
        ((logicCell._cell):GetRootWindow()):SetPosition(0, 0, 1, -logicCell._pos - logicCell._size)
        if self._cellX == -1 then
          local y = nil
          self._cellX = ((logicCell._cell):GetRootWindow()):GetRectSize()
        end
      end
    end
    if self._refreshUIParticleClipper and self._refreshPosY then
      self._refreshPosY = false
      ;
      (((((CS.PixelNeko).Render).ShaderUtility).UIParticleClipper).RefreshUIParticleClipper)((self._viewport):GetUIObject())
    end
    for dialogName,cells in pairs(self._recycleCells) do
      -- DECOMPILER ERROR at PC151: Overwrote pending register: R11 in 'AssignReg'

      for i,cell in y(cells) do
        (cell:GetRootWindow()):SetPosition(0, 0, 0, -10000)
      end
    end
    ;
    (self._viewcontainer):SetSize(0, self._cellX, 0, self._totalLength)
    local viewportX, y = (self._viewport):GetRectSize()
    if height < self._totalLength + self._upMargin then
      (self._viewcontainer):SetPosition(0, (viewportX - self._cellX) / 2, 0, currentPosition - self._totalLength + height)
    else
      ;
      (self._viewcontainer):SetPosition(0, (viewportX - self._cellX) / 2, 0, currentPosition + height - self._totalLength - self._upMargin)
    end
    do
      if self._leftMargin ~= 0 or self._rightMargin ~= 0 then
        local aMinX, aMinY, aMaxX, aMaxY, oMinX, oMinY, oMaxX, oMaxY = (self._viewcontainer):GetAnchorAndOffset()
        ;
        (self._viewcontainer):SetAnchorAndOffset(0, aMinY, 1, aMaxY, self._leftMargin, oMinY, -self._rightMargin, oMaxY)
      end
      if not self._sprintTask and not self._slideInertiaTask and #self._insertTask == 0 and #self._removeTask == 0 and not self._moveTopTask and not self._moveBottomTask and not self._moveTopIndexTask and not self._moveDownIndexTask and not self._alignTask and not self._moveToAssignedPosTask then
        self._needUpdate = false
      end
      if (self._delegate).OnCurPosChange then
        local width, height = (self._viewport):GetRectSize()
        local ratio = 0
        if height < self._totalLength then
          ratio = self._currentPosition / (self._totalLength - height)
          if ratio < 0 then
            ratio = (self._currentPosition + self._upMargin) / (self._totalLength - height)
          end
          if ratio > 1 then
            ratio = (self._currentPosition - self._downMargin) / (self._totalLength - height)
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

VerticalTableFrameImpl.GetCellDialog = function(self, logicCell)
  -- function num : 0_23 , upvalues : _ENV
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

VerticalTableFrameImpl.RecycleCell = function(self, logicCell)
  -- function num : 0_24 , upvalues : _ENV
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

VerticalTableFrameImpl.SetSlide = function(self, slide, showSoftMask)
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

VerticalTableFrameImpl.SetSoftMaskActive = function(self, showSoftMask)
  -- function num : 0_26 , upvalues : _ENV
  ((((CS.PixelNeko).Lua).SoftMaskStaticFunctions).SetSoftMaskActive)((self._viewport)._uiObject, showSoftMask)
end

VerticalTableFrameImpl.FireEvent = function(self, eventName, ...)
  -- function num : 0_27 , upvalues : _ENV
  for i,logicCell in ipairs(self._logicCells) do
    if logicCell._cell and (logicCell._cell).OnEvent then
      (logicCell._cell):OnEvent(eventName, ...)
    end
  end
end

VerticalTableFrameImpl.RefreshUIParticleClipper = function(self)
  -- function num : 0_28 , upvalues : _ENV
  self._refreshUIParticleClipper = true
  ;
  (((((CS.PixelNeko).Render).ShaderUtility).UIParticleClipper).RefreshUIParticleClipper)((self._viewport):GetUIObject())
end

VerticalTableFrameImpl.ClearAllPositionChangeTask = function(self)
  -- function num : 0_29
  self._slideInertiaTask = nil
  self._sprintTask = nil
  self._moveTopTask = nil
  self._moveBottomTask = nil
  self._moveTopIndexTask = nil
  self._moveDownIndexTask = nil
  self._moveToAssignedPosTask = nil
end

return VerticalTableFrameImpl

