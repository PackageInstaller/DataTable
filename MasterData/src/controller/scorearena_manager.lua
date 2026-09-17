local var_0_0 = {}
local network = require("network.network")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local major_factor_data = require("data.major_factor_data")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local bond_manager = require("controller.bond_manager")

var_0_0.curPlayerData = nil
var_0_0.curEnemyData = nil
var_0_0.curEnemyList = {}
var_0_0.rank = 0

function var_0_0.get_scorearena_rank(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	network:rpc("get_scorearena_rank", {
		stop = 99,
		start = 0
	}, function(arg_2_0)
		if arg_1_3 then
			arg_1_3(arg_2_0.data)
		end
	end)
end

function var_0_0.get_player_scorearena_data(arg_3_0, arg_3_1)
	network:rpc("get_player_scorearena_data", {
		default = require("model.playermodel").scorearenaAttackArray
	}, function(arg_4_0)
		arg_3_0.rank = arg_4_0.rank
		arg_3_0.curEnemyList = {}

		if arg_4_0.enemies then
			for iter_4_0, iter_4_1 in pairs(arg_4_0.enemies) do
				arg_3_0.curEnemyList[iter_4_1.playerid] = iter_4_1
			end
		end

		if arg_3_1 then
			arg_3_1(arg_4_0)
		end
	end)
end

function var_0_0.refresh_match_enemies_manual(arg_5_0, arg_5_1)
	network:rpc("refresh_match_enemies_manual", nil, function(arg_6_0)
		if arg_6_0.diamond then
			playermodel.diamond = playermodel.diamond - arg_6_0.diamond

			global_update_gold_stone_diamond(nil, nil, arg_6_0.diamond)
		end

		if arg_6_0.result == 1 and arg_6_0.enemies ~= nil then
			arg_5_0.curEnemyList = {}

			if arg_6_0.enemies then
				for iter_6_0, iter_6_1 in pairs(arg_6_0.enemies) do
					arg_5_0.curEnemyList[iter_6_1.playerid] = iter_6_1
				end
			end
		end

		if arg_5_1 then
			arg_5_1(arg_6_0.result, arg_6_0.enemies)
		end
	end)
end

function var_0_0.get_matched_enemy_data(arg_7_0, arg_7_1, arg_7_2)
	network:rpc("get_matched_enemy_data", {
		enemyid = arg_7_1
	}, function(arg_8_0)
		if arg_7_2 then
			arg_7_2(arg_8_0.result, arg_8_0.enemydata)
		end
	end)
end

function var_0_0.start_score_arena_fight(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	network:rpc("start_score_arena_fight", {
		enemyid = arg_9_2
	}, function(arg_10_0)
		if arg_10_0.result == 1 then
			HORCRUX_DEVOUR_FIGHT_TYPE = 2
			arg_9_0.curPlayerData = arg_10_0.playerdata
			arg_9_0.curEnemyData = arg_10_0.enemydata
			arg_9_0.curEnemyData.playerid = arg_9_2
			arg_9_0.curEnemyData.subscribe = arg_10_0.enemy_subscribe

			bond_manager:initEnemyBond(arg_10_0.enemybond)

			if FightManager.refreshFightToType(FIGHTTYPE_SCOREARENA) then
				if arg_9_3 then
					arg_9_3(1)
				end
			elseif arg_9_3 then
				arg_9_3(0)
			end
		elseif arg_9_3 then
			arg_9_3(arg_10_0.result)
		end
	end)
end

function var_0_0:passScoreArena(arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = self.curEnemyData.playerid

	network:rpc("scorearena_settlement", {
		enemyid = self.curEnemyData.playerid,
		result = arg_11_1,
		failtype = arg_11_3 and 2 or 1
	}, function(arg_12_0)
		if arg_12_0.result == 1 then
			if arg_12_0.honor then
				playermodel.honor = playermodel.honor + arg_12_0.honor
			end

			if arg_12_0.rank then
				self.rank = arg_12_0.rank
			end

			local var_12_0 = {}

			var_12_0.name = self.curEnemyList[var_11_0] and self.curEnemyList[var_11_0].name
			var_12_0.enemyarray = self.curEnemyData
			var_12_0.playerarray = self.curPlayerData

			if arg_11_2 then
				arg_11_2(var_12_0, self.rank, arg_12_0.honor, arg_12_0.score, arg_12_0.addscore)
			end
		end
	end)
end

function var_0_0:fightSuccess(arg_13_1)
	self:passScoreArena(1, arg_13_1)
end

function var_0_0:fightFail(arg_14_1, arg_14_2)
	self:passScoreArena(2, arg_14_1, arg_14_2)
end

local function var_0_8(arg_15_0)
	local var_15_0 = {
		science_point = arg_15_0.science_point,
		star = arg_15_0.star
	}

	var_15_0.servantid = arg_15_0.servantid
	var_15_0.soulid = servant_data[arg_15_0.servantid].major
	var_15_0.contract = arg_15_0.contract

	local var_15_1 = arg_15_0.skillslevel or {}

	var_15_0.passiveLevel = var_15_1[1] or 0
	var_15_0.skill1Level = var_15_1[2] or 0
	var_15_0.servantrank = arg_15_0.servantrank
	var_15_0.servantskin = arg_15_0.servantskin
	var_15_0.overclock = arg_15_0.overclock
	var_15_0.reinforce_component = arg_15_0.reinforce_component
	var_15_0.favorlevel = arg_15_0.favorlevel

	local var_15_2 = {
		majorlist = var_15_0,
		component = arg_15_0.component,
		horcrux = arg_15_0.horcrux
	}

	var_15_2.servant_horcrux = arg_15_0.servant_horcrux or {}

	if arg_15_0.weapon then
		var_15_2.weapon = {
			itemid = arg_15_0.weapon.itemid,
			weapon_attr = {
				exp = arg_15_0.weapon.exp,
				level = arg_15_0.weapon.level,
				nowStars = arg_15_0.weapon.nowStars
			}
		}
	end

	return var_15_2
end

function var_0_0:getArenaEnemy()
	if not self.curEnemyData then
		return nil
	end

	local var_16_0 = {}

	for iter_16_0 = 1, #self.curEnemyData do
		var_16_0[iter_16_0] = var_0_8(self.curEnemyData[iter_16_0])
		var_16_0[iter_16_0].subscribe = self.curEnemyData.subscribe
	end

	return var_16_0
end

function var_0_0:getArenaEnemyHorcruxDevour(arg_17_1)
	local var_17_0 = {}
	local var_17_1

	if self.curEnemyData then
		for iter_17_0 = 1, #self.curEnemyData do
			if self.curEnemyData[iter_17_0].servantid == arg_17_1 then
				var_17_1 = self.curEnemyData[iter_17_0].servant_horcrux

				break
			end
		end
	end

	if var_17_1 then
		for iter_17_1 = 1, HORCRUX_DEVOUR_MAX do
			var_17_0[iter_17_1] = var_17_1[iter_17_1] and var_17_1[iter_17_1] or {}
		end
	else
		for iter_17_2 = 1, HORCRUX_DEVOUR_MAX do
			var_17_0[iter_17_2] = {}
		end
	end

	return var_17_0
end

function var_0_0:getArenaPlayer()
	if not self.curPlayerData then
		return nil
	end

	local var_18_0 = {}
	local var_18_1 = IsOpenPrivilege()

	for iter_18_0, iter_18_1 in pairs(self.curPlayerData) do
		var_18_0[#var_18_0 + 1] = var_0_8(iter_18_1)
		var_18_0[#var_18_0 + 1].subscribe = var_18_1
	end

	return var_18_0
end

function var_0_0.setArenaFightArray(arg_19_0, arg_19_1)
	playermodel.scorearenaAttackArray = arg_19_1

	RoleDefault:getInstance():setIntegerForKey("scorearenaAttackArray", playermodel.scorearenaAttackArray)
end

function var_0_0.get_daily_scorearena_awards(arg_20_0, arg_20_1, arg_20_2)
	network:rpc("get_daily_scorearena_awards", {
		id = arg_20_1
	}, function(arg_21_0)
		if arg_21_0.result == 1 and (arg_21_0.honor and false or not arg_21_0.diamond or true) then
			if arg_20_2 then
				arg_20_2(1, arg_21_0.diamond, arg_21_0.honor)
			end
		elseif arg_20_2 then
			arg_20_2(arg_21_0.result)
		end
	end)
end

function var_0_0:get_auto_fight_enemy()
	if not self.curEnemyList or not next(self.curEnemyList) then
		return
	end

	local var_22_0 = {}

	for iter_22_0, iter_22_1 in pairs(self.curEnemyList) do
		table.insert(var_22_0, iter_22_1)
	end

	table.sort(var_22_0, function(arg_23_0, arg_23_1)
		return arg_23_0.fightpower < arg_23_1.fightpower
	end)

	for iter_22_2, iter_22_3 in ipairs(var_22_0) do
		if not iter_22_3.isdefeat then
			return {
				playerid = iter_22_3.playerid,
				fightpower = iter_22_3.fightpower
			}
		end
	end
end

return var_0_0
