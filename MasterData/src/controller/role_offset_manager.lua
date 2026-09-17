local RoleOffsetManager = class("RoleOffsetManager", (require("controller.base_manager")))

RoleOffsetManager.MULTITON_MSG = "RoleOffsetManager instancealready constructed!"

local var_0_1 = tostring
local var_0_2 = tonumber
local var_0_3 = checktable
local var_0_4 = math.ceil

RoleOffsetManager.MoveType = {
	Bubble = 1,
	Image = 0
}

function RoleOffsetManager:ctor()
	RoleOffsetManager.super.ctor(self)
	self:resetData()
end

function RoleOffsetManager:resetData()
	self._imagePath = nil
	self._imageAnchorPoint = cc.p(0.5, 0)
	self._initPos = cc.p(0, 0)
	self._curPos = cc.p(0, 0)
	self._bubbleAnchorPoint = cc.p(0.5, 0.5)
	self._bubbleInitPos = cc.p(GameDisplay.getUiScreenSize().width / 2, GameDisplay.getUiScreenSize().height / 2)
	self._bubbleCurPos = clone(self._bubbleInitPos)
	self._moveType = RoleOffsetManager.MoveType.Image
end

function RoleOffsetManager:createLayer(arg_3_1)
	self:removeLayer()
	self:resetData()

	local var_3_0 = require("view.Layer.RoleOffset.RoleOffsetLayer"):create()

	var_3_0:setName("RoleOffsetLayer")
	var_3_0:setLocalZOrder(9999)
	global_basic_scene:addChild(var_3_0)

	arg_3_1 = var_0_3(arg_3_1)

	if arg_3_1.imagePath then
		self:setImagePath(arg_3_1.imagePath)
		self:updateImagePath()
	end

	if arg_3_1.moveType then
		self:setMoveType(arg_3_1.moveType)
	end

	if arg_3_1.initPos then
		self:setRoleInitPos(arg_3_1.initPos)
		self:setImagePos(arg_3_1.initPos)
		self:updateImagePath()
	end

	if arg_3_1.bubbleInitPos then
		self:setBubbleInitPos(arg_3_1.bubbleInitPos)
		self:setBubblePos(arg_3_1.bubbleInitPos)
		self:updateBubblePos()
	end
end

function RoleOffsetManager:removeLayer()
	if self.layer then
		global_basic_scene:removeChildByName("RoleOffsetLayer")
	end
end

function RoleOffsetManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function RoleOffsetManager:updateImagePath()
	if self.layer then
		self.layer:updateImage()
	end
end

function RoleOffsetManager:updateBubblePos()
	if self.layer then
		self.layer:updateBubblePos()
	end
end

function RoleOffsetManager:setMoveType(arg_8_1)
	arg_8_1 = var_0_2(arg_8_1)

	for iter_8_0, iter_8_1 in pairs(RoleOffsetManager.MoveType) do
		if arg_8_1 == iter_8_1 then
			self._moveType = arg_8_1

			break
		end
	end
end

function RoleOffsetManager:getMoveType()
	return self._moveType
end

function RoleOffsetManager:setImagePath(arg_10_1)
	arg_10_1 = var_0_1(arg_10_1)
	self._imagePath = arg_10_1
end

function RoleOffsetManager:getImagePath()
	return self._imagePath
end

function RoleOffsetManager:getBubblePath()
	return cc.FileUtils:getInstance():getWritablePath() .. "role_pos_offset/bubble.png"
end

function RoleOffsetManager:setImageAnchorPoint(arg_13_1)
	arg_13_1 = var_0_3(arg_13_1)

	local var_13_0 = var_0_2(arg_13_1.x)
	local var_13_1 = var_0_2(arg_13_1.y)

	if var_13_0 and var_13_1 then
		self._imageAnchorPoint.x = var_13_0
		self._imageAnchorPoint.y = var_13_1
	end
end

function RoleOffsetManager:getImageAnchorPoint()
	return self._imageAnchorPoint
end

function RoleOffsetManager:setRoleInitPos(arg_15_1)
	arg_15_1 = var_0_3(arg_15_1)

	local var_15_0 = var_0_2(arg_15_1.x)
	local var_15_1 = var_0_2(arg_15_1.y)

	if var_15_0 and var_15_1 then
		self._initPos.x = var_15_0
		self._initPos.y = var_15_1
	end
end

function RoleOffsetManager:getRoleOffset()
	return {
		x = var_0_4(self._curPos.x - self._initPos.x),
		y = var_0_4(self._curPos.y - self._initPos.y)
	}
end

function RoleOffsetManager:getBubbleOffset()
	return {
		x = var_0_4(self._bubbleCurPos.x - self._bubbleInitPos.x),
		y = var_0_4(self._bubbleCurPos.y - self._bubbleInitPos.y)
	}
end

function RoleOffsetManager:setImagePos(arg_18_1)
	arg_18_1 = var_0_3(arg_18_1)

	local var_18_0 = var_0_2(arg_18_1.x)
	local var_18_1 = var_0_2(arg_18_1.y)

	if var_18_0 and var_18_1 then
		self._curPos.x = var_18_0
		self._curPos.y = var_18_1
	end
end

function RoleOffsetManager:getImagePos()
	return self._curPos
end

function RoleOffsetManager:setBubbleInitPos(arg_20_1)
	arg_20_1 = var_0_3(arg_20_1)

	local var_20_0 = var_0_2(arg_20_1.x)
	local var_20_1 = var_0_2(arg_20_1.y)

	if var_20_0 and var_20_1 then
		self._bubbleInitPos.x = var_20_0
		self._bubbleInitPos.y = var_20_1
	end
end

function RoleOffsetManager:setBubblePos(arg_21_1)
	arg_21_1 = var_0_3(arg_21_1)

	local var_21_0 = var_0_2(arg_21_1.x)
	local var_21_1 = var_0_2(arg_21_1.y)

	if var_21_0 and var_21_1 then
		self._bubbleCurPos.x = var_21_0
		self._bubbleCurPos.y = var_21_1
	end
end

function RoleOffsetManager:getBubblePos()
	return self._bubbleCurPos
end

return RoleOffsetManager
