-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\BlockBox.lua

local UIUtils = Framework.UI.UIUtils
local strClassName = "BlockBox"
local BlockBox = Class(strClassName, UIControls.Window)

function BlockBox:ctor()
	self.btn = UIControls.Button(self, "Block")

	self.btn:addEventClick(self.onSensorClick)

	self.img = UIControls.Image(self, "ImgScreen")
	self.trigger = UIControls.UnionTextureTrigger(self, "ImgScreen")
end

function BlockBox:show(info)
	self.info = info

	local ui = UIManager.getUI(self.info.name, nil, false)

	if info.alpha > 0 then
		self.trigger:setPauseDelay(info.pauseDelay or -1)
		self.img:setVisible(true)
	else
		self.img:setVisible(false)
	end

	if ui then
		self:setOrder(ui:getOrder() - 1)
	end

	self:setVisible(true)
end

function BlockBox:setVisible(v, hideAndDestroy)
	if v and self._visible then
		self:onVisibleChanged(true)
		UIUtils.UpdateBlurImmune(self.id)

		return
	end

	BlockBox.super.setVisible(self, v, hideAndDestroy)
end

function BlockBox:onSensorClick()
	local ui = UIManager.getUI(self.info.name, nil, false)

	if ui and self.info.close and not ui.mOpening then
		UIManager.clearBlock(ui)
	end
end

function BlockBox:onVisibleChanged(isSee)
	BlockBox.super.onVisibleChanged(self, isSee)

	local layer = isSee and self:getOrder() or 999999

	UIUtils.SetBlurOrder(layer)
end

function BlockBox:setOrder(v)
	BlockBox.super.setOrder(self, v)

	if self:getVisible() and self.img:getVisible() then
		self.trigger:refresh()
	end
end

return BlockBox
