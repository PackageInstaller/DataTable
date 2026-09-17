return {
	addBox = function(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
		local var_1_0 = cc.Node:create()

		var_1_0:setName("boxDialog")
		var_1_0:setAnchorPoint(cc.p(0, 1))
		var_1_0:setPosition(cc.p(arg_1_3, arg_1_4))
		arg_1_1:addChild(var_1_0, 100)

		local var_1_1 = cc.Label:createWithTTF("", FONT_DES, 24)

		var_1_1:setTextColor(cc.c4b(71, 75, 86, 255))
		var_1_1:setAnchorPoint(0, 0.5)
		var_1_1:setMaxLineWidth(357)
		var_1_1:setZOrder(10)
		var_1_1:setString(arg_1_2)

		local var_1_2

		if config._DEBUG then
			var_1_2 = cc.Scale9Sprite:create("public/talk/word_bg.png") or cc.Scale9Sprite:createWithSpriteFrameName("public/talk/word_bg.png")
		end

		var_1_2:setCapInsets(cc.rect(100, 50, 200, 20))
		var_1_0:addChild(var_1_2)
		var_1_2:addChild(var_1_1)

		local var_1_3 = var_1_1:getContentSize().width + 100
		local var_1_4 = var_1_1:getContentSize().height + 70

		var_1_3 = var_1_3 < 348 and 348 or var_1_3
		var_1_4 = var_1_4 < 132 and 132 or var_1_4

		var_1_2:setPreferredSize(cc.size(var_1_3, var_1_4))
		var_1_1:setPosition(cc.p(20, var_1_2:getContentSize().height / 2 - 20))
		var_1_1:setString("")

		local var_1_5 = math.floor(string.len(arg_1_2) / 3)

		var_1_0:runAction(cc.ActionFloat:create(var_1_5 * 0.01, 0, var_1_5, function(arg_2_0)
			var_1_1:setString((string.sub(arg_1_2, 0, math.floor(arg_2_0) * 3)))

			if arg_2_0 >= var_1_5 then
				if arg_1_6 then
					var_1_0:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(arg_1_6)))
				else
					var_1_0:runAction(cc.Sequence:create(cc.DelayTime:create(2 + var_1_5 * 0.05), cc.RemoveSelf:create(true)))
				end
			end
		end))

		return var_1_0
	end
}
