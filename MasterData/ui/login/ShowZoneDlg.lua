-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Login\\ShowZoneDlg.lua

local UIControls = require("UI/UIControls")
local strClassName = "ShowZone"
local ShowZone = Class(strClassName, UIControls.Window)
local UrlConfig = require("Network/UrlConfig")
local SDKAppUtils = require("SDK/SDKAppUtils")

ShowZone._DISPLAY_SECTIONS = {
	Const.SEA_SECTION_EU,
	Const.SEA_SECTION_NA,
	Const.SEA_SECTION_SEA
}

function ShowZone:ctor()
	self.buttons = {}
	self.buttons_state = {}
	self.buttons[1] = UIControls.Button(self, "BgPanel/ZonePanel/BtnZone1")
	self.buttons[2] = UIControls.Button(self, "BgPanel/ZonePanel/BtnZone2")
	self.buttons[3] = UIControls.Button(self, "BgPanel/ZonePanel/BtnZone3")
	self.buttons_state[1] = UIControls.Button(self, "BgPanel/ZonePanel/BtnZone1/BgState")
	self.buttons_state[2] = UIControls.Button(self, "BgPanel/ZonePanel/BtnZone2/BgState")
	self.buttons_state[3] = UIControls.Button(self, "BgPanel/ZonePanel/BtnZone3/BgState")
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onClose)
end

function ShowZone:onOpen()
	ShowZone.super.onOpen(self)
	self:_setButtons()
end

function ShowZone:setZone(zoneName, zoneValue)
	local noSection = ServerSection.getSection() == nil

	if noSection then
		ServerSection.setSection(zoneValue)
		self:setVisible(false)
	else
		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), Lang.get(55779), Functor(self.setServerSection, self, zoneValue), nil, nil, Lang.get(8), Lang.get(7))
	end
end

function ShowZone:setServerSection(zoneValue)
	ServerSection.setSection(zoneValue)
	SDKAppUtils.exitApp()
	self:setVisible(false)
end

function ShowZone:_setButtons()
	local curSection = ServerSection.getSection()

	for index = 1, 3 do
		local section = self._DISPLAY_SECTIONS[index]

		self.buttons[index]:addEventClick(Functor(self.setZone, self, Const.SEA_SECTION_NAME[section], section))

		local selected = section == curSection

		self.buttons_state[index]:setVisible(selected)
		self.buttons[index]:setEnable(not selected)
	end
end

function ShowZone:onClose()
	self:setVisible(false, true)
end

return ShowZone
