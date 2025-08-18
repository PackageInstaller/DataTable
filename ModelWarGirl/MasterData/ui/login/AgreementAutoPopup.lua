-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Login\\AgreementAutoPopup.lua

local DeviceHelper = require("Helper/DeviceHelper")
local UIControls = require("UI/UIControls")
local strClassName = "AgreementAutoPopup"
local Analytics = require("SDK/Analytics")
local LoginHelper = require("UI/Login/LoginHelper")
local UserData = require("Helper/UserData")
local AgreementAutoPopup = Class(strClassName, UIControls.Window)

AgreementAutoPopup.btnType = {
	confirm = 1,
	deny = 0
}

local PROTOCOL_TYPE = {
	privacy = "privacy",
	agreement = "agreement",
	privacyChildren = "privacyChildren"
}

function AgreementAutoPopup:ctor()
	self.btnClose = UIControls.Button(self, "Bg/BtnDeny", "Text")

	self.btnClose:addEventClick(Functor(self.onClickClose, self, self.btnType.deny))

	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnConfirm:addEventClick(Functor(self.onClickClose, self, self.btnType.confirm))

	self.txtAgreement_1 = UIControls.Label(self, "Bg/ContentPanel/AgreementCheckPanel/Label")
	self.txtAgreement_2 = UIControls.Label(self, "Bg/ContentPanel/AgreementCheckPanel/Label2")
	self.txtAgreement_3 = UIControls.Label(self, "Bg/ContentPanel/AgreementCheckPanel/Label3")
	self.txtAgreement_4 = UIControls.Label(self, "Bg/ContentPanel/AgreementCheckPanel/Label4")
	self.txtTitle = UIControls.Label(self, "Bg/TextTitle")
	self.txtDescription = UIControls.Label(self, "Bg/ContentPanel/TextContent")
	self.btnAgreement = UIControls.Button(self, "Bg/ContentPanel/AgreementCheckPanel/BtnAgreement")

	self.btnAgreement:addEventClick(Functor(self.showAgreement, self, PROTOCOL_TYPE.agreement))

	self.btnPrivacy = UIControls.Button(self, "Bg/ContentPanel/AgreementCheckPanel/BtnPrivacy", "Text")

	self.btnPrivacy:addEventClick(Functor(self.showAgreement, self, PROTOCOL_TYPE.privacy))
	self.btnPrivacy:setText(Lang.get(1395))
	self:setAgreementText()
	self:sendBytePrivacyLog(1)

	self.btnPrivacyChildren = UIControls.Button(self, "Bg/ContentPanel/AgreementCheckPanel/BtnPrivacyChildren", "Text")

	self.btnPrivacyChildren:addEventClick(Functor(self.showAgreement, self, PROTOCOL_TYPE.privacyChildren))

	if RegionUtils.isCN() then
		self.btnPrivacyChildren:setVisible(true)
	else
		self.btnPrivacyChildren:setVisible(false)
	end
end

function AgreementAutoPopup:showAgreement(protocol)
	SDKAgent.openAgreement(protocol)
end

function AgreementAutoPopup:setAgreementText()
	local description = ""

	if RegionUtils.isJP() then
		self.txtAgreement_1:setText(Lang.get(37131))
		self.txtAgreement_2:setText(Lang.get(37132))
		self.txtAgreement_3:setText("")
		self.txtAgreement_4:setText(Lang.get(37133))

		description = "フィギュアストーリーをご利用いただきありがとうございます。本サービスの利用に際しては、利用規約及びプライバシーポリシーの全文をお読み頂いたうえで、同意いただく必要があります。"
	elseif RegionUtils.isCN() then
		description = Lang.get(43995)

		if DeviceHelper.isAndroid() then
			description = string.format(Lang.get(45486), description)
		end
	end

	self.txtTitle:setText(Lang.get(5))
	self.txtDescription:setText(description)
end

function AgreementAutoPopup:onClickClose(type)
	if LoginHelper.onAgreementPopSelected then
		local agree = type == self.btnType.confirm

		LoginHelper.onAgreementPopSelected(agree)
	end

	if type == self.btnType.deny and RegionUtils.isCN() then
		UserData.clearCommonData("showAgreementIndex")

		local LuaToolkit = Framework.Tools.LuaToolkit

		LuaToolkit.QuitApplication()
	end

	self:sendBytePrivacyLog(type == self.btnType.confirm and 2 or 3)
	self:setVisible(false)
end

function AgreementAutoPopup:sendBytePrivacyLog(action)
	if RegionUtils.isJP() then
		local data = Analytics.getByteLogParamNoUser()

		data.action = action

		Analytics.sendLogByted("privacy", ClientUtils.table2String(data))
	end
end

return AgreementAutoPopup
