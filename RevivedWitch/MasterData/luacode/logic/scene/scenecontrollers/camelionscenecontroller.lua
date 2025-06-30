-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/camelionscenecontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NewBattleSceneController = require("logic.scene.scenecontrollers.newbattlescenecontroller")
local CameraStaticFunctions = ((CS.PixelNeko).Lua).CameraStaticFunctions
local CamelionSceneController = class("CamelionSceneController", NewBattleSceneController)
CamelionSceneController.Init = function(self)
  -- function num : 0_0 , upvalues : CamelionSceneController, _ENV
  ((CamelionSceneController.super).Init)(self)
  ;
  ((((CS.PixelNeko).UI).UIManager).SetAnimatorAndParticleUseUnscaleTime)((self._sceneRef):GetSceneParticlesObject())
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnTimelineEnd, Common.n_TimelineStop, nil)
  self._bossCount = 1
end

CamelionSceneController.BSC_TimeLineStart = function(self, timelineObjectName)
  -- function num : 0_1 , upvalues : _ENV, CameraStaticFunctions
  local dialog = (DialogManager.GetDialog)("newbattle.battlenewmaindialog")
  if dialog then
    (dialog:GetRootWindow()):SetActive(false)
  end
  ;
  ((NekoData.DataManager).DM_TimeScale):SetTimelinePause()
  ;
  (CameraStaticFunctions.CloseCameraLayer)((self._sceneRef):GetBattleMainCamera(), 30)
  if timelineObjectName == "W3_Battle_day2_boss" then
    ((self._sceneRef):GetTimeLine1Object()):SetActive(true)
    ;
    ((self._sceneRef):GetTimeLine1()):Play()
  else
    ;
    (self._bsc_battleFSM):SetBoolean("toUnloadTimeline", true)
  end
end

CamelionSceneController.BSC_TimeLineEnd = function(self, timelineObjectName)
  -- function num : 0_2 , upvalues : _ENV, CameraStaticFunctions
  local dialog = (DialogManager.GetDialog)("newbattle.battlenewmaindialog")
  if dialog then
    (dialog:GetRootWindow()):SetActive(true)
  end
  ;
  ((NekoData.DataManager).DM_TimeScale):CancelTimelinePause()
  ;
  (CameraStaticFunctions.OpenCameraLayer)((self._sceneRef):GetBattleMainCamera(), 30)
  if timelineObjectName == "W3_Battle_day2_boss" then
    ((self._sceneRef):GetTimeLine1Object()):SetActive(false)
  end
  self:BSC_UpdateAllLocalProtocol()
  self:SetBattleTimelineTag(false)
end

CamelionSceneController.OnTimelineEnd = function(self, notification)
  -- function num : 0_3
  if notification.userInfo == (self._sceneRef):GetTimeLine1() then
    (self._bsc_battleFSM):SetBoolean("toUnloadTimeline", true)
  end
end

CamelionSceneController.OnSBattlePause = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV, CamelionSceneController
  ((NekoData.DataManager).DM_TimeScale):SetTimelinePause()
  ;
  ((CamelionSceneController.super).OnSBattlePause)(self, protocol)
end

CamelionSceneController.OnSRoleDead = function(self, protocol)
  -- function num : 0_5 , upvalues : _ENV, CamelionSceneController
  if self._bossCount < 2 then
    self._bossCount = self._bossCount + 1
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_HpVisible, CamelionSceneController, {entityid = protocol.entityId, visible = 0})
  end
  ;
  ((CamelionSceneController.super).OnSRoleDead)(self, protocol)
end

return CamelionSceneController

