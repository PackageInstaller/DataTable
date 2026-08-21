-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/login/responsewaitdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ResponseWaitDialog = class("ResponseWaitDialog", Dialog)
ResponseWaitDialog.AssetBundleName = "ui/layouts.loading"
ResponseWaitDialog.AssetName = "WaitResponse"
ResponseWaitDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ResponseWaitDialog
  ((ResponseWaitDialog.super).Ctor)(self, ...)
  self._groupName = "Loading"
end

ResponseWaitDialog.OnCreate = function(self)
  -- function num : 0_1
end

ResponseWaitDialog.OnDestroy = function(self)
  -- function num : 0_2
end

return ResponseWaitDialog

