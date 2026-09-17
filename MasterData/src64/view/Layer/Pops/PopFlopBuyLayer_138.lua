PopFlopBuyLayer_138 = class("PopFlopBuyLayer_138", function()
	return PopBaseLayer:create()
end)

local activity_manager = require("controller.activity_manager")
local drop_manager = require("controller.drop_manager")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local var_0_6 = config._DEBUG and 0 or 1

function PopFlopBuyLayer_138.create(arg_2_0, arg_2_1)
	local var_2_0 = PopFlopBuyLayer_138.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopFlopBuyLayer_138:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_flop_buy_138.json" or "Pop_flop_buy_138.ExportJson")

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.rootLayer:setTouchEnabled(false)
	self:addChild(self.rootLayer, 2)

	self.rootpanel = self.rootLayer:getChildByName("bg")

	self.rootpanel:setPositionY(GameDisplay.getScreenSize().height / 2)
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
	self:initUI(arg_3_1)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			popstarrewardlayerInstance = false

			if arg_3_1.updateCallback then
				arg_3_1.updateCallback()
			end
		end
	end)
end

local var_0_7 = {
	[SHOP_CURRENCY_GOLD] = "public/currency/UI_battleEnd_gold.png",
	[SHOP_CURRENCY_DIAMOND] = "equipment/1000000.png",
	[CURRENCY_DIAMOND_PAID] = "equipment/" .. item_data[CURRENCY_DIAMOND_PAID].image_id .. ".png"
}

setmetatable(var_0_7, {
	__index = function(arg_7_0, arg_7_1)
		return "equipment/" .. item_data[arg_7_1].image_id .. ".png"
	end
})

function PopFlopBuyLayer_138:initUI(arg_8_1)
	self.currencyData = arg_8_1.currencyData
	self.limitData = arg_8_1.limitData
	self.id = arg_8_1.activityid

	local var_8_0 = 1

	while ccui.Helper:seekWidgetByName(self.rootLayer, "buy_type" .. var_8_0) do
		local var_8_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "buy_type" .. var_8_0)
		local var_8_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_buy" .. var_8_0)
		local var_8_3 = ccui.Helper:seekWidgetByName(self.rootLayer, "limit_" .. var_8_0)
		local var_8_4 = var_8_2:getChildByName("label_price")

		var_8_2.index = var_8_0
		var_8_2.limitNum = self.limitData[var_8_0].limitNum
		var_8_2.boughtNum = self.limitData[var_8_0].boughtNum
		var_8_1.index = var_8_0
		var_8_1.limitNum = self.limitData[var_8_0].limitNum
		var_8_1.boughtNum = self.limitData[var_8_0].boughtNum

		var_8_3:setString(self.limitData[var_8_0].boughtNum .. "/" .. self.limitData[var_8_0].limitNum)

		if self.limitData[var_8_0].limitNum == self.limitData[var_8_0].boughtNum then
			var_8_2:loadTextures("ActivityMoonFestival/btn_buy_out.png", "ActivityMoonFestival/btn_buy_out.png", "ActivityMoonFestival/btn_buy_out.png", var_0_6)
			var_8_4:setVisible(false)
		else
			var_8_4:setString("X" .. self.currencyData[var_8_0].price)

			local var_8_5 = ccui.ImageView:create(var_0_7[self.currencyData[var_8_0].currency])

			var_8_5:setName("currency_icon")
			var_8_5:setAnchorPoint(cc.p(0.5, 0.5))
			var_8_5:setScale(0.25)
			var_8_5:setPositionX(70)
			var_8_5:setPositionY(var_8_4:getPositionY())
			var_8_2:addChild(var_8_5)
			var_8_4:setPositionX(var_8_2:getContentSize().width / 2 - 10)
			var_8_2:addTouchEventListener(function(arg_9_0, arg_9_1)
				if arg_9_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_9_0.limitNum == arg_9_0.boughtNum then
					return
				end

				self:popGetKeyItem(arg_9_0.index, callback)
			end)
			var_8_1:setTouchEnabled(true)
			var_8_1:addTouchEventListener(function(arg_10_0, arg_10_1)
				if arg_10_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_10_0.limitNum == arg_10_0.boughtNum then
					return
				end

				self:popGetKeyItem(arg_10_0.index, callback)
			end)
		end

		var_8_0 = var_8_0 + 1
	end
end

function PopFlopBuyLayer_138.updateUI(arg_11_0)
	return
end

