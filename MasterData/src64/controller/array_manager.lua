local var_0_0 = {}
local playermodel = require("model.playermodel")
local network = require("network.network")
local arena_manager = require("controller.arena_manager")
local explore_manager = require("controller.explore_manager")
local item_manager = require("controller.item_manager")
local level_manager = require("controller.level_manager")
local servant_data = require("data.servant_data")
local horcrux_data = require("data.horcrux_data")
local chapter_data = require("data.chapter_data")
local levelmode_data = require("data.levelmode_data")
local model_data = require("data.model_data")

MAX_ARRAY_COUNT = 10

local var_0_12 = 0
local var_0_13 = 1

var_0_0.cursoulchange = false
var_0_0.curArray = nil
var_0_0.last_refight_arry = nil

function var_0_0.addArray(arg_1_0, arg_1_1)
	if #playermodel.arrays >= MAX_ARRAY_COUNT and arg_1_1 then
		arg_1_1(2)
	end

	network:rpc("add_array", nil, function(arg_2_0)
		if arg_2_0.result == 1 then
			playermodel.arrays[#playermodel.arrays + 1] = arg_2_0.array

			if arg_2_0.diamond then
				playermodel.diamond = playermodel.diamond - arg_2_0.diamond
			end

			global_update_gold_stone_diamond(nil, nil, arg_2_0.diamond)

			if arg_1_1 then
				arg_1_1(1)
			end

			AnalyticManager.add_array()
		elseif arg_2_0.result == 2 then
			if arg_1_1 then
				arg_1_1(2)
			end
		elseif arg_2_0.result == 3 and arg_1_1 then
			arg_1_1(3)
		end
	end)
end

function var_0_0.getArrayStat(arg_3_0, arg_3_1)
	return playermodel.arrays[arg_3_1].stat
end

function var_0_0.isArrayHangup(arg_4_0, arg_4_1)
	return arg_4_1 == playermodel.curArray
end

function var_0_0.isArrayCurHangup(arg_5_0, arg_5_1)
	return arg_5_1 == playermodel.curArray
end

function var_0_0:isServantInHangup(arg_6_1)
	if not arg_6_1 then
		return false
	end

	local var_6_1 = self:getBattleArrayData(playermodel.curArray)

	if not var_6_1 then
		return false
	end

	for iter_6_0, iter_6_1 in pairs(var_6_1) do
		if iter_6_1.fight_girl == arg_6_1 then
			return true
		end
	end

	return false
end

function var_0_0.getArrayByServantID(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(playermodel.arrays) do
		for iter_7_2 = 1, FORMATION_SHOW_GIRL_NUM do
			if iter_7_1["pos_" .. iter_7_2].fight_girl == arg_7_1 then
				return iter_7_1.id
			end
		end
	end

	return nil
end

function var_0_0:isServantInArrayNow(arg_8_1)
	return self:getArrayByServantID(arg_8_1) ~= nil
end

function var_0_0.getArrayByHorcruxID(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(playermodel.arrays) do
		for iter_9_2 = 1, FORMATION_SHOW_GIRL_NUM do
			if iter_9_1["pos_" .. iter_9_2].assist_girl == arg_9_1 then
				return iter_9_1.id, iter_9_2
			end
		end
	end

	return nil
end

function var_0_0.getAreanAttackByHorcruxID(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs(playermodel.arenaAttackArray) do
		if iter_10_1.assist_girl == arg_10_1 then
			return 1
		end
	end

	return nil
end

function var_0_0.getAreanDefenceByHorcruxID(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in pairs(playermodel.arenaArray) do
		if iter_11_1.assist_girl == arg_11_1 then
			return 1
		end
	end

	return nil
end

function var_0_0.getArenaAttackByServantid(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in pairs(playermodel.arenaAttackArray) do
		if iter_12_1.fight_girl == arg_12_1 then
			return iter_12_1.pos
		end
	end
end

function var_0_0.getArenaDefenceByServantid(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in pairs(playermodel.arenaArray) do
		if iter_13_1.fight_girl == arg_13_1 then
			return iter_13_1.pos
		end
	end
end

function var_0_0:isHorcruxInArrayNow(arg_14_1)
	return self:getArrayByHorcruxID(arg_14_1) ~= nil
end

function var_0_0.isArrayPatrol(arg_15_0, arg_15_1)
	return false
end

function var_0_0.isServantPatrolNow(arg_16_0, arg_16_1)
	return require("controller.patrol_manager"):isServantPatrolNow()
end

function var_0_0.isHorcruxPatrolNow(arg_17_0, arg_17_1)
	return false
end

var_0_0.isSoulInHangup = var_0_0.isServantInHangup

function var_0_0.getLevelArray(arg_18_0, arg_18_1)
	return playermodel.curArray
end

function var_0_0.getExploreArray(arg_19_0)
	return explore_manager:getExplorePlayer()
end

local function var_0_15(arg_20_0)
	for iter_20_0 = 1, 4 do
		if playermodel.arrays[arg_20_0]["pos_" .. iter_20_0].fight_girl then
			return playermodel.arrays[arg_20_0]["pos_" .. iter_20_0].fight_girl
		end
	end
end

local function var_0_16(arg_21_0)
	return string.format("%02d:%02d:%02d", math.floor(arg_21_0 / 3600), math.floor(arg_21_0 % 3600 / 60), arg_21_0 % 60)
end

function var_0_0:updateArrayFightgirl(arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5)
	if not playermodel.arrays[arg_22_1] then
		if arg_22_5 then
			arg_22_5(0)
		end

		return
	end

	if self:isArrayPatrol(arg_22_1) then
		if arg_22_5 then
			arg_22_5(8)
		end

		return
	end

	if arg_22_3 then
		if not level_manager:isPlayerPassLevel(BATTLEARRAY_SOUL_UNLOCK[arg_22_2]) then
			if arg_22_5 then
				arg_22_5(0)
			end

			return
		end

		if playermodel.arrays[arg_22_1]["pos_" .. arg_22_2].fight_girl == arg_22_3 then
			if arg_22_5 then
				arg_22_5(0)
			end

			return
		end

		if not playermodel.haveServant[arg_22_3] then
			if arg_22_5 then
				arg_22_5(2)
			end

			return
		end

		for iter_22_0 = 1, FORMATION_SHOW_GIRL_NUM do
			if playermodel.arrays[arg_22_1]["pos_" .. iter_22_0].fight_girl == arg_22_3 then
				if arg_22_5 then
					arg_22_5(4)
				end

				return
			end
		end
	else
		if playermodel.arrays[arg_22_1]["pos_" .. arg_22_2].fight_girl == nil then
			if arg_22_5 then
				arg_22_5(0)
			end

			return
		end

		if self:isArrayHangup(arg_22_1) then
			local var_22_0 = 0

			for iter_22_1 = 1, FORMATION_SHOW_GIRL_NUM do
				if playermodel.arrays[arg_22_1]["pos_" .. arg_22_2].fight_girl then
					var_22_0 = var_22_0 + 1
				end
			end

			if var_22_0 <= 1 then
				if arg_22_5 then
					arg_22_5(5)
				end

				return
			end
		end
	end

	local var_22_1 = arg_22_3 or "null"

	network:rpc("update_array_fightgirl", {
		id = arg_22_1,
		pos = arg_22_2,
		servantid = arg_22_3,
		isCancelPatrol = arg_22_4
	}, function(arg_23_0)
		if arg_23_0.result == 1 then
			playermodel.arrays[arg_22_1] = arg_23_0.array

			local var_23_0 = "null"

			for iter_23_0, iter_23_1 in pairs(arg_23_0.array) do
				if type(iter_23_1) == "table" and iter_23_1.pos == arg_22_2 then
					var_23_0 = iter_23_1.fight_girl or "null"
				end
			end

			AnalyticManager.update_array_fightgirl({
				set_before_fight_girl = var_22_1,
				set_after_fight_girl = var_23_0
			})

			if self:isArrayCurHangup(arg_22_1) then
				self:registerHangupArrayChange()
			end

			if arg_23_0.updateassist then
				for iter_23_2, iter_23_3 in pairs(arg_23_0.updateassist) do
					item_manager:setItemByServerItem(iter_23_3)
				end
			end

			local var_23_1

			if arg_23_0.patrolmsg and arg_23_0.robbed_array then
				var_23_1 = var_0_15(arg_23_0.robbed_array.id)
			end

			if arg_23_0.robbed_array then
				playermodel.arrays[arg_23_0.robbed_array.id] = arg_23_0.robbed_array

				if self:isArrayCurHangup(arg_23_0.robbed_array.id) then
					self:registerHangupArrayChange()
				end
			end

			if arg_23_0.patrolmsg then
				local patrol_manager = require("controller.patrol_manager")

				if arg_23_0.patrolmsg.diamond and arg_23_0.patrolmsg.diamond < 0 then
					playermodel.diamond = playermodel.diamond + arg_23_0.patrolmsg.diamond

					global_update_gold_stone_diamond(nil, nil, playermodel.diamond)

					arg_23_0.patrolmsg.diamond = 0
				end

				local var_23_3, var_23_4, var_23_5, var_23_6, var_23_7, var_23_8, var_23_9, var_23_10 = global_get(arg_23_0.patrolmsg)

				if var_23_3 == 0 and var_23_4 == 0 then
					if next(var_23_7) ~= nil then
						LayerManager:pushInLayer("PopPatrolResult", {
							gold = var_23_3,
							diamond = var_23_4,
							honor = var_23_5,
							sp = var_23_6,
							energy = var_23_8,
							items = var_23_7,
							name = chapter_data[arg_23_0.patrolmsg.mode .. "-" .. arg_23_0.patrolmsg.chapter].name,
							servantid = var_23_1,
							time = var_0_16(arg_23_0.patrolmsg.costtime)
						})
					end
				end

				patrol_manager:updatePatrolModel(arg_23_0.patrolmsg.patrolInfo)

				local alert_manager = require("controller.alert_manager")

				alert_manager:check_weapon_update(false)
				alert_manager:check_component_update(false)
			end

			if arg_22_5 then
				arg_22_5(1)
			end
		else
			if arg_23_0.result == 9 and arg_23_0.patrolmsg.result == 3 then
				LayerManager:pushInLayer("PopGoBuyDiamond", {
					is_need_pop_layer = 0
				})
			end

			if arg_22_5 then
				arg_22_5(arg_23_0.result)
			end
		end
	end)
end

function var_0_0:updateArrayAssistgirl(arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5)
	if not playermodel.arrays[arg_24_1] then
		if arg_24_5 then
			arg_24_5(0)
		end

		return
	end

	if playermodel.arrays[arg_24_1]["pos_" .. arg_24_2].assist_girl == arg_24_3 then
		if arg_24_5 then
			arg_24_5(0)
		end

		return
	end

	if self:isArrayPatrol(arg_24_1) then
		if arg_24_5 then
			arg_24_5(7)
		end

		return
	end

	if arg_24_3 then
		if not level_manager:isPlayerPassLevel(BATTLEARRAY_HORCRUX_UNLOCK[arg_24_2]) then
			if arg_24_5 then
				arg_24_5(0)
			end

			return
		end

		if not playermodel.arrays[arg_24_1]["pos_" .. arg_24_2].fight_girl then
			if arg_24_5 then
				arg_24_5(5)
			end

			return
		end

		if not playermodel.items[arg_24_3] then
			if arg_24_5 then
				arg_24_5(2)
			end

			return
		end
	end

	if arg_24_3 then
		local var_24_0 = playermodel.items[arg_24_3].itemid or "null"
	end

	network:rpc("update_array_assistgirl", {
		id = arg_24_1,
		pos = arg_24_2,
		assistgirl = arg_24_3,
		isCancelPatrol = arg_24_4
	}, function(arg_25_0)
		if arg_25_0.result == 1 then
			playermodel.arrays[arg_24_1] = arg_25_0.array

			local var_25_0 = "null"

			for iter_25_0, iter_25_1 in pairs(arg_25_0.array) do
				if type(iter_25_1) == "table" and iter_25_1.pos == arg_24_2 then
					var_25_0 = iter_25_1.assist_girl and playermodel.items[iter_25_1.assist_girl].itemid or "null"
				end
			end

			AnalyticManager.update_array_assistgirl({
				set_before_horcrux = var_24_0,
				set_after_horcrux = var_25_0
			})

			if self:isArrayCurHangup(arg_24_1) then
				self:registerHangupArrayChange()
			end

			if arg_25_0.updateassist then
				for iter_25_2, iter_25_3 in pairs(arg_25_0.updateassist) do
					item_manager:setItemByServerItem(iter_25_3)
				end
			end

			local var_25_1

			if arg_25_0.patrolmsg and arg_25_0.robbed_array then
				var_25_1 = var_0_15(arg_25_0.robbed_array.id)
			end

			if arg_25_0.robbed_array then
				playermodel.arrays[arg_25_0.robbed_array.id] = arg_25_0.robbed_array
			end

			if arg_25_0.patrolmsg then
				local patrol_manager = require("controller.patrol_manager")

				if arg_25_0.patrolmsg.diamond and arg_25_0.patrolmsg.diamond < 0 then
					playermodel.diamond = playermodel.diamond + arg_25_0.patrolmsg.diamond

					global_update_gold_stone_diamond(nil, nil, playermodel.diamond)

					arg_25_0.patrolmsg.diamond = 0
				end

				local var_25_3, var_25_4, var_25_5, var_25_6, var_25_7, var_25_8, var_25_9, var_25_10 = global_get(arg_25_0.patrolmsg)

				if var_25_3 == 0 and var_25_4 == 0 then
					if next(var_25_7) ~= nil then
						LayerManager:pushInLayer("PopPatrolResult", {
							gold = var_25_3,
							diamond = var_25_4,
							honor = var_25_5,
							sp = var_25_6,
							energy = var_25_8,
							items = var_25_7,
							name = chapter_data[arg_25_0.patrolmsg.mode .. "-" .. arg_25_0.patrolmsg.chapter].name,
							servantid = var_25_1,
							time = var_0_16(arg_25_0.patrolmsg.costtime)
						})
					end
				end

				patrol_manager:updatePatrolModel(arg_25_0.patrolmsg.patrolInfo)
			end

			require("controller.alert_manager"):check_horcrux_strenghth(false)

			if arg_24_5 then
				arg_24_5(1)
			end
		else
			if arg_25_0.result == 9 and arg_25_0.patrolmsg.result == 3 then
				LayerManager:pushInLayer("PopGoBuyDiamond", {
					is_need_pop_layer = 0
				})
			end

			if arg_24_5 then
				arg_24_5(arg_25_0.result)
			end
		end
	end)
end

function var_0_0.updateExploreArrayAssistgirl(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	print("updateExploreArrayAssistgirl is Deprecated!!!!")
end

function var_0_0:cleanArray(arg_27_1, arg_27_2)
	if not playermodel.arrays[arg_27_1] then
		if arg_27_2 then
			arg_27_2(0)
		end

		return
	end

	if self:isArrayHangup(arg_27_1) then
		if arg_27_2 then
			arg_27_2(2)
		end

		return
	end

	if self:isArrayPatrol(arg_27_1) then
		if arg_27_2 then
			arg_27_2(4)
		end

		return
	end

	network:rpc("clean_array", {
		id = arg_27_1
	}, function(arg_28_0)
		if arg_28_0.result == 1 then
			playermodel.arrays[arg_27_1] = arg_28_0.array

			if arg_28_0.updateassist then
				for iter_28_0, iter_28_1 in pairs(arg_28_0.updateassist) do
					item_manager:setItemByServerItem(iter_28_1)
				end
			end

			if arg_27_2 then
				arg_27_2(1)
			end
		elseif arg_27_2 then
			arg_27_2(arg_28_0.result)
		end
	end)
end

function var_0_0.getBattleArrayData(arg_29_0, arg_29_1)
	if not playermodel.arrays[arg_29_1] then
		return nil
	end

	local var_29_0 = {}

	for iter_29_0 = 1, FORMATION_SHOW_GIRL_NUM do
		var_29_0[iter_29_0] = clone(playermodel.arrays[arg_29_1]["pos_" .. iter_29_0])
		var_29_0[iter_29_0].assist = playermodel.arrays[arg_29_1].assist or {}
	end

	return var_29_0
end

function var_0_0.getBattleArraySingleData(arg_30_0, arg_30_1, arg_30_2)
	if not playermodel.arrays[arg_30_1] then
		return nil
	end

	return playermodel.arrays[arg_30_1]["pos_" .. arg_30_2]
end

function var_0_0.getArrayName(arg_31_0, arg_31_1)
	if not playermodel.arrays[arg_31_1] then
		return ""
	end

	return playermodel.arrays[arg_31_1].name
end

function var_0_0.setArrayName(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	print("setArrayName is Deprecated!!!!!")
end

function var_0_0.registerHangupArrayChange(arg_33_0)
	arg_33_0.cursoulchange = true
end

function var_0_0:executeHangupArrayChange()
	if self.cursoulchange then
		FightManager.registerPlayerReplace()

		self.cursoulchange = false

		AlertManager:check_servant_strenghth()
		AlertManager:check_horcrux_strenghth()
		cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))
	end
end

function var_0_0.resetHangupArray(arg_35_0, arg_35_1)
	arg_35_0.curArray = arg_35_1 or playermodel.curArray

	AlertManager:check_servant_strenghth()
	AlertManager:check_horcrux_strenghth()
end

function var_0_0:setHangupArray(...)
	local var_36_0
	local var_36_1
	local var_36_2 = {
		...
	}

	if #var_36_2 == 3 then
		var_36_0 = var_36_2[2]
		var_36_1 = var_36_2[3]
	else
		var_36_0 = var_36_2[1]
		var_36_1 = var_36_2[2]
	end

	if not playermodel.arrays[var_36_0] then
		if var_36_1 then
			var_36_1(3)
		end

		return
	end

	if var_36_0 == playermodel.curArray then
		if var_36_1 then
			var_36_1(1)
		end

		return
	end

	if self:isArrayPatrol(var_36_0) then
		if var_36_1 then
			var_36_1(5)
		end

		return
	end

	local var_36_3 = 0

	for iter_36_0 = 1, FORMATION_SHOW_GIRL_NUM do
		if playermodel.arrays[var_36_0]["pos_" .. iter_36_0].fight_girl then
			var_36_3 = var_36_3 + 1
		end
	end

	if var_36_3 <= 0 then
		if var_36_1 then
			var_36_1(2)
		end

		return
	end

	network:rpc("set_hangup_array", {
		id = var_36_0
	}, function(arg_37_0)
		if arg_37_0.result == 1 then
			playermodel.curArray = arg_37_0.cur_array
			playermodel.arrays[playermodel.curArray].stat = var_0_12
			playermodel.arrays[var_36_0].stat = var_0_13

			self:registerHangupArrayChange()
			AnalyticManager.set_hangup_array({
				arrayid = arg_37_0.cur_array
			})

			if var_36_1 then
				var_36_1(1)
			end
		elseif var_36_1 then
			var_36_1(arg_37_0.result)
		end
	end)
end

function var_0_0:checkAdventureArray(arg_38_1)
	if not playermodel.arrays[arg_38_1] then
		return false, 0
	end

	if self:isArrayPatrol(arg_38_1) then
		return false, 2
	end

	local var_38_0 = 0

	for iter_38_0 = 1, FORMATION_SHOW_GIRL_NUM do
		if playermodel.arrays[arg_38_1]["pos_" .. iter_38_0].fight_girl then
			var_38_0 = var_38_0 + 1
		end
	end

	if var_38_0 <= 0 then
		return false, 1
	end

	AnalyticManager.selectArraySuccess(arg_38_1)

	return true
end

local var_0_17 = {
	wind = true,
	water = true,
	fire = true,
	light = true,
	dark = true
}

function var_0_0.checkIsSameColorTeam(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = true

	if not arg_39_2 or not arg_39_1 then
		return var_39_0
	end

	if not levelmode_data[arg_39_2] then
		return var_39_0
	end

	local var_39_1 = levelmode_data[arg_39_2].ele_type or levelmode_data[arg_39_2].element_type

	if not var_39_1 then
		return var_39_0
	end

	if levelmode_data[arg_39_2].ele_type_show then
		var_39_1 = levelmode_data[arg_39_2].ele_type_show .. ",imaginary"
	end

	local var_39_2 = {}
	local var_39_3 = {
		true,
		true,
		true,
		true,
		true
	}

	for iter_39_0 in var_39_1:gmatch("([^,]+)") do
		table.insert(var_39_2, iter_39_0)
	end

	local formation_mode_manager = require("controller.formation.formation_mode_manager")
	local var_39_5 = formation_mode_manager:getInstance():getFormationInfo()[arg_39_1]

	if not formation_mode_manager then
		var_39_5 = {}
	end

	local var_39_6 = 0

	for iter_39_1 = 1, FORMATION_SHOW_GIRL_NUM do
		if var_39_5[iter_39_1].fight_girl then
			var_39_6 = var_39_6 + 1

			local var_39_7 = false
			local var_39_8 = false

			for iter_39_2, iter_39_3 in ipairs(var_39_2) do
				if model_data[servant_data[var_39_5[iter_39_1].fight_girl].modelid][iter_39_3] then
					var_39_7 = true

					break
				end

				if var_0_17[iter_39_3] then
					var_39_8 = true
				end
			end

			if not var_39_7 and var_39_8 and model_data[servant_data[var_39_5[iter_39_1].fight_girl].modelid].imaginary then
				var_39_7 = true
			end

			var_39_3[iter_39_1] = var_39_7
		end
	end

	for iter_39_4, iter_39_5 in pairs(var_39_3) do
		if not iter_39_5 then
			var_39_0 = false

			break
		end
	end

	if not var_39_0 then
		if #var_39_2 == 1 then
			global_ShowBlockWords(L_SPECIAL_JUMPTOWERLAYER.other1 .. L_SORT_ATTR[ATTR_INDEX[var_39_2[1]]] .. L_SPECIAL_JUMPTOWERLAYER.other2)
		else
			local var_39_9 = 1
			local var_39_10 = ""

			while var_39_2[var_39_9] do
				var_39_10 = var_39_9 == #var_39_2 and var_39_10 .. L_SORT_ATTR[ATTR_INDEX[var_39_2[var_39_9]]] or var_39_10 .. L_SORT_ATTR[ATTR_INDEX[var_39_2[var_39_9]]] .. "/"
				var_39_9 = var_39_9 + 1
			end

			if #var_39_2 > 4 and #var_39_2 <= 5 then
				global_ShowBlockWords(L_SPECIAL_JUMPTOWERLAYER.other1 .. var_39_10 .. L_SPECIAL_JUMPTOWERLAYER.other2, nil, nil, nil, nil, 26)
			elseif #var_39_2 > 5 then
				global_ShowBlockWords(L_SPECIAL_JUMPTOWERLAYER.other1 .. var_39_10 .. L_SPECIAL_JUMPTOWERLAYER.other2, nil, nil, nil, nil, 24)
			else
				global_ShowBlockWords(L_SPECIAL_JUMPTOWERLAYER.other1 .. var_39_10 .. L_SPECIAL_JUMPTOWERLAYER.other2)
			end
		end
	end

	if var_39_6 == 0 then
		var_39_0 = false

		global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Adventure[1], RISE_WORDS_FAIL)
	end

	return var_39_0
end

function var_0_0:checkExploreArray(arg_40_1)
	if not playermodel.arrays[arg_40_1] then
		return false, 0
	end

	if self:isArrayPatrol(arg_40_1) then
		return false, 2
	end

	local var_40_0 = 0

	for iter_40_0 = 1, FORMATION_SHOW_GIRL_NUM do
		if playermodel.arrays[arg_40_1]["pos_" .. iter_40_0].fight_girl then
			var_40_0 = var_40_0 + 1
		end
	end

	if var_40_0 <= 0 then
		return false, 1
	end

	return true
end

function var_0_0:checkPatrolArray(arg_41_1, arg_41_2)
	if not playermodel.arrays[arg_41_1] then
		return false, 0
	end

	if self:isArrayPatrol(arg_41_1) then
		return false, 2
	end

	if self:isArrayHangup(arg_41_1) then
		return false, 3
	end

	local var_41_0 = {}
	local var_41_1 = 0

	for iter_41_0 = 1, FORMATION_SHOW_GIRL_NUM do
		if playermodel.arrays[arg_41_1]["pos_" .. iter_41_0].fight_girl then
			var_41_0[iter_41_0] = playermodel.arrays[arg_41_1]["pos_" .. iter_41_0]
			var_41_1 = var_41_1 + 1
		end
	end

	if var_41_1 <= 0 then
		return false, 1
	end

	if require("controller.fight_capacity_manager"):getArrayFightCapacity(var_41_0) < (arg_41_2 or 1) then
		return false, 4
	end

	AnalyticManager.selectArraySuccess(arg_41_1)

	return true
end

function var_0_0.getPatrolChpater(arg_42_0, arg_42_1)
	return require("controller.patrol_manager"):getCurArrayPatrolChpater(arg_42_1)
end

function var_0_0:setArenaArray(arg_43_1)
	if not playermodel.arrays[arg_43_1] then
		return false, 0
	end

	if self:isArrayPatrol(arg_43_1) then
		return false, 2
	end

	local var_43_0 = 0

	for iter_43_0 = 1, FORMATION_SHOW_GIRL_NUM do
		if playermodel.arrays[arg_43_1]["pos_" .. iter_43_0].fight_girl then
			var_43_0 = var_43_0 + 1
		end
	end

	if var_43_0 <= 0 then
		return false, 1
	end

	arena_manager:setArenaFightArray(arg_43_1)
	AnalyticManager.selectArraySuccess(arg_43_1)

	return true
end

function var_0_0:setRefightArray(arg_44_1)
	if not playermodel.arrays[arg_44_1] then
		return false, 0
	end

	if self:isArrayPatrol(arg_44_1) then
		return false, 2
	end

	local var_44_0 = 0

	for iter_44_0 = 1, FORMATION_SHOW_GIRL_NUM do
		if playermodel.arrays[arg_44_1]["pos_" .. iter_44_0].fight_girl then
			var_44_0 = var_44_0 + 1
		end
	end

	if var_44_0 <= 0 then
		return false, 1
	end

	level_manager:setRefightArray(arg_44_1)
	AnalyticManager.selectArraySuccess(arg_44_1)

	self.last_refight_array = arg_44_1

	return true
end

function var_0_0.setArenaDefenceArray(arg_45_0, arg_45_1, arg_45_2)
	print("setArenaDefenceArray is Deprecated!!!!")
end

function var_0_0.getArenaAttackArray(arg_46_0)
	local var_46_0 = {}

	for iter_46_0, iter_46_1 in pairs(playermodel.arenaAttackArray) do
		if string.find(iter_46_0, "pos_") then
			var_46_0[iter_46_1.pos] = {
				pos = iter_46_1.pos,
				fight_girl = iter_46_1.fight_girl,
				assist_girl = iter_46_1.assist_girl
			}
		elseif iter_46_0 == "assist" then
			var_46_0.assist = iter_46_1
		end
	end

	return var_46_0
end

function var_0_0.getCurrFriendArray(arg_47_0)
	local var_47_0 = {}

	for iter_47_0, iter_47_1 in pairs(playermodel.arenaAttackArray) do
		var_47_0[iter_47_1.pos] = {
			pos = iter_47_1.pos,
			fight_girl = iter_47_1.fight_girl,
			assist_girl = iter_47_1.assist_girl
		}
	end

	return var_47_0
end

function var_0_0.getArenaDefenceArray(arg_48_0)
	local var_48_0 = {}

	for iter_48_0, iter_48_1 in pairs(playermodel.arenaArray) do
		if string.find(iter_48_0, "pos_") then
			var_48_0[iter_48_1.pos] = {
				pos = iter_48_1.pos,
				fight_girl = iter_48_1.fight_girl,
				assist_girl = iter_48_1.assist_girl
			}
		elseif iter_48_0 == "assist" then
			var_48_0.assist = iter_48_1
		end
	end

	return var_48_0
end

function var_0_0:horcruxIsDefenceArray(arg_49_1)
	if not playermodel.arenaArray then
		return false
	end

	for iter_49_0, iter_49_1 in pairs((self:getArenaDefenceArray())) do
		if arg_49_1 == iter_49_1.assist_girl then
			return true
		end
	end

	return false
end

function var_0_0.updateArenaDefenceArray(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
	if arg_50_2 then
		if not level_manager:isPlayerPassLevel(BATTLEARRAY_SOUL_UNLOCK[arg_50_1]) then
			if arg_50_3 then
				arg_50_3({
					result = 0
				})
			end

			return
		end

		if playermodel.arenaArray["pos_" .. arg_50_1].fight_girl == arg_50_2 then
			if arg_50_3 then
				arg_50_3({
					result = 0
				})
			end

			return
		end

		if not playermodel.haveServant[arg_50_2] then
			if arg_50_3 then
				arg_50_3({
					result = 2
				})
			end

			return
		end

		for iter_50_0 = 1, FORMATION_SHOW_GIRL_NUM do
			if playermodel.arenaArray["pos_" .. iter_50_0].fight_girl == arg_50_2 then
				if arg_50_3 then
					arg_50_3({
						result = 4
					})
				end

				return
			end
		end
	else
		if playermodel.arenaArray["pos_" .. arg_50_1].fight_girl == nil then
			if arg_50_3 then
				arg_50_3({
					result = 0
				})
			end

			return
		end

		local var_50_0 = 0

		for iter_50_1 = 1, FORMATION_SHOW_GIRL_NUM do
			if playermodel.arenaArray["pos_" .. iter_50_1].fight_girl then
				var_50_0 = var_50_0 + 1
			end
		end

		if var_50_0 <= 1 then
			if arg_50_3 then
				arg_50_3({
					result = 5
				})
			end

			return
		end
	end

	local var_50_1 = arg_50_2 or "null"

	network:rpc("update_array_fightgirl", {
		id = -1,
		pos = arg_50_1,
		servantid = arg_50_2
	}, function(arg_51_0)
		if arg_51_0.result == 1 then
			playermodel.arenaArray = arg_51_0.array

			local var_51_0 = "null"

			for iter_51_0, iter_51_1 in pairs(arg_51_0.array) do
				if type(iter_51_1) == "table" and iter_51_1.pos == arg_50_1 then
					var_51_0 = iter_51_1.fight_girl or "null"
				end
			end

			AnalyticManager.update_arena_defence_servant({
				set_before_fight_girl = var_50_1,
				set_after_fight_girl = var_51_0
			})

			if arg_51_0.updateassist then
				for iter_51_2, iter_51_3 in pairs(arg_51_0.updateassist) do
					item_manager:setItemByServerItem(iter_51_3)
				end
			end

			if arg_50_3 then
				arg_50_3(arg_51_0)
			end
		elseif arg_50_3 then
			arg_50_3(arg_51_0)
		end
	end)
end

function var_0_0.updateArenaDefenceArrayAssistgirl(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	if playermodel.arenaArray["pos_" .. arg_52_1].assist_girl == arg_52_2 then
		if arg_52_3 then
			arg_52_3({
				result = 0
			})
		end

		return
	end

	if arg_52_2 then
		if not level_manager:isPlayerPassLevel(BATTLEARRAY_HORCRUX_UNLOCK[arg_52_1]) then
			if arg_52_3 then
				arg_52_3({
					result = 0
				})
			end

			return
		end

		if not playermodel.arenaArray["pos_" .. arg_52_1].fight_girl then
			if arg_52_3 then
				arg_52_3({
					result = 5
				})
			end

			return
		end

		if not playermodel.items[arg_52_2] then
			if arg_52_3 then
				arg_52_3({
					result = 2
				})
			end

			return
		end
	end

	if arg_52_2 then
		local var_52_0 = playermodel.items[arg_52_2].itemid or "null"
	end

	network:rpc("update_array_assistgirl", {
		id = -1,
		pos = arg_52_1,
		assistgirl = arg_52_2
	}, function(arg_53_0)
		if arg_53_0.result == 1 then
			playermodel.arenaArray = arg_53_0.array

			local var_53_0 = "null"

			for iter_53_0, iter_53_1 in pairs(arg_53_0.array) do
				if type(iter_53_1) == "table" and iter_53_1.pos == arg_52_1 then
					var_53_0 = iter_53_1.assist_girl and playermodel.items[iter_53_1.assist_girl].itemid or "null"
				end
			end

			AnalyticManager.update_arena_defence_horcrux({
				set_before_horcrux = var_52_0,
				set_after_horcrux = var_53_0
			})

			if arg_53_0.updateassist then
				for iter_53_2, iter_53_3 in pairs(arg_53_0.updateassist) do
					item_manager:setItemByServerItem(iter_53_3)
				end
			end

			if arg_52_3 then
				arg_52_3(arg_53_0)
			end
		elseif arg_52_3 then
			arg_52_3(arg_53_0)
		end
	end)
end

function var_0_0.updateArenaAttackArray(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	if arg_54_2 then
		if not level_manager:isPlayerPassLevel(BATTLEARRAY_SOUL_UNLOCK[arg_54_1]) then
			if arg_54_3 then
				arg_54_3({
					result = 0
				})
			end

			return
		end

		if playermodel.arenaAttackArray["pos_" .. arg_54_1].fight_girl == arg_54_2 then
			if arg_54_3 then
				arg_54_3({
					result = 0
				})
			end

			return
		end

		if not playermodel.haveServant[arg_54_2] then
			if arg_54_3 then
				arg_54_3({
					result = 2
				})
			end

			return
		end

		for iter_54_0 = 1, FORMATION_SHOW_GIRL_NUM do
			if playermodel.arenaAttackArray["pos_" .. iter_54_0].fight_girl == arg_54_2 then
				if arg_54_3 then
					arg_54_3({
						result = 4
					})
				end

				return
			end
		end
	else
		if playermodel.arenaAttackArray["pos_" .. arg_54_1].fight_girl == nil then
			if arg_54_3 then
				arg_54_3({
					result = 0
				})
			end

			return
		end

		local var_54_0 = 0

		for iter_54_1 = 1, FORMATION_SHOW_GIRL_NUM do
			if playermodel.arenaAttackArray["pos_" .. iter_54_1].fight_girl then
				var_54_0 = var_54_0 + 1
			end
		end

		if var_54_0 <= 1 then
			if arg_54_3 then
				arg_54_3({
					result = 5
				})
			end

			return
		end
	end

	network:rpc("update_array_fightgirl", {
		id = -2,
		pos = arg_54_1,
		servantid = arg_54_2
	}, function(arg_55_0)
		if arg_55_0.result == 1 then
			playermodel.arenaAttackArray = arg_55_0.array

			if arg_54_3 then
				arg_54_3(arg_55_0)
			end
		elseif arg_54_3 then
			arg_54_3(arg_55_0)
		end
	end)
end

function var_0_0.updateArenaAttackArrayAssistgirl(arg_56_0, arg_56_1, arg_56_2, arg_56_3)
	if playermodel.arenaAttackArray["pos_" .. arg_56_1].assist_girl == arg_56_2 then
		if arg_56_3 then
			arg_56_3({
				result = 0
			})
		end

		return
	end

	if arg_56_2 then
		if not level_manager:isPlayerPassLevel(BATTLEARRAY_HORCRUX_UNLOCK[arg_56_1]) then
			if arg_56_3 then
				arg_56_3({
					result = 0
				})
			end

			return
		end

		if not playermodel.arenaAttackArray["pos_" .. arg_56_1].fight_girl then
			if arg_56_3 then
				arg_56_3({
					result = 5
				})
			end

			return
		end

		if not playermodel.items[arg_56_2] then
			if arg_56_3 then
				arg_56_3({
					result = 2
				})
			end

			return
		end
	end

	if not arg_56_2 or not playermodel.items[arg_56_2].itemid then
		-- block empty
	end

	network:rpc("update_array_assistgirl", {
		id = -2,
		pos = arg_56_1,
		assistgirl = arg_56_2
	}, function(arg_57_0)
		if arg_57_0.result == 1 then
			playermodel.arenaAttackArray = arg_57_0.array

			if arg_56_3 then
				arg_56_3(arg_57_0)
			end
		elseif arg_56_3 then
			arg_56_3(arg_57_0)
		end
	end)
end

function var_0_0.getServantPos(arg_58_0, arg_58_1)
	local var_58_0 = var_0_0:getArrayByHorcruxID(servantId)

	for iter_58_0, iter_58_1 in pairs(playermodel.arrays) do
		while iter_58_1["pos_" .. 1] do
			if iter_58_1["pos_" .. 1].fight_girl == arg_58_1 then
				return 1
			end
		end
	end
end

function var_0_0.getHorcruxPos(arg_59_0, arg_59_1)
	local var_59_0 = var_0_0:getArrayByHorcruxID(arg_59_1)

	for iter_59_0, iter_59_1 in pairs(playermodel.arrays) do
		while iter_59_1["pos_" .. 1] do
			if iter_59_1["pos_" .. 1].assist_girl == arg_59_1 then
				return 1
			end
		end
	end
end

function var_0_0.getAnyFreeArray(arg_60_0)
	for iter_60_0, iter_60_1 in ipairs(playermodel.arrays) do
		if iter_60_1.stat == var_0_12 then
			return iter_60_0
		end
	end
end

function var_0_0:updateArrayOneKey(arg_61_1, arg_61_2, arg_61_3)
	local var_61_0, var_61_1 = self:check_battlearray_info_valid(arg_61_2)

	if not var_61_0 then
		if arg_61_3 then
			arg_61_3(var_61_1)
		end

		return
	end

	network:rpc("update_array_onekey", {
		id = arg_61_1,
		battlearray = arg_61_2
	}, function(arg_62_0)
		if arg_62_0.result == 1 then
			playermodel.arrays[arg_61_1] = arg_62_0.array

			if self:isArrayCurHangup(arg_61_1) then
				self:registerHangupArrayChange()
			end

			if arg_62_0.updateassist then
				for iter_62_0, iter_62_1 in ipairs(arg_62_0.updateassist) do
					item_manager:setItemByServerItem(iter_62_1)
				end
			end

			if arg_62_0.robbed_arrays then
				for iter_62_2, iter_62_3 in ipairs(arg_62_0.robbed_arrays) do
					playermodel.arrays[iter_62_3.id] = iter_62_3

					if self:isArrayCurHangup(iter_62_3.id) then
						self:registerHangupArrayChange()
					end
				end
			end

			if arg_61_3 then
				arg_61_3(1)
			end
		elseif arg_61_3 then
			arg_61_3(arg_62_0.result)
		end
	end)
end

function var_0_0.check_battlearray_info_valid(arg_63_0, arg_63_1)
	local var_63_0 = {}
	local var_63_1 = {}

	for iter_63_0 = 1, FORMATION_SHOW_GIRL_NUM do
		if arg_63_1["pos_" .. iter_63_0].fight_girl then
			if not playermodel.haveServant[arg_63_1["pos_" .. iter_63_0].fight_girl] then
				return false, 2
			end

			var_63_0[arg_63_1["pos_" .. iter_63_0].fight_girl] = (var_63_0[arg_63_1["pos_" .. iter_63_0].fight_girl] or 0) + 1

			if var_63_0[arg_63_1["pos_" .. iter_63_0].fight_girl] > 1 then
				return false, 5
			end
		end

		local var_63_2 = arg_63_1["pos_" .. iter_63_0].assist_girl

		if arg_63_1["pos_" .. iter_63_0].assist_girl then
			if not arg_63_1["pos_" .. iter_63_0].fight_girl then
				return false, 4
			end

			if not playermodel.items[var_63_2] then
				return false, 3
			end

			var_63_1[var_63_2] = (var_63_1[var_63_2] or 0) + 1

			if var_63_1[var_63_2] > 1 then
				return false, 5
			end
		end
	end

	return true
end

function var_0_0:updateArenaDefenceArrayOneKey(arg_64_1, arg_64_2)
	local var_64_0, var_64_1 = self:check_battlearray_info_valid(arg_64_1)

	if not var_64_0 then
		if arg_64_2 then
			arg_64_2(var_64_1)
		end

		return
	end

	network:rpc("update_array_onekey", {
		id = -1,
		battlearray = arg_64_1
	}, function(arg_65_0)
		if arg_65_0.result == 1 then
			playermodel.arenaArray = arg_65_0.array

			if arg_65_0.updateassist then
				for iter_65_0, iter_65_1 in pairs(arg_65_0.updateassist) do
					item_manager:setItemByServerItem(iter_65_1)
				end
			end

			if arg_64_2 then
				arg_64_2(1)
			end
		elseif arg_64_2 then
			arg_64_2(arg_65_0.result)
		end
	end)
end

function var_0_0:updateArenaAttackArrayOneKey(arg_66_1, arg_66_2)
	local var_66_0, var_66_1 = self:check_battlearray_info_valid(arg_66_1)

	if not var_66_0 then
		if arg_66_2 then
			arg_66_2(var_66_1)
		end

		return
	end

	network:rpc("update_array_onekey", {
		id = -2,
		battlearray = arg_66_1
	}, function(arg_67_0)
		if arg_67_0.result == 1 then
			playermodel.arenaAttackArray = arg_67_0.array

			if arg_66_2 then
				arg_66_2(1)
			end
		elseif arg_66_2 then
			arg_66_2(arg_67_0.result)
		end
	end)
end

function var_0_0.getScoreAreanArrayID(arg_68_0)
	return playermodel.scorearenaAttackArray
end

function var_0_0.getHangupInfoForAnalytic(arg_69_0, arg_69_1)
	arg_69_1 = arg_69_1 or {}

	local var_69_0 = playermodel.arrays[playermodel.curArray]

	for iter_69_0 = 1, FORMATION_SHOW_GIRL_NUM do
		if var_69_0["pos_" .. iter_69_0].fight_girl then
			arg_69_1["servant" .. iter_69_0] = var_69_0["pos_" .. iter_69_0].fight_girl
			arg_69_1["assist_girl" .. iter_69_0] = var_69_0["pos_" .. iter_69_0].assist_girl and playermodel.items[var_69_0["pos_" .. iter_69_0].assist_girl].itemid
		end
	end

	return arg_69_1
end

function var_0_0.getBattleArrayDataHpInherit(arg_70_0, arg_70_1)
	if not playermodel.exploreArrays[arg_70_1] then
		return nil
	end

	local var_70_0 = {}

	for iter_70_0 = 1, FORMATION_SHOW_GIRL_NUM do
		var_70_0[iter_70_0] = playermodel.exploreArrays[arg_70_1]["pos_" .. iter_70_0]
	end

	return var_70_0
end

function var_0_0:checkExploreArrayHpInherit(arg_71_1)
	if not playermodel.exploreArrays[arg_71_1] then
		return false, 0
	end

	if self:isArrayPatrol(arg_71_1) then
		return false, 2
	end

	local var_71_0 = 0

	for iter_71_0 = 1, FORMATION_SHOW_GIRL_NUM do
		if playermodel.exploreArrays[arg_71_1]["pos_" .. iter_71_0].fight_girl then
			var_71_0 = var_71_0 + 1
		end
	end

	if var_71_0 <= 0 then
		return false, 1
	end

	return true
end

function var_0_0:updateArrayFightgirlHpInherit(arg_72_1, arg_72_2, arg_72_3, arg_72_4)
	if not playermodel.exploreArrays[arg_72_1] then
		if arg_72_4 then
			arg_72_4(0)
		end

		return
	end

	if self:isArrayPatrol(arg_72_1) then
		if arg_72_4 then
			arg_72_4(8)
		end

		return
	end

	if arg_72_3 then
		if not level_manager:isPlayerPassLevel(BATTLEARRAY_SOUL_UNLOCK[arg_72_2]) then
			if arg_72_4 then
				arg_72_4(0)
			end

			return
		end

		local var_72_0 = explore_manager:getHpInherit(arg_72_3)

		if var_72_0 and var_72_0 <= 0 then
			if arg_72_4 then
				arg_72_4(0)
			end

			return
		end

		if playermodel.exploreArrays[arg_72_1]["pos_" .. arg_72_2].fight_girl == arg_72_3 then
			if arg_72_4 then
				arg_72_4(0)
			end

			return
		end

		if not playermodel.haveServant[arg_72_3] then
			if arg_72_4 then
				arg_72_4(2)
			end

			return
		end

		for iter_72_0 = 1, FORMATION_SHOW_GIRL_NUM do
			if playermodel.exploreArrays[arg_72_1]["pos_" .. iter_72_0].fight_girl == arg_72_3 then
				if arg_72_4 then
					arg_72_4(4)
				end

				return
			end
		end

		playermodel.exploreArrays[arg_72_1]["pos_" .. arg_72_2] = playermodel.exploreArrays[arg_72_1]["pos_" .. arg_72_2] or {}

		for iter_72_1, iter_72_2 in ipairs(playermodel.exploreArrays) do
			for iter_72_3 = 1, FORMATION_SHOW_GIRL_NUM do
				if iter_72_2["pos_" .. iter_72_3] and iter_72_2["pos_" .. iter_72_3].fight_girl == arg_72_3 then
					iter_72_2["pos_" .. iter_72_3] = {}
				end
			end
		end

		if playermodel.exploreArrays[arg_72_1]["pos_" .. arg_72_2].assist_girl and explore_manager:queryHorcruxIsUsed(playermodel.exploreArrays[arg_72_1]["pos_" .. arg_72_2].assist_girl) then
			playermodel.exploreArrays[arg_72_1]["pos_" .. arg_72_2].assist_girl = nil
		end

		playermodel.exploreArrays[arg_72_1]["pos_" .. arg_72_2].fight_girl = arg_72_3

		local var_72_1 = explore_manager:getHorcruxByServantId(arg_72_3)

		if var_72_1 then
			playermodel.exploreArrays[arg_72_1]["pos_" .. arg_72_2].assist_girl = var_72_1
		end
	else
		if playermodel.exploreArrays[arg_72_1]["pos_" .. arg_72_2].fight_girl == nil then
			if arg_72_4 then
				arg_72_4(0)
			end

			return
		end

		if self:isArrayHangup(arg_72_1) then
			local var_72_2 = 0

			for iter_72_4 = 1, FORMATION_SHOW_GIRL_NUM do
				if playermodel.exploreArrays[arg_72_1]["pos_" .. arg_72_2].fight_girl then
					var_72_2 = var_72_2 + 1
				end
			end

			if var_72_2 <= 1 then
				if arg_72_4 then
					arg_72_4(5)
				end

				return
			end
		end

		playermodel.exploreArrays[arg_72_1]["pos_" .. arg_72_2] = {}
	end

	if arg_72_4 then
		arg_72_4(1, playermodel.exploreArrays)
	end
end

function var_0_0:updateArrayAssistgirlHpInherit(arg_73_1, arg_73_2, arg_73_3, arg_73_4)
	if not playermodel.exploreArrays[arg_73_1] then
		if arg_73_4 then
			arg_73_4(0)
		end

		return
	end

	local var_73_0 = playermodel.exploreArrays[arg_73_1]["pos_" .. arg_73_2]

	if not playermodel.exploreArrays[arg_73_1]["pos_" .. arg_73_2] then
		if arg_73_4 then
			arg_73_4(5)
		end

		return
	end

	if explore_manager:queryHorcruxIsUsed(arg_73_3) then
		if arg_73_4 then
			arg_73_4(0)
		end

		return
	end

	if var_73_0.assist_girl == arg_73_3 then
		if arg_73_4 then
			arg_73_4(0)
		end

		return
	end

	if self:isArrayPatrol(arg_73_1) then
		if arg_73_4 then
			arg_73_4(7)
		end

		return
	end

	if arg_73_3 then
		if not level_manager:isPlayerPassLevel(BATTLEARRAY_HORCRUX_UNLOCK[arg_73_2]) then
			if arg_73_4 then
				arg_73_4(0)
			end

			return
		end

		if not playermodel.items[arg_73_3] then
			if arg_73_4 then
				arg_73_4(2)
			end

			return
		end

		for iter_73_0, iter_73_1 in ipairs(playermodel.exploreArrays) do
			for iter_73_2 = 1, FORMATION_SHOW_GIRL_NUM do
				if iter_73_1["pos_" .. iter_73_2] and iter_73_1["pos_" .. iter_73_2].assist_girl == arg_73_3 then
					iter_73_1["pos_" .. iter_73_2].assist_girl = nil
				end
			end
		end
	end

	var_73_0.assist_girl = arg_73_3

	if arg_73_4 then
		arg_73_4(1, playermodel.exploreArrays)
	end
end

function var_0_0:isHorcruxInArrayNowHpInherit(arg_74_1)
	return self:getArrayByHorcruxIDHpInherit(arg_74_1) ~= nil
end

function var_0_0.getArrayByHorcruxIDHpInherit(arg_75_0, arg_75_1)
	for iter_75_0, iter_75_1 in ipairs(playermodel.exploreArrays) do
		for iter_75_2 = 1, FORMATION_SHOW_GIRL_NUM do
			if iter_75_1["pos_" .. iter_75_2].assist_girl == arg_75_1 then
				return iter_75_1.id
			end
		end
	end

	return nil
end

function var_0_0:isServantInArrayNowHpInherit(arg_76_1)
	return self:getArrayByServantIDHpInherit(arg_76_1) ~= nil
end

function var_0_0.getArrayByServantIDHpInherit(arg_77_0, arg_77_1)
	for iter_77_0, iter_77_1 in ipairs(playermodel.exploreArrays) do
		for iter_77_2 = 1, FORMATION_SHOW_GIRL_NUM do
			if iter_77_1["pos_" .. iter_77_2].fight_girl == arg_77_1 then
				return iter_77_1.id
			end
		end
	end

	return nil
end

function var_0_0.updateArrayOneKeyHpInherit(arg_78_0, arg_78_1, arg_78_2, arg_78_3)
	for iter_78_0 = 1, FORMATION_SHOW_GIRL_NUM do
		playermodel.exploreArrays[arg_78_1]["pos_" .. iter_78_0] = arg_78_2["pos_" .. iter_78_0] and arg_78_2["pos_" .. iter_78_0] or {}
	end

	playermodel.exploreArrays[arg_78_1].id = arg_78_1

	if arg_78_3 then
		arg_78_3(1)
	end
end

function var_0_0:onHorcruxDecompose(arg_79_1)
	local var_79_0, var_79_1 = self:getArrayByHorcruxID(arg_79_1)

	if var_79_0 then
		playermodel.arrays[var_79_0]["pos_" .. var_79_1].assist_girl = nil

		if self:isArrayCurHangup(var_79_0) then
			self:registerHangupArrayChange()
		end
	end
end

return var_0_0
