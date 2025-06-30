-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/task/tasktableframe.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local VerticalTableFrameInverseImpl = require("framework.ui.frame.table.verticaltableframeinverseimpl")
local UIManager = ((CS.PixelNeko).UI).UIManager
local LogicCell = require("framework.ui.frame.table.logiccell")
local TaskTableFrame = class("TaskTableFrame", VerticalTableFrameInverseImpl)
TaskTableFrame.RemoveCellsAtIndex = function(self, indexList, isAnimate)
  -- function num : 0_0 , upvalues : _ENV
  if type(indexList) ~= "table" then
    LogError("VerticalTableFrameInverseImpl", "please input a table value")
    return 
  end
  self._needUpdate = true
  local cellNums = #self._logicCells
  local width, height = (self._viewport):GetRectSize()
  local currentPosition = self._currentPosition
  for _,index in pairs(indexList) do
    if cellNums < index then
      LogErrorFormat("VerticalTableFrameInverseImpl", "Wrong index %d", index)
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
        if isAnimate and currentPosition < pos + gap and pos < currentPosition + height then
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
          local delta = self._totalLength - height - currentPosition
          if delta < gap or self._totalLength < height then
            self._removeTolDes = self._totalLength - gap
            local first = {pos = self._totalLength}
            local last = {pos = self._removeTolDes}
            local time = 0.1
            local easing = "linear"
            if (self._delegate).RemoveTweenParamsAtIndex then
              time = (self._delegate):RemoveTweenParamsAtIndex(index)
            end
            self._removeTolTask = (Tween.new)(time, first, last, easing)
            self._needUpdate = true
            totalHasChange = true
          end
          do
            local curValue = currentPosition - currentPosition % 0.01
            local latestValue = 0 - self._downMargin - (0 - self._downMargin) % 0.01
            if curValue ~= latestValue then
              self._removeCurDes = self._currentPosition - gap
              -- DECOMPILER ERROR at PC185: Overwrote pending register: R19 in 'AssignReg'

              local first = {pos = easing}
              local last = {pos = self._removeCurDes}
              local time = 0.1
              local easing = "linear"
              if (self._delegate).RemoveTweenParamsAtIndex then
                time = (self._delegate):RemoveTweenParamsAtIndex(index)
              end
              self._removeCurTask = (Tween.new)(time, first, last, easing)
            end
            do
              for i = 1, index - 1 do
                -- DECOMPILER ERROR at PC221: Confused about usage of register: R19 in 'UnsetPending'

                ((self._logicCells)[i])._pos = ((self._logicCells)[i])._pos - gap
              end
              do
                do
                  ;
                  (table.remove)(self._logicCells, index)
                  if not totalHasChange then
                    self._totalLength = self._totalLength - gap
                  end
                  -- DECOMPILER ERROR at PC233: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC233: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC233: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC233: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC233: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC233: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC233: LeaveBlock: unexpected jumping out DO_STMT

                end
              end
            end
          end
        end
      end
    end
  end
end