function PopFlopBuyLayer_138:updateBtn(arg_12_1, arg_12_2)
	local var_12_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_buy" .. arg_12_2)

	self.limitData[arg_12_2].boughtNum = arg_12_1.boughtNum
	var_12_0.boughtNum = arg_12_1.boughtNum
	ccui.Helper:seekWidgetByName(self.rootLayer, "buy_type" .. arg_12_2).boughtNum = arg_12_1.boughtNum

	ccui.Helper:seekWidgetByName(self.rootLayer, "limit_" .. arg_12_2):setString(self.limitData[arg_12_2].boughtNum .. "/" .. self.limitData[arg_12_2].limitNum)

	if self.limitData[arg_12_2].limitNum == self.limitData[arg_12_2].boughtNum then
		var_12_0:loadTextures("ActivityMoonFestival/btn_buy_out.png", "ActivityMoonFestival/btn_buy_out.png", "ActivityMoonFestival/btn_buy_out.png", var_0_6)
		var_12_0:getChildByName("label_price"):setVisible(false)

		if var_12_0:getChildByName("currency_icon") then
			var_12_0:getChildByName("currency_icon"):setVisible(false)
		end
	end
end

function PopFlopBuyLayer_138:popGetKeyItem(arg_13_1, arg_13_2)
	self:shopPop({
		have_bought = 0,
		itemtype = self.currencyData[arg_13_1].itemid,
		currency = self.currencyData[arg_13_1].currency,
		paid = (self.currencyData[arg_13_1].currency == 8888888 or nil) and true,
		price = self.currencyData[arg_13_1].price,
		buy_limit = self.limitData[arg_13_1].limitNum - self.limitData[arg_13_1].boughtNum
	}, arg_13_1, arg_13_2)
end

