local OfflineType = LuaNetManager.GetBeanDef("protocol.common.offlinetype")
local LoginCodeDialog = class("LoginCodeDialog", Dialog)
LoginCodeDialog.AssetBundleName = "ui/layouts.login"
LoginCodeDialog.AssetName = "LoginCode"

function LoginCodeDialog:Ctor(...)
  LoginCodeDialog.super.Ctor(self, ...)
  self._groupName = "Message"
end

function LoginCodeDialog:OnCreate()
  self._code = self:GetChild("InputField")
  self._confirmBtn = self:GetChild("SubmitButton")
  self._changeBtn = self:GetChild("ChangeIdBtn")
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._changeBtn:Subscribe_PointerClickEvent(self.OnChangeBtnClicked, self)
end

function LoginCodeDialog:OnDestroy()
end

function LoginCodeDialog:OnConfirmBtnClicked()
  local code = self._code:GetText()
  local cactive = LuaNetManager.CreateProtocol("protocol.common.cactive")
  if cactive then
    cactive.code = code
    cactive:Send()
  end
end

function LoginCodeDialog:OnChangeBtnClicked()
  NekoData.BehaviorManager.BM_Login:ClientLogout()
end

return LoginCodeDialog
