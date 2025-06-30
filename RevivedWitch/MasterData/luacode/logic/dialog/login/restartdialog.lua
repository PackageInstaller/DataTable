-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/login/restartdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local RestartDialog = class("RestartDialog", Dialog)
RestartDialog.AssetBundleName = "ui/layouts"
RestartDialog.AssetName = "RestartTips"
RestartDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RestartDialog
  ((RestartDialog.super).Ctor)(self, ...)
  self._groupName = "ClickEffect"
end

RestartDialog.OnCreate = function(self)
  -- function num : 0_1
  self._confirmBtn = self:GetChild("BackImage/ConfirmButton")
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
end

RestartDialog.OnDestroy = function(self)
  -- function num : 0_2
end

RestartDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  LogInfo("RestartDialog", "ApplicationQuit")
  ;
  (((CS.UnityEngine).Application).Quit)()
end

RestartDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  return DataCommon.BackPressed_NotResponse
end

return RestartDialog

