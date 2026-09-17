local var_0_0 = {}
local network = require("network.network")
local item_manager = require("controller.item_manager")
local recharge_manager = require("controller.recharge_manager")
local account_manager = require("controller.account_manager")
local drop_manager = require("controller.drop_manager")
local playermodel = require("model.playermodel")
local discount_manager = require("controller.discount_manager")
local item_data = require("data.item_data")
local market_data = require("data.market_data")
local shop_currency_data = require("data.shop_currency_data")
local shop_data = require("data.shop_data")

SHOP_CURRENCY_DIAMOND = 0
SHOP_CURRENCY_GOLD = 1
SHOP_CURRENCY_HORNOR = 2
SHOP_CURRENCY_EXPLORECOIN = 3
SHOP_CURRENCY_ENERGY = 4
SHOP_CURRENCY_RMB = 100

local var_0_12 = {
	[SHOP_CURRENCY_GOLD] = function()
		return playermodel.gold
	end,
	[SHOP_CURRENCY_DIAMOND] = function()
		return playermodel.diamond
	end,
	[SHOP_CURRENCY_HORNOR] = function()
		return playermodel.honor
	end,
	[SHOP_CURRENCY_EXPLORECOIN] = function()
		return playermodel.explorecoin
	end,
	[SHOP_CURRENCY_RMB] = function()
		return 0
	end
}

setmetatable(var_0_12, {
	__index = function(arg_6_0, arg_6_1)
		return function()
			return item_manager:getItemNumber(arg_6_1)
		end
	end
})

local var_0_13 = {
	[6800202] = "public/currency/6800202.png",
	[SHOP_CURRENCY_GOLD] = "public/currency/UI_battleEnd_gold.png",
	[SHOP_CURRENCY_DIAMOND] = "public/currency/UI_battleEnd_diamond.png",
	[SHOP_CURRENCY_HORNOR] = "public/currency/arenascene_dot_1.png",
	[SHOP_CURRENCY_EXPLORECOIN] = "public/currency/explorecoin.png",
	[SHOP_CURRENCY_RMB] = "public/currency/rmb_white.png",
	[BLACK_CARD] = "public/currency/1500001_1.png",
	[BLACK_SP_CARD] = "public/currency/1500002_1.png",
	[85000006] = "equipment/" .. item_data[85000006].image_id .. ".png"
}

setmetatable(var_0_13, {
	__index = function(arg_8_0, arg_8_1)
		return "public/currency/" .. item_data[arg_8_1].image_id .. ".png"
	end
})

local var_0_14 = {
	[SHOP_CURRENCY_GOLD] = function(arg_9_0, arg_9_1)
		LayerManager:pushInLayer("PopGoGainLayer", {
			item = "gold",
			callback = arg_9_1
		})
	end,
	[SHOP_CURRENCY_DIAMOND] = function(arg_10_0, arg_10_1)
		LayerManager:pushInLayer("PopGoBuyDiamond", {
			is_need_pop_layer = 1,
			callback = arg_10_1
		})
	end,
	[SHOP_CURRENCY_HORNOR] = function(arg_11_0, arg_11_1)
		LayerManager:pushInLayer("PopGoLayer", {
			targetlayer = "ArenaLayer",
			labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_HORNOR
		})
	end,
	[SHOP_CURRENCY_EXPLORECOIN] = function(arg_12_0, arg_12_1)
		LayerManager:pushInLayer("PopGoLayer", {
			targetlayer = "ExploreMapLayer",
			labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_EXPLORECOIN
		})
	end,
	[BLACK_CARD] = function(arg_13_0, arg_13_1)
		LayerManager:pushInLayer("PopGoGainLayer", {
			item = BLACK_CARD
		})
	end,
	[BLACK_SP_CARD] = function(arg_14_0, arg_14_1)
		LayerManager:pushInLayer("PopGoGainLayer", {
			item = BLACK_SP_CARD
		})
	end,
	[GIFT_TICKET] = function(arg_15_0, arg_15_1)
		LayerManager:pushInLayer("PopGoBuyGiftTicketLayer", {
			targetlayer = "PopSupermarketLayer",
			callback = arg_15_1
		})
	end
}

setmetatable(var_0_14, {
	__index = function(arg_16_0, arg_16_1)
		return function(arg_17_0)
			if not item_data[arg_17_0].targetlayer1 then
				global_ShowBlockWords(string.format(L_COMMON_WARNING.Used_Up, item_data[arg_16_1].name))

				return
			end

			if arg_17_0 then
				LayerManager:pushInLayer("PopGoGainLayer", {
					item = arg_17_0
				})
			end

			require("controller.audio_manager"):playeffectMusicTest("sound/invalid")
		end
	end
})

