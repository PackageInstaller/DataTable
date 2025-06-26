-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/login/loginwaitdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LoginWaitDialog = class("LoginWaitDialog", Dialog)
LoginWaitDialog.AssetBundleName = "ui/layouts.loading"
LoginWaitDialog.AssetName = "WaitResponse"
LoginWaitDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : LoginWaitDialog
  ((LoginWaitDialog.super).Ctor)(self, ...)
  self._groupName = "Loading"
end

LoginWaitDialog.OnCreate = function(self)
  -- function num : 0_1
end

LoginWaitDialog.OnDestroy = function(self)
  -- function num : 0_2
end

LoginWaitDialog.OnBackBtnClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  return DataCommon.BackPressed_NotResponse
end

return LoginWaitDialog

