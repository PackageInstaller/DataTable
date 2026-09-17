local var_0_0 = {}
local model_data = require("data.model_data")
local level_manager = require("controller.level_manager")
local var_0_3 = print
local var_0_4 = assert
local var_0_5 = type
local var_0_6 = math
local var_0_7 = table
local var_0_8 = string
local var_0_9 = tonumber

local function var_0_10(arg_1_0)
	if var_0_5(arg_1_0) == "number" then
		return var_0_6.floor(arg_1_0 / 10000000)
	elseif var_0_5(arg_1_0) == "string" then
		return var_0_9(var_0_8.sub(arg_1_0, 1, var_0_8.len(arg_1_0) - 7))
	end
end

var_0_0.initMonsterList = (function(arg_2_0)
	return setfenv(function(arg_3_0)
		local var_3_0 = {}
		local var_3_1 = var_0_10(arg_3_0)

		if not monsterTeamData[var_3_1] then
			loadLevelData(var_3_1)
		end

		local var_3_2 = monsterTeamData[var_3_1][arg_3_0]

		var_0_4(monsterTeamData[var_3_1][arg_3_0] ~= nil, "there is no data of team " .. arg_3_0 .. " in monster team data!!!")

		while var_3_2["monster" .. 1] do
			var_3_0[#var_3_0 + 1] = {}
			var_3_0[#var_3_0 + 1].id = var_3_2["monster" .. 1]
			var_3_0[#var_3_0 + 1].majorlist = monsterData[var_3_1][var_3_2["monster" .. 1]]
			var_3_0[#var_3_0 + 1].pos = var_3_2["pos" .. 1]
			var_3_0[#var_3_0 + 1].posy = var_3_2["posy" .. 1]
			var_3_0[#var_3_0 + 1].delaytime = var_3_2["delay" .. 1]
			var_3_0[#var_3_0 + 1].offset = var_3_2["offset" .. 1]
		end

		return var_3_0
	end, arg_2_0)
end)(level_manager)
var_0_0.initBossList = (function(arg_4_0)
	return setfenv(function(arg_5_0)
		local var_5_0 = {}
		local var_5_1 = var_0_10(arg_5_0)

		if not monsterTeamData[var_5_1] then
			loadLevelData(var_5_1)
		end

		local var_5_2 = monsterTeamData[var_5_1][arg_5_0]

		var_0_4(monsterTeamData[var_5_1][arg_5_0] ~= nil, "there is no data of team " .. arg_5_0 .. " in monster team data!!!")

		while var_5_2["monster" .. 1] do
			var_5_0[#var_5_0 + 1] = {}
			var_5_0[#var_5_0 + 1].id = var_5_2["monster" .. 1]
			var_5_0[#var_5_0 + 1].majorlist = monsterData[var_5_1][var_5_2["monster" .. 1]]
			var_5_0[#var_5_0 + 1].pos = var_5_2["pos" .. 1]
			var_5_0[#var_5_0 + 1].posy = var_5_2["posy" .. 1]
			var_5_0[#var_5_0 + 1].delaytime = var_5_2["delay" .. 1]
			var_5_0[#var_5_0 + 1].offset = var_5_2["offset" .. 1]
			var_5_0[#var_5_0 + 1].index = #var_5_0 + 1
			var_5_0[#var_5_0 + 1].range = model_data[monsterData[var_5_1][var_5_2["monster" .. 1]].modelid].range
		end

		if #var_5_0 > 0 then
			var_0_7.sort(var_5_0, function(arg_6_0, arg_6_1)
				if arg_6_0.range == arg_6_1.range then
					return arg_6_0.index < arg_6_1.index
				else
					return arg_6_0.range < arg_6_1.range
				end
			end)
		end

		if var_5_2.boss then
			var_5_0.boss = {}
			var_5_0.boss.id = var_5_2.boss
			var_5_0.boss.majorlist = monsterData[var_5_1][var_5_2.boss]
			var_5_0.boss.pos = var_5_2.posboss
			var_5_0.boss.posy = var_5_2.posyboss
			var_5_0.boss.delaytime = var_5_2.delayboss
			var_5_0.boss.offset = var_5_2.offsetboss
		end

		return var_5_0
	end, arg_4_0)
end)(level_manager)
var_0_0.getMonsterTeamNames = (function(arg_7_0)
	return setfenv(function(arg_8_0)
		local var_8_0 = {}
		local var_8_1 = var_0_10(arg_8_0)

		if not monsterTeamData[var_8_1] then
			loadLevelData(var_8_1)
		end

		local var_8_2 = monsterTeamData[var_8_1][arg_8_0]

		while var_8_2["monster" .. 1] do
			var_8_0[#var_8_0 + 1] = model_data[monsterData[var_8_1][var_8_2["monster" .. 1]].modelid].name
		end

		if var_8_2.boss then
			var_8_0.boss = model_data[monsterData[var_8_1][var_8_2.boss].modelid].name
		end

		return var_8_0
	end, arg_7_0)
end)(level_manager)

local chapter_data = require("data.chapter_data")

function var_0_0.getChapterBigBoss(arg_9_0)
	local var_9_0 = var_0_10(chapter_data[arg_9_0].bigboss)
	local var_9_1 = level_manager.monsterTeamData[var_9_0][level_manager.dequeue_boss_team(level_manager.generate_boss_team(var_9_0, chapter_data[arg_9_0].bigboss))]
	local var_9_2 = var_9_1.boss or var_9_1.monster1

	return {
		id = var_9_2,
		majorlist = level_manager.monsterData[var_9_0][var_9_2],
		pos = var_9_1.posboss,
		posy = var_9_1.posyboss,
		delaytime = var_9_1.delayboss,
		offset = var_9_1.offsetboss,
		isFinal = var_9_1.isFinal
	}
end

function var_0_0.getChapterBigBossAll(arg_10_0, arg_10_1)
	local var_10_0 = level_manager.monsterTeamData[arg_10_0][level_manager.dequeue_boss_team(level_manager.generate_boss_team(arg_10_0, chapter_data[arg_10_1].bigboss))]
	local var_10_1 = {}

	while var_10_0["monster" .. 1] do
		var_10_1.monster = var_10_1.monster or {}

		var_0_7.insert(var_10_1.monster, {
			id = var_10_0["monster" .. 1],
			majorlist = level_manager.monsterData[arg_10_0][var_10_0["monster" .. 1]],
			pos = var_10_0["pos" .. 1],
			posy = var_10_0["posy" .. 1]
		})
	end

	if var_10_0.boss then
		var_10_1.boss = {
			id = var_10_0.boss,
			majorlist = level_manager.monsterData[arg_10_0][var_10_0.boss],
			pos = var_10_0.posboss,
			posy = var_10_0.posyboss,
			isFinal = var_10_0.isFinal
		}
	end

	return var_10_1
end

function var_0_0.getGroupChapterBigBossAll(arg_11_0, arg_11_1, arg_11_2)
	var_0_3("getGroupChapterBigBossAll", arg_11_0, arg_11_1, arg_11_2)

	local var_11_0 = level_manager.getCurLevelData(arg_11_0, arg_11_1)
	local var_11_1 = arg_11_2 == 1 and var_11_0.boss_team or tostring(var_11_0["boss_team_" .. arg_11_2])
	local var_11_2 = level_manager.monsterTeamData[arg_11_0][var_11_1]
	local var_11_3 = {}

	while var_11_2["monster" .. 1] do
		var_11_3.monster = var_11_3.monster or {}

		var_0_7.insert(var_11_3.monster, {
			id = var_11_2["monster" .. 1],
			majorlist = level_manager.monsterData[arg_11_0][var_11_2["monster" .. 1]],
			pos = var_11_2["pos" .. 1],
			posy = var_11_2["posy" .. 1]
		})
	end

	if var_11_2.boss then
		var_11_3.boss = {
			id = var_11_2.boss,
			majorlist = level_manager.monsterData[arg_11_0][var_11_2.boss],
			pos = var_11_2.posboss,
			posy = var_11_2.posyboss,
			isFinal = var_11_2.isFinal,
			offset = var_11_2.offsetboss
		}
	end

	return var_11_3, var_11_1
end

function var_0_0.getLevelBoss(arg_12_0, arg_12_1)
	local var_12_0 = level_manager.getCurLevelData(arg_12_0, arg_12_1)
	local var_12_1 = level_manager.dequeue_boss_team(level_manager.generate_boss_team(arg_12_0, (tostring(var_12_0.boss_team))))
	local var_12_2 = tostring(level_manager.monsterTeamData[arg_12_0][var_12_1].boss or level_manager.monsterTeamData[arg_12_0][var_12_1].monster1)

	var_0_4(var_12_2, "monsterTeamData[" .. arg_12_0 .. "][" .. var_12_1 .. "].monster1 is nil")
	var_0_4(level_manager.monsterData[arg_12_0][var_12_2], "monsterData id is nil:" .. var_12_2)

	local var_12_3 = {
		id = var_12_2,
		majorlist = level_manager.monsterData[arg_12_0][var_12_2],
		pos = level_manager.monsterTeamData[arg_12_0][var_12_1].posboss,
		posy = level_manager.monsterTeamData[arg_12_0][var_12_1].posyboss,
		delaytime = level_manager.monsterTeamData[arg_12_0][var_12_1].delayboss,
		offset = level_manager.monsterTeamData[arg_12_0][var_12_1].offsetboss,
		isFinal = level_manager.monsterTeamData[arg_12_0][var_12_1].isFinal
	}

	var_12_3.isGroup = not not var_12_0.boss_team_2

	return var_12_3
end

function var_0_0.isBoss(arg_13_0, arg_13_1)
	local var_13_0 = level_manager.loadMonsterTeamData(arg_13_0)
	local var_13_1 = var_13_0[chapter_data[tostring(arg_13_0) .. "-" .. tostring(arg_13_1)].bigboss]
	local var_13_2 = 1
	local var_13_3

	while var_13_1["subteam" .. var_13_2] do
		var_13_3 = var_13_1["subteam" .. var_13_2]
		var_13_2 = var_13_2 + 1
	end

	if var_13_1["subteam" .. var_13_2 - 1] and var_13_0[var_13_3].boss then
		return true
	end

	return false
end

function var_0_0.getLevelBossAll(arg_14_0, arg_14_1)
	var_0_3(arg_14_0, arg_14_1)

	local var_14_0 = level_manager.monsterTeamData[arg_14_0][level_manager.dequeue_boss_team(level_manager.generate_boss_team(arg_14_0, level_manager.getCurLevelData(arg_14_0, arg_14_1).boss_team))]
	local var_14_1 = {
		monster = {}
	}

	while var_14_0["monster" .. 1] do
		var_0_7.insert(var_14_1.monster, {
			id = var_14_0["monster" .. 1],
			majorlist = level_manager.monsterData[arg_14_0][var_14_0["monster" .. 1]],
			pos = var_14_0["pos" .. 1],
			posy = var_14_0["posy" .. 1]
		})
	end

	if var_14_0.boss then
		var_14_1.boss = {
			id = var_14_0.boss,
			majorlist = level_manager.monsterData[arg_14_0][var_14_0.boss],
			pos = var_14_0.posboss,
			posy = var_14_0.posyboss,
			isFinal = var_14_0.isFinal
		}
	end

	return var_14_1
end

function var_0_0.getMonsterData(arg_15_0, arg_15_1, arg_15_2)
	return level_manager.monsterData[arg_15_1][arg_15_2]
end

return var_0_0
