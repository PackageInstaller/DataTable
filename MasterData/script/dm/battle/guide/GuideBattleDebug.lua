-- chunkname: @/tmp/or_script/lua_compile/dm/battle/guide/GuideBattleDebug.lua

local Position = require("dm.battle.guide.GuideBattlePos")
local BattleDebugConfig = require("dm.battle.guide.BattleDebugConfig")
local __id2pos__ = {
	x = {
		1,
		1,
		1,
		2,
		2,
		2,
		3,
		3,
		3
	},
	y = {
		1,
		2,
		3,
		1,
		2,
		3,
		1,
		2,
		3
	}
}

local function cell2Pos(cellId, x, y)
	if cellId > 0 then
		return Position({
			1,
			x or __id2pos__.x[cellId],
			y or __id2pos__.y[cellId]
		})
	else
		return Position({
			-1,
			x or __id2pos__.x[-cellId],
			y or __id2pos__.y[-cellId]
		})
	end
end

local GuideBattleDebug = {}
local player1 = "player1"
local player2 = "player2"
local units = {
	unitB4 = "ADHWShi",
	unitA9 = "YDZZong",
	unitA4 = "WEDe",
	masterB = "First_Battle_Master2",
	unitB7 = "PNCao",
	unitA1 = "ZTXChang",
	unitA2 = "ZTXCun",
	unitB2 = "HLDNan",
	unitB1 = "JDCZhang",
	unitA5 = "YFZZhu",
	unitA6 = "HLMGen",
	unitB3 = "YKDMLai",
	unitA3 = "DFQi",
	unitB6 = "WTXXuan",
	unitB5 = "FEMSi",
	unitA7 = "LYSi",
	unitB9 = "SGHQShou",
	masterA = "First_Battle_Master1"
}

local function loadMasterSkill(skillId, skillType)
	if skillId then
		local skillConfig = ConfigReader:getRecordById("Skill", skillId)

		return {
			level = 1,
			type = skillType,
			icon = skillConfig.Icon,
			id = skillId
		}
	end

	return ""
end

local function loadMasterData(masterId, owner, cellId, anim)
	local unitId = units[masterId]
	local config = ConfigReader:getRecordById("EnemyMaster", unitId)

	assert(config ~= nil, "master:" .. masterId .. " not exists!")

	local skills = {
		"",
		"",
		""
	}

	if config.MasterSkill1 then
		skills[1] = loadMasterSkill(config.MasterSkill1, kBattleMasterSkill1)
	end

	if config.MasterSkill2 then
		skills[2] = loadMasterSkill(config.MasterSkill2, kBattleMasterSkill2)
	end

	if config.MasterSkill3 then
		skills[3] = loadMasterSkill(config.MasterSkill3, kBattleMasterSkill3)
	end

	return {
		maxAnger = 1000,
		cost = 0,
		infoId = masterId,
		id = unitId,
		model = config.RoleModel,
		cell = cellId,
		owner = owner,
		hp = config.Hp,
		maxHp = config.Hp,
		anger = config.RageBase,
		roleType = BattleUnitType.kMaster,
		anim = {
			dur = 1000,
			name = "init"
		},
		skills = skills
	}
end

local function loadCardData(heroId)
	local unitId = units[heroId]

	if unitId then
		::label_5_0::

		local config = ConfigReader:getRecordById("HeroBase", unitId)

		if config then
			return {
				uniqueLevel = 1,
				type = "hero",
				unique = config.UniqueSkill,
				cost = config.Cost,
				id = unitId,
				infoId = heroId,
				hero = {
					ratio = 1,
					level = config.Level,
					star = config.Star,
					id = heroId,
					model = config.RoleModel,
					rarity = config.Rarity,
					maxHp = config.BaseHp,
					def = config.Defence,
					atk = config.Attack,
					genre = config.Type
				}
			}
		end
	end
end

