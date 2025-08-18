-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\Modules\\DebugBattle.lua

local DebugConst = require("Debug/DebugConst")
local ResDemoConfig = require("ClientData/ResDemoConfig")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResBattleRobotDemo = require("ClientData/ResBattleRobotDemo")
local ResBattleToolMain = require("ClientData/ResBattleToolMain")
local ResBattleToolAI = require("ResBattleToolAI")
local ResAttackEffect = require("ClientData/ResAttackEffect")
local DamageCalc = require("Common/FrameBattle/AttackProcess/DamageCalc")
local BattleReplayHelper = require("Debug/BattleReplayHelper")
local BattleStateData = require("Common/FrameBattle/BattleObject/BattleStateData")
local CombatUnit = require("Common/FrameBattle/BattleObject/CombatUnit")
local json = require("cjson")
local DebugModule = {}

DebugModule.ENTRY_NAME = "战斗"

local BATTLE_TEMP_FILE = Framework.Tools.FileUtils.GetTempPath() .. "battle_temp.txt"
local BOX_TYPE_PHYSICS = 0
local BOX_TYPE_MAGIC = 1
local BOX_TYPE_SACRED = 2
local BOX_TYPE_HEAL = 3
local BOX_TYPE_SHIELD = 4
local BOX_TYPE_HP_REMOVE = 5
local BOX_TYPE_FIRE = 6
local BOX_TYPE_ICE = 7
local BOX_TYPE_NO_ARMOR = 8
local BOX_TYPE_HP_SHIELD_REMOVE = 9

function DebugModule.enterDemo(sender, menu, value)
	if not GameFsm.isInState(Const.STATE_DEMO) then
		local DemoState = require("Debug/Modules/Demo/DemoState")

		GameFsm._fsm:addState(DemoState(Const.STATE_DEMO))
	end

	local demoId

	demoId = value == "" and 1 or tonumber(value)

	if demoId and ResDemoConfig[demoId] then
		GameFsm.getState(Const.STATE_DEMO):initBattle(10001, demoId, demoId)
		GameFsm.translateState(Const.STATE_DEMO)
	end
end

function DebugModule.enterRobotDemo(sender, menu, value)
	if not GameFsm.isInState(Const.STATE_DEMO) then
		local DemoState = require("Debug/Modules/Demo/DemoState")

		GameFsm._fsm:addState(DemoState(Const.STATE_DEMO))
	end

	local demoId

	demoId = value == "" and 1 or tonumber(value)

	local robotData = ResBattleRobotDemo[demoId]

	if robotData then
		GameFsm.getState(Const.STATE_DEMO):initBattle(10001, robotData.battleNo or 10003, demoId, true)
		GameFsm.translateState(Const.STATE_DEMO)
	end
end

function DebugModule.enterBattleTest(sender, menu, value)
	local FixedProp = require("Common/FrameBattle/BattleObject/FixedProp")
	local PropHelper = require("Common/FrameBattle/BattleObject/PropHelper")
	local ResSummonAttr = require("ClientData/ResSummonAttr")

	local function _initProperty(self)
		if self.master.monsterID then
			if ResSummonAttr[self.master.monsterID] and self.master.master and self.master.mgr:getObjectByKey(self.master.master) then
				local master = self.master.mgr:getObjectByKey(self.master.master)

				self.props = PropHelper.getSummonAttr(self.master.monsterID, master)
			else
				self.props = PropHelper.getMonsterAttr(self.master.monsterID, 1)

				if self.master.camp == BattleConst.CAMP_MONSTER then
					if self.master.playerinfo.monsterAtkEnhance or self.master.playerinfo.monsterMhpEnhance then
						self.props.fProp_mhp = self.props.fProp_mhp * (self.master.playerinfo.monsterMhpEnhance or 1)
						self.props.fProp_atk = self.props.fProp_atk * (self.master.playerinfo.monsterAtkEnhance or 1)
					else
						self.props.fProp_mhp = self.props.fProp_mhp * self.master.monsterMhpPropRate
						self.props.fProp_atk = self.props.fProp_atk * self.master.monsterPropRate
					end
				end
			end
		elseif self.master.petId then
			self.props = PropHelper.getPetAttrByPet(self.master.pet)
		else
			self.props = PropHelper.getHeroAttrByRobot(self.master.heroID, self.master:getPropLevel(), self.master.step, self.master.star, self.master.robotEquips, self.master.heroArtifact, self.master.heroRelic, self.master.paintData, self.master.relationPointData, self.master.extraProps)

			if self.master.playerinfo.enhanceAtkValue then
				self.props.fProp_atk = self.props.fProp_atk * self.master.playerinfo.enhanceAtkValue
				self.props.e_atk = self.props.e_atk * self.master.playerinfo.enhanceAtkValue
				self.props.fProp_mhp = self.props.fProp_mhp * self.master.playerinfo.enhanceMhpValue
				self.props.e_mhp = self.props.e_mhp * self.master.playerinfo.enhanceMhpValue
			end
		end
	end

	FixedProp.initProperty = _initProperty

	if not GameFsm.isInState(Const.STATE_DEMO_BATTLE_TEST) then
		local DemoStateBattleTest = require("Debug/Modules/Demo/DemoStateBattleTest")

		GameFsm._fsm:addState(DemoStateBattleTest(Const.STATE_DEMO_BATTLE_TEST))
	end

	local demoId, randomSeed, monsterAtkEnhance, monsterMhpEnhance, formation

	if value == "" then
		demoId = 1
	else
		local i1, i2 = string.find(value, "_")

		if i1 then
			demoId = tonumber(string.sub(value, 0, i1 - 1))

			local i3, i4 = string.find(value, "_", i2 + 1)

			if i3 then
				randomSeed = tonumber(string.sub(value, i2 + 1, i3 - 1))

				local i5, i6 = string.find(value, "_", i4 + 1)

				if i5 then
					monsterAtkEnhance = tonumber(string.sub(value, i4 + 1, i5 - 1))

					local i7, i8 = string.find(value, "_", i6 + 1)

					if i7 then
						monsterMhpEnhance = tonumber(string.sub(value, i6 + 1, i7 - 1))

						local formation_str = string.sub(value, i8 + 1)

						local function split(input, delimiter)
							input = tostring(input)
							delimiter = tostring(delimiter)

							if delimiter == "" then
								return false
							end

							local pos, arr = 0, {}

							for st, sp in function()
								return string.find(input, delimiter, pos, true)
							end do
								table.insert(arr, tonumber(string.sub(input, pos, st - 1)))

								pos = sp + 1
							end

							table.insert(arr, tonumber(string.sub(input, pos)))

							return arr
						end

						if formation_str ~= "" then
							formation = split(formation_str, ",")
						end
					else
						monsterMhpEnhance = tonumber(string.sub(value, i6 + 1))
					end
				else
					monsterAtkEnhance = tonumber(string.sub(value, i4 + 1))
				end
			else
				randomSeed = tonumber(string.sub(value, i2 + 1))
			end
		else
			demoId = tonumber(value)
		end
	end

	if formation then
		for index, value in ipairs(formation) do
			-- block empty
		end
	end

	local robotData = ResBattleToolMain[demoId]

	if robotData then
		GameFsm.getState(Const.STATE_DEMO_BATTLE_TEST):initBattle(10001, robotData.startBattleNo or 10003, demoId, true, randomSeed, monsterAtkEnhance, monsterMhpEnhance, formation)
		GameFsm.translateState(Const.STATE_DEMO_BATTLE_TEST)
	end
