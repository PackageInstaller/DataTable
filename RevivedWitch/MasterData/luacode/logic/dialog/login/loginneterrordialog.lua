-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/login/loginneterrordialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LoginNetErrorDialog = class("LoginNetErrorDialog", Dialog)
LoginNetErrorDialog.AssetBundleName = "ui/layouts.login"
LoginNetErrorDialog.AssetName = "LoginNetError"
LoginNetErrorDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : LoginNetErrorDialog
  ((LoginNetErrorDialog.super).Ctor)(self, ...)
  self._groupName = "BrokenLine"
end

LoginNetErrorDialog.OnCreate = function(self)
  -- function num : 0_1
  self._confirmBtn = self:GetChild("CommonButtonBlue")
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
end

LoginNetErrorDialog.OnDestroy = function(self)
  -- function num : 0_2
end

LoginNetErrorDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_3
  self:Destroy()
end

return LoginNetErrorDialog

