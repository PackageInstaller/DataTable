local activity_flop_conf_data = require("data.activity_flop_conf_data")
local var_0_1 = require("data.activity_flop_conf_data")
local activity_flop_condition_conf = require("data.activity_modules.activity_flop_condition_conf")
local activity_conf_data = require("data.activity_conf_data")
local item_data = require("data.item_data")
local var_0_5 = require("data.activity_modules.activity_flop_condition_conf")
local activity_flop_champion_data = require("data.activity_flop_champion_data")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local component_manager = require("controller.component_manager")
local network = require("network.network")
local playermodel = require("model.playermodel")

function ACTIVITY_OBJ_NEW:getActivityCommonFlopConf(arg_1_1)
	network:rpc("enter_commonflop_get_conf", {
		activityid = self._id
	}, function(arg_2_0)
		if arg_2_0.result == 1 then
			self:setCommonFlopTurns(arg_2_0.flop_turns)
			self:setChampionItems(arg_2_0.nowChampionData)
			self:setCanReset(arg_2_0.can_reset)
			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_COMMONFLOP_CONF_UPDATE, (self:decodeCommonFlopConf(arg_2_0)))
			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_COMMONFLOP_CHAMPIONS_UPDATE, arg_2_0.nowChampionData)

			if arg_1_1 then
				arg_1_1(arg_2_0)
			end
		elseif arg_2_0.result == 2 then
			global_ShowBlockWords(L_ACTIVITY_EXPLORE_CLOSE)
		elseif arg_2_0.result == 3 then
			global_ShowBlockWords("illegal error!!!")
		end
	end)
end

function ACTIVITY_OBJ_NEW:setActivityCommonFlopResult(arg_3_1, arg_3_2)
	network:rpc("set_activity_commonflop_result", {
		activityid = self._id,
		pos = arg_3_1
	}, function(arg_4_0)
		if arg_4_0.result == 1 then
			self:deleteFlopTicket(arg_4_0.consumes)
			self:setCanReset(arg_4_0.can_reset)

			local var_4_0 = {
				itemGain = {
					items = arg_4_0.items,
					gold = arg_4_0.gold,
					diamond = arg_4_0.diamond,
					itemformat = arg_4_0.itemformat
				},
				pos = arg_3_1,
				drawConf = self:getCommonItemByDropid(arg_4_0.dropid),
				isChampion = arg_4_0.isChampion
			}

			if arg_4_0.isChampion == true then
				self:setChampionItems(arg_4_0.nowChampionData)
				activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_COMMONFLOP_CHAMPIONS_UPDATE, arg_4_0.nowChampionData)
			end

			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_COMMONFLOP_SET_RESULT, var_4_0)

			if arg_3_2 then
				arg_3_2(var_4_0)
			end
		elseif arg_4_0.result == 2 then
			global_ShowBlockWords(L_FLOP_WARNING[2])

			if arg_3_2 then
				arg_3_2()
			end
		elseif arg_4_0.result == 3 then
			global_ShowBlockWords(L_FLOP_WARNING[3])

			if arg_3_2 then
				arg_3_2()
			end
		elseif arg_4_0.result == 4 then
			global_ShowBlockWords(L_FLOP_WARNING[4])

			if arg_3_2 then
				arg_3_2()
			end
		elseif arg_4_0.result == 5 then
			global_ShowBlockWords(L_FLOP_WARNING[5])

			if arg_3_2 then
				arg_3_2()
			end
		elseif arg_4_0.result == 6 then
			global_ShowBlockWords(L_FLOP_WARNING[6])

			if arg_3_2 then
				arg_3_2()
			end
		elseif arg_4_0.result == 7 then
			global_ShowBlockWords("还没有选择大奖哦~")

			if arg_3_2 then
				arg_3_2()
			end
		end
	end)
end

function ACTIVITY_OBJ_NEW:setCommonFlopChampionItems(arg_5_1, arg_5_2)
	network:rpc("set_champion_items", {
		activityid = self._id,
		ids = arg_5_1
	}, function(arg_6_0)
		if arg_6_0.result == 1 then
			self:setChampionItems(arg_6_0.nowChampionData)

			local var_6_0 = {
				activityid = self._id
			}

			var_6_0.flopturns = self:getCommonFlopTurns() or 1
			var_6_0.choose_list = arg_6_0.nowChampionData

			AnalyticManager.flopchoose(var_6_0)
			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_COMMONFLOP_CHAMPIONS_UPDATE, arg_6_0.nowChampionData)

			if arg_5_2 then
				arg_5_2()
			end
		elseif arg_6_0.result == 2 then
			global_ShowBlockWords(L_COMMONFLOP_TEXT[7])
		end
	end)
