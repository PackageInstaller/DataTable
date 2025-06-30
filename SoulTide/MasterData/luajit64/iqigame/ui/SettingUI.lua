-- chunkname: @IQIGame\\UI\\SettingUI.lua

local SettingUI = Base:Extend("SettingUI", "IQIGame.Onigao.UI.SettingUI", {})
local SettingPublicView = require("IQIGame.UI.Setting.SettingPublicView")
local SettingPlayerInfoView = require("IQIGame.UI.Setting.SettingPlayerInfoView")
local SettingMusicView = require("IQIGame.UI.Setting.SettingMusicView")
local SettingInputView = require("IQIGame.UI.Setting.SettingInputView")
local SettingSystemView = require("IQIGame.UI.Setting.SettingSystemView")

function SettingUI:OnInit()
	self:Init()
end

function SettingUI:GetPreloadAssetPaths()
	return nil
end

function SettingUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SettingUI:OnOpen(userData)
	for i = 1, #self.childViewTabs do
		self.childViewTabs[i]:OnMainUIOpen()
	end

	if userData then
		self.toggleTabs[1].gameObject:SetActive(false)
		self.toggleTabs[4].gameObject:SetActive(false)
		self.Bottom:SetActive(false)
		self.BtnLogin:SetActive(false)

		self.currentTabIndex = 2

		for i, v in pairs(self.toggleTabs) do
			v.isOn = false
		end

		self.toggleTabs[self.currentTabIndex].isOn = true
	else
		self.toggleTabs[1].gameObject:SetActive(true)
		self.toggleTabs[4].gameObject:SetActive(true)
		self.Bottom:SetActive(true)
		self.BtnLogin:SetActive(true)
	end

	if CfgDiscreteDataTable[6520061].Data[1] == 1 and LuaCodeInterface.GetOS() == "IOS" then
		self.toggleTabs[4].gameObject:SetActive(false)
	end

	self:UpdateView()
end

function SettingUI:OnClose(userData)
	for i = 1, #self.childViewTabs do
		self.childViewTabs[i]:OnMainUIClose()
	end

	self.settingPublicView:Close()
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
	if self.settingPublicView ~= nil then
		self.settingPublicView:OnUpdate()
	end
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

function SettingUI:OnDestroy()
	self.settingPublicView:Dispose()

	for i = 1, #self.childViewTabs do
		self.childViewTabs[i]:Dispose()
	end
end

function SettingUI:Init()
	UGUIUtil.SetText(self.TextBtnContact, SettingUIApi:GetString("TextBtnContact"))
	UGUIUtil.SetText(self.TextCommunity, SettingUIApi:GetString("TextCommunity"))
	UGUIUtil.SetText(self.TextProto, SettingUIApi:GetString("TextProto"))
	UGUIUtil.SetTextInChildren(self.BtnLogin, SettingUIApi:GetString("TextTitle1"))
	UGUIUtil.SetTextInChildren(self.ToggleTextOn1, SettingUIApi:GetString("ToggleText1"))
	UGUIUtil.SetTextInChildren(self.ToggleTextOff1, SettingUIApi:GetString("ToggleText1"))
	UGUIUtil.SetTextInChildren(self.ToggleTextOn2, SettingUIApi:GetString("ToggleText2"))
	UGUIUtil.SetTextInChildren(self.ToggleTextOff2, SettingUIApi:GetString("ToggleText2"))
	UGUIUtil.SetTextInChildren(self.ToggleTextOn3, SettingUIApi:GetString("ToggleText3"))
	UGUIUtil.SetTextInChildren(self.ToggleTextOff3, SettingUIApi:GetString("ToggleText3"))
	UGUIUtil.SetTextInChildren(self.ToggleTextOn4, SettingUIApi:GetString("ToggleText4"))
	UGUIUtil.SetTextInChildren(self.ToggleTextOff4, SettingUIApi:GetString("ToggleText4"))

	self.btnCloseComponent = self.BtnClose:GetComponent("Button")
	self.btnLoginComponent = self.BtnLogin:GetComponent("Button")
	self.btnContact = self.BtnContact:GetComponent("Button")
	self.btnCommunity = self.BtnCommunity:GetComponent("Button")
	self.btnProto = self.BtnProto:GetComponent("Button")
	self.settingPublicView = SettingPublicView.__New(self.SettingPublic)
	self.settingPlayerInfoView = SettingPlayerInfoView.__New(self.SettingPlayerInfo)
	self.settingMusicView = SettingMusicView.__New(self.SettingMusic)
	self.settingInputView = SettingInputView.__New(self.SettingInput)
	self.settingSystemView = SettingSystemView.New(self.SettingSystem)
	self.childViewTabs = {
		self.settingPlayerInfoView,
		self.settingSystemView,
		self.settingMusicView,
		self.settingInputView
	}

	function self.delegateToggleValueChange(isOn)
		self:OnClickTab(isOn)
	end

	function self.delegateBtnLogin()
		self:OnBtnLogin()
	end

	function self.delegateClickBtnContact()
		self:OnBtnContact()
	end

	function self.delegateClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.delegateClickBtnCommunity()
		self:OnClickBtnCommunity()
	end

	function self.delegateClickBtnProto()
		self:OnClickBtnProto()
	end

	function self.delegateBtnHuaWeiLogoutURL()
		self:OnBtnHuaWeiLogoutURL()
	end

	self:InitToggleGroup()
