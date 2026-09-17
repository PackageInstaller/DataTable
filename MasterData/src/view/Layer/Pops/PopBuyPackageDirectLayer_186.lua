PopBuyPackageDirectLayer_186 = class("PopBuyPackageDirectLayer_186", function()
	return PopBaseLayer:create()
end)

local activity_manager = require("controller.activity_manager")
local drop_manager = require("controller.drop_manager")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local activity_buy_package_ui_conf_data = require("data.activity_flop.uiconfig.activity_buy_package_ui_conf_data")
local discount_manager = require("controller.discount_manager")
local recharge_manager = require("controller.recharge_manager")
local recharge_data = require("data.recharge_data")
local var_0_11
local network = require("network.network")

function PopBuyPackageDirectLayer_186.create(arg_2_0, arg_2_1)
	local var_2_0 = PopBuyPackageDirectLayer_186.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopBuyPackageDirectLayer_186:init(arg_3_1)
	var_0_11 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_package_buy.json" or "Pop_package_buy.ExportJson")

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.rootLayer:setTouchEnabled(false)
	self:addChild(self.rootLayer, 2)
	self:initAll(arg_3_1)
	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_4_0:isBright() then
			return
		end

		if arg_3_1.cancelCallback then
			arg_3_1.cancelCallback()
		end

		arg_4_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	self.rootpanel:setScaleY(0.1)
	self.rootpanel:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 1)))
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			popstarrewardlayerInstance = false

			if arg_3_1.updateCallback then
				arg_3_1.updateCallback()
			end
		end
	end)
end

local var_0_13 = {
	[SHOP_CURRENCY_GOLD] = "public/currency/UI_battleEnd_gold.png",
	[SHOP_CURRENCY_DIAMOND] = "equipment/1000000.png",
	[CURRENCY_DIAMOND_PAID] = "equipment/" .. item_data[CURRENCY_DIAMOND_PAID].image_id .. ".png"
}

setmetatable(var_0_13, {
	__index = function(arg_7_0, arg_7_1)
		return "equipment/" .. item_data[arg_7_1].image_id .. ".png"
	end
})

function PopBuyPackageDirectLayer_186:initAll(arg_8_1)
	self.currencyData = arg_8_1.currencyData
	self.limitData = arg_8_1.limitData
	self.id = arg_8_1.activityid
	self.uiconfType = arg_8_1.uiconf.id

	self:initEventListener()
	self:getParamFromUIConf()
	self:initTexture()
	self:initUI(arg_8_1)
end

function PopBuyPackageDirectLayer_186:initEventListener()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_10_0)
		LayerManager:removePopLayer(self.__queueindex)
	end), self)
end

function PopBuyPackageDirectLayer_186:getUIConf()
	return activity_buy_package_ui_conf_data[self.id .. "-" .. self.uiconfType]
end

function PopBuyPackageDirectLayer_186.getUIColor(arg_12_0, arg_12_1)
	return cc.c3b(arg_12_1[1], arg_12_1[2], arg_12_1[3])
end

function PopBuyPackageDirectLayer_186:getParamFromUIConf()
	self.defaultconf, self.uiconf = activity_buy_package_ui_conf_data["1-1"], self:getUIConf()
	self.path = "activitiesRes/activity" .. self.id .. self.uiconf.path
end

function PopBuyPackageDirectLayer_186:initTexture(arg_14_1)
	self.rootpanel = self.rootLayer:getChildByName("bg")

	self.rootpanel:loadTexture(self.path .. "buy_bg.png")
	self.rootpanel:setPositionX(GameDisplay.getScreenSize().width / 2 + self.uiconf.bg_offset.x or 0)
	self.rootpanel:setPositionY(GameDisplay.getScreenSize().height / 2 + self.uiconf.bg_offset.y or 0)
end

