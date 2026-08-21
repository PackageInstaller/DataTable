-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Login\\SuccessionCodeTipDlg.lua

local strClassName = "SuccessionCodeTipDlg"
local SuccessionCodeTipDlg = Class(strClassName, UIControls.Window)
local DeviceHelper = require("Helper/DeviceHelper")
local UIControls = require("UI/UIControls")
local SDKAppUtils = require("SDK/SDKAppUtils")

function SuccessionCodeTipDlg:ctor()
	self.textTitle = UIControls.Label(self, "Bg/TextTitle")
	self.textContent1 = UIControls.Label(self, "Bg/ContentPanel/TextContent1")
	self.textContent2 = UIControls.Label(self, "Bg/ContentPanel/TextContent2")
	self.btnDeny = UIControls.Button(self, "Bg/BtnDeny")

	self.btnDeny:addEventClick(self.onDenyClick)

	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm", "Text")

	self.btnConfirm:addEventClick(self.onConfirmClick)

	self.isStart = nil
end

function SuccessionCodeTipDlg:onOpenStartTip()
	if not self:getVisible() then
		self:initStartData()
		self:setVisible(true)

		self.isStart = true
	end
end

function SuccessionCodeTipDlg:onOpenEndTip()
	if not self:getVisible() then
		self:initEndData()
		self:setVisible(true)

		self.isStart = false
	end
end

function SuccessionCodeTipDlg:onConfirmClick()
	if self.isStart then
		local successionCodeChooseDlg = UIManager.getUI("successionCodeChooseDlg")

		if successionCodeChooseDlg then
			successionCodeChooseDlg:show()
			self:setVisible(false)
		end
	elseif DeviceHelper.isWindows() then
		Framework.SDK.U3DOceanSDK.QuitApplication()
	else
		SDKAppUtils.exitApp()
	end
end

function SuccessionCodeTipDlg:onDenyClick()
	if self:getVisible() then
		self:setVisible(false)
	end
end

function SuccessionCodeTipDlg:initStartData()
	self.textTitle:setText("データ連携")
	self.textContent1:setVisible(true)
	self.textContent2:setVisible(false)
	self.btnDeny:setVisible(true)
	self.btnConfirm:setText("データ連携")
end

function SuccessionCodeTipDlg:initEndData()
	self.textTitle:setText(Lang.get(75619))
	self.textContent1:setVisible(false)
	self.textContent2:setVisible(true)
	self.btnDeny:setVisible(false)
	self.btnConfirm:setText(Lang.get(50621))
end

return SuccessionCodeTipDlg
