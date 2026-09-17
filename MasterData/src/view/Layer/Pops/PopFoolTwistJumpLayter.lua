PopFoolTwistJumpLayter = class("PopFoolTwistJumpLayter", function()
	return PopBaseLayer:create()
end)

local var_0_0 = 171
local var_0_1 = 3
local var_0_2 = "PopFoolTwistJumpLayter/btn_%d_%d.png"
local item_data = require("data.item_data")
local item_manager = require("controller.item_manager")
local activity_main_conf = require("data.activity_modules.activity_main_conf")
local activity_manager = require("controller.activity_manager")
local var_0_7 = config._DEBUG and 0 or 1

function PopFoolTwistJumpLayter.create(arg_2_0, arg_2_1)
	local var_2_0 = PopFoolTwistJumpLayter.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopFoolTwistJumpLayter:init(arg_3_1)
	print("open poplayer : PopFoolTwistJumpLayter")

	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:setContentSize(cc.Director:getInstance():getVisibleSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
	self:addChild(self.rootLayer, 10)

	self.initparam = arg_3_1 or {}

	self:initUI()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			-- block empty
		end
	end)
end

function PopFoolTwistJumpLayter:initUI()
	self:initBtns()
	self:playJoinInEffect()
end

local var_0_8 = {
	[171] = {
		function(arg_6_0, arg_6_1)
			LayerManager:switchShowLayer("FightLayer")
		end,
		function(arg_7_0, arg_7_1)
			LayerManager:switchShowLayer("MarketLayer", {
				singleMarket = "1-17101"
			})
		end,
		function(arg_8_0, arg_8_1)
			LayerManager:removePopLayer()
			LayerManager:pushInLayer("PopDoLayer", arg_8_0.popmsg)
		end
	}
}

function PopFoolTwistJumpLayter:initBtns()
	for iter_9_0 = 1, var_0_1 do
		local var_9_0 = string.format(var_0_2, var_0_0, iter_9_0)
		local var_9_1 = ccui.Button:create(var_9_0, var_9_0, var_9_0, var_0_7)

		var_9_1:setPosition(cc.p(320, GameDisplay.height * 0.9 - 230 * iter_9_0))
		self.rootLayer:addChild(var_9_1)

		if self.initparam[iter_9_0] then
			var_9_1.popmsg = self.initparam[iter_9_0].popmsg or nil
		end

		var_9_1:addTouchEventListener(function(arg_10_0, arg_10_1)
			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_0_8[var_0_0][iter_9_0](arg_10_0, arg_10_1)
		end)
	end

	self.rootLayer:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)
end

function PopFoolTwistJumpLayter:playJoinInEffect()
	self.rootLayer:setOpacity(0)
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeIn:create(0.2)))
end

function PopFoolTwistJumpLayter:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopFoolTwistJumpLayter:initBg(arg_15_1)
	local var_15_0 = ccui.Layout:create()

	var_15_0:setTouchEnabled(true)
	var_15_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_15_0:setAnchorPoint(cc.p(0, 0))
	var_15_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_15_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_15_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_15_0:setOpacity(0)
	self:addChild(var_15_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_16_0)
		self:addChild(arg_16_0, -2)
		arg_16_0:setPositionY(arg_16_0:getPositionY() - GameDisplay.fix_y)

		local var_16_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_16_0:setAnchorPoint(cc.p(0, 0))
		var_16_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_16_0, -1)
		self:init(arg_15_1)
		var_15_0:setOpacity(102)
		var_15_0:setTouchEnabled(false)
	end)
end
