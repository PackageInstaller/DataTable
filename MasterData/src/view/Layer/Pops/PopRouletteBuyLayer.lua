PopRouletteBuyLayer = class("PopRouletteBuyLayer", function()
	return PopBaseLayer:create()
end)

local activity_manager = require("controller.activity_manager")
local drop_manager = require("controller.drop_manager")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local discount_manager = require("controller.discount_manager")
local recharge_data = require("data.recharge_data")
local recharge_manager = require("controller.recharge_manager")
local network = require("network.network")
local var_0_10 = config._DEBUG and 0 or 1
local var_0_11
local var_0_12 = {
	[SHOP_CURRENCY_GOLD] = "public/currency/UI_battleEnd_gold.png",
	[SHOP_CURRENCY_DIAMOND] = "equipment/1000000.png"
}

setmetatable(var_0_12, {
	__index = function(arg_2_0, arg_2_1)
		return "equipment/" .. item_data[arg_2_1].image_id .. ".png"
	end
})

function PopRouletteBuyLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = PopRouletteBuyLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function PopRouletteBuyLayer:init(arg_4_1)
	var_0_11 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_flop_buy.json" or "Pop_flop_buy.ExportJson")

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.rootLayer:setTouchEnabled(false)
	self:addChild(self.rootLayer, 2)

	self.rootpanel = self.rootLayer:getChildByName("bg")

	self.rootpanel:setPositionY(GameDisplay.getScreenSize().height / 2)

	self.activityId = arg_4_1.activityId

	self:initUI(arg_4_1)
	self:registerActivityEventListener()
	activity_manager:getRouletteLimitData(self.activityId)
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			popstarrewardlayerInstance = false

			if arg_4_1.updateCallback then
				arg_4_1.updateCallback()
			end

			activity_manager:releaseEventListenerByName("PopRouletteBuyLayer")
		end
	end)
end

function PopRouletteBuyLayer.registerActivityEventListener(arg_6_0)
	activity_manager:registerEventListener("PopRouletteBuyLayer", activity_manager.activityEventId.ROULETTE_LIMIT_INFO_UPDATE, function(arg_7_0)
		arg_6_0:updateBtn(arg_7_0.data)
	end)
end

function PopRouletteBuyLayer:initUI()
	self:addTouchEventMask()
	self:playJoinEffect()
	self:initBGAndTitle()
	self:initButtons()
end

function PopRouletteBuyLayer:addTouchEventMask()
	self:createFullScreenMask(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_10_0:isBright() then
			return
		end

		arg_10_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
end

function PopRouletteBuyLayer:playJoinEffect()
	self.rootpanel:setScaleY(0.1)
	self.rootpanel:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1.15, 1.2)))
end

function PopRouletteBuyLayer:initBGAndTitle()
	self.imgPath = "ActivityRoulette_" .. self.activityId

	self.rootpanel:loadTexture(self.imgPath .. "/buy_bg.png", var_0_10)

	local var_13_0 = ccui.ImageView:create(self.imgPath .. "/title.png", var_0_10)

	var_13_0:setPosition(cc.p(320, 860))
	self.rootpanel:addChild(var_13_0)
end

function PopRouletteBuyLayer:initButtons()
	while ccui.Helper:seekWidgetByName(self.rootLayer, "buy_type" .. 1) do
		local var_14_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "buy_type" .. 1)
		local var_14_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_buy" .. 1)
		local var_14_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "limit_" .. 1)
		local var_14_3 = var_14_1:getChildByName("label_price")

		var_14_0:setPosition(cc.p(280, 750 - 1 * 200))
		var_14_0:loadTexture(self.imgPath .. "/buy_type" .. 1 .. ".png", var_0_10)
		var_14_2:setPosition(cc.p(320, 750 - 1 * 200))
		var_14_3:setPosition(cc.p(146, 45))
		var_14_1:setPosition(cc.p(420, 30))
		var_14_1:loadTextures(self.imgPath .. "/btn_buy" .. 1 .. ".png", nil, self.imgPath .. "/btn_buy" .. 1 .. ".png", var_0_10)

		local var_14_4 = ccui.ImageView:create(var_0_12[CURRENCY_DIAMOND_PAID])

		var_14_4:setName("currency_icon")
		var_14_4:setAnchorPoint(cc.p(0.5, 0.5))
		var_14_4:setScale(0.35)
		var_14_4:setPositionX(var_14_3:getPositionX() - var_14_3:getContentSize().width - 20)
		var_14_4:setPositionY(var_14_3:getPositionY())
		var_14_1:addChild(var_14_4)
	end
end

