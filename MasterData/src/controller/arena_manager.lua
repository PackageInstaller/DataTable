local var_0_0 = {}
local var_0_1
local network = require("network.network")
local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local major_factor_data = require("data.major_factor_data")
local arenaawards_data = require("data.arenaawards_data")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local bond_manager = require("controller.bond_manager")
local var_0_11

var_0_0.curPlayerData = nil
var_0_0.curEnemyData = nil
var_0_0.pvpNeedData = nil
var_0_0.curLayerStatus = nil
var_0_0.helpBattleData = {}

function var_0_0.get_rank(arg_1_0)
	return var_0_1
end

function var_0_0.get_arena_daily_times(arg_2_0, arg_2_1)
	network:rpc("get_arena_daily_times", nil, function(arg_3_0)
		if arg_2_1 then
			arg_2_1(arg_3_0)
		end
	end)
end

function var_0_0.get_fight_data(arg_4_0, arg_4_1)
	network:rpc("get_player_arena_data", nil, function(arg_5_0)
		if arg_4_1 then
			arg_4_1(arg_5_0.arena_data)
		end

		var_0_1 = arg_5_0.arena_data.rank
	end)
end

function var_0_0.get_otherplyers_data(arg_6_0, arg_6_1)
	network:rpc("get_enemy_arena_data", nil, function(arg_7_0)
		table.sort(arg_7_0.arena_data, function(arg_8_0, arg_8_1)
			return arg_8_0.rank < arg_8_1.rank
		end)

		if arg_6_1 then
			arg_6_1(arg_7_0.arena_data)
		end
	end)
end

function var_0_0.get_player_arena_array(arg_9_0)
	local array_manager = require("controller.array_manager")

	return array_manager:getArenaDefenceArray(), array_manager:getArenaAttackArray()
end

function var_0_0.setLayerState(arg_10_0, arg_10_1)
	var_0_0.curLayerStatus = arg_10_1
end

function var_0_0.getLayerState(arg_11_0)
	return var_0_0.curLayerStatus
end

