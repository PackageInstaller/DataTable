-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\GridChangeCellChild.lua

local ResItemConvert = require("ClientData/ResItemConvert")
local ResRandClient = require("ClientData/ResRandClient")
local strClassName = "GridChangeCellChild"
local GridChangeCellChild = Class(strClassName, UIControls.Child)

function GridChangeCellChild:ctor()
	self.imgIcon = UIControls.Image(self, "Icon")
	self.imgQuality = UIControls.Image(self, "ImgQuality")
	self.textNum = UIControls.Label(self, "TextNum")
end

function GridChangeCellChild:setObj(object)
	self.object = BaseObject.getConvertObject(object)

	if not self.object then
		return
	end

	self:_setObj(self.object)
end

function GridChangeCellChild:_setObj(object)
	local iconPath = object:getIconPath()

	if iconPath then
		self.imgIcon:setImage(iconPath[1], iconPath[2])
		self.imgIcon:setVisible(true)
	end

	local qualityPath = object:getQualityPath()

	if qualityPath then
		self.imgQuality:setImage(qualityPath[1], qualityPath[2])
	end

	local type = BaseObject.GetObjectType(object.id)

	if type == Const.ITEM_TYPE_ITEM then
		if self.textNum then
			if object.num and object.num > 1 then
				self.textNum:setText(object.num)
			else
				self.textNum:setText("")
			end
		end
	elseif type == Const.ITEM_TYPE_SKIN then
		self.textNum:setText("")
	end
end

function GridChangeCellChild:clear()
	self.object = nil

	self.imgIcon:setVisible(false)
end

return GridChangeCellChild