function PopFlopBuyLayer_138.showBuyPop(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	print("shoptypeshoptype###################", dump(arg_14_1))

	if not arg_14_2 then
		LayerManager:pushInLayer("PopGoodsLayer", arg_14_1)
	elseif arg_14_3 == "shopitem" then
		LayerManager:pushInLayer("PopGoodsLayer", arg_14_1)
	elseif arg_14_3 == "giftitem" then
		LayerManager:pushInLayer("PopSkinPackage", arg_14_1)
	else
		LayerManager:pushInLayer("PopGoodsLayer", arg_14_1)
	end
end

function PopFlopBuyLayer_138.shopPop(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = 1
	local var_15_1 = 2
	local var_15_2 = 3
	local var_15_4 = {
		function()
			return playermodel.gold
		end,
		[0] = function()
			if arg_15_1.paid then
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

	setmetatable(var_15_4, {
		__index = function(arg_21_0, arg_21_1)
			return function()
				return item_manager:getItemNumber(arg_21_1)
			end
		end
	})

	local var_15_5 = {
		[1500001] = "public/currency/1500001_1.png",
		[var_15_0] = "public/currency/UI_battleEnd_gold.png",
		[0] = arg_15_1.paid and "public/currency/888888.png" or "public/currency/UI_battleEnd_diamond.png",
		[var_15_1] = "public/currency/arenascene_dot_1.png",
		[var_15_2] = "public/currency/explorecoin.png",
		[100] = "public/currency/rmb_white.png"
	}

	setmetatable(var_15_5, {
		__index = function(arg_23_0, arg_23_1)
			return "public/currency/" .. item_data[arg_23_1].image_id .. ".png"
		end
	})

	local var_15_6 = {
		[var_15_0] = function()
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
		[var_15_1] = function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ArenaLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_HORNOR
			})
		end,
		[var_15_2] = function()
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

	setmetatable(var_15_6, {
		__index = function(arg_30_0, arg_30_1)
			return function()
				global_ShowBlockWords(string.format(L_COMMON_WARNING.Used_Up, item_data[arg_30_1].name))
				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end
	})

	local var_15_7 = {}

	local function var_15_8(arg_32_0)
		print(dump(arg_32_0))

		local var_32_0 = var_15_7

		if arg_32_0.result == 1 then
			activity_manager:buyFlopLimitBag(arg_15_0.id, arg_15_2, var_15_7.curbuyTime, function(arg_33_0)
				if arg_33_0.result == 1 then
					LayerManager:removePopLayer(_index)

					arg_15_1.have_bought = arg_15_1.have_bought + var_32_0.curbuyTime
					arg_15_1.sell_out = arg_15_1.buy_limit and arg_15_1.buy_limit <= arg_15_1.have_bought

					global_gain({
						items = arg_33_0.items
					})
					arg_15_0:updateBtn(arg_33_0, arg_15_2)

					if var_32_0.callback then
						var_32_0.callback()
					end
				elseif arg_33_0.result == 2 then
					global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_33_0.result == 3 then
					var_15_6[var_32_0.shopitem.currency]()
				end
			end)
		end
	end

	local function var_15_9(arg_34_0)
		if not arg_34_0.currency2 or ActivityBachelorManager:getLastPriceByItem(arg_34_0.itemid, arg_34_0.currency2) < arg_34_0.discount2 then
			return true
		end

		return false
	end

	;(function(arg_35_0)
		local var_35_0 = {
			itemid = arg_35_0.itemid,
			item_attr = arg_35_0.item_attr
		}

		var_35_0.limitNum = arg_35_0.buy_limit and (arg_35_0.buy_limit - arg_35_0.have_bought >= SHOP_NORMAL_BUY_LIMIT_NUM and SHOP_NORMAL_BUY_LIMIT_NUM or arg_35_0.buy_limit - arg_35_0.have_bought) or SHOP_NORMAL_BUY_LIMIT_NUM

		local var_35_1

		if var_15_9(arg_35_0) then
			var_35_1 = math.floor(var_15_4[arg_35_0.currency]() / arg_35_0.cost)
			var_35_0.currency = arg_35_0.currency
		else
			var_35_1 = math.floor(var_15_4[arg_35_0.currency2]() / arg_35_0.cost2)
			var_35_0.currency = arg_35_0.currency2
		end

		if var_35_1 > var_35_0.limitNum then
			var_35_0.limitNum = var_35_0.limitNum or var_35_1
		end

		var_35_0.slidecost = {}

		if var_15_9(arg_35_0) then
			var_35_0.slidecost.costtype = arg_35_0.costIcon
			var_35_0.slidecost.costnum = arg_35_0.discount or arg_35_0.cost
			var_35_0.slidecost.nowHave = var_15_4[arg_35_0.currency]()
			var_35_0.slidecost.cost_old = arg_35_0.cost_old or var_35_0.slidecost.costnum
		else
			var_35_0.slidecost.costtype = arg_35_0.costIcon2
			var_35_0.slidecost.costnum = arg_35_0.discount2 or arg_35_0.cost2
			var_35_0.slidecost.nowHave = var_15_4[arg_35_0.currency2]()
			var_35_0.slidecost.cost_old = arg_35_0.cost_old2 or var_35_0.slidecost.costnum
		end

		function var_35_0:ShopSliderCallback(arg_36_1, arg_36_2)
			if arg_36_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not self:isBright() then
				return
			end

			local var_36_0 = self.nowNum or 1

			var_15_7 = {
				curbuyTime = var_36_0,
				shoptype = shoptype,
				itemid = var_35_0.itemid,
				callback = arg_36_2,
				shopitem = arg_35_0
			}

			if var_15_9(arg_35_0) and arg_35_0.cost > var_15_4[arg_35_0.currency]() then
				LayerManager:removePopLayer()
				var_15_6[arg_35_0.currency]()

				return
			end

			self:setTouchEnabled(false)
			var_15_8({
				result = 1
			})
		end

		var_35_0.hideGainButton = true

		if arg_35_0.have_bought and arg_35_0.buy_limit then
			var_35_0.limit_buy_num = arg_35_0.buy_limit - arg_35_0.have_bought
			var_35_0.have_bought_num = arg_35_0.have_bought
		end

		var_35_0.to_shop = arg_35_0.to_shop

		arg_15_0:showBuyPop(var_35_0)

		arg_35_0.isnewitem = false
	end)((function(arg_37_0)
		local var_37_0 = {
			name = item_data[arg_37_0.itemtype].name,
			itemid = arg_37_0.itemtype,
			costIcon = var_15_5[arg_37_0.currency],
			currency = arg_37_0.currency,
			cost = arg_37_0.price
		}

		var_37_0.quality = item_data[arg_37_0.itemtype].equip_quality or 1
		var_37_0.bag_item_type = item_data[arg_37_0.itemtype].bag_item_type
		var_37_0.buy_limit = arg_37_0.buy_limit or 1000000
		var_37_0.have_bought = arg_37_0.have_bought or 0
		var_37_0.sell_out = arg_37_0.buy_limit and arg_37_0.buy_limit <= arg_37_0.have_bought
		var_37_0.to_shop = arg_37_0.to_shop

		return var_37_0
	end)(arg_15_1))
end
