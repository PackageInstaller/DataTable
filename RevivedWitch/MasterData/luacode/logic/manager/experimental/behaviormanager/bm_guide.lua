-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_guide.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_Guide = class("BM_Guide")
local _conditionHandlers = {}
local _conditionHandlersPath = "logic.guide.guideconditionhandlers."
local _eventHandlers = {}
local _eventHandlersPath = "logic.guide.guideeventhandlers."
local cGuideLinkConfing = (BeanManager.GetTableByName)("guide.cguidelinkconfig")
local cGuideConditionconfig = (BeanManager.GetTableByName)("guide.cguideconditionconfig")
local HandleCondition = function(self, conditionID)
  -- function num : 0_0 , upvalues : cGuideConditionconfig, _ENV, _conditionHandlers, _conditionHandlersPath
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

local CanPlayGuide = function(self, guideID)
  -- function num : 0_1 , upvalues : cGuideLinkConfing, _ENV, HandleCondition
  local guideInfo = cGuideLinkConfing:GetRecorder(guideID)
  local conditions = (string.split)(guideInfo.StartCondition, ",")
  for k,v in ipairs(conditions) do
    local conditionID = tonumber(v)
    local result = HandleCondition(self, conditionID)
    if result ~= true then
      return false
    end
  end
  return true
end

local CheckGuideFinished = function(self, guideID)
  -- function num : 0_2 , upvalues : cGuideLinkConfing, _ENV, HandleCondition
  local guideInfo = cGuideLinkConfing:GetRecorder(guideID)
  if guideInfo.EndCondition ~= "" then
    local conditions = (string.split)(guideInfo.EndCondition, ",")
    for k,v in ipairs(conditions) do
      local conditionID = tonumber(v)
      local result = HandleCondition(self, conditionID)
      if result ~= true then
        return false
      end
    end
  end
  do
    return true
  end
end

local SearchNextGuide = function(self, currentGuideId)
  -- function num : 0_3 , upvalues : _ENV, CheckGuideFinished, CanPlayGuide
  local cachedToCheckGuideIDTable = (self._dm):GetCachedGuideIDs()
  for k,v in pairs(cachedToCheckGuideIDTable) do
    if CheckGuideFinished(self, k) then
      self:CompleteGuide(v)
    else
      if k ~= currentGuideId and CanPlayGuide(self, k) == true then
        local currentGuide = (self._dm):GetCurrentGuide()
        local guide = (self._dm):GetGuide(k)
        if currentGuide and currentGuide._isWeakGuide and guide and not guide._isWeakGuide then
          (self._dm):CancleCurrentGuide(currentGuide:GetID())
          currentGuide = (self._dm):AddCurrentGuideFromCached(k)
          ;
          (LuaNotificationCenter.PostNotification)(Common.n_GuideStatusChanged, self, {guideStatus = "Start", guideID = k})
          currentGuide:Play()
          break
        else
          if not currentGuide or guide and not guide._isWeakGuide then
            currentGuide = (self._dm):AddCurrentGuideFromCached(k)
            ;
            (LuaNotificationCenter.PostNotification)(Common.n_GuideStatusChanged, self, {guideStatus = "Start", guideID = k})
            currentGuide:Play()
          end
        end
      end
    end
  end
  do
    if currentGuide._isWeakGuide then
    end
  end
end

local DoCheckFinish = function(self)
  -- function num : 0_4 , upvalues : _ENV, CheckGuideFinished, CanPlayGuide, SearchNextGuide
  ((self._dm):GetCurrentGuide())
  local currentGuide = nil
  local guideId = nil
  if currentGuide then
    guideId = currentGuide:GetID()
    LogInfoFormat("BM_Guide", "currentGuideId = %s", guideId)
    if CheckGuideFinished(self, guideId) then
      self:CompleteGuide(currentGuide)
    else
      if not CanPlayGuide(self, guideId) then
        (self._dm):CancleCurrentGuide(guideId)
      else
        if self:HaveOtherCanPlayGuide() then
          (self._dm):CancleCurrentGuide(guideId)
        end
      end
    end
  end
  if not (self._dm):GetCurrentGuide() then
    SearchNextGuide(self, guideId)
  end
end

local HandleTriggerGuide = function(self, notification)
  -- function num : 0_5 , upvalues : DoCheckFinish
  DoCheckFinish(self)
end

local OnHandleWeakGuide = function(self, notification)
  -- function num : 0_6 , upvalues : cGuideLinkConfing, _ENV
  if (notification.userInfo).guideStatus ~= "Start" then
    local guideId = (notification.userInfo).guideID
    local guideInfo = cGuideLinkConfing:GetRecorder(guideId)
    if guideInfo and guideInfo.guideType ~= 1 then
      local map = ((self._guide).weakGuideDialogs)[guideId]
      if map then
        for k,v in pairs(map) do
          v:Destroy()
          v:RootWindowDestroy()
          map[k] = nil
        end
      end
    end
  end
end

