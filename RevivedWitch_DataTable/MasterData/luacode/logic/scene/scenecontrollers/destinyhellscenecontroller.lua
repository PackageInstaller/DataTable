-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/destinyhellscenecontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NewBattleSceneController = require("logic.scene.scenecontrollers.newbattlescenecontroller")
local CameraStaticFunctions = ((CS.PixelNeko).Lua).CameraStaticFunctions
local DestinyHellSceneController = class("DestinyHellSceneController", NewBattleSceneController)
DestinyHellSceneController.Init = function(self)
  -- function num : 0_0 , upvalues : DestinyHellSceneController
  ((DestinyHellSceneController.super).Init)(self)
  self._bossCount = 1
end

DestinyHellSceneController.BSC_TimeLineStart = function(self, timelineObjectName)
  -- function num : 0_1 , upvalues : _ENV
  do
    if timelineObjectName == "Base_Fragment_05_ForBuild_Boss_PhaseChange" then
      local dialog = (DialogManager.GetDialog)("newbattle.battlenewmaindialog")
      if dialog then
        (dialog:GetRootWindow()):SetActive(false)
      end
      ;
      ((NekoData.DataManager).DM_TimeScale):SetTimelinePause()
      self._bossCount = self._bossCount + 1
      ;
      ((self._sceneRef):GetChange1BossTimeLineObject()):SetActive(true)
      ;
      ((self._sceneRef):GetChange1BossTimeLine()):Play()
    end
    ;
    (self._bsc_battleFSM):SetBoolean("toUnloadTimeline", true)
  end
end

DestinyHellSceneController.BSC_TimeLineEnd = function(self, timelineObjectName)
  -- function num : 0_2 , upvalues : _ENV
  do
    if timelineObjectName == "Base_Fragment_05_ForBuild_Boss_PhaseChange" then
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

DestinyHellSceneController.OnSRoleDead = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV, DestinyHellSceneController
  if self._bossCount < 2 then
    (LuaNotificationCenter.PostNotification)(Common.n_HpVisible, DestinyHellSceneController, {entityid = protocol.entityId, visible = 0})
  end
  ;
  ((DestinyHellSceneController.super).OnSRoleDead)(self, protocol)
end

return DestinyHellSceneController

