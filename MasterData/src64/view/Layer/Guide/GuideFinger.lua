GuideFinger = class("GuideFinger", function()
	return cc.Node:create()
end)

local var_0_0 = "Guide/guide_finger.png"

function GuideFinger.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = GuideFinger.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3)

	return var_2_0
end

function GuideFinger:init(arg_3_1, arg_3_2, arg_3_3)
	self._basepos = arg_3_1
	self._rect = arg_3_2

	self:initFinger()

	if arg_3_3 then
		self:initCircle()
	end
end

function GuideFinger:initFinger()
	local var_4_0

	if config._DEBUG then
		var_4_0 = cc.Sprite:create(var_0_0) or cc.Sprite:createWithSpriteFrameName(var_0_0)
	end

	self:addChild(var_4_0, 5)

	local var_4_1 = false
	local var_4_2 = 0
	local var_4_3 = 0
	local var_4_4 = math.min(30, self._rect.width / 5)
	local var_4_5 = -1 * math.min(30, self._rect.height / 5)
	local var_4_6 = 10
	local var_4_7 = -10

	if self._basepos.y <= var_4_0:getContentSize().height then
		var_4_3 = -90
		var_4_7 = -1 * var_4_7
		var_4_5 = -1 * var_4_5
	end

	if self._basepos.x >= 640 - var_4_0:getContentSize().width then
		var_4_1 = true
		var_4_2 = 1
		var_4_3 = -1 * var_4_3
		var_4_6 = -1 * var_4_6
		var_4_4 = -1 * var_4_4
	end

	var_4_0:setRotation(var_4_3)
	var_4_0:setAnchorPoint(cc.p(var_4_2, 1))
	var_4_0:setFlippedX(var_4_1)
	var_4_0:setPosition(cc.p(self._basepos.x + var_4_4, self._basepos.y + var_4_5))
	var_4_0:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0.1), cc.MoveBy:create(0.3, cc.p(var_4_6, var_4_7)), cc.MoveBy:create(0.3, cc.p(-1 * var_4_6, -1 * var_4_7)))))
end

function GuideFinger:initCircle()
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("effect/guide/02-zhiyindonghua.ExportJson")

	local var_5_0 = ccs.Armature:create("02-zhiyindonghua")

	var_5_0:setPosition(self._basepos)
	self:addChild(var_5_0, 1)
	var_5_0:getAnimation():play("Animation1")
end
