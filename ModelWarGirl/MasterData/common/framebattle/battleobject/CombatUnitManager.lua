-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\FrameBattle\\BattleObject\\CombatUnitManager.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local CombatUnit = require("Common/FrameBattle/BattleObject/CombatUnit")
local PetUnit = require("Common/FrameBattle/BattleObject/PetUnit")
local CombatResultRecorder = require("Common/FrameBattle/BattleObject/CombatResultRecorder")
local ResBattleLevelConfig = require("ClientData/ResBattleLevelConfig")
local ResBattleSuppress = require("ClientData/ResBattleSuppress")
local ResBattleSuppressLevel = require("ClientData/ResBattleSuppressLevel")
local ResStageTimeSuppress = require("ClientData/ResStageTimeSuppress")
local ResStage = require("ClientData/ResStage")
local ResRelics = require("ClientData/ResRelics")
local ResHookMisc = require("ClientData/ResHookMisc")
local ResBattleEnhance = require("ClientData/ResBattleEnhance")
local ResBattleMonsterWaves = require("ClientData/ResBattleMonsterWaves")
local BattleMiscConfig = require("Common/BattleMiscConfig")
local BattleTrapManager = require("Common/FrameBattle/BattleObject/BattleTrapManager")
local ResMonster = require("ClientData/ResMonster")
local BattleWeatherManager = require("Common/FrameBattle/BattleObject/BattleWeatherManager")
local ResStageVipTimeSuppress = require("ClientData/ResStageVipTimeSuppress")
local ResOpActTowerBuff = require("ClientData/ResOpActTowerBuff")
local ResRentBattleConfig = require("ClientData/ResRentBattleConfig")
local ResBattleTarget = require("ClientData/ResBattleTarget")
local ResClanBattleConfig = require("ClientData/ResClanBattleConfig")
local ResClanBattleLayer = require("ClientData/ResClanBattleLayer")
local ResStageReturnSuppress = require("ClientData/ResStageReturnSuppress")
local ResBattleCoefficient = require("ClientData/ResBattleCoefficient")
local ResNewMazeLayerAward = require("ClientData/ResNewMazeLayerAward")
local ResNewMazeRelic = require("ClientData/ResNewMazeRelic")
local ResNewMazeHalo = require("ClientData/ResNewMazeHalo")
local ResNewMazeDeBuff = require("ClientData/ResNewMazeDeBuff")
local ResNewMazeFetters = require("ClientData/ResNewMazeFetters")
local ResPetMazeQuality = require("ClientData/ResPetMazeQuality")
local ResPetMazeLayer = require("ClientData/ResPetMazeLayer")
local ResPetRune = require("ClientData/ResPetRune")
local ResPetGifted = require("ClientData/ResPetGifted")
local PropHelper = require("Common/FrameBattle/BattleObject/PropHelper")
local CachedNebs = {}
local LINE_NUM = 100

local function getMoveGridNebs(LR_LEN, UD_LEN, oddShorter)
	if CachedNebs[LR_LEN] then
		return CachedNebs[LR_LEN]
	end

	local gridNebs = {}

	for line = 1, UD_LEN do
		local coordY = line - 1
		local lineStart = coordY * LINE_NUM
		local extraGrid = coordY % 2

		if oddShorter then
			extraGrid = extraGrid == 1 and 0 or 1
		end

		for col = 1, LR_LEN + extraGrid do
			local gridNum = col - 1 + lineStart
			local nebs = {}

			if col > 1 then
				table.insert(nebs, gridNum - 1)
			end

			if col < LR_LEN + extraGrid then
				table.insert(nebs, gridNum + 1)
			end

			if extraGrid == 1 then
				if line > 1 then
					local downStart = (line - 2) * LINE_NUM

					if col > 1 then
						table.insert(nebs, downStart + col - 2)
					end

					if col < LR_LEN + extraGrid then
						table.insert(nebs, downStart + col - 1)
					end
				end

				if line < UD_LEN then
					local upStart = line * LINE_NUM

					if col > 1 then
						table.insert(nebs, upStart + col - 2)
					end

					if col < LR_LEN + extraGrid then
						table.insert(nebs, upStart + col - 1)
					end
				end
			else
				if line > 1 then
					local downStart = (line - 2) * LINE_NUM

					table.insert(nebs, downStart + col - 1)
					table.insert(nebs, downStart + col)
				end

				if line < UD_LEN then
					local upStart = line * LINE_NUM

					table.insert(nebs, upStart + col - 1)
					table.insert(nebs, upStart + col)
				end
			end

			gridNebs[gridNum] = nebs
		end
	end

	CachedNebs[LR_LEN] = gridNebs

	return gridNebs
end

local function CoordToGrid(coordX, coordY)
	return math.floor(coordX + 0.5) + coordY * LINE_NUM
end

local function GridToCoord(gridNum, oddShorter)
	if gridNum then
		local coordY = math.floor(gridNum / LINE_NUM)
		local extra = coordY % 2

		if oddShorter then
			extra = extra == 1 and 0 or 1
		end

		local coordX = gridNum % LINE_NUM - extra * 0.5

		return {
			coordX,
			coordY
		}
	else
		return nil
	end
end

local strClassName = "CombatUnitManager"
local CombatUnitManager = Class(strClassName)

function CombatUnitManager:ctor(matrixInstance, initInfo)
	self.matrixInstance = matrixInstance
	self.objects = {}
	self.orderObjects = {}
	self.outOfPosObjects = {}
	self.pets = {}
	self.activePets = {}
	self.tickAllUnits = {
		self.orderObjects,
		self.outOfPosObjects
	}
	self.playerTickList = {}
	self.countTime = initInfo.battleConfig.maxTime or BattleConst.MATRIX_DEFAULT_MAX_TIME
	self.framePerSec = 1000 / self.matrixInstance.frameLength
	self.curCountFrame = math.floor((self.countTime + 1) * self.framePerSec)
	self.maxTime = self.countTime
	self.maxFrame = self.curCountFrame
	self.realFrameNumber = 0
	self.nextPauseEnd = BattleConst.MATRIX_ENTITY_PREPARE_FRAME

	self:initBattleConfig(initInfo.battleConfig, initInfo)
	self:initBattleSuppress(initInfo.battleConfig, initInfo.entityDict, initInfo.speData)
	self:initObjects(initInfo.entityDict, self.matrixInstance.frameLength, initInfo)
	self:handleSpecBattle()
	self:initBattleTarget()
end

function CombatUnitManager:destroy()
	return
end

function CombatUnitManager:clearMonsters()
	for objId, unit in pairs(self.objects) do
		if unit.camp == BattleConst.CAMP_MONSTER then
			self:addOutput(BattleConst.MATRIX_EVENT_DEL_ENTITY, nil, {
				objId
			})
			unit:destroy()

			self.objects[objId] = nil

			for index, tid in ipairs(self.orderObjects) do
				if tid == objId then
					table.remove(self.orderObjects, index)

					break
				end
			end
		end
	end
end

function CombatUnitManager:enterOutOfPos(entity)
	for index, tid in ipairs(self.orderObjects) do
		if tid == entity.id then
			table.remove(self.orderObjects, index)

			break
		end
	end

	if entity.camp == BattleConst.CAMP_PLAYER then
		for index, object in ipairs(self.playerTickList) do
			if object == entity then
				table.remove(self.playerTickList, index)

				break
			end
		end
	end

	table.insert(self.outOfPosObjects, entity.id)

	local teamAllDead = true

	for _, eid in ipairs(self.orderObjects) do
		local obj = self.objects[eid]

		if obj.camp == entity.camp and obj:isAlive() then
			teamAllDead = false

			break
		end
	end

	if teamAllDead then
		self:onOneTeamAllDead(entity)
	end
end