function PopBuyPackageDirectLayer_186:initUI(arg_15_1)
	while ccui.Helper:seekWidgetByName(self.rootLayer, "buy_type" .. 1) do
		local var_15_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "buy_type" .. 1)
		local var_15_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_buy" .. 1)
		local var_15_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "limit_" .. 1)

		var_15_0:loadTexture(self.path .. "buy_type" .. 1 .. ".png")

		local var_15_3 = var_15_1:getChildByName("label_price")

		var_15_1.index = 1
		var_15_1.limitNum = self.limitData[1].limitNum
		var_15_1.boughtNum = self.limitData[1].boughtNum
		var_15_0.index = 1
		var_15_0.limitNum = self.limitData[1].limitNum
		var_15_0.boughtNum = self.limitData[1].boughtNum

		if self.limitData[1].limitNum then
			var_15_2:setString(self.limitData[1].boughtNum .. "/" .. self.limitData[1].limitNum)
			var_15_2:setFontSize(self.uiconf.label_limit_size or self.defaultconf.label_limit_size)
			var_15_2:setColor(self:getUIColor(self.uiconf["label_limit_color_" .. 1] or self.defaultconf["label_limit_color_" .. 1]))
			var_15_2:setPositionX(self.uiconf.label_limit_offset.x)
			var_15_2:setPositionY(self.uiconf.label_limit_offset.y)
		end

		if self.limitData[1].limitNum and self.limitData[1].limitNum == self.limitData[1].boughtNum then
			var_15_1:loadTextures(self.path .. "btn_buy_out.png", self.path .. "btn_buy_out.png", self.path .. "btn_buy_out.png")
			var_15_3:setVisible(false)
		else
			var_15_1:loadTextures(self.path .. "btn_buy" .. 1 .. ".png", self.path .. "btn_buy" .. 1 .. ".png", self.path .. "btn_buy" .. 1 .. ".png")
			var_15_3:setString((self.limitData[1].rechargeid or nil) and string.format(L_MANKEY, recharge_data[self.limitData[1].rechargeid].rmb))
			var_15_3:setFontSize(self.uiconf.label_price_size or self.defaultconf.label_price_size)
			var_15_3:setPositionX(var_15_3:getPositionX() + (self.uiconf.label_price_offset.x or 0))
			var_15_3:setPositionY(var_15_3:getPositionY() + (self.uiconf.label_price_offset.y or 0))
			var_15_3:setColor(self:getUIColor(self.uiconf.label_price_color or self.defaultconf.label_price_color))
			var_15_3:setLocalZOrder(10)

			if self.uiconf.label_price_bottom_color then
				local var_15_6 = cc.Label:createWithTTF("X" .. self.currencyData[1].price, FONT_NAME, self.uiconf.label_price_size or self.defaultconf.label_price_size)

				var_15_6:setAnchorPoint(cc.p(1, 0.5))
				var_15_6:setColor(self:getUIColor(self.uiconf.label_price_bottom_color or cc.c3b(0, 0, 0)))
				var_15_6:setName("labelPriceBottom")
				var_15_6:setPositionX(var_15_3:getPositionX() + 2)
				var_15_6:setPositionY(var_15_3:getPositionY() - 2)
				var_15_1:addChild(var_15_6, 2)
				var_15_6:setVisible(self:getPriceLabelBottom())
			end

			if not self.limitData[1].rechargeid then
				local var_15_7 = ccui.ImageView:create(var_0_13[self.currencyData[1].currency])

				var_15_7:setName("currency_icon")
				var_15_7:setAnchorPoint(cc.p(0.5, 0.5))
				var_15_7:setScale(0.3)
				var_15_7:setPositionX(var_15_3:getPositionX() - var_15_3:getContentSize().width - 20)
				var_15_7:setPositionY(var_15_3:getPositionY())
				var_15_1:addChild(var_15_7)
			end

			var_15_1:addTouchEventListener(function(arg_16_0, arg_16_1)
				if arg_16_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_16_0.limitNum and arg_16_0.limitNum == arg_16_0.boughtNum then
					return
				end

				self:popGetKeyItem(arg_16_0.index, callback)
			end)
			var_15_0:setTouchEnabled(true)
			var_15_0:addTouchEventListener(function(arg_17_0, arg_17_1)
				if arg_17_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_17_0.limitNum and arg_17_0.limitNum == arg_17_0.boughtNum then
					return
				end

				self:popGetKeyItem(arg_17_0.index, callback)
			end)
		end

		var_15_0:setPositionX(self.uiconf["piece_" .. 1 .. "_offset"].x)
		var_15_0:setPositionY(self.uiconf["piece_" .. 1 .. "_offset"].y)
		var_15_1:setPositionX(self.uiconf.btn_offset.x)
		var_15_1:setPositionY(self.uiconf.btn_offset.y)
		print(var_15_1:getPosition())
		var_15_2:setPositionX(self.uiconf.label_limit_offset.x)
		var_15_2:setPositionY(self.uiconf.label_limit_offset.y)
	end

	self:updateUI()