function PopRouletteBuyLayer:updateBtn(arg_15_1)
	for iter_15_0, iter_15_1 in pairs(arg_15_1) do
		local var_15_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "buy_type" .. iter_15_0)
		local var_15_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_buy" .. iter_15_0)
		local var_15_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "limit_" .. iter_15_0)
		local var_15_3 = var_15_1:getChildByName("label_price")

		if iter_15_1.limitNum then
			var_15_2:setString(iter_15_1.boughtNum .. "/" .. iter_15_1.limitNum)
			var_15_2:setColor(cc.c3b(255, 255, 255))
		else
			var_15_2:setVisible(false)
		end

		local var_15_4 = "X" .. iter_15_1.price

		if iter_15_1.rechargeid then
			var_15_4 = string.format(L_MANKEY, recharge_data[iter_15_1.rechargeid].rmb)

			var_15_1:getChildByName("currency_icon"):setVisible(false)
			var_15_3:setPositionX(140)
		end

		var_15_3:setString(var_15_4)
		var_15_3:setColor(cc.c3b(207, 42, 46))
		var_15_1:getChildByName("currency_icon"):loadTexture(var_0_12[iter_15_1.currencytype])
		var_15_1:getChildByName("currency_icon"):setPositionX(var_15_3:getPositionX() - var_15_3:getContentSize().width - 26)
		var_15_1:addTouchEventListener(function(arg_16_0, arg_16_1)
			if arg_16_1 ~= ccui.TouchEventType.ended then
				return
			end

			if iter_15_1.limitNum and iter_15_1.limitNum == iter_15_1.boughtNum then
				return
			end

			self:popGetKeyItem(iter_15_1, iter_15_0)
		end)
		var_15_0:setTouchEnabled(true)
		var_15_0:addTouchEventListener(function(arg_17_0, arg_17_1)
			if arg_17_1 ~= ccui.TouchEventType.ended then
				return
			end

			if iter_15_1.limitNum and iter_15_1.limitNum == iter_15_1.boughtNum then
				return
			end

			self:popGetKeyItem(iter_15_1, iter_15_0)
		end)
	end
end

function PopRouletteBuyLayer:popGetKeyItem(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_1.rechargeid

	if arg_18_1.rechargeid then
		network:rpc("check_recharge", {
			id = arg_18_1.rechargeid,
			client = config.clientmode
		}, function(arg_19_0)
			if arg_19_0.result == 1 then
				self.recharging = false

				AnalyticManager.clickPurchaseItem({
					product = id,
					rolenum = playermodel:getOwnedServantNum(),
					grade = playermodel.grade,
					class = playermodel.class
				})
				recharge_manager:confirmPayment(var_18_0)
			elseif arg_19_0.result == 2 then
				print("测试模式")
			elseif arg_19_0.result == 3 then
				global_ShowBlockWords(L_RECAHRGE_GOODS_UNAVAILABLE)
			elseif arg_19_0.result == 4 then
				global_ShowBlockWords(L_RECHARGE_OUT_TIME)
			elseif arg_19_0.result == 5 then
				global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)
			elseif arg_19_0.result == 6 then
				global_ShowBlockWords(L_RECHARGE_CARD_LIMIT)
			end
		end)

		return
	end

	local var_18_1 = arg_18_1.price
	local var_18_2 = arg_18_1.currencytype
	local var_18_3 = drop_manager:getAllDrops(arg_18_1.dropid)

	self:shopPop({
		have_bought = 0,
		itemtype = var_18_3[1].dropid,
		currency = var_18_2,
		paid = (var_18_2 == 8888888 or nil) and true,
		price = var_18_1,
		buy_limit = (arg_18_1.limitNum or nil) and (arg_18_1.limitNum - arg_18_1.boughtNum or 0)
	}, arg_18_2, arg_18_3)
end

