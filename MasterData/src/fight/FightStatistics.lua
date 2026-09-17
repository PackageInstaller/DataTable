local var_0_0 = {}
local playermodel = require("model.playermodel")
local var_0_2 = false
local var_0_3 = {
	players = {
		damage = {},
		damage_skilltype = {},
		suffer = {},
		heal = {},
		effective_heal = {}
	},
	enemies = {
		damage = {},
		damage_skilltype = {},
		suffer = {},
		heal = {},
		effective_heal = {}
	}
}
local var_0_4 = {
	players = {},
	enemies = {}
}

local function var_0_5()
	var_0_3 = {
		players = {
			damage = {},
			damage_skilltype = {},
			suffer = {},
			heal = {},
			effective_heal = {}
		},
		enemies = {
			damage = {},
			damage_skilltype = {},
			suffer = {},
			heal = {},
			effective_heal = {}
		}
	}
end

local function var_0_6()
	var_0_4 = {
		players = {},
		enemies = {}
	}

	for iter_2_0, iter_2_1 in pairs(FightManager.players) do
		var_0_4.players[iter_2_0] = iter_2_1:getAttribute("modelid")
	end

	for iter_2_2, iter_2_3 in pairs(FightManager.enemies) do
		var_0_4.enemies[iter_2_2] = iter_2_3:getAttribute("modelid")
	end
end

local function var_0_7(arg_3_0, arg_3_1, arg_3_2)
	if not arg_3_1 then
		return
	end

	local var_3_0, var_3_1 = arg_3_1:match("([^@]+)@(.+)")

	if var_3_0:find("slave") then
		var_3_0 = var_3_0:match("slave(.+)")
		masterid, slaveid = var_3_1:match("(%d+)_(%d+)")
		var_3_1 = masterid
	end

	local var_3_2 = var_0_4[var_3_0][tonumber(var_3_1)]

	if not var_3_2 then
		return
	end

	var_0_3[var_3_0].damage[var_3_2] = (var_0_3[var_3_0].damage[var_3_2] or 0) + arg_3_0

	if arg_3_2 then
		var_0_3[var_3_0].damage_skilltype[var_3_2] = var_0_3[var_3_0].damage_skilltype[var_3_2] or {}
		var_0_3[var_3_0].damage_skilltype[var_3_2][arg_3_2] = (var_0_3[var_3_0].damage_skilltype[var_3_2][arg_3_2] or 0) + arg_3_0
	end
end

local function var_0_8(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	local var_4_0, var_4_1 = arg_4_1:match("([^@]+)@(.+)")
	local var_4_2 = var_0_4[var_4_0][tonumber(var_4_1)]

	if not var_4_2 then
		return
	end

	var_0_3[var_4_0].suffer[var_4_2] = (var_0_3[var_4_0].suffer[var_4_2] or 0) + arg_4_0
end

local function var_0_9(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return
	end

	local var_5_0, var_5_1 = arg_5_1:match("([^@]+)@(.+)")

	if var_5_0:find("slave") then
		var_5_0 = var_5_0:match("slave(.+)")
		masterid, slaveid = var_5_1:match("(%d+)_(%d+)")
		var_5_1 = masterid
	end

	local var_5_2 = var_0_4[var_5_0][tonumber(var_5_1)]

	if not var_5_2 then
		return
	end

	var_0_3[var_5_0].heal[var_5_2] = (var_0_3[var_5_0].heal[var_5_2] or 0) + arg_5_0
end

local function var_0_10(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return
	end

	local var_6_0, var_6_1 = arg_6_1:match("([^@]+)@(.+)")

	if var_6_0:find("slave") then
		var_6_0 = var_6_0:match("slave(.+)")
		masterid, slaveid = var_6_1:match("(%d+)_(%d+)")
		var_6_1 = masterid
	end

	local var_6_2 = var_0_4[var_6_0][tonumber(var_6_1)]

	if not var_6_2 then
		return
	end

	var_0_3[var_6_0].effective_heal[var_6_2] = (var_0_3[var_6_0].effective_heal[var_6_2] or 0) + arg_6_0
end

local function var_0_11()
	if config._DEVELOP_MODE ~= "FIGHTDEV" then
		return
	end

	require("devtools.FightDebugStatisticsLayer")
	FightDebugStatisticsLayer.getInstance():update(var_0_3, FightManager.getFightTimeStatistics())
end

function var_0_0.addStatistics(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if not var_0_2 then
		return
	end

	if not arg_8_4 then
		print("statistics.addStatistics msg is nil")

		arg_8_4 = {}
	end

	if arg_8_0 == "damage" then
		var_0_7(arg_8_1, arg_8_2, arg_8_4.skilltype)
		var_0_8(arg_8_1, arg_8_3)
	elseif arg_8_0 == "heal" then
		var_0_9(arg_8_1, arg_8_2)
	elseif arg_8_0 == "effective_heal" then
		var_0_10(arg_8_1, arg_8_2)
	end

	var_0_11()
end

function var_0_0.dumpdata()
	print(dump(var_0_3))
end

function var_0_0.startStatistics()
	var_0_5()

	var_0_2 = true
end

function var_0_0.stopStatistics()
	var_0_2 = false
end

function var_0_0.getStatisticsMsg()
	return var_0_3
end

function var_0_0.getStatisticModels()
	return var_0_4
end

function var_0_0.updateStatisticsModel()
	if not var_0_2 then
		return
	end

	var_0_6()
end

return var_0_0