end

function ACTIVITY_OBJ_NEW:decodeCommonFlopConf(arg_7_1)
	local var_7_1 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1.card_conf) do
		var_7_1["pos_" .. iter_7_1.pos] = self:getCommonItemByDropid(iter_7_1.dropid)
		var_7_1["pos_" .. iter_7_1.pos].isChampion = self:isChampion(iter_7_1.order)
	end

	return var_7_1
end

function ACTIVITY_OBJ_NEW:isChampion(arg_8_1)
	for iter_8_0, iter_8_1 in pairs(self.championItems) do
		if iter_8_1.order ~= 0 and iter_8_1.order == arg_8_1 then
			return true
		end
	end

	return false
end

function ACTIVITY_OBJ_NEW:getCommonFlopLimitTurns()
	return var_0_5[self._id].flop_limit_turns
end

function ACTIVITY_OBJ_NEW:getCommonFlopTurns()
	return self.commonFlopTurns
end

function ACTIVITY_OBJ_NEW:getChampionItems()
	return self.championItems
end

function ACTIVITY_OBJ_NEW.setCommonFlopTurns(arg_12_0, arg_12_1)
	arg_12_0.commonFlopTurns = arg_12_1
end

function ACTIVITY_OBJ_NEW.setChampionItems(arg_13_0, arg_13_1)
	arg_13_0.championItems = arg_13_1
end

function ACTIVITY_OBJ_NEW.setCanReset(arg_14_0, arg_14_1)
	arg_14_0.can_reset = arg_14_1
end

function ACTIVITY_OBJ_NEW:getCanReset()
	return self.can_reset
end

function ACTIVITY_OBJ_NEW:getChampionConf()
	local var_16_0 = self:getCommonFlopTurns()
	local var_16_1 = self:getCommonSpecialTurns()

	return activity_flop_champion_data[self._id .. "-" .. ((var_16_1 and var_16_1 < self:getCommonFlopTurns() or nil) and var_16_1 + 1)]
end

function ACTIVITY_OBJ_NEW:getCommonSpecialTurns()
	return var_0_5[self._id].champion_special_turns
end

function ACTIVITY_OBJ_NEW:getCommonItemByDropid(arg_18_1)
	local var_18_0, var_18_1, var_18_2, var_18_3 = self:getCommonItemImage((drop_manager:getDropMsg(arg_18_1)))

	return {
		itemNum = var_18_0,
		itemImg = var_18_1,
		itemid = var_18_2,
		item_attr = var_18_3
	}
end

function ACTIVITY_OBJ_NEW.getCommonItemImage(arg_19_0, arg_19_1)
	if arg_19_1.diamond and arg_19_1.diamond > 0 then
		itemid = "diamond"

		return arg_19_1.diamond, 1000000, itemid
	elseif arg_19_1.gold and arg_19_1.gold > 0 then
		itemid = "gold"

		return arg_19_1.gold, 1000001, itemid
	elseif arg_19_1.equips and next(arg_19_1.equips) then
		for iter_19_0, iter_19_1 in pairs(arg_19_1.equips) do
			local var_19_2 = iter_19_1.dropid

			return iter_19_1.dropNum, item_data[iter_19_1.dropid].bag_item_type == kITEM_COMPONENT and component_manager:getComponentImageId(var_19_2) or item_data[var_19_2].image_id, var_19_2, iter_19_1.item_attr
		end
	end
end

