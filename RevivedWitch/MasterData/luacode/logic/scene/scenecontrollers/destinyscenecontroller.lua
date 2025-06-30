-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/destinyscenecontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NewBattleSceneController = require("logic.scene.scenecontrollers.newbattlescenecontroller")
local CameraStaticFunctions = ((CS.PixelNeko).Lua).CameraStaticFunctions
local DestinySceneController = class("DestinySceneController", NewBattleSceneController)
DestinySceneController.Init = function(self)
  -- function num : 0_0 , upvalues : DestinySceneController, _ENV
  ((DestinySceneController.super).Init)(self)
  ;
  ((((CS.PixelNeko).UI).UIManager).SetAnimatorAndParticleUseUnscaleTime)((self._sceneRef):GetStep1Object())
  ;
  ((((CS.PixelNeko).UI).UIManager).SetAnimatorAndParticleUseUnscaleTime)((self._sceneRef):GetStoryObject())
  ;
  ((((CS.PixelNeko).UI).UIManager).SetAnimatorAndParticleUseUnscaleTime)((self._sceneRef):GetSceneParticlesObject())
  ;
  (((((CS.PixelNeko).P1).TimeLine).EventTriggerHelper).AddTriggerBehaviourPlayListener)((self._sceneRef):GetStartTimeLineObject(), self.OnBeforeStartTriggerBehaviourPlay, self)
  self._bossCount = 1
end

DestinySceneController.BSC_TimeLineStart = function(self, timelineObjectName)
  -- function num : 0_1 , upvalues : _ENV
  do
    if timelineObjectName == "Base_Fragment_05_Boss_PhaseChange" then
      local dialog = (DialogManager.GetDialog)("newbattle.battlenewmaindialog")
      if dialog then
        (dialog:GetRootWindow()):SetActive(false)
      end
      ;
      ((NekoData.DataManager).DM_TimeScale):SetTimelinePause()
      self._bossCount = self._bossCount + 1
      ;
      ((self._sceneRef):GetStartTimeLineObject()):SetActive(false)
      ;
      ((self._sceneRef):GetChange1TimeLineObject()):SetActive(true)
      ;
      ((self._sceneRef):GetChange1TimeLine()):Play()
    end
    ;
    (self._bsc_battleFSM):SetBoolean("toUnloadTimeline", true)
  end
end

DestinySceneController.BSC_TimeLineEnd = function(self, timelineObjectName)
  -- function num : 0_2 , upvalues : _ENV
  do
    if timelineObjectName == "Base_Fragment_05_Boss_PhaseChange" then
      local dialog = (DialogManager.GetDialog)("newbattle.battlenewmaindialog")
      if dialog then
        (dialog:GetRootWindow()):SetActive(true)
      end
      ;
      ((NekoData.DataManager).DM_TimeScale):CancelTimelinePause()
      self:BSC_UpdateAllLocalProtocol()
    end
    self:SetBattleTimelineTag(false)
  end
end

DestinySceneController.OnBeforeStartTriggerBehaviourPlay = function(self, doubleValue, longValue, stringValue, objectValue)
  -- function num : 0_3 , upvalues : _ENV, DestinySceneController
  if stringValue == "BattleStart" then
    local protocol = ((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()
    ;
    ((DestinySceneController.super).OnSBattleStart)(self, protocol)
    self._battleStartFlag = true
  end
end

DestinySceneController.OnSBattleStart = function(self)
  -- function num : 0_4
  self._battleStartFlag = false
  ;
  ((self._sceneRef):GetStartTimeLineObject()):SetActive(true)
  ;
  ((self._sceneRef):GetChange1TimeLineObject()):SetActive(false)
  ;
  ((self._sceneRef):GetStartTimeLine()):Play()
end

DestinySceneController.OnSRoleDead = function(self, protocol)
  -- function num : 0_5 , upvalues : _ENV, DestinySceneController
  if self._bossCount < 2 then
    (LuaNotificationCenter.PostNotification)(Common.n_HpVisible, DestinySceneController, {entityid = protocol.entityId, visible = 0})
  end
  ;
  ((DestinySceneController.super).OnSRoleDead)(self, protocol)
end

return DestinySceneController