end

function PopBuyPackageDirectLayer_186:updateUI()
	local var_18_0 = ccui.ImageView:create(self.path .. "buy_type4.png")

	var_18_0:setPosition(cc.p(285, 120))
	self.rootpanel:addChild(var_18_0)

	local var_18_1 = ccui.Button:create(self.path .. "btn_buy4.png")

	var_18_1:setPosition(cc.p(380, 45))
	var_18_0:addChild(var_18_1)

	local function var_18_2(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		goto_complete_system({
			jump_to_system = 1518607
		})
	end

	var_18_0:setTouchEnabled(true)
	var_18_1:addTouchEventListener(var_18_2)
	var_18_0:addTouchEventListener(var_18_2)
end

function PopBuyPackageDirectLayer_186:updateBtn(arg_20_1, arg_20_2)
	local var_20_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_buy" .. arg_20_2)
	local var_20_1 = var_20_0:getChildByName("labelPriceBottom")

	self.limitData[arg_20_2].boughtNum = arg_20_1.boughtNum
	var_20_0.boughtNum = arg_20_1.boughtNum
	ccui.Helper:seekWidgetByName(self.rootLayer, "buy_type" .. arg_20_2).boughtNum = arg_20_1.boughtNum

	ccui.Helper:seekWidgetByName(self.rootLayer, "limit_" .. arg_20_2):setString(self.limitData[arg_20_2].boughtNum .. "/" .. self.limitData[arg_20_2].limitNum)

	if self.limitData[arg_20_2].limitNum == self.limitData[arg_20_2].boughtNum then
		var_20_0:loadTextures(self.path .. "btn_buy_out.png", self.path .. "btn_buy_out.png", self.path .. "btn_buy_out.png")
		var_20_0:getChildByName("label_price"):setVisible(false)

		if var_20_1 then
			var_20_1:setVisible(false)
		end

		if var_20_0:getChildByName("currency_icon") then
			var_20_0:getChildByName("currency_icon"):setVisible(false)
		end
	end
end

function PopBuyPackageDirectLayer_186:getPriceLabelBottom()
	return not not self.uiconf.label_price_bottom_color
end

function PopBuyPackageDirectLayer_186:popGetKeyItem(arg_22_1, arg_22_2)
	if self.limitData[arg_22_1].rechargeid then
		local var_22_0 = self.limitData[arg_22_1].rechargeid

		network:rpc("check_recharge", {
			id = self.limitData[arg_22_1].rechargeid,
			client = config.clientmode
		}, function(arg_23_0)
			if arg_23_0.result == 1 then
				self.recharging = false

				AnalyticManager.clickPurchaseItem({
					product = id,
					rolenum = playermodel:getOwnedServantNum(),
					grade = playermodel.grade,
					class = playermodel.class
				})
				recharge_manager:confirmPayment(var_22_0)
			elseif arg_23_0.result == 2 then
				print("测试模式")
			elseif arg_23_0.result == 3 then
				global_ShowBlockWords(L_RECAHRGE_GOODS_UNAVAILABLE)
			elseif arg_23_0.result == 4 then
				global_ShowBlockWords(L_RECHARGE_OUT_TIME)
			elseif arg_23_0.result == 5 then
				global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)
			elseif arg_23_0.result == 6 then
				global_ShowBlockWords(L_RECHARGE_CARD_LIMIT)
			end
		end)

		return
	end

	local var_22_1 = self.currencyData[arg_22_1].price

	self:shopPop({
		have_bought = 0,
		itemtype = self.currencyData[arg_22_1].itemid,
		currency = self.currencyData[arg_22_1].currency,
		paid = (self.currencyData[arg_22_1].currency == 8888888 or nil) and true,
		price = var_22_1,
		buy_limit = self.limitData[arg_22_1].limitNum - self.limitData[arg_22_1].boughtNum
	}, arg_22_1, arg_22_2)
