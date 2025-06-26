-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local _eventHandlers = {}
local _eventHandlersPath = "logic.guide.stageconditionhandlers."
local _starthandlers = {}
local _starthandlersPath = "logic.guide.stagestarthandlers."
local cGuideStageConfig = (BeanManager.GetTableByName)("guide.cguidestageconfig")
local cGuideEventConfig = (BeanManager.GetTableByName)("guide.cguidestependconditionconfig")
local cGuideLinkConfing = (BeanManager.GetTableByName)("guide.cguidelinkconfig")
local cGuideEventMonitor = (BeanManager.GetTableByName)("guide.cguideeventmonitor")
local UIManager = ((CS.PixelNeko).UI).UIManager
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local EventType = {PointerDidClicked = 1, DialogOpenOrClose = 2, GlobalPointerClicked = 3}
local Stage = class("Stage")
Stage.Status = {NotStarted = 0, Doing = 1, Finished = 2}
local HandlePointerDidClicked = function(self, notification)
  -- function num : 0_0
  self:CheckFinished((notification.userInfo).luaWindow)
end

local HandleGlobalPointerClicked = function(self)
  -- function num : 0_1
  self:CheckFinished(true)
end

local GetGuideFrame = function(self)
  -- function num : 0_2 , upvalues : _starthandlers, _ENV, _starthandlersPath
  local handler = _starthandlers[(self._record).type]
  if handler == nil then
    handler = require(_starthandlersPath .. (self._record).type)
    _starthandlers[(self._record).type] = handler
  end
  return handler((self._record).GuideFrame)
end

local HandleDialogOpen = function(self)
  -- function num : 0_3
  self:CheckFinished()
end

local HandleDialogClose = function(self)
  -- function num : 0_4 , upvalues : GetGuideFrame, Stage, _ENV
  if self._isWeakGuide and not GetGuideFrame(self) then
    self._status = (Stage.Status).NotStarted
    ;
    ((NekoData.BehaviorManager).BM_Guide):DestroyWeakGuideDialog(self._guideId, self._id)
  end
  self:CheckFinished()
end

local RemoveObserver = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  for k,v in pairs(self._events) do
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R6 in 'UnsetPending'

    (self._events)[k] = false
  end
end

Stage.Ctor = function(self, id, conditionId, guideId)
  -- function num : 0_6 , upvalues : cGuideLinkConfing, cGuideStageConfig, cGuideEventConfig, cGuideEventMonitor, _ENV, Stage
  self._id = id
  self._guideId = guideId
  self._guideInfo = cGuideLinkConfing:GetRecorder(self._guideId)
  self._isWeakGuide = (self._guideInfo).guideType ~= 1
  self._conditions = {}
  self._events = {}
  local record = cGuideStageConfig:GetRecorder(conditionId)
  if record then
    self._condition = cGuideEventConfig:GetRecorder(record.event)
    local stepFinishAddObserverTypeRecord = cGuideEventMonitor:GetRecorder((self._condition).ConditionType)
    if stepFinishAddObserverTypeRecord then
      self._stepFinishAddObserverType = stepFinishAddObserverTypeRecord.eventMonitor
    end
  else
    LogError("Stage Record Error.")
  end
  self._record = record
  self._status = (Stage.Status).NotStarted
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

Stage.GetStatus = function(self)
  -- function num : 0_7
  return self._status
end

Stage.Destroy = function(self)
  -- function num : 0_8 , upvalues : RemoveObserver
  RemoveObserver(self)
end

Stage.GetID = function(self)
  -- function num : 0_9
  return self._id
end

Stage.Reset = function(self)
  -- function num : 0_10 , upvalues : Stage, RemoveObserver
  if self._status ~= (Stage.Status).Finished then
    RemoveObserver(self)
  end
  self._willPlay = false
  self._status = (Stage.Status).NotStarted
end

