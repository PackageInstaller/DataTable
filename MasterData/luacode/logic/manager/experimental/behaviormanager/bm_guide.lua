local BM_Guide = class("BM_Guide")
local _conditionHandlers = {}
local _conditionHandlersPath = "logic.guide.guideconditionhandlers."
local _eventHandlers = {}
local _eventHandlersPath = "logic.guide.guideeventhandlers."
local cGuideLinkConfing = BeanManager.GetTableByName("guide.cguidelinkconfig")
local cGuideConditionconfig = BeanManager.GetTableByName("guide.cguideconditionconfig")

local function HandleCondition(self, conditionID)
  local conditionInfo = cGuideConditionconfig:GetRecorder(conditionID)
  if not conditionInfo then
    LogErrorFormat("BM_Guide", "--- conditionID = %s ---", conditionID)
  end
  local handler = _conditionHandlers[conditionInfo.ConditionType]
  if handler == nil then
    handler = require(_conditionHandlersPath .. conditionInfo.ConditionType)
    _conditionHandlers[conditionInfo.ConditionType] = handler
  end
  return handler(conditionInfo)
end

local function CanPlayGuide(self, guideID)
  local guideInfo = cGuideLinkConfing:GetRecorder(guideID)
  local conditions = string.split(guideInfo.StartCondition, ",")
  for k, v in ipairs(conditions) do
    local conditionID = tonumber(v)
    local result = HandleCondition(self, conditionID)
    if result ~= true then
      return false
    end
  end
  return true
end

local function CheckGuideFinished(self, guideID)
  local guideInfo = cGuideLinkConfing:GetRecorder(guideID)
  if guideInfo.EndCondition ~= "" then
    local conditions = string.split(guideInfo.EndCondition, ",")
    for k, v in ipairs(conditions) do
      local conditionID = tonumber(v)
      local result = HandleCondition(self, conditionID)
      if result ~= true then
        return false
      end
    end
  end
  return true
end

local function SearchNextGuide(self, currentGuideId)
  local cachedToCheckGuideIDTable = self._dm:GetCachedGuideIDs()
  for k, v in pairs(cachedToCheckGuideIDTable) do
    if CheckGuideFinished(self, k) then
      self:CompleteGuide(v)
    elseif k ~= currentGuideId and CanPlayGuide(self, k) == true then
      local currentGuide = self._dm:GetCurrentGuide()
      local guide = self._dm:GetGuide(k)
      if currentGuide and currentGuide._isWeakGuide and guide and not guide._isWeakGuide then
        self._dm:CancleCurrentGuide(currentGuide:GetID())
        currentGuide = self._dm:AddCurrentGuideFromCached(k)
        LuaNotificationCenter.PostNotification(Common.n_GuideStatusChanged, self, {guideStatus = "Start", guideID = k})
        currentGuide:Play()
        break
      elseif not currentGuide or guide and not guide._isWeakGuide then
        currentGuide = self._dm:AddCurrentGuideFromCached(k)
        LuaNotificationCenter.PostNotification(Common.n_GuideStatusChanged, self, {guideStatus = "Start", guideID = k})
        currentGuide:Play()
        if not currentGuide._isWeakGuide then
          break
        end
      end
    end
  end
end

local function DoCheckFinish(self)
  local currentGuide = self._dm:GetCurrentGuide()
  local guideId
  if currentGuide then
    guideId = currentGuide:GetID()
    LogInfoFormat("BM_Guide", "currentGuideId = %s", guideId)
    if CheckGuideFinished(self, guideId) then
      self:CompleteGuide(currentGuide)
    elseif not CanPlayGuide(self, guideId) then
      self._dm:CancleCurrentGuide(guideId)
    elseif self:HaveOtherCanPlayGuide() then
      self._dm:CancleCurrentGuide(guideId)
    end
  end
  if not self._dm:GetCurrentGuide() then
    SearchNextGuide(self, guideId)
  end
end

local function HandleTriggerGuide(self, notification)
  DoCheckFinish(self)
end

local function OnHandleWeakGuide(self, notification)
  if notification.userInfo.guideStatus ~= "Start" then
    local guideId = notification.userInfo.guideID
    local guideInfo = cGuideLinkConfing:GetRecorder(guideId)
    if guideInfo and guideInfo.guideType ~= 1 then
      local map = self._guide.weakGuideDialogs[guideId]
      if map then
        for k, v in pairs(map) do
          v:Destroy()
          v:RootWindowDestroy()
          map[k] = nil
        end
      end
    end
  end
end