end

function DebugModule.enterBattleTestAI(sender, menu, value)
	local FixedProp = require("Common/FrameBattle/BattleObject/FixedProp")
	local PropHelper = require("Common/FrameBattle/BattleObject/PropHelper")
	local ResSummonAttr = require("ClientData/ResSummonAttr")

	local function _initProperty(self)
		if self.master.monsterID then
			if ResSummonAttr[self.master.monsterID] and self.master.master and self.master.mgr:getObjectByKey(self.master.master) then
				local master = self.master.mgr:getObjectByKey(self.master.master)

				self.props = PropHelper.getSummonAttr(self.master.monsterID, master)
			else
				self.props = PropHelper.getMonsterAttr(self.master.monsterID, 1)

				if self.master.camp == BattleConst.CAMP_MONSTER then
					if self.master.playerinfo.monsterAtkEnhance or self.master.playerinfo.monsterMhpEnhance then
						self.props.fProp_mhp = self.props.fProp_mhp * (self.master.playerinfo.monsterMhpEnhance or 1)
						self.props.fProp_atk = self.props.fProp_atk * (self.master.playerinfo.monsterAtkEnhance or 1)
					else
						self.props.fProp_mhp = self.props.fProp_mhp * self.master.monsterMhpPropRate
						self.props.fProp_atk = self.props.fProp_atk * self.master.monsterPropRate
					end
				end
			end
		elseif self.master.petId then
			self.props = PropHelper.getPetAttrByPet(self.master.pet)
		else
			self.props = PropHelper.getHeroAttrByRobot(self.master.heroID, self.master:getPropLevel(), self.master.step, self.master.star, self.master.robotEquips, self.master.heroArtifact, self.master.heroRelic, self.master.paintData, self.master.relationPointData, self.master.extraProps)

			if self.master.playerinfo.enhanceAtkValue then
				self.props.fProp_atk = self.props.fProp_atk * self.master.playerinfo.enhanceAtkValue
				self.props.e_atk = self.props.e_atk * self.master.playerinfo.enhanceAtkValue
				self.props.fProp_mhp = self.props.fProp_mhp * self.master.playerinfo.enhanceMhpValue
				self.props.e_mhp = self.props.e_mhp * self.master.playerinfo.enhanceMhpValue
			end
		end
	end

	FixedProp.initProperty = _initProperty

	local SUN_FLOWER_POS = {
		7,
		8,
		9
	}
	local CombatUnitManager = require("Common/FrameBattle/BattleObject/CombatUnitManager")

	local function _onNextWaveMonster(self)
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

					mInfo.monsterAtkEnhance = self.initInfo.monsterAtkEnhance
					mInfo.monsterMhpEnhance = self.initInfo.monsterMhpEnhance

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

	CombatUnitManager.onNextWaveMonster = _onNextWaveMonster

	if not GameFsm.isInState(Const.STATE_DEMO_BATTLE_TEST_AI) then
		local DemoStateBattleTestAI = require("Debug/Modules/Demo/DemoStateBattleTestAI")

		GameFsm._fsm:addState(DemoStateBattleTestAI(Const.STATE_DEMO_BATTLE_TEST_AI))
	end

	local demoId, randomSeed, monsterAtkEnhance, monsterMhpEnhance, formation

	if value == "" then
		demoId = 1
	else
		local i1, i2 = string.find(value, "_")

		if i1 then
			demoId = tonumber(string.sub(value, 0, i1 - 1))

			local i3, i4 = string.find(value, "_", i2 + 1)

			if i3 then
				randomSeed = tonumber(string.sub(value, i2 + 1, i3 - 1))

				local i5, i6 = string.find(value, "_", i4 + 1)

				if i5 then
					monsterAtkEnhance = tonumber(string.sub(value, i4 + 1, i5 - 1))

					local i7, i8 = string.find(value, "_", i6 + 1)

					if i7 then
						monsterMhpEnhance = tonumber(string.sub(value, i6 + 1, i7 - 1))

						local formation_str = string.sub(value, i8 + 1)

						local function split(input, delimiter)
							input = tostring(input)
							delimiter = tostring(delimiter)

							if delimiter == "" then
								return false
							end

							local pos, arr = 0, {}

							for st, sp in function()
								return string.find(input, delimiter, pos, true)
							end do
								table.insert(arr, tonumber(string.sub(input, pos, st - 1)))

								pos = sp + 1
							end

							table.insert(arr, tonumber(string.sub(input, pos)))

							return arr
						end

						if formation_str ~= "" then
							formation = split(formation_str, ",")
						end
					else
						monsterMhpEnhance = tonumber(string.sub(value, i6 + 1))
					end
				else
					monsterAtkEnhance = tonumber(string.sub(value, i4 + 1))
				end
			else
				randomSeed = tonumber(string.sub(value, i2 + 1))
			end
		else
			demoId = tonumber(value)
		end
	end

	if formation then
		for index, value in ipairs(formation) do
			-- block empty
		end
	end

	local robotData = ResBattleToolAI[demoId]

	if robotData then
		GameFsm.getState(Const.STATE_DEMO_BATTLE_TEST_AI):initBattle(10001, robotData.startBattleNo or 10003, demoId, true, randomSeed, monsterAtkEnhance, monsterMhpEnhance, formation)
		GameFsm.translateState(Const.STATE_DEMO_BATTLE_TEST_AI)
	end
