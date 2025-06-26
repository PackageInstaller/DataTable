-- chunkname: @IQIGame\\UI\\SettingUI.lua

local OtherSettingClickView = require("IQIGame.UI.Setting.OtherSettingClickView")
local SettingMusicView = require("IQIGame.UI.Setting.SettingMusicView")
local SettingPerformanceView = require("IQIGame.UI.Setting.SettingPerformanceView")
local SettingExchangeView = require("IQIGame.UI.Setting.SettingExchangeView")
local UserProtocolWindow = require("IQIGame.UI.Login.UserProtocolWindow")
local GraphicSettingView = require("IQIGame.UI.Setting.GraphicSettingView")
local SettingUI = Base:Extend("SettingUI", "IQIGame.Onigao.UI.SettingUI", {
	ToggleType = {
		otherSetting = 4,
		music = 1,
		performance = 2,
		conversion = 3
	}
})

function SettingUI:OnInit()
	self:OnDelegation()
	LuaCodeInterface.BindOutlet(self.TapContent, self)
	LuaCodeInterface.BindOutlet(self.OtherLuaOutlet, self)

	self.SetTapContent = TapContent:New()

	self.SetTapContent:Init(self.TapContent.gameObject, self.OnToggleSetChangedDelegate)

	self.GraphicSettingView = GraphicSettingView.New(self.GraphicSettingView.gameObject, self)
	self.OtherSettingClickView = OtherSettingClickView.New(self.OtherSetting.gameObject, self)
	self.SettingMusicView = SettingMusicView.New(self.SoundInterfaceParent.gameObject, self)
	self.SettingPerformanceView = SettingPerformanceView.New(self.PerformanceParent.gameObject, self)
	self.SettingExchangeView = SettingExchangeView.New(self.ExchangeParent.gameObject, self)
	self.UserProtocolWindow = UserProtocolWindow.New(self.UserAgreePanel)

	self.UserProtocolWindow:Hide()

	self.AgreementBtn = self.AgreementBtn:GetComponent("Button")
	self.CancelBtn = self.CancelBtn:GetComponent("Button")
	self.GraphicSettingButton = self.GraphicSettingButton:GetComponent("Button")
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)

	self.UserCenterBtn:SetActive(SDKLoginModule.IsSDKMode() and SDKLoginModule.GetIsOfficialChannel())
	self:Initialize()
end

function SettingUI:Initialize()
	UGUIUtil.SetText(self.tap_destag1_1, SettingUIApi:GetTextTitle_1())
	UGUIUtil.SetText(self.tap_destag1_2, SettingUIApi:GetTextTitle_1())
	UGUIUtil.SetText(self.tap_destag2_1, SettingUIApi:GetTextTitle_2())
	UGUIUtil.SetText(self.tap_destag2_2, SettingUIApi:GetTextTitle_2())
	UGUIUtil.SetText(self.tap_destag3_1, SettingUIApi:GetTextTitle_3())
	UGUIUtil.SetText(self.tap_destag3_2, SettingUIApi:GetTextTitle_3())
	UGUIUtil.SetText(self.PerformanceDes1, SettingUIApi:GetTextTitle_5())
	UGUIUtil.SetText(self.PerformanceDes9, SettingUIApi:GetTextTitle_6())
	UGUIUtil.SetText(self.PerformanceDes5, SettingUIApi:GetTextTitle_7())
	UGUIUtil.SetText(self.PerformanceDes6, SettingUIApi:GetTextTitle_8())
	UGUIUtil.SetText(self.PerformanceDes10, SettingUIApi:GetTextTitle_9())
	UGUIUtil.SetText(self.PerformanceDes7, SettingUIApi:GetTextTitle_10())
	UGUIUtil.SetText(self.PerformanceDes11, SettingUIApi:GetTextTitle_11())
	UGUIUtil.SetText(self.AnimatorDes1, SettingUIApi:GetTextTitle_12())
	UGUIUtil.SetText(self.AnimatorDes2, SettingUIApi:GetTextTitle_13())
	UGUIUtil.SetText(self.AnimatorDes3, SettingUIApi:GetTextTitle_14())
	UGUIUtil.SetText(self.Uesrinfo1, LoginUIApi:GetUserProtocolBtnText())
	UGUIUtil.SetText(self.ExchangeDes1, SettingUIApi:GetTextTitle())
	UGUIUtil.SetText(self.ExchangeDes2, SettingUIApi:GetTextTitle_3())
	UGUIUtil.SetTextInChildren(self.AgreementBtn.gameObject, LoginUIApi:GetUserProtocolTitleText())
	UGUIUtil.SetTextInChildren(self.PrivacyBtn.gameObject, LoginUIApi:GetPrivacyPolicyTitleText())
