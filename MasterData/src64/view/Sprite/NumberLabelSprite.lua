require("Cocos2d")
require("Cocos2dConstants")

local var_0_0 = 0
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 1
local var_0_4 = {}

local function var_0_5(arg_1_0)
	local var_1_0
	local var_1_1 = arg_1_0

	if arg_1_0 < 0 then
		arg_1_0 = -1 * arg_1_0
	end

	local var_1_2 = 10000

	var_1_0 = arg_1_0 < 10000 and "" .. arg_1_0 or arg_1_0 < var_1_2 * var_1_2 and (arg_1_0 / var_1_2 < 10 and string.format("%1.2fK", arg_1_0 / var_1_2) or arg_1_0 / var_1_2 < 100 and string.format("%2.1fK", arg_1_0 / var_1_2) or string.format("%dK", arg_1_0 / var_1_2)) or arg_1_0 < var_1_2 * var_1_2 * var_1_2 and (arg_1_0 / (var_1_2 * var_1_2) < 10 and string.format("%1.2fM", arg_1_0 / (var_1_2 * var_1_2)) or arg_1_0 / (var_1_2 * var_1_2) < 100 and string.format("%2.1fM", arg_1_0 / (var_1_2 * var_1_2)) or string.format("%dM", arg_1_0 / (var_1_2 * var_1_2))) or string.format("%dG", arg_1_0 / (var_1_2 * var_1_2 * var_1_2))

	if var_1_1 < 0 then
		var_1_0 = "" .. var_1_0
	elseif var_1_1 > 0 then
		var_1_0 = "" .. var_1_0
	end

	return var_1_0
end

function var_0_4:hitNumber(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7, arg_2_8, arg_2_9, arg_2_10, arg_2_11, arg_2_12)
	local var_2_0
	local var_2_1

	if arg_2_5 then
		var_2_0 = 2
		var_2_1 = "crit"
	elseif arg_2_6 then
		var_2_0 = 3
		var_2_1 = "miss"
	elseif arg_2_7 then
		var_2_0 = 1
		var_2_1 = "addhurt"
	elseif arg_2_12 then
		var_2_0 = 8
		var_2_1 = "blind"
	elseif arg_2_11 == 9 then
		var_2_0 = 9
	elseif arg_2_11 == 10 then
		var_2_0 = 10
	elseif arg_2_11 == 11 then
		var_2_0 = 11
	elseif arg_2_4 > 0 then
		var_2_0 = 7
	elseif arg_2_4 < 0 then
		var_2_0 = 6
	end

	self:hitNumberNew(arg_2_1, arg_2_2, arg_2_3, arg_2_4, var_2_1, var_2_0, arg_2_10, arg_2_11, arg_2_8)
end

