-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/icegoddessscenecontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NewBattleSceneController = require("logic.scene.scenecontrollers.newbattlescenecontroller")
local CameraStaticFunctions = ((CS.PixelNeko).Lua).CameraStaticFunctions
local IceGoddessSceneController = class("IceGoddessSceneController", NewBattleSceneController)
IceGoddessSceneController.Init = function(self)
  -- function num : 0_0 , upvalues : IceGoddessSceneController, _ENV
  ((IceGoddessSceneController.super).Init)(self)
  ;
  ((((CS.PixelNeko).UI).UIManager).SetAnimatorAndParticleUseUnscaleTime)((self._sceneRef):GetStoryObject())
  ;
  ((((CS.PixelNeko).UI).UIManager).SetAnimatorAndParticleUseUnscaleTime)((self._sceneRef):GetSceneParticlesObject())
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnTimelineEnd, Common.n_TimelineStop, nil)
end

IceGoddessSceneController.BSC_TimeLineStart = function(self)
  -- function num : 0_1 , upvalues : _ENV, CameraStaticFunctions
  local dialog = (DialogManager.GetDialog)("newbattle.battlenewmaindialog")
  if dialog then
    (dialog:GetRootWindow()):SetActive(false)
  end
  ;
  ((NekoData.DataManager).DM_TimeScale):SetTimelinePause()
  ;
  (CameraStaticFunctions.CloseCameraLayer)((self._sceneRef):GetBattleMainCamera(), 30)
  ;
  ((self._sceneRef):GetTimeLine1Object()):SetActive(true)
  ;
  ((self._sceneRef):GetTimeLine1()):Play()
end

IceGoddessSceneController.BSC_TimeLineEnd = function(self)
  -- function num : 0_2 , upvalues : _ENV, CameraStaticFunctions
  local dialog = (DialogManager.GetDialog)("newbattle.battlenewmaindialog")
  if dialog then
    (dialog:GetRootWindow()):SetActive(true)
  end
  ;
  ((NekoData.DataManager).DM_TimeScale):CancelTimelinePause()
  ;
  (CameraStaticFunctions.OpenCameraLayer)((self._sceneRef):GetBattleMainCamera(), 30)
  ;
  ((self._sceneRef):GetTimeLine1Object()):SetActive(false)
  self:BSC_UpdateAllLocalProtocol()
  self:SetBattleTimelineTag(false)
end

IceGoddessSceneController.OnTimelineEnd = function(self, notification)
  -- function num : 0_3
  if notification.userInfo == (self._sceneRef):GetTimeLine1() then
    (self._bsc_battleFSM):SetBoolean("toUnloadTimeline", true)
  end
end

IceGoddessSceneController.OnSBattlePause = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV, IceGoddessSceneController
  ((NekoData.DataManager).DM_TimeScale):SetTimelinePause()
  ;
  ((IceGoddessSceneController.super).OnSBattlePause)(self, protocol)
end

return IceGoddessSceneController