function ACTIVITY_OBJ_NEW:goCommonNextTurn(arg_20_1)
	local function var_20_0()
		network:rpc("go_next_turn_common", {
			activityid = self._id
		}, function(arg_22_0)
			if arg_22_0.result == 1 then
				self:setCommonFlopTurns(arg_22_0.flop_turns)
				self:setCanReset(arg_22_0.can_reset)
				self:setChampionItems(arg_22_0.nowChampionData)

				local var_22_0 = self:decodeCommonFlopConf(arg_22_0)

				var_22_0.is_reset = arg_22_0.is_reset

				if arg_20_1 then
					arg_20_1(var_22_0, arg_22_0.is_reset)
				end

				activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_COMMONFLOP_CONF_UPDATE, var_22_0)
				activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_COMMONFLOP_CHAMPIONS_UPDATE, arg_22_0.nowChampionData)
			elseif arg_22_0.result == 2 then
				global_ShowBlockWords(L_FLOP_RESET_WARNING[2])
			elseif arg_22_0.result == 3 then
				global_ShowBlockWords(L_FLOP_RESET_WARNING[3])
			elseif arg_22_0.result == 4 then
				global_ShowBlockWords(string.format(L_FLOP_RESET_WARNING[4], "$$$$$$$$$$$$$$$$$$$$"))
			end
		end)
	end

	if not self:getCanReset() then
		global_ShowBlockWords(L_FLOP_RESET_WARNING[2])

		return
	elseif activity_flop_condition_conf[self._id].flop_limit_turns and self.flopTurns == activity_flop_condition_conf[self._id].flop_limit_turns then
		global_ShowBlockWords(L_FLOP_RESET_WARNING[3])

		return
	else
		LayerManager:pushInLayer("PopDoLayer", {
			labels = {
				title = L_FLOP_NEXT_TURN.title,
				des = L_FLOP_NEXT_TURN.des,
				button = L_FLOP_NEXT_TURN.button
			},
			surecallback = function()
				var_20_0()
			end
		})
	end
end

function ACTIVITY_OBJ_NEW:getNormalReward()
	local var_24_0 = self:getCommonFlopTurns()
	local var_24_1 = self:getCommonSpecialTurns()

	if var_24_1 and var_24_1 < self:getCommonFlopTurns() then
		var_24_0 = var_24_1 + 1
	end

	local var_24_2 = {}
	local var_24_3 = self:getMatrixConf()

	for iter_24_0 = 1, var_24_3 * var_24_3 do
		if var_0_1[self._id .. "-" .. var_24_0 .. "-1"]["dropid_" .. iter_24_0] ~= activity_flop_condition_conf[self._id].champion_item then
			table.insert(var_24_2, var_0_1[self._id .. "-" .. var_24_0 .. "-1"]["dropid_" .. iter_24_0])
		end
	end

	return var_24_2
end

function ACTIVITY_OBJ_NEW:getChampiontByTurns(arg_25_1)
	local var_25_0 = self:getCommonSpecialTurns()
	local var_25_1

	if var_25_0 and var_25_0 < arg_25_1 then
		arg_25_1 = var_25_0 + 1
		var_25_1 = {}
	end

	for iter_25_0 = 1, activity_flop_champion_data[self._id .. "-" .. arg_25_1].champions_num do
		table.insert(var_25_1, activity_flop_champion_data[self._id .. "-" .. arg_25_1]["champion_" .. iter_25_0])
	end

	return var_25_1
end

function ACTIVITY_OBJ_NEW:getAllTurnsChampion()
	local var_26_0 = {}

	for iter_26_0 = 1, self:getCommonSpecialTurns() + 1 do
		table.insert(var_26_0, self:getChampiontByTurns(iter_26_0))
	end

	return var_26_0
end

function ACTIVITY_OBJ_NEW:getCommonFlopPoint()
	return (item_manager:getItemNumber(activity_flop_condition_conf[self._id].key_point))
end

function ACTIVITY_OBJ_NEW:test11()
	network:rpc("test_commonflop_aa", {
		activityid = self._id
	}, function(arg_29_0)
		return
	end)
end

function ACTIVITY_OBJ_NEW:isCommonFlop()
	return activity_conf_data[self._id].commonflop
end

function ACTIVITY_OBJ_NEW:getFlopShopJump()
	return activity_flop_condition_conf[self._id].flop_shop
end

function ACTIVITY_OBJ_NEW:setCommonFlopThreeRandomChampion(arg_32_1)
	local var_32_0 = self:getChampionConf().champions_num
	local var_32_1 = {}
	local var_32_2 = {}

	for iter_32_0 = 1, var_32_0 do
		var_32_2[iter_32_0] = false
	end

	while #var_32_1 < 3 do
		local var_32_3 = math.random(var_32_0)

		if not var_32_2[var_32_3] then
			table.insert(var_32_1, var_32_3)

			var_32_2[var_32_3] = true
		end
	end

	self:setCommonFlopChampionItems(var_32_1, arg_32_1)
end
