local network = require("network.network")
local item_manager = require("controller.item_manager")
local activity_manager = require("controller.activity_manager")
local discount_manager = require("controller.discount_manager")
local recharge_manager = require("controller.recharge_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local activity_bachelor_envelope_data = require("data.activity_envelope.activity_bachelor_envelope_data")
local activity_commodity_data = require("data.activity_commodity_data")

function ACTIVITY_OBJ_NEW.initModuleShop(arg_1_0, arg_1_1)
	return
end

function ACTIVITY_OBJ_NEW:get_activity_shopitem()
	network:rpc("get_activity_shopitem", {
		id = self._id
	}, function(arg_3_0)
		activity_manager:fireEvent(activity_manager.activityEventId.GET_ACTIVITY_SHOP_ITEM, arg_3_0)
	end)
end

function ACTIVITY_OBJ_NEW.rechargeForShopItem(arg_4_0, arg_4_1)
	network:rpc("check_recharge", {
		id = arg_4_1,
		client = config.clientmode
	}, function(arg_5_0)
		if arg_5_0.result == 1 then
			arg_4_0.recharging = false

			AnalyticManager.clickPurchaseItem({
				product = arg_4_0._id,
				rolenum = playermodel:getOwnedServantNum(),
				grade = playermodel.grade,
				class = playermodel.class
			})
			recharge_manager:confirmPayment(arg_4_1)
		elseif arg_5_0.result == 2 then
			print("测试模式")
		elseif arg_5_0.result == 3 then
			global_ShowBlockWords(L_RECAHRGE_GOODS_UNAVAILABLE)
		elseif arg_5_0.result == 4 then
			global_ShowBlockWords(L_RECHARGE_OUT_TIME)
		elseif arg_5_0.result == 5 then
			global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)
		elseif arg_5_0.result == 6 then
			global_ShowBlockWords(L_RECHARGE_CARD_LIMIT)
		end
	end)
end

function ACTIVITY_OBJ_NEW:buyActivityItem(arg_6_1)
	local var_6_0 = activity_commodity_data[self._id .. "_" .. arg_6_1].need_item
	local var_6_1
	local var_6_2

	if activity_commodity_data[self._id .. "_" .. arg_6_1].need_item ~= 0 and activity_commodity_data[self._id .. "_" .. arg_6_1].need_num > item_manager:getItemNumber(var_6_0) then
		LayerManager:pushInLayer("PopGoBuyGiftTicketLayer", {
			targetlayer = "PopSupermarketLayer"
		})

		do return end

		var_6_1 = {}
		var_6_2 = {
			title = L_BATTLEPASS_BUY.title
		}
	end

	var_6_2.des = string.format(L_WORD_COLLECT_SURE_DETAIL_1, var_6_0 == 0 and "魂晶" or item_data[var_6_0].name)
	var_6_2.button = L_BATTLEPASS_BUY.button
	var_6_1.labels = var_6_2

	function var_6_1.surecallback()
		network:rpc("buy_activity_item", {
			activityid = self._id,
			commodity = arg_6_1
		}, function(arg_8_0)
			if arg_8_0.result == 1 then
				global_gain(arg_8_0)

				if arg_8_0.costitem then
					for iter_8_0, iter_8_1 in pairs(arg_8_0.costitem) do
						if iter_8_1.itemid == 0 then
							playermodel:costDiamond(iter_8_1.num)
						else
							item_manager:deleteItem(iter_8_1.itemid, iter_8_1.num)
						end
					end
				end

				activity_manager:fireEvent(activity_manager.activityEventId.GET_ACTIVITY_SHOP_ITEM)
			elseif var_6_0 == 0 then
				LayerManager:pushInLayer("PopGoBuyDiamond", {
					is_need_pop_layer = 1
				})
			else
				LayerManager:pushInLayer("PopGoBuyGiftTicketLayer", {
					targetlayer = "PopSupermarketLayer"
				})
			end
		end)
	end

	LayerManager:pushInLayer("PopDoLayer", var_6_1)
end
