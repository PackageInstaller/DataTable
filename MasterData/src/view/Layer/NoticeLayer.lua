local var_0_0

NoticeLayer = class("NoticeLayer", function()
	return cc.Layer:create()
end)

function NoticeLayer.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = NoticeLayer.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4)

	return var_2_0
end

function NoticeLayer:deleteSelf()
	local var_3_0 = cc.Director:getInstance():getVisibleSize()

	endBg = ccui.Button:create("levelScene/grayBg.png", "levelScene/grayBg.png")

	endBg:setPosition(cc.p(var_3_0.width / 2, var_3_0.height / 2))
	endBg:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 == ccui.TouchEventType.ended then
			cc.SimpleAudioEngine:getInstance():playEffect("sound/button.mp3")
			self:runAction(cc.Sequence:create(cc.DelayTime:create(1), CCEaseElasticInOut:create(cc.ScaleTo:create(0.5, 0)), cc.RemoveSelf:create(true)))
		end
	end)
	self:addChild(endBg, -1)

	local var_3_1 = cc.Label:create()

	var_3_1:setString("Click anywhere to enter the main scene!")
	var_3_1:setSystemFontSize(25)
	var_3_1:setPosition(cc.p(var_3_0.width / 2, var_3_0.height / 2 - 240))
	self:addChild(var_3_1, 1, 3)
end

function NoticeLayer.dateToSecond(arg_5_0, arg_5_1)
	local function var_5_0(arg_6_0, arg_6_1)
		local var_6_0 = {}
		local var_6_1 = "(.-)" .. arg_6_1
		local var_6_2 = 1
		local var_6_3, var_6_4, var_6_5 = arg_6_0:find("(.-)" .. arg_6_1, 1)

		while var_6_3 do
			if var_6_3 ~= 1 or var_6_5 ~= "" then
				table.insert(var_6_0, var_6_5)
			end

			var_6_2 = var_6_4 + 1
			var_6_3, var_6_4, var_6_5 = arg_6_0:find(var_6_1, var_6_4 + 1)
		end

		if var_6_2 <= #arg_6_0 then
			table.insert(var_6_0, (arg_6_0:sub(var_6_2)))
		end

		return var_6_0
	end

	local var_5_1 = var_5_0(arg_5_1, " ")
	local var_5_2 = var_5_0(var_5_1[1], "-")
	local var_5_3 = var_5_0(var_5_1[2], ":")

	return os.time({
		year = var_5_2[1],
		month = var_5_2[2],
		day = var_5_2[3],
		hour = var_5_3[1],
		min = var_5_3[2],
		sec = var_5_3[3]
	}) >= os.time()
end

function NoticeLayer:init(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	var_0_0 = ccui.ScrollView:create()

	var_0_0:setAnchorPoint(cc.p(0, 0))
	var_0_0:setContentSize(cc.size(1136 * arg_7_3 - 10, 550 * arg_7_4))
	var_0_0:setDirection(1)
	var_0_0:setInnerContainerSize(cc.size(1136 * arg_7_3 - 10, 700 * arg_7_4))
	var_0_0:setBounceEnabled(true)
	var_0_0:setPosition(cc.p(1136 * (1 - arg_7_3) / 2, 640 * (1 - arg_7_4) / 2))

	local var_7_0 = cc.Director:getInstance()
	local var_7_1 = var_7_0:getVisibleSize()
	local var_7_2 = cc.Sprite:create("ui/replace.png")

	var_7_2.setPosition(var_7_0, cc.p(var_7_1.width / 2, var_7_1.height / 2))
	var_7_2:setScaleX(arg_7_3)
	var_7_2:setScaleY(arg_7_4)
	var_7_2:setOpacity(120)
	self:addChild(var_7_2, 0, 0)

	local var_7_3 = cc.Label:create()

	var_7_3:setString(arg_7_1)
	var_7_3:setScale(2)
	var_7_3:setPosition(cc.p(var_7_1.width / 2, var_7_1.height / 2 + var_7_1.height * arg_7_4 / 2 - 20))
	self:addChild(var_7_3, 1, 1)

	local var_7_4 = cc.Label:createWithSystemFont(arg_7_2, "Arial", 20, cc.size(1136 * arg_7_3 * 0.9 - 10, 700 * arg_7_4), cc.TEXT_ALIGNMENT_LEFT, cc.VERTICAL_TEXT_ALIGNMENT_TOP)

	var_7_4:setAnchorPoint(cc.p(0.5, 1))
	var_7_4:setPosition(cc.p(var_7_1.width * arg_7_3 * 0.5, 700 * arg_7_4))
	var_0_0:addChild(var_7_4, 2, 2)
	self:addChild(var_0_0, 1)
	self:deleteSelf()
end
