local AutoReturnConfirmDialog = class("AutoReturnConfirmDialog", Dialog)
AutoReturnConfirmDialog.AssetBundleName = "ui/layouts.secondconfirm"
AutoReturnConfirmDialog.AssetName = "AutoReturnConfirm"

function AutoReturnConfirmDialog:Ctor(...)
  AutoReturnConfirmDialog.super.Ctor(self, ...)
  self._groupName = "BrokenLine"
end

function AutoReturnConfirmDialog:OnCreate()
  self._confirmButton = self:GetChild("ConfirmButton")
  self._cancelButton = self:GetChild("CancelButton")
  self._confirmButton:Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
  self._cancelButton:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function AutoReturnConfirmDialog:OnDestroy()
end

function AutoReturnConfirmDialog:SetCallBack(callBackFunc)
  self._callBackFunc = callBackFunc
end

function AutoReturnConfirmDialog:OnClickConfirmBtn()
  if self._callBackFunc then
    self._callBackFunc()
  end
  DialogManager.DestroySingletonDialog("dungeon.autoreturnconfirmdialog")
end

function AutoReturnConfirmDialog:OnBackBtnClicked()
  DialogManager.DestroySingletonDialog("dungeon.autoreturnconfirmdialog")
end

return AutoReturnConfirmDialog
