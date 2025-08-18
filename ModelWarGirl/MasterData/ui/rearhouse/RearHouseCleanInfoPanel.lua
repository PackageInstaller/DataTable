-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\RearHouseCleanInfoPanel.lua

local strClassName = "RearHouseCleanInfoPanel"
local RearHouseInfoPanelBase = require("UI/RearHouse/RearHouseInfoPanelBase")
local CameraModeManager = require("System/CameraModeManager")
local RearHouseCleanInfoPanel = Class(strClassName, RearHouseInfoPanelBase)

function RearHouseCleanInfoPanel:ctor(entity, prefabPath, x, y)
	self.mCleanClick = nil

	self:initUI()
end

function RearHouseCleanInfoPanel:initUI(...)
	local path = {
		"EditLeft",
		"EditRight"
	}

	self.panels = {}

	for i = 1, #path do
		local _path = path[i]
		local panel = UIControls.Panel(self, _path)

		table.insert(self.panels, panel)

		local btnClean = UIControls.Button(self, _path .. "/BtnClean")

		btnClean:addEventClick(self.onBtnCleanClick)
	end
end

function RearHouseCleanInfoPanel:getTargetHero(...)
	if self.target then
		return self.target.putData.hero
	end
end

function RearHouseCleanInfoPanel:onBtnCleanClick(...)
	if self.mCleanClick then
		self.mCleanClick()
	end
end

return RearHouseCleanInfoPanel