end

function SettingUI:OnDelegation()
	function self.OnClick_CloseBtn()
		self:OnClickCloseBtn()
	end

	function self.OnClick_UserAgreementBtn()
		self:OnClickUserAgreementBtn()
	end

	function self.OnClick_ClickPrivacyBtn()
		self:OnClickPrivacyBtn()
	end

	function self.OnClick_CanelAccountBtn()
		self:OnClickCanelAccountBtn()
	end

	function self.OnToggleSetChangedDelegate(go, isOn)
		self:OnTogglePartChanged(go, isOn)
	end

	function self.delegateOnClickGraphicSetting()
		self.GraphicSettingView:Open()
	end

	function self.DelegateOnClickPushToggle(isOn)
		self:OnClickPushToggle(isOn)
	end

	function self.UnlockFunctionUpdateEvent()
		self:UnlockFunctionUpdate()
	end

	function self.DelegateOnClickUserCenterBtn()
		self:OnClickUserCenterBtn()
	end

	function self.DelegateOnClickFeedbackBtn()
		self:OnClickFeedbackBtn()
	end

	function self.delegateOnClickCustomerBtn()
		self:OnClickCustomerBtn()
	end
end

function SettingUI:OnTogglePartChanged(go_name)
	log("go_name  " .. go_name)

	if go_name == "tag1" then
		self.CurChooseType = self.ToggleType.music
	elseif go_name == "tag2" then
		self.CurChooseType = self.ToggleType.performance
	elseif go_name == "tag3" then
		self.CurChooseType = self.ToggleType.conversion
	elseif go_name == "tag4" then
		self.CurChooseType = self.ToggleType.otherSetting
	end

	self:OnTogglePartChangedExtend()
end

function SettingUI:OnTogglePartChangedExtend()
	self.SoundInterfaceParent:SetActive(self.CurChooseType == self.ToggleType.music)
	self.PerformanceParent:SetActive(self.CurChooseType == self.ToggleType.performance)
	self.ExchangeParent:SetActive(self.CurChooseType == self.ToggleType.conversion)
	self.OtherSetting:SetActive(self.CurChooseType == self.ToggleType.otherSetting)
end

function SettingUI:OnClickUserAgreementBtn()
	self.UserProtocolWindow:Show(LoginUIApi:GetUserProtocolUrl(), 1)
end

function SettingUI:OnClickPrivacyBtn()
	self.UserProtocolWindow:Show(LoginUIApi:GetPrivacyPolicyUrl(), 2)
end

function SettingUI:OnClickCanelAccountBtn()
	local tips = CfgTipsTable[1600001].Text

	NoticeModule.ShowNoticeByType(5, tips, function()
		LoginModule.Logout(SceneTransferModule.ReturnLogin)
	end, function()
		log("Cancel Exit Account.")
	end)
end

function SettingUI:OnClickPushToggle(isOn)
	return
end

function SettingUI:OnClickUserCenterBtn()
	SDKLoginModule.OpenUserCenter()
end

function SettingUI:OnClickFeedbackBtn()
	return
end

function SettingUI:OnClickCustomerBtn()
	return
end

