local AccelerateBuffDialog = class("AccelerateBuffDialog", Dialog)
local UIManager = CS.PixelNeko.UI.UIManager
AccelerateBuffDialog.AssetBundleName = "ui/layouts.dungeon"
AccelerateBuffDialog.AssetName = "DungeonBuff1"

function AccelerateBuffDialog:Ctor(...)
  AccelerateBuffDialog.super.Ctor(self, ...)
  self._groupName = "Operation"
end

function AccelerateBuffDialog:OnCreate()
  self._progress = self:GetChild("Progress")
  self:GetRootWindow():Subscribe_UpdateEvent(self.OnActorMove, self)
  LuaNotificationCenter.AddObserver(self, self.OnBuffProgress, Common.n_SceneBuffProgress, nil)
end

function AccelerateBuffDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function AccelerateBuffDialog:OnBuffProgress(notification)
  self:SetProgress(1 - notification.userInfo.current / notification.userInfo.total)
end

function AccelerateBuffDialog:OnActorMove()
  local x, z = NekoData.BehaviorManager.BM_Dungeon:GetActorWorldPosition()
  local screenX, screenY = UIManager.WorldToScreenPointInMargin("Main", x, 0, z)
  local viewportX, viewportY = UIManager.ScreenPointToLocalPointInRectangle(self._textParentGO, screenX, screenY)
  self:GetRootWindow():SetAnchoredPosition(viewportX, viewportY)
end

function AccelerateBuffDialog:SetProgress(progress)
  self._progress:SetFillAmount(progress)
end

return AccelerateBuffDialog
