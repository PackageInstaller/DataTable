local NewBattleSceneController = require("logic.scene.scenecontrollers.newbattlescenecontroller")
local CameraStaticFunctions = CS.PixelNeko.Lua.CameraStaticFunctions
local SimolaSceneController = class("SimolaSceneController", NewBattleSceneController)

function SimolaSceneController:Init()
  SimolaSceneController.super.Init(self)
  CS.PixelNeko.UI.UIManager.SetAnimatorAndParticleUseUnscaleTime(self._sceneRef:GetSceneParticlesObject())
  LuaNotificationCenter.AddObserver(self, self.OnTimelineEnd, Common.n_TimelineStop, nil)
end

function SimolaSceneController:BSC_TimeLineStart(timelineObjectName)
  local dialog = DialogManager.GetDialog("newbattle.battlenewmaindialog")
  if dialog then
    dialog:GetRootWindow():SetActive(false)
  end
  NekoData.DataManager.DM_TimeScale:SetTimelinePause()
  CameraStaticFunctions.CloseCameraLayer(self._sceneRef:GetBattleMainCamera(), 30)
  if timelineObjectName == "W4_Battle_boss_01" then
    self._sceneRef:GetTimeLine1Object():SetActive(true)
    self._sceneRef:GetTimeLine1():Play()
  else
    self._bsc_battleFSM:SetBoolean("toUnloadTimeline", true)
  end
end

function SimolaSceneController:BSC_TimeLineEnd(timelineObjectName)
  local dialog = DialogManager.GetDialog("newbattle.battlenewmaindialog")
  if dialog then
    dialog:GetRootWindow():SetActive(true)
  end
  NekoData.DataManager.DM_TimeScale:CancelTimelinePause()
  CameraStaticFunctions.OpenCameraLayer(self._sceneRef:GetBattleMainCamera(), 30)
  if timelineObjectName == "W4_Battle_boss_01" then
    self._sceneRef:GetTimeLine1Object():SetActive(false)
  end
  self:BSC_UpdateAllLocalProtocol()
  self:SetBattleTimelineTag(false)
end

function SimolaSceneController:OnTimelineEnd(notification)
  if notification.userInfo == self._sceneRef:GetTimeLine1() then
    self._bsc_battleFSM:SetBoolean("toUnloadTimeline", true)
  end
end

function SimolaSceneController:OnSBattlePause(protocol)
  NekoData.DataManager.DM_TimeScale:SetTimelinePause()
  SimolaSceneController.super.OnSBattlePause(self, protocol)
end

return SimolaSceneController
