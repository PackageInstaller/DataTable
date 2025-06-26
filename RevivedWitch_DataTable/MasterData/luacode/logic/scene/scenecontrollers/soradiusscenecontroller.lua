-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/soradiusscenecontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NewBattleSceneController = require("logic.scene.scenecontrollers.newbattlescenecontroller")
local CameraStaticFunctions = ((CS.PixelNeko).Lua).CameraStaticFunctions
local SoradiusSceneController = class("SoradiusSceneController", NewBattleSceneController)
SoradiusSceneController.Init = function(self)
  -- function num : 0_0 , upvalues : SoradiusSceneController, _ENV
  ((SoradiusSceneController.super).Init)(self)
  ;
  ((((CS.PixelNeko).UI).UIManager).SetAnimatorAndParticleUseUnscaleTime)((self._sceneRef):GetStep1Object())
  ;
  ((((CS.PixelNeko).UI).UIManager).SetAnimatorAndParticleUseUnscaleTime)((self._sceneRef):GetStep2Object())
  ;
  ((((CS.PixelNeko).UI).UIManager).SetAnimatorAndParticleUseUnscaleTime)((self._sceneRef):GetStep3Object())
  ;
  ((((CS.PixelNeko).UI).UIManager).SetAnimatorAndParticleUseUnscaleTime)((self._sceneRef):GetStoryObject())
  ;
  ((((CS.PixelNeko).UI).UIManager).SetAnimatorAndParticleUseUnscaleTime)((self._sceneRef):GetSceneParticlesObject())
  ;
  (((((CS.PixelNeko).P1).TimeLine).EventTriggerHelper).AddTriggerBehaviourPlayListener)((self._sceneRef):GetStartTimeLineObject(), self.OnStartTriggerBehaviourPlay, self)
  ;
  (((((CS.PixelNeko).P1).TimeLine).EventTriggerHelper).AddTriggerBehaviourPlayListener)((self._sceneRef):GetChange1TimeLineObject(), self.OnChange1TriggerBehaviourPlay, self)
  ;
  (((((CS.PixelNeko).P1).TimeLine).EventTriggerHelper).AddTriggerBehaviourPlayListener)((self._sceneRef):GetChange2TimeLineObject(), self.OnChange2TriggerBehaviourPlay, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnTimelineEnd, Common.n_TimelineStop, nil)
  self._bossCount = 1
end

SoradiusSceneController.BSC_TimeLineStart = function(self, timelineObjectName)
  -- function num : 0_1 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("newbattle.battlenewmaindialog")
  if dialog then
    (dialog:GetRootWindow()):SetActive(false)
  end
  ;
  ((NekoData.DataManager).DM_TimeScale):SetTimelinePause()
  if timelineObjectName == "W3_Boss_Change1" then
    self._bossCount = self._bossCount + 1
    ;
    ((self._sceneRef):GetStartTimeLineObject()):SetActive(false)
    ;
    ((self._sceneRef):GetChange1TimeLineObject()):SetActive(true)
    ;
    ((self._sceneRef):GetChange2TimeLineObject()):SetActive(false)
    ;
    ((self._sceneRef):GetDeathTimeLineObject()):SetActive(false)
    ;
    ((self._sceneRef):GetChange1TimeLine()):Play()
  else
    if timelineObjectName == "W3_Boss_Change2" then
      self._bossCount = self._bossCount + 1
      ;
      ((self._sceneRef):GetStartTimeLineObject()):SetActive(false)
      ;
      ((self._sceneRef):GetChange1TimeLineObject()):SetActive(false)
      ;
      ((self._sceneRef):GetChange2TimeLineObject()):SetActive(true)
      ;
      ((self._sceneRef):GetDeathTimeLineObject()):SetActive(false)
      ;
      ((self._sceneRef):GetChange2TimeLine()):Play()
    else
      if timelineObjectName == "W3_Boss_Death" then
        ((self._sceneRef):GetStartTimeLineObject()):SetActive(false)
        ;
        ((self._sceneRef):GetChange1TimeLineObject()):SetActive(false)
        ;
        ((self._sceneRef):GetChange2TimeLineObject()):SetActive(false)
        ;
        ((self._sceneRef):GetDeathTimeLineObject()):SetActive(true)
        ;
        ((self._sceneRef):GetDeathTimeLine()):Play()
      else
        ;
        (self._bsc_battleFSM):SetBoolean("toUnloadTimeline", true)
      end
    end
  end
end