end

local Monsters = {
	1100100,
	1100300,
	1100400,
	1100500,
	1100600,
	1100700,
	1100800,
	1110100,
	1200100,
	1200200,
	1200300,
	1200400,
	1200500,
	1200600,
	1200700,
	1200800,
	1200900,
	1201000,
	1210100,
	1300100,
	1300200,
	1300300,
	1300400,
	1300600,
	1300700,
	1300800,
	1300900,
	1301000,
	1301100,
	1310100,
	1400100,
	1400300,
	1400400,
	1400500,
	1400600,
	1400700,
	1400800,
	1400900,
	1410100,
	1500100,
	1500200,
	1500300,
	1500400,
	1500500,
	1500600,
	1500700,
	1500800,
	1500900,
	1510100
}

function DebugModule.heroEnterDemo(sender, menu, value)
	if not GameFsm.isInState(Const.STATE_DEMO) then
		local DemoState = require("Debug/Modules/Demo/DemoState")

		GameFsm._fsm:addState(DemoState(Const.STATE_DEMO))
	end

	local heroMonsterId

	heroMonsterId = value == "" and -1 or tonumber(value)

	if heroMonsterId ~= -1 then
		coroutine.start(DebugModule.coTest, heroMonsterId)
	else
		coroutine.start(DebugModule.coTestList)
	end
end

function DebugModule.coTestList()
	for _, heroId in ipairs(Monsters) do
		DebugModule.coTest(heroId)
		coroutine.wait(10)
	end

	GameFsm.translateState(Const.STATE_LOGIN)
end

function DebugModule.coTest(heroMonsterId)
	local ResMonster = require("ClientData/ResMonster")

	ResMonster[heroMonsterId].init_mana = 60
	ResMonster[heroMonsterId].mana_gen = 5
	ResMonster[10001].attack_id = 1

	local demoId = 901
	local demoInfo = ResDemoConfig[demoId]

	demoInfo.players = {
		0,
		heroMonsterId,
		0,
		0,
		0,
		10001,
		0,
		0,
		0
	}

	local ResBattleConfig = require("ClientData/ResBattleConfig")

	ResBattleConfig[demoId].maxTime = 86400
	ResBattleConfig[demoId].monsters = {
		10001,
		10001,
		10001,
		0,
		0,
		0,
		0,
		0,
		0
	}

	local demoState = GameFsm.getState(Const.STATE_DEMO)

	demoState:initBattle(10001, demoId, demoId)
	GameFsm.translateState(Const.STATE_DEMO)

	while demoState.flagLoaded == false do
		coroutine.wait(1)
	end

	coroutine.wait(10)

	local modelId = ResMonster[heroMonsterId].model
	local ResSkillConfig = require("ClientData/ResSkillConfig")
	local skillList = {}

	for k, v in pairs(ResSkillConfig) do
		if string.find(tostring(k), tostring(modelId)) then
			table.insert(skillList, k)
		end
	end

	local SkillDataBank = require("Common/FrameBattle/BattleObject/SkillDataBank")
	local combatUnit = demoState.mMatrixInstance.bObjMgr.aliveObjects[1]
	local target = demoState.mMatrixInstance.bObjMgr.aliveObjects[2]

	for idx, cardId in pairs(skillList) do
		local cardInfo = ResSkillConfig[cardId][#ResSkillConfig[cardId]]
		local skillType = cardInfo.skill_type
		local skillId = cardInfo.skill_ids[1]
		local skillData = SkillDataBank.getSkillData(combatUnit.weaponType, skillId)

		if skillType == BattleConst.SKILL_CONFIG_CA then
			-- block empty
		elseif skillType == BattleConst.SKILL_CONFIG_SKILL then
			-- block empty
		elseif skillType == BattleConst.SKILL_CONFIG_TRIGGER then
			combatUnit:handleSkillTarget(skillData.skillTarget or 0)
			combatUnit:_useTriggerSkill(cardId, 1, skillId, skillData)
		end
	end
end

local NUM_TYPES = {}

for typeStr, typeInt in pairs(Const.NUM_TYPE) do
	table.insert(NUM_TYPES, typeStr)
end

local NumType = Const.NUM_TYPE[NUM_TYPES[1]]
local Num = 0

function DebugModule.setNumType(sender, menu, value)
	NumType = Const.NUM_TYPE[value]
end

function DebugModule.setNum(sender, menu, value)
	Num = tonumber(value) or 0
end

function DebugModule.playNum(sender, menu, value)
	local showId = tonumber(value)
	local stateStr = ""

	if showId then
		stateStr = UIConst.getBattleShowStateInfo(showId)
	end

	local state = GameFsm.getCurState()

	if not state.mActorMgr then
		MsgManager.notice("没有在战斗状态")

		return
	end

	local obj = state.mActorMgr.actors[1]

	obj:showNum(Num, NumType, stateStr)
end

function DebugModule.pause()
	local state = GameFsm.getCurState()

	if not state.frameMgr then
		MsgManager.notice("没有在战斗状态")

		return
	end

	if state.frameMgr.isRunning then
		state:onPause()
	else
		state:onResume()
	end
end

function DebugModule.winBattle()
	if GameFsm.isInState(Const.STATE_BATTLE) then
		GameFsm.getCurState():onMatrixOver(BattleConst.CAMP_MONSTER, nil, 1)
		GameFsm.getCurState().frameMgr:pause()

		if GameFsm.getCurState().battleConfig and GameFsm.getCurState().battleConfig.id == 11001 then
			BeginnerManager.stopBeginnerStep(12)
		end
	end
end

local BOX_TYPE_PHYSICS = 0
local BOX_TYPE_MAGIC = 1
local BOX_TYPE_SACRED = 2
local BOX_TYPE_HEAL = 3
local BOX_TYPE_SHIELD = 4
local BOX_TYPE_HP_REMOVE = 5
local BOX_TYPE_ELEMENT = 6
local BOX_TYPE_NO_CRIT = 7
local BOX_TYPE_NO_ARMOR = 8
local BOX_TYPE_HP_SHIELD_REMOVE = 9

local function DamageCalc_calcDamageResult(propCache, target, boxId, eventLevel, randomGenerate, skillPower, objectMgr, skillInfo)
	local effectData = ResAttackEffect[boxId]
	local results = {}
	local effectLevelData = effectData[1]

	if eventLevel and eventLevel > 1 and effectData[eventLevel] then
		effectLevelData = effectData[eventLevel]
	end

	local boxType = effectLevelData.dmg_type

	if target.stateGroup:getProp(BattleConst.STATE_MAGIC_IMMUNE, 0) > 0 and boxType == BOX_TYPE_MAGIC then
		target:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SOMETHING, {
			BattleConst.ENTITY_SOMETHING_IMMUE_MAGIC
		})

		return results
	elseif target.stateGroup:getProp(BattleConst.STATE_PHYSICS_IMMUNE, 0) > 0 and boxType == BOX_TYPE_PHYSICS then
		local attacker = objectMgr:getObjectByKey(propCache.id)

		target:raiseSimpleEvent({
			BattleConst.ENTITY_SOMETHING_IMMUE_PHYSICS,
			attacker
		})

		if attacker then
			target:beHited(attacker, 0, BattleConst.DAMAGE_TYPE_HURT_IMMUE)
		end

		return results
	end

	if not DamageCalc.BOX_TYPE_CONFIG[boxType] then
		boxType = BOX_TYPE_PHYSICS
	end

	local conditionPower = skillInfo[1].stateGroup:getSkillConditionEnhanceRate(skillInfo[2], skillInfo[3], boxType, target, boxId)

	if conditionPower ~= 10000 then
		skillPower = skillPower * conditionPower * 0.0001
	end

	local boxConfig = DamageCalc.BOX_TYPE_CONFIG[boxType]
	local damageAmount = DamageCalc.AttackCalc(propCache, target, effectLevelData, boxType, objectMgr, skillInfo[4], skillInfo[5])
	local isCrit = false
	local shield = 0

	if boxConfig[1] then
		damageAmount = DamageCalc.DefenseCalc(damageAmount, propCache, target, boxType)
	end

	if boxConfig[2] then
		damageAmount, isCrit = DamageCalc.CritCalc(damageAmount, propCache, target, randomGenerate, effectLevelData)
	end

	if boxConfig[4] then
		damageAmount = DamageCalc.PowerCalc(damageAmount, boxType, propCache, target, skillPower, randomGenerate)
	end

	local targets = {}
	local linkDamage = 0

	if boxConfig[7] then
		targets, linkDamage = DamageCalc.CheckSoulLimit(damageAmount, target, objectMgr, targets)
	else
		table.insert(targets, {
			target,
			damageAmount
		})
	end

	local boxRealType = boxType

	if effectLevelData.final_dmg_type then
		boxRealType = effectLevelData.final_dmg_type
	end

	for index, hurtInfo in ipairs(targets) do
		local oneTarget = hurtInfo[1]
		local oneDmg = hurtInfo[2] + linkDamage

		if boxConfig[5] then
			oneDmg, shield = DamageCalc.ShieldCalc(oneDmg, oneTarget)
		end

		DamageCalc.recordMainResults(oneDmg, shield, isCrit, boxRealType, results, oneTarget, {
			index > 1,
			effectLevelData.shield_time,
			effectLevelData.burning
		}, hurtInfo[3])

		if boxConfig[6] then
			DamageCalc.HandleVampire(objectMgr, oneDmg, oneTarget, propCache, results)
		end
	end

	return results
