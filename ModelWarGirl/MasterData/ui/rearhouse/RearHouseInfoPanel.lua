-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\RearHouseInfoPanel.lua

local strClassName = "RearHouseInfoPanel"
local RearHouseInfoPanelBase = require("UI/RearHouse/RearHouseInfoPanelBase")
local CameraModeManager = require("System/CameraModeManager")
local RearHouseInfoPanel = Class(strClassName, RearHouseInfoPanelBase)

function RearHouseInfoPanel:ctor(entity, prefabPath, x, y)
	self.mConfirmClick = nil
	self.mDelClick = nil
	self.mFlipClick = nil

	self:initUI()
end

function RearHouseInfoPanel:initUI(...)
	local path = {
		"EditLeft",
		"EditRight"
	}

	self.panels = {}

	for i = 1, #path do
		local _path = path[i]
		local panel = UIControls.Panel(self, _path)

		table.insert(self.panels, panel)

		local btnConfirm = UIControls.Button(self, _path .. "/BtnConfirm")

		btnConfirm:addEventClick(self.onBtnConfirmClick)

		local btnDel = UIControls.Button(self, _path .. "/BtnDel")

		btnDel:addEventClick(self.onBtnDelClick)

		panel.btnFlip = UIControls.Button(self, _path .. "/BtnFlip")

		panel.btnFlip:addEventClick(self.onBtnFlipClick)
	end
end

function RearHouseInfoPanel:setIsShelf(isShelf)
	for i, panel in ipairs(self.panels) do
		panel.btnFlip:setVisible(isShelf)
	end
end

function RearHouseInfoPanel:onBtnConfirmClick(...)
	if self.mConfirmClick then
		self.mConfirmClick()
	end
end

function RearHouseInfoPanel:onBtnDelClick(...)
	if self.mDelClick then
		self.mDelClick()
	end
end

function RearHouseInfoPanel:onBtnFlipClick(...)
	if self.mFlipClick then
		self.mFlipClick()
	end
end

return RearHouseInfoPanel