function var_0_4.hitNumberNew(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7, arg_3_8, arg_3_9)
	if not arg_3_6 then
		return
	end

	local var_3_0 = GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT
	local var_3_1 = {
		L1 = 317 + var_3_0 / 3,
		L2 = 450 + var_3_0 / 3,
		L3 = 500 + var_3_0 / 3
	}
	local var_3_2 = {
		L1 = var_3_0 / 3 + 10,
		L2 = 30 + var_3_0 / 3,
		L3 = 50 + var_3_0 / 3
	}

	if arg_3_2 == nil then
		arg_3_2 = 0
	end

	if arg_3_3 == nil then
		arg_3_3 = 0
	end

	local var_3_4
	local var_3_5
	local var_3_6 = arg_3_7
	local var_3_7
	local var_3_8 = 0
	local var_3_10
	local var_3_11 = 1
	local var_3_12 = arg_3_5
	local var_3_13 = arg_3_6

	if arg_3_6 == 6 or var_3_13 == 7 then
		if arg_3_8 == 1 then
			var_3_13 = 6
		elseif arg_3_8 == 2 or arg_3_8 == 3 then
			var_3_13 = 4
		end
	end

	if arg_3_8 == 4 then
		var_3_13 = 7
	end

	if arg_3_4 and arg_3_4 ~= 0 then
		if var_3_13 == 1 then
			if var_3_6 == "enemy" then
				var_3_7 = "fonts/stormNumber1.fnt"
				var_3_12 = "addhurt"
			else
				var_3_7 = "fonts/stormNumber2.fnt"
				var_3_12 = "addhurt1"
			end
		elseif var_3_13 == 2 then
			if var_3_6 == "enemy" then
				var_3_7 = "fonts/critNumber1.fnt"
				var_3_12 = "crit"
			else
				var_3_7 = "fonts/critNumber2.fnt"
				var_3_12 = "crit1"
			end
		elseif var_3_13 == 3 then
			if var_3_6 == "enemy" then
				var_3_7 = "fonts/dodgeNumber1.fnt"
				var_3_12 = "miss"
			else
				var_3_7 = "fonts/dodgeNumber2.fnt"
				var_3_12 = "miss1"
			end
		elseif var_3_13 == 4 then
			var_3_7 = var_3_6 == "enemy" and "fonts/hitNumber1.fnt" or "fonts/hitNumber1.fnt"
		elseif var_3_13 == 5 then
			-- block empty
		elseif var_3_13 == 6 then
			var_3_7 = var_3_6 == "enemy" and "fonts/hitNumber1.fnt" or "fonts/hitNumber1.fnt"
		elseif var_3_13 == 7 then
			var_3_7 = var_3_6 == "player" and "fonts/treatmentNumber1.fnt" or "fonts/treatmentNumber1.fnt"
		elseif var_3_13 == 8 then
			var_3_7 = nil
		elseif var_3_13 == 9 or var_3_13 == 10 or var_3_13 == 11 then
			var_3_7 = var_3_6 == "enemy" and "fonts/energydamage1.fnt" or "fonts/energydamage1.fnt"
		end

		var_3_10 = var_0_5(arg_3_4)
	else
		var_3_7 = nil
	end

	if arg_3_9 == 1 then
		var_3_12 = "counter"
	elseif arg_3_9 == 2 then
		var_3_12 = "countered"
	end

	local var_3_14 = ccui.Layout:create()

	var_3_14:setContentSize(cc.size(1, 1))
	var_3_14:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_3_14:setAnchorPoint(0.5, 0.5)

	if var_3_12 then
		var_3_4 = config._DEBUG and cc.Sprite:create("fight/" .. var_3_12 .. ".png") or cc.Sprite:createWithSpriteFrameName("fight/" .. var_3_12 .. ".png")

		var_3_4:setPosition(cc.p(0, 10))
		var_3_14:addChild(var_3_4, 10)

		if var_3_7 then
			var_3_5 = ccui.TextBMFont:create(var_3_10, var_3_7)

			var_3_5:setPosition(cc.p(0, 10))
			var_3_5:setAnchorPoint(cc.p(0, 0.5))
			var_3_14:addChild(var_3_5, 10)
			var_3_4:setPositionX(-var_3_4:getContentSize().width / 2)
		end
	elseif var_3_7 then
		var_3_5 = ccui.TextBMFont:create(var_3_10, var_3_7)

		var_3_5:setAnchorPoint(cc.p(0, 0.5))
		var_3_5:setPosition(cc.p(-var_3_5:getContentSize().width / 2, 10))
		var_3_14:addChild(var_3_5, 10)
	end

	if var_3_13 >= 1 and var_3_13 <= 3 then
		arg_3_3 = arg_3_3 + var_3_2.L3
		var_3_11 = 1
		var_3_8 = var_0_1

		if arg_3_3 + var_0_1 > var_3_1.L3 + 100 then
			var_0_1 = 0
		end

		var_0_1 = var_0_1 + 25
		var_0_3 = -1 * var_0_3
	elseif var_3_13 >= 4 and var_3_13 <= 5 then
		arg_3_3 = arg_3_3 + var_3_2.L2
		var_3_11 = 0.8
		var_3_8 = var_0_1

		if arg_3_3 + var_0_1 > var_3_1.L2 + 100 then
			var_0_1 = 0
		end

		var_0_1 = var_0_1 + 22
		var_0_3 = -1 * var_0_3
	elseif var_3_13 == 8 then
		arg_3_3 = arg_3_3 + var_3_2.L1
		var_3_8 = var_0_0

		if arg_3_3 + var_0_0 > var_3_1.L1 + 100 then
			var_0_0 = 2
		end

		var_0_0 = var_0_0 + 11
		var_0_2 = -1 * var_0_2
		var_3_11 = 1
	elseif var_3_13 == 9 then
		arg_3_3 = arg_3_3 + var_3_2.L1
		var_3_8 = var_0_0

		if arg_3_3 + var_0_0 > var_3_1.L1 + 100 then
			var_0_0 = 2
		end

		var_0_0 = var_0_0 + 11
		var_0_2 = -1 * var_0_2
		var_3_11 = 0.6
	elseif var_3_13 == 10 then
		arg_3_3 = arg_3_3 + var_3_2.L1
		var_3_8 = var_0_0

		if arg_3_3 + var_0_0 > var_3_1.L1 + 100 then
			var_0_0 = 2
		end

		var_0_0 = var_0_0 + 11
		var_0_2 = -1 * var_0_2
		var_3_11 = 0.7
	elseif var_3_13 == 11 then
		arg_3_3 = arg_3_3 + var_3_2.L1
		var_3_8 = var_0_0

		if arg_3_3 + var_0_0 > var_3_1.L1 + 100 then
			var_0_0 = 2
		end

		var_0_0 = var_0_0 + 11
		var_0_2 = -1 * var_0_2
		var_3_11 = 1
	else
		arg_3_3 = arg_3_3 + var_3_2.L1
		var_3_8 = var_0_0

		if arg_3_3 + var_0_0 > var_3_1.L1 + 100 then
			var_0_0 = 2
		end

		var_0_0 = var_0_0 + 11
		var_0_2 = -1 * var_0_2
		var_3_11 = 0.7
	end

	var_3_14:setPosition(arg_3_2, arg_3_3 + var_3_8)

	if var_3_13 == 5 then
		var_3_14:setScale(0.6)
	else
		var_3_14:setScale(var_3_11)
	end

	arg_3_1:addChild(var_3_14, 9999)

	local var_3_22 = cc.RemoveSelf:create()
	local var_3_23 = cc.CallFunc:create(function()
		var_0_1 = 0
	end)
	local var_3_24 = cc.MoveBy:create(0.30000000000000004, cc.p(0, 30))
	local var_3_25 = cc.Spawn:create(cc.MoveBy:create(0.2, cc.p(0, 20)), cc.FadeOut:create(0.2))
	local var_3_26 = 1
	local var_3_27 = cc.Sequence:create(cc.ScaleTo:create(0.1, 1.5 * var_3_11), cc.ScaleTo:create(0.13333333333333333, 1 * var_3_11), cc.DelayTime:create(0.8333333333333334))
	local var_3_28 = cc.Sequence:create(cc.FadeTo:create(0.06666666666666667, 153))

	if var_3_13 >= 1 and var_3_13 <= 3 then
		var_3_14:runAction(cc.Sequence:create(var_3_27, var_3_28, var_3_23, var_3_22))
	elseif var_3_13 >= 4 and var_3_13 <= 5 then
		if var_3_13 == 5 then
			var_3_14:runAction(cc.Sequence:create(cc.Sequence:create(cc.ScaleTo:create(0.06666666666666667, 1.5 * var_3_11), cc.ScaleTo:create(0.06666666666666667, 1.2 * var_3_11), cc.DelayTime:create(0.21666666666666667), cc.ScaleTo:create(0.03333333333333333, 0.6 * var_3_11)), cc.Spawn:create(cc.ScaleTo:create(0.06666666666666667, 0.6 * var_3_11), cc.FadeTo:create(0.06666666666666667, 153)), var_3_23, var_3_22))
		else
			var_3_14:runAction(cc.Sequence:create(var_3_27, var_3_28, var_3_23, var_3_22))
		end
	else
		var_3_14:runAction(cc.Spawn:create(cc.Sequence:create(cc.DelayTime:create(0.13333333333333333 * 1), cc.MoveBy:create(0.8666666666666667, cc.p(0, 60))), cc.Sequence:create(cc.FadeIn:create(0.1 * 1), cc.DelayTime:create(0.13333333333333333), cc.FadeOut:create(0.7666666666666667), cc.CallFunc:create(function()
			var_0_0 = 0
		end), cc.RemoveSelf:create()), cc.Sequence:create(cc.ScaleTo:create(0.03333333333333333 * 1, 1.3), cc.ScaleTo:create(0.06666666666666667 * 1, 0.8 * var_3_11), cc.ScaleTo:create(0.06666666666666667 * 1, var_3_11)), (cc.CallFunc:create(function()
			if var_3_4 then
				var_3_4:runAction(cc.Sequence:create(cc.FadeIn:create(0.1 * var_3_26), cc.DelayTime:create(0.13333333333333333), cc.FadeOut:create(0.7666666666666667), cc.RemoveSelf:create()))
			end

			if var_3_5 then
				var_3_5:runAction(cc.Sequence:create(cc.FadeIn:create(0.1 * var_3_26), cc.DelayTime:create(0.13333333333333333), cc.FadeOut:create(0.7666666666666667), cc.RemoveSelf:create()))
			end
		end))))
	end
end

return var_0_4