local function loadHeroData(heroId, owner, cellId, anim)
	local unitId = units[heroId]

	if unitId then
		::label_6_0::

		local config = ConfigReader:getRecordById("HeroBase", unitId)

		assert(config ~= nil, "hero:" .. heroId .. " not exists!")

		local var_6_0 = {
			maxAnger = 1000,
			infoId = heroId,
			id = unitId
		}

		var_6_0.model = GameConfigs.debugModelId or config.RoleModel
		var_6_0.cell = cellId
		var_6_0.owner = owner
		var_6_0.hp = config.BaseHp
		var_6_0.maxHp = config.BaseHp
		var_6_0.anger = config.MasterRage
		var_6_0.cost = config.Cost
		var_6_0.roleType = BattleUnitType.kHero
		var_6_0.anim = anim or {
			name = "spawn"
		}
		var_6_0.genre = config.Type
		var_6_0.unique = config.UniqueSkill

		return var_6_0
	end
end

local function loadPlayerData(playerId, side, energy, cardArray)
	local cards = {
		0,
		0,
		0,
		0
	}
	local cardPool = {}

	for i = 1, 4 do
		if cardArray[i] then
			cards[i] = loadCardData(cardArray[i])
		end
	end

	for i = #cardArray, 5, -1 do
		cardPool[#cardPool + 1] = loadCardData(cardArray[i])
	end

	local nextCard = cardPool[#cardPool]

	return {
		energy = energy or 10,
		id = playerId,
		side = side,
		cardPoolSize = #cardPool,
		cards = cards,
		cardPool = cardPool,
		nextCard = nextCard
	}
end

local function popHeroCard(playerInfo, idx)
	if not playerInfo.nextCard then
		playerInfo.cards[idx] = playerInfo.nextCard

		local cardPool = playerInfo.cardPool
		local count = playerInfo.cardPoolSize

		if count > 1 then
			playerInfo.cardPoolSize = count - 1
			playerInfo.nextCard = cardPool[count - 1]
		else
			playerInfo.cardPoolSize = 0
			playerInfo.nextCard = nil
		end

		return {
			type = "hero",
			next = playerInfo.nextCard,
			idx = idx,
			card = playerInfo.nextCard
		}
	end
end

local function genPerform(skillId, actId, dst, dur)
	if dst then
		local dur = dur or 200

		return {
			anim = {
				seq = {
					{
						loop = -1,
						name = "run",
						move = {
							dst = dst,
							dur = dur
						},
						dur = dur
					},
					{
						name = skillId
					}
				}
			},
			act = actId
		}
	else
		return {
			anim = {
				name = skillId
			},
			act = actId
		}
	end
end

function GuideBattleDebug:main(guideThread, battleContext)
	if GameConfigs.debugSkills then
		BattleDebugConfig.unitsSkills.unitA1 = {}

		for k, v in pairs(GameConfigs.debugSkills) do
			BattleDebugConfig.unitsSkills.unitA1[#BattleDebugConfig.unitsSkills.unitA1 + 1] = {
				target = "masterB",
				skill = v
			}
		end
	end

	BattleDebugConfig.units.unitA1 = GameConfigs.debugHeroId or BattleDebugConfig.units.unitA1
	units = BattleDebugConfig.units

	local battleData = {
		player1 = loadPlayerData(player1, kBattleSideA, 12, {
			"unitA1",
			"unitA2",
			"unitA3",
			"unitA4",
			"unitA5",
			"unitA6",
			"unitA7",
			"unitA9"
		}),
		masterA = loadMasterData("masterA", player1, 8),
		player2 = loadPlayerData(player2, kBattleSideB, 12, {
			"unitB1",
			"unitB2",
			"unitB3",
			"unitB4",
			"unitB5",
			"unitB6",
			"unitB7",
			"unitB9"
		}),
		masterB = loadMasterData("masterB", player2, -8)
	}

	for k, v in pairs(BattleDebugConfig.unitsPos) do
		if math.abs(v) ~= 8 then
			battleData[k] = v > 0 and loadHeroData(k, player1, v) or loadHeroData(k, player2, v)
		end
	end

	local function getId(unitId)
		return units[unitId]
	end

	local function getInfo(unitId)
		return battleData[unitId]
	end

	local function getPos(unitId, x, y)
		return cell2Pos(battleData[unitId].cell, x, y)
	end

	function genActId(unitId)
		local unitInfo = battleData[unitId]

		if self._curAct then
			self._curAct = self._curAct + 1 or 1
		end

		local actId = "#cg" .. self._curAct

		unitInfo.act = actId

		return actId
	end

	local function getAct(unitId)
		return battleData[unitId].act
	end

	local function genSkillInfo(unitId, actId)
		return {
			act = actId
		}
	end

	guideThread:enableInput()

	local guideBuilder = CommonGuideBattleBuilder:new()

	function guideBuilder.processSpawnUnit(guideBuilder)
		local guideBuilder = guideBuilder

		for k, v in pairs(BattleDebugConfig.unitsSpawn) do
			guideBuilder = guideBuilder:spawnUnit(getInfo(v)):settleUnit(getInfo(v))
		end

		return guideBuilder
	end

	function guideBuilder.performSkillExtra(guideBuilder, skills, unit, skillconfig)
		local guideBuilder = guideBuilder

		for k, skill in pairs(skills) do
			guideBuilder = guideBuilder:performSkill(getId(unit), genPerform(skill.skill, getAct(unit), getPos(skillconfig.target) + {
				-1.5,
				0
			}, 200), {
				getId(skillconfig.target)
			}, {
				roles = {
					"target"
				},
				act = getAct(unit)
			})
			guideBuilder = guideBuilder:sleepForFrames(skill.delayFrame or 50)
		end

		return guideBuilder
	end

	function guideBuilder.playSkill(guideBuilder)
		local guideBuilder = guideBuilder

		for unit, skills in pairs(BattleDebugConfig.unitsSkills) do
			for skill, skillconfig in pairs(skills) do
				guideBuilder = skillconfig.skillextra and guideBuilder:startSkill(getId(unit), genSkillInfo(unit, genActId(unit))):performSkillExtra(skillconfig.skillextra, unit, skillconfig):endSkill(getId(unit), getAct(unit)):sleepForFrames(50) or guideBuilder:startSkill(getId(unit), genSkillInfo(unit, genActId(unit))):performSkill(getId(unit), genPerform(skillconfig.skill, getAct(unit), getPos(skillconfig.target) + {
					-1.5,
					0
				}, 200), {
					getId(skillconfig.target)
				}, {
					roles = {
						"target"
					},
					act = getAct(unit)
				}):endSkill(getId(unit), getAct(unit)):sleepForFrames(50)
			end
		end

		return guideBuilder
	end

	guideBuilder:startBattle(guideThread, battleContext):sleepForFrames(80):addObjectEvent(kBRGuideLine, "Prologue", true):addObjectEvent(kBRGuideLine, "TouchEnabled", false):addObjectEvent(kBRGuideLine, "HideRightButton"):addObjectEvent(kBRGuideLine, "HideCardArray"):addObjectEvent(kBRGuideLine, "HideEnergyBar"):addObjectEvent(kBRGuideLine, "HideTime"):addObjectEvent(kBRGuideLine, "ResumeTime", {}):addObjectEvent(kBRGuideLine, "HidePauseButton", {}):addPlayer(getInfo(player1)):addPlayer(getInfo(player2)):addObjectEvent(kBRGuideLine, "TimeScale", {
		timeScale = 1
	}):addObjectEvent(kBRGuideLine, "HideSkillButton"):processSpawnUnit():sleepForFrames(30):playSkill():endBattle(function()
		GameConfigs.debugHeroId = nil
		GameConfigs.debugModelId = nil
		GameConfigs.debugSkills = nil
	end):sleepForFrames(60):addObjectEvent(kBRGuideLine, "StartStory", {
		pause = true,
		leaveBattle = true,
		statisticPoint = "battle_guide_story_3",
		story = "blockstory00_1end"
	})

	return 0
end

function GuideBattleDebug:onExit(exitCode)
	print("onExit", exitCode)
end

return GuideBattleDebug
