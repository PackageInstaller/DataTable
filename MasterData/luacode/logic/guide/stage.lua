local _eventHandlers = {}
local _eventHandlersPath = "logic.guide.stageconditionhandlers."
local _starthandlers = {}
local _starthandlersPath = "logic.guide.stagestarthandlers."
local cGuideStageConfig = BeanManager.GetTableByName("guide.cguidestageconfig")
local cGuideEventConfig = BeanManager.GetTableByName("guide.cguidestependconditionconfig")
local cGuideLinkConfing = BeanManager.GetTableByName("guide.cguidelinkconfig")
local cGuideEventMonitor = BeanManager.GetTableByName("guide.cguideeventmonitor")
local UIManager = CS.PixelNeko.UI.UIManager
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local EventType = {
  PointerDidClicked = 1,
  DialogOpenOrClose = 2,
  GlobalPointerClicked = 3
}
local Stage = class("Stage")
Stage.Status = {
  NotStarted = 0,
  Doing = 1,
  Finished = 2
}

local function HandlePointerDidClicked(self, notification)
  self:CheckFinished(notification.userInfo.luaWindow)
end

local function HandleGlobalPointerClicked(self)
  self:CheckFinished(true)
end

local function GetGuideFrame(self)
  local handler = _starthandlers[self._record.type]
  if handler == nil then
    handler = require(_starthandlersPath .. self._record.type)
    _starthandlers[self._record.type] = handler
  end
  return handler(self._record.GuideFrame)
end

local function HandleDialogOpen(self)
  self:CheckFinished()
end

local function HandleDialogClose(self)
  if self._isWeakGuide and not GetGuideFrame(self) then
    self._status = Stage.Status.NotStarted
    NekoData.BehaviorManager.BM_Guide:DestroyWeakGuideDialog(self._guideId, self._id)
  end
  self:CheckFinished()
end

local function RemoveObserver(self)
  LuaNotificationCenter.RemoveObserver(self)
  for k, v in pairs(self._events) do
    self._events[k] = false
  end
end

function Stage:Ctor(id, conditionId, guideId)
  self._id = id
  self._guideId = guideId
  self._guideInfo = cGuideLinkConfing:GetRecorder(self._guideId)
  self._isWeakGuide = self._guideInfo.guideType ~= 1
  self._conditions = {}
  self._events = {}
  local record = cGuideStageConfig:GetRecorder(conditionId)
  if record then
    self._condition = cGuideEventConfig:GetRecorder(record.event)
    local stepFinishAddObserverTypeRecord = cGuideEventMonitor:GetRecorder(self._condition.ConditionType)
    if stepFinishAddObserverTypeRecord then
      self._stepFinishAddObserverType = stepFinishAddObserverTypeRecord.eventMonitor
    end
  else
    LogError("Stage Record Error.")
  end
  self._record = record
  self._status = Stage.Status.NotStarted
end

function Stage:GetStatus()
  return self._status
end

function Stage:Destroy()
  RemoveObserver(self)
end

function Stage:GetID()
  return self._id
end

function Stage:Reset()
  if self._status ~= Stage.Status.Finished then
    RemoveObserver(self)
  end
  self._willPlay = false
  self._status = Stage.Status.NotStarted
end

