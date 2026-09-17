local var_0_0 = config._DEBUG and 0 or 1
local var_0_1 = 291

LineSprite = class("LineSprite", function(arg_1_0)
	return ccui.ImageView:create(("ActivityMusicalNotesLayer_" .. arg_1_0.activityId .. "/") .. "line.png", var_0_0)
end)

function LineSprite.create(arg_2_0, arg_2_1)
	local var_2_0 = LineSprite.new(arg_2_1)

	var_2_0:init(arg_2_1)

	return var_2_0
end

function LineSprite:init(arg_3_1)
	self.max_line_length = arg_3_1.max_line_length

	self:setAnchorPoint(0.5, 0.5)
	self:initData(arg_3_1)
end

function LineSprite.initData(arg_4_0, arg_4_1)
	arg_4_0.activityId = arg_4_1.activityId
	arg_4_0.startNode = arg_4_1.startNode
	arg_4_0.endNode = nil
end

function LineSprite.resetData(arg_5_0)
	arg_5_0.startNode = nil
	arg_5_0.endNode = nil
end

function LineSprite.setStartNode(arg_6_0, arg_6_1)
	arg_6_0.startNode = arg_6_1
end

function LineSprite.setEndNode(arg_7_0, arg_7_1)
	arg_7_0.endNode = arg_7_1
end

function LineSprite:drawLine(arg_8_1, arg_8_2)
	local var_8_0 = cc.pSub(arg_8_1, arg_8_2)
	local var_8_1 = cc.p((arg_8_1.x + arg_8_2.x) / 2, (arg_8_1.y + arg_8_2.y) / 2)

	self:setPosition((cc.p(math.floor(var_8_1.x), math.floor(var_8_1.y))))
	self:setRotation(-math.deg(math.atan2(var_8_0.y, var_8_0.x)))
	self:setScaleX(cc.pGetLength(var_8_0) / var_0_1)
end

function LineSprite:updateUIFrame()
	if not self.startNode or not self.endNode then
		return
	end

	local var_9_0 = self.startNode:getContentSize()
	local var_9_1 = self.endNode:getContentSize()

	self:drawLine(cc.p(self.startNode:getPositionX() + var_9_0.width / 2, self.startNode:getPositionY() + var_9_0.height / 2), (cc.p(self.endNode:getPositionX() + var_9_1.width / 2, self.endNode:getPositionY() + var_9_1.height / 2)))
end

function LineSprite:updateTouch(arg_10_1)
	if not self.startNode then
		return
	end

	arg_10_1 = self:getMaxLenghtPos(arg_10_1)

	local var_10_0 = self.startNode:getContentSize()

	self:drawLine(cc.p(self.startNode:getPositionX() + var_10_0.width / 2, self.startNode:getPositionY() + var_10_0.height / 2), arg_10_1)
end

function LineSprite:getMaxLenghtPos(arg_11_1)
	local var_11_0 = self.startNode:getContentSize()
	local var_11_1 = cc.p(self.startNode:getPositionX() + var_11_0.width / 2, self.startNode:getPositionY() + var_11_0.height / 2)
	local var_11_2 = cc.pSub(arg_11_1, var_11_1)

	if cc.pGetLength(var_11_2) <= self.max_line_length then
		return arg_11_1
	end

	local var_11_3 = cc.pNormalize(var_11_2)

	return cc.p(var_11_1.x + var_11_3.x * self.max_line_length, var_11_1.y + var_11_3.y * self.max_line_length)
end
