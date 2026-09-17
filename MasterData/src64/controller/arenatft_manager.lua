local var_0_0 = {}
local playermodel = require("model.playermodel")
local network = require("network.network")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local arenatft_conf_data = require("data.arenatft.arenatft_conf_data")
local arenatft_season_data = require("data.arenatft.arenatft_season_data")
local time_check_manager = require("controller.time_check_manager")
local servant_data = require("data.servant_data")

var_0_0.defenceArray = nil
var_0_0.attackArray = nil
var_0_0.oldRank = nil
var_0_0.oldSuccScore = nil
var_0_0.oldFailScore = nil
var_0_0.enemyArray = nil
var_0_0.curLayerStatus = nil
var_0_0.enemyInfo = {}
var_0_0.playerInfo = {}
var_0_0.attack_order = {}
var_0_0.enemy_order = 1
var_0_0.player_order = 1
var_0_0.fight_data = {}
var_0_0.layerBtnLock = false

local function var_0_8(arg_1_0)
	local var_1_0 = {
		science_point = arg_1_0.science_point,
		star = arg_1_0.star
	}

	var_1_0.servantid = arg_1_0.servantid
	var_1_0.soulid = servant_data[arg_1_0.servantid].major
	var_1_0.contract = arg_1_0.contract

	local var_1_1 = arg_1_0.skillslevel or {}

	var_1_0.passiveLevel = var_1_1[1] or 0
	var_1_0.skill1Level = var_1_1[2] or 0
	var_1_0.servantrank = arg_1_0.servantrank
	var_1_0.servantskin = arg_1_0.servantskin
	var_1_0.overclock = arg_1_0.overclock
	var_1_0.reinforce_component = arg_1_0.reinforce_component
	var_1_0.favorlevel = arg_1_0.favorlevel

	local var_1_2 = {
		majorlist = var_1_0,
		component = arg_1_0.component,
		horcrux = arg_1_0.horcrux
	}

	if arg_1_0.weapon then
		var_1_2.weapon = {
			itemid = arg_1_0.weapon.itemid,
			weapon_attr = {
				exp = arg_1_0.weapon.exp,
				level = arg_1_0.weapon.level,
				nowStars = arg_1_0.weapon.nowStars
			}
		}
	end

	return var_1_2
end

function var_0_0.get_player_arenatft_info(arg_2_0, arg_2_1)
	network:rpc("get_player_arenatft_info", nil, function(arg_3_0)
		arg_2_0.oldRank = arg_3_0.rank
		arg_2_0.oldSuccScore = arg_3_0.succscore
		arg_2_0.succscore = arg_3_0.succscore
		arg_2_0.canfightnow = arg_3_0.canfightnow
		arg_2_0.remain_daily_time = arg_3_0.daily_remain_count
		arg_2_0.total_daily_time = arg_3_0.daily_total_count
		arg_2_0.daily_refresh_time = arg_3_0.daily_refresh_time
		arg_2_0.failsheild = arg_3_0.failsheild or 0
		arg_2_0.last_attack_order = arg_3_0.last_attack_order

		arg_2_0:set_arenatft_battlefield_status(arg_3_0.arenastatuses)

		if arg_2_1 then
			arg_2_1(arg_3_0)
		end
	end)
end

function var_0_0:getOldPlayerInfo()
	if self.oldRank then
		return {
			failscore = 110,
			rank = self.oldRank,
			succscore = self.oldSuccScore
		}
	else
		return nil
	end
end

function var_0_0.get_arenatft_attack_array(arg_5_0, arg_5_1)
	network:rpc("get_arenatft_attack_array", nil, function(arg_6_0)
		arg_5_0.attackArray = arg_6_0.arrays or {}

		if arg_5_1 then
			arg_5_1(arg_6_0)
		end
	end)
end

function var_0_0.getAttackArrayData(arg_7_0, arg_7_1)
	if not var_0_0.attackArray[arg_7_1] then
		return {}
	end

	local var_7_0 = {}

	for iter_7_0 = 1, FORMATION_SHOW_GIRL_NUM do
		var_7_0[iter_7_0] = var_0_0.attackArray[arg_7_1]["pos_" .. iter_7_0]
	end

	return var_7_0
