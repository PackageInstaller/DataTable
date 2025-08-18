-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\GridMixin.lua

local GridMixin = {}

function GridMixin:initGridMixin()
	self:initUI()
	self:clear()

	self.mEnableTips = true
	self.mTipsConfig = nil
	self.mEventClick = nil
end

function GridMixin:initUI()
	self.imgIcon = UIControls.Image(self, "Icon")
	self.imgSelected = UIControls.Image(self, "ImgSelect")
	self.btnSensor = UIControls.Button(self)

	self.btnSensor:addEventClick(self.onGridClick)
end

function GridMixin:setObj(object)
	self.object = object

	if object == nil then
		self:clear()

		return
	end

	self:_setObj(object)
end

function GridMixin:_setObj(object)
	local iconPath = object:getIconPath()

	if iconPath then
		self.imgIcon:setImage(iconPath[1], iconPath[2])
		self.imgIcon:setVisible(true)
	end
end

function GridMixin:clear()
	self.object = nil
	self._isSelect = false

	self.imgIcon:setVisible(false)
	self.imgSelected:setVisible(false)
end

function GridMixin:isEmpty()
	return self.object == nil
end

function GridMixin:getSelected()
	return self._isSelect
end

function GridMixin:setSelected(selected)
	self._isSelect = selected

	self.imgSelected:setVisible(selected)
end

function GridMixin:onGridClick(sender)
	if self.mEventClick then
		self.mEventClick(self)
	end

	if self:isEmpty() then
		return
	end

	if self._onGridClick ~= nil then
		self:_onGridClick()
	end
end

function GridMixin:setClickEnable(isEnable)
	self.btnSensor:setEnable(isEnable)
end

return GridMixin
