local NewBattleSceneController = require("logic.scene.scenecontrollers.newbattlescenecontroller")
local CameraStaticFunctions = CS.PixelNeko.Lua.CameraStaticFunctions
local DestinySceneController = class("DestinySceneController", NewBattleSceneController)

function DestinySceneController:Init()
  DestinySceneController.super.Init(self)
  CS.PixelNeko.UI.UIManager.SetAnimatorAndParticleUseUnscaleTime(self._sceneRef:GetStep1Object())
  CS.PixelNeko.UI.UIManager.SetAnimatorAndParticleUseUnscaleTime(self._sceneRef:GetStoryObject())
  CS.PixelNeko.UI.UIManager.SetAnimatorAndParticleUseUnscaleTime(self._sceneRef:GetSceneParticlesObject())
  CS.PixelNeko.P1.TimeLine.EventTriggerHelper.AddTriggerBehaviourPlayListener(self._sceneRef:GetStartTimeLineObject(), self.OnBeforeStartTriggerBehaviourPlay, self)
  self._bossCount = 1
end

function DestinySceneController:BSC_TimeLineStart(timelineObjectName)
  if timelineObjectName == "Base_Fragment_05_Boss_PhaseChange" then
    local dialog = DialogManager.GetDialog("newbattle.battlenewmaindialog")
    if dialog then
      dialog:GetRootWindow():SetActive(false)
    end
    NekoData.DataManager.DM_TimeScale:SetTimelinePause()
    self._bossCount = self._bossCount + 1
    self._sceneRef:GetStartTimeLineObject():SetActive(false)
    self._sceneRef:GetChange1TimeLineObject():SetActive(true)
    self._sceneRef:GetChange1TimeLine():Play()
  end
  self._bsc_battleFSM:SetBoolean("toUnloadTimeline", true)
end

function DestinySceneController:BSC_TimeLineEnd(timelineObjectName)
  if timelineObjectName == "Base_Fragment_05_Boss_PhaseChange" then
    local dialog = DialogManager.GetDialog("newbattle.battlenewmaindialog")
    if dialog then
      dialog:GetRootWindow():SetActive(true)
    end
    NekoData.DataManager.DM_TimeScale:CancelTimelinePause()
    self:BSC_UpdateAllLocalProtocol()
  end
  self:SetBattleTimelineTag(false)
end

function DestinySceneController:OnBeforeStartTriggerBehaviourPlay(doubleValue, longValue, stringValue, objectValue)
  if stringValue == "BattleStart" then
    local protocol = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol()
    DestinySceneController.super.OnSBattleStart(self, protocol)
    self._battleStartFlag = true
  end
end

function DestinySceneController:OnSBattleStart()
  self._battleStartFlag = false
  self._sceneRef:GetStartTimeLineObject():SetActive(true)
  self._sceneRef:GetChange1TimeLineObject():SetActive(false)
  self._sceneRef:GetStartTimeLine():Play()
end

function DestinySceneController:OnSRoleDead(protocol)
  if self._bossCount < 2 then
    LuaNotificationCenter.PostNotification(Common.n_HpVisible, DestinySceneController, {
      entityid = protocol.entityId,
      visible = 0
    })
  end
  DestinySceneController.super.OnSRoleDead(self, protocol)
end

return DestinySceneController
