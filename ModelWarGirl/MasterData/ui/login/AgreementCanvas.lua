-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Login\\AgreementCanvas.lua

local SDKConst = require("SDK/SDKConst")
local AttName = SDKConst.AttName
local DeviceHelper = require("Helper/DeviceHelper")
local strClassName = "agreementCanvas"
local AgreementCanvas = Class(strClassName, UIControls.Window)

AgreementCanvas.textAgreement = {
	Lang.get(86601),
	Lang.get(86602),
	(Lang.get(86603))
}
AgreementCanvas.textPrivacy = {
	Lang.get(101659),
	Lang.get(86605),
	(Lang.get(86606))
}
AgreementCanvas.textPrivacyChildren = {
	Lang.get(90265),
	Lang.get(86608),
	(Lang.get(86609))
}
AgreementCanvas.textThirdPartyAndroid = {
	Lang.get(86610),
	Lang.get(86611),
	(Lang.get(86612))
}
AgreementCanvas.textThirdPartyIOS = {
	Lang.get(86610),
	Lang.get(86611),
	(Lang.get(86612))
}
AgreementCanvas.textPrivacyXxgame = {
	Lang.get(101660),
	Lang.get(101661),
	(Lang.get(101662))
}

local MAX_PART = 4

AgreementCanvas.btnType = {
	confirm = 1,
	close = 0
}

local PROTOCOL_TYPE = {
	privacy = "privacy",
	thirdParty = "thirdParty",
	agreement = "agreement",
	privacyChildren = "privacyChildren"
}

function AgreementCanvas:ctor()
	self.textTitle = UIControls.Label(self, "BgPanel/TextTitle")
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(Functor(self.onClickClose, self, self.btnType.close))

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnEnter")

	self.btnConfirm:addEventClick(Functor(self.onClickClose, self, self.btnType.confirm))

	self.panelTab = UIControls.Panel(self, "BgPanel/TabPanel")

	if RegionUtils.isCurrentRegion(RegionConst.REGION_JP) then
		self.panelTab:setVisible(true)
	end

	self.btnAgreement = UIControls.Button(self, "BgPanel/TabPanel/Tab1", "Text")

	self.btnAgreement:addEventClick(Functor(self.setShowType, self, PROTOCOL_TYPE.agreement))
	self.btnAgreement:setText(Lang.get(1365))

	self.btnPrivacy = UIControls.Button(self, "BgPanel/TabPanel/Tab2", "Text")

	self.btnPrivacy:addEventClick(Functor(self.setShowType, self, PROTOCOL_TYPE.privacy))
	self.btnPrivacy:setText(Lang.get(1395))

	self.btnChildPrivacy = UIControls.Button(self, "BgPanel/TabPanel/Tab3", "Text")

	self.btnChildPrivacy:addEventClick(Functor(self.setShowType, self, PROTOCOL_TYPE.privacyChildren))
	self.btnChildPrivacy:setText(Lang.get(74847))

	self.btnThirdParty = UIControls.Button(self, "BgPanel/TabPanel/Tab4", "Text")

	self.btnThirdParty:addEventClick(Functor(self.setShowType, self, PROTOCOL_TYPE.thirdParty))
	self.btnThirdParty:setText(Lang.get(75660))

	self.txtContents = {}

	for i = 1, MAX_PART do
		local txt = UIControls.Label(self, "BgPanel/Scroll ViewContent/Viewport/Content/TextContent" .. i)

		self.txtContents[i] = txt
	end
end

function AgreementCanvas:onClickClose(type)
	self:setVisible(false)
end

function AgreementCanvas:setShowType(protocol)
	local textRule

	if protocol == PROTOCOL_TYPE.agreement then
		self.textTitle:setText(Lang.get(1365))

		textRule = AgreementCanvas.textAgreement

		self.btnAgreement:setEnable(true)
		self.btnPrivacy:setEnable(false)
		self.btnChildPrivacy:setEnable(false)
		self.btnThirdParty:setVisible(false)
	elseif protocol == PROTOCOL_TYPE.privacyChildren then
		self.textTitle:setText(Lang.get(74847))

		textRule = AgreementCanvas.textPrivacyChildren

		self.btnPrivacy:setEnable(false)
		self.btnAgreement:setEnable(false)
		self.btnChildPrivacy:setEnable(true)
		self.btnThirdParty:setVisible(false)
	elseif protocol == PROTOCOL_TYPE.thirdParty then
		self.textTitle:setText(Lang.get(75660))

		if DeviceHelper.isIOS() then
			textRule = AgreementCanvas.textThirdPartyIOS
		else
			textRule = AgreementCanvas.textThirdPartyAndroid
		end

		self.btnPrivacy:setEnable(false)
		self.btnAgreement:setEnable(false)
		self.btnChildPrivacy:setEnable(false)
		self.btnThirdParty:setVisible(true)
	else
		self.textTitle:setText(Lang.get(1395))

		if ChannelUtil.getSubChannelID() == "xxgame" then
			textRule = AgreementCanvas.textPrivacyXxgame
		else
			textRule = AgreementCanvas.textPrivacy
		end

		self.btnPrivacy:setEnable(true)
		self.btnAgreement:setEnable(false)
		self.btnChildPrivacy:setEnable(false)
		self.btnThirdParty:setVisible(false)
	end

	for i = 1, MAX_PART do
		if textRule[i] then
			self.txtContents[i]:setVisible(true)
			self.txtContents[i]:setText(textRule[i])
		else
			self.txtContents[i]:setVisible(false)
		end
	end
end

return AgreementCanvas
