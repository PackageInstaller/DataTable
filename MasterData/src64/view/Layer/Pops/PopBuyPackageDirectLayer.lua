PopBuyPackageDirectLayer = class("PopBuyPackageDirectLayer", function()
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

function PopBuyPackageDirectLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopBuyPackageDirectLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopBuyPackageDirectLayer:init(arg_3_1)
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

function PopBuyPackageDirectLayer:initAll(arg_8_1)
	self.currencyData = arg_8_1.currencyData
	self.limitData = arg_8_1.limitData
	self.id = arg_8_1.activityid
	self.uiconfType = 1

	self:initEventListener()
	self:getParamFromUIConf()
	self:initTexture()
	self:initUI(arg_8_1)
end

function PopBuyPackageDirectLayer:initEventListener()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_10_0)
		LayerManager:removePopLayer(self.__queueindex)
	end), self)
end

function PopBuyPackageDirectLayer:getUIConf()
	return activity_buy_package_ui_conf_data[self.id .. "-" .. self.uiconfType] or activity_buy_package_ui_conf_data[430]
end

function PopBuyPackageDirectLayer.getUIColor(arg_12_0, arg_12_1)
	return cc.c3b(arg_12_1[1], arg_12_1[2], arg_12_1[3])
end

function PopBuyPackageDirectLayer:getParamFromUIConf()
	self.defaultconf, self.uiconf = activity_buy_package_ui_conf_data["1-1"], self:getUIConf()
	self.path = "activitiesRes/activity" .. self.id .. self.uiconf.path
end

function PopBuyPackageDirectLayer:initTexture(arg_14_1)
	self.rootpanel = self.rootLayer:getChildByName("bg")

	self.rootpanel:loadTexture(self.path .. "buy_bg.png")
	self.rootpanel:setPositionX(GameDisplay.getScreenSize().width / 2 + self.uiconf.bg_offset.x or 0)
	self.rootpanel:setPositionY(GameDisplay.getScreenSize().height / 2 + self.uiconf.bg_offset.y or 0)
end

function PopBuyPackageDirectLayer:initUI(arg_15_1)
	self:addBuyUI()

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
			var_15_2:setString(L_BUY_LIMIT .. self.limitData[1].boughtNum .. "/" .. self.limitData[1].limitNum)
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

			local var_15_4 = "X" .. self.currencyData[1].price

			if self.limitData[1].rechargeid then
				var_15_4 = string.format(L_MANKEY, recharge_data[self.limitData[1].rechargeid].rmb)
			end

			var_15_3:setVisible(false)
			var_15_3:setString(var_15_4)
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
				var_15_7:setVisible(false)
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
		var_15_2:setPositionX(self.uiconf.label_limit_offset.x)
		var_15_2:setPositionY(self.uiconf.label_limit_offset.y)
	end
end

function PopBuyPackageDirectLayer.updateUI(arg_18_0)
	return
end

function PopBuyPackageDirectLayer:updateBtn(arg_19_1, arg_19_2)
	local var_19_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_buy" .. arg_19_2)
	local var_19_1 = var_19_0:getChildByName("labelPriceBottom")

	self.limitData[arg_19_2].boughtNum = arg_19_1.boughtNum
	var_19_0.boughtNum = arg_19_1.boughtNum
	ccui.Helper:seekWidgetByName(self.rootLayer, "buy_type" .. arg_19_2).boughtNum = arg_19_1.boughtNum

	ccui.Helper:seekWidgetByName(self.rootLayer, "limit_" .. arg_19_2):setString(self.limitData[arg_19_2].boughtNum .. "/" .. self.limitData[arg_19_2].limitNum)

	if self.limitData[arg_19_2].limitNum == self.limitData[arg_19_2].boughtNum then
		var_19_0:loadTextures(self.path .. "btn_buy_out.png", self.path .. "btn_buy_out.png", self.path .. "btn_buy_out.png")
		var_19_0:getChildByName("label_price"):setVisible(false)

		if var_19_1 then
			var_19_1:setVisible(false)
		end

		if var_19_0:getChildByName("currency_icon") then
			var_19_0:getChildByName("currency_icon"):setVisible(false)
		end
	end
end

function PopBuyPackageDirectLayer:getPriceLabelBottom()
	return not not self.uiconf.label_price_bottom_color
end