function CombatUnitManager:initBattleConfig(battleConfig, initInfo)
	self.suppressDataMonsterState = nil
	self.playerEnhanceBuffs = {}
	self.monsterEnhanceBuffs = {}
	self.playerEnhanceEvents = {}
	self.monsterEnhanceEvents = {}

	if initInfo.speData then
		self.campBuffData = initInfo.speData.campBuffData or {}
	else
		self.campBuffData = {}
	end

	self.battleType = initInfo.battleType

	if self.battleType and BattleConst.PVP_BATTLE_DICT[self.battleType] then
		self.isPvp = 1
	else
		self.isPvp = 0
	end

	self.initInfo = initInfo
	self.battleConfig = battleConfig
	self.leftDir = initInfo.leftDir
	self.upDir = initInfo.upDir
	self.LR_LEN = initInfo.LR_LEN
	self.max_lr = self.LR_LEN - 0.5
	self.min_lr = -0.5
	self.UD_LEN = initInfo.UD_LEN
	self.max_ud = self.UD_LEN - 1
	self.min_ud = 0
	self.oddShorter = initInfo.ODD_SHORTER
	self.GridConfig = initInfo.GridConfig or BattleMiscConfig.NORMAL_POS_CONFIG
	self.POS_CONFIG = self.GridConfig.PosToCoordXY
	self.centerPoint = initInfo.centerPoint
	self.gridSize = BattleConst.GRID_SIZE
	self.LEFT_CAMP = BattleConst.CAMP_PLAYER

	local speData = initInfo.speData

	if speData and speData.mazeRelics then
		self.mazeSlics = speData.mazeRelics
	end

	self.suppressExtraLevel = 0

	if speData and speData.STBuffs then
		self.STBuffs = speData.STBuffs

		for _, buffId in ipairs(self.STBuffs) do
			if ResOpActTowerBuff[buffId] and ResOpActTowerBuff[buffId].suppress_level then
				self.suppressExtraLevel = self.suppressExtraLevel + ResOpActTowerBuff[buffId].suppress_level
			end
		end
	end

	local monsterLevelIndex = BattleConst.DEFAULT_MONSTER_DYNAMIC_INDEX

	if self.battleConfig.monster_level_idx then
		monsterLevelIndex = self.battleConfig.monster_level_idx
	end

	if speData and ResBattleLevelConfig[monsterLevelIndex] and ResBattleLevelConfig[monsterLevelIndex][speData.monsterLevel] then
		self.monsterPropRate = 1 + (ResBattleLevelConfig[monsterLevelIndex][speData.monsterLevel].monster_rate or 0) / 10000
		self.monsterMhpPropRate = 1 + (ResBattleLevelConfig[monsterLevelIndex][speData.monsterLevel].monster_mhp_rate or 0) / 10000

		if speData.mazeEnhanceRate then
			self.monsterPropRate = self.monsterPropRate * speData.mazeEnhanceRate
			self.monsterMhpPropRate = self.monsterMhpPropRate * speData.mazeEnhanceRate
		end

		self.monsterLevel = speData.monsterLevel
	elseif speData and (speData.rentData or speData.clanData or speData.newMazeData or speData.petMazeData) then
		self.monsterPropRate = 1
		self.monsterMhpPropRate = 1
		self.monsterLevel = battleConfig.monster_level or 1

		if speData.rentData then
			local stageConfig = speData.rentData.stageConfig

			if stageConfig and ResRentBattleConfig[battleConfig.id] then
				self.monsterLevel = stageConfig.show_level

				local area = stageConfig.area
				local offset = stageConfig.offset_num
				local rentConfig = ResRentBattleConfig[battleConfig.id]

				if rentConfig and rentConfig.battle_area and rentConfig.battle_area[area] then
					local value = rentConfig.battle_area[area].value
					local rate = rentConfig.battle_area[area].rate

					self.monsterPropRate = value * math.pow(rate, offset)
					self.monsterMhpPropRate = value * math.pow(rate, offset)
				end
			end
		elseif speData.clanData then
			local layerData = ResClanBattleLayer[speData.clanData.layer]
			local clanConfig = ResClanBattleConfig[battleConfig.id]

			if layerData and clanConfig then
				self.monsterLevel = layerData.show_level

				local area = layerData.area
				local offset = layerData.offset_num

				if clanConfig.battle_area and clanConfig.battle_area[area] then
					local value = clanConfig.battle_area[area].value
					local rate = clanConfig.battle_area[area].rate

					self.monsterPropRate = value * math.pow(rate, offset) * (1 + (speData.clanData.atkRate or 0))
					self.monsterMhpPropRate = value * math.pow(rate, offset) * (1 + (speData.clanData.mhpRate or 0))
				end
			end
		elseif speData.newMazeData then
			local tmpID = speData.newMazeData.tmpID
			local level = speData.newMazeData.level
			local layer = speData.newMazeData.layer

			self.monsterLevel = 220

			if ResNewMazeLayerAward[tmpID] and ResNewMazeLayerAward[tmpID][level] and ResNewMazeLayerAward[tmpID][level][layer] then
				local area = ResNewMazeLayerAward[tmpID][level][layer].level_area
				local offset = ResNewMazeLayerAward[tmpID][level][layer].level_offset

				self.monsterPropRate, self.monsterMhpPropRate = self:getBattleCoefficient(battleConfig.id, area, offset)
				self.monsterLevel = ResNewMazeLayerAward[tmpID][level][layer].monster_level
			end

			self.newMazeRelics = speData.newMazeRelics
			self.newMazeHalos = speData.newMazeHalos
			self.newMazeBuffs = speData.newMazeBuffs
			self.newMazeFetters = speData.newMazeFetters
		elseif speData.petMazeData then
			local petMazeData = speData.petMazeData
			local level = petMazeData.level

			if petMazeData.bossId and petMazeData.bossId > 0 then
				local layerConfig = ResPetMazeLayer[level]

				if layerConfig then
					local area = layerConfig.level_area
					local offset = layerConfig.level_offset

					self.monsterPropRate, self.monsterMhpPropRate = self:getBattleCoefficient(battleConfig.id, area, offset)
				end
			elseif petMazeData.stageId and petMazeData.stageId > 0 then
				local quality = petMazeData.quality

				if ResPetMazeQuality[level] and ResPetMazeQuality[level][quality] then
					local qualityConfig = ResPetMazeQuality[level][quality]
					local area = qualityConfig.level_area
					local offset = qualityConfig.level_offset

					self.monsterPropRate, self.monsterMhpPropRate = self:getBattleCoefficient(battleConfig.id, area, offset)
				end
			end
		end
	else
		self.monsterPropRate = 1 + (battleConfig.monster_rate or 0) / 10000
		self.monsterMhpPropRate = 1 + (battleConfig.monster_mhp_rate or 0) / 10000
		self.monsterLevel = battleConfig.monster_level or 1
	end

	self.playerEnterState = {}

	for _, sId in ipairs(battleConfig.player_enter_state or {}) do
		table.insert(self.playerEnterState, sId)
	end

	if speData then
		for _, sId in ipairs(speData.serverBuff or {}) do
			table.insert(self.playerEnterState, sId)
		end

		self.monsterHps = speData.monsterHps or {}
	else
		self.monsterHps = {}
	end

	self.specBattleType = initInfo.BATTLE_SPEC
	self.monsterEnterDict = {}
	self.monsterWaveDict = {}

	if self.battleConfig.traps then
		self.trapMgr = BattleTrapManager(self, self.battleConfig.traps)
	end

	self.weatherManager = BattleWeatherManager(self, self.battleConfig)

	self:checkBattleConfigCondition(initInfo.entityDict)
end

function CombatUnitManager:getBattleCoefficient(battleId, area, offset)
	local monsterPropRate = 1
	local monsterMhpPropRate = 1

	if ResBattleCoefficient[battleId] then
		local battleCoefficientData = ResBattleCoefficient[battleId]
		local value = battleCoefficientData.battle_area[area].value
		local rate = battleCoefficientData.battle_area[area].rate

		monsterPropRate = value * math.pow(rate, offset)
		monsterMhpPropRate = value * math.pow(rate, offset)
	end

	return monsterPropRate, monsterMhpPropRate
end

function CombatUnitManager:checkBattleConfigCondition(entityDict)
	if self.battleConfig and self.battleConfig.condition_type then
		local enable = false

		if self.battleConfig.condition_type == 1 and self.battleConfig.condition_args then
			local needCamp = tonumber(self.battleConfig.condition_args[1])
			local needNumber = tonumber(self.battleConfig.condition_args[2])

			if needCamp and needNumber then
				local playerNum, monsterNum = utils.getBattleObjMaxNum(entityDict, "camp", needCamp)

				if playerNum < needNumber then
					enable = true
				end
			end
		elseif self.battleConfig.condition_type == 2 and self.battleConfig.condition_args then
			local needNumber = tonumber(self.battleConfig.condition_args[1])

			if needNumber then
				local playerNum, monsterNum = utils.getBattleObjMaxNum(entityDict, "career", Const.CAREER_TYPE.SUPPORT)

				if needNumber <= playerNum then
					enable = true
				end
			end
		elseif self.battleConfig.condition_type == 3 then
			enable = true
		end

		if enable and self.battleConfig.condition_state then
			local state_id = tonumber(self.battleConfig.condition_state[1])
			local state_level = tonumber(self.battleConfig.condition_state[2])

			if state_id then
				table.insert(self.monsterEnhanceBuffs, {
					state_id,
					state_level or 1
				})
			end
		end
	end
end

function CombatUnitManager:initBattlePetRuneAttr()
	self.petCommonAttrs = {}
	self.petExclusiveAttrs = {}
	self.heroExtraConditionStates = {}

	for _, pet in ipairs(self.activePets) do
		local props = {}
		local petObj = pet.pet

		for _, cRune in ipairs(petObj.commonRune or {}) do
			local rId = cRune.resid
			local rData = ResPetRune[rId]

			if rData then
				for _, aInfo in ipairs(rData.attr or {}) do
					local attrName = BattleConst.PROP_TYPE_CONFIG[aInfo.type_id]

					props[attrName] = (props[attrName] or 0) + aInfo.num
				end

				if rData.state_id then
					if pet.camp == BattleConst.CAMP_PLAYER then
						table.insert(self.playerEnhanceBuffs, {
							rData.state_id,
							rData.level or 1
						})
					else
						table.insert(self.monsterEnhanceBuffs, {
							rData.state_id,
							rData.level or 1
						})
					end
				end
			end
		end

		self.petCommonAttrs[pet.camp] = props

		for _, sRune in ipairs(petObj.exclusiveRune or {}) do
			local gid = sRune.hero_gid

			if gid and gid ~= "" and gid ~= "0" then
				local rData = ResPetRune[sRune.resid]

				if rData then
					local attrs = self.petExclusiveAttrs[gid] or {}

					for _, aInfo in ipairs(rData.attr or {}) do
						local attrName = BattleConst.PROP_TYPE_CONFIG[aInfo.type_id]

						attrs[attrName] = (attrs[attrName] or 0) + aInfo.num
					end

					self.petExclusiveAttrs[gid] = attrs

					local states = self.heroExtraConditionStates[gid] or {}

					if rData.state_id then
						table.insert(states, {
							rData.state_id,
							rData.level or 1
						})
					end

					self.heroExtraConditionStates[gid] = states
				end
			end
		end
	end
end

function CombatUnitManager:initPetExtraProps(camp, heroObj, props)
	local attrs = self.petCommonAttrs[camp]

	for propName, propValue in pairs(attrs or {}) do
		props[propName] = (props[propName] or 0) + propValue
	end

	if self.petExclusiveAttrs[heroObj.gid] then
		for propName, propValue in pairs(self.petExclusiveAttrs[heroObj.gid]) do
			props[propName] = (props[propName] or 0) + propValue
		end
	end

	local pets = self:getPossessPets(camp, heroObj.career)

	if pets then
		local possessAttr = PropHelper.getPetPossessAttr(pets, heroObj.career, true)

		for propName, propValue in pairs(possessAttr) do
			props[propName] = (props[propName] or 0) + propValue
		end
	end
end

function CombatUnitManager:getPossessPets(camp, career)
	if self.initInfo.speData and self.initInfo.speData.PossessPet then
		local campPossessPets = self.initInfo.speData.PossessPet[camp] or {}

		return campPossessPets[career]
	end
end

function CombatUnitManager:handleSpecBattle()
	if self.specBattleType == BattleConst.SPECIAL_BATTLE_HOOK then
		for _, eid in ipairs(self.orderObjects) do
			local entity = self.objects[eid]

			if entity.camp == BattleConst.CAMP_PLAYER then
				entity:addBattleState(entity, 1100304, 1, BattleConst.STATE_DURATION_UNLIMIT)
			else
				if entity.playerinfo.noDieTime and entity.playerinfo.noDieTime > 0 then
					entity:addBattleState(entity, 1100304, 1, entity.playerinfo.noDieTime)
				end

				entity.hp = 1
			end
		end

		local priorPlayers = {}

		for prior, info in ipairs(ResHookMisc[1].careers) do
			for _, eid in ipairs(self.orderObjects) do
				local entity = self.objects[eid]

				if entity.camp == BattleConst.CAMP_PLAYER and entity.career == info.career then
					table.insert(priorPlayers, entity)
				end
			end
		end

		for index, manaInfo in ipairs(ResHookMisc[1].manas) do
			if priorPlayers[index] then
				priorPlayers[index].mana = manaInfo.mana
			end
		end
	elseif self.specBattleType == BattleConst.SPECIAL_BATTLE_SUN_FLOWER then
		local battleNo = self.battleConfig.id

		if ResBattleMonsterWaves[battleNo] then
			self.curWave = 0
			self.beatedWave = 0
			self.waveTimeType = ResBattleMonsterWaves[battleNo].time_type
			self.waveMonsters = ResBattleMonsterWaves[battleNo].monster_waves
		end
	end