Stage.Play = function(self)
  -- function num : 0_11 , upvalues : Stage, _ENV, GetGuideFrame, TransformStaticFunctions, UIManager, EventType, HandlePointerDidClicked, HandleDialogOpen, HandleDialogClose, HandleGlobalPointerClicked
  if self._isWeakGuide or not self:CheckFinished() then
    if not self._willPlay and self._status ~= (Stage.Status).Doing then
      self._willPlay = true
      ;
      (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
    end
    local guideFrame = GetGuideFrame(self)
    do
      if guideFrame then
        if self._guideInfo then
          if (self._guideInfo).guideType == 1 then
            local blackPanelParmFunc, textPanelParmFunc = nil, nil
            if (self._record).raycastTarget ~= 1 then
              do
                do
                  do
                    local raycastTarget = (self._record).wordId == 0
                    if (self._record).type ~= 15 and (self._record).type ~= 16 and (self._record).type ~= 22 then
                      if guideFrame == "0" then
                        textPanelParmFunc = function()
    -- function num : 0_11_0
    return {width = 0, height = 0, posX = 0, posY = 0}
  end

                      elseif (self._record).hideBlack == 1 then
                        textPanelParmFunc = function()
    -- function num : 0_11_1 , upvalues : guideFrame, GetGuideFrame, self, TransformStaticFunctions, UIManager
    guideFrame = GetGuideFrame(self)
    if guideFrame then
      local width, height = guideFrame:GetRectSize()
      local screenPos = guideFrame:GetLocalPointInUiRootPanel()
      local pivotX, pivotY = guideFrame:GetPivotPosition()
      local RootLocalScale_x, RootLocalScale_y, RootLocalScale_z = (TransformStaticFunctions.GetLossyScale)(UIManager.UIRoot)
      local x, y, z = guideFrame:GetLossyScale()
      return {width = width * x / RootLocalScale_x, height = height * y / RootLocalScale_y, posX = screenPos.x + width * (0.5 - pivotX), posY = screenPos.y + height * (0.5 - pivotY)}
    end
  end

                      else
                        blackPanelParmFunc = function()
    -- function num : 0_11_2 , upvalues : guideFrame, GetGuideFrame, self, TransformStaticFunctions, UIManager
    guideFrame = GetGuideFrame(self)
    if guideFrame then
      local width, height = guideFrame:GetRectSize()
      local screenPos = guideFrame:GetLocalPointInUiRootPanel()
      local pivotX, pivotY = guideFrame:GetPivotPosition()
      local RootLocalScale_x, RootLocalScale_y, RootLocalScale_z = (TransformStaticFunctions.GetLossyScale)(UIManager.UIRoot)
      local x, y, z = guideFrame:GetLossyScale()
      return {width = width * x / RootLocalScale_x, height = height * y / RootLocalScale_y, posX = screenPos.x + width * (0.5 - pivotX), posY = screenPos.y + height * (0.5 - pivotY)}
    end
  end

                        textPanelParmFunc = function()
    -- function num : 0_11_3 , upvalues : guideFrame, GetGuideFrame, self, TransformStaticFunctions, UIManager
    guideFrame = GetGuideFrame(self)
    if guideFrame then
      local width, height = guideFrame:GetRectSize()
      local screenPos = guideFrame:GetLocalPointInUiRootPanel()
      local pivotX, pivotY = guideFrame:GetPivotPosition()
      local RootLocalScale_x, RootLocalScale_y, RootLocalScale_z = (TransformStaticFunctions.GetLossyScale)(UIManager.UIRoot)
      local x, y, z = guideFrame:GetLossyScale()
      return {width = width * x / RootLocalScale_x, height = height * y / RootLocalScale_y, posX = screenPos.x + width * (0.5 - pivotX), posY = screenPos.y + height * (0.5 - pivotY)}
    end
  end

                      end
                    elseif guideFrame == "0" then
                      textPanelParmFunc = function()
    -- function num : 0_11_4
    return {width = 0, height = 0, posX = 0, posY = 0}
  end

                    elseif (self._record).hideBlack == 1 then
                      textPanelParmFunc = function()
    -- function num : 0_11_5 , upvalues : guideFrame
    local sizeAndPos = guideFrame()
    return {width = sizeAndPos.width, height = sizeAndPos.height, posX = sizeAndPos.posX, posY = sizeAndPos.posY}
  end

                    else
                      blackPanelParmFunc = function()
    -- function num : 0_11_6 , upvalues : guideFrame
    local sizeAndPos = guideFrame()
    return {width = sizeAndPos.width, height = sizeAndPos.height, posX = sizeAndPos.posX, posY = sizeAndPos.posY}
  end

                      textPanelParmFunc = function()
    -- function num : 0_11_7 , upvalues : guideFrame
    local sizeAndPos = guideFrame()
    return {width = sizeAndPos.width, height = sizeAndPos.height, posX = sizeAndPos.posX, posY = sizeAndPos.posY}
  end

                    end
                    ;
                    ((NekoData.BehaviorManager).BM_Guide):CreateGuideDialog(self._guideId, self._id, blackPanelParmFunc, textPanelParmFunc, (self._record).direction, (self._record).wordId, (self._record).profileId, raycastTarget)
                    if (self._record).type ~= 15 and (self._record).type ~= 16 and (self._record).type ~= 22 then
                      blackPanelParmFunc = function()
    -- function num : 0_11_8 , upvalues : guideFrame, GetGuideFrame, self, TransformStaticFunctions, UIManager
    guideFrame = GetGuideFrame(self)
    if guideFrame then
      local width, height = guideFrame:GetRectSize()
      local screenPos = guideFrame:GetLocalPointInUiRootPanel()
      local pivotX, pivotY = guideFrame:GetPivotPosition()
      local RootLocalScale_x, RootLocalScale_y, RootLocalScale_z = (TransformStaticFunctions.GetLossyScale)(UIManager.UIRoot)
      local x, y, z = guideFrame:GetLossyScale()
      return {width = width * x / RootLocalScale_x, height = height * y / RootLocalScale_y, posX = screenPos.x + width * (0.5 - pivotX), posY = screenPos.y + height * (0.5 - pivotY)}
    end
  end

                    elseif (self._record).hideBlack ~= 1 then
                      blackPanelParmFunc = function()
    -- function num : 0_11_9 , upvalues : guideFrame
    local sizeAndPos = guideFrame()
    return {width = sizeAndPos.width, height = sizeAndPos.height, posX = sizeAndPos.posX, posY = sizeAndPos.posY}
  end

                    end
                    ;
                    ((NekoData.BehaviorManager).BM_Guide):CreateGuideDialog(self._guideId, self._id, blackPanelParmFunc)
                    ;
                    ((NekoData.BehaviorManager).BM_Guide):CreateWeakGuideDialog(self._guideId, self._id, guideFrame.parent, guideFrame.effectPos)
                    -- DECOMPILER ERROR at PC162: Confused about usage of register: R2 in 'UnsetPending'

                    if self._stepFinishAddObserverType and not (self._events)[self._stepFinishAddObserverType] then
                      if self._stepFinishAddObserverType == EventType.PointerDidClicked then
                        (self._events)[self._stepFinishAddObserverType] = true
                        ;
                        (LuaNotificationCenter.AddObserver)(self, HandlePointerDidClicked, Common.n_GlobalPointerDidClick, nil)
                      else
                        -- DECOMPILER ERROR at PC178: Confused about usage of register: R2 in 'UnsetPending'

                        if self._stepFinishAddObserverType == EventType.DialogOpenOrClose then
                          (self._events)[self._stepFinishAddObserverType] = true
                          ;
                          (LuaNotificationCenter.AddObserver)(self, HandleDialogOpen, Common.n_ModalDialogOpen, nil)
                          ;
                          (LuaNotificationCenter.AddObserver)(self, HandleDialogClose, Common.n_SingletonDialogDestroy, nil)
                        else
                          -- DECOMPILER ERROR at PC202: Confused about usage of register: R2 in 'UnsetPending'

                          if self._stepFinishAddObserverType == EventType.GlobalPointerClicked then
                            (self._events)[self._stepFinishAddObserverType] = true
                            ;
                            (LuaNotificationCenter.AddObserver)(self, HandleGlobalPointerClicked, Common.n_GuideResponseClick, nil)
                          end
                        end
                      end
                    end
                    -- DECOMPILER ERROR at PC221: Confused about usage of register: R2 in 'UnsetPending'

                    if self._isWeakGuide and not (self._events)[EventType.DialogOpenOrClose] then
                      (self._events)[EventType.DialogOpenOrClose] = true
                      ;
                      (LuaNotificationCenter.AddObserver)(self, HandleDialogOpen, Common.n_ModalDialogOpen, nil)
                      ;
                      (LuaNotificationCenter.AddObserver)(self, HandleDialogClose, Common.n_DialogWillDestroy, nil)
                    end
                    self._status = (Stage.Status).Doing
                    self._willPlay = false
                    if self._isWeakGuide and self._status == (Stage.Status).Doing then
                      ((NekoData.BehaviorManager).BM_Guide):DestroyWeakGuideDialog(self._guideId, self._id)
                    end
                  end
                  -- DECOMPILER ERROR: 18 unprocessed JMP targets
                end
              end
            end
          end
        end
      end
    end
  end
end

Stage.OnUpdate = function(self)
  -- function num : 0_12 , upvalues : Stage
  if self._willPlay and self._status ~= (Stage.Status).Doing then
    self:Play()
  else
    if self._isWeakGuide and self._status == (Stage.Status).Doing then
      self:Play()
    end
  end
end

local HandleCondition = function(self, condition, luaWindow)
  -- function num : 0_13 , upvalues : _eventHandlers, _ENV, _eventHandlersPath
  local handler = _eventHandlers[condition.ConditionType]
  if handler == nil then
    handler = require(_eventHandlersPath .. condition.ConditionType)
    _eventHandlers[condition.ConditionType] = handler
  end
  return handler(condition, luaWindow)
end

Stage.CheckFinished = function(self, luaWindow)
  -- function num : 0_14 , upvalues : HandleCondition, RemoveObserver, Stage, _ENV
  if not self._isWeakGuide then
    local tag = true
    tag = HandleCondition(self, self._condition, luaWindow)
    if tag then
      RemoveObserver(self)
      self._status = (Stage.Status).Finished
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_GuideStageFinished, self, {guideID = self._guideId, stageID = self._id})
      LogInfoFormat("Stage", "FinishStage guideID = %s, stageID = %s", self._guideId, self._id)
    end
    return tag
  else
    do
      if self._status ~= (Stage.Status).Doing then
        self:Play()
      end
      do return false end
    end
  end
end

return Stage