local function var_0_15(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	local shop_manager = require("controller.shop_manager")

	if arg_18_0.currencytype == SHOP_CURRENCY_DIAMOND then
		playermodel.diamond = playermodel.diamond - arg_18_0.value

		global_update_gold_stone_diamond(nil, nil, arg_18_0.value)
	elseif arg_18_0.currencytype == SHOP_CURRENCY_GOLD then
		playermodel.gold = playermodel.gold - arg_18_0.value

		global_update_gold_stone_diamond(arg_18_0.value)
	elseif arg_18_0.currencytype == SHOP_CURRENCY_HORNOR then
		playermodel.honor = playermodel.honor - arg_18_0.value
	elseif arg_18_0.currencytype == SHOP_CURRENCY_EXPLORECOIN then
		-- block empty
	elseif arg_18_0.currencytype == SHOP_CURRENCY_ENERGY then
		-- block empty
	else
		item_manager:deleteItem(arg_18_0.currencytype, arg_18_0.value)
	end

	if arg_18_5 then
		global_get(arg_18_1)
	else
		global_gain(arg_18_1)
	end

	if arg_18_4 then
		arg_18_4(1)
	end
end

local function var_0_16(arg_19_0, arg_19_1)
	item_manager:deleteItem(arg_19_0.itemid, arg_19_0.itemcount)

	if arg_19_1.items then
		global_gain(arg_19_1)
	elseif arg_19_1.gaintype == SHOP_CURRENCY_DIAMOND then
		global_gain({
			diamond = arg_19_1.gainvalue
		})
	elseif arg_19_1.gaintype == SHOP_CURRENCY_GOLD then
		global_gain({
			gold = arg_19_1.gainvalue
		})
	elseif arg_19_1.gaintype == SHOP_CURRENCY_HORNOR then
		global_gain({
			honor = arg_19_1.gainvalue
		})
	elseif arg_19_1.gaintype == SHOP_CURRENCY_EXPLORECOIN then
		-- block empty
	elseif arg_19_1.gaintype == SHOP_CURRENCY_ENERGY then
		-- block empty
	end
end

local function var_0_17(arg_20_0)
	for iter_20_0, iter_20_1 in pairs((drop_manager:getAllDrops(item_data[arg_20_0].mode_id))) do
		if item_data[iter_20_1.dropid].bag_item_type == kITEM_SKIN then
			return iter_20_1.dropid
		end
	end
end

local function var_0_18(arg_21_0, arg_21_1, arg_21_2)
	network:rpc("get_shop_data", {
		shoptype = arg_21_1,
		channelid = account_manager:getChannel(),
		isantihexie = require("controller.antihexie_assets_manager"):isAntiHexieNow()
	}, function(arg_22_0)
		arg_21_0:set_buy_limit(arg_22_0.shoplist)
		arg_21_0:fix_shop_data(arg_22_0.shoplist)
		arg_21_0:hide_uncolor_clothes(arg_22_0.shoplist)

		if arg_21_2 then
			arg_21_2(arg_22_0.shoplist)
		end
	end)
end

function var_0_0.get_shop_data(arg_23_0, arg_23_1, arg_23_2)
	var_0_18(arg_23_0, arg_23_1, arg_23_2)
end

function var_0_0.fix_shop_data(arg_24_0, arg_24_1)
	local function var_24_0(arg_25_0)
		if item_data[arg_25_0.itemtype].id == 100 then
			print("因为物品表未配置,将商品[" .. arg_25_0.shopid .. "]/物品[" .. arg_25_0.itemtype .. "]的商品从显示中移除")

			return true
		end

		return false
	end

	while 1 <= #arg_24_1 do
		local var_24_1

		if var_24_0(arg_24_1[1]) then
			table.remove(arg_24_1, 1)
		else
			var_24_1 = 1 + 1
		end
	end
end

function var_0_0:hide_uncolor_clothes(arg_26_1)
	self.uncolorList = {}

	while 1 <= #arg_26_1 do
		local var_26_0

		if arg_26_1[1].buy_need_item then
			table.remove(arg_26_1, 1)

			self.uncolorList[var_0_17(arg_26_1[1].itemtype)] = arg_26_1[1]
		else
			var_26_0 = 1 + 1
		end
	end
end

function var_0_0.get_shop_clothes_data(arg_27_0, arg_27_1)
	network:rpc("get_shop_clothes_data", nil, function(arg_28_0)
		if arg_27_1 then
			arg_27_1((arg_28_0.shoplist or nil) and arg_27_0:initSkinShop(arg_28_0.shoplist, {
				skin = {},
				skin_package = {}
			}))
		end
	end)
end

function var_0_0.initSkinShop(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = {
		[kITEM_SKIN] = function(arg_30_0)
			arg_29_2.skin[arg_30_0.soulid] = arg_29_2.skin[arg_30_0.soulid] or {}

			if arg_30_0.shopinfo.have_bought < arg_30_0.shopinfo.buy_limit then
				arg_29_2.skin[arg_30_0.soulid][item_data[arg_30_0.shopinfo.itemtype].model] = arg_30_0
			end
		end,
		[kITEM_SKIN_GIFT] = function(arg_31_0)
			arg_29_2.skin_package[arg_31_0.soulid] = arg_29_2.skin_package[arg_31_0.soulid] or {}

			if arg_31_0.shopinfo.have_bought < arg_31_0.shopinfo.buy_limit then
				arg_29_2.skin_package[arg_31_0.soulid][item_data[arg_31_0.shopinfo.itemtype].model] = arg_31_0
			end
		end
	}

	for iter_29_0, iter_29_1 in pairs(arg_29_1) do
		if var_29_0[item_data[iter_29_1.shopinfo.itemtype].bag_item_type] then
			var_29_0[item_data[iter_29_1.shopinfo.itemtype].bag_item_type](iter_29_1)
		end
	end

	return arg_29_2
end

function var_0_0.set_buy_limit(arg_32_0, arg_32_1)
	local item_manager = require("controller.item_manager")

	for iter_32_0, iter_32_1 in pairs(arg_32_1) do
		if iter_32_1.unique_item and item_manager:getItemNumber(iter_32_1.unique_item) > 0 then
			arg_32_1[iter_32_0].have_bought = iter_32_1.buy_limit
		end
	end
end

function var_0_0.shop_buy(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5, arg_33_6, arg_33_7)
	arg_33_4 = arg_33_4 or 1

	network:rpc("shop_buy", {
		shoptype = arg_33_1,
		shopid = arg_33_2,
		buycount = arg_33_4,
		selectcurrencytype = arg_33_7
	}, function(arg_34_0)
		if arg_34_0.result == 1 then
			if arg_33_5 then
				arg_33_5()
			end

			if (arg_34_0.exchangetype or shop_currency_data[arg_33_1].exchangetype or 1) == 1 then
				var_0_15({
					value = arg_34_0.cost,
					currencytype = arg_34_0.currencytype
				}, {
					items = arg_34_0.item,
					gold = arg_34_0.gold,
					diamond = arg_34_0.diamond,
					itemformat = arg_34_0.itemformat
				}, 1, arg_33_1, arg_33_3, arg_33_6)

				local var_34_0 = {
					shoptype = "1-" .. arg_33_1,
					itemid = arg_34_0.item[1].itemid,
					currencytype = arg_34_0.currencytype
				}

				if arg_34_0.currencytype == SHOP_CURRENCY_DIAMOND then
					var_34_0.cost_diamond = arg_34_0.cost or 0
				end

				if shop_data[arg_33_2] then
					var_34_0.original_itemid = shop_data[arg_33_2].itemid or 0
				end

				AnalyticManager.shopBuySuccess(var_34_0)
			else
				var_0_16({
					itemid = arg_34_0.sellitem,
					itemcount = arg_34_0.sellcount
				}, {
					items = arg_34_0.item,
					gaintype = arg_34_0.currencytype,
					gainvalue = arg_34_0.cost
				})

				if arg_33_3 then
					arg_33_3(1)
				end
			end
		elseif arg_34_0.result == 2 then
			global_ShowBlockWords(L_MARKET_BUY_WARNING[2])

			if arg_33_3 then
				arg_33_3(2)
			end
		elseif arg_34_0.result == 3 then
			global_ShowBlockWords(L_MARKET_BUY_WARNING[3])

			if arg_33_3 then
				arg_33_3(3)
			end
		elseif arg_34_0.result == 6 then
			global_ShowBlockWords(COMMUNITY_POPCOMMUNITYBULIDINGLAYER.tips20)
		elseif arg_34_0.result == 7 then
			if arg_33_3 then
				arg_33_3(7)
			end

			global_ShowBlockWords(L_MARKET_MSG.END)
		elseif arg_34_0.result == 10 then
			global_ShowBlockWords(L_MARKET_BUY_WARNING[10])
		elseif arg_33_3 then
			arg_33_3(arg_34_0.result)
		end
	end)
end

function var_0_0.shop_buy_with_ticket(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4, arg_35_5, arg_35_6, arg_35_7)
	if not arg_35_6 then
		if arg_35_3 then
			arg_35_3(5)
		end

		return
	end

	arg_35_4 = arg_35_4 or 1
	arg_35_7 = arg_35_7 or 1

	network:rpc("shop_buy", {
		shoptype = arg_35_1,
		shopid = arg_35_2,
		buycount = arg_35_4,
		ticket = arg_35_6,
		ticketcount = arg_35_7
	}, function(arg_36_0)
		if arg_36_0.result == 1 then
			if arg_35_5 then
				arg_35_5()
			end

			if (shop_currency_data[arg_35_1].exchangetype or 1) == 1 then
				var_0_15({
					value = arg_36_0.cost,
					currencytype = arg_36_0.currencytype
				}, {
					items = arg_36_0.item,
					itemformat = arg_36_0.itemformat
				}, 1, arg_35_1, arg_35_3)

				if arg_36_0.ticketcost then
					item_manager:deleteItem(arg_35_6, arg_36_0.ticketcost)
				end

				local var_36_0 = {
					useticket = 1,
					shoptype = "1-" .. arg_35_1,
					itemid = arg_36_0.item[1].itemid,
					currencytype = arg_36_0.currencytype
				}

				if arg_36_0.currencytype == SHOP_CURRENCY_DIAMOND then
					var_36_0.cost_diamond = arg_36_0.cost or 0
				end

				var_36_0.original_itemid = shop_data[arg_35_2].itemid

				AnalyticManager.shopBuySuccess(var_36_0)
			else
				var_0_16({
					itemid = arg_36_0.sellitem,
					itemcount = arg_36_0.sellcount
				}, {
					items = arg_36_0.item,
					gaintype = arg_36_0.currencytype,
					gainvalue = arg_36_0.cost
				})

				if arg_35_3 then
					arg_35_3(1)
				end
			end
		else
			global_ShowBlockWords(L_MARKET_BUY_WARNING[arg_36_0.result])

			if arg_35_3 then
				arg_35_3(arg_36_0.result)
			end
		end
	end)
end

function var_0_0.shop_purchase(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	if arg_37_3 then
		arg_37_3()
	end

	recharge_manager:confirmPayment(arg_37_2)
end

function var_0_0.get_market_data(arg_38_0, arg_38_1, arg_38_2)
	network:rpc("get_market_data", {
		markettype = arg_38_1
	}, function(arg_39_0)
		local var_39_0 = {}

		for iter_39_0, iter_39_1 in pairs(arg_39_0.marketlist) do
			table.insert(var_39_0, iter_39_1)
		end

		if arg_38_2 then
			arg_38_2(var_39_0)
		end
	end)
end

function var_0_0.market_buy(arg_40_0, arg_40_1, arg_40_2, arg_40_3, arg_40_4, arg_40_5)
	arg_40_4 = arg_40_4 or 1

	network:rpc("market_buy", {
		markettype = arg_40_1,
		pos = arg_40_2,
		buycount = arg_40_4
	}, function(arg_41_0)
		if arg_41_0.result == 1 then
			if arg_40_5 then
				arg_40_5()
			end

			if (arg_41_0.exchangetype or market_data[arg_40_1].exchangetype or 1) == 1 then
				var_0_15({
					value = arg_41_0.cost,
					currencytype = arg_41_0.currencytype
				}, {
					items = arg_41_0.item,
					itemformat = arg_41_0.itemformat
				})

				local var_41_0 = {
					shoptype = "2-" .. arg_40_1,
					itemid = arg_41_0.item[1].itemid,
					currencytype = arg_41_0.currencytype
				}

				if arg_41_0.currencytype == SHOP_CURRENCY_GOLD then
					var_41_0.cost_gold = arg_41_0.cost or 0
				end

				AnalyticManager.marketBuySuccess(var_41_0)
			else
				var_0_16({
					itemid = arg_41_0.sellitem,
					itemcount = arg_41_0.sellcount
				}, {
					items = arg_41_0.item,
					gaintype = arg_41_0.currencytype,
					gainvalue = arg_41_0.cost
				})
				AnalyticManager.marketSellSuccess({
					itemid = arg_41_0.sellitem,
					get_gold = arg_41_0.cost
				})
			end

			if arg_40_3 then
				arg_40_3(1)
			end
		elseif arg_41_0.result == 2 then
			if arg_40_3 then
				arg_40_3(2)
			end
		elseif arg_41_0.result == 3 then
			if arg_41_0.currencytype == SHOP_CURRENCY_DIAMOND then
				global_riseWord(L_DIAMOND_LACK)
			elseif arg_41_0.currencytype == SHOP_CURRENCY_GOLD then
				global_riseWord(L_GOLD_LACK)
			elseif arg_41_0.currencytype == SHOP_CURRENCY_HORNOR then
				global_riseWord(L_MARKET_CURRENCY_LACK.HORNOR)
			elseif arg_41_0.currencytype == SHOP_CURRENCY_EXPLORECOIN then
				global_riseWord(L_MARKET_CURRENCY_LACK.EXPLORECOIN)
			elseif arg_41_0.currencytype == SHOP_CURRENCY_SMELT then
				global_riseWord(L_MARKET_CURRENCY_LACK.SMELT)
			end

			if arg_40_3 then
				arg_40_3(3)
			end
		elseif arg_40_3 then
			arg_40_3(0)
		end
	end)
end

function var_0_0.get_market_refresh_time(arg_42_0, arg_42_1, arg_42_2)
	network:rpc("get_market_refresh_time", {
		markettype = arg_42_1
	}, function(arg_43_0)
		if arg_43_0.result == 1 and arg_42_2 then
			arg_42_2(arg_43_0.time, arg_43_0.cost, arg_43_0.ismax)
		end
	end)
end

function var_0_0.refresh_market(arg_44_0, arg_44_1, arg_44_2)
	network:rpc("refresh_market", {
		markettype = arg_44_1
	}, function(arg_45_0)
		if arg_45_0.result == 1 then
			playermodel.diamond = playermodel.diamond - arg_45_0.diamond

			global_update_gold_stone_diamond(nil, nil, arg_45_0.diamond)
			AnalyticManager.refreshMarket({
				cost_diamond = arg_45_0.diamond
			})

			if arg_44_2 then
				arg_44_2(1)
			end
		elseif arg_45_0.result == 2 then
			global_riseWord(L_DIAMOND_LACK)

			if arg_44_2 then
				arg_44_2(2)
			end
		elseif arg_45_0.result == 3 then
			global_riseWord(L_MARKET_REFRESH_WARNING[3])

			if arg_44_2 then
				arg_44_2(3)
			end
		elseif arg_44_2 then
			arg_44_2(0)
		end
	end)
end

var_0_0.active_shop_list = nil
var_0_0.active_market_list = nil

function var_0_0:get_active_shoptype()
	return self.active_shop_list
end

function var_0_0.set_active_shoptype(arg_47_0, arg_47_1)
	arg_47_0.active_shop_list = arg_47_1
end

function var_0_0:update_active_shoptype(arg_48_1, arg_48_2)
	if arg_48_2 == "OPEN" then
		self.active_shop_list = self.active_shop_list or {}

		table.insert(self.active_shop_list, arg_48_1)
	elseif arg_48_2 == "CLOSE" then
		if not self.active_shop_list then
			return
		end

		for iter_48_0, iter_48_1 in ipairs(self.active_shop_list) do
			if iter_48_1 == arg_48_1 then
				table.remove(self.active_shop_list, iter_48_0)

				break
			end
		end
	end
end

function var_0_0:get_active_markettype()
	return self.active_market_list
end

function var_0_0.set_active_markettype(arg_50_0, arg_50_1)
	arg_50_0.active_market_list = arg_50_1
end

function var_0_0:update_active_markettype(arg_51_1, arg_51_2)
	if arg_51_2 == "OPEN" then
		self.active_market_list = self.active_market_list or {}

		table.insert(self.active_market_list, arg_51_1)
	elseif arg_51_2 == "CLOSE" then
		if not self.active_market_list then
			return
		end

		for iter_51_0, iter_51_1 in ipairs(self.active_market_list) do
			if iter_51_1 == arg_51_1 then
				table.remove(self.active_market_list, iter_51_0)

				break
			end
		end
	end
end

function var_0_0.is_collection(arg_52_0, arg_52_1)
	local function var_52_0(arg_53_0, arg_53_1)
		for iter_53_0, iter_53_1 in pairs(arg_53_0) do
			for iter_53_2, iter_53_3 in pairs(iter_53_1) do
				if iter_53_2 == "type" and iter_53_3 == arg_53_1 then
					return iter_53_0
				end
			end
		end

		return nil
	end

	local var_52_1 = var_52_0(market_data, arg_52_1) or var_52_0(shop_currency_data, arg_52_1)

	if shop_currency_data[var_52_1] and shop_currency_data[var_52_1].exchangetype == 2 or market_data[var_52_1] and market_data[var_52_1].exchangetype == 2 then
		return true
	end

	return false
end

function var_0_0.get_config_data(arg_54_0, arg_54_1)
	network:rpc("get_shop_config", {}, function(arg_55_0)
		if arg_54_1 then
			arg_54_1(1, arg_55_0.shopconfig)
		end
	end)
end

function var_0_0.get_config_data_single(arg_56_0, arg_56_1, arg_56_2, arg_56_3)
	network:rpc("get_shop_config", {
		shoptype = arg_56_1,
		need_reddot = arg_56_3
	}, function(arg_57_0)
		if arg_56_2 then
			arg_56_2(1, arg_57_0.shopconfig)
		end
	end)
end

function var_0_0.is_special_shopid(arg_58_0, arg_58_1)
	return arg_58_1 == 220001
end

function var_0_0:push_back_shop_buy_stack(arg_59_1)
	self.shop_buy_stack = self.shop_buy_stack or {}

	table.insert(self.shop_buy_stack, arg_59_1)
end

function var_0_0:pop_shop_buy_stack()
	return table.remove(self.shop_buy_stack)
end

function var_0_0:is_shop_buy_stack_empty()
	if not self.shop_buy_stack then
		return true
	end

	if not next(self.shop_buy_stack) then
		return true
	end
end

function var_0_0.clear_shop_buy_stack(arg_62_0)
	arg_62_0.shop_buy_stack = {}
end

function var_0_0.is_skin_shop(arg_63_0, arg_63_1)
	if string.split("-", arg_63_1)[1] == 1 then
		return
	end

	return shop_currency_data[string.split("-", arg_63_1)[2]] and shop_currency_data[string.split("-", arg_63_1)[2]].is_skin
end

function var_0_0:fixUnColorMsg(arg_64_1, arg_64_2)
	local var_64_0 = arg_64_1.uncolor_clothes
	local var_64_1 = self.uncolorList[arg_64_1.uncolor_clothes]
	local var_64_2 = arg_64_1.updateLayerCallback
	local var_64_3 = {
		[6800202] = "public/currency/6800202.png",
		[SHOP_CURRENCY_GOLD] = "public/currency/UI_battleEnd_gold.png",
		[SHOP_CURRENCY_DIAMOND] = "public/currency/UI_battleEnd_diamond.png",
		[SHOP_CURRENCY_HORNOR] = "public/currency/arenascene_dot_1.png",
		[SHOP_CURRENCY_EXPLORECOIN] = "public/currency/explorecoin.png",
		[SHOP_CURRENCY_RMB] = "public/currency/rmb_white.png",
		[BLACK_CARD] = "public/currency/1500001_1.png",
		[BLACK_SP_CARD] = "public/currency/1500002_1.png",
		[85000006] = "equipment/" .. item_data[85000006].image_id .. ".png"
	}

	setmetatable(var_64_3, {
		__index = function(arg_65_0, arg_65_1)
			return "public/currency/" .. item_data[arg_65_1].image_id .. ".png"
		end
	})

	local var_64_4 = (function(arg_66_0)
		if not arg_66_0 then
			return "-1"
		end

		local var_66_5 = global_get_time_by_date(arg_66_0) - playermodel.onlineTime
		local var_66_6 = math.floor(var_66_5 / 24 / 3600)
		local var_66_7 = math.floor((var_66_5 - var_66_6 * 24 * 3600) / 3600)
		local var_66_8 = math.floor((var_66_5 - var_66_6 * 24 * 3600 - var_66_7 * 3600) / 60)

		return var_66_6 ~= 0 and string.format(L_TIME_TEXT[1], var_66_6, var_66_7) or var_66_7 ~= 0 and string.format(L_TIME_TEXT[2], var_66_7, var_66_8) or string.format(L_TIME_TEXT[3], var_66_8)
	end)(self.uncolorList[arg_64_1.uncolor_clothes].finish_time)

	if var_64_4 ~= "-1" then
		var_64_4 = L_MARKET_REFRESH.Rest_Time .. var_64_4
	end

	local var_64_5 = {
		[SHOP_CURRENCY_GOLD] = function()
			return playermodel.gold
		end,
		[SHOP_CURRENCY_DIAMOND] = function()
			return playermodel.diamond
		end,
		[SHOP_CURRENCY_HORNOR] = function()
			return playermodel.honor
		end,
		[SHOP_CURRENCY_EXPLORECOIN] = function()
			return playermodel.explorecoin
		end,
		[SHOP_CURRENCY_RMB] = function()
			return 0
		end
	}

	setmetatable(var_64_5, {
		__index = function(arg_72_0, arg_72_1)
			return function()
				return item_manager:getItemNumber(arg_72_1)
			end
		end
	})

	local function var_64_6(arg_74_0)
		if not arg_74_0.currency2 or discount_manager:getLastPriceByItem(arg_74_0.itemid, arg_74_0.currency2, arg_74_0.discount2) < arg_74_0.discount2 then
			return true
		end

		return false
	end

	local function var_64_7(arg_75_0)
		if arg_75_0.result == 1 then
			local function var_75_0(arg_76_0)
				if arg_76_0 == 1 then
					self.uncolorList[var_64_0].have_bought = self.uncolorList[var_64_0].have_bought + 1
					self.uncolorList[var_64_0].buy_limit = self.uncolorList[var_64_0].buy_limit - self.uncolorList[var_64_0].have_bought

					if var_64_2 then
						var_64_2()
					end
				end
			end

			if arg_75_0.selectCoupon then
				self:shop_buy_with_ticket(arg_64_2, var_64_1.shopid, var_75_0, nil, function()
					LayerManager:removePopLayer()
				end, arg_75_0.selectCoupon, 1)
			else
				self:shop_buy(arg_64_2, var_64_1.shopid, var_75_0, nil, function()
					LayerManager:removePopLayer()
				end)
			end
		end
	end

	local var_64_8 = {
		hideGainButton = true,
		itemid = arg_64_1.uncolor_clothes,
		itemtype = self.uncolorList[arg_64_1.uncolor_clothes].itemtype,
		have_bought_num = self.uncolorList[arg_64_1.uncolor_clothes].have_bought,
		couponList = arg_64_1.couponList
	}
	local var_64_9 = {
		costtype = var_64_3[self.uncolorList[arg_64_1.uncolor_clothes].currency]
	}

	var_64_9.costnum = math.floor(self.uncolorList[arg_64_1.uncolor_clothes].discount or self.uncolorList[arg_64_1.uncolor_clothes].price)
	var_64_9.nowHave = self:getCurrencyNum(self.uncolorList[arg_64_1.uncolor_clothes].currency)
	var_64_8.slidecost = var_64_9
	var_64_8.currency = self.uncolorList[arg_64_1.uncolor_clothes].currency
	var_64_8.cost_old = self.uncolorList[arg_64_1.uncolor_clothes].price
	var_64_8.costIcon = var_64_3[self.uncolorList[arg_64_1.uncolor_clothes].currency]
	var_64_8.limitNum = self.uncolorList[arg_64_1.uncolor_clothes].buy_limit - self.uncolorList[arg_64_1.uncolor_clothes].have_bought
	var_64_8.limit_time = var_64_4
	var_64_8.index = arg_64_1.index
	var_64_8.limit_buy_num = self.uncolorList[arg_64_1.uncolor_clothes].buy_limit - self.uncolorList[arg_64_1.uncolor_clothes].have_bought

	function var_64_8:ShopSliderCallback(arg_79_1, arg_79_2, arg_79_3)
		if arg_79_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self:isBright() then
			return
		end

		if var_64_1.have_bought >= var_64_1.buy_limit then
			global_ShowBlockWords(L_MARKET_MSG.Sold_Out)

			return
		end

		if var_64_1.sell_time and timeCheckManager:getCurTime() < global_get_time_by_date(var_64_1.sell_time) then
			global_ShowBlockWords(var_64_1.sell_time .. L_START_BUY)

			return
		end

		if not self.nowNum then
			-- block empty
		end

		if var_64_6(var_64_1) and not arg_79_3 then
			if math.floor(var_64_1.discount or var_64_1.price) > var_64_5[var_64_1.currency]() then
				LayerManager:removePopLayer()
				LayerManager:pushInLayer("PopGoBuyGiftTicketLayer", {
					targetlayer = "PopSupermarketLayer",
					callback = updateCoinLabel
				})

				return
			end
		end

		self:setTouchEnabled(false)
		var_64_7({
			result = 1,
			selectCoupon = arg_79_3
		})
	end

	return var_64_8
end

function var_0_0.get_all_diamond_and_gold_items_price(arg_80_0)
	network:rpc("get_all_diamond_and_gold_items_price", {
		markettype = 1
	}, function(arg_81_0)
		local var_81_0 = cc.EventCustom:new("GET_BUY_ONEKEY_DATA")

		var_81_0.gold = arg_81_0.gold
		var_81_0.diamond = arg_81_0.diamond

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_81_0)
	end)
end

function var_0_0.buy_diamond_and_gold_items_onekey(arg_82_0, arg_82_1, arg_82_2)
	network:rpc("buy_diamond_and_gold_items_onekey", {
		markettype = 1,
		usegold = arg_82_1,
		usediamond = arg_82_2
	}, function(arg_83_0)
		local var_83_0 = {}

		if arg_83_0.result == 1 then
			playermodel.gold = playermodel.gold - arg_83_0.costgold
			playermodel.diamond = playermodel.diamond - arg_83_0.costdiamond

			global_update_gold_stone_diamond(arg_83_0.costgold, nil, arg_83_0.costdiamond)

			local var_83_1 = {
				items = {},
				itemformat = {}
			}

			for iter_83_0, iter_83_1 in ipairs(arg_83_0.buyres) do
				for iter_83_2, iter_83_3 in ipairs(iter_83_1.item) do
					if iter_83_3.itemcount ~= item_manager:getItemNumberByEntityId(iter_83_3.entityid) then
						table.insert(var_83_1.items, iter_83_3)
					end
				end

				table.insert(var_83_0, {
					pos = iter_83_1.pos,
					buycount = iter_83_1.buycount
				})
			end

			if #var_83_1.items > 0 then
				global_gain(var_83_1)
			end
		end

		local var_83_2 = cc.EventCustom:new("BUY_ONEKEY_SUCCESS")

		var_83_2.result = arg_83_0.result
		var_83_2.markettype = "2-1"
		var_83_2.marketitems = var_83_0
		var_83_2.costgold = arg_83_0.costgold
		var_83_2.costdiamond = arg_83_0.costdiamond

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_83_2)
	end)
end

function var_0_0.purchase_shop_currency(arg_84_0, arg_84_1, arg_84_2, arg_84_3, arg_84_4)
	network:rpc("purchase_shop_currency", {
		itemid = arg_84_1,
		num = arg_84_2
	}, function(arg_85_0)
		if arg_85_0.result == 1 then
			for iter_85_0, iter_85_1 in ipairs(arg_85_0.consumes) do
				item_manager:deleteItem(iter_85_1.entityid, iter_85_1.num)
			end

			playermodel.diamond = playermodel.diamond - (arg_85_0.cost_diamond or 0)

			if arg_84_4 then
				global_get({
					items = arg_85_0.items
				})
			else
				global_gain({
					items = arg_85_0.items
				})
			end

			if arg_84_3 then
				arg_84_3()
			end
		elseif arg_85_0.result == 2 then
			global_ShowBlockWords("配置错误")
		elseif arg_85_0.result == 3 then
			global_ShowBlockWords("兑换失败")
		end
	end)
end

function var_0_0.refresh_shop(arg_86_0, arg_86_1, arg_86_2)
	network:rpc("refresh_shop", {
		shoptype = arg_86_1,
		channelid = account_manager:getChannel(),
		isantihexie = require("controller.antihexie_assets_manager"):isAntiHexieNow()
	}, function(arg_87_0)
		if arg_86_2 then
			arg_86_2(arg_87_0)
		end
	end)
end

function var_0_0.getCurrencyNum(arg_88_0, arg_88_1)
	return var_0_12[arg_88_1](arg_88_1)
end

function var_0_0.getCurrencyIcon(arg_89_0, arg_89_1)
	return var_0_13[arg_89_1]
end

function var_0_0.judgeNumber(arg_90_0, arg_90_1)
	if not arg_90_1.currency2 or discount_manager:getLastPriceByItem(arg_90_1.itemid, arg_90_1.currency2, arg_90_1.discount2) < arg_90_1.discount2 then
		return true
	end

	return false
end

function var_0_0:getBuyLimit(arg_91_1)
	local var_91_0 = 0
	local var_91_1 = arg_91_1.itemid or arg_91_1.itemtype
	local var_91_2 = arg_91_1.currency
	local var_91_3 = arg_91_1.buy_limit
	local var_91_4 = arg_91_1.have_bought
	local var_91_5 = self:judgeNumber(arg_91_1) and math.floor(self:getCurrencyNum(arg_91_1.currency) / (arg_91_1.cost or arg_91_1.price)) or math.floor(self:getCurrencyNum(arg_91_1.currency2) / (arg_91_1.cost2 or arg_91_1.price2))

	var_91_0 = var_91_1 == 9000004 and var_91_2 == 9000005 and (var_91_3 and (var_91_3 - var_91_4 >= 999 and 999 or var_91_3 - var_91_4) or 999) or var_91_3 and (var_91_3 - var_91_4 >= SHOP_NORMAL_BUY_LIMIT_NUM and SHOP_NORMAL_BUY_LIMIT_NUM or var_91_3 - var_91_4) or SHOP_NORMAL_BUY_LIMIT_NUM
	var_91_0 = var_91_0 < var_91_5 and var_91_0 or var_91_5

	return var_91_0
end

function var_0_0.pushBuyWeaponPop(arg_92_0, arg_92_1, arg_92_2)
	local var_92_0 = require("data.servant_data")[arg_92_1].recommend_weapon2
	local shop_data = require("data.shop_data")
	local var_92_2
	local var_92_3
	local var_92_4
	local var_92_5
	local var_92_6
	local var_92_7
	local var_92_8 = {
		[52] = true,
		[53] = true,
		[55] = true,
		[51] = true,
		[54] = true,
		[56] = true
	}

	for iter_92_0, iter_92_1 in pairs(shop_data) do
		if var_92_8[iter_92_1.shop_type] and iter_92_1.itemid == var_92_0 then
			var_92_2 = iter_92_1.id

			break
		end
	end

	if var_92_2 then
		var_0_18(arg_92_0, shop_data[var_92_2].shop_type, function(arg_93_0)
			arg_92_0:set_buy_limit(arg_93_0)
			arg_92_0:fix_shop_data(arg_93_0)
			arg_92_0:hide_uncolor_clothes(arg_93_0)

			for iter_93_0, iter_93_1 in pairs(arg_93_0) do
				if iter_93_1.shopid == var_92_2 then
					var_92_3 = iter_93_1
				end
			end

			local var_93_0

			if arg_92_0:judgeNumber(var_92_3) then
				var_93_0 = var_92_3.currency
				var_92_5 = var_92_3.discount or var_92_3.price
			else
				var_93_0 = var_92_3.currency2
				var_92_5 = var_92_3.discount2 or var_92_3.price2
			end

			var_92_6 = arg_92_0:getCurrencyIcon(var_93_0)
			var_92_4 = arg_92_0:getCurrencyNum(var_93_0)
			var_92_7 = arg_92_0:getBuyLimit(var_92_3)

			local var_93_1 = {
				shopid = var_92_2,
				activity_level = var_92_3.activity_level,
				have_bought = var_92_3.have_bought
			}

			var_93_1.buy_limit = var_92_3.buy_limit or 1000000
			var_93_1.sell_time = var_92_3.sell_time
			var_93_1.cost = var_92_5
			var_93_1.currency = var_93_0
			arg_92_0.popShopInfo = var_93_1

			LayerManager:pushInLayer("PopGoodsLayer", {
				shopid = var_92_2,
				slidecost = {
					nowHave = var_92_4,
					costnum = var_92_5,
					costtype = var_92_6
				},
				itemid = var_92_0,
				limitNum = var_92_7
			})

			if arg_92_2 then
				arg_92_2()
			end
		end)
	end
end

function var_0_0:getPopShopInfo()
	return self.popShopInfo
end

function var_0_0.isWeaponMax(arg_95_0, arg_95_1, arg_95_2, arg_95_3)
	if item_data[arg_95_2].bag_item_type ~= kITEM_WEAPON then
		return false
	end

	local var_95_0 = 0

	if playermodel.weaponId[item_data[arg_95_2].servant] then
		for iter_95_0 = playermodel.items[playermodel.weaponId[item_data[arg_95_2].servant]].weapon_attr.nowStars + 1, item_data[playermodel.items[playermodel.weaponId[item_data[arg_95_2].servant]].itemid].max_star do
			var_95_0 = var_95_0 + item_data[arg_95_2]["upgrade_need_num" .. iter_95_0]
		end

		var_95_0 = var_95_0 - item_manager:getItemNumber(arg_95_2) + 1
	else
		var_95_0 = 1

		while item_data[arg_95_2]["upgrade_need_num" .. 1] do
			var_95_0 = var_95_0 + item_data[arg_95_2]["upgrade_need_num" .. 1]
		end

		var_95_0 = var_95_0 - item_manager:getItemNumber(arg_95_2)
	end

	if var_95_0 < arg_95_3 then
		return true
	end

	return false
end

function var_0_0.popGoGain(arg_96_0, arg_96_1, arg_96_2)
	var_0_14[arg_96_1](arg_96_1, arg_96_2)
end

return var_0_0
