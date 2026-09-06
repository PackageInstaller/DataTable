local PlayableDirector = CS.UnityEngine.Playables.PlayableDirector
local TunnelVideoSkipDialog = class("TunnelVideoSkipDialog", Dialog)
TunnelVideoSkipDialog.AssetBundleName = "ui/layouts.dungeon"
TunnelVideoSkipDialog.AssetName = "DungeonMovieSkip"

function TunnelVideoSkipDialog:Ctor(...)
  TunnelVideoSkipDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._playableDirector = nil
  self._timelineID = nil
end

function TunnelVideoSkipDialog:OnCreate()
  self.skipButton = self:GetChild("SkipBtn")
  self.skipButton:Subscribe_PointerClickEvent(self.OnSkipBtnClick, self)
  LuaNotificationCenter.AddObserver(self, TunnelVideoSkipDialog.HandleBattleStart, Common.n_BattleStart, nil)
end

function TunnelVideoSkipDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function TunnelVideoSkipDialog:OnSkipBtnClick()
  if self._timelineID == "1" then
    self._playableDirector.time = 34
  else
    self._playableDirector.time = 29
  end
  self:Destroy()
end

function TunnelVideoSkipDialog:SetData(id)
  self._timelineID = id
  if id == "1" then
    local sceneController = SceneManager.GetSceneControllerByID(10011)
    self._playableDirector = sceneController._sceneRef.timelineObjects[1118]
  else
    local sceneController = SceneManager.GetSceneControllerByID(10011)
    self._playableDirector = sceneController._sceneRef.timelineObjects[1019]
  end
end

function TunnelVideoSkipDialog:HandleBattleStart()
  self:Destroy()
end

function TunnelVideoSkipDialog:OnBackBtnClicked()
  self:OnSkipBtnClick()
end

return TunnelVideoSkipDialog