end

local function DamageCalc_PowerCalc(damageAmount, boxType, propCache, target, skillPower, randomGenerate)
	local isBlock = false
	local attackerHurtPercent = 1 + propCache.damage_percent
	local targetDamagePercent = 1 - target.damage_reduce_percent

	if boxType == BOX_TYPE_HEAL then
		attackerHurtPercent = math.max(0, propCache.heal_effect)
		targetDamagePercent = math.max(0, target.heal_enhance_percent)
	elseif boxType == BOX_TYPE_SHIELD then
		if propCache.shieldEnhance then
			attackerHurtPercent = 1 + propCache.shieldEnhance / 10000
		else
			attackerHurtPercent = 1
		end

		if target.beShieldEnhance then
			targetDamagePercent = 1 + target.beShieldEnhance / 10000
		else
			targetDamagePercent = 1
		end
	elseif target.blockRate and target.blockRate >= 1 and randomGenerate:random(10000) <= target.blockRate then
		target:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SOMETHING, {
			BattleConst.STATE_BLOCK_RATE
		})

		targetDamagePercent = targetDamagePercent * BattleConst.BLOCK_REDUCE
		isBlock = true
	end

	damageAmount = math.max(0, damageAmount * attackerHurtPercent * targetDamagePercent * skillPower / 10000)

	if target.camp ~= propCache.attackCamp and target.race and BattleConst.HERO_CAMP_OVERCOME[propCache.race] == target.race then
		local extraDamage = damageAmount * BattleConst.OVERCOME_VALUE

		if propCache.campOvercomeAdd and propCache.campOvercomeAdd ~= 0 then
			extraDamage = extraDamage + damageAmount * propCache.campOvercomeAdd * 0.0001
		end

		if target.beCampOvercomeAdd and target.beCampOvercomeAdd ~= 0 then
			extraDamage = extraDamage + damageAmount * target.beCampOvercomeAdd * 0.0001
		end

		damageAmount = damageAmount + extraDamage
	end

	if boxType == BOX_TYPE_FIRE then
		local fireHurtPercent = 1 + propCache.fire_damage
		local fireHurtReducePercent = 1 - target.fire_damage_reduce

		damageAmount = math.max(0, damageAmount * fireHurtPercent * fireHurtReducePercent)
	elseif boxType == BOX_TYPE_ICE then
		local iceHurtPercent = 1 + propCache.ice_damage
		local iceHurtReducePercent = 1 - target.ice_damage_reduce

		damageAmount = math.max(0, damageAmount * iceHurtPercent * iceHurtReducePercent)
	end

	return damageAmount, isBlock