end

function var_0_0:getPlayerArray(arg_8_1)
	playerArray = {}

	for iter_8_0, iter_8_1 in pairs((self:getAttackArrayData(self.attack_order[arg_8_1] or self.last_attack_order[arg_8_1]))) do
		if iter_8_1.fight_girl then
			playerArray[#playerArray + 1] = {}
			playerArray[#playerArray].model = global_get_servant_skin(iter_8_1.fight_girl)
		end
	end

	return playerArray
end

function var_0_0:getAttackArrayPower()
	self.playerInfo.fightPower = 0

	for iter_9_0 = 1, 3 do
		local var_9_0 = self:getAttackArrayData(iter_9_0)

		if var_9_0 then
			self.playerInfo.fightPower = self.playerInfo.fightPower + fight_capacity_manager:getArrayFightCapacity(var_9_0)
		end
	end
end

function var_0_0.set_arenatft_attack_servant(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	network:rpc("set_arenatft_attack_servant", {
		array = arg_10_1,
		pos = arg_10_2,
		servantid = arg_10_3
	}, function(arg_11_0)
		if arg_11_0.result == 1 then
			var_0_0.attackArray[arg_10_1] = arg_11_0.array

			if arg_11_0.robarray then
				var_0_0.attackArray[arg_11_0.robarray.id] = arg_11_0.robarray
			end
		end

		if arg_10_4 then
			arg_10_4(arg_11_0.result)
		end
	end)
end

function var_0_0.set_arenatft_attack_horcrux(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	network:rpc("set_arenatft_attack_horcrux", {
		array = arg_12_1,
		pos = arg_12_2,
		horcrux = arg_12_3
	}, function(arg_13_0)
		if arg_13_0.result == 1 then
			var_0_0.attackArray[arg_12_1] = arg_13_0.array

			if arg_13_0.robarray then
				var_0_0.attackArray[arg_13_0.robarray.id] = arg_13_0.robarray
			end
		end

		if arg_12_4 then
			arg_12_4(arg_13_0.result)
		end
	end)
end

function var_0_0:isServantInAtkArrayNow(arg_14_1)
	return self:getAtkArrayByServantID(arg_14_1) ~= nil
end

function var_0_0.getAtkArrayByServantID(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(var_0_0.attackArray) do
		for iter_15_2 = 1, FORMATION_SHOW_GIRL_NUM do
			if iter_15_1["pos_" .. iter_15_2].fight_girl == arg_15_1 then
				return iter_15_1.id
			end
		end
	end

	return nil
end

function var_0_0.get_arenatft_defence_array(arg_16_0)
	network:rpc("get_arenatft_defence_array", nil, function(arg_17_0)
		arg_16_0.defenceArray = arg_17_0.arrays
	end)
end

function var_0_0.getDefenceArrayData(arg_18_0, arg_18_1)
	if not var_0_0.defenceArray[arg_18_1] then
		return nil
	end

	local var_18_0 = {}

	for iter_18_0 = 1, FORMATION_SHOW_GIRL_NUM do
		var_18_0[iter_18_0] = var_0_0.defenceArray[arg_18_1]["pos_" .. iter_18_0]
	end

	return var_18_0
end

function var_0_0.getDefServantPos(arg_19_0, arg_19_1)
	local var_19_0 = var_0_0:getDefArrayByServantID(servantId)

	for iter_19_0, iter_19_1 in pairs(var_0_0.defenceArray) do
		while iter_19_1["pos_" .. 1] do
			if iter_19_1["pos_" .. 1].fight_girl == arg_19_1 then
				return 1
			end
		end
	end
end

function var_0_0.getAtkServantPos(arg_20_0, arg_20_1)
	local var_20_0 = var_0_0:getAtkArrayByServantID(servantId)

	for iter_20_0, iter_20_1 in pairs(var_0_0.attackArray) do
		while iter_20_1["pos_" .. 1] do
			if iter_20_1["pos_" .. 1].fight_girl == arg_20_1 then
				return 1
			end
		end
	end
end

function var_0_0.set_arenatft_defence_servant(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	network:rpc("set_arenatft_defence_servant", {
		array = arg_21_1,
		pos = arg_21_2,
		servantid = arg_21_3
	}, function(arg_22_0)
		if arg_22_0.result == 1 then
			var_0_0.defenceArray[arg_21_1] = arg_22_0.array

			if arg_22_0.robarray then
				var_0_0.defenceArray[arg_22_0.robarray.id] = arg_22_0.robarray
			end
		end

		if arg_21_4 then
			arg_21_4(arg_22_0.result)
		end
	end)
end

function var_0_0:isServantInDefArrayNow(arg_23_1)
	return self:getDefArrayByServantID(arg_23_1) ~= nil
end

function var_0_0.getDefArrayByServantID(arg_24_0, arg_24_1)
	for iter_24_0, iter_24_1 in ipairs(var_0_0.defenceArray) do
		for iter_24_2 = 1, FORMATION_SHOW_GIRL_NUM do
			if iter_24_1["pos_" .. iter_24_2].fight_girl == arg_24_1 then
				return iter_24_1.id
			end
		end
	end

	return nil
end

function var_0_0.set_arenatft_defence_horcrux(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	network:rpc("set_arenatft_defence_horcrux", {
		array = arg_25_1,
		pos = arg_25_2,
		horcrux = arg_25_3
	}, function(arg_26_0)
		if arg_26_0.result == 1 then
			var_0_0.defenceArray[arg_25_1] = arg_26_0.array

			if arg_26_0.robarray then
				var_0_0.defenceArray[arg_26_0.robarray.id] = arg_26_0.robarray
			end
		end

		if arg_25_4 then
			arg_25_4(arg_26_0.result)
		end
	end)
end

function var_0_0.getTvtDefenceByHorcruxID(arg_27_0, arg_27_1)
	for iter_27_0, iter_27_1 in pairs(var_0_0.defenceArray) do
		for iter_27_2 = 1, FORMATION_SHOW_GIRL_NUM do
			if iter_27_1["pos_" .. iter_27_2].assist_girl == arg_27_1 then
				return iter_27_0
			end
		end
	end

	return nil
end

function var_0_0:isHorcruxInDefenceArrayNow(arg_28_1)
	return self:getTvtDefenceByHorcruxID(arg_28_1) ~= nil
end

function var_0_0:isHorcruxInAttackArrayNow(arg_29_1)
	return self:getTvtAttackByHorcruxID(arg_29_1) ~= nil
end

function var_0_0.getTvtAttackByHorcruxID(arg_30_0, arg_30_1)
	for iter_30_0, iter_30_1 in pairs(var_0_0.attackArray) do
		for iter_30_2 = 1, FORMATION_SHOW_GIRL_NUM do
			if iter_30_1["pos_" .. iter_30_2].assist_girl == arg_30_1 then
				return iter_30_0
			end
		end
	end

	return nil
end

function var_0_0.setLayerState(arg_31_0, arg_31_1)
	var_0_0.curLayerStatus = arg_31_1
end

function var_0_0.getLayerState(arg_32_0)
	return var_0_0.curLayerStatus
end

function var_0_0.arenatft_match_enemy(arg_33_0, arg_33_1)
	network:rpc("arenatft_match_enemy", nil, function(arg_34_0)
		if arg_34_0.result == 1 then
			arg_33_0.attack_order = {}
			arg_33_0.enemyInfo = arg_34_0.enemydata
			arg_33_0.canrefuse = arg_34_0.canrefuse
			arg_33_0.remain_daily_time = arg_34_0.remain_daily_time
			arg_33_0.remain_refuse_time = arg_34_0.remain_refuse_time
		end

		if arg_33_1 then
			arg_33_1(arg_34_0)
		end
	end)
end

function var_0_0:getEnemyInfo()
	return self.enemyInfo
end

function var_0_0:getPlayerInfo()
	self:getAttackArrayPower()

	return self.playerInfo
end

function var_0_0.get_enemy_defence_array(arg_37_0, arg_37_1)
	network:rpc("get_enemy_defence_array", {}, function(arg_38_0)
		if arg_38_0.result == 1 then
			arg_37_0.enemyArray = arg_38_0.fightinfo
			arg_37_0.enemyInfo.fightPower = 0

			for iter_38_0 = 1, 3 do
				arg_37_0.enemyInfo.fightPower = arg_37_0.enemyInfo.fightPower + arg_37_0.enemyArray[iter_38_0].fightpower
			end
		end

		if arg_37_1 then
			arg_37_1(arg_38_0)
		end
	end)
end

function var_0_0:start_fight(arg_39_1)
	self:setLayerBtnLock(false)
	network:rpc("start_fight", nil, function(arg_40_0)
		if arg_40_0.result == 1 then
			HORCRUX_DEVOUR_FIGHT_TYPE = 4
			self.curPlayerData = arg_40_0.playerdata
			self.curEnemyData = arg_40_0.enemydata
			self.curEnemyData.subscribe = arg_40_0.enemy_subscribe

			self:set_arenatft_battlefield_status(arg_40_0.arenastatuses)

			self.fight_data = {}

			if FightManager.refreshFightToTypeForce(FIGHTTYPE_ARENATFT) then
				if arg_39_1 then
					arg_39_1(1)
				end
			elseif arg_39_1 then
				arg_39_1(0)
			end
		elseif arg_39_1 then
			arg_39_1(arg_40_0.result)
		end
	end)
end

function var_0_0:getArenaEnemyHorcruxDevour(arg_41_1)
	local var_41_0 = {}
	local var_41_1

	if self.curEnemyData then
		for iter_41_0 = 1, #self.curEnemyData do
			if self.curEnemyData[iter_41_0].servantid == arg_41_1 then
				var_41_1 = self.curEnemyData[iter_41_0].servant_horcrux

				break
			end
		end
	end

	if var_41_1 then
		for iter_41_1 = 1, HORCRUX_DEVOUR_MAX do
			var_41_0[iter_41_1] = var_41_1[iter_41_1] and var_41_1[iter_41_1] or {}
		end
	else
		for iter_41_2 = 1, HORCRUX_DEVOUR_MAX do
			var_41_0[iter_41_2] = {}
		end
	end

	return var_41_0
end

function var_0_0.pass_arenatft(arg_42_0, arg_42_1, arg_42_2)
	network:rpc("pass_arenatft", {
		result = arg_42_1,
		fightrecord = (function()
			local var_43_0 = {
				fight_data = FightManager.getStatisticsMsg()
			}

			arg_42_0.fight_data[#arg_42_0.fight_data + 1] = {}
			arg_42_0.fight_data[#arg_42_0.fight_data].fightData = global_deepCopy(var_43_0.fight_data)
			arg_42_0.fight_data[#arg_42_0.fight_data].playerarray = arg_42_0:getPlayerArray(arg_42_0.player_order)
			arg_42_0.fight_data[#arg_42_0.fight_data].enemyarray = arg_42_0:getEnemyArray(arg_42_0.enemy_order)
			arg_42_0.fight_data[#arg_42_0.fight_data].fightresult = arg_42_1
			arg_42_0.fight_data[#arg_42_0.fight_data].time = math.floor(FightManager.getFightTimeStatistics())

			return json.encode(var_43_0.fight_data)
		end)()
	}, function(arg_44_0)
		print("msg===", dump(arg_44_0))

		if arg_44_0.result == 1 then
			arg_42_0.curPlayerData = arg_44_0.playerdata
			arg_42_0.curEnemyData = arg_44_0.enemydata
			arg_42_0.curEnemyData.subscribe = arg_44_0.enemy_subscribe
			arg_42_0.player_order = arg_42_0.player_order + 1
			arg_42_0.enemy_order = arg_42_0.enemy_order + 1

			arg_42_0:set_arenatft_battlefield_status(arg_44_0.arenastatuses)
			FightManager.refreshAtOnce()

			local var_44_0 = cc.EventCustom:new("UPDATE_BATTLEFIELD_INFO")

			var_44_0.mode = "none"
			var_44_0.chapter = "none"

			cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_44_0)
		elseif arg_44_0.result == 2 then
			arg_42_0.playerInfo.delta = arg_44_0.succscore - (arg_42_0.playerInfo.succscore or arg_42_0.succscore)
			arg_42_0.playerInfo.succscore = arg_44_0.succscore
			arg_42_0.playerInfo.failscore = arg_44_0.failscore
			arg_42_0.playerInfo.rank = arg_44_0.rank
			arg_42_0.failsheild = arg_44_0.failsheild or 0
			arg_42_0.isfirstwin = arg_44_0.isfirstwin

			if arg_42_2 then
				arg_42_2(arg_44_0)
			end

			arg_42_0.player_order = 1
			arg_42_0.enemy_order = 1
		elseif arg_44_0.result == 3 then
			arg_42_0.playerInfo.delta = arg_44_0.succscore - (arg_42_0.playerInfo.succscore or arg_42_0.succscore)
			arg_42_0.playerInfo.succscore = arg_44_0.succscore
			arg_42_0.playerInfo.failscore = arg_44_0.failscore
			arg_42_0.playerInfo.rank = arg_44_0.rank
			arg_42_0.failsheild = arg_44_0.failsheild or 0

			if arg_42_2 then
				arg_42_2(arg_44_0)
			end

			arg_42_0.player_order = 1
			arg_42_0.enemy_order = 1
		elseif arg_44_0.result == 4 then
			l2Log("战斗无效")
		elseif arg_44_0.result == 5 then
			global_ShowBlockWords(L_TVT_FIGHT_TWO_SEASON)

			if arg_42_2 then
				arg_42_2(arg_44_0)
			end

			LayerManager:switchReturnLayer("ThreeVsThreeLayer")
		end
	end)
end

function var_0_0:isToDayfirstWin()
	return self.isfirstwin
end

function var_0_0.resetFirstwin(arg_46_0)
	arg_46_0.isfirstwin = nil
end

function var_0_0:getAttackProceed()
	return self.enemy_order
end

function var_0_0:getFightData()
	return self.fight_data
end

function var_0_0:fightSuccess(arg_49_1)
	self:pass_arenatft(1, arg_49_1)
end

function var_0_0:fightFail(arg_50_1)
	self:pass_arenatft(0, arg_50_1)
end

function var_0_0:getArenaPlayer()
	if not self.curPlayerData then
		return nil
	end

	local var_51_0 = {}
	local var_51_1 = IsOpenPrivilege()

	for iter_51_0, iter_51_1 in pairs(self.curPlayerData) do
		var_51_0[#var_51_0 + 1] = var_0_8(iter_51_1)
		var_51_0[#var_51_0 + 1].subscribe = var_51_1
	end

	return var_51_0
end

function var_0_0:getArenaEnemy()
	if not self.curEnemyData then
		return nil
	end

	local var_52_0 = {}

	for iter_52_0 = 1, #self.curEnemyData do
		var_52_0[iter_52_0] = var_0_8(self.curEnemyData[iter_52_0])
		var_52_0[iter_52_0].subscribe = self.curEnemyData.subscribe
	end

	return var_52_0
end

function var_0_0.get_player_arenatft_records(arg_53_0, arg_53_1)
	network:rpc("get_player_arenatft_records", nil, function(arg_54_0)
		if arg_53_1 then
			arg_53_1(arg_54_0)
		end
	end)
end

function var_0_0.get_arenatft_ranklist(arg_55_0, arg_55_1)
	network:rpc("get_arenatft_ranklist", {
		stop = 100,
		start = 1
	}, function(arg_56_0)
		if arg_55_1 then
			arg_55_1(arg_56_0)
		end
	end)
end

function var_0_0.get_arenatft_ranklistEx(arg_57_0, arg_57_1, arg_57_2)
	arg_57_1 = arg_57_1 or {}

	local var_57_0 = arg_57_1.seasonId
	local var_57_1 = arg_57_1.start or 1
	local var_57_2 = arg_57_1.stop or 10

	network:rpc("get_arenatft_ranklist", {
		start = var_57_1,
		stop = var_57_2,
		seasonid = var_57_0
	}, function(arg_58_0)
		if arg_57_2 then
			arg_57_2(arg_58_0)
		end
	end)
end

function var_0_0.get_arenatft_historyRankConfig(arg_59_0, arg_59_1)
	network:rpc("get_history_season_config", nil, function(arg_60_0)
		if arg_60_0.result == 1 then
			arg_59_0._seasonId = nil
			arg_59_0._seasonIdTable = {}

			local var_60_0 = require("controller.time_check_manager"):getCurTime()

			if arg_60_0.list and next(arg_60_0.list) then
				for iter_60_0, iter_60_1 in pairs(arg_60_0.list) do
					if not arg_59_0._seasonId then
						if global_get_time_by_date(iter_60_1.starttime) <= var_60_0 and var_60_0 < global_get_time_by_date(iter_60_1.finishtime) then
							arg_59_0._seasonId = iter_60_1.seasonid
						end
					end

					table.insert(arg_59_0._seasonIdTable, iter_60_1)

					arg_59_0._seasonIdTable[#arg_59_0._seasonIdTable].id = iter_60_1.seasonid
				end

				table.sort(arg_59_0._seasonIdTable, function(arg_61_0, arg_61_1)
					return arg_61_0.id >= arg_61_1.id
				end)

				if not arg_59_0._seasonId and arg_59_0._seasonIdTable[1] then
					arg_59_0._seasonId = arg_59_0._seasonIdTable[1].id
				end
			end
		end

		if arg_59_1 then
			arg_59_1(arg_60_0)
		end
	end)
end

function var_0_0.set_fight_array_order(arg_62_0, arg_62_1, arg_62_2, arg_62_3)
	network:rpc("set_fight_array_order", {
		order = arg_62_1,
		array = arg_62_2
	}, function(arg_63_0)
		arg_62_0.attack_order[#arg_62_0.attack_order + 1] = arg_62_2

		if arg_62_3 then
			arg_62_3()
		end
	end)
end

function var_0_0:isHasAllData()
	return self.attackArray == nil
end

function var_0_0:is_attack_array_empty()
	local function var_65_0(arg_66_0)
		for iter_66_0 = 1, FORMATION_SHOW_GIRL_NUM do
			if arg_66_0["pos_" .. iter_66_0].fight_girl then
				return false
			end
		end

		return true
	end

	if not self.attackArray then
		return false
	end

	for iter_65_0, iter_65_1 in ipairs(self.attackArray) do
		if var_65_0(iter_65_1) then
			return true
		end
	end

	return false
end

function var_0_0.get_arenatft_daily_awards(arg_67_0, arg_67_1)
	network:rpc("get_arenatft_daily_awards", {}, function(arg_68_0)
		if arg_68_0.result ~= 1 then
			return
		end

		if next(arg_68_0.items) then
			global_gain(arg_68_0)
		end

		if arg_67_1 then
			arg_67_1()
		end
	end)
end

function var_0_0.giveup_match_enemy(arg_69_0, arg_69_1)
	network:rpc("giveup_match_enemy", {}, function(arg_70_0)
		if arg_69_1 then
			arg_69_1()
		end
	end)
end

function var_0_0.refresh_arenatft_dailytime(arg_71_0, arg_71_1)
	network:rpc("refresh_arenatft_dailytime", {}, function(arg_72_0)
		if arg_72_0.result == 2 then
			global_ShowBlockWords(L_TVT_CAN_NOT_REFUSE)

			return
		end

		if arg_72_0.result == 4 then
			global_ShowBlockWords(L_TVT_CAN_NOT_REFUSE_2)

			return
		end

		if arg_72_0.result ~= 1 then
			return
		end

		arg_71_0.remain_daily_time = arg_72_0.remain_daily_time
		arg_71_0.daily_refresh_time = arg_71_0.daily_refresh_time + 1

		if arg_72_0.diamond then
			playermodel.diamond = playermodel.diamond - arg_72_0.diamond
		end

		global_update_gold_stone_diamond(arg_72_0.gold, arg_72_0.stone, arg_72_0.diamond)
		global_ShowBlockWords(L_TWISTEGG_LACK_OF_COST.Buy_Success)

		if arg_71_1 then
			arg_71_1()
		end
	end)
end

function var_0_0.get_season_data(arg_73_0, arg_73_1)
	network:rpc("get_season_data", {}, function(arg_74_0)
		if arg_74_0.result ~= 1 then
			return
		end

		arg_73_0.seasonid = arg_74_0.seasonid
		arg_73_0.succscore = arg_74_0.succscore

		if arg_73_1 then
			arg_73_1(arg_74_0)
		end
	end)
end

function var_0_0.get_player_arenatft_record_fightdata(arg_75_0, arg_75_1, arg_75_2)
	network:rpc("get_player_arenatft_record_fightdata", {
		index = arg_75_1
	}, function(arg_76_0)
		if arg_76_0.result ~= 1 then
			return
		end

		if arg_75_2 then
			arg_75_2(arg_76_0)
		end
	end)
end

function var_0_0:update_arenatft_attack_array_one_key(arg_77_1, arg_77_2, arg_77_3)
	local var_77_0, var_77_1 = self:checkBattlearrayInfoValid(arg_77_2)

	if not var_77_0 then
		if arg_77_3 then
			arg_77_3(var_77_1)
		end

		return
	end

	network:rpc("set_areantft_attack_array_onekey", {
		array = arg_77_1,
		battlearray = arg_77_2
	}, function(arg_78_0)
		if arg_78_0.result == 1 then
			self:resetArray(arg_77_1, arg_78_0.array)

			if arg_78_0.robbed_arrays and next(arg_78_0.robbed_arrays) then
				self:resetOtherArray(arg_78_0.robbed_arrays)
			end

			if arg_77_3 then
				arg_77_3(1)
			end
		elseif arg_77_3 then
			arg_77_3(arg_78_0.result)
		end
	end)
end

function var_0_0.get_player_arenatft_task(arg_79_0, arg_79_1)
	network:rpc("get_player_arenatft_task", {}, function(arg_80_0)
		if arg_79_1 then
			arg_79_1(arg_80_0.task)
		end
	end)
end

function var_0_0.get_task_reward(arg_81_0, arg_81_1, arg_81_2)
	network:rpc("get_task_reward", {
		taskid = arg_81_1
	}, function(arg_82_0)
		if arg_82_0.result ~= 1 then
			return
		end

		global_gain(arg_82_0)

		if arg_81_2 then
			arg_81_2(arg_82_0.task)
		end
	end)
end

function var_0_0:getCurScore()
	return self.succscore
end

function var_0_0:getPlayerRemainTime()
	return self.remain_daily_time
end

function var_0_0:getPlayerTotalTime()
	return self.total_daily_time
end

function var_0_0:isPlayerCanRefuse()
	return self.canrefuse
end

function var_0_0:getRemainRefuseTime()
	return self.remain_refuse_time
end

function var_0_0:getDailyRefreshTime()
	return self.daily_refresh_time
end

function var_0_0:getPlayerRefreshCost()
	return arenatft_conf_data.refresh_daily_consume["consume" .. self.daily_refresh_time + 1]
end

function var_0_0:getEnemyArrayFightpower()
	return self.enemyInfo.fightPower
end

function var_0_0:isEnemyArrayMemNil(arg_91_1, arg_91_2)
	if not self.enemyArray or not next(self.enemyArray) then
		return false
	end

	if not self.enemyArray[arg_91_1] or not next(self.enemyArray[arg_91_1]) then
		return false
	end

	return self.enemyArray[arg_91_1].battlearray[arg_91_2] ~= nil
end

function var_0_0:getEnemyArrayData(arg_92_1)
	return self.enemyArray[arg_92_1].battlearray
end

function var_0_0:getEnemyArray(arg_93_1)
	playerArray = {}

	for iter_93_0, iter_93_1 in pairs((self:getEnemyArrayData(arg_93_1))) do
		if iter_93_1.servantid then
			playerArray[#playerArray + 1] = {}
			playerArray[#playerArray].model = global_get_servant_skin(iter_93_1.servantid)
		end
	end

	return playerArray
end

function var_0_0:getSeasonLessTime()
	if self.seasonid < 0 then
		return -1
	end

	if not arenatft_season_data[self.seasonid] then
		return -1
	end

	return global_get_time_by_date(arenatft_season_data[self.seasonid].finishtime) - time_check_manager:getCurTime()
end

function var_0_0:getCurSeason()
	return self.seasonid or 0
end

function var_0_0:isSeasonSleep()
	if self.canfightnow == nil then
		return true
	end

	return not self.canfightnow
end

function var_0_0.checkBattlearrayInfoValid(arg_97_0, arg_97_1)
	local var_97_0 = {}
	local var_97_1 = {}

	for iter_97_0 = 1, FORMATION_SHOW_GIRL_NUM do
		if arg_97_1["pos_" .. iter_97_0].fight_girl then
			if not playermodel.haveServant[arg_97_1["pos_" .. iter_97_0].fight_girl] then
				return false, 2
			end

			var_97_0[arg_97_1["pos_" .. iter_97_0].fight_girl] = (var_97_0[arg_97_1["pos_" .. iter_97_0].fight_girl] or 0) + 1

			if var_97_0[arg_97_1["pos_" .. iter_97_0].fight_girl] > 1 then
				return false, 5
			end
		end

		local var_97_2 = arg_97_1["pos_" .. iter_97_0].assist_girl

		if arg_97_1["pos_" .. iter_97_0].assist_girl then
			if not arg_97_1["pos_" .. iter_97_0].fight_girl then
				return false, 4
			end

			if not playermodel.items[var_97_2] then
				return false, 3
			end

			var_97_1[var_97_2] = (var_97_1[var_97_2] or 0) + 1

			if var_97_1[var_97_2] > 1 then
				return false, 5
			end
		end
	end

	return true
end

function var_0_0:resetArray(arg_98_1, arg_98_2)
	for iter_98_0, iter_98_1 in pairs(self.attackArray) do
		if iter_98_1.id == arg_98_1 then
			self.attackArray[iter_98_0] = arg_98_2
		end
	end
end

function var_0_0:resetOtherArray(arg_99_1)
	for iter_99_0, iter_99_1 in pairs(self.attackArray) do
		for iter_99_2, iter_99_3 in pairs(arg_99_1) do
			if iter_99_3.id == iter_99_1.id then
				self.attackArray[iter_99_0] = arg_99_1[iter_99_2]
			end
		end
	end
end

function var_0_0:getTftAreanArrayID()
	return self.attackArray
end

function var_0_0:getTftAreanArray()
	if not self.curPlayerData then
		return nil
	end

	local var_101_0 = {}

	for iter_101_0, iter_101_1 in pairs(self.curPlayerData) do
		table.insert(var_101_0, {
			fight_girl = iter_101_1.servantid
		})
	end

	return var_101_0
end

function var_0_0.setLayerBtnLock(arg_102_0, arg_102_1)
	arg_102_0.layerBtnLock = arg_102_1
end

function var_0_0:getLayerBtnLock()
	return self.layerBtnLock
end

function var_0_0.getRefuseNum(arg_104_0)
	return arenatft_conf_data.buy_fight_count.value
end

var_0_0.arenatftbattlefieldstatus = nil

function var_0_0.set_arenatft_battlefield_status(arg_105_0, arg_105_1)
	arg_105_0.arenatftbattlefieldstatus = arg_105_1
end

function var_0_0:get_arenatft_battlefield_status()
	return self.arenatftbattlefieldstatus
end

function var_0_0:get_arenatft_battlefield_status_info()
	if not self.arenatftbattlefieldstatus then
		return nil
	end

	local battlefield_status_data = require("data.battlefield_status_data")
	local var_107_1 = {}

	for iter_107_0, iter_107_1 in ipairs(self.arenatftbattlefieldstatus) do
		if battlefield_status_data[iter_107_1].des then
			table.insert(var_107_1, battlefield_status_data[iter_107_1].des)
		end
	end

	return var_107_1
end

function var_0_0.get_arenatft_battlefield_status_icon(arg_108_0, arg_108_1)
	local var_108_0 = require("data.battlefield_status_data")[arg_108_1]

	if var_108_0.targetattr then
		return ATTRICONPATH[var_108_0.targetattr]
	end

	if var_108_0.targetcareer then
		return ATTRICONPATH[var_108_0.targetcareer]
	end

	return "FightLayer/map_icon.png"
end

function var_0_0:getFailsheildNum()
	return self.failsheild
end

function var_0_0.resetFailsheildNum(arg_110_0)
	arg_110_0.failsheild = nil
end

return var_0_0
