local NewBattleSceneController = require("logic.scene.scenecontrollers.newbattlescenecontroller")
local CameraStaticFunctions = CS.PixelNeko.Lua.CameraStaticFunctions
local DestinyHellSceneController = class("DestinyHellSceneController", NewBattleSceneController)

function DestinyHellSceneController:Init()
  DestinyHellSceneController.super.Init(self)
  self._bossCount = 1
end

function DestinyHellSceneController:BSC_TimeLineStart(timelineObjectName)
  if timelineObjectName == "Base_Fragment_05_ForBuild_Boss_PhaseChange" then
    local dialog = DialogManager.GetDialog("newbattle.battlenewmaindialog")
    if dialog then
      dialog:GetRootWindow():SetActive(false)
    end
    NekoData.DataManager.DM_TimeScale:SetTimelinePause()
    self._bossCount = self._bossCount + 1
    self._sceneRef:GetChange1BossTimeLineObject():SetActive(true)
    self._sceneRef:GetChange1BossTimeLine():Play()
  end
  self._bsc_battleFSM:SetBoolean("toUnloadTimeline", true)
end

function DestinyHellSceneController:BSC_TimeLineEnd(timelineObjectName)
  if timelineObjectName == "Base_Fragment_05_ForBuild_Boss_PhaseChange" then
    local dialog = DialogManager.GetDialog("newbattle.battlenewmaindialog")
    if dialog then
      dialog:GetRootWindow():SetActive(true)
    end
    NekoData.DataManager.DM_TimeScale:CancelTimelinePause()
    self:BSC_UpdateAllLocalProtocol()
  end
  self:SetBattleTimelineTag(false)
end

function DestinyHellSceneController:OnSRoleDead(protocol)
  if self._bossCount < 2 then
    LuaNotificationCenter.PostNotification(Common.n_HpVisible, DestinyHellSceneController, {
      entityid = protocol.entityId,
      visible = 0
    })
  end
  DestinyHellSceneController.super.OnSRoleDead(self, protocol)
end

return DestinyHellSceneController