end

local function CombatUnit_addBattleState(self, attacker, stateId, level, delayTime)
	local stateData = BattleStateData.getStateData(stateId, level)

	if stateData and stateData.conditionName and stateData.conditionValue then
		if self[stateData.conditionName] ~= stateData.conditionValue then
			return
		end
	elseif stateData and stateData.conditionName and stateData.multiConditionValue then
		local hasEqual = false

		for _, value in ipairs(stateData.multiConditionValue) do
			if self[stateData.conditionName] == value then
				hasEqual = true

				break
			end
		end

		if not hasEqual then
			return
		end
	end

	local state = self.stateGroup:addState(attacker, stateId, level, delayTime)

	if state then
		-- block empty
	end
end

local MAX_MANA = 100

local function CombatUnit_onChangeMana(self, changeValue, autoAdd)
	if not autoAdd then
		-- block empty
	end

	self.mana = math.max(0, math.min(self.mana + changeValue, MAX_MANA))

	if not autoAdd or self.mana == MAX_MANA then
		self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SETMANA, {
			self.mana,
			MAX_MANA
		})
	end

	if self.mana == 0 then
		self:raiseSimpleEvent({
			BattleConst.PASSIVE_TRIGGER_SIMPLE_MANA_ZERO
		})
	end
end

function DebugModule.showDamageCalc(sender, menu, value)
	if Framework.Tools.LuaToolkit.IsEditor() then
		DamageCalc.calcDamageResult = DamageCalc_calcDamageResult
		CombatUnit.addBattleState = CombatUnit_addBattleState
		CombatUnit.onChangeMana = CombatUnit_onChangeMana
		DamageCalc.PowerCalc = DamageCalc_PowerCalc
	end
end

function DebugModule.recordBattle(sender, menu, value)
	if GameFsm.isInState(Const.STATE_BATTLE) then
		local state = GameFsm.getCurState()
		local replayFileKey = state.battleType
		local replayRecorder = BattleReplayHelper.initRecorder(replayFileKey)

		replayRecorder:Record(state:getReplayData())
		replayRecorder:Close()
	end
end

function DebugModule.tryReplayBattle(sender, menu, value)
	if value ~= "无" then
		local replayDate = BattleReplayHelper.getRecorderData(value)

		if replayDate then
			local replayState = GameFsm.getState(Const.STATE_BATTLE_REPLAY)

			replayState:setReplayData(replayDate)
			GameFsm.translateState(Const.STATE_BATTLE_REPLAY)
		end
	end
end

local REPLAY_URL_ROOM_DEV = "http://106.75.52.55:8888/relay/roomlist"
local REPLAY_URL_ROOM = "http://106.75.52.55:8888/relay/roomlist"
local REPLAY_INFO = {}
local useBy = "dev"
local NOW_ACTIVE, NOW_UID

local function GetRoomIds(result)
	local f = io.open("D:\\temp1.text", "rb")
	local content = f:read("*all")

	REPLAY_INFO = {}

	local names = {}

	result = 0

	if result == 0 then
		local roomData = json.decode(content)
		local dateList = {}

		for id, data in pairs(roomData.data) do
			table.insert(dateList, data)
		end

		table.sort(dateList, function(a, b)
			return a.Time > b.Time
		end)

		for index, data in ipairs(dateList) do
			local str_t = os.date("%Y-%m-%d %H:%M:%S 星期%w", data.Time)

			REPLAY_INFO[str_t] = {
				data.Multi,
				data.RoomID,
				NOW_UID
			}

			table.insert(names, str_t)
		end
	end

	UIManager.getUI("debug"):setServerReplayValue(names)
end

function DebugModule.onQueryPlayerBattle(sender, menu, value)
	local s = utils.splitString(value, ",")

	if #s >= 1 and #s[1] > 5 then
		local playerUid = s[1]

		NOW_UID = playerUid

		local roomtype = s[2] or "0"
		local url = REPLAY_URL_ROOM
		local finalUrl = "%s?uid=%s&roomtype=%s"

		finalUrl = string.format(finalUrl, url, playerUid, roomtype)

		Framework.Network.HttpUtils.GetToFile(finalUrl, GetRoomIds, BATTLE_TEMP_FILE)
	else
		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "参数格式", "1.玩家UID,2.类型(dev, ios, aos),3.房间类型(0表示全部),中间使用逗号隔开,2 3默认为内服和全部")
	end
end

local REPLAY_URL_BATTLE_DEV = "http://106.75.52.55:8888/relay/roomdata"
local REPLAY_URL_BATTLE = "http://106.75.52.55:8888/relay/roomdata"

local function GetBattleData(result)
	if result == 0 then
		local f = io.open(BATTLE_TEMP_FILE, "rb")
		local content = f:read("*all")
		local roomData = json.decode(content)
		local battleData = roomData.Data
		local isMuti = NOW_ACTIVE[1] > 0
		local playerUid = NOW_ACTIVE[3]
		local NetService = require("Network/NetService")

		NetService._initProtobufLib()

		local msgTable = protobuf.decode("datap.BattleData", battleData)

		if msgTable then
			local replayState = GameFsm.getState(Const.STATE_BATTLE_REPLAY)

			replayState:setServerReplayData(msgTable)
			GameFsm.translateState(Const.STATE_BATTLE_REPLAY)
		end
	end
end

function DebugModule.directReadBattle()
	local f = io.open(BATTLE_TEMP_FILE, "rb")
	local content = f:read("*all")
	local battleData = content
	local NetService = require("Network/NetService")

	NetService._initProtobufLib()

	local msgTable = protobuf.decode("datap.BattleData", battleData)

	if msgTable then
		if msgTable.start_data.type == BattleConst.BATTLE_TYPE_THREE_TEAM_PVP then
			local PVPCommon = require("Logic/PVP/PVPCommon")

			if utils.isRobot(msgTable.start_data.spec.mpvp.robot) then
				local formations = PVPCommon.getMultiPvpReplayRobotFormation(msgTable.start_data.spec.mpvp.robot)

				for i, formation in ipairs(formations) do
					table.insert(msgTable.start_data.start_common.formation, formation)
				end
			end
		end

		local replayState = GameFsm.getState(Const.STATE_BATTLE_REPLAY)

		replayState:setServerReplayData(msgTable)
		GameFsm.translateState(Const.STATE_BATTLE_REPLAY)
	end
