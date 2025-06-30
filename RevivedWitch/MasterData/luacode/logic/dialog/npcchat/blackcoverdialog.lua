-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/npcchat/blackcoverdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BlackCoverDialog = class("BlackCoverDialog", Dialog)
BlackCoverDialog.AssetBundleName = "ui/layouts.dramadialog"
BlackCoverDialog.AssetName = "TimeLineTransit"
BlackCoverDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BlackCoverDialog
  ((BlackCoverDialog.super).Ctor)(self, ...)
end

BlackCoverDialog.OnCreate = function(self)
  -- function num : 0_1
  (self:GetRootWindow()):Subscribe_StateEnterEvent(self.OnAnimatorStateEnter, self)
end

BlackCoverDialog.SetData = function(self, value)
  -- function num : 0_2 , upvalues : _ENV
  (self:GetRootWindow()):SetAnimatorInteger("curtainStyle", tonumber(value))
end

BlackCoverDialog.OnAnimatorStateEnter = function(self, handle, stateName, normalizedTime)
  -- function num : 0_3
  self:Destroy()
end

return BlackCoverDialog

