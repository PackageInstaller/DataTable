-- chunkname: @IQIGame\\UI\\Activity01InfoUI.lua

local Activity01InfoUI = Base:Extend("Activity01InfoUI", "IQIGame.Onigao.UI.Activity01InfoUI", {})

function Activity01InfoUI:OnInit()
	self:Initialize()
end

function Activity01InfoUI:GetPreloadAssetPaths()
	return nil
end

function Activity01InfoUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function Activity01InfoUI:IsManualShowOnOpen(userData)
	return false
end

function Activity01InfoUI:GetBGM(userData)
	return nil
end

function Activity01InfoUI:OnOpen(userData)
	self.eventID = userData
	self.goNameInGame.transform:GetComponent("Text").text = PlayerModule.PlayerInfo.baseInfo.pName
end

function Activity01InfoUI:OnClose(userData)
	return
end

function Activity01InfoUI:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.TurnRewardInfoResult, self.onRewardInfoResultDelegate)
	self.inputName.onValueChanged:AddListener(self.onValueChangedDelegate_name)
	self.inputPhone.onValueChanged:AddListener(self.onValueChangedDelegate_phone)
	self.inputAddress.onValueChanged:AddListener(self.onValueChangedDelegate_address)
	self.goBtnCancel:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnCancel)
	self.goBtnOK:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnOK)
end

function Activity01InfoUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.TurnRewardInfoResult, self.onRewardInfoResultDelegate)
	self.inputName.onValueChanged:RemoveListener(self.onValueChangedDelegate_name)
	self.inputPhone.onValueChanged:RemoveListener(self.onValueChangedDelegate_phone)
	self.inputAddress.onValueChanged:RemoveListener(self.onValueChangedDelegate_address)
	self.goBtnCancel:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnCancel)
	self.goBtnOK:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnOK)
end

function Activity01InfoUI:OnPause()
	return
end

function Activity01InfoUI:OnResume()
	return
end

function Activity01InfoUI:OnCover()
	return
end

function Activity01InfoUI:OnReveal()
	return
end

function Activity01InfoUI:OnRefocus(userData)
	return
end

function Activity01InfoUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function Activity01InfoUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function Activity01InfoUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function Activity01InfoUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function Activity01InfoUI:OnDestroy()
	return
end

function Activity01InfoUI:Initialize()
	local btnOK = self.goBtnOK:GetComponent("Button")

	btnOK.interactable = true

	function self.DelegateOnClickBtnCancel()
		self:OnClickBtnCancel()
	end

	function self.DelegateOnClickBtnOK()
		self:OnClickBtnOK()
	end

	function self.onRewardInfoResultDelegate()
		self:OnRewardInfoResult()
	end

	self.goBtnCancel.transform:Find("Text"):GetComponent("Text").text = ActivityUIApi:GetString("commit_cancel")
	self.goBtnOK.transform:Find("Text"):GetComponent("Text").text = ActivityUIApi:GetString("commit_ok")
	self.txtTitle.transform:GetComponent("Text").text = ActivityUIApi:GetString("commit_title")
	self.txtNameInGame.transform:GetComponent("Text").text = ActivityUIApi:GetString("commit_nameInGame")
	self.txtName1.transform:GetComponent("Text").text = ActivityUIApi:GetString("commit_name1")
	self.txtName2.transform:GetComponent("Text").text = ActivityUIApi:GetString("commit_name2")
	self.txtPhone1.transform:GetComponent("Text").text = ActivityUIApi:GetString("commit_phone1")
	self.txtPhone2.transform:GetComponent("Text").text = ActivityUIApi:GetString("commit_phone2")
	self.txtAddress1.transform:GetComponent("Text").text = ActivityUIApi:GetString("commit_address1")
	self.txtAddress2.transform:GetComponent("Text").text = ActivityUIApi:GetString("commit_address2")
	self.txtDeclare.transform:GetComponent("Text").text = ActivityUIApi:GetString("commit_declare")
	self.inputName = self.goName.transform:GetComponent("IQIGame.Onigao.Game.UI.InputField")
	self.inputPhone = self.goPhone.transform:GetComponent("IQIGame.Onigao.Game.UI.InputField")
	self.inputAddress = self.goAddress.transform:GetComponent("IQIGame.Onigao.Game.UI.InputField")

	function self.onValueChangedDelegate_name(value)
		self:OnValueChanged_name(value)
	end

	function self.onValueChangedDelegate_phone(value)
		self:OnValueChanged_phone(value)
	end

	function self.onValueChangedDelegate_address(value)
		self:OnValueChanged_address(value)
	end
end

function Activity01InfoUI:OnClickBtnOK()
	if self:CheckValid() then
		ActivityTurnModule.ReceiveRewardInfo(self.eventID, self.inputName.text, self.inputPhone.text, self.inputAddress.text)
	else
		NoticeModule.ShowNotice(21055002)
	end
end

function Activity01InfoUI:CheckValid()
	if self.inputName.text == "" then
		return false
	end

	if self.inputPhone.text == "" then
		return false
	end

	if self.inputAddress.text == "" then
		return false
	end

	return true
end

function Activity01InfoUI:CheckIsMax13Number(str)
	return string.len(str) <= 13 and tonumber(str)
end

function Activity01InfoUI:OnClickBtnCancel()
	NoticeModule.ShowNotice(21055001, function()
		UIModule.Close(Constant.UIControllerName.Activity01InfoUI)
	end)
end

function Activity01InfoUI:OnRewardInfoResult()
	NoticeModule.ShowNotice(21055003)
	UIModule.Close(Constant.UIControllerName.Activity01InfoUI)
end

function Activity01InfoUI:OnValueChanged_name(value)
	if ActivityTurnModule.getCharLength(value) <= 20 then
		self.strName = value
	else
		self.inputName.text = self.strName
	end
end

function Activity01InfoUI:OnValueChanged_phone(value)
	if ActivityTurnModule.getCharLength(value) <= 20 then
		self.strPhone = value
	else
		self.inputPhone.text = self.strPhone
	end
end

function Activity01InfoUI:OnValueChanged_address(value)
	if ActivityTurnModule.getCharLength(value) <= 300 then
		self.strAddress = value
	else
		self.inputAddress.text = self.strAddress
	end
end

return Activity01InfoUI