end

function SettingUI:InitToggleGroup()
	self.toggleTabs = {}

	local toggle, tabBtn

	for i = 1, #self.childViewTabs do
		tabBtn = self.TogGroup.transform:GetChild(i - 1).gameObject
		toggle = tabBtn:GetComponent("Toggle")
		toggle.isOn = false
		self.toggleTabs[i] = toggle
	end

	self.currentTabIndex = self.currentTabIndex == nil and 1 or self.currentTabIndex
	self.toggleTabs[self.currentTabIndex].isOn = true
end

function SettingUI:UpdateView()
	if self.currentTabIndex ~= nil then
		self:ShowTab(self.currentTabIndex)
	end

	self.BtnContact:SetActive(SDKLoginModule.isShowCustomer())
	self.BtnCommunity:SetActive(SDKLoginModule.isShowWiki())
	self.BtnHuaWeiLogoutURL:SetActive(SDKLoginModule.IsHuaweiChannel())
end

function SettingUI:OnClickTab(isOn)
	if isOn then
		local currentTarget = self.UIController:GetCurrentTarget()

		for i = 1, #self.toggleTabs do
			if self.toggleTabs[i].gameObject == currentTarget then
				self:ShowTab(i)

				return
			end
		end
	end
end

function SettingUI:ShowTab(tabIndex)
	if self.currentChildView ~= nil then
		self.currentChildView:Close()
	end

	self.currentTabIndex = tabIndex
	self.currentChildView = self.childViewTabs[self.currentTabIndex]

	self.currentChildView:Open()

	if self.currentTabIndex == 1 then
		self.settingPublicView:Open()
	else
		self.settingPublicView:Close()
	end
end

function SettingUI:OnAddListeners()
	self.btnCloseComponent.onClick:AddListener(self.delegateClickBtnClose)
	self.btnLoginComponent.onClick:AddListener(self.delegateBtnLogin)
	self.btnContact.onClick:AddListener(self.delegateClickBtnContact)
	self.btnCommunity.onClick:AddListener(self.delegateClickBtnCommunity)
	self.btnProto.onClick:AddListener(self.delegateClickBtnProto)
	self.BtnHuaWeiLogoutURL:GetComponent("Button").onClick:AddListener(self.delegateBtnHuaWeiLogoutURL)

	for i, v in pairs(self.toggleTabs) do
		v.onValueChanged:AddListener(self.delegateToggleValueChange)
	end
end

function SettingUI:OnRemoveListeners()
	self.btnCloseComponent.onClick:RemoveListener(self.delegateClickBtnClose)
	self.btnLoginComponent.onClick:RemoveListener(self.delegateBtnLogin)
	self.btnContact.onClick:RemoveListener(self.delegateClickBtnContact)
	self.btnCommunity.onClick:RemoveListener(self.delegateClickBtnCommunity)
	self.btnProto.onClick:RemoveListener(self.delegateClickBtnProto)
	self.BtnHuaWeiLogoutURL:GetComponent("Button").onClick:RemoveListener(self.delegateBtnHuaWeiLogoutURL)

	for i, v in pairs(self.toggleTabs) do
		v.onValueChanged:RemoveListener(self.delegateToggleValueChange)
	end
end

function SettingUI:OnBtnLogin()
	SDKLoginModule.Logout(function()
		LoginModule.Logout(ProcedureReset.ResetAndGoToLogin)
	end)
end

function SettingUI:OnBtnContact()
	SDKLoginModule.contactCustomer()
end

function SettingUI:OnClickBtnCommunity()
	SDKLoginModule.openWiki()
end

function SettingUI:OnBtnHuaWeiLogoutURL()
	UnityEngine.Application.OpenURL(MainUIApi:GetString("HuaWeiLogoutURL"))
end

function SettingUI:OnClickBtnProto()
	UIModule.Open(Constant.UIControllerName.SettingProtoUI, Constant.UILayer.UI)
end

function SettingUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.SettingUI)
end

return SettingUI