end

local MAX_SUPPRESS_NUM = 6

function CombatUnitManager:getPlayerDynamicLevel(dynamic_level, suppressType, entityDict)
	local dynamicLevel = 0

	if dynamic_level and dynamic_level[1] then
		local rates = dynamic_level[1].param
		local minThreshold = dynamic_level[1].threshold
		local levels = {}

		for objectID, playerinfo in pairs(entityDict) do
			if playerinfo.camp == BattleConst.CAMP_PLAYER and not playerinfo.monsterID then
				local suppressLevel = self:_getInfoSuppressLevel(playerinfo, suppressType)

				table.insert(levels, suppressLevel)
			end
		end

		table.sort(levels, function(a, b)
			return b < a
		end)

		local maxLevel = levels[1]
		local minLevel = math.max(0, maxLevel - minThreshold)

		for index = #levels, MAX_SUPPRESS_NUM - 1 do
			table.insert(levels, 0)
		end

		for index = 1, MAX_SUPPRESS_NUM do
			local rate = rates[index] or 0

			dynamicLevel = dynamicLevel + rate * math.max(minLevel, levels[index])
		end
	end

	return dynamicLevel + (self.suppressExtraLevel or 0)
end

function CombatUnitManager:_getInfoSuppressLevel(playerinfo, suppressType)
	local suppressLevel = 1
	local level = playerinfo.level
	local star = playerinfo.star

	if suppressType == 2 then
		suppressLevel = math.max(80, playerinfo.heroObj.battleStep * 20)
	elseif suppressType == 3 then
		if star <= 5 then
			suppressLevel = math.max(0, level + (star - 3) * 5)
		elseif star > 5 and star <= 10 then
			suppressLevel = math.max(0, level + (star - 4) * 10)
		else
			suppressLevel = math.max(0, level + (star - 10) * 3.1 + 60)
		end
	elseif suppressType == 4 then
		local equipRate = 0

		if playerinfo.isRobot and playerinfo.robotEquips and playerinfo.robotEquips.equip_level then
			equipRate = playerinfo.robotEquips.equip_level
		end

		for _, equip in ipairs(playerinfo.equips) do
			if equip.level and equip.level > 5 then
				equipRate = equipRate + (equip.level + equip.evolve - 5) * 0.987
			end
		end

		if star <= 5 then
			suppressLevel = math.max(0, level + (star - 3) * 5 + equipRate)
		elseif star > 5 and star <= 10 then
			suppressLevel = math.max(0, level + (star - 4) * 10 + equipRate)
		else
			suppressLevel = math.max(0, level + (star - 10) * 3.1 + 60 + equipRate)
		end
	else
		local crystalSecondLevel = playerinfo.crystalSecondLevel or 0
		local equipRate = 0

		if playerinfo.isRobot and playerinfo.robotEquips and playerinfo.robotEquips.equip_level then
			equipRate = playerinfo.robotEquips.equip_level
		end

		for _, equip in ipairs(playerinfo.equips) do
			if equip.level and equip.level > 5 then
				equipRate = equipRate + (equip.level - 5) * 0.987
			end
		end

		if star <= 5 then
			suppressLevel = math.max(0, level + (star - 3) * 5 + equipRate + crystalSecondLevel * 0.07)
		elseif star > 5 and star <= 10 then
			suppressLevel = math.max(0, level + (star - 4) * 10 + equipRate + crystalSecondLevel * 0.07)
		else
			suppressLevel = math.max(0, level + (star - 10) * 3.1 + 60 + equipRate + crystalSecondLevel * 0.07)
		end
	end

	return suppressLevel
end

function CombatUnitManager:_addCampEffect(camp, enhanceInfo)
	if enhanceInfo.state_id then
		if camp == BattleConst.CAMP_PLAYER then
			table.insert(self.playerEnhanceBuffs, {
				enhanceInfo.state_id,
				enhanceInfo.state_level
			})
		else
			table.insert(self.monsterEnhanceBuffs, {
				enhanceInfo.state_id,
				enhanceInfo.state_level
			})
		end
	elseif enhanceInfo.event_id then
		if camp == BattleConst.CAMP_PLAYER then
			table.insert(self.playerEnhanceEvents, enhanceInfo.event_id)
		else
			table.insert(self.monsterEnhanceEvents, enhanceInfo.event_id)
		end
	end
end

function CombatUnitManager:_checkCampEffect(playerCampMaxNum, monsterCampMaxNum, enhanceInfo)
	if playerCampMaxNum == enhanceInfo.enhance_args then
		self:_addCampEffect(BattleConst.CAMP_PLAYER, enhanceInfo)
	end

	if monsterCampMaxNum == enhanceInfo.enhance_args then
		self:_addCampEffect(BattleConst.CAMP_MONSTER, enhanceInfo)
	end
end

local SUPPRESS_TYPE_MONSTER = 1
local SUPPRESS_TYPE_PLAYER = 2

function CombatUnitManager:initBattleSuppress(battleConfig, entityDict, speData)
	local suppressData = ResBattleSuppress[battleConfig.suppress_id]
	local suppressLevelData = ResBattleSuppressLevel[battleConfig.suppress_id]

	if suppressData and battleConfig.suppress_level and suppressLevelData then
		local playerLevel

		if speData and speData.suppres then
			playerLevel = speData.suppres
		end

		if suppressData.suppress_type ~= 1 or playerLevel == nil then
			playerLevel = self:getPlayerDynamicLevel(suppressData.dynamic_level, suppressData.suppress_type, entityDict)
		end

		self.suppressLevel = playerLevel - battleConfig.suppress_level

		for index, suppressInfo in ipairs(suppressLevelData) do
			local minOK = not suppressInfo.min_level or not (playerLevel < suppressInfo.min_level + battleConfig.suppress_level)
			local maxOK = not suppressInfo.max_level or not (playerLevel > suppressInfo.max_level + battleConfig.suppress_level)

			if minOK and maxOK then
				self.suppressDataMonsterState = suppressInfo.suppress_state

				break
			end
		end
	end

	self.playerCampMaxNum, self.monsterCampMaxNum, self.specCampInfo = utils.getBattleCampMaxNum(entityDict)
	self.playerMaxSupportNum, self.monsterMaxSupportNum = utils.getBattleObjMaxNum(entityDict, "career", Const.CAREER_TYPE.SUPPORT)

	for index, enhanceInfo in ipairs(ResBattleEnhance) do
		if enhanceInfo.enhance_type == 1 then
			self:_checkCampEffect(self.playerCampMaxNum, self.monsterCampMaxNum, enhanceInfo)
		elseif enhanceInfo.enhance_type == 2 then
			self:_checkCampEffect(self.playerMaxSupportNum, self.monsterMaxSupportNum, enhanceInfo)
		elseif enhanceInfo.enhance_type == 3 then
			self:_checkCampEffect(self.specCampInfo[1], self.specCampInfo[3], enhanceInfo)
		elseif enhanceInfo.enhance_type == 4 then
			self:_checkCampEffect(self.specCampInfo[2], self.specCampInfo[4], enhanceInfo)
		end
	end

	self:_checkStageTimeSuppress(speData)
	self:_checkStageReturnSuppress(speData)
end

function CombatUnitManager:_checkStageTimeSuppress(speData)
	self.stageSuppressDataMonsterState = nil

	local tickTime = 0
	local vipLevel = 0
	local timeSuppressId

	if speData and speData.stageData then
		tickTime = speData.stageData.suppressTick or 0
		vipLevel = speData.stageData.vipLevel or 0
		tickTime = tickTime / 3600

		local season = speData.stageData.season
		local chapter = speData.stageData.chapter
		local level = speData.stageData.level

		if ResStage[season] and ResStage[season][chapter] and ResStage[season][chapter][level] then
			timeSuppressId = ResStage[season][chapter][level].tick_suppress_id or 1
		end
	elseif speData and speData.seasonTowerData and speData.seasonTowerData.towerData then
		tickTime = speData.seasonTowerData.suppressTick or 0
		vipLevel = speData.seasonTowerData.vipLevel or 0
		timeSuppressId = speData.seasonTowerData.towerData.tick_suppress_id
		tickTime = tickTime / 3600
	end

	local timeRate = 1

	if ResStageVipTimeSuppress[vipLevel] and ResStageVipTimeSuppress[vipLevel].rate then
		timeRate = ResStageVipTimeSuppress[vipLevel].rate
	end

	if ResStageTimeSuppress[timeSuppressId] then
		for _, info in ipairs(ResStageTimeSuppress[timeSuppressId].suppress_group) do
			local minOK = not info.min_level or not (tickTime < info.min_level * timeRate)
			local maxOK = not info.max_level or not (tickTime > info.max_level * timeRate)

			if minOK and maxOK then
				self.stageSuppressDataMonsterState = info.suppress_state

				break
			end
		end
	end
end

function CombatUnitManager:_checkStageReturnSuppress(speData)
	self.stageReturnSuppressMonsterState = nil

	local returnSuppressId
	local backStageCnt = 0

	if speData and speData.stageData then
		local season = speData.stageData.season
		local chapter = speData.stageData.chapter
		local level = speData.stageData.level

		backStageCnt = speData.stageData.backStageCnt or 0

		if ResStage[season] and ResStage[season][chapter] and ResStage[season][chapter][level] then
			returnSuppressId = ResStage[season][chapter][level].return_suppress_id
		end
	end

	if returnSuppressId and ResStageReturnSuppress[returnSuppressId] and ResStageReturnSuppress[returnSuppressId].return_phase and ResStageReturnSuppress[returnSuppressId].return_phase[backStageCnt] then
		self.stageReturnSuppressMonsterState = ResStageReturnSuppress[returnSuppressId].return_phase[backStageCnt].suppress_state
	end
end

