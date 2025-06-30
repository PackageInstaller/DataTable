-- chunkname: @IQIGame\\UI\\Login\\AccountTransfer\\AccountTransferRegisterView.lua

local m = {
	SendTime = 0,
	SendCD = 60,
	IsEditConfirm = false
}
local AccountTransferProtoInfoView = require("IQIGame.UI.Login.AccountTransfer.AccountTransferProtoInfoView")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnClose()
		self:OnBtnClose()
	end

	function self.DelegateBtnSend()
		self:OnBtnSend()
	end

	function self.DelegateBtnRegister()
		self:OnBtnRegister()
	end

	function self.DelegateBtnUserAgreement()
		self:OnBtnUserAgreement()
	end

	function self.DelegateBtnProtectionPolicy()
		self:OnBtnProtectionPolicy()
	end

	self.AccountInputCom = self.AccountInput:GetComponent("IQIGame.Onigao.Game.UI.InputField")
	self.ProtoInfoView = AccountTransferProtoInfoView.New(self.ProtoInfoNode)

	self:AddListener()
	self.View:SetActive(false)
	self.AccountError:SetActive(false)
end

function m:AddListener()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
	self.BtnSend:GetComponent("Button").onClick:AddListener(self.DelegateBtnSend)
	self.BtnRegister:GetComponent("Button").onClick:AddListener(self.DelegateBtnRegister)
	self.BtnUserAgreement:GetComponent("Button").onClick:AddListener(self.DelegateBtnUserAgreement)
	self.BtnProtectionPolicy:GetComponent("Button").onClick:AddListener(self.DelegateBtnProtectionPolicy)
end

function m:RemoveListener()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
	self.BtnSend:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnSend)
	self.BtnRegister:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnRegister)
	self.BtnUserAgreement:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnUserAgreement)
	self.BtnProtectionPolicy:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnProtectionPolicy)
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	local now = PlayerModule.GetServerTime()

	if now - self.SendTime > 1 then
		self:ShowSendCD()

		self.SendTime = now
	end

	if self.AccountInputCom.isFocused ~= self.IsEditConfirm then
		self.IsEditConfirm = self.AccountInputCom.isFocused

		if self.IsEditConfirm == true then
			self.AccountError:SetActive(false)
		end
	end
end

function m:UpdateView()
	self:ShowSendCD()
end

function m:ShowSendCD()
	local cd = math.floor(self.SendCD - (PlayerModule.GetServerTime() - LoginModule.LastSendMessageTimer))

	self.TextSendCD:SetActive(cd > 0)
	self.BtnSend:SetActive(cd < 0)

	if cd > 0 then
		UGUIUtil.SetText(self.TextSendCD, AccountTransferUIApi:GetString("TextSendCD", cd))
	end
end

function m:OnBtnClose()
	self:Close()
end

function m:OnBtnSend()
	local str = self.AccountInput:GetComponent("IQIGame.Onigao.Game.UI.InputField").text

	if str == "" then
		self.AccountError:SetActive(true)

		return
	end

	self.AccountError:SetActive(false)

	local phone = tonumber(str)

	LoginModule.Send(phone)
end

function m:OnBtnRegister()
	local phoneStr = self.AccountInput:GetComponent("IQIGame.Onigao.Game.UI.InputField").text

	if phoneStr == "" then
		self.AccountError:SetActive(true)

		return
	end

	self.AccountError:SetActive(false)

	local codeStr = self.MessageInput:GetComponent("IQIGame.Onigao.Game.UI.InputField").text

	if codeStr == "" then
		log("验证码不能为空")

		return
	end

	if not self.AgreementToggle:GetComponent("Toggle").isOn then
		log("阅读并同意协议文件")

		return
	end

	LoginModule.Verify(tonumber(phoneStr), codeStr)
end

function m:OnBtnUserAgreement()
	local UserProtocolUrl = AccountTransferUIApi:GetString("UserProtocolUrl")
	local UserProtocolTitle = AccountTransferUIApi:GetString("UserProtocolTitle")

	self.ProtoInfoView:Open(UserProtocolUrl, UserProtocolTitle)
end

function m:OnBtnProtectionPolicy()
	local PrivacyPolicyUrl = AccountTransferUIApi:GetString("PrivacyPolicyUrl")
	local PrivacyPolicyTitle = AccountTransferUIApi:GetString("PrivacyPolicyTitle")

	self.ProtoInfoView:Open(PrivacyPolicyUrl, PrivacyPolicyTitle)
end

function m:Open()
	self.View:SetActive(true)
	self:UpdateView()
	self.ProtoInfoView:Close()
end

function m:Close()
	self.View:SetActive(false)
	self.ProtoInfoView:Close()
end

function m:Dispose()
	self:RemoveListener()
	self.ProtoInfoView:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
