GoldSprite = class("GoldSprite", function()
	return cc.Sprite:create("mainScenebg/drop_gold.png")
end)

function GoldSprite.createGold(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = GoldSprite.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4)

	return var_2_0
end

function GoldSprite:init(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self:setVisible(false)
	self:setScale(0.8)
	self:setAnchorPoint(cc.p(0, 0))
	self:setPosition(cc.p(arg_3_1, arg_3_2 + 80))
	SmallFightLayer.getInstance().goldBatchNode:addChild(self, 0)
	self:registerFightManager()
	self:showgold(arg_3_4)
end

function GoldSprite.registerFightManager(arg_4_0)
	FightManager.golds[#FightManager.golds + 1] = arg_4_0
	arg_4_0.index = #FightManager.golds + 1
end

function GoldSprite:unregisterFightManager()
	if self.index then
		FightManager.golds[self.index] = nil
	end
end

function GoldSprite:showgold(arg_6_1)
	local var_6_0 = math.random(2, 8) * 20
	local var_6_1 = var_6_0
	local var_6_2 = math.tan(math.rad(30))
	local var_6_3
	local var_6_4
	local var_6_5

	if math.random() >= 0.5 then
		var_6_5 = 60
		var_6_3 = var_6_1 / 4
		var_6_4 = 3 * var_6_1 / 4
	else
		var_6_5 = -60
		var_6_1 = -var_6_1
		var_6_3 = var_6_1 / 4
		var_6_4 = 3 * var_6_1 / 4
	end

	self:runAction(cc.Sequence:create(cc.DelayTime:create(arg_6_1), cc.Show:create(), cc.BezierBy:create(0.4, {
		cc.p(var_6_3, var_6_0 + var_6_1 * var_6_2 / 2),
		cc.p(var_6_4, var_6_0),
		cc.p(var_6_1, -80)
	}), cc.JumpBy:create(0.2, cc.p(var_6_5 / 2, 0), 15, 1), cc.JumpBy:create(0.1, cc.p(var_6_5 / 4, 0), 5, 1)))
end

function GoldSprite:collect(arg_7_1)
	self:stopAllActions()
	self:runAction(cc.Sequence:create(cc.Spawn:create(cc.MoveTo:create(1, cc.p(310, 640 + GameDisplay.height - 1136)), cc.ScaleTo:create(1, 0.4)), cc.RemoveSelf:create(), cc.CallFunc:create(function()
		if arg_7_1 then
			arg_7_1()
		end
	end)))
	self:unregisterFightManager()
end

function GoldSprite:hide()
	self:runAction(cc.Sequence:create(cc.FadeOut:create(1), cc.RemoveSelf:create()))
	self:unregisterFightManager()
end

function GoldSprite:move(arg_10_1, arg_10_2)
	local var_10_0, var_10_1 = self:getPosition()

	self:setPosition(cc.p(var_10_0 + arg_10_1, var_10_1 + arg_10_2))
end