function var_0_0.beginArenaFight(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	network:rpc("start_fight_with_player", {
		array = arg_12_1,
		enemyid = arg_12_2
	}, function(arg_13_0)
		if arg_13_0.result == 1 then
			HORCRUX_DEVOUR_FIGHT_TYPE = 1
			arg_12_0.curPlayerData = arg_13_0.playerdata
			arg_12_0.curEnemyData = arg_13_0.enemydata
			arg_12_0.curEnemyData.playerid = arg_12_2
			arg_12_0.curEnemyData.enemy_subscribe = arg_13_0.enemy_subscribe
			arg_12_0.helpBattleData = {
				enemy = arg_13_0.enemy_assist_array
			}
			var_0_11 = arg_13_0.enemydata

			bond_manager:initEnemyBond(arg_13_0.enemybond)
			arg_12_0:set_arena_battlefield_status(arg_13_0.arenastatuses)

			if FightManager.refreshFightToType(FIGHTTYPE_ARENA) then
				if arg_12_3 then
					arg_12_3(1)
				end

				AnalyticManager.joinArena()
			elseif arg_12_3 then
				arg_12_3(0)
			end
		elseif arg_12_3 then
			arg_12_3(arg_13_0.result)
		end
	end)
end

function var_0_0:passArena(arg_14_1, arg_14_2, arg_14_3)
	network:rpc("fight_with_player_result", {
		enemyid = self.curEnemyData.playerid,
		result = arg_14_1,
		token = (function()
			local fight_capacity_manager = require("controller.fight_capacity_manager")
			local model_manager = require("controller.model_manager")
			local var_15_2 = {}

			for iter_15_0 = 1, FORMATION_SHOW_GIRL_NUM do
				if FightManager.players[iter_15_0] then
					local var_15_3 = {}

					var_15_3.servantid = FightManager.players[iter_15_0]:getAttribute("servantid")
					var_15_3.science_point = FightManager.players[iter_15_0]:getAttribute("science_point")
					var_15_3.hpFactor = FightManager.players[iter_15_0].model:getFactorAttribute("hpFactor")
					var_15_3.damageFactor = FightManager.players[iter_15_0].model:getFactorAttribute("damageFactor")
					var_15_3.attackspeed = FightManager.players[iter_15_0].model:getAttribute("attackspeed")
					var_15_3.defence = FightManager.players[iter_15_0].model:getAttribute("defence")
					var_15_3.maxrage = FightManager.players[iter_15_0].model:getAttribute("maxrage")

					local var_15_4

					if FightManager.players[iter_15_0]._assistconfig then
						var_15_4 = FightManager.players[iter_15_0]._assistconfig.entityid
					end

					local var_15_5 = model_manager.new()

					var_15_5:initPlayerAttribute(var_15_3.servantid)

					var_15_3.fightpower = fight_capacity_manager:computeFightCapacityNew(var_15_5, nil, var_15_3.servantid, var_15_4)

					table.insert(var_15_2, var_15_3)
				end
			end

			return json.encode(var_15_2)
		end)(),
		failtype = arg_14_3 and 2 or 1
	}, function(arg_16_0)
		if arg_16_0.result == 1 then
			if arg_16_0.honor and arg_16_0.honor > 0 then
				playermodel.honor = playermodel.honor + arg_16_0.honor
			end

			if arg_14_2 then
				arg_14_2(arg_16_0.rank, arg_16_0.honor, self.pvpNeedData)
			end
		end
	end)
end

function var_0_0:fightSuccess(arg_17_1)
	self:passArena(1, arg_17_1)

	if ArenaLayer.getInstance() then
		ArenaLayer.getInstance():updateUI()
	end
end

function var_0_0:fightFail(arg_18_1, arg_18_2)
	self:passArena(2, arg_18_1, arg_18_2)

	if ArenaLayer.getInstance() then
		ArenaLayer.getInstance():updateUI()
	end
end

function var_0_0:getCurArenaData()
	return {
		enemyarray = self.curEnemyData,
		playerarray = self.curPlayerData,
		otherinfo = self.pvpNeedData
	}
end

local function var_0_12(arg_20_0)
	local var_20_0 = {
		science_point = arg_20_0.science_point,
		star = arg_20_0.star
	}

	var_20_0.servantid = arg_20_0.servantid
	var_20_0.soulid = servant_data[arg_20_0.servantid].major
	var_20_0.contract = arg_20_0.contract

	local var_20_1 = arg_20_0.skillslevel or {}

	var_20_0.passiveLevel = var_20_1[1] or 0
	var_20_0.skill1Level = var_20_1[2] or 0
	var_20_0.servantrank = arg_20_0.servantrank
	var_20_0.servantskin = arg_20_0.servantskin
	var_20_0.overclock = arg_20_0.overclock
	var_20_0.reinforce_component = arg_20_0.reinforce_component
	var_20_0.favorlevel = arg_20_0.favorlevel

	local var_20_2 = {
		majorlist = var_20_0,
		component = arg_20_0.component,
		horcrux = arg_20_0.horcrux
	}

	if arg_20_0.weapon then
		var_20_2.weapon = {
			itemid = arg_20_0.weapon.itemid,
			weapon_attr = {
				exp = arg_20_0.weapon.exp,
				level = arg_20_0.weapon.level,
				nowStars = arg_20_0.weapon.nowStars
			}
		}
	end

	return var_20_2
end

function var_0_0:getArenaEnemy()
	if not self.curEnemyData then
		return nil
	end

	local var_21_0 = {}

	for iter_21_0 = 1, #self.curEnemyData do
		var_21_0[iter_21_0] = var_0_12(self.curEnemyData[iter_21_0])
		var_21_0[iter_21_0].subscribe = self.curEnemyData.enemy_subscribe
	end

	return var_21_0
end

function var_0_0:getArenaPlayer()
	if not self.curPlayerData then
		return nil
	end

	local var_22_0 = {}
	local var_22_1 = IsOpenPrivilege()

	for iter_22_0, iter_22_1 in pairs(self.curPlayerData) do
		var_22_0[#var_22_0 + 1] = var_0_12(iter_22_1)
		var_22_0[#var_22_0 + 1].subscribe = var_22_1
	end

	return var_22_0
end

function var_0_0.getArenaAwards(arg_23_0, arg_23_1)
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in pairs(arenaawards_data) do
		if arg_23_1 <= iter_23_1.min and arg_23_1 >= iter_23_1.max then
			var_23_0.diamond = iter_23_1.diamond_daily
			var_23_0.honor = iter_23_1.honor_daily
		end
	end

	return var_23_0
end

function var_0_0.setArenaFightArray(arg_24_0, arg_24_1)
	return
end

function var_0_0.setPvpNeedData(arg_25_0, arg_25_1)
	arg_25_0.pvpNeedData = arg_25_1
end

function var_0_0.getPlayerArenaArray(arg_26_0, arg_26_1)
	playermodel:loadPlayerArenaDataFromServer(function(arg_27_0)
		arg_26_0:set_arena_battlefield_status(arg_27_0)

		if arg_26_1 then
			arg_26_1()
		end
	end)
end

var_0_0.arenabattlefieldstatus = nil

function var_0_0.set_arena_battlefield_status(arg_28_0, arg_28_1)
	arg_28_0.arenabattlefieldstatus = arg_28_1
end

function var_0_0:get_arena_battlefield_status()
	return self.arenabattlefieldstatus
end

function var_0_0:get_arena_battlefield_status_info()
	if not self.arenabattlefieldstatus then
		return nil
	end

	local battlefield_status_data = require("data.battlefield_status_data")
	local var_30_1 = {}

	for iter_30_0, iter_30_1 in ipairs(self.arenabattlefieldstatus) do
		if battlefield_status_data[iter_30_1].des then
			table.insert(var_30_1, battlefield_status_data[iter_30_1].des)
		end
	end

	return var_30_1
end

function var_0_0.get_arena_battlefield_status_icon(arg_31_0, arg_31_1)
	local var_31_0 = require("data.battlefield_status_data")[arg_31_1]

	if var_31_0.targetattr then
		return ATTRICONPATH[var_31_0.targetattr]
	end

	if var_31_0.targetcareer then
		return ATTRICONPATH[var_31_0.targetcareer]
	end

	return "FightLayer/map_icon.png"
end

function var_0_0:getArenaEnemyHorcruxDevour(arg_32_1)
	local var_32_0 = {}
	local var_32_1

	if self.curEnemyData then
		for iter_32_0 = 1, #self.curEnemyData do
			if self.curEnemyData[iter_32_0].servantid == arg_32_1 then
				var_32_1 = self.curEnemyData[iter_32_0].servant_horcrux

				break
			end
		end
	end

	if var_32_1 then
		for iter_32_1 = 1, HORCRUX_DEVOUR_MAX do
			var_32_0[iter_32_1] = var_32_1[iter_32_1] and var_32_1[iter_32_1] or {}
		end
	else
		for iter_32_2 = 1, HORCRUX_DEVOUR_MAX do
			var_32_0[iter_32_2] = {}
		end
	end

	return var_32_0
end

return var_0_0
