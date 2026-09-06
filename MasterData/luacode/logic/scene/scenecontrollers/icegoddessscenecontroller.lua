local NewBattleSceneController = require("logic.scene.scenecontrollers.newbattlescenecontroller")
local CameraStaticFunctions = CS.PixelNeko.Lua.CameraStaticFunctions
local IceGoddessSceneController = class("IceGoddessSceneController", NewBattleSceneController)

function IceGoddessSceneController:Init()
  IceGoddessSceneController.super.Init(self)
  CS.PixelNeko.UI.UIManager.SetAnimatorAndParticleUseUnscaleTime(self._sceneRef:GetStoryObject())
  CS.PixelNeko.UI.UIManager.SetAnimatorAndParticleUseUnscaleTime(self._sceneRef:GetSceneParticlesObject())
  LuaNotificationCenter.AddObserver(self, self.OnTimelineEnd, Common.n_TimelineStop, nil)
end

function IceGoddessSceneController:BSC_TimeLineStart()
  local dialog = DialogManager.GetDialog("newbattle.battlenewmaindialog")
  if dialog then
    dialog:GetRootWindow():SetActive(false)
  end
  NekoData.DataManager.DM_TimeScale:SetTimelinePause()
  CameraStaticFunctions.CloseCameraLayer(self._sceneRef:GetBattleMainCamera(), 30)
  self._sceneRef:GetTimeLine1Object():SetActive(true)
  self._sceneRef:GetTimeLine1():Play()
end

function IceGoddessSceneController:BSC_TimeLineEnd()
  local dialog = DialogManager.GetDialog("newbattle.battlenewmaindialog")
  if dialog then
    dialog:GetRootWindow():SetActive(true)
  end
  NekoData.DataManager.DM_TimeScale:CancelTimelinePause()
  CameraStaticFunctions.OpenCameraLayer(self._sceneRef:GetBattleMainCamera(), 30)
  self._sceneRef:GetTimeLine1Object():SetActive(false)
  self:BSC_UpdateAllLocalProtocol()
  self:SetBattleTimelineTag(false)
end

function IceGoddessSceneController:OnTimelineEnd(notification)
  if notification.userInfo == self._sceneRef:GetTimeLine1() then
    self._bsc_battleFSM:SetBoolean("toUnloadTimeline", true)
  end
end

function IceGoddessSceneController:OnSBattlePause(protocol)
  NekoData.DataManager.DM_TimeScale:SetTimelinePause()
  IceGoddessSceneController.super.OnSBattlePause(self, protocol)
end

return IceGoddessSceneController