function PopBuyPackageDirectLayer:popGetKeyItem(arg_21_1, arg_21_2)
	if self.limitData[arg_21_1].rechargeid then
		local var_21_0 = self.limitData[arg_21_1].rechargeid

		network:rpc("check_recharge", {
			id = self.limitData[arg_21_1].rechargeid,
			client = config.clientmode
		}, function(arg_22_0)
			if arg_22_0.result == 1 then
				self.recharging = false

				AnalyticManager.clickPurchaseItem({
					product = id,
					rolenum = playermodel:getOwnedServantNum(),
					grade = playermodel.grade,
					class = playermodel.class
				})
				recharge_manager:confirmPayment(var_21_0)
			elseif arg_22_0.result == 2 then
				print("测试模式")
			elseif arg_22_0.result == 3 then
				global_ShowBlockWords(L_RECAHRGE_GOODS_UNAVAILABLE)
			elseif arg_22_0.result == 4 then
				global_ShowBlockWords(L_RECHARGE_OUT_TIME)
			elseif arg_22_0.result == 5 then
				global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)
			elseif arg_22_0.result == 6 then
				global_ShowBlockWords(L_RECHARGE_CARD_LIMIT)
			end
		end)

		return
	end

	local var_21_1 = self.currencyData[arg_21_1].price

	self:shopPop({
		have_bought = 0,
		itemtype = self.currencyData[arg_21_1].itemid,
		currency = self.currencyData[arg_21_1].currency,
		paid = (self.currencyData[arg_21_1].currency == 8888888 or nil) and true,
		price = var_21_1,
		buy_limit = self.limitData[arg_21_1].limitNum - self.limitData[arg_21_1].boughtNum
	}, arg_21_1, arg_21_2)
end

