-- chunkname: @/tmp/or_script/lua_compile/dm/battle/guide/GuideBattle1.lua

local Position = require("dm.battle.guide.GuideBattlePos")
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

local function fixedPos(zone, x, y)
	return Position({
		zone,
		x,
		y
	})
end

local GuideBattle1 = {}
local skillModelTime = 1000
local player1 = "player1"
local player2 = "player2"
local masterA = "masterA"
local masterB = "masterB"
local unitA1 = "unitA1"
local unitA2 = "unitA2"
local unitA3 = "unitA3"
local unitA4 = "unitA4"
local unitA5 = "unitA5"
local unitB1 = "unitB1"
local unitB2 = "unitB2"
local unitB3 = "unitB3"
local unitB4 = "unitB4"
local unitB5 = "unitB5"
local unitB6 = "unitB6"
local unitB7 = "unitB7"
local units = {
	unitB3 = "First_Battle_B03",
	masterB = "First_Battle_Master2",
	unitA3 = "First_Battle_A03",
	unitA4 = "First_Battle_A04",
	unitB4 = "First_Battle_B04",
	unitB5 = "First_Battle_B05",
	unitA1 = "First_Battle_A01",
	unitB6 = "First_Battle_B06",
	unitA2 = "First_Battle_A02",
	unitB7 = "First_Battle_B07",
	unitB2 = "First_Battle_B02",
	unitB1 = "First_Battle_B01",
	unitA5 = "First_Battle_A05",
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

		local config = ConfigReader:getRecordById("EnemyHero", unitId)

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
					maxHp = config.Hp,
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

		local config = ConfigReader:getRecordById("EnemyHero", unitId)

		assert(config ~= nil, "hero:" .. heroId .. " not exists!")

		return {
			maxAnger = 1000,
			infoId = heroId,
			id = unitId,
			model = config.RoleModel,
			cell = cellId,
			owner = owner,
			hp = config.Hp,
			maxHp = config.Hp,
			anger = config.RageBase,
			cost = config.Cost,
			roleType = BattleUnitType.kHero,
			anim = anim or {
				name = "spawn"
			},
			genre = config.Type,
			unique = config.UniqueSkill
		}
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

function GuideBattle1:main(guideThread, battleContext)
	local battleData = {
		player1 = loadPlayerData(player1, kBattleSideA, 12, {
			"",
			"",
			"",
			"",
			"unitA1",
			"unitA3",
			"unitA2",
			"unitA4",
			"unitA5"
		}),
		masterA = loadMasterData("masterA", player1, 8),
		player2 = loadPlayerData(player2, kBattleSideB, 10, {
			"unitB5",
			"unitB6",
			"unitB7"
		}),
		masterB = loadMasterData("masterB", player2, -8),
		unitB1 = loadHeroData("unitB1", player2, -1),
		unitB2 = loadHeroData("unitB2", player2, -2),
		unitB3 = loadHeroData("unitB3", player2, -4),
		unitB4 = loadHeroData("unitB4", player2, -6),
		unitB5 = loadHeroData("unitB5", player2, -4),
		unitB6 = loadHeroData("unitB6", player2, -2),
		unitB7 = loadHeroData("unitB7", player2, -6)
	}
	local handlers = {
		heroCard = function(guideBuilder, playerId, op, args)
			local idx = args.idx
			local cellId = tonumber(args.cellNo)
			local playerInfo = battleData[playerId]

			assert(playerInfo ~= nil, "player: " .. playerId .. " Not Exists")

			local card = playerInfo.cards[idx]

			assert(card ~= nil and card ~= 0, "Card Not Exists")

			local heroId = card.infoId

			playerInfo.energy = playerInfo.energy - card.cost

			guideBuilder:syncEnergy(playerId, {
				playerInfo.energy,
				0,
				0
			})
			guideBuilder:nextCard(playerId, popHeroCard(playerInfo, idx))

			local heroInfo = battleData[heroId]

			if not heroInfo then
				battleData[heroId] = loadHeroData(heroId, playerId, cellId * playerInfo.side)
				heroInfo = battleData[heroId]
			end

			guideBuilder:spawnUnit(heroInfo):sleepForFrames(1):settleUnit(heroInfo)

			return true
		end
	}
	local specialHandlers = {
		heroCard = function(guideBuilder, playerId, op, args)
			local idx = args.idx
			local cellId = tonumber(args.cellNo)
			local playerInfo = battleData[playerId]

			assert(playerInfo ~= nil, "player: " .. playerId .. " Not Exists")

			local card = playerInfo.cards[idx]

			assert(card ~= nil and card ~= 0, "Card Not Exists")

			local heroId = card.infoId

			playerInfo.energy = playerInfo.energy - card.cost

			guideBuilder:syncEnergy(playerId, {
				playerInfo.energy,
				0,
				0
			})

			local heroInfo = battleData[heroId]

			if not heroInfo then
				battleData[heroId] = loadHeroData(heroId, playerId, cellId * playerInfo.side)
				heroInfo = battleData[heroId]
			end

			guideBuilder:spawnUnit(heroInfo):sleepForFrames(1):settleUnit(heroInfo)

			return true
		end
	}

	local function defaultHandler(guideBuilder, playerId, op, args)
		Bdump("defaultHandler", args, op)

		return true
	end

	local function modifyEnergy(playerId, energy)
		local playerInfo = battleData[playerId]

		playerInfo.energy = playerInfo.energy + energy

		return {
			playerInfo.energy,
			0,
			0
		}
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

	local function genUniqueSkillInfo(unitId, actId)
		local unitInfo = battleData[unitId]

		return {
			model = "1#" .. unitInfo.unique,
			act = actId
		}
	end

	local function genSkillInfo(unitId, actId)
		return {
			act = actId
		}
	end

	local function doDamage(unitId, damage, crit, block)
		local damage = math.ceil(damage)
		local unitInfo = battleData[unitId]
		local oldhp = unitInfo.hp

		unitInfo.hp = math.max(unitInfo.hp - damage, 0)

		return {
			raw = damage,
			eft = oldhp - unitInfo.hp,
			val = unitInfo.hp,
			crit = crit,
			block = block,
			deadly = oldhp > 0 and unitInfo.hp <= 0
		}
	end

	local function doCure(unitId, cure)
		local cure = math.floor(cure)
		local unitInfo = battleData[unitId]
		local oldhp = unitInfo.hp

		unitInfo.hp = math.min(unitInfo.hp + cure, unitInfo.maxHp)

		return {
			raw = cure,
			eft = unitInfo.hp - oldhp,
			val = unitInfo.hp
		}
	end

	local function doHarmTargetView(unitId, targetIds)
		local unitInfo = battleData[unitId]
		local targets = {}

		for k, v in ipairs(targetIds) do
			local pos = getPos(v)

			targets[k] = {
				zone = pos[1],
				x = pos[2],
				y = pos[3]
			}
		end

		return getId(unitId), {
			act = unitInfo.act,
			targets = targets
		}
	end

	local function doFocus(unitId, destination, scale, duration)
		local unitInfo = battleData[unitId]

		return getId(unitId), {
			act = unitInfo.act,
			dst = destination,
			scale = scale,
			dur = duration
		}
	end

	guideThread:enableInput()

	local guideBuilder = CommonGuideBattleBuilder:new()

	guideBuilder:startBattle(guideThread, battleContext):addObjectEvent(kBRGuideLine, "Prologue", true):addObjectEvent(kBRGuideLine, "TouchEnabled", false):addObjectEvent(kBRGuideLine, "HideRightButton"):addObjectEvent(kBRGuideLine, "HideCardArray"):addObjectEvent(kBRGuideLine, "HideEnergyBar"):addObjectEvent(kBRGuideLine, "HideTime"):addObjectEvent(kBRGuideLine, "ResumeTime", {}):addObjectEvent(kBRGuideLine, "HidePauseButton", {}):addPlayer(getInfo(player1)):addPlayer(getInfo(player2)):spawnUnit(getInfo(masterA)):spawnUnit(getInfo(masterB)):addObjectEvent(kBRGuideLine, "TimeScale", {
		timeScale = 1
	}):sleepForTime(100):addObjectEvent(kBRGuideLine, "HideSkillButton"):sleepForTime(200):addObjectEvent(kBRGuideLine, "StartStory", {
		pause = true,
		statisticPoint = "battle_guide_story_0",
		story = "blockstory00_1start"
	}):sleepForTime(300):sleepForFrames(10):spawnUnit(getInfo(unitB1)):spawnUnit(getInfo(unitB2)):spawnUnit(getInfo(unitB3)):spawnUnit(getInfo(unitB4)):sleepForFrames(1):settleUnit(getInfo(unitB1)):settleUnit(getInfo(unitB2)):settleUnit(getInfo(unitB3)):settleUnit(getInfo(unitB4)):sleepForFrames(20):startSkill(getId(unitB1), genSkillInfo(unitB1, genActId(unitB1))):performSkill(getId(unitB1), genPerform("skill1", getAct(unitB1), getPos("masterA") + {
		-1.5,
		0
	}, 200), {
		getId(masterA)
	}, {
		roles = {
			"target"
		},
		act = getAct(unitB1)
	}):sleepForFrames(18):damageUnit(getId(masterA), doDamage(masterA, 780), getAct(unitB1)):sleepForFrames(10):endSkill(getId(unitB1), getAct(unitB1)):startSkill(getId(unitB3), genSkillInfo(unitB3, genActId(unitB3))):performSkill(getId(unitB3), genPerform("skill1", getAct(unitB3), getPos("masterA") + {
		-1.5,
		0
	}, 200), {
		getId(masterA)
	}, {
		roles = {
			"target"
		},
		act = getAct(unitB3)
	}):sleepForFrames(18):damageUnit(getId(masterA), doDamage(masterA, 745), getAct(unitB3)):sleepForFrames(10):endSkill(getId(unitB3), getAct(unitB3)):sleepForFrames(10):addObjectEvent(kBRGuideLine, "StartStory", {
		pause = true,
		statisticPoint = "battle_guide_story_1",
		story = "blockstory00_1mid"
	}):sleepForFrames(1):addObjectEvent(kBRGuideLine, "ShowCardArray"):addObjectEvent(kBRGuideLine, "ShowEnergyBar"):sleepForFrames(1):nextCard(player1, popHeroCard(getInfo(player1), 1)):sleepForFrames(4):nextCard(player1, popHeroCard(getInfo(player1), 2)):sleepForFrames(4):nextCard(player1, popHeroCard(getInfo(player1), 3)):sleepForFrames(10):addObjectEvent(kBRGuideLine, "StartGuide", {
		cell = 2,
		autoRotation = true,
		effectStyle = "drag_auto",
		statisticPoint = "battle_guide_startGuide_1",
		cardIndex = 1,
		style = "slideCard",
		pause = true,
		duration = 3,
		textRefpt = {
			x = 0.7,
			y = 0.4
		}
	}):processPlayerInput(specialHandlers, defaultHandler):sleepForFrames(10):startSkill(getId(unitA1), genUniqueSkillInfo(unitA1, genActId(unitA1))):sleepForTime(skillModelTime):syncRage(getId(unitA1), {
		anger = 0
	}):performSkill(getId(unitA1), genPerform("skill3", getAct(unitA1), getPos("unitB2") + {
		-1.5,
		0
	}, 200), {
		getId(unitB2),
		getId(unitB2),
		getId(unitB3)
	}, {
		roles = {
			"target"
		},
		act = getAct(unitA1)
	}):harmTargetView(doHarmTargetView(unitA1, {
		unitB2
	})):focus(doFocus(unitA1, getPos(unitB2), 1.13, 80)):sleepForFrames(35):damageUnit(getId(unitB2), doDamage(unitB2, 1980), getAct(unitA1)):sleepForFrames(10):addObjectEvent(getId(unitB2), "GuideDie"):sleepForFrames(20):endSkill(getId(unitA1), getAct(unitA1)):syncRage(getId(masterB), {
		anger = 250
	}):dieUnit(getId(unitB2)):sleepForFrames(15):addObjectEvent(kBRGuideLine, "StartGuide", {
		cell = 4,
		autoRotation = true,
		effectStyle = "drag_auto",
		statisticPoint = "battle_guide_startGuide_2",
		cardIndex = 2,
		style = "slideCard",
		pause = true,
		duration = 3,
		textRefpt = {
			x = 0.7,
			y = 0.4
		}
	}):processPlayerInput(specialHandlers, defaultHandler):sleepForFrames(10):startSkill(getId(unitA3), genUniqueSkillInfo(unitA3, genActId(unitA3))):sleepForTime(skillModelTime):syncRage(getId(unitA3), {
		anger = 0
	}):performSkill(getId(unitA3), genPerform("skill3", getAct(unitA3), getPos("unitB1") + {
		-1.5,
		0
	}, 200), {
		getId(unitB1),
		getId(unitB3)
	}, {
		roles = {
			"target"
		},
		act = getAct(unitA3)
	}):harmTargetView(doHarmTargetView(unitA3, {
		unitB1,
		unitB3
	})):focus(doFocus(unitA3, getPos(unitB1, nil, 2), 1.13, 80)):sleepForFrames(36):damageUnit(getId(unitB1), doDamage(unitB1, 2430), getAct(unitA3)):damageUnit(getId(unitB3), doDamage(unitB3, 2559), getAct(unitA3)):sleepForFrames(6):addObjectEvent(getId(unitB1), "GuideDie"):addObjectEvent(getId(unitB3), "GuideDie"):sleepForFrames(20):endSkill(getId(unitA3), getAct(unitA3)):syncRage(getId(masterB), {
		anger = 750
	}):dieUnit(getId(unitB1)):dieUnit(getId(unitB3)):sleepForFrames(15):addObjectEvent(kBRGuideLine, "StartGuide", {
		cell = 9,
		autoRotation = true,
		effectStyle = "drag_auto",
		statisticPoint = "battle_guide_startGuide_3",
		cardIndex = 3,
		style = "slideCard",
		pause = true,
		duration = 3,
		textRefpt = {
			x = 0.7,
			y = 0.4
		}
	}):processPlayerInput(specialHandlers, defaultHandler):sleepForFrames(10):startSkill(getId(unitA2), genUniqueSkillInfo(unitA2, genActId(unitA2))):sleepForTime(skillModelTime):syncRage(getId(unitA2), {
		anger = 0
	}):performSkill(getId(unitA2), genPerform("skill3", getAct(unitA2), getPos("unitB4") + {
		-1.5,
		0
	}, 200), {
		getId(unitB4)
	}, {
		roles = {
			"target"
		},
		act = getAct(unitA2)
	}):harmTargetView(doHarmTargetView(unitA2, {
		unitB4
	})):focus(doFocus(unitA2, getPos(unitB4, nil, 2), 1.13, 80)):sleepForFrames(15):damageUnit(getId(unitB4), doDamage(unitB4, 563), getAct(unitA2)):sleepForFrames(3):damageUnit(getId(unitB4), doDamage(unitB4, 572), getAct(unitA2)):sleepForFrames(3):damageUnit(getId(unitB4), doDamage(unitB4, 559), getAct(unitA2)):sleepForFrames(15):damageUnit(getId(unitB4), doDamage(unitB4, 568), getAct(unitA2)):sleepForFrames(15):damageUnit(getId(unitB4), doDamage(unitB4, 1530), getAct(unitA2)):syncRage(getId(unitB4), {
		anger = 1000
	}):sleepForFrames(10):endSkill(getId(unitA2), getAct(unitA2)):dieUnit(getId(unitB4)):sleepForFrames(10):startSkill(getId(masterB), genSkillInfo(masterB, genActId(masterB))):performSkill(getId(masterB), genPerform("skill3", getAct(masterB), getPos("masterA") + {
		-3,
		0
	}, 200), {
		getId(masterA)
	}, {
		roles = {
			"target"
		},
		act = getAct(masterB)
	}):syncRage(getId(masterB), {
		anger = 0
	}):sleepForFrames(3):sleepForFrames(22):addObjectEvent(kBRGuideLine, "RockScreen"):addObjectEvent(kBRGuideLine, "RockScreen"):damageUnit(getId(unitA3), doDamage(unitA3, 6280, true), getAct(masterB)):damageUnit(getId(unitA2), doDamage(unitA2, 6333, true), getAct(masterB)):damageUnit(getId(unitA1), doDamage(unitA1, 5706, true), getAct(masterB)):damageUnit(getId(masterA), doDamage(masterA, 8132, true), getAct(masterB)):addObjectEvent(kBRGuideLine, "TimeScale", {
		timeScale = 0.5
	}):addObjectEvent(getId(unitA1), "GuideThrown", {
		-3,
		3
	}):addObjectEvent(getId(masterA), "GuideThrown", {
		-3,
		3
	}):addObjectEvent(getId(unitA2), "GuideThrown", {
		-3,
		3
	}):addObjectEvent(getId(unitA3), "GuideThrown", {
		-3,
		3
	}):sleepForFrames(15):addObjectEvent(kBRGuideLine, "TimeScale", {
		timeScale = 1
	}):syncRage(getId(unitA1), {
		anger = 200
	}):syncRage(getId(masterA), {
		anger = 200
	}):syncRage(getId(unitA2), {
		anger = 200
	}):syncRage(getId(unitA3), {
		anger = 200
	}):endSkill(getId(masterB), getAct(masterB)):sleepForTime(200):addObjectEvent(getId(unitA1), "GuideGoBack", {
		1,
		2,
		2,
		800
	}):addObjectEvent(getId(unitA3), "GuideGoBack", {
		1,
		3,
		1,
		800
	}):addObjectEvent(getId(unitA2), "GuideGoBack", {
		1,
		4,
		3,
		800
	}):addObjectEvent(getId(masterA), "GuideGoBack", {
		1,
		4,
		2,
		800
	}):sleepForFrames(20):sleepForFrames(10):spawnUnit(getInfo(unitB6)):sleepForFrames(1):settleUnit(getInfo(unitB6)):sleepForFrames(10):startSkill(getId(unitB6), genSkillInfo(unitB6, genActId(unitB6))):performSkill(getId(unitB6), genPerform("skill1", getAct(unitB6), getPos("unitA1") + {
		-1.8,
		0
	}, 200), {
		getId(unitA1)
	}, {
		roles = {
			"target"
		},
		act = getAct(unitB6)
	}):sleepForFrames(12):damageUnit(getId(unitA1), doDamage(unitA1, 1120), getAct(unitB6)):sleepForFrames(10):endSkill(getId(unitB6), getAct(unitB6)):sleepForFrames(10):startSkill(getId(unitA1), genSkillInfo(unitA1, genActId(unitA1))):performSkill(getId(unitA1), genPerform("skill1", getAct(unitA1), getPos("unitB6") + {
		-1,
		0
	}, 200), {
		getId(unitB6)
	}, {
		roles = {
			"target"
		},
		act = getAct(unitA1)
	}):sleepForFrames(13):syncRage(getId(unitA1), {
		anger = 400
	}):damageUnit(getId(unitB6), doDamage(unitB6, 1029), getAct(unitA1)):sleepForFrames(10):endSkill(getId(unitA1), getAct(unitA1)):spawnUnit(getInfo(unitB5)):sleepForFrames(1):settleUnit(getInfo(unitB5)):sleepForFrames(10):startSkill(getId(unitB5), genSkillInfo(unitB5, genActId(unitB5))):performSkill(getId(unitB5), genPerform("skill1", getAct(unitB5), getPos("unitA3") + {
		-3,
		0
	}, 200), {
		getId(unitA3)
	}, {
		roles = {
			"target"
		},
		act = getAct(unitB5)
	}):sleepForFrames(13):damageUnit(getId(unitA3), doDamage(unitA3, 1211), getAct(unitB5)):sleepForFrames(5):endSkill(getId(unitB5), getAct(unitB5)):sleepForFrames(10):startSkill(getId(unitA3), genSkillInfo(unitA3, genActId(unitA3))):performSkill(getId(unitA3), genPerform("skill1", getAct(unitA3), getPos("unitB5") + {
		-1.3,
		0
	}, 200), {
		getId(unitB5)
	}, {
		roles = {
			"target"
		},
		act = getAct(unitA3)
	}):sleepForFrames(13):syncRage(getId(unitA3), {
		anger = 400
	}):damageUnit(getId(unitB5), doDamage(unitB5, 1374), getAct(unitA3)):sleepForFrames(10):endSkill(getId(unitA3), getAct(unitA3)):spawnUnit(getInfo(unitB7)):sleepForFrames(1):settleUnit(getInfo(unitB7)):sleepForFrames(10):startSkill(getId(unitB7), genSkillInfo(unitB7, genActId(unitB7))):performSkill(getId(unitB7), genPerform("skill1", getAct(unitB7), getPos("unitA2") + {
		-1.6,
		0
	}, 200), {
		getId(unitA2)
	}, {
		roles = {
			"target"
		},
		act = getAct(unitB7)
	}):sleepForFrames(10):syncRage(getId(unitA2), {
		anger = 400
	}):damageUnit(getId(unitA2), doDamage(unitA2, 939), getAct(unitB7)):sleepForFrames(10):endSkill(getId(unitB7), getAct(unitB7)):sleepForFrames(10):startSkill(getId(unitA2), genSkillInfo(unitA2, genActId(unitA2))):performSkill(getId(unitA2), genPerform("skill1", getAct(unitA2), getPos("unitB7") + {
		-1,
		0
	}, 200), {
		getId(unitB7)
	}, {
		roles = {
			"target"
		},
		act = getAct(unitA2)
	}):sleepForFrames(13):damageUnit(getId(unitB7), doDamage(unitB7, 1635), getAct(unitA2)):sleepForFrames(10):endSkill(getId(unitA2), getAct(unitA2)):sleepForFrames(30):addObjectEvent(kBRGuideLine, "StartStory", {
		pause = true,
		statisticPoint = "battle_guide_story_2",
		story = "blockstory00_1mid2"
	}):sleepForFrames(1):syncEnergy(player1, modifyEnergy(player1, 3)):sleepForFrames(4):syncEnergy(player1, modifyEnergy(player1, 3)):sleepForFrames(4):syncEnergy(player1, modifyEnergy(player1, 4)):nextCard(player1, popHeroCard(getInfo(player1), 1)):sleepForFrames(4):nextCard(player1, popHeroCard(getInfo(player1), 2)):sleepForFrames(20):addObjectEvent(kBRGuideLine, "StartGuide", {
		cell = 7,
		autoRotation = true,
		effectStyle = "drag_auto",
		statisticPoint = "battle_guide_startGuide_4",
		cardIndex = 1,
		style = "slideCard",
		pause = true,
		duration = 3,
		textRefpt = {
			x = 0.7,
			y = 0.4
		}
	}):processPlayerInput(handlers, defaultHandler):sleepForFrames(10):startSkill(getId(unitA4), genUniqueSkillInfo(unitA4, genActId(unitA4))):sleepForTime(skillModelTime):performSkill(getId(unitA4), genPerform("skill3", getAct(unitA4), fixedPos(0, 0, 2), 200), {
		getId(unitB1)
	}, {
		roles = {
			"target"
		},
		act = getAct(unitA4)
	}):focus(doFocus(unitA4, fixedPos(0, 0, 2), 1.13, 80)):syncRage(getId(unitA4), {
		anger = 0
	}):sleepForFrames(30):addObjectEvent(getId(masterA), "GuideResume"):addObjectEvent(getId(unitA2), "GuideResume"):addObjectEvent(getId(unitA3), "GuideResume"):addObjectEvent(getId(unitA1), "GuideResume"):cureUnit(getId(unitA1), doCure(unitA1, 10390), getAct(unitA4)):cureUnit(getId(unitA2), doCure(unitA2, 10390), getAct(unitA4)):cureUnit(getId(unitA3), doCure(unitA3, 10390), getAct(unitA4)):cureUnit(getId(masterA), doCure(masterA, 10390), getAct(unitA4)):sleepForFrames(28):endSkill(getId(unitA4), getAct(unitA4)):sleepForFrames(15):addObjectEvent(kBRGuideLine, "StartGuide", {
		cell = 5,
		autoRotation = true,
		effectStyle = "drag_auto",
		statisticPoint = "battle_guide_startGuide_5",
		cardIndex = 2,
		style = "slideCard",
		pause = true,
		duration = 3,
		textRefpt = {
			x = 0.7,
			y = 0.4
		}
	}):processPlayerInput(handlers, defaultHandler):sleepForFrames(10):startSkill(getId(unitA5), genUniqueSkillInfo(unitA5, genActId(unitA5))):sleepForTime(skillModelTime):performSkill(getId(unitA5), genPerform("skill3", getAct(unitA5), getPos("unitB6", nil, 2) + {
		-1.5,
		0
	}, 200), {
		getId(unitB6),
		getId(masterB)
	}, {
		roles = {
			"target"
		},
		act = getAct(unitA5)
	}):harmTargetView(doHarmTargetView(unitA5, {
		unitB6,
		masterB
	})):focus(doFocus(unitA5, getPos(unitB6, nil, 2), 1.13, 80)):syncRage(getId(unitA5), {
		anger = 0
	}):sleepForFrames(20):syncRage(getId(masterB), {
		anger = 200
	}):damageUnit(getId(masterB), doDamage(masterB, 4103, true), getAct(unitA5)):damageUnit(getId(unitB6), doDamage(unitB6, 5420, true), getAct(unitA5)):sleepForFrames(10):sleepForFrames(20):endSkill(getId(unitA5), getAct(unitA5)):sleepForFrames(10):addObjectEvent(kBRGuideLine, "StartStory", {
		pause = true,
		leaveBattle = true,
		statisticPoint = "battle_guide_story_3",
		story = "blockstory00_1end"
	})

	return 0
end

function GuideBattle1:onExit(exitCode)
	print("onExit", exitCode)
end

return GuideBattle1
