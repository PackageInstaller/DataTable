-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/frame/grid/verticalgridframeimpl.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local LogicCell = require("framework.ui.frame.grid.logiccell")
local VerticalGridFrameImpl = class("VerticalGridFrameImpl")
VerticalGridFrameImpl.Ctor = function(self, interface, container, delegate, columnNums, canSlide, viewportName, rightToLeft)
  -- function num : 0_0 , upvalues : _ENV
  self._interface = interface
  self._container = container
  self._delegate = delegate
  self._canSlide = canSlide
  self._columnNums = columnNums
  self._rightToLeft = rightToLeft
  self._recycleCells = {}
  self._logicCells = {}
  self._baseCells = {}
  if (((((CS.PixelNeko).Lua).UI).FrameStaticFunctions).GetFrameChildCount)(container._uiObject) > 0 then
    LogErrorFormat("VerticalGridFrameImpl", "非法操作: container [%s] 已经创建过frame Viewport", container._uiObject)
  end
  self._viewport = ((((CS.PixelNeko).UI).UIManager).CreateLuaWindow)("ui/widgets.assetbundle", viewportName, container._uiObject)
  ;
  (((((CS.PixelNeko).Lua).UI).FrameStaticFunctions).AddFrameChild)(container._uiObject, (self._viewport)._uiObject)
  self._viewcontainer = ((((CS.PixelNeko).UI).UIManager).GetChildLuaWindow)((self._viewport)._uiObject, "_Containter")
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

VerticalGridFrameImpl.Destroy = function(self)
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

VerticalGridFrameImpl.GetTotalLength = function(self)
  -- function num : 0_2
  return self._totalLength
end

VerticalGridFrameImpl.GetCurrentPosition = function(self)
  -- function num : 0_3
  return self._currentPosition
end

VerticalGridFrameImpl.ReloadAllCell = function(self)
  -- function num : 0_4 , upvalues : _ENV, LogicCell, UIManager
  for i,logicCell in ipairs(self._logicCells) do
    if logicCell._cell then
      self:RecycleCell(logicCell)
    end
  end
  self._logicCells = {}
  self._currentPosition = 0 - self._upMargin
  self._totalLength = 0
  local cellNums = (self._delegate):NumberOfCell(self._interface)
  for i = 1, cellNums do
    local logicCell = (LogicCell.Create)()
    logicCell._dialogName = (self._delegate):CellAtIndex(self._interface, i)
    do
      do
        if not (self._baseCells)[logicCell._dialogName] then
          local dialogDefine = require("logic.dialog." .. logicCell._dialogName)
          -- DECOMPILER ERROR at PC54: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (self._baseCells)[logicCell._dialogName] = (UIManager.CreateLuaWindow)(dialogDefine.AssetBundleName .. ".assetbundle", dialogDefine.AssetName, (self._viewcontainer)._uiObject)
          ;
          ((self._baseCells)[logicCell._dialogName]):SetPosition(0, 0, 0, -10000)
        end
        logicCell._data = (self._delegate):DataAtIndex(self._interface, i)
        -- DECOMPILER ERROR at PC71: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (self._logicCells)[i] = logicCell
        -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  for i,logicCell in ipairs(self._logicCells) do
    local row, column = (i - 1) // self._columnNums, (i - 1) % self._columnNums
    if self._rightToLeft then
      column = self._columnNums - column - 1
    end
    logicCell._row = row
    logicCell._col = column
    if self._cellSizeX == 0 or self._cellSizeY == 0 then
      self:GetCellDialog(logicCell)
      -- DECOMPILER ERROR at PC102: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (logicCell._cell)._delegate = self._delegate
      -- DECOMPILER ERROR at PC105: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (logicCell._cell)._cellData = logicCell._data
      ;
      (logicCell._cell):RefreshCell(logicCell._data)
      self._cellSizeX = ((logicCell._cell):GetRootWindow()):GetRectSize()
      self:RecycleCell(logicCell)
    end
    logicCell._posX = (column) * self._cellSizeX
    logicCell._posY = row * self._cellSizeY
    self._totalLength = (row + 1) * self._cellSizeY
  end
  self._needUpdate = true
  self:UpdateView(0)
