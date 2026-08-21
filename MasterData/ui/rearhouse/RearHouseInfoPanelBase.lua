-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\RearHouseInfoPanelBase.lua

local UIUtils = require("Framework.UI.UIUtils")
local RearHouseInfoPanelBase = Class("RearHouseInfoPanelBase", UIControls.Logo)
local ratio = 1.1
local HEIGHT = 125 * ratio
local WIDTH = 125 * ratio
local HALF_HEIGHT = 42 * ratio

function RearHouseInfoPanelBase:ctor(...)
	return
end

function RearHouseInfoPanelBase:setTarget(center, target)
	self.center = center
	self.target = target
end

function RearHouseInfoPanelBase:showPanel(isLeftRoot, isLeftPanel)
	local showIndex = isLeftPanel and 1 or 2

	if isLeftRoot then
		UIUtils.SetLogoTarget(self.id, self.target.topRootLeft)
	else
		UIUtils.SetLogoTarget(self.id, self.target.topRootRight)
	end

	for i, panel in ipairs(self.panels) do
		if showIndex == i then
			panel:setVisible(true)
		else
			panel:setVisible(false)
		end
	end
end

function RearHouseInfoPanelBase:setVisible(v)
	if v then
		self:checkBounds()
	end

	RearHouseInfoPanelBase.super.setVisible(self, v)
end

function RearHouseInfoPanelBase:checkBounds(...)
	if self.target and self.target.topRootLeft and self.target.topRootRight then
		local bounds = self.center.bounds.edit
		local rootPos

		rootPos = self.target.topRootRight.position

		local pos = CameraModeManager.getScreenPos(rootPos)
		local leftUpPos = CameraModeManager.getScreenPos(bounds.leftUpPos)
		local rightDownPos = CameraModeManager.getScreenPos(bounds.rightDownPos)
		local height = self.target.type == 8 and HEIGHT or HALF_HEIGHT

		if pos.x + WIDTH > rightDownPos.x then
			self:showPanel(true, true)
		else
			self:showPanel(false, false)
		end

		if pos.y + height >= leftUpPos.y then
			self:setPanelPosition(0, -(pos.y + height - leftUpPos.y))
		elseif pos.y - height < rightDownPos.y then
			self:setPanelPosition(0, -(pos.y - height - rightDownPos.y))
		else
			self:setPanelPosition(0, 0)
		end
	end
end

function RearHouseInfoPanelBase:setPanelPosition(x, y)
	for i, panel in ipairs(self.panels) do
		panel:setPosition(x, y)
	end
end

return RearHouseInfoPanelBase
