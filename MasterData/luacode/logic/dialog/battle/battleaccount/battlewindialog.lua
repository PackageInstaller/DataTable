local BattleWinDialog = class("BattleWinDialog", Dialog)
BattleWinDialog.AssetBundleName = "ui/layouts.battlewin"
BattleWinDialog.AssetName = "BattleWin"

function BattleWinDialog:Ctor(...)
  BattleWinDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function BattleWinDialog:OnCreate()
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnBattleWinOver, self)
end

function BattleWinDialog:OnDestroy()
end

function BattleWinDialog:Show(show)
  if show then
    self:GetRootWindow():PlayAnimation("BattleWin")
  end
end

function BattleWinDialog:OnBattleWinOver(arg1, arg2)
  if arg2 == "battlewin" then
    self:Destroy()
  end
end

return BattleWinDialog
