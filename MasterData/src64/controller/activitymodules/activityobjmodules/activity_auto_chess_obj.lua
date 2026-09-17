local activity_manager = require("controller.activity_manager")
local autochess_conf_data = require("data.autochess_conf_data")
local activity_conf_data = require("data.activity_conf_data")
local playermodel = require("model.playermodel")
local network = require("network.network")
local item_manager = require("controller.item_manager")

function ACTIVITY_OBJ_NEW:get_auto_chess_info()
	network:rpc("activity_autochess_data", {
		activityid = self._id
	}, function(arg_2_0)
		if arg_2_0.result == 1 then
			self.autoChessServants = arg_2_0.servants
			self.autoChessRedom = arg_2_0.random

			self:updateAutoChessArrayByString(arg_2_0.array)
			activity_manager:fireEvent(activity_manager.activityEventId.AUTOCHESS_LIST_UPDATE, arg_2_0)
		end
	end)
end

function ACTIVITY_OBJ_NEW:activity_autochess_select(arg_3_1)
	network:rpc("activity_autochess_select", {
		activityid = self._id,
		id = arg_3_1
	}, function(arg_4_0)
		if arg_4_0.result == 1 then
			if arg_4_0.cost_items then
				for iter_4_0, iter_4_1 in ipairs(arg_4_0.cost_items) do
					item_manager:deleteItem(iter_4_1.entityid, iter_4_1.num)
				end
			end

			self.autoChessRedom = arg_4_0.random

			self:updateAutoChessServants(arg_4_0.servants)
			self:updateAutoChessArrayByString(arg_4_0.array)
			global_ShowBlockWords(L_AUTO_CHESS.selectSucc)
			activity_manager:fireEvent(activity_manager.activityEventId.AUTOCHESS_SELECT_SUCCESS, arg_4_0)
		elseif arg_4_0.result == 2 then
			global_ShowBlockWords(L_AUTO_CHESS.selectmoney)
		end
	end)
end

function ACTIVITY_OBJ_NEW:activity_autochess_set_array(arg_5_1)
	local var_5_0 = {}

	for iter_5_0 = 1, 6 do
		if arg_5_1[iter_5_0] then
			table.insert(var_5_0, arg_5_1[iter_5_0].servantid .. "_" .. arg_5_1[iter_5_0].star)
		else
			table.insert(var_5_0, "")
		end
	end

	network:rpc("activity_autochess_set_array", {
		activityid = self._id,
		array = var_5_0
	}, function(arg_6_0)
		if arg_6_0.result == 1 then
			self:updateAutoChessArrayByString(var_5_0)
		end
	end)
end

function ACTIVITY_OBJ_NEW:activity_autochess_upstar(arg_7_1, arg_7_2)
	network:rpc("activity_autochess_upstar", {
		activityid = self._id,
		id = arg_7_1,
		star = arg_7_2
	}, function(arg_8_0)
		if arg_8_0.result == 1 then
			global_ShowBlockWords(L_AUTO_CHESS.upstarsucc)
			self:get_auto_chess_info()
		end
	end)
end

function ACTIVITY_OBJ_NEW:activity_autochess_refresh()
	network:rpc("activity_autochess_refresh", {
		activityid = self._id
	}, function(arg_10_0)
		if arg_10_0.result == 1 then
			if arg_10_0.cost_diamond then
				playermodel.diamond = playermodel.diamond - arg_10_0.cost_diamond

				global_update_gold_stone_diamond(nil, nil, -arg_10_0.cost_diamond)
			end

			if arg_10_0.cost_items then
				for iter_10_0, iter_10_1 in ipairs(arg_10_0.cost_items) do
					item_manager:deleteItem(iter_10_1.entityid, iter_10_1.num)
				end
			end

			self.autoChessRedom = arg_10_0.random

			activity_manager:fireEvent(activity_manager.activityEventId.AUTOCHESS_LIST_UPDATE, arg_10_0)
		elseif arg_10_0.result == 2 then
			if self:getAutoChessRefreshNeedItem() == 888888 then
				LayerManager:pushInLayer("PopGoBuyDiamond", {
					is_need_pop_layer = 1
				})
			else
				global_ShowBlockWords(L_POPCARDBUFFLAYER.shop_1)
			end
		end
	end)
end

function ACTIVITY_OBJ_NEW.getAutoChessServantCost(arg_11_0)
	return 2
end

