local var_0_0 = {}

LEVELMODE_NORMAL = 1
LEVELMODE_ADVENTURE = 2
MAIN_MODE = 1

local var_0_1 = 6

setmetatable(var_0_0, {
	__index = require("controller.level_manager_ext")
})

local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local levelmode_data = require("data.levelmode_data")
local chapter_data = require("data.chapter_data")
local battlefield_status_data = require("data.battlefield_status_data")
local city_data = require("data.city_data")
local level_bgm = require("data.level_bgm")
local city_area_data = require("data.city_area_data")
local time_check_manager = require("controller.time_check_manager")

local function var_0_11(arg_1_0, arg_1_1)
	if arg_1_1 >= 2101 and arg_1_1 <= 2199 then
		return require(arg_1_0 .. 2101 + (math.ceil(arg_1_1 % 2100 / 3) - 1) * 3)
	end

	return require(arg_1_0 .. arg_1_1)
end

local var_0_12 = setmetatable({}, {
	__index = function(arg_2_0, arg_2_1)
		local var_2_0 = var_0_11("data.leveldata.level_data_", arg_2_1)

		arg_2_0[arg_2_1] = var_2_0

		return var_2_0
	end
})
local var_0_13 = setmetatable({}, {
	__index = function(arg_3_0, arg_3_1)
		local var_3_0 = var_0_11("data.leveldata.monster_team_data", arg_3_1)

		arg_3_0[arg_3_1] = var_3_0

		return var_3_0
	end
})
local var_0_14 = setmetatable({}, {
	__index = function(arg_4_0, arg_4_1)
		local var_4_0 = var_0_11("data.leveldata.monster_data", arg_4_1)

		arg_4_0[arg_4_1] = var_4_0

		return var_4_0
	end
})

var_0_0.levelData = var_0_12
var_0_0.monsterTeamData = var_0_13
var_0_0.monsterData = var_0_14

local network = require("network.network")

local function var_0_17(arg_6_0)
	return tonumber((arg_6_0:match("^%d+")))
end

local function var_0_18(arg_7_0)
	local var_7_0, var_7_1 = arg_7_0:match("(%d+)-(%d+)")

	return tonumber(var_7_0), tonumber(var_7_1)
end

function var_0_0.loadLevelData(arg_8_0)
	return var_0_12[arg_8_0]
end

function var_0_0.getCurLevelData(arg_9_0, arg_9_1)
	local var_9_0 = var_0_0.loadLevelData(arg_9_0)

	if not var_9_0 or not var_9_0[arg_9_0 .. "-" .. arg_9_1] then
		print("error data")
	end

	return var_9_0[arg_9_0 .. "-" .. arg_9_1]
end

function var_0_0.loadMonsterTeamData(arg_10_0)
	return var_0_13[arg_10_0]
end

function var_0_0.getCurMonsterTeamData(arg_11_0, arg_11_1)
	local var_11_0 = var_0_0.loadMonsterTeamData(arg_11_0)

	if not var_11_0 or not var_11_0[arg_11_1] then
		print("error data")
	end

	return var_11_0[arg_11_1]
end

function var_0_0.loadMonsterData(arg_12_0)
	return var_0_14[arg_12_0]
end

function var_0_0.getCurMonsterData(arg_13_0, arg_13_1)
	local var_13_0 = var_0_0.loadMonsterData(arg_13_0)

	if not var_13_0 or not var_13_0[arg_13_1] then
		print("error data")
	end

	return var_13_0[arg_13_1]
end

function var_0_0:formatModeChapterLevelByPlayerLevel(arg_14_1, arg_14_2)
	return self:formatSystemUnlockLevel(arg_14_1, arg_14_2)
end

function var_0_0.isPlayerPassLevel(arg_15_0, arg_15_1)
	if type(arg_15_1) == "number" then
		local var_15_0 = math.floor(arg_15_1 / 1000)

		if var_15_0 <= 0 then
			var_15_0 = 1
		end

		if playermodel.levelmode[var_15_0] then
			return playermodel.levelmode[var_15_0].status > arg_15_1 % 1000
		end
	elseif type(arg_15_1) == "string" then
		local var_15_1, var_15_2 = arg_15_1:match("(%d+)-(%d+)")

		if playermodel.levelmode[tonumber(var_15_1)] then
			return playermodel.levelmode[tonumber(var_15_1)].status > tonumber(var_15_2)
		end
	elseif type(arg_15_1) == "table" and playermodel.levelmode[arg_15_1.mode] then
		return playermodel.levelmode[arg_15_1.mode].status > arg_15_1.chapter
	end

	return false
end

function var_0_0:formatSystemUnlockLevel(arg_16_1, arg_16_2)
	local var_16_0
	local var_16_1

	if type(arg_16_1) == "number" then
		var_16_0 = math.floor(arg_16_1 / 1000)

		if var_16_0 == 0 then
			var_16_0 = 1
		end

		var_16_1 = arg_16_1 % 1000
	elseif type(arg_16_1) == "string" then
		var_16_0, var_16_1 = arg_16_1:match("(%d+)-(%d+)")
		var_16_0 = tonumber(var_16_0)
		var_16_1 = tonumber(var_16_1)
	elseif type(arg_16_1) == "table" then
		var_16_0 = arg_16_1.mode
		var_16_1 = arg_16_1.chapter
	else
		return ""
	end

	if var_16_1 <= 0 then
		var_16_1 = 1
	end

	local var_16_2 = self:getDifficultByMode(var_16_0)

	if arg_16_2 then
		return string.format("%s%s", var_16_2 == 1 and "" or L_LEVEL_MODE_DIF[var_16_2], self:getChapterName(var_16_0, var_16_1))
	else
		return string.format("%s%s%s", L_CHECK_TASK_DATA.tasktypeStr[1], var_16_2 == 1 and "" or L_LEVEL_MODE_DIF[var_16_2], self:getChapterName(var_16_0, var_16_1))
	end
end

function var_0_0.isPlayerPassSmallLevel(arg_17_0, arg_17_1)
	if type(arg_17_1) == "number" then
		local var_17_0 = math.floor(arg_17_1 / 10000)
		local var_17_1 = math.floor(arg_17_1 % 10000 / 10)
		local var_17_2 = arg_17_1 % 10
		local var_17_3, var_17_4 = playermodel.levelmode[var_17_0].level:match("(%d+)-(%d+)")
		local var_17_5 = tonumber(var_17_4)
		local var_17_6 = tonumber(var_17_3)

		return var_17_1 < playermodel.levelmode[var_17_0].status or var_17_1 < var_17_6 or var_17_6 == var_17_1 and var_17_2 < var_17_5
	elseif type(arg_17_1) == "string" then
		local var_17_7, var_17_8, var_17_9 = arg_17_1:match("(%d+)-(%d+)-(%d+)")
		local var_17_10 = tonumber(var_17_9)
		local var_17_11 = tonumber(var_17_8)
		local var_17_12 = tonumber(var_17_7)
		local var_17_13, var_17_14 = playermodel.levelmode[var_17_12].level:match("(%d+)-(%d+)")
		local var_17_15 = tonumber(var_17_14)
		local var_17_16 = tonumber(var_17_13)

		return var_17_11 < playermodel.levelmode[var_17_12].status or var_17_11 < var_17_16 or var_17_16 == var_17_11 and var_17_10 < var_17_15
	elseif type(arg_17_1) == "table" then
		-- block empty
	end

	return false
end

function var_0_0.isPlayerPassBigBoss(arg_18_0, arg_18_1)
	if type(arg_18_1) == "number" then
		local var_18_0 = math.floor(arg_18_1 / 1000)

		if var_18_0 <= 0 then
			var_18_0 = 1
		end

		return playermodel.levelmode[var_18_0].pass > arg_18_1 % 1000
	elseif type(arg_18_1) == "string" then
		local var_18_1, var_18_2 = arg_18_1:match("(%d+)-(%d+)")

		return playermodel.levelmode[tonumber(var_18_1)].pass > tonumber(var_18_2)
	elseif type(arg_18_1) == "table" then
		return playermodel.levelmode[arg_18_1.mode].pass > arg_18_1.chapter
	end

	return false
end

function var_0_0.getLevelName(arg_19_0, arg_19_1, arg_19_2)
	return var_0_0.getCurLevelData(arg_19_1, arg_19_2).level_name or arg_19_2
end

var_0_0.curMode = nil
var_0_0.curLevel = nil
var_0_0.boss = nil
var_0_0.enemylist = {}
var_0_0.curindex = 1
var_0_0.hanguplist = {}
var_0_0.curhangupindex = 1

