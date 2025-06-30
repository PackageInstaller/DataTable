-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/battleaccount/battlewindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BattleWinDialog = class("BattleWinDialog", Dialog)
BattleWinDialog.AssetBundleName = "ui/layouts.battlewin"
BattleWinDialog.AssetName = "BattleWin"
BattleWinDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattleWinDialog
  ((BattleWinDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

BattleWinDialog.OnCreate = function(self)
  -- function num : 0_1
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnBattleWinOver, self)
end

BattleWinDialog.OnDestroy = function(self)
  -- function num : 0_2
end

BattleWinDialog.Show = function(self, show)
  -- function num : 0_3
  if show then
    (self:GetRootWindow()):PlayAnimation("BattleWin")
  end
end

BattleWinDialog.OnBattleWinOver = function(self, arg1, arg2)
  -- function num : 0_4
  if arg2 == "battlewin" then
    self:Destroy()
  end
end

return BattleWinDialog