function PopRouletteBuyLayer.showBuyPop(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if not arg_20_2 then
		LayerManager:pushInLayer("PopGoodsLayer", arg_20_1)
	elseif arg_20_3 == "shopitem" then
		LayerManager:pushInLayer("PopGoodsLayer", arg_20_1)
	elseif arg_20_3 == "giftitem" then
		LayerManager:pushInLayer("PopSkinPackage", arg_20_1)
	else
		LayerManager:pushInLayer("PopGoodsLayer", arg_20_1)
	end
end

function PopRouletteBuyLayer.shopPop(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = 1
	local var_21_1 = 2
	local var_21_2 = 3
	local var_21_4 = {
		function()
			return playermodel.gold
		end,
		[0] = function()
			if arg_21_1.paid then
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

	setmetatable(var_21_4, {
		__index = function(arg_27_0, arg_27_1)
			return function()
				return item_manager:getItemNumber(arg_27_1)
			end
		end
	})

	local var_21_5 = {
		[1500001] = "public/currency/1500001_1.png",
		[var_21_0] = "public/currency/UI_battleEnd_gold.png",
		[0] = arg_21_1.paid and "public/currency/888888.png" or "public/currency/UI_battleEnd_diamond.png",
		[var_21_1] = "public/currency/arenascene_dot_1.png",
		[var_21_2] = "public/currency/explorecoin.png",
		[100] = "public/currency/rmb_white.png"
	}

	setmetatable(var_21_5, {
		__index = function(arg_29_0, arg_29_1)
			return "public/currency/" .. item_data[arg_29_1].image_id .. ".png"
		end
	})

	local var_21_6 = {
		[var_21_0] = function()
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
		[var_21_1] = function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ArenaLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_HORNOR
			})
		end,
		[var_21_2] = function()
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

	setmetatable(var_21_6, {
		__index = function(arg_36_0, arg_36_1)
			return function()
				global_ShowBlockWords(string.format(L_COMMON_WARNING.Used_Up, item_data[arg_36_1].name))
				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end
	})

	local var_21_7 = {}

	local function var_21_8(arg_38_0)
		if arg_38_0.result == 1 then
			activity_manager:buyRouletteLimitBag(arg_21_0.activityId, arg_21_2, var_21_7.curbuyTime)
		end
	end

	local function var_21_9(arg_39_0)
		if not arg_39_0.currency2 or discount_manager:getLastPriceByItem(arg_39_0.itemid, arg_39_0.currency2, arg_39_0.discount2) < arg_39_0.discount2 then
			return true
		end

		return false
	end

	;(function(arg_40_0)
		local var_40_0 = {
			itemid = arg_40_0.itemid,
			item_attr = arg_40_0.item_attr
		}

		var_40_0.limitNum = arg_40_0.buy_limit and (arg_40_0.buy_limit - arg_40_0.have_bought >= SHOP_NORMAL_BUY_LIMIT_NUM and SHOP_NORMAL_BUY_LIMIT_NUM or arg_40_0.buy_limit - arg_40_0.have_bought) or SHOP_NORMAL_BUY_LIMIT_NUM

		local var_40_1

		if var_21_9(arg_40_0) then
			var_40_1 = math.floor(var_21_4[arg_40_0.currency]() / arg_40_0.cost)
			var_40_0.currency = arg_40_0.currency
		else
			var_40_1 = math.floor(var_21_4[arg_40_0.currency2]() / arg_40_0.cost2)
			var_40_0.currency = arg_40_0.currency2
		end

		if var_40_1 > var_40_0.limitNum then
			var_40_0.limitNum = var_40_0.limitNum or var_40_1
		end

		var_40_0.slidecost = {}

		if var_21_9(arg_40_0) then
			var_40_0.slidecost.costtype = arg_40_0.costIcon
			var_40_0.slidecost.costnum = arg_40_0.discount or arg_40_0.cost
			var_40_0.slidecost.nowHave = var_21_4[arg_40_0.currency]()
			var_40_0.slidecost.cost_old = arg_40_0.cost_old or var_40_0.slidecost.costnum
		else
			var_40_0.slidecost.costtype = arg_40_0.costIcon2
			var_40_0.slidecost.costnum = arg_40_0.discount2 or arg_40_0.cost2
			var_40_0.slidecost.nowHave = var_21_4[arg_40_0.currency2]()
			var_40_0.slidecost.cost_old = arg_40_0.cost_old2 or var_40_0.slidecost.costnum
		end

		function var_40_0:ShopSliderCallback(arg_41_1, arg_41_2)
			if arg_41_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not self:isBright() then
				return
			end

			local var_41_0 = self.nowNum or 1

			var_21_7 = {
				curbuyTime = var_41_0,
				shoptype = shoptype,
				itemid = var_40_0.itemid,
				callback = arg_41_2,
				shopitem = arg_40_0
			}

			if var_21_9(arg_40_0) and arg_40_0.cost > var_21_4[arg_40_0.currency]() then
				LayerManager:removePopLayer()
				var_21_6[arg_40_0.currency]()

				return
			end

			self:setTouchEnabled(false)
			var_21_8({
				result = 1
			})
		end

		var_40_0.hideGainButton = true

		if arg_40_0.have_bought and arg_40_0.buy_limit then
			var_40_0.limit_buy_num = arg_40_0.buy_limit - arg_40_0.have_bought
			var_40_0.have_bought_num = arg_40_0.have_bought
		end

		var_40_0.to_shop = arg_40_0.to_shop

		arg_21_0:showBuyPop(var_40_0)

		arg_40_0.isnewitem = false
	end)((function(arg_42_0)
		local var_42_0 = {
			name = item_data[arg_42_0.itemtype].name,
			itemid = arg_42_0.itemtype,
			costIcon = var_21_5[arg_42_0.currency],
			currency = arg_42_0.currency,
			cost = arg_42_0.price
		}

		var_42_0.quality = item_data[arg_42_0.itemtype].equip_quality or 1
		var_42_0.bag_item_type = item_data[arg_42_0.itemtype].bag_item_type
		var_42_0.buy_limit = arg_42_0.buy_limit or 1000000
		var_42_0.have_bought = arg_42_0.have_bought or 0
		var_42_0.sell_out = arg_42_0.buy_limit and arg_42_0.buy_limit <= arg_42_0.have_bought
		var_42_0.to_shop = arg_42_0.to_shop

		return var_42_0
	end)(arg_21_1))
end