end

VerticalGridFrameImpl.MoveToTop = function(self, isAnimate)
  -- function num : 0_5 , upvalues : _ENV
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

VerticalGridFrameImpl.MoveToBottom = function(self, isAnimate)
  -- function num : 0_6 , upvalues : _ENV
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

VerticalGridFrameImpl.MoveTopToIndex = function(self, desIndex, isAnimate)
  -- function num : 0_7 , upvalues : _ENV
  self._needUpdate = true
  self._moveDownIndexTask = nil
  local destination = ((self._logicCells)[desIndex])._posY
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

VerticalGridFrameImpl.MoveDownToIndex = function(self, desIndex, isAnimate)
  -- function num : 0_8 , upvalues : _ENV
  self._needUpdate = true
  self._moveTopIndexTask = nil
  local width, height = (self._viewport):GetRectSize()
  local destination = ((self._logicCells)[desIndex])._posY + self._cellSizeY - height
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

VerticalGridFrameImpl.MoveToAssignedPos = function(self, pos, isAnimate)
  -- function num : 0_9 , upvalues : _ENV
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

VerticalGridFrameImpl.ReloadCellsAtIndex = function(self, indexList, isAnimate)
  -- function num : 0_10 , upvalues : _ENV, UIManager
  if type(indexList) ~= "table" then
    LogError("VerticalGridFrameImpl", "please input a table value")
    return 
  end
  local cellNums = (self._delegate):NumberOfCell(self._interface)
  for _,index in pairs(indexList) do
    if not index or cellNums < index then
      LogErrorFormat("VerticalGridFrameImpl", "the index %d is out of range", index)
      return 
    end
    local logicCell = (self._logicCells)[index]
    logicCell._dialogName = (self._delegate):CellAtIndex(self._interface, index)
    do
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
        (logicCell._cell)._cellData = logicCell._data
        ;
        (logicCell._cell):RefreshCell(logicCell._data)
        self:RecycleCell(logicCell)
        -- DECOMPILER ERROR at PC86: Confused about usage of register: R10 in 'UnsetPending'

        ;
        (self._logicCells)[index] = logicCell
        -- DECOMPILER ERROR at PC87: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  self:UpdateView(0)
end

