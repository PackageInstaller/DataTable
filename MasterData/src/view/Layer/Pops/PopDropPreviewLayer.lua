PopDropPreviewLayer = class("PopDropPreviewLayer", function()
	return PopBaseLayer:create()
end)

local drop_manager = require("controller.drop_manager")

function PopDropPreviewLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopDropPreviewLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopDropPreviewLayer:init(arg_3_1)
	local var_3_0 = ccui.Layout:create()

	var_3_0:setTouchEnabled(true)
	var_3_0:setContentSize(cc.size(640, GameDisplay.height))
	var_3_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_3_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_3_0:setBackGroundColorOpacity(200)
	var_3_0:setCascadeOpacityEnabled(false)
	var_3_0:setPositionY(-GameDisplay.fix_y)
	self:addChild(var_3_0)
	var_3_0:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_3_0:runAction(cc.RemoveSelf:create())
	end)

	local var_3_1 = 30
	local var_3_2 = ccui.ImageView:create("tilemap/pop_bg_tile.png")

	var_3_2:setPosition(cc.p(320, GameDisplay.height / 2))
	var_3_0:addChild(var_3_2)

	local var_3_3 = drop_manager:getEquipAllDrops(arg_3_1.dropid)
	local var_3_4 = ccui.ScrollView:create()

	var_3_4:setBounceEnabled(true)

	local var_3_5 = math.ceil(#var_3_3 / 3) * 225 < 700 and 700 or math.ceil(#var_3_3 / 3) * 225

	var_3_4:setInnerContainerSize(cc.size(560, var_3_5))
	var_3_4:setDirection(ccui.ScrollViewDir.vertical)
	var_3_4:setContentSize(cc.size(560, 700))
	var_3_4:setAnchorPoint(cc.p(0.5, 0))
	var_3_4:setPosition(340, 300 - var_3_1)
	var_3_0:addChild(var_3_4)

	for iter_3_0, iter_3_1 in ipairs(var_3_3) do
		local var_3_6 = ItemSprite:createNewWithItemId(iter_3_1.dropid)

		var_3_6:setAnchorPoint(cc.p(0, 0))
		var_3_6:setScale(0.8)
		var_3_6:setPosition(2 + (iter_3_0 - 1) % 3 * 189, var_3_5 - (math.floor((iter_3_0 - 1) / 3) + 1) * 200)
		var_3_4:addChild(var_3_6)
		var_3_6:setTouchEnabled(true)
		var_3_6:addSpriteTouchEventListener(function(arg_5_0, arg_5_1)
			if arg_5_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_5_0:getLocation().y - arg_5_0:getStartLocation().y) > 50 then
				return
			end

			PopLayer:Item({
				hideGainButton = true,
				itemid = iter_3_1.dropid
			})
		end)
	end
end
