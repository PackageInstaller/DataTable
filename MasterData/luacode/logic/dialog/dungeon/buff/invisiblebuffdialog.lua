local InvisibleBuffDialog = class("InvisibleBuffDialog", Dialog)
local UIManager = CS.PixelNeko.UI.UIManager
InvisibleBuffDialog.AssetBundleName = "ui/layouts.dungeon"
InvisibleBuffDialog.AssetName = "DungeonBuff2"

function InvisibleBuffDialog:Ctor(...)
  InvisibleBuffDialog.super.Ctor(self, ...)
  self._groupName = "Operation"
end

function InvisibleBuffDialog:OnCreate()
  self._progress = self:GetChild("Progress")
  self:GetRootWindow():Subscribe_UpdateEvent(self.OnActorMove, self)
  LuaNotificationCenter.AddObserver(self, self.OnBuffProgress, Common.n_SceneBuffProgress, nil)
end

function InvisibleBuffDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function InvisibleBuffDialog:OnBuffProgress(notification)
  self:SetProgress(1 - notification.userInfo.current / notification.userInfo.total)
end

function InvisibleBuffDialog:OnActorMove()
  local x, z = NekoData.BehaviorManager.BM_Dungeon:GetActorWorldPosition()
  local screenX, screenY = UIManager.WorldToScreenPointInMargin("Main", x, 0, z)
  local viewportX, viewportY = UIManager.ScreenPointToLocalPointInRectangle(self._textParentGO, screenX, screenY)
  self:GetRootWindow():SetAnchoredPosition(viewportX, viewportY)
end

function InvisibleBuffDialog:SetProgress(progress)
  self._progress:SetFillAmount(progress)
end

return InvisibleBuffDialog
