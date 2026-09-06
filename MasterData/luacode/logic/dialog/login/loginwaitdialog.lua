local LoginWaitDialog = class("LoginWaitDialog", Dialog)
LoginWaitDialog.AssetBundleName = "ui/layouts.loading"
LoginWaitDialog.AssetName = "WaitResponse"

function LoginWaitDialog:Ctor(...)
  LoginWaitDialog.super.Ctor(self, ...)
  self._groupName = "Loading"
end

function LoginWaitDialog:OnCreate()
end

function LoginWaitDialog:OnDestroy()
end

function LoginWaitDialog:OnBackBtnClicked()
  return DataCommon.BackPressed_NotResponse
end

return LoginWaitDialog