function CombatUnitManager:addBattleEnhance(obj)
	if obj.camp == BattleConst.CAMP_PLAYER then
		for index, stateInfo in ipairs(self.playerEnhanceBuffs) do
			obj:addBattleState(obj, stateInfo[1], stateInfo[2], BattleConst.STATE_DURATION_UNLIMIT)
		end
	else
		if self.suppressDataMonsterState then
			obj:addBattleState(obj, self.suppressDataMonsterState, 1, BattleConst.STATE_DURATION_UNLIMIT)
		end

		if self.stageSuppressDataMonsterState then
			obj:addBattleState(obj, self.stageSuppressDataMonsterState, 1, BattleConst.STATE_DURATION_UNLIMIT)
		end

		for index, stateInfo in ipairs(self.monsterEnhanceBuffs) do
			obj:addBattleState(obj, stateInfo[1], stateInfo[2], BattleConst.STATE_DURATION_UNLIMIT)
		end

		if self.stageReturnSuppressMonsterState then
			obj:addBattleState(obj, self.stageReturnSuppressMonsterState, 1, BattleConst.STATE_DURATION_UNLIMIT)
		end
	end

	if obj.hero and self.heroExtraConditionStates[obj.hero.gid] then
		for _, stateInfo in ipairs(self.heroExtraConditionStates[obj.hero.gid]) do
			obj:addBattleState(obj, stateInfo[1], stateInfo[2], BattleConst.STATE_DURATION_UNLIMIT)
		end
	end
end

function CombatUnitManager:addEnterBattleBuff(obj)
	if obj.camp == BattleConst.CAMP_PLAYER then
		for _, stateId in ipairs(self.playerEnterState) do
			obj:addBattleState(obj, stateId, 1, BattleConst.STATE_DURATION_UNLIMIT)
		end
	end

	if self.weatherManager.weatherFriendState and obj.camp == self.weatherManager.weatherCamp then
		self:addGlobalState(self.weatherManager.weatherFriendState, obj)
	elseif self.weatherManager.weatherEnemyState and obj.camp ~= self.weatherManager.weatherCamp then
		self:addGlobalState(self.weatherManager.weatherEnemyState, obj)
	end

	if self.campBuffData[obj.camp] and self.campBuffData[obj.camp].teamGroup then
		local hero = obj.hero

		if obj.master and self:getObjectByKey(obj.master) then
			hero = self:getObjectByKey(obj.master).hero
		end

		if hero then
			local states = utils.getHeroTeamProficientStates(hero, self.campBuffData[obj.camp].teamGroup)

			for _, pStateId in ipairs(states) do
				obj:addBattleState(obj, pStateId, 1, BattleConst.STATE_DURATION_UNLIMIT)
			end
		end
	end

	if obj.camp == BattleConst.CAMP_PLAYER and not obj.master and self.initInfo.speData then
		for _, stateInfo in ipairs(self.initInfo.speData.extraStates or {}) do
			if stateInfo[3] and stateInfo[3] > 1 then
				obj:setStateLayer(obj, stateInfo[1], stateInfo[2], BattleConst.STATE_DURATION_UNLIMIT, stateInfo[3])
			else
				obj:addBattleState(obj, stateInfo[1], stateInfo[2], BattleConst.STATE_DURATION_UNLIMIT)
			end
		end

		for _, passiveInfo in ipairs(self.initInfo.speData.extraPassives or {}) do
			obj:addPassiveSkill(passiveInfo[1], passiveInfo[2], obj.id)
		end
	end

	if obj.hero then
		local pets = self:getPossessPets(obj.camp, obj.career)

		if pets then
			local giftStates = {}
			local giftStateLevels = {}

			for _, pet in ipairs(pets) do
				for _, giftId in ipairs(pet.giftList) do
					local giftData = ResPetGifted[giftId]

					if giftData.skill_id then
						if giftStateLevels[giftData.skill_id] then
							if (giftData.skill_level or 1) > giftStateLevels[giftData.skill_id] then
								giftStateLevels[giftData.skill_id] = giftData.skill_level or 1
							end
						else
							table.insert(giftStates, giftData.skill_id)

							giftStateLevels[giftData.skill_id] = giftData.skill_level or 1
						end
					end
				end
			end

			for _, stateId in ipairs(giftStates) do
				obj:addBattleState(obj, stateId, giftStateLevels[stateId], BattleConst.STATE_DURATION_UNLIMIT)
			end
		end
	end
end

function CombatUnitManager:getRandomGenerator()
	return self.matrixInstance.randGenerator
end

function CombatUnitManager:addOutput(outputType, filter, args)
	self.matrixInstance:addOutput(outputType, filter, args)
end

function CombatUnitManager:onSkillActTime(attacker, pauseFrame, targets, hideDelayTime, cardId, hideEffect)
	if self.specBattleType ~= BattleConst.SPECIAL_BATTLE_HOOK then
		for _, unitContainer in ipairs(self.tickAllUnits) do
			for _, eid in ipairs(unitContainer) do
				local obj = self.objects[eid]

				obj:onSkillPause(pauseFrame, targets, attacker, hideDelayTime, cardId, hideEffect)
			end
		end

		for _, pet in ipairs(self.activePets) do
			pet:onSkillPause(pauseFrame, targets, attacker, hideDelayTime, cardId, hideEffect)
		end

		self.nextPauseEnd = self.frameNumber + pauseFrame
	end
end

function CombatUnitManager:noticeSkillEnd(attacker, cardId)
	for _, unitContainer in ipairs(self.tickAllUnits) do
		for _, eid in ipairs(unitContainer) do
			local obj = self.objects[eid]

			obj:noticeSkillEnd(attacker, cardId)
		end
	end
end

function CombatUnitManager:initObjects(entityDict, frameLength, initInfo)
	self.frameLength = frameLength
	self.nowEntityId = 0

	self:initPetUnit(initInfo.petEntity)
	self:_addEntity(entityDict)

	self.playerDeadNum = 0
	self.gridNebs = getMoveGridNebs(self.LR_LEN, self.UD_LEN, self.oddShorter)
end

function CombatUnitManager:getMoveInfo(obj, target)
	local startGridNum = CoordToGrid(obj.coordX, obj.coordY)
	local endGridNum = CoordToGrid(target.coordX, target.coordY)
	local nextGrid = self:_crossNebs(startGridNum, endGridNum)

	return GridToCoord(nextGrid)
end

function CombatUnitManager:_crossNebs(startGridNum, endGridNum)
	local aliveGrids = {}

	for _, eid in ipairs(self.orderObjects) do
		local obj = self.objects[eid]
		local gridNum = CoordToGrid(obj.coordX, obj.coordY)

		if gridNum then
			aliveGrids[gridNum] = true
		end
	end

	local targetGridNum
	local passed = {}
	local nowNode = {
		endGridNum
	}

	passed[endGridNum] = true

	for dist = 1, self.LR_LEN + self.UD_LEN do
		if #nowNode > 0 then
			for index = 1, #nowNode do
				local nodeNum = table.remove(nowNode, 1)

				for _, nebGrid in ipairs(self.gridNebs[nodeNum] or {}) do
					if not passed[nebGrid] and not aliveGrids[nebGrid] then
						passed[nebGrid] = true

						table.insert(nowNode, nebGrid)
					end

					if nebGrid == startGridNum and (targetGridNum == nil or math.abs(targetGridNum - startGridNum) > math.abs(nodeNum - startGridNum)) then
						targetGridNum = nodeNum
					end
				end
			end

			if targetGridNum then
				break
			end
		else
			break
		end
	end

	if targetGridNum == nil then
		if startGridNum % LINE_NUM < endGridNum % LINE_NUM then
			if not aliveGrids[startGridNum + 1] then
				targetGridNum = startGridNum + 1
			end
		elseif startGridNum % LINE_NUM > endGridNum % LINE_NUM and not aliveGrids[startGridNum - 1] then
			targetGridNum = startGridNum - 1
		end
	end

	return targetGridNum
end

function CombatUnitManager:checkGlobalStartEvent()
	self:checkTrapInitEvent()
	self:checkMazeGlobalEvent()
	self:checkNewMazeGlobalEvent()
	self:checkCampInfoEvent()

	if self.waveMonsters then
		self:onNextWaveMonster()
	end
end

function CombatUnitManager:checkCampInfoEvent()
	for _, event_id in ipairs(self.playerEnhanceEvents) do
		self:triggerGlobalEventByCamp(event_id, BattleConst.CAMP_PLAYER)
	end

	for _, event_id in ipairs(self.monsterEnhanceEvents) do
		self:triggerGlobalEventByCamp(event_id, BattleConst.CAMP_MONSTER)
	end
end

function CombatUnitManager:checkMazeGlobalEvent()
	if self.mazeSlics then
		for _, slicID in ipairs(self.mazeSlics) do
			if ResRelics[slicID] and ResRelics[slicID].event_id then
				local events = ResRelics[slicID].event_id

				self:triggerGlobalEventByCamp(events, BattleConst.CAMP_PLAYER)
			end
		end
	end

	if self.STBuffs then
		for _, buffId in ipairs(self.STBuffs) do
			if ResOpActTowerBuff[buffId] and ResOpActTowerBuff[buffId].event_id then
				local events = ResOpActTowerBuff[buffId].event_id

				self:triggerGlobalEventByCamp(events, BattleConst.CAMP_PLAYER)
			end
		end
	end
end

function CombatUnitManager:checkNewMazeGlobalEvent()
	if self.newMazeRelics then
		for _, relicId in ipairs(self.newMazeRelics) do
			if ResNewMazeRelic[relicId] and ResNewMazeRelic[relicId].attack_event_id then
				local events = ResNewMazeRelic[relicId].attack_event_id

				self:triggerGlobalEventByCamp(events, BattleConst.CAMP_PLAYER)
			end
		end
	end

	if self.newMazeHalos then
		for _, haloId in ipairs(self.newMazeHalos) do
			if ResNewMazeHalo[haloId] and ResNewMazeHalo[haloId].attack_event_id then
				local events = ResNewMazeHalo[haloId].attack_event_id

				self:triggerGlobalEventByCamp(events, BattleConst.CAMP_PLAYER)
			end
		end
	end

	if self.newMazeFetters then
		for _, fetterId in ipairs(self.newMazeFetters) do
			if ResNewMazeFetters[fetterId] and ResNewMazeFetters[fetterId].attack_event_id then
				local events = ResNewMazeFetters[fetterId].attack_event_id

				self:triggerGlobalEventByCamp(events, BattleConst.CAMP_PLAYER)
			end
		end
	end
end

function CombatUnitManager:initPetUnit(petEntity)
	if not self.entityPetId then
		self.entityPetId = BattleConst.PET_ENTITY_START
	end

	for _, petInfo in ipairs(petEntity or {}) do
		local newPet = self:_onCreatePetEntity(self.entityPetId, petInfo)

		self.pets[self.entityPetId] = newPet
		self.entityPetId = self.entityPetId + 1

		table.insert(self.activePets, newPet)
	end

	self:initBattlePetRuneAttr()
end

function CombatUnitManager:onPetOver(deadPet)
	for index, pet in ipairs(self.activePets) do
		if pet == deadPet then
			table.remove(self.activePets, index)

			break
		end
	end
end