local function var_0_19(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if not arg_20_0 or not arg_20_1 or not arg_20_2 or not arg_20_3 then
		return false
	end

	if arg_20_0 ~= arg_20_2 then
		return false
	end

	return var_0_17(arg_20_1) == var_0_17(arg_20_3)
end

local function var_0_20(arg_21_0, arg_21_1)
	if not arg_21_1 then
		return 11500500
	end

	local var_21_0 = var_0_0.getCurMonsterTeamData(arg_21_0, arg_21_1)

	if var_21_0.subteam1 then
		local var_21_1 = {
			index = 0,
			teams = {}
		}

		while var_21_0["subteam" .. 1] do
			table.insert(var_21_1.teams, var_21_0["subteam" .. 1])
		end

		return var_21_1
	else
		return arg_21_1
	end
end

var_0_0.generate_boss_team = var_0_20

function var_0_0.resetCurLevelEnemy(arg_22_0, arg_22_1)
	if not var_0_19(var_0_0.curMode, var_0_0.curLevel, arg_22_0, arg_22_1) then
		var_0_0.resetCurHangupEnemy(arg_22_0, arg_22_1)
	end

	var_0_0.curMode = arg_22_0
	var_0_0.curLevel = arg_22_1
	var_0_0.curChapter = var_0_17(arg_22_1)
	var_0_0.curindex = 1
	var_0_0.curhangupindex = 1

	local var_22_0 = var_0_0.getCurLevelData(arg_22_0, arg_22_1)

	assert(var_22_0 ~= nil, "there is no data of level " .. arg_22_1 .. " in leveldata")

	var_0_0.boss = var_0_20(arg_22_0, var_22_0.boss_team)
	var_0_0.bigboss = var_0_20(arg_22_0, chapter_data[arg_22_0 .. "-" .. var_0_0.curChapter].bigboss)
	var_0_0.enemylist = {}

	while var_22_0["monster_team" .. 1] do
		var_0_0.enemylist[1] = var_22_0["monster_team" .. 1]
	end
end

function var_0_0.getMonsterTeam()
	var_0_0.curindex = var_0_0.curindex + 1

	if var_0_0.curindex > #var_0_0.enemylist then
		var_0_0.curindex = 1
	end

	return var_0_0.enemylist[var_0_0.curindex]
end

local function var_0_21(arg_24_0)
	if type(arg_24_0) == "table" then
		return arg_24_0.teams[arg_24_0.index + 1]
	else
		return arg_24_0
	end
end

local function var_0_22(arg_25_0)
	if type(arg_25_0) == "table" then
		arg_25_0.index = arg_25_0.index + 1

		return arg_25_0.index >= #arg_25_0.teams
	else
		return true
	end
end

local function var_0_23(arg_26_0)
	if type(arg_26_0) == "table" then
		return arg_26_0.index + 1
	else
		return 1
	end
end

function var_0_0:dequeue_boss_team()
	if type(self) == "table" then
		return self.teams[#self.teams]
	else
		return self
	end
end

function var_0_0.reset_boss_team_proceed()
	if type(var_0_0.bigboss) == "table" then
		var_0_0.bigboss.index = 0
	end

	if type(var_0_0.boss) == "table" then
		var_0_0.boss.index = 0
	end
end

local function var_0_24(arg_29_0)
	if type(arg_29_0) == "table" then
		return arg_29_0.index == #arg_29_0.teams - 1
	else
		return false
	end
end

function var_0_0.isBossTeamLastButOne(arg_30_0)
	if var_0_0:isBigBossNow() then
		return var_0_24(var_0_0.bigboss)
	else
		return var_0_24(var_0_0.boss)
	end
end

function var_0_0.isBossTeam(arg_31_0)
	if var_0_0:isBigBossNow() then
		if type(var_0_0.bigboss) == "table" then
			return true
		else
			return false
		end
	elseif type(var_0_0.boss) == "table" then
		return true
	else
		return false
	end
end

function var_0_0.isBossTeamFinished()
	if var_0_0:isBigBossNow() then
		return var_0_22(var_0_0.bigboss)
	else
		return var_0_22(var_0_0.boss)
	end
end

local function var_0_25(arg_33_0)
	if type(arg_33_0) == "table" then
		return #arg_33_0.teams
	else
		return 1
	end
end

function var_0_0.getBossTeamSumNum()
	if var_0_0:isBigBossNow() then
		return var_0_25(var_0_0.bigboss)
	else
		return var_0_25(var_0_0.boss)
	end
end

function var_0_0.getBossTeamProceed()
	if var_0_0:isBigBossNow() then
		return var_0_23(var_0_0.bigboss)
	else
		return var_0_23(var_0_0.boss)
	end
end

function var_0_0.getBossTeam()
	if var_0_0:isBigBossNow() then
		return var_0_21(var_0_0.bigboss)
	else
		return var_0_21(var_0_0.boss)
	end
end

function var_0_0.getBigBossTeam(arg_37_0)
	return var_0_21(var_0_0.bigboss)
end

function var_0_0.getAllMonsterList(arg_38_0, arg_38_1)
	arg_38_0 = arg_38_0 or var_0_0.curMode
	arg_38_1 = arg_38_1 or var_0_0.curChapter

	local var_38_0 = {}

	while chapter_data[arg_38_0 .. "-" .. arg_38_1]["monster_team" .. 1] do
		var_38_0[chapter_data[arg_38_0 .. "-" .. arg_38_1]["monster_team" .. 1]] = true
	end

	for iter_38_0 = 1, chapter_data[arg_38_0 .. "-" .. arg_38_1].level_num do
		local var_38_2 = var_0_0.getCurLevelData(arg_38_0, arg_38_1 .. "-" .. iter_38_0)
		local var_38_3 = 1

		while var_38_2["monster_team" .. var_38_3] do
			var_38_0[var_38_2["monster_team" .. var_38_3]] = true
			var_38_3 = var_38_3 + 1
		end

		local var_38_4 = var_0_20(arg_38_0, var_38_2.boss_team)

		if type(var_38_4) == "table" then
			for iter_38_1, iter_38_2 in ipairs(var_38_4.teams) do
				var_38_0[iter_38_2] = true
			end
		else
			var_38_0[var_38_4] = true
		end
	end

	if chapter_data[arg_38_0 .. "-" .. arg_38_1].bigboss then
		local var_38_5 = var_0_20(arg_38_0, chapter_data[arg_38_0 .. "-" .. arg_38_1].bigboss)

		if type(var_38_5) == "table" then
			for iter_38_3, iter_38_4 in ipairs(var_38_5.teams) do
				var_38_0[iter_38_4] = true
			end
		else
			var_38_0[var_38_5] = true
		end
	end

	local var_38_6 = {}

	for iter_38_5, iter_38_6 in pairs(var_38_0) do
		while var_0_0.monsterTeamData[arg_38_0][iter_38_5]["monster" .. 1] do
			var_38_6[var_0_0.monsterData[arg_38_0][var_0_0.monsterTeamData[arg_38_0][iter_38_5]["monster" .. 1]].modelid] = true
		end

		if var_0_0.monsterTeamData[arg_38_0][iter_38_5].boss then
			var_38_6[var_0_0.monsterData[arg_38_0][var_0_0.monsterTeamData[arg_38_0][iter_38_5].boss].modelid] = true
		end
	end

	local var_38_8 = {}

	for iter_38_7, iter_38_8 in pairs(var_38_6) do
		table.insert(var_38_8, iter_38_7)
	end

	return var_38_8
end

function var_0_0.getAdventureAllMonsterList()
	local var_39_0 = {}

	for iter_39_0, iter_39_1 in ipairs(var_0_0.enemylist) do
		var_39_0[iter_39_1] = true
	end

	if var_0_0.boss then
		if type(var_0_0.boss) == "table" then
			for iter_39_2, iter_39_3 in ipairs(var_0_0.boss.teams) do
				var_39_0[iter_39_3] = true
			end
		else
			var_39_0[var_0_0.boss] = true
		end
	end

	local var_39_1 = {}

	for iter_39_4, iter_39_5 in pairs(var_39_0) do
		while var_0_0.monsterTeamData[var_0_0.curMode][iter_39_4]["monster" .. 1] do
			var_39_1[var_0_0.monsterData[var_0_0.curMode][var_0_0.monsterTeamData[var_0_0.curMode][iter_39_4]["monster" .. 1]].modelid] = true
		end

		if var_0_0.monsterTeamData[var_0_0.curMode][iter_39_4].boss then
			var_39_1[var_0_0.monsterData[var_0_0.curMode][var_0_0.monsterTeamData[var_0_0.curMode][iter_39_4].boss].modelid] = true
		end
	end

	local var_39_3 = {}

	for iter_39_6, iter_39_7 in pairs(var_39_1) do
		table.insert(var_39_3, iter_39_6)
	end

	return var_39_3
end

function var_0_0.getAdventureModeAllBossList()
	local var_40_0 = {}

	for iter_40_0 = 1, levelmode_data[var_0_0.curMode].totalchapter do
		var_40_0[var_0_20(var_0_0.curMode, var_0_0.getCurLevelData(var_0_0.curMode, iter_40_0 .. "-1").boss_team)] = true
	end

	local var_40_1 = {}

	for iter_40_1, iter_40_2 in pairs(var_40_0) do
		while var_0_0.monsterTeamData[var_0_0.curMode][iter_40_1]["monster" .. 1] do
			var_40_1[var_0_0.monsterData[var_0_0.curMode][var_0_0.monsterTeamData[var_0_0.curMode][iter_40_1]["monster" .. 1]].modelid] = true
		end

		if var_0_0.monsterTeamData[var_0_0.curMode][iter_40_1].boss then
			var_40_1[var_0_0.monsterData[var_0_0.curMode][var_0_0.monsterTeamData[var_0_0.curMode][iter_40_1].boss].modelid] = true
		end
	end

	local var_40_3 = {}

	for iter_40_3, iter_40_4 in pairs(var_40_1) do
		table.insert(var_40_3, iter_40_3)
	end

	return var_40_3
end

function var_0_0.resetCurHangupEnemy(arg_41_0, arg_41_1)
	local var_41_0 = chapter_data[arg_41_0 .. "-" .. var_0_17(arg_41_1)]

	var_0_0.hanguplist = {}

	while var_41_0["monster_team" .. 1] do
		var_0_0.hanguplist[1] = var_41_0["monster_team" .. 1]
	end
end

function var_0_0.getHangupTeam()
	var_0_0.curhangupindex = var_0_0.curhangupindex + 1

	if var_0_0.curhangupindex > #var_0_0.hanguplist then
		var_0_0.curhangupindex = 1
	end

	return var_0_0.hanguplist[var_0_0.curhangupindex]
end

function var_0_0.resetCurFightSouls(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = chapter_data[arg_43_1 .. "-" .. var_0_17(arg_43_2)]

	playermodel.curSoul = {}

	for iter_43_0 = 1, var_0_1 do
		if var_43_0["fightsoulconfig" .. iter_43_0] then
			local var_43_1 = {
				classtype = 2,
				pos = iter_43_0
			}

			if var_43_0["fightsoulconfig" .. iter_43_0] > 0 then
				var_43_1.fight_girl = var_43_0["fightsoulconfig" .. iter_43_0] or nil
			end

			playermodel.curSoul[iter_43_0] = var_43_1
		end
	end

	local array_manager = require("controller.array_manager")
	local var_43_3 = array_manager:getBattleArrayData(array_manager.curArray)

	for iter_43_1 = 1, FORMATION_SHOW_GIRL_NUM do
		if var_43_3 and var_43_3[iter_43_1] and var_43_3[iter_43_1].fight_girl then
			if not playermodel.curSoul[iter_43_1] then
				playermodel.curSoul[iter_43_1] = {
					classtype = 1,
					pos = iter_43_1,
					fight_girl = var_43_3[iter_43_1].fight_girl,
					assist_girl = var_43_3[iter_43_1].assist_girl,
					assist = var_43_3.assist
				}
			else
				playermodel.curSoul[iter_43_1].assist = var_43_3.assist
			end
		end
	end
end

function var_0_0.resetCurFightSoulsAdventure(arg_44_0, arg_44_1, arg_44_2)
	local activity_manager = require("controller.activity_manager")
	local var_44_1 = require("controller.formation.formation_mode_manager"):getInstance()

	if activity_manager:isjumpTowerMode(arg_44_1) then
		var_44_1 = require("controller.formation.formation_jumptower_manager"):getInstance()
	elseif activity_manager:isLockActivityBossFight(arg_44_1) then
		var_44_1 = require("controller.formation.formation_bossfight_manager"):getInstance()
	end

	playermodel.curSoul = {}

	local var_44_2 = var_44_1:getFormationInfo()[1] or {}

	for iter_44_0 = 1, FORMATION_SHOW_GIRL_NUM do
		if var_44_2[iter_44_0] and var_44_2[iter_44_0].fight_girl then
			playermodel.curSoul[iter_44_0] = {
				classtype = 1,
				pos = iter_44_0,
				fight_girl = var_44_2[iter_44_0].fight_girl,
				assist_girl = var_44_2[iter_44_0].assist_girl,
				assist = var_44_2.assist
			}
		end
	end
end

function var_0_0.getCurFightEnemys(arg_45_0)
	return var_0_13[arg_45_0][FightManager.isFightingBoss() and var_0_0.getBossTeam() or (var_0_0:isCurChapterOld() or var_0_0:isChapterComplete()) and var_0_0.hanguplist[var_0_0.curhangupindex] or var_0_0.enemylist[var_0_0.curindex]]
end

function var_0_0.getChapterBattleFieldConfig(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = chapter_data[arg_46_1 .. "-" .. var_0_17(arg_46_2)]
	local var_46_1 = {}

	while var_46_0["battlefieldstatus" .. 1] do
		table.insert(var_46_1, var_46_0["battlefieldstatus" .. 1])
	end

	return var_46_1
end

function var_0_0.getChapterBattleFieldInfo(arg_47_0, ...)
	local var_47_0
	local var_47_1 = {
		...
	}

	var_47_0 = #var_47_1 == 2 and chapter_data[var_47_1[1] .. "-" .. var_0_17(var_47_1[2])] or chapter_data[var_47_1[1]]

	local var_47_2 = {}
	local var_47_3 = {}

	while var_47_0["battlefieldstatus" .. 1] do
		table.insert(var_47_3, battlefield_status_data[var_47_0["battlefieldstatus" .. 1]].des)

		if battlefield_status_data[var_47_0["battlefieldstatus" .. 1]].des then
			table.insert(var_47_2, var_47_0["battlefieldstatus" .. 1])
		end
	end

	return var_47_3, var_47_2
end

function var_0_0.getCurFightChapter(arg_48_0)
	return playermodel.curMode .. "-" .. var_0_17(playermodel.levelmode[playermodel.curMode].curlevel)
end

function var_0_0.isCurChapterOld(arg_49_0)
	local var_49_0 = playermodel.curMode

	if levelmode_data[playermodel.curMode].modetype ~= 1 then
		return false
	end

	return var_0_17(playermodel.levelmode[var_49_0].curlevel) < var_0_17(playermodel.levelmode[var_49_0].level)
end

function var_0_0.isChapterComplete(arg_50_0)
	local var_50_0 = playermodel.curMode

	if levelmode_data[playermodel.curMode].modetype ~= 1 then
		return false
	end

	local var_50_1, var_50_2 = var_0_18(playermodel.levelmode[var_50_0].level)

	return playermodel.levelmode[var_50_0].level == playermodel.levelmode[var_50_0].curlevel and var_50_2 >= chapter_data[var_50_0 .. "-" .. var_50_1].level_num and var_50_1 == playermodel.levelmode[var_50_0].status - 1
end

function var_0_0.isCanOpenBond(arg_51_0)
	return playermodel.levelmode[1].status == 6 and playermodel.levelmode[1].pass == 6
end

function var_0_0.isBigBossNow(arg_52_0)
	local var_52_0 = playermodel.curMode

	if levelmode_data[playermodel.curMode].modetype ~= 1 then
		return false
	end

	local var_52_1, var_52_2 = var_0_18(playermodel.levelmode[var_52_0].level)

	return playermodel.levelmode[var_52_0].level == playermodel.levelmode[var_52_0].curlevel and var_52_2 >= chapter_data[var_52_0 .. "-" .. var_52_1].level_num and var_52_1 == playermodel.levelmode[var_52_0].status and playermodel.levelmode[var_52_0].status == playermodel.levelmode[var_52_0].pass - 1
end

function var_0_0.isHangupComplete(arg_53_0)
	return true
end

function var_0_0:addHangupCount()
	if self:isCurChapterOld() then
		return false
	end

	return true
end

function var_0_0:getCurHangupInfo(arg_55_1, arg_55_2)
	return self:getCurEnemyCount(arg_55_1) .. "/" .. (var_0_0.getCurLevelData(arg_55_1, arg_55_2).enemycount or 3)
end

function var_0_0.isAutoFightBoss(arg_56_0)
	local var_56_0 = playermodel.curMode
	local var_56_1, var_56_2 = var_0_18(playermodel.levelmode[playermodel.curMode].level)

	return var_56_2 < chapter_data[var_56_0 .. "-" .. var_56_1].level_num
end

function var_0_0:cleanHangupCount()
	if self:isCurChapterOld() then
		self.curhangupindex = 1

		return
	end

	self.curindex = 1

	self:cleanCurEnemyCount(playermodel.curMode)
end

function var_0_0.isCurNewChapter(arg_58_0)
	local var_58_0 = playermodel.curMode
	local var_58_1, var_58_2 = var_0_18(playermodel.curLevel)

	return var_58_2 == 1 and var_58_1 == playermodel.levelmode[var_58_0].status
end

function var_0_0:isHangupValid()
	return self:isLevelModeHangupValid(playermodel.curMode)
end

function var_0_0:isLevelModeComplete(arg_60_1, arg_60_2)
	arg_60_1 = arg_60_1 or playermodel.curMode
	arg_60_2 = arg_60_2 or var_0_17(playermodel.levelmode[arg_60_1].curlevel)

	return arg_60_2 >= self:getModeTotalChapter(arg_60_1)
end

local var_0_26 = {}

function var_0_0.update_city_lock_stat(arg_61_0, arg_61_1)
	arg_61_1 = arg_61_1 or {}
	var_0_26 = {}

	for iter_61_0, iter_61_1 in ipairs(arg_61_1) do
		var_0_26[iter_61_1.id] = iter_61_1.stat
	end
end

function var_0_0.can_city_join(arg_62_0, arg_62_1)
	return var_0_26[arg_62_1] == nil
end

function var_0_0.getCityList(arg_63_0)
	local var_63_0 = {}

	for iter_63_0, iter_63_1 in pairs(city_data) do
		if not iter_63_1.is_talk_city and not var_0_26[iter_63_1.id] and not iter_63_1.is_activity_city and not iter_63_1.is_big_war_city and iter_63_1.show_in_levelmap then
			table.insert(var_63_0, iter_63_1.id)
		end
	end

	table.sort(var_63_0, function(arg_64_0, arg_64_1)
		return arg_64_0 < arg_64_1
	end)

	return var_63_0
end

function var_0_0.getSpecialCityList(arg_65_0)
	local var_65_0 = {}

	for iter_65_0, iter_65_1 in pairs(city_data) do
		if not iter_65_1.is_talk_city and not var_0_26[iter_65_1.id] and not iter_65_1.is_activity_city and not iter_65_1.is_big_war_city and iter_65_1.show_in_specialmapbox then
			table.insert(var_65_0, iter_65_1.id)
		end
	end

	table.sort(var_65_0, function(arg_66_0, arg_66_1)
		return arg_66_0 < arg_66_1
	end)

	return var_65_0
end

function var_0_0:getCityBoxList()
	local var_67_0 = {}

	for iter_67_0, iter_67_1 in pairs(city_data) do
		if not iter_67_1.is_talk_city and not var_0_26[iter_67_1.id] and not iter_67_1.is_activity_city and not iter_67_1.is_big_war_city and iter_67_1.show_in_levelmapbox and self:checkUnlockTime(iter_67_1.id) then
			table.insert(var_67_0, iter_67_1.id)
		end
	end

	table.sort(var_67_0, function(arg_68_0, arg_68_1)
		return arg_68_0 < arg_68_1
	end)

	return var_67_0
end

function var_0_0.isSubCity(arg_69_0, arg_69_1)
	for iter_69_0, iter_69_1 in pairs(city_data) do
		if not iter_69_1.is_talk_city and iter_69_1.areaid then
			return arg_69_1
		end
	end

	return false
end

function var_0_0.getAreaList(arg_70_0)
	local var_70_0 = {}

	for iter_70_0, iter_70_1 in pairs(city_area_data) do
		if iter_70_1.subcity1 then
			table.insert(var_70_0, iter_70_1.subcity1)
		end
	end

	return var_70_0
end

function var_0_0.getActivityCityListById(arg_71_0, arg_71_1)
	local var_71_0 = {}

	if arg_71_1 > 400 then
		local var_71_1 = ACTIVITY_ID_TO_MODETYPE_FUNC.level(arg_71_1)

		for iter_71_0 = 1, 10 do
			local var_71_2 = tonumber(var_71_1 .. iter_71_0)

			if city_data[var_71_2] then
				table.insert(var_71_0, var_71_2)
			else
				break
			end
		end
	else
		for iter_71_1, iter_71_2 in pairs(city_data) do
			if iter_71_2.is_activity_city and string.find(iter_71_2.id, arg_71_1) then
				table.insert(var_71_0, iter_71_2.id)
			end
		end
	end

	table.sort(var_71_0, function(arg_72_0, arg_72_1)
		return arg_72_0 < arg_72_1
	end)

	return var_71_0
end

function var_0_0.getAreaId(arg_73_0, arg_73_1)
	local var_73_0

	for iter_73_0, iter_73_1 in pairs(city_data) do
		if iter_73_1.id == arg_73_1 and iter_73_1.areaid then
			var_73_0 = iter_73_1.areaid
		end
	end

	return var_73_0
end

function var_0_0.getAreaJumpLayer(arg_74_0, arg_74_1)
	local var_74_0 = "LevelMapLayer"

	for iter_74_0, iter_74_1 in pairs(city_area_data) do
		if iter_74_1.id == arg_74_1 and iter_74_1.showlayer then
			var_74_0 = iter_74_1.showlayer
		end
	end

	return var_74_0
end

function var_0_0.getAreaModeType(arg_75_0, arg_75_1)
	local var_75_0

	for iter_75_0, iter_75_1 in pairs(city_area_data) do
		if iter_75_1.id == arg_75_1 and iter_75_1.modetype then
			var_75_0 = iter_75_1.modetype
		end
	end

	return var_75_0
end

function var_0_0.getAreaSubCity(arg_76_0, arg_76_1)
	local var_76_0 = {}

	if not arg_76_1 then
		return var_76_0
	end

	for iter_76_0, iter_76_1 in pairs(city_area_data) do
		if iter_76_1.id == arg_76_1 then
			while iter_76_1["subcity" .. 1] do
				var_76_0[1] = iter_76_1["subcity" .. 1]
			end
		end
	end

	return var_76_0
end

function var_0_0.getTaskFile(arg_77_0, arg_77_1)
	if not arg_77_1 then
		return
	end

	for iter_77_0, iter_77_1 in pairs(city_area_data) do
		if iter_77_1.id == arg_77_1 and iter_77_1.taskfile then
			return iter_77_1.taskfile
		end
	end
end

function var_0_0.getConversationId(arg_78_0, arg_78_1)
	if not arg_78_1 then
		return
	end

	for iter_78_0, iter_78_1 in pairs(city_area_data) do
		if iter_78_1.id == arg_78_1 and iter_78_1.conversation then
			return iter_78_1.conversation
		end
	end
end

function var_0_0.getTalkCityList(arg_79_0)
	local var_79_0 = {}

	for iter_79_0, iter_79_1 in pairs(city_data) do
		if iter_79_1.is_talk_city then
			table.insert(var_79_0, iter_79_1.id)
		end
	end

	table.sort(var_79_0, function(arg_80_0, arg_80_1)
		return arg_80_0 < arg_80_1
	end)

	return var_79_0
end

function var_0_0:isMainCity(arg_81_1)
	if self:isTalkCity(arg_81_1) then
		return false
	end

	if self:isActivityCity(arg_81_1) then
		return false
	end

	if self:isBranchCity(arg_81_1) then
		return false
	end

	return true
end

function var_0_0:isMainLevel(arg_82_1)
	if self:isTalkLevel(arg_82_1) then
		return false
	end

	if self:isActivityLevel(arg_82_1) then
		return false
	end

	return true
end

function var_0_0:isCityUnlocked(arg_83_1, arg_83_2)
	arg_83_2 = arg_83_2 or 1

	return playermodel.citystat[arg_83_1] and self:isLevelModeUnlocked(city_data[arg_83_1]["difficulty" .. arg_83_2])
end

function var_0_0:isCityCanUnlock(arg_84_1)
	return not playermodel.citystat[arg_84_1] and self:isLevelModeUnlocked(city_data[arg_84_1].difficulty1)
end

function var_0_0:isCityLockedByTime(arg_85_1)
	local var_85_0 = playermodel.citystat[arg_85_1]

	if playermodel.citystat[arg_85_1] then
		var_85_0 = self:isLevelModeAutoUnlocked(city_data[arg_85_1].difficulty1)
		var_85_0 = var_85_0 and self:isModeManualLocked(city_data[arg_85_1].difficulty1)
	end

	return var_85_0
end

function var_0_0.getCityUnlockTime(arg_86_0, arg_86_1)
	local time_check_manager = require("controller.time_check_manager")

	return os.time(parse_time(levelmode_data[city_data[arg_86_1].difficulty1].unlocktime))
end

function var_0_0.checkUnlockTime(arg_87_0, arg_87_1)
	return (((levelmode_data[city_data[arg_87_1].difficulty1].unlocktime or nil) and os.time(parse_time(levelmode_data[city_data[arg_87_1].difficulty1].unlocktime))) < require("controller.time_check_manager"):getCurTime() or nil) and true
end

function var_0_0.isDisableBuff(arg_88_0, arg_88_1)
	return not not (levelmode_data[city_data[arg_88_1].difficulty1] and levelmode_data[city_data[arg_88_1].difficulty1].isdisablebuff == 1)
end

function var_0_0.getCityName(arg_89_0, arg_89_1)
	return city_data[arg_89_1].name
end

function var_0_0.getCityDes(arg_90_0, arg_90_1)
	return city_data[arg_90_1].des or L_CITY_DEFAULT_DES
end

function var_0_0.getCityImg(arg_91_0, arg_91_1)
	return city_data[arg_91_1].img
end

function var_0_0.getCityConf(arg_92_0, arg_92_1)
	return city_data[arg_92_1].cityconf or "Map1"
end

function var_0_0.getActivityLevelMapJson(arg_93_0, arg_93_1)
	return (city_data[arg_93_1] and city_data[arg_93_1].levelmapjson or nil) and city_data[arg_93_1].levelmapjson
end

function var_0_0:getCityDifficulties(arg_94_1)
	local var_94_0 = {}

	while city_data[arg_94_1]["difficulty" .. 1] do
		table.insert(var_94_0, {
			mode = city_data[arg_94_1]["difficulty" .. 1],
			stat = self:isLevelModeUnlocked(city_data[arg_94_1]["difficulty" .. 1])
		})
	end

	return var_94_0
end

function var_0_0.getCityByMode(arg_95_0, arg_95_1)
	return levelmode_data[arg_95_1].city
end

function var_0_0.getDifficultByMode(arg_96_0, arg_96_1)
	for iter_96_0 = 1, 4 do
		if city_data[levelmode_data[arg_96_1].city]["difficulty" .. iter_96_0] and city_data[levelmode_data[arg_96_1].city]["difficulty" .. iter_96_0] == arg_96_1 then
			return iter_96_0
		end
	end
end

function var_0_0:getCurFightCity()
	if not self:isMainCity(levelmode_data[playermodel.curMode].city) then
		return 1
	end

	return levelmode_data[playermodel.curMode].city
end

function var_0_0.getCurTalkCity(arg_98_0)
	return levelmode_data[playermodel.curMode].city
end

function var_0_0.getCurFightDifficulty(arg_99_0)
	local var_99_0 = 1

	while city_data[levelmode_data[playermodel.curMode].city]["difficulty" .. 1] do
		if city_data[levelmode_data[playermodel.curMode].city]["difficulty" .. 1] == playermodel.curMode then
			var_99_0 = 1

			break
		end
	end

	return var_99_0
end

function var_0_0:getCurMainFightDifficulty()
	local var_100_0 = playermodel.curMode
	local var_100_1 = levelmode_data[playermodel.curMode].city

	if not self:isMainCity(levelmode_data[playermodel.curMode].city) then
		var_100_0 = 1
		var_100_1 = 1
	end

	local var_100_2 = city_data[var_100_1]
	local var_100_3 = 1

	while var_100_2["difficulty" .. 1] do
		if var_100_2["difficulty" .. 1] == var_100_0 then
			var_100_3 = 1

			break
		end
	end

	return var_100_3
end

function var_0_0.getCurTalkLevelDifficulty(arg_101_0)
	return 1
end

function var_0_0.getModeByDifficulty(arg_102_0, arg_102_1, arg_102_2)
	if city_data[arg_102_1]["difficulty" .. arg_102_2] then
		return city_data[arg_102_1]["difficulty" .. arg_102_2]
	else
		return city_data[arg_102_1].difficulty1
	end
end

function var_0_0:getUnlockedDifficultyInCity(arg_103_1)
	local var_103_0 = 1

	while city_data[arg_103_1]["difficulty" .. 1] do
		local var_103_1

		if self:isLevelModeUnlocked(city_data[arg_103_1]["difficulty" .. 1]) then
			var_103_0 = 1
			var_103_1 = 1 + 1
		else
			break
		end
	end

	return var_103_0
end

function var_0_0.isOnlyCityDifficultyValid(arg_104_0, arg_104_1, arg_104_2)
	if not city_data[arg_104_1]["difficulty" .. arg_104_2] then
		return false
	else
		return true
	end
end

function var_0_0:isCityDifficultyValid(arg_105_1, arg_105_2)
	if not city_data[arg_105_1]["difficulty" .. arg_105_2] then
		return false
	end

	if arg_105_2 == 1 then
		return true
	else
		return self:isLevelModeUnlocked(city_data[arg_105_1]["difficulty" .. arg_105_2])
	end
end

function var_0_0.getCityRecommendPower(arg_106_0, arg_106_1)
	return city_data[arg_106_1].powerlimit or 0
end

function var_0_0.unlockCity(arg_107_0, arg_107_1, arg_107_2)
	network:rpc("unlock_city", {
		city = arg_107_1
	}, function(arg_108_0)
		if arg_108_0.result == 1 then
			playermodel.citystat[arg_107_1] = true

			arg_107_0:checkIsAlertNewCity()

			if not arg_107_0:isActivityCity(arg_107_1) then
				playermodel.levelmode[arg_107_0:getModeByDifficulty(arg_107_1, 1)] = arg_108_0.levelmode
				playermodel.curLevel = arg_108_0.curlevel
				playermodel.curMode = arg_108_0.curmode
			end
		end

		if arg_107_2 then
			arg_107_2(arg_108_0.result)
		end
	end)
end

function var_0_0.getUnlockCityTalk(arg_109_0, arg_109_1)
	return city_data[arg_109_1].talkid
end

function var_0_0.getGoldDropSpeed(arg_110_0)
	local var_110_0 = BASIC_GOLD_DROP

	for iter_110_0, iter_110_1 in pairs(playermodel.levelmode) do
		if levelmode_data[iter_110_1.mode] and levelmode_data[iter_110_1.mode].modetype == 1 then
			if iter_110_1.status - 1 > 0 then
				var_110_0 = var_110_0 + (chapter_data[iter_110_1.mode .. "-" .. iter_110_1.status - 1].gold or 0)
			end
		end
	end

	return var_110_0
end

function var_0_0.getSpDropSpeed(arg_111_0)
	local var_111_0 = BASIC_SP_DROP

	for iter_111_0, iter_111_1 in pairs(playermodel.levelmode) do
		if levelmode_data[iter_111_1.mode] and levelmode_data[iter_111_1.mode].modetype == 1 then
			if iter_111_1.status - 1 > 0 then
				var_111_0 = var_111_0 + (chapter_data[iter_111_1.mode .. "-" .. iter_111_1.status - 1].strengthpoint or 0)
			end
		end
	end

	return var_111_0
end

function var_0_0.getExpDropSpeed(arg_112_0)
	local var_112_0 = BASIC_EXP_DROP

	for iter_112_0, iter_112_1 in pairs(playermodel.levelmode) do
		if levelmode_data[iter_112_1.mode] and levelmode_data[iter_112_1.mode].modetype == 1 then
			if iter_112_1.status - 1 > 0 then
				var_112_0 = var_112_0 + (chapter_data[iter_112_1.mode .. "-" .. iter_112_1.status - 1].exp or 0)
			end
		end
	end

	return var_112_0
end

function var_0_0.getTotalModeCount(arg_113_0)
	local var_113_0 = 0

	for iter_113_0, iter_113_1 in pairs(playermodel.levelmode) do
		var_113_0 = var_113_0 + 1
	end

	return var_113_0
end

function var_0_0.getAllModeBySort(arg_114_0)
	local var_114_0 = {}

	for iter_114_0, iter_114_1 in pairs(playermodel.levelmode) do
		if levelmode_data[iter_114_1.mode] then
			table.insert(var_114_0, iter_114_1.mode)
		end
	end

	table.sort(var_114_0, function(arg_115_0, arg_115_1)
		return arg_115_0 < arg_115_1
	end)

	return var_114_0
end

function var_0_0.getTotalNormalModeCount(arg_116_0)
	local var_116_0 = 0

	for iter_116_0, iter_116_1 in pairs(playermodel.levelmode) do
		if levelmode_data[iter_116_0] and levelmode_data[iter_116_0].modetype == LEVELMODE_NORMAL then
			var_116_0 = var_116_0 + 1
		end
	end

	return var_116_0
end

function var_0_0.getNormalModeBySort(arg_117_0)
	local var_117_0 = {}

	for iter_117_0, iter_117_1 in pairs(playermodel.levelmode) do
		if levelmode_data[iter_117_0] and levelmode_data[iter_117_0].modetype == LEVELMODE_NORMAL then
			table.insert(var_117_0, {
				mode = iter_117_0,
				order = levelmode_data[iter_117_0].order
			})
		end
	end

	table.sort(var_117_0, function(arg_118_0, arg_118_1)
		return arg_118_0.order < arg_118_1.order
	end)

	return var_117_0
end

function var_0_0.getTotalAdventureModeCount(arg_119_0)
	local var_119_0 = 0

	for iter_119_0, iter_119_1 in pairs(playermodel.levelmode) do
		if levelmode_data[iter_119_0] and levelmode_data[iter_119_0].modetype == LEVELMODE_ADVENTURE and (not levelmode_data[iter_119_0].classtype or playermodel.class == levelmode_data[iter_119_0].classtype) then
			var_119_0 = var_119_0 + 1
		end
	end

	return var_119_0
end

function var_0_0.getAdventureModeBySort(arg_120_0, ...)
	local var_120_0 = {}
	local var_120_1 = {}

	for iter_120_0, iter_120_1 in pairs(playermodel.levelmode) do
		if levelmode_data[iter_120_0] and levelmode_data[iter_120_0].modetype == LEVELMODE_ADVENTURE and levelmode_data[iter_120_0].mode ~= 104 and (not levelmode_data[iter_120_0].classtype or playermodel.class == levelmode_data[iter_120_0].classtype) then
			if not levelmode_data[iter_120_0].openday then
				table.insert(var_120_0, {
					mode = iter_120_0,
					order = levelmode_data[iter_120_0].order
				})
			else
				local var_120_2 = {}

				for iter_120_2 in string.gmatch(levelmode_data[iter_120_0].openday, "%d+") do
					var_120_2[iter_120_2] = true
				end

				if var_120_2[os.date("%w")] then
					table.insert(var_120_0, {
						mode = iter_120_0,
						order = levelmode_data[iter_120_0].order
					})
				else
					table.insert(var_120_1, {
						mode = iter_120_0,
						order = levelmode_data[iter_120_0].order
					})
				end
			end
		end
	end

	table.sort(var_120_0, function(arg_121_0, arg_121_1)
		return arg_121_0.order < arg_121_1.order
	end)
	table.sort(var_120_1, function(arg_122_0, arg_122_1)
		return arg_122_0.order < arg_122_1.order
	end)

	return var_120_0, var_120_1
end

function var_0_0.getAdventureResetStatus(arg_123_0, arg_123_1, arg_123_2)
	network:rpc("get_adventure_proceed", {
		mode = arg_123_1
	}, function(arg_124_0)
		if arg_124_0.result == 1 then
			playermodel.levelmode[arg_123_1] = arg_124_0.mode

			if arg_123_2 then
				arg_123_2()
			end
		elseif arg_123_2 then
			arg_123_2()
		end
	end)
end

function var_0_0.getLevelModeCity(arg_125_0, arg_125_1)
	return levelmode_data[arg_125_1].city
end

function var_0_0.getModeName(arg_126_0, arg_126_1)
	return levelmode_data[arg_126_1].name
end

function var_0_0.getModeTotalChapter(arg_127_0, arg_127_1)
	return levelmode_data[arg_127_1].totalchapter
end

function var_0_0:getCityMaxStars(arg_128_1)
	local var_128_0 = {}

	while city_data[arg_128_1]["difficulty" .. 1] do
		table.insert(var_128_0, city_data[arg_128_1]["difficulty" .. 1])
	end

	local var_128_2 = 0

	for iter_128_0, iter_128_1 in pairs(var_128_0) do
		var_128_2 = var_128_2 + self:getModeTotalChapter(iter_128_1) * 3
	end

	return var_128_2
end

function var_0_0:isLevelModeUnlocked(arg_129_1)
	if self:isModeManualLocked(arg_129_1) then
		return false
	end

	return self:isLevelModeAutoUnlocked(arg_129_1)
end

function var_0_0:isLevelModeAutoUnlocked(arg_130_1)
	if not levelmode_data[arg_130_1] then
		return false
	end

	if not levelmode_data[arg_130_1].premode then
		return true
	end

	print(playermodel.levelmode[arg_130_1].status, "look")

	if playermodel.levelmode[arg_130_1].status > 1 then
		return true
	end

	local var_130_0 = true

	for iter_130_0 in levelmode_data[arg_130_1].premode:gmatch("%d+") do
		if not self:isLevelModePass(tonumber(iter_130_0)) then
			var_130_0 = false

			break
		end
	end

	return var_130_0
end

function var_0_0.getLevelModeLockState(arg_131_0, arg_131_1)
	return
end

function var_0_0:isLevelModePass(arg_132_1)
	return playermodel.levelmode[arg_132_1].status > self:getModeTotalChapter(arg_132_1)
end

function var_0_0.getModeProceed(arg_133_0, arg_133_1)
	return playermodel.levelmode[arg_133_1].status - 1
end

function var_0_0.getLevelPerChapter(arg_134_0, arg_134_1)
	return levelmode_data[arg_134_1].levelperchapter or 10
end

function var_0_0.getLevelContinueMode(arg_135_0, arg_135_1)
	local var_135_0

	for iter_135_0, iter_135_1 in pairs(levelmode_data) do
		if iter_135_1.modetype == 1 and iter_135_1.premode then
			for iter_135_2 in iter_135_1.premode:gmatch("%d+") do
				if arg_135_1 == tonumber(iter_135_2) then
					var_135_0 = iter_135_0

					break
				end
			end

			if var_135_0 then
				break
			end
		end
	end

	return var_135_0
end

function var_0_0.getJumpNextMode(arg_136_0, arg_136_1)
	local var_136_0

	for iter_136_0, iter_136_1 in pairs(levelmode_data) do
		if iter_136_1.modetype == 1 and iter_136_1.premode then
			for iter_136_2 in iter_136_1.premode:gmatch("%d+") do
				if arg_136_1 == tonumber(iter_136_2) then
					var_136_0 = iter_136_0

					break
				end
			end

			if var_136_0 then
				break
			end
		end
	end

	for iter_136_3, iter_136_4 in pairs(levelmode_data) do
		if iter_136_4.modetype == 1 and iter_136_4.mode == arg_136_1 and iter_136_4.jumpnextmode then
			var_136_0 = tonumber(iter_136_4.jumpnextmode)

			break
		end
	end

	return var_136_0
end

function var_0_0.isLevelModeHangupValid(arg_137_0, arg_137_1)
	return levelmode_data[arg_137_1].hangupinvalid == nil
end

function var_0_0:preModeChapterComplete(arg_138_1, arg_138_2)
	return self:isLevelModeUnlocked(arg_138_1)
end

var_0_0.preModeUnlocked = var_0_0.isLevelModeUnlocked

function var_0_0.isChapterModeUnlocked(arg_139_0, arg_139_1, arg_139_2)
	if not playermodel.levelmode[arg_139_1] then
		return false
	end

	return arg_139_2 <= var_0_17(playermodel.levelmode[arg_139_1].level)
end

function var_0_0:canChapterModeUnlock(arg_140_1, arg_140_2)
	return arg_140_2 <= self:getChapterCanUnlock(arg_140_1)
end

function var_0_0:isChapterModeValid(arg_141_1, arg_141_2)
	if not playermodel.levelmode[arg_141_1] then
		return false
	end

	if not levelmode_data[arg_141_1] then
		return false
	end

	return self:isLevelModeUnlocked(arg_141_1)
end

function var_0_0:isModeValid(arg_142_1)
	if not playermodel.levelmode[arg_142_1] then
		return false, 0
	end

	if not levelmode_data[arg_142_1] then
		return false, 0
	end

	if not self:isLevelModeUnlocked(arg_142_1) then
		return false, 2
	end

	if not self:isModeTimeValid(arg_142_1) then
		return false, 3
	end

	return true
end

function var_0_0.isModeTimeValid(arg_143_0, arg_143_1)
	if levelmode_data[arg_143_1].starttime and time_check_manager:getCurTime() < global_get_time_by_date(levelmode_data[arg_143_1].starttime) then
		return false
	end

	if levelmode_data[arg_143_1].endtime and time_check_manager:getCurTime() > global_get_time_by_date(levelmode_data[arg_143_1].endtime) then
		return false
	end

	if levelmode_data[arg_143_1].openday then
		local var_143_0 = {}

		for iter_143_0 in string.gmatch(levelmode_data[arg_143_1].openday, "%d+") do
			var_143_0[iter_143_0] = true
		end

		if not var_143_0[os.date("%w")] then
			return false
		end
	end

	return true
end

local var_0_27 = L_WEEK_TEXT_SIMPLE

function var_0_0:getModeUnlockMsg(arg_144_1, arg_144_2)
	if arg_144_2 == 2 then
		if not levelmode_data[arg_144_1].premode then
			return ""
		end

		local var_144_0 = tonumber(levelmode_data[arg_144_1].premode)

		return string.format(L_LAYER_UNLOCKED2, levelmode_data[var_144_0].name, self:getChapterName(var_144_0, levelmode_data[arg_144_1].chapter))
	elseif arg_144_2 == 3 then
		if levelmode_data[arg_144_1].starttime and os.time() < global_get_time_by_date(levelmode_data[arg_144_1].starttime) then
			return "暂未开启"
		end

		if levelmode_data[arg_144_1].endtime and os.time() > global_get_time_by_date(levelmode_data[arg_144_1].endtime) then
			return L_ACTIVITY_END
		end

		if levelmode_data[arg_144_1].openday then
			local var_144_1 = {}

			for iter_144_0 in string.gmatch(levelmode_data[arg_144_1].openday, "%d+") do
				table.insert(var_144_1, iter_144_0)
			end

			local var_144_2 = ""

			for iter_144_1, iter_144_2 in pairs(var_144_1) do
				var_144_2 = var_144_2 == "" and var_144_2 .. var_0_27[iter_144_2] or var_144_2 .. "、" .. var_0_27[iter_144_2]
			end

			return string.format(L_OPEN_WEEKLY, var_144_2)
		end

		return ""
	end
end

function var_0_0.getAdventureDailytimeByModeType(arg_145_0, arg_145_1, arg_145_2, arg_145_3)
	network:rpc("get_adventure_dailytime", {
		modetype = arg_145_1,
		trialtype = arg_145_3
	}, function(arg_146_0)
		if arg_146_0.result == 1 then
			if arg_146_0.time then
				if arg_145_2 then
					arg_145_2(1, arg_146_0.time, arg_146_0.buy_modes)
				end
			elseif arg_145_2 then
				arg_145_2(1, arg_146_0.timetbl)
			end
		elseif arg_145_2 then
			arg_145_2(0)
		end
	end)
end

function var_0_0.getWeekendAdventureDailytime(arg_147_0, arg_147_1)
	network:rpc("get_weekend_adventure_dailytime", nil, function(arg_148_0)
		if arg_148_0.result == 1 then
			if arg_147_1 then
				arg_147_1(1, arg_148_0.timetbl)
			end
		elseif arg_147_1 then
			arg_147_1(0)
		end
	end)
end

function var_0_0.buyAdventureDailyTime(arg_149_0, arg_149_1, arg_149_2, arg_149_3)
	network:rpc("buy_adventure_dailytime", {
		param = "BUY",
		modetype = arg_149_1,
		trialtype = arg_149_3
	}, function(arg_150_0)
		if arg_150_0.result == 1 then
			playermodel.diamond = playermodel.diamond - arg_150_0.diamond

			global_update_gold_stone_diamond(nil, nil, arg_150_0.diamond)

			if arg_149_2 then
				arg_149_2(1, arg_150_0.diamond, arg_150_0.time)
			end
		elseif arg_149_2 then
			arg_149_2(arg_150_0.result)
		end
	end)
end

function var_0_0.getBuyAdventureDailyTimeInfo(arg_151_0, arg_151_1, arg_151_2, arg_151_3)
	network:rpc("buy_adventure_dailytime", {
		param = "INFO",
		modetype = arg_151_1,
		trialtype = arg_151_3
	}, function(arg_152_0)
		if arg_151_2 then
			arg_151_2(arg_152_0.result, arg_152_0.diamond, arg_152_0.time)
		end
	end)
end

function var_0_0.getAdventureScore(arg_153_0, arg_153_1, arg_153_2)
	if not levelmode_data[arg_153_1].saveenemycount then
		if arg_153_2 then
			arg_153_2(0)
		end

		return
	end

	network:rpc("get_adventure_score", {
		mode = arg_153_1
	}, function(arg_154_0)
		if arg_154_0.result == 1 then
			if arg_153_2 then
				arg_153_2(1, arg_154_0.score)
			end
		elseif arg_153_2 then
			arg_153_2(arg_154_0.result)
		end
	end)
end

function var_0_0.getChapterName(arg_155_0, arg_155_1, arg_155_2)
	return (chapter_data[arg_155_1 .. "-" .. arg_155_2] or nil) and (chapter_data[arg_155_1 .. "-" .. arg_155_2].name or arg_155_1 .. "-" .. arg_155_2)
end

function var_0_0.getChapterHeadImage(arg_156_0, arg_156_1, arg_156_2)
	return (chapter_data[arg_156_1 .. "-" .. arg_156_2] or nil) and (chapter_data[arg_156_1 .. "-" .. arg_156_2].chapter_title_headimg_path or "213")
end

function var_0_0.getChapterPassHeadImage(arg_157_0, arg_157_1, arg_157_2)
	return (chapter_data[arg_157_1 .. "-" .. arg_157_2] or nil) and (chapter_data[arg_157_1 .. "-" .. arg_157_2].pass_chapter_title_headimg_path or "213")
end

function var_0_0.getChapterDes(arg_158_0, arg_158_1, arg_158_2)
	return chapter_data[arg_158_1 .. "-" .. arg_158_2].des
end

function var_0_0.getUnlockChapter(arg_159_0, arg_159_1)
	return var_0_17(playermodel.levelmode[arg_159_1].level)
end

function var_0_0.getChapterCanUnlock(arg_160_0, arg_160_1)
	return playermodel.levelmode[arg_160_1].status
end

function var_0_0.getCurChapter(arg_161_0, arg_161_1)
	return var_0_17(playermodel.levelmode[arg_161_1].curlevel)
end

function var_0_0:getChapterProceed(arg_162_1, arg_162_2)
	if not self:isChapterModeUnlocked(arg_162_1, arg_162_2) then
		return 0, chapter_data[arg_162_1 .. "-" .. arg_162_2].level_num
	end

	if arg_162_2 < playermodel.levelmode[arg_162_1].status then
		return chapter_data[arg_162_1 .. "-" .. arg_162_2].level_num, chapter_data[arg_162_1 .. "-" .. arg_162_2].level_num
	else
		local var_162_0, var_162_1 = var_0_18(playermodel.levelmode[arg_162_1].level)

		return var_162_1, chapter_data[arg_162_1 .. "-" .. arg_162_2].level_num
	end
end

function var_0_0:getChapterProceedWithBigBoss(arg_163_1, arg_163_2)
	if not self:isChapterModeUnlocked(arg_163_1, arg_163_2) then
		return 0, chapter_data[arg_163_1 .. "-" .. arg_163_2].level_num + 1
	end

	if arg_163_2 < playermodel.levelmode[arg_163_1].status then
		return chapter_data[arg_163_1 .. "-" .. arg_163_2].level_num + 1, chapter_data[arg_163_1 .. "-" .. arg_163_2].level_num + 1
	else
		local var_163_0, var_163_1 = var_0_18(playermodel.levelmode[arg_163_1].level)

		return var_163_1, chapter_data[arg_163_1 .. "-" .. arg_163_2].level_num + 1
	end
end

function var_0_0.getChapterEnemyHead(arg_164_0, arg_164_1, arg_164_2)
	return chapter_data[arg_164_1 .. "-" .. arg_164_2].image
end

function var_0_0:getChapterBasicInfo(arg_165_1, arg_165_2)
	local var_165_0 = {
		unlock = false
	}

	if self:isChapterModeUnlocked(arg_165_1, arg_165_2) then
		var_165_0.unlock = true
	end

	return var_165_0
end

function var_0_0.getChapterDropGold(arg_166_0, arg_166_1, arg_166_2)
	if not chapter_data[arg_166_1 .. "-" .. arg_166_2] then
		return 0
	end

	return chapter_data[arg_166_1 .. "-" .. arg_166_2].gold * 6
end

function var_0_0.getChapterDropSp(arg_167_0, arg_167_1, arg_167_2)
	if not chapter_data[arg_167_1 .. "-" .. arg_167_2] then
		return 0
	end

	return chapter_data[arg_167_1 .. "-" .. arg_167_2].strengthpoint * 6
end

function var_0_0.getChapterDropItems(arg_168_0, arg_168_1, arg_168_2)
	local var_168_0 = {}

	if not chapter_data[arg_168_1 .. "-" .. arg_168_2] then
		return var_168_0
	end

	local var_168_1 = chapter_data[arg_168_1 .. "-" .. arg_168_2]

	for iter_168_0, iter_168_1 in pairs(chapter_data[arg_168_1 .. "-" .. arg_168_2]) do
		local var_168_2, var_168_3 = string.match(iter_168_0, "type(%d+)_item(%d+)")

		if var_168_2 and var_168_3 then
			var_168_0[iter_168_0] = var_168_1[iter_168_0]
		elseif string.match(iter_168_0, "type(%d+)") then
			var_168_0[iter_168_0] = var_168_1[iter_168_0]
		end
	end

	return ((function(arg_169_0)
		local var_169_0 = {
			type_tbl = {}
		}

		for iter_169_0, iter_169_1 in pairs(arg_169_0) do
			local var_169_1, var_169_2 = string.match(iter_169_0, "type(%d+)_item(%d+)")
			local var_169_3 = tonumber(var_169_1)
			local var_169_4 = tonumber(var_169_2)
			local var_169_5

			if var_169_3 and var_169_4 then
				if true == true then
					var_169_0[var_169_3] = {}
					var_169_0[var_169_3].attribute = var_169_3
					var_169_0[var_169_3].content = {}
					var_169_0[var_169_3].content[var_169_4] = {
						itemid = iter_169_1
					}
					var_169_5 = false
				else
					local var_169_7 = false

					for iter_169_2, iter_169_3 in pairs(var_169_0) do
						if iter_169_3.attribute and iter_169_3.attribute == var_169_3 then
							if iter_169_3.content[var_169_4] then
								iter_169_3.content[var_169_4].itemid = iter_169_1
							else
								iter_169_3.content[var_169_4] = {
									itemid = iter_169_1
								}
							end

							var_169_7 = true

							break
						end
					end

					if var_169_7 == false then
						var_169_0[var_169_3] = {}
						var_169_0[var_169_3].attribute = var_169_3
						var_169_0[var_169_3].content = {}
						var_169_0[var_169_3].content[var_169_4] = {
							itemid = iter_169_1
						}
					end
				end
			else
				local var_169_8 = string.match(iter_169_0, "type(%d+)")

				if var_169_8 then
					var_169_0.type_tbl[tonumber(var_169_8)] = iter_169_1
				end
			end
		end

		return var_169_0
	end)(var_168_0))
end

function var_0_0:isOldChapter(arg_170_1, arg_170_2)
	return arg_170_2 < playermodel.levelmode[arg_170_1].status and playermodel.levelmode[arg_170_1].level / self:getLevelPerChapter(arg_170_1) ~= playermodel.levelmode[arg_170_1].status - 1
end

function var_0_0:isChapterCompleteUnlock(arg_171_1, arg_171_2)
	if arg_171_2 == 1 then
		return self:isLevelModeUnlocked(arg_171_1)
	else
		return arg_171_2 <= self:getUnlockChapter(arg_171_1)
	end
end

function var_0_0:isChapterUnlock(arg_172_1, arg_172_2)
	return arg_172_2 <= self:getChapterCanUnlock(arg_172_1)
end

function var_0_0.isUnlockBigBoss(arg_173_0, arg_173_1, arg_173_2)
	return arg_173_2 == playermodel.levelmode[arg_173_1].status and playermodel.levelmode[arg_173_1].status == playermodel.levelmode[arg_173_1].pass - 1
end

function var_0_0.isChapterPass(arg_174_0, arg_174_1, arg_174_2)
	return arg_174_2 < playermodel.levelmode[arg_174_1].status
end

function var_0_0.getChapterLevelNum(arg_175_0, arg_175_1, arg_175_2)
	return chapter_data[arg_175_1 .. "-" .. arg_175_2].level_num or 5
end

function var_0_0:isLevelPass(arg_176_1, arg_176_2)
	local var_176_0, var_176_1 = var_0_18(arg_176_2)
	local var_176_2, var_176_3 = var_0_18(playermodel.levelmode[arg_176_1].level)

	return self:isChapterPass(arg_176_1, var_176_0) or self:isUnlockBigBoss(arg_176_1, var_176_0) or var_176_2 == var_176_0 and var_176_1 < var_176_3
end

function var_0_0:isLevelUnlock(arg_177_1, arg_177_2)
	local var_177_0, var_177_1 = var_0_18(arg_177_2)
	local var_177_2, var_177_3 = var_0_18(playermodel.levelmode[arg_177_1].level)

	return self:isChapterPass(arg_177_1, var_177_0) or self:isUnlockBigBoss(arg_177_1, var_177_0) or var_177_2 == var_177_0 and var_177_1 <= var_177_3
end

function var_0_0.getChapterStrongholdLv(arg_178_0, arg_178_1, arg_178_2)
	return chapter_data[arg_178_1 .. "-" .. arg_178_2].stronghold or 1
end

function var_0_0.getChapterRecommendPower(arg_179_0, arg_179_1, arg_179_2)
	if arg_179_1 == 1 and arg_179_2 <= 50 then
		return chapter_data[arg_179_1 .. "-" .. arg_179_2].combat_limit * 0.5
	else
		return chapter_data[arg_179_1 .. "-" .. arg_179_2].combat_limit * 0.75
	end
end

function var_0_0.getChapterStrongholdDrop(arg_180_0, arg_180_1, arg_180_2)
	return chapter_data[arg_180_1 .. "-" .. arg_180_2].patrol_itemid or 3
end

function var_0_0.getLevelDropID(arg_181_0, arg_181_1, arg_181_2)
	local var_181_0 = var_0_0.getCurLevelData(arg_181_1, arg_181_2)

	assert(var_181_0, "levelData is nil:" .. arg_181_1 .. "-" .. arg_181_2)

	return var_181_0.equip_drop
end

function var_0_0.getLevelFirstPassDrop(arg_182_0, arg_182_1, arg_182_2)
	local var_182_0 = var_0_0.getCurLevelData(arg_182_1, arg_182_2)

	assert(var_182_0, "levelData is nil:" .. arg_182_1 .. "-" .. arg_182_2)

	return var_182_0.first_award
end

function var_0_0.isModeQuickFightValid(arg_183_0, arg_183_1)
	return levelmode_data[arg_183_1].quickfightinvalid == nil
end

function var_0_0.isQuickFightValid(arg_184_0, arg_184_1, arg_184_2)
	if levelmode_data[arg_184_1].quickfightinvalid then
		return false, L_BRANCH_CANNOT_QUICK_FIND
	end

	if arg_184_2 > playermodel.levelmode[arg_184_1].status then
		return false, string.format(L_QUICK_FIND_CONDITION, arg_184_2)
	else
		return true
	end
end

function var_0_0:getChapterQuickFightInfo(arg_185_1, arg_185_2)
	local var_185_0 = {
		total = 0,
		needs = 2,
		custom = 0,
		total = chapter_data[arg_185_1 .. "-" .. arg_185_2].quickfight_limit
	}

	if self.modebasicinfo[arg_185_1] and self.modebasicinfo[arg_185_1][arg_185_2] then
		var_185_0.custom = self.modebasicinfo[arg_185_1][arg_185_2].info
	end

	return var_185_0
end

function var_0_0.autoSetQuickFightSoul(arg_186_0, arg_186_1, arg_186_2)
	local var_186_0 = chapter_data[arg_186_1 .. "-" .. arg_186_2].trainnum or 2
	local servant_data = require("data.servant_data")
	local var_186_2 = {}
	local var_186_3 = {}

	if chapter_data[arg_186_1 .. "-" .. arg_186_2].recommend_servant1 and playermodel.haveServant[chapter_data[arg_186_1 .. "-" .. arg_186_2].recommend_servant1] then
		table.insert(var_186_2, chapter_data[arg_186_1 .. "-" .. arg_186_2].recommend_servant1)

		var_186_3[servant_data[chapter_data[arg_186_1 .. "-" .. arg_186_2].recommend_servant1].major] = true
		var_186_0 = var_186_0 - 1
	end

	if var_186_0 <= 0 then
		return var_186_2
	end

	if chapter_data[arg_186_1 .. "-" .. arg_186_2].recommend_servant2 and playermodel.haveServant[chapter_data[arg_186_1 .. "-" .. arg_186_2].recommend_servant2] then
		table.insert(var_186_2, chapter_data[arg_186_1 .. "-" .. arg_186_2].recommend_servant2)

		var_186_3[servant_data[chapter_data[arg_186_1 .. "-" .. arg_186_2].recommend_servant2].major] = true
		var_186_0 = var_186_0 - 1
	end

	if var_186_0 <= 0 then
		return var_186_2
	end

	if chapter_data[arg_186_1 .. "-" .. arg_186_2].recommend_servant3 and playermodel.haveServant[chapter_data[arg_186_1 .. "-" .. arg_186_2].recommend_servant3] then
		table.insert(var_186_2, chapter_data[arg_186_1 .. "-" .. arg_186_2].recommend_servant3)

		var_186_3[servant_data[chapter_data[arg_186_1 .. "-" .. arg_186_2].recommend_servant3].major] = true
		var_186_0 = var_186_0 - 1
	end

	if var_186_0 <= 0 then
		return var_186_2
	end

	for iter_186_0, iter_186_1 in pairs(playermodel.haveServant) do
		if iter_186_1 and not var_186_3[servant_data[iter_186_0].major] and servant_data[iter_186_0].classtype == 1 then
			table.insert(var_186_2, iter_186_0)

			var_186_3[servant_data[iter_186_0].major] = true
			var_186_0 = var_186_0 - 1
		end

		if var_186_0 <= 0 then
			break
		end
	end

	return var_186_2
end

function var_0_0.quickFight(arg_187_0, arg_187_1, arg_187_2, arg_187_3, arg_187_4)
	require("controller.parse_server"):passQuickFight(arg_187_1, arg_187_2, arg_187_3, arg_187_4)
end

function var_0_0.quickTrainFight(arg_188_0, arg_188_1, arg_188_2, arg_188_3, arg_188_4)
	require("controller.parse_server"):passTrainQuickFight(arg_188_1, arg_188_2, arg_188_3, arg_188_4)
end

function var_0_0.buyQuickFightTicket(arg_189_0, arg_189_1, arg_189_2)
	network:rpc("buy_quickfight_ticket", {
		num = arg_189_1
	}, function(arg_190_0)
		if arg_190_0.result == 1 then
			playermodel.diamond = playermodel.diamond - arg_190_0.cost

			item_manager:setItemByServerItem(arg_190_0.item)
			global_update_gold_stone_diamond(nil, nil, arg_190_0.cost)
			AnalyticManager.buyQuickFightTicket(arg_190_0.cost, arg_189_1)

			if arg_189_2 then
				arg_189_2(1)
			end
		elseif arg_189_2 then
			arg_189_2(arg_190_0.result)
		end
	end)
end

function var_0_0.getQuickFightTime(arg_191_0, arg_191_1)
	local var_191_0, var_191_1 = playermodel.curLevel:match("(%d+)-(%d+)")

	network:rpc("get_quick_pass_used_time", {
		quicktype = 1,
		mode = playermodel.curMode,
		chapter = var_191_0
	}, function(arg_192_0)
		if arg_191_1 then
			arg_191_1(arg_192_0)
		end

		arg_191_0.quickFightTime = arg_192_0.totaltimes - arg_192_0.times

		cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("onQuickFight")))
	end)
end

function var_0_0:getCurQuickFightTime(arg_193_1)
	if not self.quickFightTime or self.quickFightTime == QUICK_FIGHT_DAILY_TIME - 1 then
		self:getQuickFightTime(function(arg_194_0)
			self.quickFightTime = arg_194_0.totaltimes - arg_194_0.times

			if arg_193_1 then
				arg_193_1(self.quickFightTime)
			end
		end)
	elseif arg_193_1 then
		arg_193_1(self.quickFightTime)
	end
end

function var_0_0:isDailyFreeFightTime()
	return (self.quickFightTime or playermodel.quickfight_count) == 0 and self:isPlayerPassLevel(UNLOCK_QUICKFIGHT)
end

function var_0_0.getTrainFightTime(arg_196_0, arg_196_1, arg_196_2, arg_196_3)
	network:rpc("get_quick_pass_used_time", {
		quicktype = 2,
		mode = arg_196_1,
		chapter = arg_196_2
	}, function(arg_197_0)
		if arg_196_3 then
			arg_196_3(arg_197_0.times, arg_197_0.totaltimes)
		end
	end)
end

function var_0_0:selectChapter(arg_198_1, arg_198_2, arg_198_3)
	if playermodel.levelmode[arg_198_1].status <= 0 then
		if arg_198_3 then
			arg_198_3(2)
		end

		return
	end

	if arg_198_2 > self:getModeTotalChapter(arg_198_1) then
		if arg_198_3 then
			arg_198_3(4)
		end

		return
	end

	if arg_198_2 > self:getChapterCanUnlock(arg_198_1) then
		if arg_198_3 then
			arg_198_3(5)
		end

		return
	end

	if arg_198_1 == playermodel.curMode and arg_198_2 == self:getCurChapter(arg_198_1) then
		if arg_198_3 then
			arg_198_3(3)
		end

		return
	end

	network:rpc("select_curchapter", {
		mode = arg_198_1,
		chapter = arg_198_2
	}, function(arg_199_0)
		if arg_199_0.result == 1 then
			playermodel.levelmode[arg_198_1] = arg_199_0.levelmode
			playermodel.curLevel = arg_199_0.curlevel
			playermodel.curMode = arg_199_0.curmode

			require("controller.array_manager"):resetHangupArray()

			if arg_198_3 then
				arg_198_3(1)
			end
		elseif arg_198_3 then
			arg_198_3(arg_199_0.result)
		end
	end)
end

function var_0_0.switchToNormalMode(arg_200_0, arg_200_1)
	network:rpc("switch_to_normalmode", nil, function(arg_201_0)
		if arg_201_0.result == 1 then
			playermodel.curLevel = arg_201_0.curlevel
			playermodel.curMode = arg_201_0.curmode

			if arg_200_1 then
				arg_200_1(1)
			end
		elseif arg_200_1 then
			arg_200_1(arg_201_0.result)
		end
	end)
end

function var_0_0:switchToAdventureMode(...)
	local var_202_0 = {
		...
	}
	local var_202_1
	local var_202_2
	local var_202_3

	if #var_202_0 == 2 then
		var_202_1 = var_202_0[1]

		if type(var_202_0[2]) == "function" then
			var_202_3 = var_202_0[2]
			var_202_2 = 1
		else
			var_202_2 = var_202_0[2]
			var_202_3 = nil
		end
	else
		var_202_1, var_202_2, var_202_3, arrayid = var_202_0[1], var_202_0[2], var_202_0[3], var_202_0[4]
	end

	local var_202_4, var_202_5 = self:isModeValid(var_202_1)

	if not var_202_4 then
		if var_202_3 then
			var_202_3(var_202_5)
		end

		return
	end

	network:rpc("switch_to_adventuremode", {
		mode = var_202_1,
		chapter = var_202_2
	}, function(arg_203_0)
		if arg_203_0.result == 1 then
			playermodel.levelmode[var_202_1] = arg_203_0.levelmode
			playermodel.curLevel = arg_203_0.curlevel
			playermodel.curMode = arg_203_0.curmode

			AnalyticManager.joinAdventure(var_202_1)
			AnalyticManager.startLevel(playermodel.curMode, playermodel.curLevel)

			if var_202_3 then
				var_202_3(1)
			end
		elseif var_202_3 then
			var_202_3(arg_203_0.result)
		end
	end)
end

function var_0_0:switchToGroupFightMode(...)
	local var_204_0 = {
		...
	}
	local var_204_1
	local var_204_2
	local var_204_3

	if #var_204_0 == 2 then
		var_204_1 = var_204_0[1]

		if type(var_204_0[2]) == "function" then
			var_204_3 = var_204_0[2]
			var_204_2 = 1
		else
			var_204_2 = var_204_0[2]
			var_204_3 = nil
		end
	else
		var_204_1, var_204_2, var_204_3, arrayid = var_204_0[1], var_204_0[2], var_204_0[3], var_204_0[4]
	end

	local var_204_4, var_204_5 = self:isModeValid(var_204_1)

	if not var_204_4 then
		if var_204_3 then
			var_204_3(var_204_5)
		end

		return
	end

	local activity_manager = require("controller.activity_manager")
	local var_204_7 = {}

	for iter_204_0, iter_204_1 in pairs((activity_manager:getGroupTowerArray())) do
		table.insert(var_204_7, iter_204_1.fight_girl)
	end

	network:rpc("switch_to_adventuremode", {
		mode = var_204_1,
		chapter = var_204_2,
		servants = var_204_7
	}, function(arg_205_0)
		print("msg", dump(arg_205_0))

		if arg_205_0.result == 1 then
			local var_205_0 = false
			local var_205_1

			playermodel.levelmode[var_204_1] = arg_205_0.levelmode
			playermodel.curLevel = arg_205_0.curlevel
			playermodel.curMode = arg_205_0.curmode

			AnalyticManager.joinAdventure(var_204_1)

			for iter_205_0, iter_205_1 in pairs(activity_manager:getIsHaveArrayNil()) do
				if iter_205_1 == true then
					var_205_0 = true
					var_205_1 = iter_205_0

					break
				end
			end

			if var_205_0 then
				global_ShowBlockWords(string.format(L_TVT_DEFENCE_ARRAY_NIL, var_205_1))
				RoleDefault:getInstance():setBoolForKey("GroupTowerAutoFight", false)

				if var_204_3 then
					var_204_3(1)
				end
			else
				LayerManager:switchShowLayer("FightLayer", {
					is_hide_topcost = true,
					is_hide_listbutton = true
				})
				FightManager.refreshFightToType(FIGHTTYPE_GROUPFIGHT)
			end
		end
	end)
end

function var_0_0:isMainChapterOrFeederChapter(arg_206_1)
	if not levelmode_data[arg_206_1] then
		return false
	end

	return arg_206_1 and arg_206_1 < 102 or self:isTalkLevel(arg_206_1) or self:isSpecailLevel(arg_206_1) or self:isMainLevel(arg_206_1) or self:isBranchLevel(arg_206_1) or false
end

local function var_0_28()
	local var_207_0 = {}
	local var_207_1 = RoleDefault:getInstance():getStringForKey("mode_is_new")

	if var_207_1 then
		for iter_207_0 in var_207_1:gmatch("([^,]+),") do
			var_207_0[tonumber(iter_207_0)] = true
		end
	end

	return var_207_0
end

local function var_0_29(arg_208_0)
	local var_208_0 = var_0_28()

	if var_208_0[arg_208_0] then
		return
	end

	var_208_0[arg_208_0] = true

	if next(var_208_0) == nil then
		return
	end

	local var_208_1 = ""

	for iter_208_0, iter_208_1 in pairs(var_208_0) do
		var_208_1 = var_208_1 .. iter_208_0 .. ","
	end

	RoleDefault:getInstance():setStringForKey("mode_is_new", var_208_1)
end

function var_0_0:isModeNew(arg_209_1)
	local var_209_0, var_209_1 = self:isModeValid(arg_209_1)

	if not var_209_0 then
		return false
	end

	if var_0_28()[arg_209_1] and self:isModeValid(arg_209_1) then
		return true
	else
		return false
	end
end

function var_0_0:isCityNewDifficulty(arg_210_1, arg_210_2)
	if not arg_210_1 or not city_data[arg_210_1] then
		return false
	end

	if arg_210_2 and not city_data[arg_210_1]["difficulty" .. arg_210_2] then
		return false
	end

	if not self:isMainCity(arg_210_1) then
		return false
	end

	if arg_210_2 then
		return self:isModeNew(city_data[arg_210_1]["difficulty" .. arg_210_2])
	else
		for iter_210_0 = 1, 4 do
			if self:isModeNew(city_data[arg_210_1]["difficulty" .. iter_210_0]) then
				return true
			end
		end

		return false
	end
end

function var_0_0:checkIsAlertNewCity()
	local var_211_0 = false

	for iter_211_0, iter_211_1 in pairs((self:getCityList())) do
		if self:isCityCanUnlock(iter_211_1) and self:isMainCity(iter_211_1) then
			var_211_0 = true

			break
		end
	end

	local alert_manager = require("controller.alert_manager")

	if var_211_0 then
		alert_manager:register_alert(ALERT_NEW_CITY)
	else
		alert_manager:unregister_alert(ALERT_NEW_CITY, true)
	end
end

function var_0_0.isModeEasyInCity(arg_212_0, arg_212_1)
	for iter_212_0 = 1, 4 do
		if arg_212_1 == city_data[levelmode_data[arg_212_1].city]["difficulty" .. iter_212_0] then
			return iter_212_0 == 1
		end
	end
end

function var_0_0:checkIsAlertNewMode(arg_213_1, arg_213_2)
	if arg_213_1 and arg_213_2 and next(arg_213_2) ~= nil then
		for iter_213_0, iter_213_1 in pairs(arg_213_2) do
			if not self:isModeEasyInCity(iter_213_1) and self:isMainLevel(iter_213_1) then
				var_0_29(iter_213_1)
			end
		end
	end

	local var_213_0 = var_0_28()

	for iter_213_2, iter_213_3 in pairs(var_213_0) do
		if not self:isModeValid(iter_213_2) then
			var_213_0[iter_213_2] = nil
		end
	end

	local alert_manager = require("controller.alert_manager")

	if next(var_213_0) ~= nil then
		alert_manager:register_alert(ALERT_NEW_MODE)
	else
		alert_manager:unregister_alert(ALERT_NEW_MODE, true)
	end
end

function var_0_0:unMarkModeNew(arg_214_1)
	local var_214_0 = var_0_28()

	if not var_214_0[arg_214_1] then
		return
	end

	var_214_0[arg_214_1] = nil

	local var_214_1 = ""

	for iter_214_0, iter_214_1 in pairs(var_214_0) do
		var_214_1 = var_214_1 .. iter_214_0 .. ","
	end

	RoleDefault:getInstance():setStringForKey("mode_is_new", var_214_1)
	self:checkIsAlertNewMode()
end

function var_0_0.checkIsAlertNewChapter(arg_215_0, arg_215_1)
	return
end

function var_0_0.finishPatrolByArrayid(arg_216_0, arg_216_1, arg_216_2)
	require("controller.patrol_manager"):finishPatrolByArrayid(arg_216_1, arg_216_2)
end

function var_0_0:checkIsAlertNew(arg_217_1, arg_217_2)
	self:checkIsAlertNewChapter(arg_217_1)
	self:checkIsAlertNewMode(arg_217_1, arg_217_2)
	self:checkIsAlertNewCity()
end

local var_0_30 = {}
local var_0_31 = {}
local var_0_32 = {}

function var_0_0.getChapterHangupDropInfo(arg_218_0, arg_218_1, arg_218_2, arg_218_3)
	if var_0_30[arg_218_1 .. "-" .. arg_218_2] then
		if arg_218_3 then
			arg_218_3(var_0_30[arg_218_1 .. "-" .. arg_218_2])
		end

		return
	end

	network:rpc("get_level_drop_info", {
		infotype = "HANGUPDROP",
		chapter = arg_218_1 .. "-" .. arg_218_2
	}, function(arg_219_0)
		var_0_30[arg_218_1 .. "-" .. arg_218_2] = arg_219_0.dropinfo

		if arg_218_3 then
			pcall(arg_218_3, arg_219_0.dropinfo)
		end
	end)
end

function var_0_0.getChapterPatrolInfo(arg_220_0, arg_220_1, arg_220_2, arg_220_3)
	if var_0_30[arg_220_1 .. "-" .. arg_220_2] then
		if arg_220_3 then
			arg_220_3(var_0_30[arg_220_1 .. "-" .. arg_220_2])
		end

		return
	end

	network:rpc("get_level_drop_info", {
		infotype = "PATROLDROP",
		chapter = arg_220_1 .. "-" .. arg_220_2
	}, function(arg_221_0)
		var_0_30[arg_220_1 .. "-" .. arg_220_2] = arg_221_0.dropinfo

		if arg_220_3 then
			pcall(arg_220_3, arg_221_0.dropinfo)
		end
	end)
end

function var_0_0.getAdventureDropInfo(arg_222_0, arg_222_1, arg_222_2, arg_222_3)
	if var_0_31[arg_222_1 .. "-" .. arg_222_2] then
		if arg_222_3 then
			arg_222_3(var_0_31[arg_222_1 .. "-" .. arg_222_2])
		end

		return
	end

	network:rpc("get_level_drop_info", {
		infotype = "ADVENTUREDROP",
		chapter = arg_222_1 .. "-" .. arg_222_2
	}, function(arg_223_0)
		var_0_31[arg_222_1 .. "-" .. arg_222_2] = arg_223_0.dropinfo

		if arg_222_3 then
			pcall(arg_222_3, arg_223_0.dropinfo)
		end
	end)
end

function var_0_0.getBigBossDropInfo(arg_224_0, arg_224_1, arg_224_2, arg_224_3)
	if var_0_32[arg_224_1 .. "-" .. arg_224_2] then
		if arg_224_3 then
			arg_224_3(var_0_32[arg_224_1 .. "-" .. arg_224_2])
		end

		return
	end

	network:rpc("get_level_drop_info", {
		infotype = "BOSSDROP",
		chapter = arg_224_1 .. "-" .. arg_224_2
	}, function(arg_225_0)
		var_0_32[arg_224_1 .. "-" .. arg_224_2] = arg_225_0.dropinfo

		if arg_224_3 then
			pcall(arg_224_3, arg_225_0.dropinfo)
		end
	end)
end

function var_0_0.getPlayerLevelRank(arg_226_0, arg_226_1, arg_226_2)
	network:rpc("get_player_level_rank", {
		mode = arg_226_1
	}, function(arg_227_0)
		if arg_227_0.rank and arg_227_0.time then
			arg_227_0.time = os.date("%Y/%m/%d %X", arg_227_0.time)

			if arg_226_2 then
				arg_226_2(arg_227_0)
			end
		elseif arg_226_2 then
			arg_226_2()
		end
	end)
end

function var_0_0.getLevelRankList(arg_228_0, arg_228_1, arg_228_2)
	network:rpc("get_level_ranklist", {
		start = 1,
		stop = 100,
		mode = arg_228_1
	}, function(arg_229_0)
		if arg_228_2 then
			arg_228_2(arg_229_0.data)
		end
	end)
end

function var_0_0.getModesLockState(arg_230_0, arg_230_1)
	network:rpc("get_modes_lock_state", nil, function(arg_231_0)
		if arg_231_0.infos then
			arg_230_0.modesLockState = {}

			for iter_231_0, iter_231_1 in pairs(arg_231_0.infos) do
				arg_230_0.modesLockState[iter_231_1.mode] = iter_231_1.time or -1
			end
		end

		if arg_231_0.cities then
			arg_230_0:update_city_lock_stat(arg_231_0.cities)
		end

		if arg_230_1 then
			arg_230_1()
		end
	end)
end

function var_0_0:isModeManualLocked(arg_232_1)
	self.modesLockState = self.modesLockState or {}

	return not not self.modesLockState[arg_232_1]
end

function var_0_0.isTalkLevel(arg_233_0, arg_233_1)
	if not levelmode_data[arg_233_1] then
		return
	end

	if not levelmode_data[arg_233_1].city then
		return
	end

	return not not city_data[levelmode_data[arg_233_1].city].is_talk_city
end

function var_0_0.isBranchLevel(arg_234_0, arg_234_1)
	if not levelmode_data[arg_234_1] then
		return
	end

	for iter_234_0, iter_234_1 in pairs(city_data) do
		while iter_234_1["difficulty" .. 1] do
			if arg_234_1 == iter_234_1["difficulty" .. 1] then
				return not not iter_234_1.show_in_levelmapbox
			end
		end
	end
end

function var_0_0.isSpecailLevel(arg_235_0, arg_235_1)
	if not levelmode_data[arg_235_1] then
		return
	end

	if not levelmode_data[arg_235_1].city then
		return
	end

	return not not city_data[levelmode_data[arg_235_1].city].show_in_specialmapbox
end

function var_0_0.isTalkCity(arg_236_0, arg_236_1)
	if not city_data[arg_236_1] then
		return
	end

	return city_data[arg_236_1].is_talk_city
end

function var_0_0.isBranchCity(arg_237_0, arg_237_1)
	if not city_data[arg_237_1] then
		return
	end

	return city_data[arg_237_1].show_in_levelmapbox
end

function var_0_0.isSpecialCity(arg_238_0, arg_238_1)
	if not city_data[arg_238_1] then
		return
	end

	return city_data[arg_238_1].show_in_specialmapbox
end

function var_0_0:getShowNameByChapter(arg_239_1)
	local var_239_0, var_239_1 = arg_239_1:match("(%d+)-(%d+)")

	return string.format("%s(%s)", self:getModeName(tonumber(var_239_0)), self:getChapterName(tonumber(var_239_0), tonumber(var_239_1)))
end

function var_0_0:getChapterStarsState(arg_240_1, arg_240_2)
	local bit = require("bit")
	local var_240_1 = self:getModeTotalChapter(arg_240_1)

	if not playermodel.levelmode[arg_240_1].stars or var_240_1 > #playermodel.levelmode[arg_240_1].stars then
		playermodel.levelmode[arg_240_1].stars = playermodel.levelmode[arg_240_1].stars or {}

		for iter_240_0 = 1, math.ceil(var_240_1 / 10) do
			table.insert(playermodel.levelmode[arg_240_1].stars, 0)
		end
	end

	local var_240_2 = math.ceil(arg_240_2 / 10)
	local var_240_3 = (arg_240_2 - 1) % 10 + 1
	local var_240_4 = {}

	for iter_240_1 = 1, LEVEL_STARS_NUM do
		var_240_4[iter_240_1] = bit.band(2^((var_240_3 - 1) * 3 + iter_240_1 - 1), playermodel.levelmode[arg_240_1].stars[var_240_2]) > 0
	end

	return var_240_4
end

function var_0_0:getChapterStarsCount(arg_241_1, arg_241_2)
	local var_241_0 = self:getChapterStarsState(arg_241_1, arg_241_2)
	local var_241_1 = 0

	for iter_241_0 = 1, LEVEL_STARS_NUM do
		if var_241_0[iter_241_0] then
			var_241_1 = var_241_1 + 1
		end
	end

	return var_241_1
end

function var_0_0:getModeTotalStars(arg_242_1)
	local var_242_0 = 0

	for iter_242_0 = 1, levelmode_data[arg_242_1].totalchapter do
		for iter_242_1, iter_242_2 in pairs((self:getChapterStarsState(arg_242_1, iter_242_0))) do
			if iter_242_2 then
				var_242_0 = var_242_0 + 1
			end
		end
	end

	return var_242_0
end

function var_0_0:getAllNomalStarCount()
	local var_243_0 = 0

	for iter_243_0, iter_243_1 in pairs(playermodel.levelmode) do
		if levelmode_data[iter_243_1.mode] and levelmode_data[iter_243_1.mode].modetype == 1 then
			var_243_0 = var_243_0 + self:getModeTotalStars(iter_243_1.mode)
		end
	end

	return var_243_0
end

function var_0_0:getCityTotalStars(arg_244_1)
	local var_244_0 = {}

	while city_data[arg_244_1]["difficulty" .. 1] do
		table.insert(var_244_0, city_data[arg_244_1]["difficulty" .. 1])
	end

	local var_244_2 = 0

	for iter_244_0, iter_244_1 in pairs(var_244_0) do
		var_244_2 = var_244_2 + self:getModeTotalStars(iter_244_1)
	end

	return var_244_2
end

function var_0_0.getModeStarReward(arg_245_0, arg_245_1, arg_245_2, arg_245_3)
	if playermodel.levelmodeReward[arg_245_1][arg_245_2] then
		arg_245_3(2)

		return
	end

	network:rpc("get_mode_stars_reward", {
		mode = arg_245_1,
		reward_class = arg_245_2
	}, function(arg_246_0)
		if arg_246_0.result == 1 then
			global_gain(arg_246_0)

			playermodel.levelmodeReward[arg_245_1] = playermodel.levelmodeReward[arg_245_1] or {}
			playermodel.levelmodeReward[arg_245_1][arg_245_2] = true

			local alert_manager = require("controller.alert_manager")

			if arg_245_0:checkStarRewardAlert() then
				alert_manager:register_alert(ALERT_STAR_REWARD)
			else
				alert_manager:unregister_alert(ALERT_STAR_REWARD, true)
			end
		elseif arg_246_0.result == 2 then
			global_ShowBlockWords(L_MODE_STAR_REWARD_FAIL[arg_246_0.result])
		elseif arg_246_0.result == 3 then
			global_ShowBlockWords(L_MODE_STAR_REWARD_FAIL[arg_246_0.result])
		end

		if arg_245_3 then
			arg_245_3(arg_246_0.result)
		end
	end)
end

function var_0_0:checkIsNewStarReward(arg_247_1)
	local var_247_0 = require("data.levelmode_star_reward_data")[arg_247_1]

	if not playermodel.levelmodeReward then
		return false
	end

	if not playermodel.levelmodeReward[arg_247_1] then
		return false
	end

	if not var_247_0 then
		return false
	end

	local var_247_1 = self:getModeTotalStars(arg_247_1)

	while var_247_0["need_num" .. 1] do
		if var_247_1 >= var_247_0["need_num" .. 1] and not playermodel.levelmodeReward[arg_247_1][1] then
			return true
		end
	end

	return false
end

function var_0_0:checkIsNewStarRewardInCity(arg_248_1)
	if not city_data[arg_248_1] then
		return false
	end

	local var_248_0 = 1

	while city_data[arg_248_1]["difficulty" .. var_248_0] do
		if self:checkIsNewStarReward(city_data[arg_248_1]["difficulty" .. var_248_0]) then
			return true
		end

		var_248_0 = var_248_0 + 1
	end

	return false
end

function var_0_0:checkStarRewardAlert()
	if not playermodel.levelmodeReward then
		return
	end

	if next(playermodel.levelmodeReward) == nil then
		return
	end

	for iter_249_0, iter_249_1 in pairs(city_data) do
		while iter_249_1["difficulty" .. 1] do
			if self:checkIsNewStarReward(iter_249_1["difficulty" .. 1]) then
				return true
			end
		end
	end

	return false
end

function var_0_0.passLevelGetNewStar(arg_250_0, arg_250_1, arg_250_2)
	local bit = require("bit")
	local var_250_2, var_250_3 = playermodel.curLevel:match("(%d+)-(%d+)")
	local var_250_4 = math.ceil(var_250_2 / 10)
	local var_250_5 = {}

	for iter_250_0 = 1, LEVEL_STARS_NUM do
		if bit.band(2^(((var_250_2 - 1) % 10 + 1 - 1) * 3 + iter_250_0 - 1), arg_250_1[var_250_4] or 0) == 0 and bit:band(arg_250_2[var_250_4] or 0) > 0 then
			var_250_5[iter_250_0] = true
		end
	end

	return var_250_5
end

function var_0_0:setRefightArray(arg_251_1)
	self.starRefightArray = require("controller.array_manager"):getBattleArrayData(arg_251_1)

	for iter_251_0, iter_251_1 in pairs(self.starRefightArray) do
		self.starRefightArray[iter_251_0].classtype = 1
	end
end

function var_0_0.resetRefightArray(arg_252_0)
	local array_manager = require("controller.array_manager")

	array_manager.last_refight_array = array_manager.curArray
	arg_252_0.starRefightArray = array_manager:getBattleArrayData(array_manager.curArray)
end

function var_0_0:resetRefightPlayer()
	local var_253_0 = self.starRefightArray or global_deepCopy(playermodel.curSoul)

	playermodel.curSoul = {}

	for iter_253_0 = 1, FORMATION_SHOW_GIRL_NUM do
		if var_253_0[iter_253_0] and var_253_0[iter_253_0].fight_girl then
			playermodel.curSoul[iter_253_0] = {
				classtype = 1,
				pos = iter_253_0,
				fight_girl = var_253_0[iter_253_0].fight_girl,
				assist_girl = var_253_0[iter_253_0].assist_girl,
				assist = var_253_0[iter_253_0].assist
			}
		end
	end
end

function var_0_0.resetBigBoosFightDieTbl(arg_254_0)
	arg_254_0.bigBoosFightDieTbl = {}
end

function var_0_0:getBigBoosFightDieTbl()
	return self.bigBoosFightDieTbl
end

function var_0_0:onNormalPlayerDie(arg_256_1)
	self.bigBoosFightDieTbl[arg_256_1] = true
end

function var_0_0.getChapterBossBgm(arg_257_0, arg_257_1, arg_257_2)
	if not level_bgm[arg_257_1 .. "-" .. arg_257_2] then
		return BOSS_BGM
	end

	if not level_bgm[arg_257_1 .. "-" .. arg_257_2].bgm then
		return BOSS_BGM
	end

	return "sound/" .. level_bgm[arg_257_1 .. "-" .. arg_257_2].bgm or BOSS_BGM
end

function var_0_0.get_cur_activity_hangup_conf_client(arg_258_0, arg_258_1, arg_258_2, arg_258_3)
	network:rpc("get_cur_activity_hangup_conf_client", {
		mode = arg_258_1,
		chapter = arg_258_2
	}, function(arg_259_0)
		if arg_258_3 then
			arg_258_3(arg_259_0)
		end
	end)
end

function var_0_0.getModeListByModeType(arg_260_0, arg_260_1)
	local var_260_0 = {}

	for iter_260_0, iter_260_1 in pairs(levelmode_data) do
		if iter_260_1.modetype == arg_260_1 then
			table.insert(var_260_0, iter_260_0)
		end
	end

	table.sort(var_260_0, function(arg_261_0, arg_261_1)
		return arg_261_0 < arg_261_1
	end)

	return var_260_0
end

function var_0_0.get_adventure_score(arg_262_0, arg_262_1, arg_262_2, arg_262_3)
	network:rpc("get_adventure_score", {
		mode = arg_262_1,
		modetype = arg_262_2
	}, function(arg_263_0)
		if arg_263_0.result == 1 then
			if arg_262_3 then
				arg_262_3(arg_263_0.result, arg_263_0.score, arg_263_0.modescore, arg_263_0.rank)
			end
		elseif arg_262_3 then
			arg_262_3(arg_263_0.result)
		end
	end)
end

function var_0_0.is_have_adventure_awards(arg_264_0, arg_264_1, arg_264_2, arg_264_3)
	network:rpc("is_have_adventure_awards", {
		mode = arg_264_1,
		modetype = arg_264_2
	}, function(arg_265_0)
		print(dump(arg_265_0))

		if arg_265_0.result == 1 then
			if arg_264_3 then
				arg_264_3(arg_265_0)
			end
		elseif arg_264_3 then
			arg_264_3(arg_265_0)
		end
	end)
end

function var_0_0.get_adventure_score_awards(arg_266_0, arg_266_1, arg_266_2, arg_266_3, arg_266_4)
	network:rpc("get_adventure_score_awards", {
		mode = arg_266_1,
		modetype = arg_266_2,
		rank = arg_266_3
	}, function(arg_267_0)
		if arg_267_0.result == 1 then
			global_gain({
				items = arg_267_0.items,
				diamond = arg_267_0.diamond,
				gold = arg_267_0.gold,
				sp = arg_267_0.sp
			})

			if arg_266_4 then
				arg_266_4(arg_267_0)
			end
		elseif arg_266_4 then
			arg_266_4(arg_267_0)
		end
	end)
end

function var_0_0.get_adventure_score_ranklist(arg_268_0, arg_268_1, arg_268_2, arg_268_3, arg_268_4, arg_268_5)
	network:rpc("get_adventure_score_ranklist", {
		mode = arg_268_1,
		modetype = arg_268_2,
		start = arg_268_3,
		stop = arg_268_4
	}, function(arg_269_0)
		if arg_269_0.result == 1 then
			if arg_268_5 then
				arg_268_5(arg_269_0.result, arg_269_0.data)
			end
		elseif arg_268_5 then
			arg_268_5(arg_269_0.result)
		end
	end)
end

function var_0_0.get_mode_bossimg(arg_270_0, arg_270_1)
	return levelmode_data[arg_270_1].bossimg or 2100, levelmode_data[arg_270_1].bossimgininitpos or "200,568", levelmode_data[arg_270_1].bossimgoffset or "0,0", levelmode_data[arg_270_1].bossimgscale or 1, levelmode_data[arg_270_1].bossimg_fade_star_x or 0.5, levelmode_data[arg_270_1].bossimg_fade_finish_x or 1, levelmode_data[arg_270_1].bossimg_fade_star_a or 1, levelmode_data[arg_270_1].bossimg_fade_finish_a or 0.2
end

function var_0_0.get_infinite_score_up_list(arg_271_0, arg_271_1, arg_271_2)
	network:rpc("get_infinite_score_up_list", {
		mode = arg_271_1
	}, function(arg_272_0)
		if arg_272_0.list then
			if arg_271_2 then
				arg_271_2(1, arg_272_0.list)
			end
		elseif arg_271_2 then
			arg_271_2(0)
		end
	end)
end

function var_0_0:getinfiniteWaveStr()
	local var_273_2 = self:getModeTotalChapter(playermodel.curMode)

	return var_273_2, (var_273_2 < playermodel.levelmode[playermodel.curMode].status or nil) and var_273_2
end

function var_0_0.get_mode_task_reward(arg_274_0, arg_274_1)
	return levelmode_data[arg_274_1].task_reward
end

function var_0_0:getinfiniteChapterScore()
	if playermodel.levelmode[playermodel.curMode].status - 1 >= self:getModeTotalChapter(playermodel.curMode) then
		return
	end

	if chapter_data[playermodel.curMode .. "-" .. playermodel.levelmode[playermodel.curMode].status - 1] and chapter_data[playermodel.curMode .. "-" .. playermodel.levelmode[playermodel.curMode].status - 1].timereward then
		return chapter_data[playermodel.curMode .. "-" .. playermodel.levelmode[playermodel.curMode].status - 1].timereward
	end
end

function var_0_0.setinfiniteScoreInfo(arg_276_0, arg_276_1)
	arg_276_0.scoreinfo = arg_276_1
end

function var_0_0:getinfiniteScoreInfo(arg_277_1)
	if not self.scoreinfo or not arg_277_1 then
		return
	end

	local var_277_0

	for iter_277_0, iter_277_1 in pairs(self.scoreinfo) do
		if iter_277_1.mode and iter_277_1.mode == arg_277_1 then
			var_277_0 = iter_277_1.score
		end
	end

	return var_277_0
end

function var_0_0:isInfinteTheLastBoss()
	if not playermodel.curMode then
		return false
	end

	local var_278_0 = playermodel.levelmode[playermodel.curMode].status

	if not playermodel.levelmode[playermodel.curMode].status then
		return false
	end

	if var_278_0 >= self:getModeTotalChapter(playermodel.curMode) then
		return true
	else
		return false
	end
end

function var_0_0.getCityListById(arg_279_0, arg_279_1)
	local var_279_0 = {}

	for iter_279_0, iter_279_1 in pairs(levelmode_data) do
		if iter_279_1.modetype == arg_279_1 then
			if arg_279_1 == 1021 then
				if iter_279_1.mode >= 1021 and iter_279_1.mode <= 1023 then
					table.insert(var_279_0, iter_279_1.mode)
				end
			else
				table.insert(var_279_0, iter_279_1.mode)
			end
		end
	end

	table.sort(var_279_0, function(arg_280_0, arg_280_1)
		return arg_280_0 < arg_280_1
	end)

	return var_279_0
end

function var_0_0.getCurLevelInfo(arg_281_0, arg_281_1)
	local var_281_0 = var_0_17(playermodel.levelmode[arg_281_1].level)
	local var_281_1 = {}

	for iter_281_0, iter_281_1 in pairs(chapter_data) do
		if string.find(iter_281_1.id, "^" .. arg_281_1 .. "(-%d+)$") then
			table.insert(var_281_1, iter_281_1)
		end
	end

	table.sort(var_281_1, function(arg_282_0, arg_282_1)
		return arg_282_0.index < arg_282_1.index
	end)

	local var_281_2 = {}

	for iter_281_2 = 1, #var_281_1 do
		local var_281_3 = var_281_1[iter_281_2]
		local var_281_4 = 0

		if var_281_0 == iter_281_2 then
			var_281_4 = 1
		elseif var_281_0 < iter_281_2 then
			var_281_4 = 2
		end

		local var_281_5 = var_281_3.out_image
		local var_281_6

		if var_281_3.out_image ~= nil then
			var_281_6 = var_281_5 .. "_gray"
			var_281_5 = "TowerDefenceLevelLayer/" .. var_281_5 .. ".png"
		end

		if var_281_6 ~= nil and iter_281_2 % 3 == 0 then
			var_281_6 = "TowerDefenceLevelLayer/" .. var_281_6 .. ".png"
		elseif var_281_6 ~= nil and iter_281_2 % 3 ~= 0 then
			var_281_6 = "TowerDefenceLevelLayer/small_level_gray.png"
		end

		table.insert(var_281_2, {
			curStar = 2,
			iconPath = "",
			index = iter_281_2,
			name = var_281_3.name,
			des = var_281_3.des,
			curStatus = var_281_4,
			bgPath = var_281_5,
			bgPathGray = var_281_6
		})
	end

	var_281_2.curTotalStar = 0
	var_281_2.curStarProcess = 0

	return var_281_2
end

function var_0_0:getCurCityUnlockModeMaxStar(arg_283_1)
	local var_283_0 = 0

	while city_data[arg_283_1]["difficulty" .. 1] do
		if self:isLevelModeUnlocked(city_data[arg_283_1]["difficulty" .. 1]) then
			var_283_0 = var_283_0 + self:getModeTotalChapter(city_data[arg_283_1]["difficulty" .. 1]) * 3
		end
	end

	if var_283_0 == 0 then
		return self:getModeTotalChapter(city_data[arg_283_1].difficulty1) * 3
	else
		return var_283_0
	end
end

function var_0_0:getCurModeByCity(arg_284_1)
	local var_284_0 = 1

	while city_data[arg_284_1]["difficulty" .. var_284_0 + 1] do
		var_284_0 = var_284_0 + 1
	end

	while city_data[arg_284_1]["difficulty" .. var_284_0] do
		if self:isLevelModeUnlocked(city_data[arg_284_1]["difficulty" .. var_284_0]) then
			return city_data[arg_284_1]["difficulty" .. var_284_0]
		end

		var_284_0 = var_284_0 - 1
	end

	return city_data[arg_284_1].difficulty1
end

function var_0_0:getCurCityUnlockModeTotalStars(arg_285_1)
	local var_285_0 = {}

	while city_data[arg_285_1]["difficulty" .. 1] do
		if self:isLevelModeUnlocked(city_data[arg_285_1]["difficulty" .. 1]) then
			table.insert(var_285_0, city_data[arg_285_1]["difficulty" .. 1])
		end
	end

	local var_285_2 = 0

	for iter_285_0, iter_285_1 in pairs(var_285_0) do
		var_285_2 = var_285_2 + self:getModeTotalStars(iter_285_1)
	end

	return var_285_2
end

function var_0_0.getFirstModeByCity(arg_286_0, arg_286_1)
	return city_data[arg_286_1].difficulty1
end

function var_0_0.getPremode(arg_287_0, arg_287_1)
	return levelmode_data[arg_287_1].premode
end

function var_0_0.getModeByCity(arg_288_0, arg_288_1, arg_288_2)
	arg_288_2 = arg_288_2 or 1

	return city_data[arg_288_1]["difficulty" .. arg_288_2]
end

function var_0_0.isPassedTower(arg_289_0, arg_289_1, arg_289_2)
	return arg_289_2 < math.max((not playermodel.levelmode[arg_289_1].lastpass or nil) and 0, playermodel.levelmode[arg_289_1].pass)
end

function var_0_0.buy_mode_temporarily(arg_290_0, arg_290_1, arg_290_2)
	network:rpc("buy_mode_temporarily", {
		mode = arg_290_1
	}, function(arg_291_0)
		if arg_291_0.result == 1 then
			playermodel.diamond = playermodel.diamond - 100

			global_update_gold_stone_diamond(nil, nil, 100)
		elseif arg_291_0.result == 2 then
			global_ShowBlockWords(L_FAILED_UNLOCKED)
		elseif arg_291_0.result == 3 then
			global_ShowBlockWords(L_DIAMOND_LACK)
		end

		if arg_290_2 then
			arg_290_2(arg_291_0.result)
		end
	end)
end

function var_0_0.getDropUpServants(arg_292_0, arg_292_1)
	if not arg_292_1 or not levelmode_data[arg_292_1] or not levelmode_data[arg_292_1].up_servant then
		return
	end

	local var_292_0 = levelmode_data[arg_292_1].up_servant

	if not levelmode_data[arg_292_1].up_servant then
		return
	end

	local var_292_1 = string.split(var_292_0, "&")

	for iter_292_0, iter_292_1 in ipairs(var_292_1) do
		var_292_1[iter_292_0] = tonumber(iter_292_1)
	end

	return var_292_1
end

return var_0_0
