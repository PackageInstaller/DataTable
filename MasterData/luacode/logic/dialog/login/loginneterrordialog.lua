local LoginNetErrorDialog = class("LoginNetErrorDialog", Dialog)
LoginNetErrorDialog.AssetBundleName = "ui/layouts.login"
LoginNetErrorDialog.AssetName = "LoginNetError"

function LoginNetErrorDialog:Ctor(...)
  LoginNetErrorDialog.super.Ctor(self, ...)
  self._groupName = "BrokenLine"
end

function LoginNetErrorDialog:OnCreate()
  self._confirmBtn = self:GetChild("CommonButtonBlue")
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
end

function LoginNetErrorDialog:OnDestroy()
end

function LoginNetErrorDialog:OnConfirmBtnClicked()
  self:Destroy()
end

return LoginNetErrorDialog
