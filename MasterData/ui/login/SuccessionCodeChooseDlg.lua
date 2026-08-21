-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Login\\SuccessionCodeChooseDlg.lua

local strClassName = "SuccessionCodeChooseDlg"
local SuccessionCodeChooseDlg = Class(strClassName, UIControls.Window)
local SvrListManager = SvrListManager
local REQ_TYPE = SvrListManager.REQ_TYPE
local UIControls = require("UI/UIControls")

function SuccessionCodeChooseDlg:ctor()
	self.btnBind = UIControls.Button(self, "BgPanel/OptionPanel/BtnBind")

	self.btnBind:addEventClick(self.onBindClick)

	self.btnSetCode = UIControls.Button(self, "BgPanel/OptionPanel/BtnSetCode")

	self.btnSetCode:addEventClick(self.onSetClick)

	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)
end

function SuccessionCodeChooseDlg:show()
	if not self:getVisible() then
		self:setVisible(true)
	end
end

function SuccessionCodeChooseDlg:onBindClick()
	SvrListManager.requestUpdate(REQ_TYPE.FULL)
	SvrListManager.requestUpdate(REQ_TYPE.ENTRY)

	local successionCodeBindDlg = UIManager.getUI("successionCodeBindDlg")

	if successionCodeBindDlg then
		successionCodeBindDlg:show()
		self:setVisible(false)
	end
end

function SuccessionCodeChooseDlg:onSetClick()
	local successionCodeCreateDlg = UIManager.getUI("successionCodeCreateDlg")

	if successionCodeCreateDlg then
		successionCodeCreateDlg:show()
		self:setVisible(false)
	end
end

function SuccessionCodeChooseDlg:onCloseClick()
	if self:getVisible() then
		self:setVisible(false)
	end
end

return SuccessionCodeChooseDlg
