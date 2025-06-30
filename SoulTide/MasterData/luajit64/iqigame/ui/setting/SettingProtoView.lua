-- chunkname: @IQIGame\\UI\\Setting\\SettingProtoView.lua

local SettingProtoView = {}
local SettingProtocolItem = require("IQIGame.UI.Setting.SettingProtocolItem")
local SettingProtoInfoView = require("IQIGame.UI.Setting.SettingProtoInfoView")

function SettingProtoView.New(view)
	local obj = Clone(SettingProtoView)

	obj:Init(view)

	return obj
end

function SettingProtoView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.infoView = SettingProtoInfoView.New(self.goInfoView)

	function self.DelegateCheckProtocolDetail(title, url)
		self:CheckProtocolDetail(title, url)
	end

	self.UserProtocolItem = SettingProtocolItem.New(self.UserProtocolItemGO, self.DelegateCheckProtocolDetail)
	self.PrivacyProtocolItem = SettingProtocolItem.New(self.PrivacyProtocolItemGO, self.DelegateCheckProtocolDetail)
	self.ChildProtocolItem = SettingProtocolItem.New(self.ChildProtocolItemGO, self.DelegateCheckProtocolDetail)
	self.ThirdPartyChannelProtocolItem = SettingProtocolItem.New(self.ThirdPartyChannelProtocolItemGO, self.DelegateCheckProtocolDetail)

	self:OnAddListener()
end

function SettingProtoView:OnMainUIOpen()
	if SDKLoginModule.IsSDKMode() then
		self.SDKProtocolResult = SDKLoginModule.GetProtocolResultInfo()
	end
end

function SettingProtoView:OnMainUIClose()
	self:Close()

	self.SDKProtocolResult = nil
end

function SettingProtoView:Open()
	self.View:SetActive(true)
	self.infoView:Close()

	if SDKLoginModule.IsSDKMode() and self.SDKProtocolResult ~= nil then
		self.UserProtocolItem:SetData(self.SDKProtocolResult.userAgrName, self.SDKProtocolResult.userAgrUrl)
		self.PrivacyProtocolItem:SetData(self.SDKProtocolResult.priAgrName, self.SDKProtocolResult.priAgrUrl)
		self.ChildProtocolItem:SetData(self.SDKProtocolResult.childAgrName, self.SDKProtocolResult.childAgrUrl)
		self.ThirdPartyChannelProtocolItem:SetData(self.SDKProtocolResult.sdkAgrName, self.SDKProtocolResult.sdkAgrUrl)
	else
		self.UserProtocolItem:SetData(MiscApi:GetString("UserProtocolNameText"), MiscApi:GetString("UserProtocolUrl"))
		self.PrivacyProtocolItem:SetData(MiscApi:GetString("PrivacyPolicyNameText"), MiscApi:GetString("PrivacyPolicyUrl"))
		self.ChildProtocolItem:SetData(MiscApi:GetString("ChildPrivacyNameText"), MiscApi:GetString("ChildPrivacyUrl"))
		self.ThirdPartyChannelProtocolItem:SetData("", "")
	end
end

function SettingProtoView:Close()
	self.View:SetActive(false)
	self.infoView:Close()
end

function SettingProtoView:OnAddListener()
	self.UserProtocolItem:AddListeners()
	self.PrivacyProtocolItem:AddListeners()
	self.ChildProtocolItem:AddListeners()
	self.ThirdPartyChannelProtocolItem:AddListeners()
end

function SettingProtoView:OnRemoveListener()
	self.UserProtocolItem:RemoveListeners()
	self.PrivacyProtocolItem:RemoveListeners()
	self.ChildProtocolItem:RemoveListeners()
	self.ThirdPartyChannelProtocolItem:RemoveListeners()
end

function SettingProtoView:CheckProtocolDetail(title, url)
	if url == nil or url == "" then
		return
	end

	self.infoView:Open(url, title)
end

function SettingProtoView:Dispose()
	self:OnRemoveListener()
	self.UserProtocolItem:Dispose()
	self.PrivacyProtocolItem:Dispose()
	self.ChildProtocolItem:Dispose()
	self.ThirdPartyChannelProtocolItem:Dispose()
	self.infoView:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return SettingProtoView