TaskTableFrame.InsertCellsAtIndex = function(self, indexList, isAnimate)
  -- function num : 0_1 , upvalues : _ENV, LogicCell, UIManager
  if indexList and type(indexList) ~= "table" then
    LogError("VerticalTableFrameInverseImpl", "please input a table value")
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
      LogError("VerticalTableFrameInverseImpl", "no additional data")
      return 
    end
  end
  for _,index in pairs(indexList) do
    cellNums = #self._logicCells
    if not index or cellNums + 1 < index and not lastinsert then
      LogErrorFormat("VerticalTableFrameInverseImpl", "Wrong index %d", index)
      return 
    end
    local logicCell = (LogicCell.Create)()
    logicCell._dialogName = (self._delegate):CellAtIndex(self._interface, index)
    if not (self._baseCells)[logicCell._dialogName] then
      local dialogDefine = require("logic.dialog." .. logicCell._dialogName)
      -- DECOMPILER ERROR at PC97: Confused about usage of register: R12 in 'UnsetPending'

      ;
      (self._baseCells)[logicCell._dialogName] = (UIManager.CreateLuaWindow)(dialogDefine.AssetBundleName .. ".assetbundle", dialogDefine.AssetName, (self._viewcontainer)._uiObject)
      local width, height = (self._viewport):GetRectSize()
      ;
      ((self._baseCells)[logicCell._dialogName]):SetPosition(0, 0, 0, -10 * height)
    end
    do
      logicCell._data = (self._delegate):DataAtIndex(self._interface, index)
      local tempSize = {}
      local width, height = (self._viewport):GetRectSize()
      if not (self._delegate).ShouldLengthChange or not (self._delegate):ShouldLengthChange(self._interface, i) then
        if not tempSize[logicCell._dialogName] then
          self:GetCellDialog(logicCell)
          -- DECOMPILER ERROR at PC140: Confused about usage of register: R14 in 'UnsetPending'

          ;
          (logicCell._cell)._delegate = self._delegate
          -- DECOMPILER ERROR at PC143: Confused about usage of register: R14 in 'UnsetPending'

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
          -- DECOMPILER ERROR at PC169: Confused about usage of register: R14 in 'UnsetPending'

          ;
          (logicCell._cell)._delegate = self._delegate
          -- DECOMPILER ERROR at PC172: Confused about usage of register: R14 in 'UnsetPending'

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
                -- DECOMPILER ERROR at PC198: Confused about usage of register: R19 in 'UnsetPending'

                ((self._logicCells)[i])._pos = (self._removeDes)[i]
                -- DECOMPILER ERROR at PC200: Confused about usage of register: R19 in 'UnsetPending'

                ;
                (self._removeDes)[i] = nil
                -- DECOMPILER ERROR at PC202: Confused about usage of register: R19 in 'UnsetPending'

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
                  -- DECOMPILER ERROR at PC233: Confused about usage of register: R20 in 'UnsetPending'

                  ;
                  (self._insertDes)[i] = nil
                  -- DECOMPILER ERROR at PC235: Confused about usage of register: R20 in 'UnsetPending'

                  ;
                  (self._insertTask)[i] = nil
                end
              end
              do
                ;
                (table.insert)(self._logicCells, index, logicCell)
                local curValue = self._currentPosition - self._currentPosition % 0.01
                local latestValue = -self._downMargin - (0 - self._downMargin) % 0.01
                local time = 0.1
                local easing = "linear"
                if curValue == latestValue and isAnimate then
                  self._insertTask = {}
                  for i = 1, index - 1 do
                    -- DECOMPILER ERROR at PC277: Confused about usage of register: R22 in 'UnsetPending'

                    if height < self._totalLength + logicCell._size then
                      (self._insertDes)[i] = ((self._logicCells)[i])._pos + logicCell._size
                      local first = {pos = ((self._logicCells)[i])._pos}
                      local last = {pos = (self._insertDes)[i]}
                      if (self._delegate).InsertTweenParamsAtIndex then
                        time = (self._delegate):InsertTweenParamsAtIndex(i - index + 1)
                      end
                      -- DECOMPILER ERROR at PC306: Confused about usage of register: R24 in 'UnsetPending'

                      ;
                      (self._insertTask)[i] = (Tween.new)(time, first, last, easing)
                      self._needUpdate = true
                    else
                      do
                        do
                          -- DECOMPILER ERROR at PC316: Confused about usage of register: R22 in 'UnsetPending'

                          ;
                          ((self._logicCells)[i])._pos = ((self._logicCells)[i])._pos + logicCell._size
                          -- DECOMPILER ERROR at PC317: LeaveBlock: unexpected jumping out DO_STMT

                          -- DECOMPILER ERROR at PC317: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                          -- DECOMPILER ERROR at PC317: LeaveBlock: unexpected jumping out IF_STMT

                        end
                      end
                    end
                  end
                  -- DECOMPILER ERROR at PC334: Confused about usage of register: R18 in 'UnsetPending'

                  if #self._insertTask ~= 0 then
                    if index <= cellNums then
                      (self._insertDes)[index] = ((self._logicCells)[index + 1])._pos + ((self._logicCells)[index + 1])._size
                      local first = {pos = ((self._logicCells)[index + 1])._pos}
                      local last = {pos = (self._insertDes)[index]}
                      -- DECOMPILER ERROR at PC353: Overwrote pending register: R17 in 'AssignReg'

                      if (self._delegate).InsertTweenParamsAtIndex then
                        time = (self._delegate):InsertTweenParamsAtIndex(1)
                      end
                      -- DECOMPILER ERROR at PC363: Confused about usage of register: R20 in 'UnsetPending'

                      ;
                      (self._insertTask)[index] = (Tween.new)(time, first, last, easing)
                    else
                      do
                        -- DECOMPILER ERROR at PC366: Confused about usage of register: R18 in 'UnsetPending'

                        ;
                        (self._insertDes)[index] = 0
                        local first = {pos = -((self._logicCells)[index])._size}
                        do
                          do
                            local last = {pos = (self._insertDes)[index]}
                            -- DECOMPILER ERROR at PC385: Overwrote pending register: R17 in 'AssignReg'

                            if (self._delegate).InsertTweenParamsAtIndex then
                              time = (self._delegate):InsertTweenParamsAtIndex(1)
                            end
                            -- DECOMPILER ERROR at PC395: Confused about usage of register: R20 in 'UnsetPending'

                            ;
                            (self._insertTask)[index] = (Tween.new)(time, first, last, easing)
                            self._needUpdate = true
                            -- DECOMPILER ERROR at PC411: Confused about usage of register: R18 in 'UnsetPending'

                            if index <= cellNums then
                              ((self._logicCells)[index])._pos = ((self._logicCells)[index + 1])._pos + ((self._logicCells)[index + 1])._size
                            else
                              -- DECOMPILER ERROR at PC415: Confused about usage of register: R18 in 'UnsetPending'

                              ;
                              ((self._logicCells)[index])._pos = 0
                            end
                            for i = 1, index - 1 do
                              -- DECOMPILER ERROR at PC428: Confused about usage of register: R22 in 'UnsetPending'

                              ((self._logicCells)[i])._pos = ((self._logicCells)[i])._pos + logicCell._size
                            end
                            -- DECOMPILER ERROR at PC443: Confused about usage of register: R18 in 'UnsetPending'

                            if index <= cellNums then
                              ((self._logicCells)[index])._pos = ((self._logicCells)[index + 1])._pos + ((self._logicCells)[index + 1])._size
                            else
                              -- DECOMPILER ERROR at PC447: Confused about usage of register: R18 in 'UnsetPending'

                              ;
                              ((self._logicCells)[index])._pos = 0
                            end
                            self._totalLength = self._totalLength + logicCell._size
                            if curValue ~= latestValue then
                              self._currentPosition = self._currentPosition + logicCell._size
                            end
                            -- DECOMPILER ERROR at PC458: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC458: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC458: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                            -- DECOMPILER ERROR at PC458: LeaveBlock: unexpected jumping out IF_STMT

                            -- DECOMPILER ERROR at PC458: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC458: LeaveBlock: unexpected jumping out IF_STMT

                            -- DECOMPILER ERROR at PC458: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC458: LeaveBlock: unexpected jumping out IF_STMT

                            -- DECOMPILER ERROR at PC458: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC458: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC458: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC458: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC458: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC458: LeaveBlock: unexpected jumping out IF_STMT

                            -- DECOMPILER ERROR at PC458: LeaveBlock: unexpected jumping out DO_STMT

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