end

function DebugModule.tryReplayServerBattle(sender, menu, value)
	if REPLAY_INFO[value] then
		NOW_ACTIVE = REPLAY_INFO[value]

		local roomid = NOW_ACTIVE[2]
		local uid = NOW_ACTIVE[3]
		local finalUrl = "%s?uid=%s&roomid=%s"

		finalUrl = string.format(finalUrl, REPLAY_URL_BATTLE, uid, roomid)

		Framework.Network.HttpUtils.GetToFile(finalUrl, GetBattleData, BATTLE_TEMP_FILE)
	end
end

local PLAY_SERVER_MODE = false

local function DirectGetBattleData(result)
	if result == 0 then
		local f = io.open(BATTLE_TEMP_FILE, "rb")
		local battleData = f:read("*all")
		local NetService = require("Network/NetService")

		NetService._initProtobufLib()

		local msgTable = protobuf.decode("datap.BattleData", battleData)

		if msgTable then
			if PLAY_SERVER_MODE then
				local ServerBattleReplay = require("ServerBattle/ServerBattleReplay")

				ServerBattleReplay._onReplayResult(msgTable)
			else
				local replayState = GameFsm.getState(Const.STATE_BATTLE_REPLAY)

				replayState:setServerReplayData(msgTable)
				GameFsm.translateState(Const.STATE_BATTLE_REPLAY)
			end
		end
	end
end

function DebugModule.onDirectQueryPlayerBattle(sender, menu, value)
	local s = utils.splitString(value, ",")

	if #s >= 1 and #s[1] > 5 then
		local roomid = s[1]
		local uid = s[2]

		NOW_UID = nil

		if s[3] then
			PLAY_SERVER_MODE = true
		else
			PLAY_SERVER_MODE = false
		end

		local finalUrl = "%s?uid=%s&roomid=%s"

		finalUrl = string.format(finalUrl, REPLAY_URL_BATTLE, uid, roomid)

		Framework.Network.HttpUtils.GetToFile(finalUrl, DirectGetBattleData, BATTLE_TEMP_FILE)
	else
		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "参数格式", "1.玩家UID,2.类型(dev, ios, aos),3.服务端模式")
	end
end

local TheMatrixClass = require("Common/FrameBattle/TheMatrix")

local function _initConfig(self)
	self:clear()

	if self:isZombieBattle() then
		self.mainDlgName = "battleZombieMainDlg"
	else
		self.mainDlgName = "battleMainDlg"
	end

	self:initObjInfo()

	local input = self:getMatrixInput()

	self.mMatrixInstance = TheMatrixClass(input, false)

	for i = 1, 36000 do
		if self.mMatrixInstance.battleOver then
			local outputQueue = self.mMatrixInstance:getFrameOutput()

			if outputQueue then
				for i, output in pairs(outputQueue) do
					EventCenter.sendEvent(output[1], output[2], unpack(output[3]))
				end
			end

			break
		else
			self.mMatrixInstance:nextFrame()
		end
	end
end

local function startBattleOverAction(self, speResultType, realEnd)
	return
end

local function onBattleResult(self, battleResult)
	local msg = ""

	msg = battleResult[2] == "kPVEResultResultTypeWin" and "胜利" or battleResult[2] == "kPVEResultResultTypeTimeOut" and "超时" or "失败"

	UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "结果", msg, Slot(self.onExitBattle, self))
end

local SwitchBattleInfo = {
	false
}

function DebugModule.switchBattleMode(sender, menu, value)
	local quickMode = value == "快速战斗"

	if SwitchBattleInfo[1] == quickMode then
		return
	end

	local BattleState = require("GameFsm/GameStateBattle")

	if quickMode then
		SwitchBattleInfo[1] = true
		SwitchBattleInfo[2] = BattleState._initConfig
		BattleState._initConfig = _initConfig
		SwitchBattleInfo[3] = BattleState.startBattleOverAction
		BattleState.startBattleOverAction = startBattleOverAction
		SwitchBattleInfo[4] = BattleState.onBattleResult
		BattleState.onBattleResult = onBattleResult
	else
		SwitchBattleInfo[1] = false
		BattleState._initConfig = SwitchBattleInfo[2]
		BattleState.startBattleOverAction = SwitchBattleInfo[3]
		BattleState.onBattleResult = SwitchBattleInfo[4]
	end
end

function DebugModule.winCheatBattle()
	if GameFsm.isInState(Const.STATE_BATTLE) then
		GameFsm.getCurState():onMatrixOver(BattleConst.CAMP_MONSTER, nil)
		GameFsm.getCurState().frameMgr:pause()
	end
end

function DebugModule.changeBattleURL(sender, menu, value)
	REPLAY_URL_ROOM_DEV = "http://" .. value .. "/relay/roomlist"
	REPLAY_URL_ROOM = "http://" .. value .. "/relay/roomlist"
	REPLAY_URL_BATTLE_DEV = "http://" .. value .. "/relay/roomdata"
	REPLAY_URL_BATTLE = "http://" .. value .. "/relay/roomdata"
end

local out = ""
local outReplayId = ""
local num = 0
local fightTime = 0
local ImmediateBattle = require("ServerBattle/ImmediateBattle")