function PopBuyPackageDirectLayer.showBuyPop(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	print("shoptypeshoptype###################", dump(arg_23_1))

	if not arg_23_2 then
		LayerManager:pushInLayer("PopGoodsLayer", arg_23_1)
	elseif arg_23_3 == "shopitem" then
		LayerManager:pushInLayer("PopGoodsLayer", arg_23_1)
	elseif arg_23_3 == "giftitem" then
		LayerManager:pushInLayer("PopSkinPackage", arg_23_1)
	else
		LayerManager:pushInLayer("PopGoodsLayer", arg_23_1)
	end
end

function PopBuyPackageDirectLayer.shopPop(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = 1
	local var_24_1 = 2
	local var_24_2 = 3
	local var_24_4 = {
		function()
			return playermodel.gold
		end,
		[0] = function()
			if arg_24_1.paid then
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

	setmetatable(var_24_4, {
		__index = function(arg_30_0, arg_30_1)
			return function()
				return item_manager:getItemNumber(arg_30_1)
			end
		end
	})

	local var_24_5 = {
		[1500001] = "public/currency/1500001_1.png",
		[var_24_0] = "public/currency/UI_battleEnd_gold.png",
		[0] = arg_24_1.paid and "public/currency/888888.png" or "public/currency/UI_battleEnd_diamond.png",
		[var_24_1] = "public/currency/arenascene_dot_1.png",
		[var_24_2] = "public/currency/explorecoin.png",
		[100] = "public/currency/rmb_white.png"
	}

	setmetatable(var_24_5, {
		__index = function(arg_32_0, arg_32_1)
			return "public/currency/" .. item_data[arg_32_1].image_id .. ".png"
		end
	})

	local var_24_6 = {
		[var_24_0] = function()
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
		[var_24_1] = function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ArenaLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_HORNOR
			})
		end,
		[var_24_2] = function()
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

	setmetatable(var_24_6, {
		__index = function(arg_39_0, arg_39_1)
			return function()
				global_ShowBlockWords(string.format(L_COMMON_WARNING.Used_Up, item_data[arg_39_1].name))
				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end
	})

	local var_24_7 = {}

	local function var_24_8(arg_41_0)
		print(dump(arg_41_0))

		local var_41_0 = var_24_7

		if arg_41_0.result == 1 then
			activity_manager:buyFlopLimitBag(arg_24_0.id, arg_24_2, var_24_7.curbuyTime, arg_24_0.uiconfType, function(arg_42_0)
				if arg_42_0.result == 1 then
					LayerManager:removePopLayer(_index)

					arg_24_1.have_bought = arg_24_1.have_bought + var_41_0.curbuyTime
					arg_24_1.sell_out = arg_24_1.buy_limit and arg_24_1.buy_limit <= arg_24_1.have_bought

					global_gain({
						items = arg_42_0.items
					})
					arg_24_0:updateBtn(arg_42_0, arg_24_2)

					if var_41_0.callback then
						var_41_0.callback()
					end
				elseif arg_42_0.result == 2 then
					global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_42_0.result == 3 then
					var_24_6[var_41_0.shopitem.currency]()
				end
			end)
		end
	end

	local function var_24_9(arg_43_0)
		if not arg_43_0.currency2 or discount_manager:getLastPriceByItem(arg_43_0.itemid, arg_43_0.currency2, arg_43_0.discount2) < arg_43_0.discount2 then
			return true
		end

		return false
	end

	;(function(arg_44_0)
		local var_44_0 = {
			itemid = arg_44_0.itemid,
			item_attr = arg_44_0.item_attr
		}

		var_44_0.limitNum = arg_44_0.buy_limit and (arg_44_0.buy_limit - arg_44_0.have_bought >= SHOP_NORMAL_BUY_LIMIT_NUM and SHOP_NORMAL_BUY_LIMIT_NUM or arg_44_0.buy_limit - arg_44_0.have_bought) or SHOP_NORMAL_BUY_LIMIT_NUM

		local var_44_1

		if var_24_9(arg_44_0) then
			var_44_1 = math.floor(var_24_4[arg_44_0.currency]() / arg_44_0.cost)
			var_44_0.currency = arg_44_0.currency
		else
			var_44_1 = math.floor(var_24_4[arg_44_0.currency2]() / arg_44_0.cost2)
			var_44_0.currency = arg_44_0.currency2
		end

		if var_44_1 > var_44_0.limitNum then
			var_44_0.limitNum = var_44_0.limitNum or var_44_1
		end

		var_44_0.slidecost = {}

		if var_24_9(arg_44_0) then
			var_44_0.slidecost.costtype = arg_44_0.costIcon
			var_44_0.slidecost.costnum = arg_44_0.discount or arg_44_0.cost
			var_44_0.slidecost.nowHave = var_24_4[arg_44_0.currency]()
			var_44_0.slidecost.cost_old = arg_44_0.cost_old or var_44_0.slidecost.costnum
		else
			var_44_0.slidecost.costtype = arg_44_0.costIcon2
			var_44_0.slidecost.costnum = arg_44_0.discount2 or arg_44_0.cost2
			var_44_0.slidecost.nowHave = var_24_4[arg_44_0.currency2]()
			var_44_0.slidecost.cost_old = arg_44_0.cost_old2 or var_44_0.slidecost.costnum
		end

		function var_44_0:ShopSliderCallback(arg_45_1, arg_45_2)
			if arg_45_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not self:isBright() then
				return
			end

			local var_45_0 = self.nowNum or 1

			var_24_7 = {
				curbuyTime = var_45_0,
				shoptype = shoptype,
				itemid = var_44_0.itemid,
				callback = arg_45_2,
				shopitem = arg_44_0
			}

			if var_24_9(arg_44_0) and arg_44_0.cost > var_24_4[arg_44_0.currency]() then
				LayerManager:removePopLayer()
				var_24_6[arg_44_0.currency]()

				return
			end

			self:setTouchEnabled(false)
			var_24_8({
				result = 1
			})
		end

		var_44_0.hideGainButton = true

		if arg_44_0.have_bought and arg_44_0.buy_limit then
			var_44_0.limit_buy_num = arg_44_0.buy_limit - arg_44_0.have_bought
			var_44_0.have_bought_num = arg_44_0.have_bought
		end

		var_44_0.to_shop = arg_44_0.to_shop

		arg_24_0:showBuyPop(var_44_0)

		arg_44_0.isnewitem = false
	end)((function(arg_46_0)
		local var_46_0 = {
			name = item_data[arg_46_0.itemtype].name,
			itemid = arg_46_0.itemtype,
			costIcon = var_24_5[arg_46_0.currency],
			currency = arg_46_0.currency,
			cost = arg_46_0.price
		}

		var_46_0.quality = item_data[arg_46_0.itemtype].equip_quality or 1
		var_46_0.bag_item_type = item_data[arg_46_0.itemtype].bag_item_type
		var_46_0.buy_limit = arg_46_0.buy_limit or 1000000
		var_46_0.have_bought = arg_46_0.have_bought or 0
		var_46_0.sell_out = arg_46_0.buy_limit and arg_46_0.buy_limit <= arg_46_0.have_bought
		var_46_0.to_shop = arg_46_0.to_shop

		return var_46_0
	end)(arg_24_1))
end

function PopBuyPackageDirectLayer:addBuyUI()
	local function var_47_0(arg_48_0)
		for iter_48_0 = 1, arg_48_0 do
			local var_48_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "buy_type1"):clone()

			var_48_0:setName("buy_type" .. 3 + iter_48_0)
			ccui.Helper:seekWidgetByName(var_48_0, "btn_buy1"):setName("btn_buy" .. 3 + iter_48_0)
			ccui.Helper:seekWidgetByName(var_48_0, "limit_1"):setName("limit_" .. 3 + iter_48_0)
			self.rootpanel:addChild(var_48_0)
		end
	end

	if self.id == 730 then
		var_47_0(1)
	elseif self.id == 755 then
		var_47_0(1)
	end
end