TaskTableFrame.OnLateUpdate = function(self, notification)
  -- function num : 0_2 , upvalues : _ENV
  local deltaTime = (notification.userInfo).deltaTime
  local width, height = (self._viewport):GetRectSize()
  if self._needUpdate then
    if self._slideInertiaTask then
      if (self._slideInertiaTask):update(deltaTime) then
        self._currentPosition = self._slideInertiaPosition - (self._slideInertiaSpeed + ((self._slideInertiaTask).subject).pos) * self._slideInertiaTime / 2
        if self._autoAlign then
          if self._slideInertiaSpeed < 0 then
            local half = ((self._logicCells)[self._topIndex])._pos + ((self._logicCells)[self._topIndex])._size / 2
            if self._currentPosition + height < half then
              local first = {pos = self._currentPosition}
              local cellNums = #self._logicCells
              if self._topIndex + 1 <= cellNums then
                self._alignDes = ((self._logicCells)[self._topIndex + 1])._pos + ((self._logicCells)[self._topIndex + 1])._size - height
                local last = {pos = self._alignDes}
                self._alignTask = (Tween.new)(0.3, first, last, "linear")
              end
            else
              do
                if half <= self._currentPosition + height then
                  local first = {pos = self._currentPosition}
                  self._alignDes = ((self._logicCells)[self._topIndex])._pos + ((self._logicCells)[self._topIndex])._size - height
                  local last = {pos = self._alignDes}
                  self._alignTask = (Tween.new)(0.3, first, last, "linear")
                end
                do
                  if self._slideInertiaSpeed > 0 then
                    local half = ((self._logicCells)[self._downIndex])._pos + ((self._logicCells)[self._downIndex])._size / 2
                    if self._currentPosition <= half then
                      local first = {pos = self._currentPosition}
                      self._alignDes = ((self._logicCells)[self._downIndex])._pos
                      local last = {pos = self._alignDes}
                      self._alignTask = (Tween.new)(0.3, first, last, "linear")
                    else
                      do
                        if half < self._currentPosition then
                          local first = {pos = self._currentPosition}
                          if self._downIndex - 1 > 0 then
                            self._alignDes = ((self._logicCells)[self._downIndex - 1])._pos
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

                          if self._slideInertiaTask and (self._totalLength - height + self._upMargin < self._currentPosition or self._currentPosition < 0 - self._downMargin) then
                            (self._slideInertiaTask).clock = (self._slideInertiaTask).clock + 2 * deltaTime
                          end
                          if self._totalLength - height + height / 3 + self._upMargin < self._currentPosition then
                            self._currentPosition = self._totalLength - height + height / 3 + self._upMargin
                            self._slideInertiaTask = nil
                            self._slideInertiaPosition = nil
                            ;
                            (self._viewcontainer):SetBlocksRaycasts(true)
                          end
                          if self._currentPosition < -height / 3 - self._downMargin then
                            self._currentPosition = -height / 3 - self._downMargin
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
                            else
                              self._currentPosition = ((self._alignTask).subject).pos
                            end
                          end
                          do
                            if self._insertTask then
                              local clear = nil
                              for i,task in pairs(self._insertTask) do
                                local logicCell = (self._logicCells)[i]
                                if task:update(deltaTime) then
                                  logicCell._pos = (self._insertDes)[i]
                                  -- DECOMPILER ERROR at PC340: Confused about usage of register: R12 in 'UnsetPending'

                                  ;
                                  (self._insertDes)[i] = nil
                                  -- DECOMPILER ERROR at PC342: Confused about usage of register: R12 in 'UnsetPending'

                                  ;
                                  (self._insertTask)[i] = nil
                                  if (self._delegate).OnInsertTweenFinish then
                                    (self._delegate):OnInsertTweenFinish(i)
                                  end
                                  clear = true
                                else
                                  logicCell._pos = (task.subject).pos
                                end
                              end
                              if clear and (table.nums)(self._insertTask) == 0 and (self._delegate).OnInsertTweenFinish then
                                (self._delegate):OnInsertTweenFinish()
                              end
                            end
                            do
                              if self._removeTask then
                                local clear = nil
                                for i,task in pairs(self._removeTask) do
                                  local logicCell = (self._logicCells)[i]
                                  if task:update(deltaTime) then
                                    logicCell._pos = (self._removeDes)[i]
                                    -- DECOMPILER ERROR at PC392: Confused about usage of register: R12 in 'UnsetPending'

                                    ;
                                    (self._removeDes)[i] = nil
                                    -- DECOMPILER ERROR at PC394: Confused about usage of register: R12 in 'UnsetPending'

                                    ;
                                    (self._removeTask)[i] = nil
                                    if (self._delegate).OnRemoveTweenFinish then
                                      (self._delegate):OnRemoveTweenFinish(i)
                                    end
                                    clear = true
                                  else
                                    logicCell._pos = (task.subject).pos
                                  end
                                end
                                if clear and (table.nums)(self._removeTask) == 0 and (self._delegate).OnRemoveTweenFinish then
                                  (self._delegate):OnRemoveTweenFinish()
                                end
                              end
                              if self._removeCurTask then
                                if (self._removeCurTask):update(deltaTime) then
                                  self._currentPosition = self._removeCurDes
                                  self._removeCurTask = nil
                                  self._removeCurDes = nil
                                  if (self._delegate).OnRemoveTweenFinish then
                                    (self._delegate):OnRemoveTweenFinish()
                                  end
                                else
                                  self._currentPosition = ((self._removeCurTask).subject).pos
                                end
                                if height < self._totalLength + self._upMargin and self._totalLength + self._upMargin - height < self._currentPosition then
                                  self._currentPosition = self._totalLength + self._upMargin - height
                                end
                                if self._currentPosition < 0 - self._downMargin then
                                  self._currentPosition = 0 - self._downMargin
                                end
                              end
                              if self._removeTolTask then
                                if (self._removeTolTask):update(deltaTime) then
                                  self._totalLength = self._removeTolDes
                                  self._removeTolTask = nil
                                  self._removeTolDes = nil
                                  if (self._delegate).OnRemoveTweenFinish then
                                    (self._delegate):OnRemoveTweenFinish()
                                  end
                                else
                                  self._totalLength = ((self._removeTolTask).subject).pos
                                end
                              end
                              if self._moveTopTask then
                                if (self._moveTopTask):update(deltaTime) then
                                  self._currentPosition = self._totalLength - height + self._upMargin
                                  self._moveTopTask = nil
                                else
                                  self._currentPosition = ((self._moveTopTask).subject).pos
                                end
                              end
                              if self._moveBottomTask then
                                if (self._moveBottomTask):update(deltaTime) then
                                  self._currentPosition = 0 - self._downMargin
                                  self._moveBottomTask = nil
                                else
                                  self._currentPosition = ((self._moveBottomTask).subject).pos
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
                              if self._moveTopIndexTask then
                                if (self._moveTopIndexTask):update(deltaTime) then
                                  self._currentPosition = self._moveTopIndexDes
                                  self._moveTopIndexTask = nil
                                else
                                  self._currentPosition = ((self._moveTopIndexTask).subject).pos
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

return TaskTableFrame