function CombatUnitManager:_onCreatePetEntity(objectID, playerinfo)
	local camp = playerinfo.camp
	local newUnit = PetUnit(objectID, self, self.frameLength, playerinfo)

	return newUnit
end

function CombatUnitManager:_addEntity(entityDict)
	local tmpOrder = {}

	for objectID, playerinfo in pairs(entityDict) do
		table.insert(tmpOrder, objectID)
	end

	table.sort(tmpOrder)

	for _, objectID in ipairs(tmpOrder) do
		local playerinfo = entityDict[objectID]

		self:_onCreateEntity(objectID, playerinfo, true)

		if objectID > self.nowEntityId then
			self.nowEntityId = objectID
		end
	end

	table.sort(self.playerTickList, function(a, b)
		return a.pos < b.pos
	end)
end

function CombatUnitManager:getDist(coordX, coordY, targetCoordX, targetCoordY)
	local xDist = math.abs(targetCoordX - coordX)
	local yDist = math.abs(targetCoordY - coordY)

	if xDist >= yDist * 0.5 then
		return math.floor(xDist + yDist * 0.5)
	else
		return yDist
	end
end

function CombatUnitManager:getCoordByPos(pos, isMonster)
	if self.GridConfig.GridType == 1 then
		if isMonster then
			pos = -pos
		end

		local posInfo = self.POS_CONFIG[pos] or self.POS_CONFIG[0]

		return posInfo[1], posInfo[2]
	else
		local posInfo = self.POS_CONFIG[pos] or self.POS_CONFIG[0]
		local orderX = posInfo[1]
		local orderY = posInfo[2]

		if isMonster then
			orderX = self.LR_LEN - 1 - orderX
		end

		return orderX, orderY
	end
end

function CombatUnitManager:_onCreateEntity(objectID, playerinfo, fromInit)
	local camp = playerinfo.camp
	local pos = playerinfo.pos
	local orderX, orderY = self:getCoordByPos(pos, camp ~= self.LEFT_CAMP)

	playerinfo.coordX = orderX
	playerinfo.coordY = orderY
	playerinfo.extraProps = {}

	if fromInit and self.campBuffData[camp] and self.campBuffData[camp].buffInfo and playerinfo.heroObj then
		utils.getHeroHouseBuffProps(playerinfo.heroObj, self.campBuffData[camp].buffInfo, playerinfo.extraProps)
	end

	if fromInit and self.campBuffData[camp] and self.campBuffData[camp].teamGroup and playerinfo.heroObj then
		utils.getHeroTeamProficientProps(playerinfo.heroObj, self.campBuffData[camp].teamGroup, playerinfo.extraProps)
	end

	if fromInit and playerinfo.heroObj then
		self:initPetExtraProps(camp, playerinfo.heroObj, playerinfo.extraProps)
		utils.initHeadPendantProps(playerinfo.allRoleHeadPendant, playerinfo.extraProps)
	end

	if fromInit and camp == BattleConst.CAMP_PLAYER and self.initInfo.speData then
		for attrName, attrValue in pairs(self.initInfo.speData.extraAttrs or {}) do
			playerinfo.extraProps[attrName] = (playerinfo.extraProps[attrName] or 0) + attrValue
		end
	end

	local newUnit = CombatUnit(objectID, self, self.frameLength, playerinfo)

	self.objects[objectID] = newUnit

	table.insert(self.orderObjects, objectID)

	if newUnit.camp == BattleConst.CAMP_PLAYER and newUnit.career ~= Const.CAREER_TYPE.SUPPORT then
		table.insert(self.playerTickList, newUnit)
	end

	if fromInit then
		self:addBattleEnhance(self.objects[objectID])
	elseif self.trapMgr then
		self.trapMgr:toRealCoord(self.objects[objectID], self.objects[objectID].coordX, self.objects[objectID].coordY)
	end
end

function CombatUnitManager:onsummonMonsters(master, monsters, priorLine)
	if self.specBattleType ~= BattleConst.SPECIAL_BATTLE_HOOK then
		for index, monsterID in pairs(monsters) do
			if ResMonster[monsterID] then
				local monsterInfos = {}
				local pos = self:getEmptyPos(master, priorLine)

				if pos then
					if master.master and self:getObjectByKey(master.master) then
						master = self:getObjectByKey(master.master)
					end

					local eid = master.id * BattleConst.MAX_COMMON_MONSTER_NUMBER + (master.summonNumber or 0)

					master.summonNumber = (master.summonNumber or 0) + 1

					local monster = utils.getBattleMonsterInfo(monsterID, pos, master.camp, eid)

					monster.master = master.id

					self:_onCreateEntity(eid, monster)
					self:addOutput(BattleConst.MATRIX_EVENT_SUMMON_MONSTER, master.id, {
						eid,
						monster
					})

					local monster = self.objects[eid]

					if monster then
						monster:initInEnterBattle()
					end

					for _, unitContainer in ipairs(self.tickAllUnits) do
						for _, eid in ipairs(unitContainer) do
							local obj = self.objects[eid]

							obj:raiseSimpleEvent({
								BattleConst.PASSIVE_TRIGGER_SIMPLE_EVENT_SUMMON,
								monster,
								master
							})
						end
					end

					self:onTriggerPassive(BattleConst.PASSIVE_TRIGGER_TYPE_SIMPLE_EVENT, {
						BattleConst.PASSIVE_TRIGGER_SIMPLE_PLAYER_NUM,
						monster
					})
				end
			end
		end
	end
end

function CombatUnitManager:onRebornEntity(master, target, mhpPercent)
	if self.specBattleType ~= BattleConst.SPECIAL_BATTLE_HOOK then
		local rebornCoordX, rebornCoordY

		if not self:getObject(target.realCoordX, target.realCoordY) then
			rebornCoordX = target.realCoordX
			rebornCoordY = target.realCoordY
		else
			local pos = self:getEmptyPos(target)

			if pos and self.POS_CONFIG[pos] then
				rebornCoordX, rebornCoordY = self:getCoordByPos(pos, target.camp ~= self.LEFT_CAMP)
			end
		end

		if rebornCoordX then
			table.insert(self.orderObjects, target.id)

			if target.camp == BattleConst.CAMP_PLAYER and target.career ~= Const.CAREER_TYPE.SUPPORT then
				table.insert(self.playerTickList, target)
			end

			target:onReborn(rebornCoordX, rebornCoordY, mhpPercent, master)

			for _, unitContainer in ipairs(self.tickAllUnits) do
				for _, eid in ipairs(unitContainer) do
					local obj = self.objects[eid]

					obj:raiseSimpleEvent({
						BattleConst.PASSIVE_TRIGGER_SIMPLE_EVENT_REBORN,
						target,
						master
					})
				end
			end
		end
	end
end

function CombatUnitManager:onTriggerPassive(eventType, eventArgs)
	for _, unitContainer in ipairs(self.tickAllUnits) do
		for _, eid in ipairs(unitContainer) do
			local obj = self.objects[eid]

			obj.passiveGroup:onPassiveTrigger(eventType, eventArgs)
		end
	end
end

function CombatUnitManager:getObjectByKey(objectKey)
	return self.objects[objectKey]
end

function CombatUnitManager:getObjectIncludeAll(objectKey)
	if objectKey == -1 and self.globalMaster then
		return self.globalMaster
	else
		return self.objects[objectKey] or self.pets[objectKey]
	end
end

function CombatUnitManager:nextFrame(frameNumber)
	self.frameSkillEntity = nil
	self.frameSkillPause = false
	self.predictSkillEntity = nil
	self.frameNumber = frameNumber

	if not self.matrixInstance.battleOver then
		if self.frameNumber == 1 then
			self:checkGlobalStartEvent()
		end

		if frameNumber == BattleConst.MATRIX_ENTITY_PREPARE_FRAME then
			self:addOutput(BattleConst.MATRIX_EVENT_BATTLE_START, nil, {})
			self:addOutput(BattleConst.MATRIX_EVENT_BATTLE_TIME, nil, {
				self.countTime
			})
		elseif frameNumber >= self.nextPauseEnd then
			self.weatherManager:nextFrame(frameNumber)

			self.curCountFrame = self.curCountFrame - 1

			if self.curCountFrame >= 0 and self.curCountFrame % self.framePerSec == 0 then
				self.countTime = self.countTime - 1

				self:addOutput(BattleConst.MATRIX_EVENT_BATTLE_TIME, nil, {
					self.countTime
				})
			end

			if not self.noAction then
				for _, pet in ipairs(self.activePets) do
					if not self.frameSkillEntity then
						pet:checkHeroSkill()
					end
				end

				if not self.frameSkillEntity then
					for _, unitContainer in ipairs(self.tickAllUnits) do
						for _, eid in ipairs(unitContainer) do
							local object = self.objects[eid]

							object:checkHeroSkill()
						end
					end

					if self.frameSkillEntity then
						for _, unitContainer in ipairs(self.tickAllUnits) do
							for _, eid in ipairs(unitContainer) do
								local object = self.objects[eid]

								object:predictHeroSkill()
							end
						end

						if self.predictSkillEntity ~= self.frameSkillEntity then
							self.frameSkillEntity = nil
						end
					end
				end
			end

			self.realFrameNumber = self.realFrameNumber + 1

			if self.monsterWaveDict[self.realFrameNumber] then
				self.noAction = false

				self:clearMonsters()
				self:addOutput(BattleConst.MATRIX_EVENT_MONSTER_WAVE, nil, {
					self.monsterWaveDict[self.realFrameNumber]
				})

				self.monsterWaveDict[self.realFrameNumber] = nil

				self:addOutput(BattleConst.MATRIX_EVENT_ACTION_END, nil, {
					false
				})
			end

			if self.monsterEnterDict[self.realFrameNumber] then
				for _, mInfo in ipairs(self.monsterEnterDict[self.realFrameNumber]) do
					self:_onCreateEntity(mInfo.entityID, mInfo)
					self:addOutput(BattleConst.MATRIX_EVENT_MONSTER_ENTER, nil, {
						mInfo.entityID,
						mInfo
					})

					local monster = self.objects[mInfo.entityID]

					if monster then
						monster:initInEnterBattle()
					end
				end

				self.monsterEnterDict[self.realFrameNumber] = nil
			end
		end
	end

	for _, eid in ipairs(self.orderObjects) do
		local object = self.objects[eid]

		if object.career == Const.CAREER_TYPE.SUPPORT then
			object:nextFrame(frameNumber, self.noAction)
		end
	end

	for _, eid in ipairs(self.outOfPosObjects) do
		local object = self.objects[eid]

		object:nextFrame(frameNumber, self.noAction)
	end

	for _, object in ipairs(self.playerTickList) do
		object:nextFrame(frameNumber, self.noAction)
	end

	for _, eid in ipairs(self.orderObjects) do
		local object = self.objects[eid]

		if object.camp ~= BattleConst.CAMP_PLAYER and object.career ~= Const.CAREER_TYPE.SUPPORT then
			object:nextFrame(frameNumber, self.noAction)
		end
	end

	for _, pet in ipairs(self.activePets) do
		pet:nextFrame(frameNumber, self.noAction)
	end

	if self.curCountFrame <= 0 then
		self.matrixInstance:onTimeOut()
	end
