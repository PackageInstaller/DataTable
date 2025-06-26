-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/autoreturnconfirmdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AutoReturnConfirmDialog = class("AutoReturnConfirmDialog", Dialog)
AutoReturnConfirmDialog.AssetBundleName = "ui/layouts.secondconfirm"
AutoReturnConfirmDialog.AssetName = "AutoReturnConfirm"
AutoReturnConfirmDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AutoReturnConfirmDialog
  ((AutoReturnConfirmDialog.super).Ctor)(self, ...)
  self._groupName = "BrokenLine"
end

AutoReturnConfirmDialog.OnCreate = function(self)
  -- function num : 0_1
  self._confirmButton = self:GetChild("ConfirmButton")
  self._cancelButton = self:GetChild("CancelButton")
  ;
  (self._confirmButton):Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
  ;
  (self._cancelButton):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

AutoReturnConfirmDialog.OnDestroy = function(self)
  -- function num : 0_2
end

AutoReturnConfirmDialog.SetCallBack = function(self, callBackFunc)
  -- function num : 0_3
  self._callBackFunc = callBackFunc
end

AutoReturnConfirmDialog.OnClickConfirmBtn = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self._callBackFunc then
    (self._callBackFunc)()
  end
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.autoreturnconfirmdialog")
end

AutoReturnConfirmDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("dungeon.autoreturnconfirmdialog")
end

return AutoReturnConfirmDialog