function ACTIVITY_OBJ_NEW:getAutoChessSelectNeedItem()
	return autochess_conf_data[self._id].recruit_item
end

function ACTIVITY_OBJ_NEW:getAutoChessJumpID()
	return autochess_conf_data[self._id].jump
end

function ACTIVITY_OBJ_NEW:getAutoChessServantList()
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in pairs(self.autoChessServants) do
		for iter_14_2 = 1, iter_14_1.count do
			table.insert(var_14_0, {
				servantid = iter_14_1.id,
				star = iter_14_1.star
			})
		end
	end

	table.sort(var_14_0, function(arg_15_0, arg_15_1)
		return arg_15_0.star > arg_15_1.star
	end)

	return var_14_0
end

function ACTIVITY_OBJ_NEW:getMaxStarByContrant(arg_16_1)
	return autochess_conf_data[self._id]["star_contract_" .. arg_16_1]
end

function ACTIVITY_OBJ_NEW:updateAutoChessArrayByString(arg_17_1)
	if not arg_17_1 or not next(arg_17_1) then
		return
	end

	self.autoChessArray = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		if iter_17_1 and iter_17_1 ~= "" then
			local var_17_0 = string.split(iter_17_1, "_")

			self.autoChessArray[iter_17_0] = {
				id = tonumber(var_17_0[1]),
				star = tonumber(var_17_0[2])
			}
		end
	end
end

function ACTIVITY_OBJ_NEW:getAutoChessArray()
	return self.autoChessArray or {}
end

function ACTIVITY_OBJ_NEW:getAutoChessUpstarNeedList(arg_19_1, arg_19_2)
	local var_19_0 = false
	local var_19_1 = {}
	local var_19_2 = (function(arg_20_0)
		return autochess_conf_data[self._id]["upstar_cost_" .. arg_20_0 - 1]
	end)(arg_19_2)
	local var_19_3 = var_19_2

	for iter_19_0, iter_19_1 in pairs(self.autoChessServants) do
		if iter_19_1.id == arg_19_1 and iter_19_1.star == arg_19_2 - 1 then
			if var_19_2 <= iter_19_1.count then
				var_19_0 = true
				var_19_3 = var_19_2
			else
				var_19_0 = false
				var_19_3 = iter_19_1.count
			end
		end
	end

	for iter_19_2 = 1, var_19_3 do
		table.insert(var_19_1, {
			count = 1,
			star = arg_19_2 - 1,
			id = arg_19_1
		})
	end

	return var_19_1, var_19_0, math.max(0, var_19_2 - var_19_3)
end

function ACTIVITY_OBJ_NEW:getAutoChessReNeed()
	return autochess_conf_data[self._id].refresh_cost
end

function ACTIVITY_OBJ_NEW:getAutoChessRefreshNeedItem()
	if not autochess_conf_data[self._id].refresh_id or autochess_conf_data[self._id].refresh_id == 0 then
		return 888888
	end

	return autochess_conf_data[self._id].refresh_id
end

function ACTIVITY_OBJ_NEW:getAutoChessRedomList()
	return self.autoChessRedom
end

function ACTIVITY_OBJ_NEW:updateAutoChessServants(arg_24_1)
	local var_24_0

	for iter_24_0, iter_24_1 in ipairs(arg_24_1) do
		var_24_0 = iter_24_1.id
	end

	for iter_24_2, iter_24_3 in pairs(self.autoChessServants) do
		if iter_24_3.id == var_24_0 then
			self.autoChessServants[iter_24_2] = nil
		end
	end

	for iter_24_4, iter_24_5 in ipairs(arg_24_1) do
		table.insert(self.autoChessServants, iter_24_5)
	end
end

function ACTIVITY_OBJ_NEW:addAutoChessSelectted(arg_25_1)
	local var_25_0 = false

	for iter_25_0, iter_25_1 in pairs(self.autoChessServants) do
		if iter_25_1.id == arg_25_1.id and iter_25_1.star == arg_25_1.star then
			iter_25_1.count = iter_25_1.count + 1
			var_25_0 = true
		end
	end

	if not var_25_0 then
		table.insert(self.autoChessServants, arg_25_1)
	end
end

function ACTIVITY_OBJ_NEW:canAutoChessServantUpStar(arg_26_1)
	for iter_26_0, iter_26_1 in pairs(self.autoChessServants) do
		if iter_26_1.id == arg_26_1 and iter_26_1.star == 1 then
			return true
		end
	end

	return false
end
