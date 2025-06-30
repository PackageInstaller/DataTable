-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/fragment/fragmenttipsdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local FragmentTipsDialog = class("FragmentTipsDialog", Dialog)
FragmentTipsDialog.AssetBundleName = "ui/layouts.fragment"
FragmentTipsDialog.AssetName = "FragmentTip"
FragmentTipsDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FragmentTipsDialog
  ((FragmentTipsDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

FragmentTipsDialog.OnCreate = function(self)
  -- function num : 0_1
  self._closeBtn = self:GetChild("Back/CloseBtn")
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

FragmentTipsDialog.OnDestroy = function(self)
  -- function num : 0_2
end

FragmentTipsDialog.OnBackBtnClicked = function(self)
  -- function num : 0_3
  self:Destroy()
end

return FragmentTipsDialog