VerticalGridFrameImpl.RemoveCellsAtIndex = function(self, indexList, isAnimate)
  -- function num : 0_11 , upvalues : _ENV
  if type(indexList) ~= "table" then
    LogError("VerticalGridFrameImpl", "please input a table value")
    return 
  end
  self._needUpdate = true
  local width, height = (self._viewport):GetRectSize()
  for _,index in ipairs(indexList) do
    local cellNums = #self._logicCells
    if cellNums < index then
      LogErrorFormat("VerticalGridFrameImpl", "Wrong index %d", index)
      return 
    end
    local posX = ((self._logicCells)[index])._posX
    local posY = ((self._logicCells)[index])._posY
    self:RecycleCell((self._logicCells)[index])
    for i = index + 1, cellNums do
      -- DECOMPILER ERROR at PC58: Confused about usage of register: R17 in 'UnsetPending'

      if self._rightToLeft then
        if ((self._logicCells)[i])._col == self._columnNums - 1 then
          ((self._logicCells)[i])._row = ((self._logicCells)[i])._row - 1
          -- DECOMPILER ERROR at PC61: Confused about usage of register: R17 in 'UnsetPending'

          ;
          ((self._logicCells)[i])._col = 0
        else
          -- DECOMPILER ERROR at PC69: Confused about usage of register: R17 in 'UnsetPending'

          ;
          ((self._logicCells)[i])._col = ((self._logicCells)[i])._col + 1
        end
      else
        -- DECOMPILER ERROR at PC82: Confused about usage of register: R17 in 'UnsetPending'

        if ((self._logicCells)[i])._col == 0 then
          ((self._logicCells)[i])._row = ((self._logicCells)[i])._row - 1
          -- DECOMPILER ERROR at PC87: Confused about usage of register: R17 in 'UnsetPending'

          ;
          ((self._logicCells)[i])._col = self._columnNums - 1
        else
          -- DECOMPILER ERROR at PC95: Confused about usage of register: R17 in 'UnsetPending'

          ;
          ((self._logicCells)[i])._col = ((self._logicCells)[i])._col - 1
        end
      end
      -- DECOMPILER ERROR at PC103: Confused about usage of register: R17 in 'UnsetPending'

      ;
      ((self._logicCells)[i])._posX = ((self._logicCells)[i])._col * self._cellSizeX
      -- DECOMPILER ERROR at PC111: Confused about usage of register: R17 in 'UnsetPending'

      ;
      ((self._logicCells)[i])._posY = ((self._logicCells)[i])._row * self._cellSizeY
    end
    ;
    (table.remove)(self._logicCells, index)
    self._totalLength = ((cellNums - 1 - 1) // self._columnNums + 1) * self._cellSizeY
  end
end

VerticalGridFrameImpl.InsertCellsAtIndex = function(self, indexList, isAnimate)
  -- function num : 0_12 , upvalues : _ENV, LogicCell, UIManager
  if indexList and type(indexList) ~= "table" then
    LogError("VerticalGridFrameImpl", "please input a table value")
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
      LogError("VerticalGridFrameImpl", "no additional data")
      return 
    end
  end
  for _,index in ipairs(indexList) do
    cellNums = #self._logicCells
    if not index or cellNums + 1 < index and not lastinsert then
      LogErrorFormat("VerticalGridFrameImpl", "Wrong index %d", index)
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
      do
        local row, column = (index - 1) // self._columnNums, (index - 1) % self._columnNums
        if self._rightToLeft then
          column = self._columnNums - column - 1
        end
        logicCell._row = row
        logicCell._col = column
        self:GetCellDialog(logicCell)
        -- DECOMPILER ERROR at PC132: Confused about usage of register: R13 in 'UnsetPending'

        ;
        (logicCell._cell)._delegate = self._delegate
        -- DECOMPILER ERROR at PC135: Confused about usage of register: R13 in 'UnsetPending'

        ;
        (logicCell._cell)._cellData = logicCell._data
        ;
        (logicCell._cell):RefreshCell(logicCell._data)
        self._cellSizeX = ((logicCell._cell):GetRootWindow()):GetRectSize()
        self:RecycleCell(logicCell)
        logicCell._posX = (column) * self._cellSizeX
        logicCell._posY = row * self._cellSizeY
        ;
        (table.insert)(self._logicCells, index, logicCell)
        cellNums = #self._logicCells
        for i = index + 1, cellNums do
          -- DECOMPILER ERROR at PC177: Confused about usage of register: R17 in 'UnsetPending'

          if ((self._logicCells)[i])._col == self._columnNums - 1 then
            ((self._logicCells)[i])._col = 0
            -- DECOMPILER ERROR at PC184: Confused about usage of register: R17 in 'UnsetPending'

            ;
            ((self._logicCells)[i])._row = ((self._logicCells)[i])._row + 1
          else
            -- DECOMPILER ERROR at PC192: Confused about usage of register: R17 in 'UnsetPending'

            ;
            ((self._logicCells)[i])._col = ((self._logicCells)[i])._col + 1
          end
          -- DECOMPILER ERROR at PC200: Confused about usage of register: R17 in 'UnsetPending'

          ;
          ((self._logicCells)[i])._posX = ((self._logicCells)[i])._col * self._cellSizeX
          -- DECOMPILER ERROR at PC208: Confused about usage of register: R17 in 'UnsetPending'

          ;
          ((self._logicCells)[i])._posY = ((self._logicCells)[i])._row * self._cellSizeY
        end
        self._totalLength = ((cellNums - 1) // self._columnNums + 1) * self._cellSizeY
        -- DECOMPILER ERROR at PC217: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
end

VerticalGridFrameImpl.FireEvent = function(self, eventName, ...)
  -- function num : 0_13 , upvalues : _ENV
  for i,logicCell in ipairs(self._logicCells) do
    if logicCell._cell and (logicCell._cell).OnEvent then
      (logicCell._cell):OnEvent(eventName, ...)
    end
  end
end

VerticalGridFrameImpl.FireIndexCellEvent = function(self, eventName, index, ...)
  -- function num : 0_14
  local logicCell = (self._logicCells)[index]
  if not logicCell then
    return 
  end
  if logicCell._cell and (logicCell._cell).OnEvent then
    (logicCell._cell):OnEvent(eventName, ...)
  end
end

VerticalGridFrameImpl.SetMargin = function(self, upValue, downValue)
  -- function num : 0_15
  if self._upMargin == 0 then
    self._upMargin = upValue
  end
  if self._downMargin == 0 then
    self._downMargin = downValue
  end
end

VerticalGridFrameImpl.OnBeginDrag = function(self, args)
  -- function num : 0_16
  self._dragDelta = 0
  self._slideInertiaTime = 0.3
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

VerticalGridFrameImpl.OnDrag = function(self, args)
  -- function num : 0_17 , upvalues : UIManager
  local pressPosition = args.pressPosition
  local position = args.position
  local localPressX, localPressY = (UIManager.ScreenPointToLocalPointInRectangle)((self._viewport)._uiObject, pressPosition.x, pressPosition.y)
  local localX, localY = (UIManager.ScreenPointToLocalPointInRectangle)((self._viewport)._uiObject, position.x, position.y)
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

VerticalGridFrameImpl.OnEndDrag = function(self, args)
  -- function num : 0_18 , upvalues : UIManager, _ENV
  self._dragDelta = 0
  local _, original = (UIManager.ScreenPointToLocalPointInRectangle)((self._viewport)._uiObject, 0, 0)
  local _, speed = (UIManager.ScreenPointToLocalPointInRectangle)((self._viewport)._uiObject, (self._moveSpeed).x, (self._moveSpeed).y)
  speed = original - speed
  local width, height = (self._viewport):GetRectSize()
  local currentPosition = self._currentPosition
  if speed == 0 then
    (self._viewcontainer):SetBlocksRaycasts(true)
  else
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
      end
      do
        if (self._delegate).OnFrameEndDrag then
          (self._delegate):OnFrameEndDrag(self._interface)
        end
      end
    end
  end
end

VerticalGridFrameImpl.OnPointerDown = function(self, deltaTime)
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

VerticalGridFrameImpl.OnPointerUp = function(self, deltaTime)
  -- function num : 0_20
  self._sprintclickdown = false
  self:UpdateView(0)
end

VerticalGridFrameImpl.OnLateUpdate = function(self, notification)
  -- function num : 0_21
  local deltaTime = (notification.userInfo).unscaledDeltaTime
  local width, height = (self._viewport):GetRectSize()
  if self._needUpdate then
    if self._slideInertiaTask then
      if (self._slideInertiaTask):update(deltaTime) then
        self._currentPosition = self._slideInertiaPosition - (self._slideInertiaSpeed + ((self._slideInertiaTask).subject).pos) * self._slideInertiaTime / 2
        self._slideInertiaTask = nil
        self._slideInertiaPosition = nil
        ;
        (self._viewcontainer):SetBlocksRaycasts(true)
      else
        self._currentPosition = self._slideInertiaPosition - (self._slideInertiaSpeed + ((self._slideInertiaTask).subject).pos) * (self._slideInertiaTask).clock / 2
      end
      -- DECOMPILER ERROR at PC67: Confused about usage of register: R5 in 'UnsetPending'

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

VerticalGridFrameImpl.UpdateView = function(self, deltaTime)
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
    for i,logicCell in ipairs(self._logicCells) do
      if currentPosition - self._upMargin <= logicCell._posY + self._cellSizeY and logicCell._posY <= currentPosition + height + self._downMargin then
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
          -- DECOMPILER ERROR at PC91: Confused about usage of register: R10 in 'UnsetPending'

          ;
          (logicCell._cell)._delegate = self._delegate
          -- DECOMPILER ERROR at PC94: Confused about usage of register: R10 in 'UnsetPending'

          ;
          (logicCell._cell)._cellData = logicCell._data
          ;
          (logicCell._cell):RefreshCell(logicCell._data)
        end
        ;
        ((logicCell._cell):GetRootWindow()):SetPosition(0, logicCell._posX, 1, -logicCell._posY - self._cellSizeY)
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
      -- DECOMPILER ERROR at PC145: Overwrote pending register: R10 in 'AssignReg'

      for i,cell in y(cells) do
        (cell:GetRootWindow()):SetPosition(0, 0, 0, -10000)
      end
    end
    local vx = self._cellX * self._columnNums
    local viewportX, y = (self._viewport):GetRectSize()
    if viewportX < vx then
      vx = viewportX
    end
    ;
    (self._viewcontainer):SetSize(0, vx, 0, self._totalLength)
    if self._totalLength + self._upMargin <= height then
      (self._viewcontainer):SetPosition(0, (viewportX - vx) / 2, 0, currentPosition - self._totalLength + height - self._upMargin)
    else
      ;
      (self._viewcontainer):SetPosition(0, (viewportX - vx) / 2, 0, currentPosition - self._totalLength + height)
    end
    do
      if self._leftMargin ~= 0 or self._rightMargin ~= 0 then
        local aMinX, aMinY, aMaxX, aMaxY, oMinX, oMinY, oMaxX, oMaxY = (self._viewcontainer):GetAnchorAndOffset()
        ;
        (self._viewcontainer):SetAnchorAndOffset(0, aMinY, 1, aMaxY, self._leftMargin, oMinY, -self._rightMargin, oMaxY)
      end
      if not self._sprintTask and not self._slideInertiaTask and not self._moveTopTask and not self._moveBottomTask and not self._moveTopIndexTask and not self._moveDownIndexTask and not self._moveToAssignedPosTask then
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

VerticalGridFrameImpl.GetCellDialog = function(self, logicCell)
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

VerticalGridFrameImpl.RecycleCell = function(self, logicCell)
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

VerticalGridFrameImpl.SendMessageToInstance = function(self, name, args)
  -- function num : 0_25 , upvalues : _ENV
  for _,logicCell in ipairs(self._logicCells) do
    if logicCell._cell and (logicCell._cell).HandleFrameMessage then
      ((logicCell._cell).HandleFrameMessage)(logicCell._cell, name, args)
    end
  end
end

VerticalGridFrameImpl.SetSlide = function(self, slide, showSoftMask)
  -- function num : 0_26 , upvalues : _ENV
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

VerticalGridFrameImpl.SetSoftMaskActive = function(self, showSoftMask)
  -- function num : 0_27 , upvalues : _ENV
  ((((CS.PixelNeko).Lua).SoftMaskStaticFunctions).SetSoftMaskActive)((self._viewport)._uiObject, showSoftMask)
end

VerticalGridFrameImpl.RefreshUIParticleClipper = function(self)
  -- function num : 0_28 , upvalues : _ENV
  self._refreshUIParticleClipper = true
  ;
  (((((CS.PixelNeko).Render).ShaderUtility).UIParticleClipper).RefreshUIParticleClipper)((self._viewport):GetUIObject())
end

VerticalGridFrameImpl.ClearAllPositionChangeTask = function(self)
  -- function num : 0_29
  self._slideInertiaTask = nil
  self._sprintTask = nil
  self._moveTopTask = nil
  self._moveBottomTask = nil
  self._moveTopIndexTask = nil
  self._moveDownIndexTask = nil
  self._moveToAssignedPosTask = nil
end

return VerticalGridFrameImpl