end

function CombatUnitManager:onUnitDead(deadObject, attacker)
	local teamAllDead = true

	for _, eid in ipairs(self.orderObjects) do
		local obj = self.objects[eid]

		if obj ~= deadObject then
			obj:onObjectDead(deadObject)

			if obj.camp == deadObject.camp and obj:isAlive() then
				teamAllDead = false
			end
		end
	end

	for _, eid in ipairs(self.outOfPosObjects) do
		local object = self.objects[eid]

		if object ~= deadObject then
			object:onObjectDead(deadObject)
		end
	end

	attacker:onKillSomeOne(deadObject)
	self:onTriggerPassive(BattleConst.PASSIVE_TRIGGER_TYPE_SIMPLE_EVENT, {
		BattleConst.PASSIVE_TRIGGER_SIMPLE_PLAYER_NUM,
		deadObject
	})

	for index, tid in ipairs(self.orderObjects) do
		if tid == deadObject.id then
			table.remove(self.orderObjects, index)

			break
		end
	end

	if deadObject.camp == BattleConst.CAMP_PLAYER then
		for index, object in ipairs(self.playerTickList) do
			if object == deadObject then
				table.remove(self.playerTickList, index)

				break
			end
		end
	end

	if deadObject.camp == BattleConst.CAMP_PLAYER and deadObject.heroID and not self.matrixInstance.battleOver then
		self.playerDeadNum = self.playerDeadNum + 1
	end

	if teamAllDead then
		if deadObject.camp ~= BattleConst.CAMP_PLAYER then
			for _, unitContainer in ipairs(self.tickAllUnits) do
				for _, eid in ipairs(self.orderObjects) do
					local obj = self.objects[eid]

					if obj.camp ~= deadObject.camp then
						obj.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_GAME_WIN, {
							deadObject
						})
					end
				end
			end
		end

		self:onOneTeamAllDead(deadObject)
	end
end

function CombatUnitManager:onOneTeamAllDead(object)
	if object.camp == BattleConst.CAMP_MONSTER and self.waveMonsters then
		if next(self.monsterEnterDict) ~= nil then
			return
		end

		self:addOutput(BattleConst.MATRIX_EVENT_MONSTER_WAVE_DEAD, nil, {})

		if self:onNextWaveMonster() then
			-- block empty
		else
			self.matrixInstance:onBattleResult(object.camp)
		end
	else
		self.matrixInstance:onBattleResult(object.camp)
	end

	self:addOutput(BattleConst.MATRIX_EVENT_ACTION_END, nil, {
		true
	})

	self.noAction = true
end

local SUN_FLOWER_POS = {
	7,
	8,
	9
}

function CombatUnitManager:onNextWaveMonster()
	if self.waveMonsters and self.waveMonsters[self.curWave] then
		self.beatedWave = self.curWave
	end

	self.curWave = self.curWave + 1

	if self.waveMonsters and self.waveMonsters[self.curWave] then
		local startFrame = self.waveMonsters[self.curWave].frame_num or 1

		if startFrame <= 0 then
			startFrame = 1
		end

		self.monsterEnterDict = {}
		self.monsterWaveDict = {}
		self.monsterWaveDict[self.realFrameNumber + startFrame] = self.curWave

		local poses = self.waveMonsters[self.curWave].monsters_pos or {}
		local frames = self.waveMonsters[self.curWave].monsters_frame or {}

		for index, mId in ipairs(self.waveMonsters[self.curWave].monsters) do
			local pos = poses[index]
			local frame = frames[index] or 0

			if pos and SUN_FLOWER_POS[pos] then
				self.nowEntityId = self.nowEntityId + 1

				local mInfo = utils.getBattleMonsterInfo(mId, SUN_FLOWER_POS[pos], BattleConst.CAMP_MONSTER, self.nowEntityId)

				self:addOutput(BattleConst.MATRIX_EVENT_ADD_ENTITY, nil, {
					self.nowEntityId,
					mInfo
				})

				local frameNumber = self.realFrameNumber + startFrame + frame

				if not self.monsterEnterDict[frameNumber] then
					self.monsterEnterDict[frameNumber] = {}
				end

				table.insert(self.monsterEnterDict[frameNumber], mInfo)
			end
		end

		return true
	end

	return false
end

function CombatUnitManager:getDeadHero(container, camp)
	for objId, obj in pairs(self.objects) do
		if obj.camp == camp and not obj:isAlive() and not obj.master then
			container[objId] = obj
		end
	end
end

function CombatUnitManager:getObjectByCoordY(container, coordY, camp)
	for _, objId in ipairs(self.orderObjects) do
		local obj = self.objects[objId]

		if (not coordY or obj.realCoordY == coordY or obj.bigMonster and math.abs(obj.realCoordY - coordY) <= 1) and (not camp or obj.camp == camp) then
			container[objId] = obj
		end
	end
end

function CombatUnitManager:getObjectByCoordX(container, coordX, camp, excludeSummon, includeOutOfPos)
	if includeOutOfPos then
		for _, unitContainer in ipairs(self.tickAllUnits) do
			for _, objId in ipairs(unitContainer) do
				local obj = self.objects[objId]

				if (not coordX or obj.realCoordX == coordX) and (not camp or obj.camp == camp) and (not excludeSummon or not obj.master) then
					container[objId] = obj
				end
			end
		end
	else
		for _, objId in ipairs(self.orderObjects) do
			local obj = self.objects[objId]

			if (not coordX or obj.realCoordX == coordX) and (not camp or obj.camp == camp) and (not excludeSummon or not obj.master) then
				container[objId] = obj
			end
		end
	end
end

function CombatUnitManager:getObjectOfNear(container, coordX, coordY, camp, isBigger, nearDist)
	nearDist = nearDist or 1

	if isBigger then
		nearDist = nearDist + 1
	end

	for _, objId in ipairs(self.orderObjects) do
		local obj = self.objects[objId]

		if not camp or camp == obj.camp then
			local dist = self:getDist(coordX, coordY, obj.realCoordX, obj.realCoordY)

			if dist <= nearDist or obj.bigMonster and dist <= nearDist + 1 then
				container[objId] = obj
			end
		end
	end
end

function CombatUnitManager:getObjectOfFarest(container, coordY, camp, excludeSummon)
	local farObj, coordX, farCoordY

	for _, objId in ipairs(self.orderObjects) do
		local obj = self.objects[objId]

		if camp == obj.camp and (not excludeSummon or not obj.master) and (coordY == nil or obj.realCoordY == coordY or obj.bigMonster and math.abs(obj.realCoordY - coordY) <= 1) then
			if camp == BattleConst.CAMP_PLAYER and (coordX == nil or coordX > obj.realCoordX) then
				farObj = obj
				coordX = obj.realCoordX
				farCoordY = obj.realCoordY
			elseif camp == BattleConst.CAMP_MONSTER and (coordX == nil or coordX < obj.realCoordX) then
				farObj = obj
				coordX = obj.realCoordX
				farCoordY = obj.realCoordY
			elseif coordY == nil and coordX and obj.realCoordX == coordX then
				local objAbsY = math.abs(obj.realCoordY - 2)
				local farAbsY = math.abs(farCoordY - 2)

				if farAbsY < objAbsY or objAbsY == farAbsY and farCoordY < obj.realCoordY then
					farObj = obj
					coordX = obj.realCoordX
					farCoordY = obj.realCoordY
				end
			end
		end
	end

	if farObj then
		container[farObj.id] = farObj
	end
end

function CombatUnitManager:getObjectOfLine(container, coordY, camp, isFront)
	local searchMin = true

	if camp == BattleConst.CAMP_PLAYER and isFront then
		searchMin = false
	elseif camp == BattleConst.CAMP_MONSTER and not isFront then
		searchMin = false
	end

	local lineRecords = {}

	for _, objId in ipairs(self.orderObjects) do
		local obj = self.objects[objId]

		if not camp or camp == obj.camp then
			local adjustY

			if not coordY or coordY == obj.realCoordY then
				adjustY = obj.realCoordY
			elseif coordY and obj.isBigger then
				adjustY = coordY
			end

			if adjustY then
				if not lineRecords[adjustY] then
					lineRecords[adjustY] = {
						obj.realCoordX,
						obj
					}
				elseif searchMin and obj.realCoordX < lineRecords[adjustY][1] then
					lineRecords[adjustY] = {
						obj.realCoordX,
						obj
					}
				elseif not searchMin and obj.realCoordX > lineRecords[adjustY][1] then
					lineRecords[adjustY] = {
						obj.realCoordX,
						obj
					}
				end
			end
		end
	end

	for lineNum, lineInfo in pairs(lineRecords) do
		container[lineInfo[2].id] = lineInfo[2]
	end
end

function CombatUnitManager:nearIsEmpty(target, isFriend)
	if target and target.outOfPos then
		return true
	end

	local nearDist = 1
	local camp = target.camp

	if not isFriend then
		camp = camp == BattleConst.CAMP_PLAYER and BattleConst.CAMP_MONSTER or BattleConst.CAMP_PLAYER
	end

	for _, objId in ipairs(self.orderObjects) do
		local obj = self.objects[objId]

		if obj ~= target and camp == obj.camp then
			local dist = self:getDist(target.coordX, target.coordY, obj.realCoordX, obj.realCoordY)

			if dist <= nearDist or obj.bigMonster and dist <= nearDist + 1 then
				return false
			end
		end
	end

	return true
end

function CombatUnitManager:getObjectReal(coordX, coordY)
	if coordX < self.min_lr or coordX > self.max_lr or coordY < self.min_ud or coordY > self.max_ud then
		return nil
	end

	for _, objId in ipairs(self.orderObjects) do
		local obj = self.objects[objId]
		local dist = self:getDist(coordX, coordY, obj.realCoordX, obj.realCoordY)

		if dist == 0 or obj.bigMonster and dist <= 1 then
			return obj
		end
	end

	return false
end

function CombatUnitManager:getServantByCamp(container, camp)
	for _, objId in ipairs(self.orderObjects) do
		local obj = self.objects[objId]

		if obj.master and camp == obj.camp then
			container[objId] = obj
		end
	end
end

function CombatUnitManager:getServantByMaster(container, master)
	for _, objId in ipairs(self.orderObjects) do
		local obj = self.objects[objId]

		if obj.master == master.id then
			container[objId] = obj
		end
	end
