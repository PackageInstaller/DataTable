-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\AttrCellMixin.lua

local AttrCellMixin = {}

function AttrCellMixin:ctorMixin()
	self:initUI()
end

function AttrCellMixin:initUI()
	self.basePath = ""

	if self.mPath then
		self.basePath = self.mPath .. "/"
	end

	self.imgIcon = UIControls.Image(self, self.basePath .. "Icon")
	self.textName = UIControls.Label(self, self.basePath .. "TextName")
	self.textNum = UIControls.Label(self, self.basePath .. "TextNum1")
end

function AttrCellMixin:setTypeData(attrType, attrValue)
	local iconPath = ClientUtils.getRolePropIconByType(attrType)

	if iconPath then
		self.imgIcon:setImage(iconPath[1], iconPath[2])
	end

	local zhName, valueStr = ClientUtils.getRolePropZhNameByType(attrType, attrValue)

	self.textName:setText(zhName)
	self.textNum:setText(valueStr)
end

return AttrCellMixin