local function runOneReplaceMode(battleStart, resData)
	local battleInitData

	battleInitData = utils.getBattleInitInfo(battleStart)

	local randomSeed = battleInitData.seed
	local battleNo = battleInitData.battleNo
	local pets = battleInitData.pets
	local petEntity

	if pets and pets[1] then
		petEntity = pets[1]
	end

	local speData = battleInitData.speData
	local heros = battleInitData.heros
	local enemyStartRate = resData.enemyStartRate or 1
	local enemyIncRate = resData.enemyIncRate or 0.1
	local tryCount = resData.multiCount or 1
	local enemyAtkStart = enemyStartRate
	local enemyMhpStart = enemyStartRate
	local enemyAtkInc = enemyIncRate
	local enemyMhpInc = enemyIncRate
	local battleType = battleInitData.battleType

	if battleType == "kBattleTypeWorldBoss" then
		local multiDamage = 0

		for i = 1, tryCount do
			local result = ImmediateBattle:startBattle(battleNo, math.random(1000000), heros, 1, 1, speData, petEntity)

			if ImmediateBattle.mMatrixInstance and ImmediateBattle.mMatrixInstance.battleOver then
				multiDamage = multiDamage + math.floor(ImmediateBattle.mMatrixInstance.bObjMgr:getBattleDamage())
			end
		end

		local damage = math.floor(multiDamage / tryCount)
		local spec = battleStart.spec.world_boss.data
		local type = spec.type
		local hard = spec.hard
		local ResWorldBoss = require("ClientData/ResWorldBoss")
		local resData = ResWorldBoss[type][hard]
		local point = math.floor(resData.score_k * damage) + resData.init_score

		out = out .. outReplayId .. "," .. battleNo .. "," .. battleInitData.battleType .. "," .. point .. "," .. ImmediateBattle.mMatrixInstance.bObjMgr:getBattleTime() .. ","

		for k, v in pairs(battleInitData.heros) do
			out = out .. v.heroID .. "," .. v.pos .. ","
		end

		out = out .. "\n"
	else
		local bigInccRate = resData.enemyBigIncRate
		local inc = enemyIncRate

		for index = 0, 200 do
			local passedIndex = index

			inc = inc * 2

			local enhanceAtkValue = enemyAtkStart + inc
			local enhanceMhpValue = enemyMhpStart + inc

			if enhanceAtkValue <= 0 or enhanceMhpValue <= 0 then
				break
			end

			local win = false
			local result = ImmediateBattle:startBattle(battleNo, randomSeed, heros, enhanceAtkValue, enhanceMhpValue, speData, petEntity)

			if ImmediateBattle.mMatrixInstance and ImmediateBattle.mMatrixInstance.battleOver then
				if ImmediateBattle.mMatrixInstance.battleOver ~= BattleConst.BATTLE_OVER_WIN then
					num = num + 1
					fightTime = fightTime + ImmediateBattle.mMatrixInstance.bObjMgr:getBattleTime()

					for count = 1, tryCount do
						local result = ImmediateBattle:startBattle(battleNo, math.random(1000000), heros, enhanceAtkValue, enhanceMhpValue, speData, petEntity)

						if ImmediateBattle.mMatrixInstance and ImmediateBattle.mMatrixInstance.battleOver then
							num = num + 1

							if ImmediateBattle.mMatrixInstance.battleOver == BattleConst.BATTLE_OVER_WIN then
								win = true

								break
							end
						end
					end
				else
					win = true
				end
			end

			if win ~= true or index == 200 then
				out = out .. outReplayId .. "," .. battleNo .. "," .. battleInitData.battleType .. "," .. enhanceAtkValue - inc / 2 .. "," .. ImmediateBattle.mMatrixInstance.bObjMgr:getBattleTime() .. ","

				for k, v in pairs(battleInitData.heros) do
					out = out .. v.heroID .. "," .. v.pos .. ","
				end

				out = out .. "\n"

				break
			end
		end
	end
end

local function replaceHeroData(item, heroID, artifactData, relicData)
	local Artifact = require("Common/Object/Artifact")
	local Relic = require("Common/Object/Relic")
	local hero = item.hero

	if not hero then
		return
	end

	if heroID and heroID ~= 0 then
		hero.base.resid = heroID
	end

	if artifactData and artifactData.resid and artifactData.resid ~= 0 then
		local artifact = item.artifact

		if artifactData.resid then
			artifact.resid = artifactData.resid
		end

		if artifactData.level then
			artifact.level = artifactData.level
		end

		if artifactData.break_level then
			artifact.break_level = artifactData.break_level
		end

		if artifactData.exp then
			artifact.exp = artifactData.exp
		end
	end

	if relicData and relicData.id and relicData.id ~= 0 then
		local relic = item.relic

		if relicData.id then
			relic.id = relicData.id
		end

		if relicData.level then
			relic.level = relicData.level
		end
	end
end

local function replaceServerFormation(battleData, resData)
	local battleStart = battleData.start_data

	out = ""
	outReplayId = tostring("'" .. battleData.replay_id)

	local items = battleStart.start_common.formation[1].item
	local resArtifact = {}
	local resRelic = {}
	local heroID = resData.replaceHeroId

	if resData then
		resArtifact.resid = resData.artifactID
		resArtifact.level = resData.artifactLevel
		resArtifact.break_level = resData.artifactBreakLevel
		resRelic.id = resData.relic_id
		resRelic.level = resData.relic_level
		heroID = resData.replaceHeroId
	end

	local artifactData, relicData
	local resEquipId = resData.replaceEquipId
	local replaceIndex = 1

	if resEquipId then
		local ResBattleToolProp = require("ClientData/ResBattleToolProp")
		local resData = ResBattleToolProp[resEquipId]

		if resData then
			artifactData = {}
			relicData = {}
			artifactData.resid = resData.artifactID
			artifactData.level = resData.artifactLevel
			artifactData.break_level = resData.artifactBreakLevel
			relicData.id = resData.relic_id
			relicData.level = resData.relic_level
		end
	end

	if items then
		for index = 1, #items do
			if index == replaceIndex and items[index] then
				replaceIndex = index + 1

				local hero = items[index].hero
				local recoveryHeroId = hero.base.resid
				local recoveryArtifactData, recoveryRelicData
				local item = items[index]

				if item.relic and item.relic.id then
					recoveryRelicData = {
						id = item.relic.id,
						level = item.relic.level
					}
				end

				if item.artifact and item.artifact.resid then
					local artifact = item.artifact

					recoveryArtifactData = {
						resid = artifact.resid,
						level = artifact.level,
						break_level = artifact.break_level,
						exp = artifact.exp
					}
				end

				replaceHeroData(item, heroID, artifactData, relicData)

				local startNum = num
				local startFight = fightTime
				local startTime = os.time()

				runOneReplaceMode(battleStart, resData)

				local endTime = os.time()

				replaceHeroData(item, recoveryHeroId, recoveryArtifactData, recoveryRelicData)
			end
		end
	end
end