end

function CombatUnitManager:getObject(coordX, coordY)
	if coordX < self.min_lr or coordX > self.max_lr or coordY < self.min_ud or coordY > self.max_ud then
		return nil
	end

	for _, objId in ipairs(self.orderObjects) do
		local obj = self.objects[objId]
		local dist = self:getDist(coordX, coordY, obj.coordX, obj.coordY)

		if dist == 0 or obj.bigMonster and dist <= 1 then
			return obj
		end
	end

	return false
end

function CombatUnitManager:getObjectByPos(pos, camp)
	local posInfo = self.POS_CONFIG[pos] or self.POS_CONFIG[0]

	if posInfo then
		if camp == self.LEFT_CAMP then
			return self:getObject(posInfo[1], posInfo[2])
		else
			return self:getObject(self.LR_LEN - 1 - posInfo[1], posInfo[2])
		end
	else
		return nil
	end
end

function CombatUnitManager:_getOneLineEmptyPos(object, nowLine)
	local nowLineConfig = self.GridConfig.LineConfig[nowLine]

	if nowLineConfig then
		local nowLineAllNum = #nowLineConfig
		local nowLineHalfNum = math.floor(nowLineAllNum / 2)
		local emptyIndex

		for index = 1, nowLineHalfNum do
			local obj = self:getObjectByPos(nowLineConfig[index], object.camp)

			if obj == false then
				emptyIndex = index
			elseif obj and obj:attackNear() then
				break
			end
		end

		return nowLineConfig[emptyIndex]
	end
end

