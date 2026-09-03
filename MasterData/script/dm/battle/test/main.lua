-- chunkname: @/tmp/or_script/lua_compile/dm/battle/test/main.lua

package.cpath = "../serverbattle/libs/darwin/?.so;" .. package.cpath

require("objectlua.init")
require("foundation.init")
require("dragon.fsm.init")
require("dm.battle.logic.all")
print("==== Running battle testing ====")

local skillModule = require("dm.battle.test.DemoSkills")
local battleConfig = {
	dmgFlooredCoeff = {
		0.2,
		5
	}
}
local unitBase = {
	genre = "dps",
	name = "NoName",
	blockrate = 0,
	maxHp = 500,
	unblockrate = 0,
	counterrate = 0,
	absorption = 0,
	blockstrg = 0,
	unhurtrate = 0,
	level = 21,
	atk = 170,
	anger = 240,
	def = 90,
	star = 5,
	critstrg = 0,
	undeadrate = 0,
	hurtrate = 0,
	uncritrate = 0,
	defrate = 1,
	ctrlrate = 0,
	hp = 500,
	reflection = 0,
	atkrate = 1,
	unctrlrate = 0,
	skillrate = 0.5,
	critrate = 0,
	doublerate = 0,
	quality = 10,
	defweaken = 0,
	modelId = "m001",
	atkweaken = 0,
	flags = {
		"elite"
	},
	angerRules = {
		a3 = 400,
		a2 = 100,
		a1 = {
			10,
			1000
		}
	},
	skills = {
		normal = {
			level = 10,
			proto = "DemoNormalSkill",
			skillId = "normal"
		},
		proud = {
			level = 10,
			proto = "DemoNormalSkill",
			skillId = "proud"
		},
		unique = {
			level = 10,
			proto = "DemoBuffSkill",
			skillId = "unique"
		},
		death = {
			level = 10,
			proto = "DemoNormalSkill",
			skillId = "death"
		}
	}
}

local function unitData(base, obj)
	return fillTableWithDefaults(obj, base)
end

local player1Data = {
	initiative = 100,
	energy = {
		capacity = 10,
		base = 3
	},
	waves = {
		{
			master = unitData(unitBase, {
				id = "m-a1",
				modelId = "1001",
				critrate = 0.1
			})
		}
	},
	cards = {
		{
			cost = 3,
			id = "c-a1",
			hero = unitData(unitBase, {
				id = "h-a1",
				modelId = "100001"
			})
		},
		{
			cost = 3,
			id = "c-a2",
			hero = unitData(unitBase, {
				id = "h-a2",
				modelId = "100002"
			})
		},
		{
			cost = 3,
			id = "c-a3",
			hero = unitData(unitBase, {
				id = "h-a3",
				modelId = "100003"
			})
		},
		{
			cost = 3,
			id = "c-a4",
			hero = unitData(unitBase, {
				id = "h-a4",
				modelId = "100004"
			})
		},
		{
			cost = 3,
			id = "c-a5",
			hero = unitData(unitBase, {
				id = "h-a5",
				modelId = "100005"
			})
		},
		{
			cost = 3,
			id = "c-a6",
			hero = unitData(unitBase, {
				id = "h-a6",
				modelId = "100006"
			})
		},
		{
			cost = 3,
			id = "c-a7",
			hero = unitData(unitBase, {
				id = "h-a7",
				modelId = "100007"
			})
		},
		{
			cost = 3,
			id = "c-a8",
			hero = unitData(unitBase, {
				id = "h-a8",
				modelId = "100008"
			})
		}
	}
}
local player2Data = {
	initiative = 110,
	energy = {
		capacity = 10,
		base = 2
	},
	waves = {
		{
			master = unitData(unitBase, {
				id = "m-b1",
				modelId = "1001"
			})
		}
	},
	cards = {
		{
			cost = 3,
			id = "c-b1",
			hero = unitData(unitBase, {
				id = "h-b1",
				modelId = "100009"
			})
		},
		{
			cost = 3,
			id = "c-b2",
			hero = unitData(unitBase, {
				id = "h-b2",
				modelId = "100010"
			})
		},
		{
			cost = 3,
			id = "c-b3",
			hero = unitData(unitBase, {
				id = "h-b3",
				modelId = "100011"
			})
		},
		{
			cost = 3,
			id = "c-b4",
			hero = unitData(unitBase, {
				id = "h-b4",
				modelId = "100012"
			})
		},
		{
			cost = 3,
			id = "c-b5",
			hero = unitData(unitBase, {
				id = "h-b5",
				modelId = "100013"
			})
		},
		{
			cost = 3,
			id = "c-b6",
			hero = unitData(unitBase, {
				id = "h-b6",
				modelId = "100007"
			})
		},
		{
			cost = 3,
			id = "c-b7",
			hero = unitData(unitBase, {
				id = "h-b7",
				modelId = "100004"
			})
		},
		{
			cost = 3,
			id = "c-b8",
			hero = unitData(unitBase, {
				id = "h-b8",
				modelId = "100003"
			})
		}
	}
}
local randseed1, randseed2, randseed3

randseed1 = tonumber(tostring(os.time()):reverse():sub(1, 6))
randseed2 = tonumber(tostring(os.time()):reverse():sub(1, 7)) % 964913
randseed3 = tonumber(tostring(os.time()):reverse():sub(1, 8)) % 917389

local random1 = Random:new(randseed1)
local random2 = Random:new(randseed2)
local random3 = Random:new(randseed3)

print("Random seeds:", randseed1, randseed2, randseed3)

local starttime = os.clock()
local battleLogic = RegularBattleLogic:new()

battleLogic:setSkillDefinitions(skillModule.__all__)
battleLogic:setBattleConfig(battleConfig)
battleLogic:setRandomizer(random1)
battleLogic:setMaxRounds(20)

local player1 = BattlePlayer:new("p1"):initWithData(player1Data)

battleLogic:getTeamA():addPlayer(player1)

local player2 = BattlePlayer:new("p2"):initWithData(player2Data)

battleLogic:getTeamB():addPlayer(player2)

local battleRecorder = BattleRecorder:new()
local battleStatist = SimpleBattleStatist:new()
local battleSimulator = BattleSimulator:new()

battleSimulator:setBattleRecorder(battleRecorder)
battleSimulator:setBattleStatist(battleStatist)
battleSimulator:setBattleLogic(battleLogic)

local interval = 50
local timeout = 200000
local elapsed = 0

battleSimulator:start(interval)

while true do
	local status = battleSimulator:tick(interval)

	elapsed = elapsed + interval

	if status ~= nil then
		break
	end

	if timeout ~= nil and timeout <= elapsed then
		print("Battle simulator timed out!")

		break
	end
end

local endtime = os.clock()

print("Elapsed time:", endtime - starttime)

local frames = battleRecorder:getTotalFrames()
local battleTime = frames * interval

print("Total Frames:", string.format("%s (%s ms)", frames, battleTime))
dump(battleStatist:getSummary(), "summary")
Bdump("timelines:{}", battleRecorder:dumpRecords(true))
print("==== Battle testing completed ====")
