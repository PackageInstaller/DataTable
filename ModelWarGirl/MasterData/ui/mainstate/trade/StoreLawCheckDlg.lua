-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\StoreLawCheckDlg.lua

local ResClientHardCode = require("ClientData/ResClientHardCode")
local StoreLawCheckDlg = Class("StoreLawCheckDlg", UIControls.Window)
local ONSHOWLAW = {
	Settlement = 1,
	Month = 3,
	Business = 2
}

function StoreLawCheckDlg:ctor()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onClose)

	self.textPanel = UIControls.Panel(self, "BgPanel/ScrollView/Viewport/Content")
	self.text = UIControls.Label(self, "BgPanel/ScrollView/Viewport/Content/TextContent")
	self.btnSettlement = UIControls.Button(self, "BgPanel/TabPanel/Tab1")

	self.btnSettlement:addEventClick(Functor(self.showLaw, self, ONSHOWLAW.Settlement))

	self.btnBusiness = UIControls.Button(self, "BgPanel/TabPanel/Tab2")

	self.btnBusiness:addEventClick(Functor(self.showLaw, self, ONSHOWLAW.Business))

	self.btnMonth = UIControls.Button(self, "BgPanel/TabPanel/Tab3")

	self.btnMonth:addEventClick(Functor(self.showLaw, self, ONSHOWLAW.Month))
end

function StoreLawCheckDlg:onOpen()
	StoreLawCheckDlg.super.onOpen(self)
	self:showLaw(ONSHOWLAW.Settlement)
end

function StoreLawCheckDlg:showLaw(law)
	self.textPanel:setPosition(0, 0)

	if law == ONSHOWLAW.Settlement then
		self.text:setText(ResClientHardCode[10] and ResClientHardCode[10].desc[1])
		self.btnSettlement:setEnable(false)
		self.btnBusiness:setEnable(true)
		self.btnMonth:setEnable(true)
	elseif law == ONSHOWLAW.Month then
		self.text:setText(ResClientHardCode[16] and ResClientHardCode[16].desc[1])
		self.btnSettlement:setEnable(true)
		self.btnBusiness:setEnable(true)
		self.btnMonth:setEnable(false)
	else
		self.text:setText(ResClientHardCode[9] and ResClientHardCode[9].desc[1])
		self.btnSettlement:setEnable(true)
		self.btnBusiness:setEnable(false)
		self.btnMonth:setEnable(true)
	end
end

function StoreLawCheckDlg:onClose()
	self:setVisible(false)
end

return StoreLawCheckDlg