function BM_Guide:Ctor()
  self._guide = NekoData.Data.guide
  self._dm = NekoData.DataManager.DM_Guide
  LuaNotificationCenter.AddObserver(self, HandleTriggerGuide, Common.n_LevelUp, nil)
  LuaNotificationCenter.AddObserver(self, HandleTriggerGuide, Common.n_EquipChanged, nil)
  LuaNotificationCenter.AddObserver(self, HandleTriggerGuide, Common.n_BuildingLevelUp, nil)
  LuaNotificationCenter.AddObserver(self, HandleTriggerGuide, Common.n_OnSChooseBackGround, nil)
  LuaNotificationCenter.AddObserver(self, HandleTriggerGuide, Common.n_SUpdateSummerMissions, nil)
  LuaNotificationCenter.AddObserver(self, HandleTriggerGuide, Common.n_TriggerGuide, nil)
  LuaNotificationCenter.AddObserver(self, OnHandleWeakGuide, Common.n_GuideStatusChanged, nil)
end

function BM_Guide:HaveOtherCanPlayGuide()
  local currentGuide = self._dm:GetCurrentGuide()
  local currentGuideId
  if currentGuide then
    currentGuideId = currentGuide:GetID()
  end
  local cachedToCheckGuideIDTable = self._dm:GetCachedGuideIDs()
  for k, v in pairs(cachedToCheckGuideIDTable) do
    if k ~= currentGuideId and CanPlayGuide(self, k) == true then
      return true
    end
  end
end

function BM_Guide:HasFinished(guideID)
  if self._dm:HasFinished(guideID) then
    return true
  end
  return false
end

function BM_Guide:CompleteGuide(guide)
  guide:Finished()
  self._dm:FinishGuide(guide:GetID())
  DoCheckFinish(self)
end

function BM_Guide:FinishGuide(guideID)
  local guide = self._dm:GetGuide(guideID)
  if guide then
    guide:Finished()
  end
  self._dm:FinishGuide(guideID)
  DoCheckFinish(self)
end

function BM_Guide:IsCurrentGuide(guideID)
  return self._dm:IsCurrentGuide(guideID)
end

function BM_Guide:IsCurrentStage(guideID, stageID)
  return self._dm:IsCurrentStage(guideID, stageID)
end

function BM_Guide:HasCurrentGuide()
  return self._dm:HasCurrentGuide()
end

function BM_Guide:HasCurrentStrongGuide()
  local currentGuide = self._dm:GetCurrentGuide()
  return currentGuide and not currentGuide._isWeakGuide
end

function BM_Guide:CreateGuideDialog(guideId, stageId, blackPanelParmFunc, textPanelParmFunc, direction, wordId, profileId, raycastTarget)
  local dialog = DialogManager.CreateSingletonDialog("guide.guidedialog")
  dialog:SetGuideId(guideId, stageId)
  dialog:SetEmptyPoint(blackPanelParmFunc)
  dialog:SetTextPoint(textPanelParmFunc, direction, wordId, profileId, raycastTarget)
end

function BM_Guide:CreateWeakGuideDialog(guideId, stageId, parent, effectPos)
  if not self._guide.weakGuideDialogs[guideId] then
    self._guide.weakGuideDialogs[guideId] = {}
  end
  local dialog = self._guide.weakGuideDialogs[guideId][stageId]
  dialog = dialog or DialogManager.CreateDialog("guide.weakguidedialog", parent)
  dialog:SetEffectPos(effectPos)
  self._guide.weakGuideDialogs[guideId][stageId] = dialog
end

function BM_Guide:DestroyWeakGuideDialog(guideId, stageId)
  local map = self._guide.weakGuideDialogs[guideId]
  if map and map[stageId] then
    local dialog = map[stageId]
    map[stageId] = nil
    dialog:Destroy()
    dialog:RootWindowDestroy()
  end
end

function BM_Guide:CreateGuideDialogInBattle(guideId, blackPanelParmFunc, textPanelParmFunc, direction, wordId)
  local dialog = DialogManager.CreateSingletonDialog("guide.guidedialoginbattle")
  dialog:SetGuideId(guideId)
  dialog:SetEmptyPoint(blackPanelParmFunc)
  dialog:SetTextPoint(textPanelParmFunc, direction, wordId, 12398)
end

function BM_Guide:DestroyGuideDialogInBattle()
  DialogManager.DestroySingletonDialog("guide.guidedialoginbattle")
end

function BM_Guide:CanPlayGuide(guideID)
  local hasFinished = self:HasFinished(guideID)
  if hasFinished then
    return false
  else
    return CanPlayGuide(self, guideID)
  end
end

return BM_Guide