function Stage:Play()
  if self._isWeakGuide or not self:CheckFinished() then
    if not self._willPlay and self._status ~= Stage.Status.Doing then
      self._willPlay = true
      LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
    end
    local guideFrame = GetGuideFrame(self)
    if guideFrame then
      if self._guideInfo then
        if self._guideInfo.guideType == 1 then
          local blackPanelParmFunc, textPanelParmFunc
          if self._record.wordId ~= 0 then
            local raycastTarget = self._record.raycastTarget == 1
            if self._record.type ~= 15 and self._record.type ~= 16 and self._record.type ~= 22 then
              if guideFrame == "0" then
                function textPanelParmFunc()
                  return {
                    width = 0,
                    
                    height = 0,
                    posX = 0,
                    posY = 0
                  }
                end
              elseif self._record.hideBlack == 1 then
                function textPanelParmFunc()
                  guideFrame = GetGuideFrame(self)
                  
                  if guideFrame then
                    local width, height = guideFrame:GetRectSize()
                    local screenPos = guideFrame:GetLocalPointInUiRootPanel()
                    local pivotX, pivotY = guideFrame:GetPivotPosition()
                    local RootLocalScale_x, RootLocalScale_y, RootLocalScale_z = TransformStaticFunctions.GetLossyScale(UIManager.UIRoot)
                    local x, y, z = guideFrame:GetLossyScale()
                    return {
                      width = width * x / RootLocalScale_x,
                      height = height * y / RootLocalScale_y,
                      posX = screenPos.x + width * (0.5 - pivotX),
                      posY = screenPos.y + height * (0.5 - pivotY)
                    }
                  end
                end
              else
                function blackPanelParmFunc()
                  guideFrame = GetGuideFrame(self)
                  
                  if guideFrame then
                    local width, height = guideFrame:GetRectSize()
                    local screenPos = guideFrame:GetLocalPointInUiRootPanel()
                    local pivotX, pivotY = guideFrame:GetPivotPosition()
                    local RootLocalScale_x, RootLocalScale_y, RootLocalScale_z = TransformStaticFunctions.GetLossyScale(UIManager.UIRoot)
                    local x, y, z = guideFrame:GetLossyScale()
                    return {
                      width = width * x / RootLocalScale_x,
                      height = height * y / RootLocalScale_y,
                      posX = screenPos.x + width * (0.5 - pivotX),
                      posY = screenPos.y + height * (0.5 - pivotY)
                    }
                  end
                end
                
                function textPanelParmFunc()
                  guideFrame = GetGuideFrame(self)
                  if guideFrame then
                    local width, height = guideFrame:GetRectSize()
                    local screenPos = guideFrame:GetLocalPointInUiRootPanel()
                    local pivotX, pivotY = guideFrame:GetPivotPosition()
                    local RootLocalScale_x, RootLocalScale_y, RootLocalScale_z = TransformStaticFunctions.GetLossyScale(UIManager.UIRoot)
                    local x, y, z = guideFrame:GetLossyScale()
                    return {
                      width = width * x / RootLocalScale_x,
                      height = height * y / RootLocalScale_y,
                      posX = screenPos.x + width * (0.5 - pivotX),
                      posY = screenPos.y + height * (0.5 - pivotY)
                    }
                  end
                end
              end
            elseif guideFrame == "0" then
              function textPanelParmFunc()
                return {
                  width = 0,
                  
                  height = 0,
                  posX = 0,
                  posY = 0
                }
              end
            elseif self._record.hideBlack == 1 then
              function textPanelParmFunc()
                local sizeAndPos = guideFrame()
                
                return {
                  width = sizeAndPos.width,
                  height = sizeAndPos.height,
                  posX = sizeAndPos.posX,
                  posY = sizeAndPos.posY
                }
              end
            else
              function blackPanelParmFunc()
                local sizeAndPos = guideFrame()
                
                return {
                  width = sizeAndPos.width,
                  height = sizeAndPos.height,
                  posX = sizeAndPos.posX,
                  posY = sizeAndPos.posY
                }
              end
              
              function textPanelParmFunc()
                local sizeAndPos = guideFrame()
                return {
                  width = sizeAndPos.width,
                  height = sizeAndPos.height,
                  posX = sizeAndPos.posX,
                  posY = sizeAndPos.posY
                }
              end
            end
            NekoData.BehaviorManager.BM_Guide:CreateGuideDialog(self._guideId, self._id, blackPanelParmFunc, textPanelParmFunc, self._record.direction, self._record.wordId, self._record.profileId, raycastTarget)
          else
            if self._record.type ~= 15 and self._record.type ~= 16 and self._record.type ~= 22 then
              function blackPanelParmFunc()
                guideFrame = GetGuideFrame(self)
                
                if guideFrame then
                  local width, height = guideFrame:GetRectSize()
                  local screenPos = guideFrame:GetLocalPointInUiRootPanel()
                  local pivotX, pivotY = guideFrame:GetPivotPosition()
                  local RootLocalScale_x, RootLocalScale_y, RootLocalScale_z = TransformStaticFunctions.GetLossyScale(UIManager.UIRoot)
                  local x, y, z = guideFrame:GetLossyScale()
                  return {
                    width = width * x / RootLocalScale_x,
                    height = height * y / RootLocalScale_y,
                    posX = screenPos.x + width * (0.5 - pivotX),
                    posY = screenPos.y + height * (0.5 - pivotY)
                  }
                end
              end
            elseif self._record.hideBlack ~= 1 then
              function blackPanelParmFunc()
                local sizeAndPos = guideFrame()
                
                return {
                  width = sizeAndPos.width,
                  height = sizeAndPos.height,
                  posX = sizeAndPos.posX,
                  posY = sizeAndPos.posY
                }
              end
            end
            NekoData.BehaviorManager.BM_Guide:CreateGuideDialog(self._guideId, self._id, blackPanelParmFunc)
          end
        else
          NekoData.BehaviorManager.BM_Guide:CreateWeakGuideDialog(self._guideId, self._id, guideFrame.parent, guideFrame.effectPos)
        end
        if self._stepFinishAddObserverType and not self._events[self._stepFinishAddObserverType] then
          if self._stepFinishAddObserverType == EventType.PointerDidClicked then
            self._events[self._stepFinishAddObserverType] = true
            LuaNotificationCenter.AddObserver(self, HandlePointerDidClicked, Common.n_GlobalPointerDidClick, nil)
          elseif self._stepFinishAddObserverType == EventType.DialogOpenOrClose then
            self._events[self._stepFinishAddObserverType] = true
            LuaNotificationCenter.AddObserver(self, HandleDialogOpen, Common.n_ModalDialogOpen, nil)
            LuaNotificationCenter.AddObserver(self, HandleDialogClose, Common.n_SingletonDialogDestroy, nil)
          elseif self._stepFinishAddObserverType == EventType.GlobalPointerClicked then
            self._events[self._stepFinishAddObserverType] = true
            LuaNotificationCenter.AddObserver(self, HandleGlobalPointerClicked, Common.n_GuideResponseClick, nil)
          end
        end
        if self._isWeakGuide and not self._events[EventType.DialogOpenOrClose] then
          self._events[EventType.DialogOpenOrClose] = true
          LuaNotificationCenter.AddObserver(self, HandleDialogOpen, Common.n_ModalDialogOpen, nil)
          LuaNotificationCenter.AddObserver(self, HandleDialogClose, Common.n_DialogWillDestroy, nil)
        end
      end
      self._status = Stage.Status.Doing
      self._willPlay = false
    elseif self._isWeakGuide and self._status == Stage.Status.Doing then
      NekoData.BehaviorManager.BM_Guide:DestroyWeakGuideDialog(self._guideId, self._id)
    end
  end
end

function Stage:OnUpdate()
  if self._willPlay and self._status ~= Stage.Status.Doing then
    self:Play()
  elseif self._isWeakGuide and self._status == Stage.Status.Doing then
    self:Play()
  end
end

local function HandleCondition(self, condition, luaWindow)
  local handler = _eventHandlers[condition.ConditionType]
  if handler == nil then
    handler = require(_eventHandlersPath .. condition.ConditionType)
    _eventHandlers[condition.ConditionType] = handler
  end
  return handler(condition, luaWindow)
end

function Stage:CheckFinished(luaWindow)
  if not self._isWeakGuide then
    local tag = true
    tag = HandleCondition(self, self._condition, luaWindow)
    if tag then
      RemoveObserver(self)
      self._status = Stage.Status.Finished
      LuaNotificationCenter.PostNotification(Common.n_GuideStageFinished, self, {
        guideID = self._guideId,
        stageID = self._id
      })
      LogInfoFormat("Stage", "FinishStage guideID = %s, stageID = %s", self._guideId, self._id)
    end
    return tag
  else
    if self._status ~= Stage.Status.Doing then
      self:Play()
    end
    return false
  end
end

return Stage
