PopRodInfoLayer = class("PopRodInfoLayer", function(arg_1_0)
	return PopBaseLayer:create(arg_1_0)
end)

local time_check_manager = require("controller.time_check_manager")
local discount_manager = require("controller.discount_manager")
local item_data = require("data.item_data")
local var_0_3 = config._DEBUG and 0 or 1

function PopRodInfoLayer.create(arg_2_0)
	local var_2_0 = PopRodInfoLayer.new()

	var_2_0:initBg()

	return var_2_0
end

function PopRodInfoLayer:initBg()
	local var_3_0 = ccui.Layout:create()

	var_3_0:setTouchEnabled(true)
	var_3_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_3_0:setAnchorPoint(cc.p(0, 0))
	var_3_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_3_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_3_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_3_0:setOpacity(0)
	self:addChild(var_3_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_4_0)
		self:addChild(arg_4_0, -2)
		arg_4_0:setPositionY(arg_4_0:getPositionY() - GameDisplay.fix_y)

		local var_4_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_4_0:setAnchorPoint(cc.p(0, 0))
		var_4_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_4_0, -1)
		self:init(msg, initInfo)
		var_3_0:setOpacity(102)
		var_3_0:setTouchEnabled(false)
	end)
end

function PopRodInfoLayer:init(arg_5_1)
	print("open poplayer : PopRodInfoLayer")

	self.rootLayer = cc.Layer:create()

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 1)

	self.openNum = 0

	self:initUI()
	self:playJoinEffect()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			-- block empty
		end
	end)
end

function PopRodInfoLayer:initUI()
	self.rootpanel = ccui.ImageView:create("public/panelbg/bg_skill_rob.png", var_0_3)

	self.rootpanel:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2)
	self.rootpanel:setName("bottom_bg")
	self.rootLayer:addChild(self.rootpanel)

	local var_7_0 = cc.Label:createWithTTF(L_ROD_INFO_POP, FONT_NAME, 20)

	var_7_0:setColor(cc.c3b(255, 238, 253))
	var_7_0:setAnchorPoint(cc.p(1, 0.5))
	var_7_0:setPosition(cc.p(530, 620))
	self.rootpanel:addChild(var_7_0)
	self:initCobView()
	LayerManager:createFullScreenMask(self, 0, function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_8_0:isBright() then
			return
		end

		arg_8_0:setBright(false)
		self:exit()
	end)
end

function PopRodInfoLayer:playJoinEffect()
	self.rootLayer:setScaleY(0.1)
	self.rootLayer:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 1)))
end

function PopRodInfoLayer:initCobView()
	local var_10_0 = discount_manager:getAllMyCoupons()

	if not var_10_0 or not next(var_10_0) then
		local var_10_1 = cc.Label:createWithTTF(L_COB_NIL, FONT_NAME, 48)

		var_10_1:setPosition(cc.p(290, self.rootpanel:getContentSize().height / 2 - 10))
		self.rootpanel:addChild(var_10_1)

		return
	end

	local var_10_2 = 1

	self.robView = ccui.ScrollView:create()

	self.robView:setBounceEnabled(true)
	self.robView:setName("rob_view")
	self.robView:setAnchorPoint(cc.p(0.5, 0.5))
	self.robView:setPositionX(self.rootpanel:getContentSize().width / 2 + 20)
	self.robView:setPositionY(self.rootpanel:getContentSize().height / 2 - 50)
	self.robView:setInnerContainerSize(cc.size(572, 166 * (math.floor((#var_10_0 - 1) / 2) + 1)))
	self.robView:setContentSize(cc.size(572, 560))

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		local var_10_3 = self:createRobSprite(iter_10_1)

		var_10_3:setPosition(cc.p((var_10_2 + 1) % 2 * 254 + 140, self.robView:getInnerContainerSize().height - math.floor((var_10_2 - 1) / 2) * 166 - 80))
		self.robView:addChild(var_10_3)

		var_10_2 = var_10_2 + 1
	end

	self.rootpanel:addChild(self.robView)
end

function PopRodInfoLayer.createRobSprite(arg_11_0, arg_11_1)
	local var_11_0 = ccui.ImageView:create("PopRodInfoLayer/sprite_bg.png", var_0_3)
	local var_11_1 = ccui.ImageView:create("equipment/" .. item_data[arg_11_1.id].image_id .. ".png")

	var_11_1:setPosition(cc.p(var_11_0:getContentSize().width / 2, var_11_0:getContentSize().height / 2))
	var_11_0:addChild(var_11_1)
	var_11_1:setTouchEnabled(true)
	var_11_1:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		showItemDetails(arg_11_1.id)
	end)

	local var_11_2 = cc.Label:createWithTTF("X" .. arg_11_1.num, FONT_NAME, 16)

	var_11_2:setColor(cc.c3b(0, 255, 204))
	var_11_2:setPosition(cc.p(var_11_0:getContentSize().width - 25, 17))
	var_11_0:addChild(var_11_2)

	return var_11_0
end

function PopRodInfoLayer:exit()
	self.rootLayer:setCascadeOpacityEnabled(true)
	self.rootLayer:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0.1), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end
