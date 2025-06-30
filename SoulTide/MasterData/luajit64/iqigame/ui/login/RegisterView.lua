-- chunkname: @IQIGame\\UI\\Login\\RegisterView.lua

local RegisterView = {}

function RegisterView.__New(ui, onClose)
	local o = Clone(RegisterView)

	o:InitView(ui, onClose)

	return o
end

function RegisterView:InitView(ui, onClose)
	self.rootUI = ui
	self.OnCloseCallback = onClose

	self.rootUI:SetActive(false)
	LuaCodeInterface.BindOutlet(self.rootUI, self)
	UGUIUtil.SetText(self.IDTextTitle, LoginUIApi:GetString("IDTextTitle"))
	UGUIUtil.SetText(self.PassWord1Title, LoginUIApi:GetString("PassWord1Title"))
	UGUIUtil.SetText(self.PassWord2Title, LoginUIApi:GetString("PassWord2Title"))
	UGUIUtil.SetText(self.ActivationCodeTitle, LoginUIApi:GetString("ActivationCodeTitle"))
	UGUIUtil.SetText(self.BtnTextBack, LoginUIApi:GetString("BtnTextBack"))
	UGUIUtil.SetText(self.BtnTextRegister, LoginUIApi:GetString("BtnTextRegister"))
	UGUIUtil.SetText(self.PlaceholderID, LoginUIApi:GetString("PlaceholderID"))
	UGUIUtil.SetText(self.PlaceholderPass1, LoginUIApi:GetString("PlaceholderPass1"))
	UGUIUtil.SetText(self.PlaceholderPass2, LoginUIApi:GetString("PlaceholderPass2"))
	UGUIUtil.SetText(self.PlaceholderCode, LoginUIApi:GetString("PlaceholderCode"))
	UGUIUtil.SetText(self.TextBtnNotice, LoginUIApi:GetString("TextBtnNotice"))
	UGUIUtil.SetText(self.IDTextError, "")
	UGUIUtil.SetText(self.PassWord1Error, "")
	UGUIUtil.SetText(self.PassWord2Error, "")
	UGUIUtil.SetText(self.ActivationCodeError, "")

	self.btnBackComponent = self.BtnBack:GetComponent("Button")
	self.btnRegisterComponent = self.BtnRegister:GetComponent("Button")
	self.inputIDComponent = self.IDText:GetComponent("IQIGame.Onigao.Game.UI.InputField")
	self.inputPassWorld1Component = self.PassWord1:GetComponent("IQIGame.Onigao.Game.UI.InputField")
	self.inputPassWorld2Component = self.PassWord2:GetComponent("IQIGame.Onigao.Game.UI.InputField")
	self.inputActivationCodeComponent = self.ActivationCode:GetComponent("IQIGame.Onigao.Game.UI.InputField")

	function self.delegateBtnBack()
		self:OnClickBtnBack()
	end

	function self.delegateBtnRegister()
		self:OnClickBtnRegister()
	end

	function self.delegateRegisterFailed(code, str)
		self:OnRegisterFailed(code, str)
	end

	function self.DelegateOnIdInputChanged(text)
		self:OnIdInputChanged(text)
	end
end

function RegisterView:AddEventListener()
	self.btnBackComponent.onClick:AddListener(self.delegateBtnBack)
	self.btnRegisterComponent.onClick:AddListener(self.delegateBtnRegister)
	self.inputIDComponent.onValueChanged:AddListener(self.DelegateOnIdInputChanged)
	EventDispatcher.AddEventListener(EventID.RegisterFailed, self.delegateRegisterFailed)
end

function RegisterView:RemoveEventListener()
	self.btnBackComponent.onClick:RemoveListener(self.delegateBtnBack)
	self.btnRegisterComponent.onClick:RemoveListener(self.delegateBtnRegister)
	self.inputIDComponent.onValueChanged:RemoveListener(self.DelegateOnIdInputChanged)
	EventDispatcher.RemoveEventListener(EventID.RegisterFailed, self.delegateRegisterFailed)
end

function RegisterView:OnUpdate()
	if self.inputIDComponent.isFocused == true then
		UGUIUtil.SetText(self.IDTextError, "")
	end

	if self.inputPassWorld1Component.isFocused == true then
		UGUIUtil.SetText(self.PassWord1Error, "")
	end

	if self.inputPassWorld2Component.isFocused == true then
		UGUIUtil.SetText(self.PassWord2Error, "")
	end

	if self.inputActivationCodeComponent.isFocused == true then
		UGUIUtil.SetText(self.ActivationCodeError, "")
	end
end

function RegisterView:OnClickBtnBack()
	self:Hide()

	if self.OnCloseCallback ~= nil then
		self.OnCloseCallback()
	end
end

function RegisterView:OnClickBtnRegister()
	local isPass = true
	local inputIDStr = tostring(self.inputIDComponent.text)

	if #inputIDStr < 6 then
		UGUIUtil.SetText(self.IDTextError, LoginUIApi:GetString("IDTextError"))

		isPass = false
	else
		UGUIUtil.SetText(self.IDTextError, "")
	end

	local inputPass1Str = tostring(self.inputPassWorld1Component.text)

	if #inputPass1Str < 6 then
		UGUIUtil.SetText(self.PassWord1Error, LoginUIApi:GetString("PassWord1Error"))

		isPass = false
	else
		UGUIUtil.SetText(self.PassWord1Error, "")
	end

	local inputPass2Str = tostring(self.inputPassWorld2Component.text)

	if #inputPass2Str < 6 then
		UGUIUtil.SetText(self.PassWord2Error, LoginUIApi:GetString("PassWord1Error"))

		isPass = false
	else
		UGUIUtil.SetText(self.PassWord2Error, "")
	end

	if inputPass1Str ~= inputPass2Str then
		UGUIUtil.SetText(self.PassWord1Error, LoginUIApi:GetString("PassWord2Error"))
		UGUIUtil.SetText(self.PassWord2Error, LoginUIApi:GetString("PassWord2Error"))

		isPass = false
	end

	local codeStr = tostring(self.inputActivationCodeComponent.text)

	if CfgDiscreteDataTable[6507099].Data[1] ~= 0 then
		if #codeStr ~= 13 then
			UGUIUtil.SetText(self.ActivationCodeError, LoginUIApi:GetString("ActivationCodeError"))

			isPass = false
		else
			UGUIUtil.SetText(self.ActivationCodeError, "")
		end
	end

	if isPass == true then
		LoginModule.Register(inputIDStr, inputPass1Str, codeStr)
	end
end

function RegisterView:OnRegisterFailed(code, str)
	if code == 110010 or code == 110011 then
		UGUIUtil.SetText(self.ActivationCodeError, str)
	else
		UGUIUtil.SetText(self.IDTextError, str)
	end
end

function RegisterView:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
end

function RegisterView:Show()
	self.rootUI:SetActive(true)
	self:AddEventListener()
end

function RegisterView:Hide()
	self.rootUI:SetActive(false)
	self:RemoveEventListener()
end

function RegisterView:OnIdInputChanged(text)
	self.inputIDComponent.text = string.lower(text)
end

return RegisterView
