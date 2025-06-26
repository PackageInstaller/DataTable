-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/confirmbox/errorconfirmdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ErrorConfirmDialog = class("ErrorConfirmDialog", Dialog)
ErrorConfirmDialog.AssetBundleName = "ui/layouts.secondconfirm"
ErrorConfirmDialog.AssetName = "SingleConfirm"
ErrorConfirmDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ErrorConfirmDialog
  ((ErrorConfirmDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

ErrorConfirmDialog.OnCreate = function(self)
  -- function num : 0_1
  self._btn = self:GetChild("ConfirmButton")
  ;
  (self._btn):Subscribe_PointerClickEvent(self.OnClick, self)
end

ErrorConfirmDialog.OnClick = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("confirmbox.errorconfirmdialog")
end

ErrorConfirmDialog.AddNewModal = function(self)
  -- function num : 0_3
end

return ErrorConfirmDialog