function SettingUI:OnDestroy()
	self.GraphicSettingView:OnDestroy()
	self.OtherSettingClickView:OnDestroy()
	self.UserProtocolWindow:Dispose()
	self.SettingMusicView:OnDestroy()
	self.SettingPerformanceView:OnDestroy()
	self.SettingExchangeView:OnDestroy()
	self.commonReturnBtn:Dispose()
	LuaCodeInterface.ClearOutlet(self.TapContent, self)
	LuaCodeInterface.ClearOutlet(self.OtherLuaOutlet, self)
end

function SettingUI:UnlockFunctionUpdate()
	self:RefreshUnlockBtn()
end

function SettingUI:RefreshUnlockBtn()
	local funcList = {}

	funcList[Constant.UnlockType.FUNC_CDKEY] = self.cdkeyBtn

	UnlockFunctionModule.FuncSwitchHandler(funcList)
end

function SettingUI:OnOpen(userData)
	self.SettingExchangeView:ResetCodeText()

	if userData then
		self.SetTapContent:ToggleEvent("tag4")
		self.OtherSettingClickView:OpenRefresh()
		self:UrpBgMaskFunctiom(false)
	else
		self.SetTapContent:ToggleEvent("tag1")
		self:UrpBgMaskFunctiom(true)
	end

	self:RefreshUnlockBtn()
	self.GraphicSettingView:OnOpen()
	self.SettingPerformanceView:OnOpen()
end

function SettingUI:UrpBgMaskFunctiom(isUrpTestEnter)
	self.AgreementBtn.gameObject:SetActive(isUrpTestEnter)
	self.CancelBtn.gameObject:SetActive(isUrpTestEnter)
	self.TapContent.gameObject:SetActive(isUrpTestEnter)

	self.urpsettingTag.gameObject.transform.localScale = Vector3.zero
end

function SettingUI:OnClose(userData)
	self.GraphicSettingView:OnClose()
end

function SettingUI:GetPreloadAssetPaths()
	return nil
end

function SettingUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SettingUI:IsManualShowOnOpen(userData)
	return false
end

function SettingUI:GetBGM(userData)
	return nil
end

function SettingUI:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.UnlockFunction, self.UnlockFunctionUpdateEvent)
	self.AgreementBtn.onClick:AddListener(self.OnClick_UserAgreementBtn)
	self.PrivacyBtn:GetComponent("Button").onClick:AddListener(self.OnClick_ClickPrivacyBtn)
	self.CancelBtn.onClick:AddListener(self.OnClick_CanelAccountBtn)
	self.GraphicSettingButton.onClick:AddListener(self.delegateOnClickGraphicSetting)
	self.PushToggle:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnClickPushToggle)
	self.UserCenterBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickUserCenterBtn)
	self.FeedbackBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickFeedbackBtn)
	self.CustomerBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickCustomerBtn)
	UIEventUtil.AddClickEventListener_Button(self, "LogoffBtn", self.__OnLogoffBtnClick)
end

function SettingUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.UnlockFunction, self.UnlockFunctionUpdateEvent)
	self.AgreementBtn.onClick:RemoveListener(self.OnClick_UserAgreementBtn)
	self.PrivacyBtn:GetComponent("Button").onClick:RemoveListener(self.OnClick_ClickPrivacyBtn)
	self.CancelBtn.onClick:RemoveListener(self.OnClick_CanelAccountBtn)
	self.GraphicSettingButton.onClick:RemoveListener(self.delegateOnClickGraphicSetting)
	self.PushToggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnClickPushToggle)
	self.UserCenterBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickUserCenterBtn)
	self.FeedbackBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickFeedbackBtn)
	self.CustomerBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickCustomerBtn)
	UIEventUtil.ClearEventListener(self)
end

function SettingUI:__OnLogoffBtnClick()
	Application.OpenURL("https://cdn-sdk.iqigame.com/iqisdk/agreement/hw_close_account.html")
end

function SettingUI:OnPause()
	return
end

function SettingUI:OnResume()
	return
end

function SettingUI:OnCover()
	return
end

function SettingUI:OnReveal()
	return
end

function SettingUI:OnRefocus(userData)
	return
end

function SettingUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SettingUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SettingUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SettingUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

return SettingUI