end

function PopBuyPackageDirectLayer_186.showBuyPop(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	print("shoptypeshoptype###################", dump(arg_24_1))

	if not arg_24_2 then
		LayerManager:pushInLayer("PopGoodsLayer", arg_24_1)
	elseif arg_24_3 == "shopitem" then
		LayerManager:pushInLayer("PopGoodsLayer", arg_24_1)
	elseif arg_24_3 == "giftitem" then
		LayerManager:pushInLayer("PopSkinPackage", arg_24_1)
	else
		LayerManager:pushInLayer("PopGoodsLayer", arg_24_1)
	end
end

function PopBuyPackageDirectLayer_186.shopPop(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = 1
	local var_25_1 = 2
	local var_25_2 = 3
	local var_25_4 = {
		function()
			return playermodel.gold
		end,
		[0] = function()
			if arg_25_1.paid then
				return item_manager:getItemNumber(CURRENCY_DIAMOND_PAID)
			else
				return playermodel.diamond
			end
		end,
		function()
			return playermodel.honor
		end,
		function()
			return playermodel.explorecoin
		end,
		[100] = function()
			return 0
		end
	}

	setmetatable(var_25_4, {
		__index = function(arg_31_0, arg_31_1)
			return function()
				return item_manager:getItemNumber(arg_31_1)
			end
		end
	})

	local var_25_5 = {
		[1500001] = "public/currency/1500001_1.png",
		[var_25_0] = "public/currency/UI_battleEnd_gold.png",
		[0] = arg_25_1.paid and "public/currency/888888.png" or "public/currency/UI_battleEnd_diamond.png",
		[var_25_1] = "public/currency/arenascene_dot_1.png",
		[var_25_2] = "public/currency/explorecoin.png",
		[100] = "public/currency/rmb_white.png"
	}

	setmetatable(var_25_5, {
		__index = function(arg_33_0, arg_33_1)
			return "public/currency/" .. item_data[arg_33_1].image_id .. ".png"
		end
	})

	local var_25_6 = {
		[var_25_0] = function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "HandOfMidasLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_GOLD
			})
		end,
		[0] = function()
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 1
			})
		end,
		[var_25_1] = function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ArenaLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_HORNOR
			})
		end,
		[var_25_2] = function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ExploreMapLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_EXPLORECOIN
			})
		end,
		[6800601] = function()
			LayerManager:pushInLayer("PopGoBuyGiftTicketLayer", {
				targetlayer = "PopSupermarketLayer"
			})
		end,
		[8888888] = function()
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 1
			})
		end
	}

	setmetatable(var_25_6, {
		__index = function(arg_40_0, arg_40_1)
			return function()
				global_ShowBlockWords(string.format(L_COMMON_WARNING.Used_Up, item_data[arg_40_1].name))
				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end
	})

	local var_25_7 = {}

	local function var_25_8(arg_42_0)
		print(dump(arg_42_0))

		local var_42_0 = var_25_7

		if arg_42_0.result == 1 then
			activity_manager:buyFlopLimitBag(arg_25_0.id, arg_25_2, var_25_7.curbuyTime, arg_25_0.uiconfType, function(arg_43_0)
				if arg_43_0.result == 1 then
					LayerManager:removePopLayer(_index)

					arg_25_1.have_bought = arg_25_1.have_bought + var_42_0.curbuyTime
					arg_25_1.sell_out = arg_25_1.buy_limit and arg_25_1.buy_limit <= arg_25_1.have_bought

					global_gain({
						items = arg_43_0.items
					})
					arg_25_0:updateBtn(arg_43_0, arg_25_2)

					if var_42_0.callback then
						var_42_0.callback()
					end
				elseif arg_43_0.result == 2 then
					global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_43_0.result == 3 then
					var_25_6[var_42_0.shopitem.currency]()
				end
			end)
		end
	end

	local function var_25_9(arg_44_0)
		if not arg_44_0.currency2 or discount_manager:getLastPriceByItem(arg_44_0.itemid, arg_44_0.currency2, arg_44_0.discount2) < arg_44_0.discount2 then
			return true
		end

		return false
	end

	;(function(arg_45_0)
		local var_45_0 = {
			itemid = arg_45_0.itemid,
			item_attr = arg_45_0.item_attr
		}

		var_45_0.limitNum = arg_45_0.buy_limit and (arg_45_0.buy_limit - arg_45_0.have_bought >= SHOP_NORMAL_BUY_LIMIT_NUM and SHOP_NORMAL_BUY_LIMIT_NUM or arg_45_0.buy_limit - arg_45_0.have_bought) or SHOP_NORMAL_BUY_LIMIT_NUM

		local var_45_1

		if var_25_9(arg_45_0) then
			var_45_1 = math.floor(var_25_4[arg_45_0.currency]() / arg_45_0.cost)
			var_45_0.currency = arg_45_0.currency
		else
			var_45_1 = math.floor(var_25_4[arg_45_0.currency2]() / arg_45_0.cost2)
			var_45_0.currency = arg_45_0.currency2
		end

		if var_45_1 > var_45_0.limitNum then
			var_45_0.limitNum = var_45_0.limitNum or var_45_1
		end

		var_45_0.slidecost = {}

		if var_25_9(arg_45_0) then
			var_45_0.slidecost.costtype = arg_45_0.costIcon
			var_45_0.slidecost.costnum = arg_45_0.discount or arg_45_0.cost
			var_45_0.slidecost.nowHave = var_25_4[arg_45_0.currency]()
			var_45_0.slidecost.cost_old = arg_45_0.cost_old or var_45_0.slidecost.costnum
		else
			var_45_0.slidecost.costtype = arg_45_0.costIcon2
			var_45_0.slidecost.costnum = arg_45_0.discount2 or arg_45_0.cost2
			var_45_0.slidecost.nowHave = var_25_4[arg_45_0.currency2]()
			var_45_0.slidecost.cost_old = arg_45_0.cost_old2 or var_45_0.slidecost.costnum
		end

		function var_45_0:ShopSliderCallback(arg_46_1, arg_46_2)
			if arg_46_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not self:isBright() then
				return
			end

			local var_46_0 = self.nowNum or 1

			var_25_7 = {
				curbuyTime = var_46_0,
				shoptype = shoptype,
				itemid = var_45_0.itemid,
				callback = arg_46_2,
				shopitem = arg_45_0
			}

			if var_25_9(arg_45_0) and arg_45_0.cost > var_25_4[arg_45_0.currency]() then
				LayerManager:removePopLayer()
				var_25_6[arg_45_0.currency]()

				return
			end

			self:setTouchEnabled(false)
			var_25_8({
				result = 1
			})
		end

		var_45_0.hideGainButton = true

		if arg_45_0.have_bought and arg_45_0.buy_limit then
			var_45_0.limit_buy_num = arg_45_0.buy_limit - arg_45_0.have_bought
			var_45_0.have_bought_num = arg_45_0.have_bought
		end

		var_45_0.to_shop = arg_45_0.to_shop

		arg_25_0:showBuyPop(var_45_0)

		arg_45_0.isnewitem = false
	end)((function(arg_47_0)
		local var_47_0 = {
			name = item_data[arg_47_0.itemtype].name,
			itemid = arg_47_0.itemtype,
			costIcon = var_25_5[arg_47_0.currency],
			currency = arg_47_0.currency,
			cost = arg_47_0.price
		}

		var_47_0.quality = item_data[arg_47_0.itemtype].equip_quality or 1
		var_47_0.bag_item_type = item_data[arg_47_0.itemtype].bag_item_type
		var_47_0.buy_limit = arg_47_0.buy_limit or 1000000
		var_47_0.have_bought = arg_47_0.have_bought or 0
		var_47_0.sell_out = arg_47_0.buy_limit and arg_47_0.buy_limit <= arg_47_0.have_bought
		var_47_0.to_shop = arg_47_0.to_shop

		return var_47_0
	end)(arg_25_1))
end
