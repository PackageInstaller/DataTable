local ErrorConfirmDialog = class("ErrorConfirmDialog", Dialog)
ErrorConfirmDialog.AssetBundleName = "ui/layouts.secondconfirm"
ErrorConfirmDialog.AssetName = "SingleConfirm"

function ErrorConfirmDialog:Ctor(...)
  ErrorConfirmDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function ErrorConfirmDialog:OnCreate()
  self._btn = self:GetChild("ConfirmButton")
  self._btn:Subscribe_PointerClickEvent(self.OnClick, self)
end

function ErrorConfirmDialog:OnClick()
  DialogManager.DestroySingletonDialog("confirmbox.errorconfirmdialog")
end

function ErrorConfirmDialog:AddNewModal()
end

return ErrorConfirmDialog