BM_Guide.Ctor = function(self)
  -- function num : 0_7 , upvalues : _ENV, HandleTriggerGuide, OnHandleWeakGuide
  self._guide = (NekoData.Data).guide
  self._dm = (NekoData.DataManager).DM_Guide
  ;
  (LuaNotificationCenter.AddObserver)(self, HandleTriggerGuide, Common.n_LevelUp, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, HandleTriggerGuide, Common.n_EquipChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, HandleTriggerGuide, Common.n_BuildingLevelUp, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, HandleTriggerGuide, Common.n_OnSChooseBackGround, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, HandleTriggerGuide, Common.n_SUpdateSummerMissions, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, HandleTriggerGuide, Common.n_TriggerGuide, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, OnHandleWeakGuide, Common.n_GuideStatusChanged, nil)
end

BM_Guide.HaveOtherCanPlayGuide = function(self)
  -- function num : 0_8 , upvalues : _ENV, CanPlayGuide
  ((self._dm):GetCurrentGuide())
  local currentGuide = nil
  local currentGuideId = nil
  if currentGuide then
    currentGuideId = currentGuide:GetID()
  end
  local cachedToCheckGuideIDTable = (self._dm):GetCachedGuideIDs()
  for k,v in pairs(cachedToCheckGuideIDTable) do
    if k ~= currentGuideId and CanPlayGuide(self, k) == true then
      return true
    end
  end
end

BM_Guide.HasFinished = function(self, guideID)
  -- function num : 0_9
  if (self._dm):HasFinished(guideID) then
    return true
  end
  return false
end

BM_Guide.CompleteGuide = function(self, guide)
  -- function num : 0_10 , upvalues : DoCheckFinish
  guide:Finished()
  ;
  (self._dm):FinishGuide(guide:GetID())
  DoCheckFinish(self)
end

BM_Guide.FinishGuide = function(self, guideID)
  -- function num : 0_11 , upvalues : DoCheckFinish
  local guide = (self._dm):GetGuide(guideID)
  if guide then
    guide:Finished()
  end
  ;
  (self._dm):FinishGuide(guideID)
  DoCheckFinish(self)
end

BM_Guide.IsCurrentGuide = function(self, guideID)
  -- function num : 0_12
  return (self._dm):IsCurrentGuide(guideID)
end

BM_Guide.IsCurrentStage = function(self, guideID, stageID)
  -- function num : 0_13
  return (self._dm):IsCurrentStage(guideID, stageID)
end

BM_Guide.HasCurrentGuide = function(self)
  -- function num : 0_14
  return (self._dm):HasCurrentGuide()
end

BM_Guide.HasCurrentStrongGuide = function(self)
  -- function num : 0_15
  local currentGuide = (self._dm):GetCurrentGuide()
  if currentGuide then
    return not currentGuide._isWeakGuide
  end
end

BM_Guide.CreateGuideDialog = function(self, guideId, stageId, blackPanelParmFunc, textPanelParmFunc, direction, wordId, profileId, raycastTarget)
  -- function num : 0_16 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("guide.guidedialog")
  dialog:SetGuideId(guideId, stageId)
  dialog:SetEmptyPoint(blackPanelParmFunc)
  dialog:SetTextPoint(textPanelParmFunc, direction, wordId, profileId, raycastTarget)
end

BM_Guide.CreateWeakGuideDialog = function(self, guideId, stageId, parent, effectPos)
  -- function num : 0_17 , upvalues : _ENV
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R5 in 'UnsetPending'

  if not ((self._guide).weakGuideDialogs)[guideId] then
    ((self._guide).weakGuideDialogs)[guideId] = {}
  end
  local dialog = (((self._guide).weakGuideDialogs)[guideId])[stageId]
  if not dialog then
    dialog = (DialogManager.CreateDialog)("guide.weakguidedialog", parent)
  end
  dialog:SetEffectPos(effectPos)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (((self._guide).weakGuideDialogs)[guideId])[stageId] = dialog
end

BM_Guide.DestroyWeakGuideDialog = function(self, guideId, stageId)
  -- function num : 0_18
  local map = ((self._guide).weakGuideDialogs)[guideId]
  if map and map[stageId] then
    local dialog = map[stageId]
    map[stageId] = nil
    dialog:Destroy()
    dialog:RootWindowDestroy()
  end
end

BM_Guide.CreateGuideDialogInBattle = function(self, guideId, blackPanelParmFunc, textPanelParmFunc, direction, wordId)
  -- function num : 0_19 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("guide.guidedialoginbattle")
  dialog:SetGuideId(guideId)
  dialog:SetEmptyPoint(blackPanelParmFunc)
  dialog:SetTextPoint(textPanelParmFunc, direction, wordId, 12398)
end

BM_Guide.DestroyGuideDialogInBattle = function(self)
  -- function num : 0_20 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("guide.guidedialoginbattle")
end

BM_Guide.CanPlayGuide = function(self, guideID)
  -- function num : 0_21 , upvalues : CanPlayGuide
  local hasFinished = self:HasFinished(guideID)
  if hasFinished then
    return false
  else
    return CanPlayGuide(self, guideID)
  end
end

return BM_Guide

