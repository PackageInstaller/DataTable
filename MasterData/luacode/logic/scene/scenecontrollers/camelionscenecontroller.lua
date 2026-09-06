local NewBattleSceneController = require("logic.scene.scenecontrollers.newbattlescenecontroller")
local CameraStaticFunctions = CS.PixelNeko.Lua.CameraStaticFunctions
local CamelionSceneController = class("CamelionSceneController", NewBattleSceneController)

function CamelionSceneController:Init()
  CamelionSceneController.super.Init(self)
  CS.PixelNeko.UI.UIManager.SetAnimatorAndParticleUseUnscaleTime(self._sceneRef:GetSceneParticlesObject())
  LuaNotificationCenter.AddObserver(self, self.OnTimelineEnd, Common.n_TimelineStop, nil)
  self._bossCount = 1
end

function CamelionSceneController:BSC_TimeLineStart(timelineObjectName)
  local dialog = DialogManager.GetDialog("newbattle.battlenewmaindialog")
  if dialog then
    dialog:GetRootWindow():SetActive(false)
  end
  NekoData.DataManager.DM_TimeScale:SetTimelinePause()
  CameraStaticFunctions.CloseCameraLayer(self._sceneRef:GetBattleMainCamera(), 30)
  if timelineObjectName == "W3_Battle_day2_boss" then
    self._sceneRef:GetTimeLine1Object():SetActive(true)
    self._sceneRef:GetTimeLine1():Play()
  else
    self._bsc_battleFSM:SetBoolean("toUnloadTimeline", true)
  end
end

function CamelionSceneController:BSC_TimeLineEnd(timelineObjectName)
  local dialog = DialogManager.GetDialog("newbattle.battlenewmaindialog")
  if dialog then
    dialog:GetRootWindow():SetActive(true)
  end
  NekoData.DataManager.DM_TimeScale:CancelTimelinePause()
  CameraStaticFunctions.OpenCameraLayer(self._sceneRef:GetBattleMainCamera(), 30)
  if timelineObjectName == "W3_Battle_day2_boss" then
    self._sceneRef:GetTimeLine1Object():SetActive(false)
  end
  self:BSC_UpdateAllLocalProtocol()
  self:SetBattleTimelineTag(false)
end

function CamelionSceneController:OnTimelineEnd(notification)
  if notification.userInfo == self._sceneRef:GetTimeLine1() then
    self._bsc_battleFSM:SetBoolean("toUnloadTimeline", true)
  end
end

function CamelionSceneController:OnSBattlePause(protocol)
  NekoData.DataManager.DM_TimeScale:SetTimelinePause()
  CamelionSceneController.super.OnSBattlePause(self, protocol)
end

function CamelionSceneController:OnSRoleDead(protocol)
  if self._bossCount < 2 then
    self._bossCount = self._bossCount + 1
    LuaNotificationCenter.PostNotification(Common.n_HpVisible, CamelionSceneController, {
      entityid = protocol.entityId,
      visible = 0
    })
  end
  CamelionSceneController.super.OnSRoleDead(self, protocol)
end

return CamelionSceneController