local function _decodeServerData(file)
	local FixedProp = require("Common/FrameBattle/BattleObject/FixedProp")
	local PropHelper = require("Common/FrameBattle/BattleObject/PropHelper")
	local ResSummonAttr = require("ClientData/ResSummonAttr")

	local function _initProperty(self)
		if self.master.monsterID then
			if ResSummonAttr[self.master.monsterID] and self.master.master and self.master.mgr:getObjectByKey(self.master.master) then
				local master = self.master.mgr:getObjectByKey(self.master.master)

				self.props = PropHelper.getSummonAttr(self.master.monsterID, master)
			else
				self.props = PropHelper.getMonsterAttr(self.master.monsterID, 1)

				if self.master.camp == BattleConst.CAMP_MONSTER then
					if self.master.playerinfo.monsterAtkEnhance or self.master.playerinfo.monsterMhpEnhance then
						self.props.fProp_mhp = self.props.fProp_mhp * (self.master.playerinfo.monsterAtkEnhance or 1)
						self.props.fProp_atk = self.props.fProp_atk * (self.master.playerinfo.monsterMhpEnhance or 1)
					else
						self.props.fProp_mhp = self.props.fProp_mhp * self.master.monsterMhpPropRate
						self.props.fProp_atk = self.props.fProp_atk * self.master.monsterPropRate
					end
				end
			end
		elseif self.master.petId then
			self.props = PropHelper.getPetAttrByPet(self.master.pet)
		else
			self.props = PropHelper.getHeroAttrByRobot(self.master.heroID, self.master:getPropLevel(), self.master.step, self.master.star, self.master.robotEquips, self.master.heroArtifact, self.master.heroRelic, self.master.paintData, self.master.relationPointData, self.master.extraProps)

			if self.master.playerinfo.enhanceAtkValue then
				self.props.fProp_atk = self.props.fProp_atk * self.master.playerinfo.enhanceAtkValue
				self.props.e_atk = self.props.e_atk * self.master.playerinfo.enhanceAtkValue
				self.props.fProp_mhp = self.props.fProp_mhp * self.master.playerinfo.enhanceMhpValue
				self.props.e_mhp = self.props.e_mhp * self.master.playerinfo.enhanceMhpValue
			end
		end
	end

	FixedProp.initProperty = _initProperty

	local content = file:read("*all")
	local battleData = content
	local NetService = require("Network/NetService")

	NetService._initProtobufLib()

	local msgTable = protobuf.decode("datap.BattleData", battleData)

	if msgTable then
		return msgTable
	end
end

local function _RunReplace(resData)
	local fileName = resData.fileName

	fileName = "Assets/test"

	local path = fileName .. "/path.txt"
	local pathFile = io.open(path, "r")

	if pathFile then
		local str = ""

		str = str .. "replayID" .. "," .. "battleNo" .. "," .. "battleType" .. "," .. "enHanceNumber" .. "," .. "battleTime" .. ","

		for i = 1, 6 do
			str = str .. "hero" .. i .. "," .. "pos" .. i .. ","
		end

		str = str .. "\n"

		local startTime = os.time()
		local line = pathFile:read()

		while line do
			local filePath = fileName .. "/" .. line .. "/replayData"
			local battleFile = io.open(filePath, "rb")

			if battleFile then
				local battleData = _decodeServerData(battleFile)

				if battleData then
					replaceServerFormation(battleData, resData)

					str = str .. out
				end
			end

			line = pathFile:read()
		end

		local filename = string.format("test_%s.csv", os.date("%m_%d_%H_%M_%S"))
		local file = io.open(filename, "aw")

		if file then
			file:write(str)
			file:close()
		end

		local endTime = os.time()

		pathFile:close()
	end
end

function DebugModule.checkNewHero(sender, menu, value)
	local battleNo = tonumber(value)
	local ResBattleToolMain = require("ClientData/ResBattleToolMain")
	local mainData = ResBattleToolMain[battleNo]

	if mainData then
		_RunReplace(mainData)
	end
end

DebugModule.FUNC_MENU = {
	{
		name = "Demo测试",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.enterDemo
	},
	{
		name = "Demo机器人测试",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.enterRobotDemo
	},
	{
		name = "Demo战斗测试",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.enterBattleTest
	},
	{
		name = "Demo战斗测试AI",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.enterBattleTestAI
	},
	{
		name = "指定英雄入场",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.heroEnterDemo
	},
	{
		name = "暂停/恢复",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.pause
	},
	{
		name = "跳字测试",
		typ = DebugConst.BTN_TYPE_MENU,
		value = {
			{
				name = "类型选择",
				typ = DebugConst.BTN_TYPE_COMBOX,
				func = DebugModule.setNumType,
				value = NUM_TYPES
			},
			{
				name = "数字输入",
				typ = DebugConst.BTN_TYPE_INPUT,
				func = DebugModule.setNum
			},
			{
				name = "跳字",
				typ = DebugConst.BTN_TYPE_INPUT,
				func = DebugModule.playNum
			}
		}
	},
	{
		name = "战斗胜利",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.winBattle
	},
	{
		name = "伤害log显示",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.showDamageCalc
	},
	{
		name = "记录战斗回放",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.recordBattle
	},
	{
		name = "播放战斗回放",
		typ = DebugConst.BTN_TYPE_COMBOX,
		func = DebugModule.tryReplayBattle,
		value = BattleReplayHelper.getAllRecorder()
	},
	{
		name = "查询玩家战斗",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = GetRoomIds
	},
	{
		name = "玩家战斗回放列表",
		typ = DebugConst.BTN_TYPE_COMBOX,
		func = DebugModule.tryReplayServerBattle,
		value = {}
	},
	{
		name = "直接查询房间(方式2)",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.onDirectQueryPlayerBattle
	},
	{
		name = "战斗方式",
		typ = DebugConst.BTN_TYPE_COMBOX,
		func = DebugModule.switchBattleMode,
		value = {
			"正常",
			"快速战斗"
		}
	},
	{
		name = "战斗作弊胜利",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.winCheatBattle
	},
	{
		name = "直接读取战斗",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.directReadBattle
	},
	{
		name = "更改回放网址",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.changeBattleURL
	},
	{
		name = "战斗跑测工具",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.checkNewHero
	}
}

return DebugModule
