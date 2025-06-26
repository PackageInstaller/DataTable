-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/breakanimationdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BreakAnimationDialog = class("BreakAnimationDialog", Dialog)
BreakAnimationDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
BreakAnimationDialog.AssetName = "BaseCharacterInfoBreakAni"
BreakAnimationDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BreakAnimationDialog
  ((BreakAnimationDialog.super).Ctor)(self, ...)
end

BreakAnimationDialog.OnCreate = function(self)
  -- function num : 0_1
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
end

BreakAnimationDialog.OnAnimationStateExit = function(self)
  -- function num : 0_2
  self:Destroy()
end

return BreakAnimationDialog