function CombatUnitManager:getEmptyPos(object, priorLine)
	if not priorLine or priorLine == 0 then
		priorLine = object.realCoordY + 1
	elseif priorLine == 3 then
		priorLine = #self.GridConfig.LineConfig
	elseif priorLine == 4 then
		priorLine = #self.GridConfig.LineConfig - 1
	elseif priorLine == 5 then
		priorLine = math.floor(#self.GridConfig.LineConfig / 2) + 1
	elseif priorLine == 6 then
		return object.pos
	end

	local nowResult = self:_getOneLineEmptyPos(object, priorLine)

	if nowResult then
		return nowResult
	end

	for index = 1, #self.GridConfig.LineConfig - 1 do
		local upResult = self:_getOneLineEmptyPos(object, priorLine + index)

		if upResult then
			return upResult
		end

		local downResult = self:_getOneLineEmptyPos(object, priorLine - index)

		if downResult then
			return downResult
		end
	end
end

function CombatUnitManager:getConditionTargets(target, suitCondition)
	local camp = target.camp
	local coordY = target.coordY
	local coordX = target.coordX
	local targets = {}

	if suitCondition == BattleConst.ASSIST_TYPE_LINE then
		for _, objId in ipairs(self.orderObjects) do
			local obj = self.objects[objId]

			if not obj.bigMonster and obj.camp == camp and obj.coordY == coordY and target ~= obj then
				table.insert(targets, obj)
			end
		end
	elseif suitCondition == BattleConst.ASSIST_TYPE_NEB_ALL or suitCondition == BattleConst.ASSIST_TYPE_NEB_THREE or suitCondition == BattleConst.ASSIST_TYPE_NEB_TWO then
		for _, objId in ipairs(self.orderObjects) do
			local obj = self.objects[objId]

			if not obj.bigMonster and obj.camp == camp and math.abs(obj.coordY - coordY) <= 1 and math.abs(obj.coordX - coordX) <= 1 and target ~= obj then
				table.insert(targets, obj)
			end
		end

		if suitCondition == BattleConst.ASSIST_TYPE_NEB_THREE then
			targets = self:getRandomGenerator():randomChoice(targets, 3)
		elseif suitCondition == BattleConst.ASSIST_TYPE_NEB_TWO then
			targets = self:getRandomGenerator():randomChoice(targets, 2)
		end
	end

	return targets
end

function CombatUnitManager:inManualOpera()
	if BattleConst.AUTO_SYNC_BATTLE[self.battleType] then
		return false
	else
		return self.matrixInstance.manualOpera
	end
end

function CombatUnitManager:inShortSkill()
	if BattleConst.AUTO_SYNC_BATTLE[self.battleType] then
		return true
	else
		return self.matrixInstance.shortOpera
	end
end

function CombatUnitManager:recordCombatResult(attackerId, targetId, damageType, damageValue, isCrit, master)
	if not self.resultRecord then
		self.resultRecord = {}
	end

	if master then
		attackerId = master
	end

	if not self.resultRecord[attackerId] then
		self.resultRecord[attackerId] = CombatResultRecorder()
	end

	self.resultRecord[attackerId]:recordOneAttack(damageType, damageValue, isCrit, self.objects[attackerId])

	if not self.resultRecord[targetId] then
		self.resultRecord[targetId] = CombatResultRecorder()
	end

	self.resultRecord[targetId]:recordOneHited(damageType, damageValue, self.objects[targetId])
end

function CombatUnitManager:getBattleTime()
	return self.maxTime - math.max(0, self.countTime)
end

function CombatUnitManager:getBattleDamage()
	local dmg = 0

	for index, obj in pairs(self.objects) do
		if obj.camp ~= BattleConst.CAMP_PLAYER then
			dmg = dmg + math.min(math.max(obj.mhp - obj.hp, 0), obj.mhp)
		end
	end

	return dmg
end

function CombatUnitManager:getBattleDamagePercent()
	local maxMhp = 0
	local dmg = 0

	for index, obj in pairs(self.objects) do
		if obj.camp == BattleConst.CAMP_MONSTER then
			dmg = dmg + math.min(math.max(obj.mhp - obj.hp, 0), obj.mhp)
			maxMhp = maxMhp + obj.mhp
		end
	end

	return math.max(0, math.min(10000, math.floor(dmg * 10000 / maxMhp)))
end

function CombatUnitManager:getDamageResultInfo()
	local results = {}
	local memberPlayer = {}
	local memberMonster = {}

	for attackerId, obj in pairs(self.objects) do
		local oneResult

		if self.resultRecord and self.resultRecord[attackerId] then
			oneResult = self.resultRecord[attackerId]
		else
			oneResult = {}
		end

		if obj.isSummonEntity == 0 and obj.camp == BattleConst.CAMP_PLAYER then
			local newRecord = {}

			newRecord.resid = obj.heroID or obj.monsterID
			newRecord.damage = oneResult.totalDamage
			newRecord.kill_count = obj.killNum

			if obj.hero and obj.hero.gid then
				newRecord.gid = obj.hero.gid
			end

			newRecord.left_hp = math.max(0, math.min(10000, math.ceil(10000 * obj.hp / obj.mhp)))

			table.insert(memberPlayer, newRecord)
		elseif obj.isSummonEntity == 0 and obj.camp == BattleConst.CAMP_MONSTER then
			local newRecord = {}

			newRecord.resid = obj.monsterID or obj.heroID
			newRecord.damage = oneResult.totalDamage
			newRecord.kill_count = obj.killNum
			newRecord.left_hp = math.max(0, math.min(10000, math.ceil(10000 * obj.hp / obj.mhp)))
			newRecord.pos = obj.monsterStartPos

			table.insert(memberMonster, newRecord)
		end
	end

	table.insert(results, {
		member = memberPlayer
	})
	table.insert(results, {
		member = memberMonster
	})

	return results
end

function CombatUnitManager:getPlayerAliveNum()
	local num = 0

	for _, unitContainer in ipairs(self.tickAllUnits) do
		for _, eid in ipairs(unitContainer) do
			local obj = self.objects[eid]

			if obj.camp == BattleConst.CAMP_PLAYER and obj.hero then
				num = num + 1
			end
		end
	end

	return num
end

function CombatUnitManager:playerHpInfo()
	local hpInfo = {}

	for index, obj in pairs(self.objects) do
		if obj.camp == BattleConst.CAMP_PLAYER and obj.hero and obj.hero.gid then
			local info = {}

			info.gid = obj.hero.gid
			info.hp = math.max(0, math.min(10000, math.ceil(10000 * obj.hp / obj.mhp)))

			table.insert(hpInfo, info)
		end
	end

	return hpInfo
end

function CombatUnitManager:teammateHpInfo()
	local hpInfo = {}

	for index, obj in pairs(self.objects) do
		if obj.camp == BattleConst.CAMP_PLAYER then
			local info = {}

			if obj.hero and obj.heroID then
				info.resid = obj.heroID
				info.hp = math.max(0, math.min(10000, math.ceil(10000 * obj.hp / obj.mhp)))

				table.insert(hpInfo, info)
			elseif obj.monsterID then
				info.resid = obj.monsterID
				info.hp = math.max(0, math.min(10000, math.ceil(10000 * obj.hp / obj.mhp)))

				table.insert(hpInfo, info)
			end
		end
	end

	return hpInfo
end

function CombatUnitManager:monsterHpInfo()
	local hpInfo = {}

	for index, obj in pairs(self.objects) do
		if obj.monsterStartPos then
			local info = {}

			info.id = obj.monsterStartPos
			info.hp = math.max(0, math.min(10000, math.ceil(10000 * obj.hp / obj.mhp)))

			table.insert(hpInfo, info)
		end
	end

	return hpInfo
end

function CombatUnitManager:getMonsterLoseHp()
	local dmg = 0

	for index, obj in pairs(self.objects) do
		if obj.camp ~= BattleConst.CAMP_PLAYER and obj.isSummonEntity == 0 then
			dmg = dmg + math.min(math.max(obj.mhp - obj.hp, 0), obj.mhp)
		end
	end

	return dmg
end

function CombatUnitManager:countPlayerNum(campFilter, typeFilter, trigger)
	local num = 0

	for index, objId in pairs(self.orderObjects) do
		local obj = self.objects[objId]

		if obj:isAlive() and (campFilter == 3 or campFilter == 0 and obj.camp == trigger.camp or campFilter == 2 and obj.camp ~= trigger.camp or campFilter == 3 and (obj.id == trigger.id or obj.master == trigger.id)) and (typeFilter == 2 or typeFilter == 0 and obj.master or typeFilter == 1 and not obj.master) then
			num = num + 1
		end
	end

	return num
end

function CombatUnitManager:getMonsterLoseHpPercent()
	local dmg = 0
	local maxHp = 0

	for index, obj in pairs(self.objects) do
		if obj.camp ~= BattleConst.CAMP_PLAYER and obj.isSummonEntity == 0 then
			dmg = dmg + math.min(math.max(obj.initHp - obj.hp, 0), obj.mhp)
			maxHp = maxHp + obj.mhp
		end
	end

	if maxHp > 0 then
		return dmg / maxHp
	else
		return 0
	end
end

function CombatUnitManager:toRealCoord(target, coordX, coordY)
	if self.trapMgr then
		self.trapMgr:toRealCoord(target, coordX, coordY)
	end
end

function CombatUnitManager:checkTrapInitEvent()
	if self.trapMgr then
		for _, objId in ipairs(self.orderObjects) do
			local obj = self.objects[objId]

			self.trapMgr:toRealCoord(obj, obj.coordX, obj.coordY)
		end
	end
end

local GLOBAL_MASTER = {
	orderY = 0,
	monsterID = 1000001,
	pos = 0,
	orderX = 0,
	camp = BattleConst.CAMP_PLAYER
}

function CombatUnitManager:confirmGlobalMaster()
	if not self.globalMaster then
		self.globalMaster = CombatUnit(-1, self, self.frameLength, GLOBAL_MASTER)
		self.globalMaster.isToolMan = true
	end
end

function CombatUnitManager:triggerGlobalEvent(events, target)
	self:confirmGlobalMaster()

	if target then
		self.globalMaster:triggerSkillEvent(events[1], events[2], target.id, nil, events[3] or 1)
	else
		self.globalMaster:triggerSkillEvent(events[1], events[2], self.globalMaster.id, nil, events[3] or 1)
	end
end

function CombatUnitManager:triggerGlobalEventByCamp(events, camp)
	for _, objId in ipairs(self.orderObjects) do
		local obj = self.objects[objId]

		if obj.camp == camp and obj:isAlive() then
			self:triggerGlobalEvent(events, obj)

			return
		end
	end
end

function CombatUnitManager:addGlobalState(stateId, target)
	self:confirmGlobalMaster()

	if target then
		target:addBattleState(self.globalMaster, stateId, 1, BattleConst.STATE_DURATION_UNLIMIT)
	end
end

function CombatUnitManager:delGlobalState(stateId, target)
	if target then
		target:deleteBattleState(self.globalMaster, stateId)
	end
end

local TARGET_INIT_FUNC_NAME = {
	[8] = "recordSkillNumTarget",
	[7] = "recordSkillNumTarget"
}

function CombatUnitManager:initBattleTarget()
	self.battleTarget = self.battleConfig.target_id
	self.battleTargetData = ResBattleTarget[self.battleConfig.target_id]

	if self.battleTargetData then
		local targets = self.battleTargetData.targets or {}

		for index, oneTarget in ipairs(targets) do
			local tType = oneTarget.t_type
			local tInitFuncName = TARGET_INIT_FUNC_NAME[tType]

			if tInitFuncName and self[tInitFuncName] then
				self[tInitFuncName](self, oneTarget)
			end
		end
	else
		self.battleTarget = nil
	end
end

function CombatUnitManager:recordSkillNumTarget(oneTarget)
	local targetInfo = oneTarget.arg1

	if targetInfo and #targetInfo >= 3 then
		local needId = targetInfo[1]
		local skillId = targetInfo[2]
		local eventId = targetInfo[3]

		for objectId, obj in pairs(self.objects) do
			if obj.heroID == needId or obj.monsterID == needId then
				obj:recordSkillNumTarget(skillId, eventId)

				break
			end
		end
	end
end

function CombatUnitManager:getBattleTargetState()
	local okNum = 0
	local states = {}

	if self.battleTarget then
		local targets = self.battleTargetData.targets or {}

		for index, oneTarget in ipairs(targets) do
			local tOk, sDetail = self:_getOneTargetState(oneTarget)

			table.insert(states, {
				tOk,
				sDetail
			})

			if tOk then
				okNum = okNum + 1
			end
		end
	end

	return okNum, states
end

local TARGET_STATE_FUNC_NAME = {
	"targetStateWin",
	"targetStateHeroHp",
	"targetStateTime",
	"targetStateHeroAlive",
	"targetStateDamageRank",
	"targetStateHeroKill",
	"targetStateSkillHitNum",
	"targetStateSkillFirstHitNum",
	"targetStateDeadTime",
	"targetStateHpTop",
	"targetStateBeInterupt",
	"targetStateSkillUseNum"
}

function CombatUnitManager:_getOneTargetState(oneTarget)
	local funcName = TARGET_STATE_FUNC_NAME[oneTarget.t_type]

	if funcName and self[funcName] then
		return self[funcName](self, oneTarget)
	end

	return nil
end

function CombatUnitManager:targetStateWin(oneTarget)
	if self.matrixInstance.battleOver == BattleConst.BATTLE_OVER_WIN then
		return true
	elseif self.matrixInstance.battleOver then
		return false
	else
		return nil
	end
end

function CombatUnitManager:targetStateHeroHp(oneTarget)
	if oneTarget.arg1 and oneTarget.arg2 then
		local needId = oneTarget.arg1[1]
		local needHp = oneTarget.arg2[1]

		for objectId, obj in pairs(self.objects) do
			if obj.heroID == needId or obj.monsterID == needId then
				return needHp <= math.ceil(10000 * obj.hppct)
			end
		end
	end

	return false
end

function CombatUnitManager:targetStateTime(oneTarget)
	return math.floor(self:getBattleTime()) <= oneTarget.arg1[1]
end

function CombatUnitManager:targetStateHeroAlive(oneTarget)
	return self:getPlayerAliveNum() >= oneTarget.arg1[1]
end

function CombatUnitManager:targetStateDamageRank(oneTarget)
	local maxDamage = 0
	local heroDamage = 0

	if self.resultRecord then
		local needId = oneTarget.arg1[1]
		local has = false

		for objectId, obj in pairs(self.objects) do
			if obj.camp == BattleConst.CAMP_PLAYER and obj.hero then
				has = true

				local result = self.resultRecord[objectId]

				if result then
					maxDamage = math.max(maxDamage, result.totalDamage)

					if obj.heroID == needId or obj.monsterID == needId then
						heroDamage = result.totalDamage
					end
				end
			end
		end

		if not has then
			return false
		end
	end

	if maxDamage <= heroDamage then
		return true, heroDamage
	else
		return false
	end
end

function CombatUnitManager:targetStateHeroKill(oneTarget)
	if oneTarget.arg1 and oneTarget.arg2 then
		local needId = oneTarget.arg1[1]
		local needNum = oneTarget.arg2[1]
		local has = false

		for objectId, obj in pairs(self.objects) do
			if obj.heroID == needId or obj.monsterID == needId then
				has = true

				if needNum <= obj.killNum then
					return true
				else
					return nil
				end
			end
		end

		if not has then
			return false
		end
	end

	return nil
end

function CombatUnitManager:targetStateSkillHitNum(oneTarget)
	if oneTarget.arg1 and oneTarget.arg2 then
		local needId = oneTarget.arg1[1]
		local needNum = oneTarget.arg2[1]
		local has = false

		for objectId, obj in pairs(self.objects) do
			if obj.heroID == needId or obj.monsterID == needId then
				has = true

				if obj.recordSkillMaxHitNum and needNum <= obj.recordSkillMaxHitNum then
					return true, obj.recordSkillMaxHitNum
				else
					return nil, obj.recordSkillMaxHitNum
				end
			end
		end

		if not has then
			return false
		end
	end

	return nil
end

function CombatUnitManager:targetStateSkillFirstHitNum(oneTarget)
	if oneTarget.arg1 and oneTarget.arg2 then
		local needId = oneTarget.arg1[1]
		local needNum = oneTarget.arg2[1]
		local diffType = oneTarget.arg2[2]
		local has = false

		for objectId, obj in pairs(self.objects) do
			if obj.heroID == needId or obj.monsterID == needId then
				has = true

				if obj.recordSkillFirstHitNum and (diffType == 1 and obj.recordSkillFirstHitNum == needNum or diffType ~= 1 and needNum <= obj.recordSkillFirstHitNum) then
					return true, obj.recordSkillFirstHitNum
				elseif obj.manaFullSkillNum > 1 then
					return false, obj.recordSkillFirstHitNum
				elseif obj.manaFullSkillNum == 1 and obj.attackType ~= BattleConst.ATTACK_SKILL then
					return false, obj.recordSkillFirstHitNum
				else
					return nil, obj.recordSkillFirstHitNum
				end
			end
		end

		if not has then
			return false
		end
	end

	return nil
end

function CombatUnitManager:targetStateDeadTime(oneTarget)
	if oneTarget.arg1 and oneTarget.arg2 then
		local needId = oneTarget.arg1[1]
		local needNum = oneTarget.arg2[1]

		for objectId, obj in pairs(self.objects) do
			if obj.heroID == needId or obj.monsterID == needId then
				if obj.deadTime and needNum >= math.floor(self.maxTime - math.max(0, obj.deadTime)) then
					return true
				else
					break
				end
			end
		end

		if needNum < math.floor(self:getBattleTime()) then
			return false
		end
	end

	return nil
end

function CombatUnitManager:targetStateHpTop(oneTarget)
	local allOk = true
	local okState = {}

	if oneTarget.arg1 and oneTarget.arg2 then
		local needIds = oneTarget.arg1
		local needNums = oneTarget.arg2

		for index, needId in ipairs(needIds) do
			local has = false
			local needNum = needNums[index] or needNums[1]

			for objectId, obj in pairs(self.objects) do
				if obj.heroID == needId or obj.monsterID == needId then
					has = true

					if needNum > math.ceil(10000 * obj.minHpPercent) then
						allOk = false

						table.insert(okState, false)

						break
					end

					table.insert(okState, true)

					break
				end
			end

			if not has then
				return false
			end
		end
	end

	return allOk, okState
end

function CombatUnitManager:targetStateBeInterupt(oneTarget)
	if oneTarget.arg1 and oneTarget.arg2 then
		local needId = oneTarget.arg1[1]
		local needNum = oneTarget.arg2[1]

		for objectId, obj in pairs(self.objects) do
			if obj.heroID == needId or obj.monsterID == needId then
				if needNum <= obj.beInteruptSkillNum then
					return true
				else
					return nil
				end
			end
		end
	end

	return nil
end

function CombatUnitManager:targetStateSkillUseNum(oneTarget)
	local okState = {}

	if oneTarget.arg1 and oneTarget.arg2 then
		local needId = oneTarget.arg1[1]
		local needNum = oneTarget.arg2[1]
		local diffRule = oneTarget.arg2[2]

		for objectId, obj in pairs(self.objects) do
			if obj.heroID == needId or obj.monsterID == needId then
				if diffRule == 1 then
					if needNum <= obj.manaFullSkillNum then
						return true
					else
						return
					end
				elseif needNum >= obj.manaFullSkillNum then
					return true
				else
					return false
				end
			end
		end
	end

	return false
end

return CombatUnitManager