SoradiusSceneController.BSC_TimeLineEnd = function(self, timelineObjectName)
  -- function num : 0_2 , upvalues : _ENV
  if timelineObjectName == "W3_Boss_Death" then
    local dialog = (DialogManager.GetDialog)("newbattle.battlenewmaindialog")
    if dialog then
      (dialog:GetRootWindow()):SetActive(true)
    end
    ;
    ((NekoData.DataManager).DM_TimeScale):CancelTimelinePause()
    self:BSC_UpdateAllLocalProtocol()
    self:SetBattleTimelineTag(false)
  end
end

SoradiusSceneController.OnStartTriggerBehaviourPlay = function(self, doubleValue, longValue, stringValue, objectValue)
  -- function num : 0_3 , upvalues : _ENV, SoradiusSceneController
  if stringValue == "BattleStart" then
    local protocol = ((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()
    ;
    ((SoradiusSceneController.super).OnSBattleStart)(self, protocol)
    self._battleStartFlag = true
  end
end

SoradiusSceneController.OnChange1TriggerBehaviourPlay = function(self, doubleValue, longValue, stringValue, objectValue)
  -- function num : 0_4 , upvalues : _ENV
  if stringValue == "Continue" then
    (self._bsc_battleFSM):SetBoolean("toUnloadTimeline", true)
    local dialog = (DialogManager.GetDialog)("newbattle.battlenewmaindialog")
    if dialog then
      (dialog:GetRootWindow()):SetActive(true)
    end
    ;
    ((NekoData.DataManager).DM_TimeScale):CancelTimelinePause()
    self:BSC_UpdateAllLocalProtocol()
    self:SetBattleTimelineTag(false)
  end
end

SoradiusSceneController.OnChange2TriggerBehaviourPlay = function(self, doubleValue, longValue, stringValue, objectValue)
  -- function num : 0_5 , upvalues : _ENV
  if stringValue == "Continue" then
    (self._bsc_battleFSM):SetBoolean("toUnloadTimeline", true)
    local dialog = (DialogManager.GetDialog)("newbattle.battlenewmaindialog")
    if dialog then
      (dialog:GetRootWindow()):SetActive(true)
    end
    ;
    ((NekoData.DataManager).DM_TimeScale):CancelTimelinePause()
    self:BSC_UpdateAllLocalProtocol()
    self:SetBattleTimelineTag(false)
  end
end

SoradiusSceneController.OnTimelineEnd = function(self, notification)
  -- function num : 0_6
  if self._battleStartFlag and notification.userInfo == (self._sceneRef):GetStartTimeLine() then
    ((self._sceneRef):GetStoryObjectBoss()):SetActive(false)
  end
  if notification.userInfo == (self._sceneRef):GetDeathTimeLine() then
    (self._bsc_battleFSM):SetBoolean("toUnloadTimeline", true)
  end
  if notification.userInfo == (self._sceneRef):GetChange1TimeLine() then
    ((self._sceneRef):GetStep2ObjectBoss()):SetActive(false)
  end
  if notification.userInfo == (self._sceneRef):GetChange2TimeLine() then
    ((self._sceneRef):GetStep3ObjectBoss()):SetActive(false)
  end
end

SoradiusSceneController.OnSBattleStart = function(self)
  -- function num : 0_7
  self._battleStartFlag = false
  ;
  ((self._sceneRef):GetStartTimeLineObject()):SetActive(true)
  ;
  ((self._sceneRef):GetChange1TimeLineObject()):SetActive(false)
  ;
  ((self._sceneRef):GetChange2TimeLineObject()):SetActive(false)
  ;
  ((self._sceneRef):GetDeathTimeLineObject()):SetActive(false)
  ;
  ((self._sceneRef):GetStartTimeLine()):Play()
end

SoradiusSceneController.OnSRoleDead = function(self, protocol)
  -- function num : 0_8 , upvalues : _ENV, SoradiusSceneController
  if self._bossCount < 3 then
    (LuaNotificationCenter.PostNotification)(Common.n_HpVisible, SoradiusSceneController, {entityid = protocol.entityId, visible = 0})
  end
  ;
  ((SoradiusSceneController.super).OnSRoleDead)(self, protocol)
end

SoradiusSceneController.OnSBattlePause = function(self, protocol)
  -- function num : 0_9 , upvalues : _ENV, SoradiusSceneController
  ((NekoData.DataManager).DM_TimeScale):SetTimelinePause()
  ;
  ((SoradiusSceneController.super).OnSBattlePause)(self, protocol)
end

return SoradiusSceneController

