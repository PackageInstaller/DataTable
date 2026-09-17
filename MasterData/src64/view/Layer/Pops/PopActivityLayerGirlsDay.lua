PopActivityLayerGirlsDay = class("PopActivityLayerGirlsDay", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")

local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")

function PopActivityLayerGirlsDay.create(arg_2_0, arg_2_1)
	local var_2_0 = PopActivityLayerGirlsDay.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopActivityLayerGirlsDay:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ActivityLayer_GirlsDay.json" or "ActivityLayer_GirlsDay.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "bg_img")

	self.rootpanel:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2))
	self.rootpanel:setScaleY(0)
	self.rootpanel:setTouchEnabled(false)
	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_4_0:isBright() then
			return
		end

		arg_4_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			if self.exitcallback then
				self.exitcallback(0)
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 80)
	self.showActions.extendVertical(self)
	self:initUI()
end

function PopActivityLayerGirlsDay:initUI()
	self.shop_btn = ccui.Helper:seekWidgetByName(self.rootLayer, "shop_btn")

	self.shop_btn:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_7_0 = cc.EventCustom:new("switchShowLayer")

		var_7_0.layerName = "MarketLayer"
		var_7_0.initparam = {
			showType = "1-502",
			returnLayer = "MainLayer",
			singleMarket = {
				"1-501",
				"1-502",
				"1-2",
				"1-503",
				"1-504",
				"1-505",
				"1-506",
				"1-507"
			}
		}

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_7_0)
	end)
end

function PopActivityLayerGirlsDay:exit()
	self.hideActions.shrinkVertical(self, function()
		if self.exitcallback then
			self.exitcallback(0)
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopActivityLayerGirlsDay:initBg(arg_10_1)
	local var_10_0 = ccui.Layout:create()

	var_10_0:setTouchEnabled(true)
	var_10_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_10_0:setAnchorPoint(cc.p(0, 0))
	var_10_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_10_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_10_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_10_0:setOpacity(0)
	var_10_0:setCascadeOpacityEnabled(false)
	self:addChild(var_10_0, -1)

	local var_10_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_10_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_10_1:setPositionX(var_10_0:getContentSize().width / 2)
	var_10_1:setPositionY(var_10_0:getContentSize().height / 2)
	var_10_0:addChild(var_10_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_11_0)
		self:addChild(arg_11_0, -2)
		arg_11_0:setPositionY(arg_11_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_10_1)
		var_10_0:setOpacity(102)
		var_10_0:setTouchEnabled(false)
	end)
end
