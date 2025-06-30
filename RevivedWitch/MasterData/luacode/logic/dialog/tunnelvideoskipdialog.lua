-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/tunnelvideoskipdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local PlayableDirector = ((CS.UnityEngine).Playables).PlayableDirector
local TunnelVideoSkipDialog = class("TunnelVideoSkipDialog", Dialog)
TunnelVideoSkipDialog.AssetBundleName = "ui/layouts.dungeon"
TunnelVideoSkipDialog.AssetName = "DungeonMovieSkip"
TunnelVideoSkipDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TunnelVideoSkipDialog
  ((TunnelVideoSkipDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._playableDirector = nil
  self._timelineID = nil
end

TunnelVideoSkipDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, TunnelVideoSkipDialog
  self.skipButton = self:GetChild("SkipBtn")
  ;
  (self.skipButton):Subscribe_PointerClickEvent(self.OnSkipBtnClick, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, TunnelVideoSkipDialog.HandleBattleStart, Common.n_BattleStart, nil)
end

TunnelVideoSkipDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

TunnelVideoSkipDialog.OnSkipBtnClick = function(self)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  if self._timelineID == "1" then
    (self._playableDirector).time = 34
  else
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._playableDirector).time = 29
  end
  self:Destroy()
end

TunnelVideoSkipDialog.SetData = function(self, id)
  -- function num : 0_4 , upvalues : _ENV
  self._timelineID = id
  if id == "1" then
    local sceneController = (SceneManager.GetSceneControllerByID)(10011)
    self._playableDirector = ((sceneController._sceneRef).timelineObjects)[1118]
  else
    do
      local sceneController = (SceneManager.GetSceneControllerByID)(10011)
      self._playableDirector = ((sceneController._sceneRef).timelineObjects)[1019]
    end
  end
end

TunnelVideoSkipDialog.HandleBattleStart = function(self)
  -- function num : 0_5
  self:Destroy()
end

TunnelVideoSkipDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6
  self:OnSkipBtnClick()
end

return TunnelVideoSkipDialog

