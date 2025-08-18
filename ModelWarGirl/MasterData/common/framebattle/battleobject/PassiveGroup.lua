-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\FrameBattle\\BattleObject\\PassiveGroup.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local SkillDataBank = require("Common/FrameBattle/BattleObject/SkillDataBank")
local PassiveSkillData = require("ClientData/ResPassiveSkill")
local PassiveEffectData = require("ClientData/ResPassiveEffect")
local BattleStateData = require("Common/FrameBattle/BattleObject/BattleStateData")
local AttackCalc = require("Common/FrameBattle/AttackProcess/AttackCalc")
local ResSkillConfig = require("ClientData/ResSkillConfig")
local ResSkillToCard = require("ClientData/ResSkillToCard")
local CONDITION_TYPE_STATE = 1
local CONDITION_TYPE_HP = 2
local CONDITION_TYPE_CHECK_SHIELD = 3
local CONDITION_TYPE_ATTR_EQUAL = 4
local CONDITION_TYPE_CAMP_OVERCOME = 5
local EFF_PRIOR_BOTTOM = 99
local BasicTriggerEffect = Class("BasicTriggerEffect")

function BasicTriggerEffect:ctor(combatUnit, effectId, effectlevel, attackerId)
	self.effectId = effectId
	self.effectlevel = effectlevel

	local effectData = PassiveEffectData[effectId] or {}
	local data = effectData[effectlevel]
	local triggerType = data.triggerType
	local triggerArgs = data.triggerArgs
	local triggerSubType = data.triggerSubType
	local effectInfo = data.effectInfo
	local clearEffectInfo = data.clearEffectInfo

	self.effPrior = data.effPrior
	self.master = combatUnit
	self.attackerId = attackerId
	self.triggerType = triggerType
	self.triggerSubType = triggerSubType
	self.triggerArgs = triggerArgs
	self.effectInfo = {}
	self.clearEffectInfo = {}

	self:_handleEffectInfo(self.effectInfo, effectInfo)
	self:_handleEffectInfo(self.clearEffectInfo, clearEffectInfo)

	local conditions = data.conditionArgs

	if conditions then
		self.conditions = conditions
		self.conditionType = tonumber(conditions[1])

		if self.conditionType == CONDITION_TYPE_STATE then
			self.conditionStateArgTarget = tonumber(conditions[2])
			self.conditionStateArgStateId = tonumber(conditions[3])
			self.conditionStateArgReverse = tonumber(conditions[4])

			if self.conditionStateArgTarget and self.conditionStateArgStateId then
				self.needCheckCondition = true
			end
		elseif self.conditionType == CONDITION_TYPE_CHECK_SHIELD then
			self.needCheckCondition = true
			self.targetType = tonumber(conditions[2])
			self.checkNoShield = tonumber(conditions[3])
		elseif self.conditionType == CONDITION_TYPE_HP then
			self.conditionHpBase = tonumber(conditions[2])
			self.conditionHpType = tonumber(conditions[3])
			self.conditionHpTarget = tonumber(conditions[4])
			self.conditionHpValue = tonumber(conditions[5])
			self.conditionHpValueType = tonumber(conditions[6])
			self.needCheckCondition = true
		elseif self.conditionType == CONDITION_TYPE_ATTR_EQUAL then
			self.conditionAttrArgTarget = tonumber(conditions[2])
			self.conditionAttrArgAttrName = conditions[3]
			self.conditionAttrArgAttrValue = conditions[4]

			if self.conditionAttrArgTarget and self.conditionAttrArgAttrName and self.conditionAttrArgAttrValue then
				self.needCheckCondition = true
			end
		elseif self.conditionType == CONDITION_TYPE_CAMP_OVERCOME then
			self.needCheckCondition = true
		elseif self.conditionType then
			self.needCheckCondition = true
		end
	end

	self.countShow = data.countShow
	self.nowCount = 0
	self.argNeedCount = 0
	self.isInTriggering = false
	self.triggerCD = data.effect_cd

	if self.triggerCD and self.triggerCD > 0 then
		self.triggerCD = math.floor(self.triggerCD * self.master.framePerSec)
	end

	self:onInit()
end

function BasicTriggerEffect:_handleEffectInfo(container, effectInfo)
	if effectInfo then
		for index, eff in ipairs(effectInfo) do
			local effectType = eff.effectType
			local effectArgs = eff.effectArgs

			if effectType == 1 then
				local skillId = tonumber(effectArgs[1])
				local eventId = tonumber(effectArgs[2])
				local attackerType = tonumber(effectArgs[3])

				table.insert(container, {
					effectType,
					skillId,
					eventId,
					attackerType
				})
			elseif effectType == 2 then
				local targetType = tonumber(effectArgs[1])
				local stateId = tonumber(effectArgs[2])
				local stateLevel = tonumber(effectArgs[3])
				local stateDuration = tonumber(effectArgs[4])

				if stateDuration < 0 then
					stateDuration = BattleConst.STATE_DURATION_UNLIMIT
				end

				table.insert(container, {
					effectType,
					targetType,
					stateId,
					stateLevel,
					stateDuration
				})
			elseif effectType == 3 then
				local cardId = tonumber(effectArgs[1])
				local cardLevel = tonumber(effectArgs[2])
				local triggerCD = tonumber(effectArgs[3])
				local cardUseCD = tonumber(effectArgs[4])

				table.insert(container, {
					effectType,
					cardId,
					cardLevel,
					triggerCD,
					cardUseCD
				})
			end
		end
	end
end

function BasicTriggerEffect:onCheckCondition(target)
	if self.needCheckCondition then
		return utils.onCheckCondition(self.master, self.conditions, target)
	else
		return true
	end
end

function BasicTriggerEffect:onInit()
	return
end

function BasicTriggerEffect:destroy()
	return
end

function BasicTriggerEffect:triggerPassiveEffect(args)
	if not self.isInTriggering then
		self.isInTriggering = true

		self:onTrigger(args)

		self.isInTriggering = false
	end
end

function BasicTriggerEffect:onTrigger(args)
	return
end

function BasicTriggerEffect:onCountChanged()
	if self.countShow then
		self.master:addOutput(BattleConst.MATRIX_EVENT_ENTITY_PASSIVE_COUNT, {
			self.effectId,
			self.effectlevel,
			self.nowCount,
			self.argNeedCount
		})
	end
end

function BasicTriggerEffect:onClearEffect()
	if self.needCheckCondition and not self:onCheckCondition(self.master) then
		return
	end

	for index, effInfo in ipairs(self.clearEffectInfo) do
		local effType = effInfo[1]

		if effType == 1 then
			local attackerType = effInfo[4]

			if attackerType and attackerType == 1 then
				local attacker

				if self.attackerId then
					attacker = self.master.mgr:getObjectByKey(self.attackerId)
				else
					attacker = self.master
				end

				if attacker then
					attacker:triggerSkillEvent(effInfo[2], effInfo[3], self.master.id, nil, self.effectlevel)
				end
			else
				self.master:triggerSkillEvent(effInfo[2], effInfo[3], self.master.id, nil, self.effectlevel)
			end
		elseif effType == 2 then
			-- block empty
		end
	end
end

function BasicTriggerEffect:handleTriggerCd()
	if self.triggerCD and self.triggerCD > 0 then
		local nowFrame = self.master:getRealFrameNum()

		if self.triggerFrame and nowFrame < self.triggerFrame + self.triggerCD then
			return false
		end

		self.triggerFrame = nowFrame
	end

	return true
end

function BasicTriggerEffect:raiseEffect(targetId)
	local effectData = PassiveEffectData[self.effectId] or {}
	local data = effectData[self.effectlevel]

	if data and data.triggerEffectRate and data.triggerEffectRate > 0 and not AttackCalc.onRandomControl(self.master.randomGenerator, data.triggerEffectRate, self.effectlevel, self.master, nil, BattleConst.FAKE_PROB_TYPE_PASSIVE, self.effectId) then
		return
	end

	if data and data.triggerShow then
		self.master:addOutput(BattleConst.MATRIX_EVENT_ENTITY_TRIGGER_PASSIVE, {
			self.effectId,
			self.effectlevel
		})
	end

	if not self:handleTriggerCd() then
		return
	end

	for index, effInfo in ipairs(self.effectInfo) do
		local effType = effInfo[1]

		if effType == 1 then
			if self.holdInfo and self.holdInfo ~= true or self.holdInfo == false then
				return
			end

			targetId = targetId or self.master.id

			if effInfo[2] and effInfo[3] then
				local attackerType = effInfo[4]

				if attackerType and attackerType > 0 then
					local attacker

					if self.attackerId then
						attacker = self.master.mgr:getObjectIncludeAll(self.attackerId)
					else
						attacker = self.master
					end

					if attacker then
						if attackerType == 1 then
							attacker:triggerSkillEvent(effInfo[2], effInfo[3], self.master.id, nil, self.effectlevel)
						elseif attackerType == 2 then
							attacker:triggerSkillEvent(effInfo[2], effInfo[3], targetId, nil, self.effectlevel)
						elseif attackerType == 3 then
							local target = self.master.mgr:getObjectByKey(targetId)

							if target then
								target:triggerSkillEvent(effInfo[2], effInfo[3], self.master.id, nil, self.effectlevel)
							end
						elseif attackerType == 4 then
							attacker:triggerSkillEvent(effInfo[2], effInfo[3], self.master.id, nil, self.effectlevel)
						end
					end
				else
					self.master:triggerSkillEvent(effInfo[2], effInfo[3], targetId, nil, self.effectlevel)
				end
			end
		elseif effType == 2 then
			local target

			if effInfo[2] == 1 then
				if targetId then
					target = self.master.mgr:getObjectByKey(targetId)
				end
			else
				target = self.master
			end

			if target then
				local stateId = effInfo[3]
				local stateLevel = effInfo[4]
				local stateDuration = effInfo[5]

				if self.holdInfo ~= nil then
					local layer = self.holdInfo

					if self.holdInfo == false then
						layer = 0
					elseif self.holdInfo == true then
						layer = 1
					end

					target:setStateLayer(self.master, stateId, stateLevel, stateDuration, layer)
				else
					self.master.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_ATTACK_RESULT, {
						BattleConst.PASSIVE_TRIGGER_ATTACK_STATE,
						target,
						stateId,
						stateLevel
					})
					target:addBattleState(self.master, stateId, stateLevel, stateDuration)
					target.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_BEING_ATTACKED_RESULT, {
						BattleConst.PASSIVE_TRIGGER_ATTACK_STATE,
						self.master,
						stateId,
						stateLevel
					})
				end
			end
		elseif effType == 3 then
			local cardId = effInfo[2]
			local cardLevel = effInfo[3]
			local triggerCD = effInfo[4]
			local cardUseCD = effInfo[5]

			self.master:triggerPassiveCard(cardId, cardLevel, triggerCD, cardUseCD, targetId)
		end
	end
end

local HpChangeTriggerEffect = Class("HpChangeTriggerEffect", BasicTriggerEffect)

function HpChangeTriggerEffect:onInit()
	if self.triggerSubType == 1 then
		self.argLessUnit = tonumber(self.triggerArgs[1])

		self:onCalcLessHp()
	elseif self.triggerSubType == 2 then
		self.conditionHpType = tonumber(self.triggerArgs[1])
		self.conditionHpValueType = tonumber(self.triggerArgs[3])

		if self.conditionHpValueType == 2 then
			self.conditionHpValue = tonumber(self.triggerArgs[2]) / 10000
		else
			self.conditionHpValue = tonumber(self.triggerArgs[2])
		end

		self:onTrigger()
	elseif self.triggerSubType == 3 then
		self.conditionHpType = tonumber(self.triggerArgs[1])
		self.conditionHpValueType = tonumber(self.triggerArgs[3])

		if self.conditionHpValueType == 2 then
			self.conditionHpValue = tonumber(self.triggerArgs[2]) / 10000
		else
			self.conditionHpValue = tonumber(self.triggerArgs[2])
		end

		self:onTrigger()
	elseif self.triggerSubType == 4 then
		self.conditionHpType = tonumber(self.triggerArgs[1])
		self.conditionHpValueType = tonumber(self.triggerArgs[3])
		self.recorderValue = 0

		self.master:recordDamageValue(self.effectId, self.recorderValue)
	end
end

function HpChangeTriggerEffect:onCalcLessHp()
	if self.argLessUnit then
		local hp = self.master.hp
		local mhp = self.master.mhp
		local lessRate = (mhp - hp) / mhp * 10000
		local level = math.floor(lessRate / self.argLessUnit)

		if level and level ~= self.holdInfo then
			self.holdInfo = level

			self:raiseEffect()
		end
	end
end

function HpChangeTriggerEffect:onTrigger(args)
	if self.needCheckCondition and not self:onCheckCondition(self.master) then
		return
	end

	if self.triggerSubType == 1 then
		self:onCalcLessHp()
	elseif self.triggerSubType == 2 or self.triggerSubType == 3 then
		local hp = self.master.hp
		local ok = false
		local value = hp

		if self.conditionHpValueType == 2 then
			local mhp = self.master.mhp

			if mhp and mhp ~= 0 then
				value = hp / mhp
			end
		end

		if self.conditionHpType == 2 then
			ok = value <= self.conditionHpValue
		else
			ok = value >= self.conditionHpValue
		end

		if self.triggerSubType == 2 then
			if ok ~= self.holdInfo then
				self.holdInfo = ok

				self:raiseEffect()
			end
		elseif self.triggerSubType == 3 and ok and ok ~= self.holdInfo then
			self.holdInfo = ok

			self:raiseEffect()
		end
	elseif self.triggerSubType == 4 then
		local attacker = args[1]

		if self.conditionHpType == 1 and attacker and attacker.id == self.master.id then
			return
		end

		if args[4] then
			return
		end

		if not args[2] then
			return
		end

		local preValue = args[2] + (args[3] or 0)
		local nowValue = self.master.hp + self.master.shield

		if self.conditionHpValueType == 1 and nowValue <= preValue then
			return
		elseif self.conditionHpValueType ~= 1 and preValue <= nowValue then
			return
		end

		self.recorderValue = self.recorderValue + math.abs(preValue - nowValue)

		self.master:recordDamageValue(self.effectId, self.recorderValue)
	end
end

local UseSkillTriggerEffect = Class("UseSkillTriggerEffect", BasicTriggerEffect)

function UseSkillTriggerEffect:onInit()
	if self.triggerSubType == 1 then
		self.argUseCardId = tonumber(self.triggerArgs[1])
		self.argNeedCount = tonumber(self.triggerArgs[2])
		self.nowCount = 0
	elseif self.triggerSubType == 2 then
		self.argUseCardType = tonumber(self.triggerArgs[1])
		self.argNeedCount = tonumber(self.triggerArgs[2])
		self.nowCount = 0
	end

	self:onCountChanged()
end

function UseSkillTriggerEffect:onTrigger(args)
	local cardId = args[1]
	local targetId = args[2]
	local attackType = args[3]
	local target = self.master.mgr:getObjectByKey(targetId)

	if self.triggerSubType == 1 then
		if self.needCheckCondition and not self:onCheckCondition(target) then
			return
		end

		if self.argUseCardId == BattleConst.SPECIAL_ID_COMMON_ATTACK then
			if attackType == BattleConst.ATTACK_CA then
				self.nowCount = self.nowCount + 1
			end
		elseif self.argUseCardId == BattleConst.SPECIAL_ID_ANY_SKILL then
			self.nowCount = self.nowCount + 1
		elseif self.argUseCardId == BattleConst.SPECIAL_ID_EXCEPT_COMMON_ATTACK then
			if attackType == BattleConst.ATTACK_SKILL then
				self.nowCount = self.nowCount + 1
			end
		elseif self.argUseCardId == cardId then
			self.nowCount = self.nowCount + 1
		end

		if self.nowCount >= self.argNeedCount then
			self.nowCount = 0

			self:raiseEffect(targetId)
		end

		self:onCountChanged()
	elseif self.triggerSubType == 2 then
		if self.needCheckCondition and not self:onCheckCondition(target) then
			return
		end

		local useCardType

		if cardId and cardId < BattleConst.SKILL_MAX_COMMON_ATTACK then
			useCardType = Const.CARD_TYPE_DAMAGE
		end

		if self.argUseCardType == useCardType then
			self.nowCount = self.nowCount + 1
		end

		if self.nowCount >= self.argNeedCount then
			self.nowCount = 0

			self:raiseEffect(targetId)
		end

		self:onCountChanged()
	end
end

local UseSkillEndTriggerEffect = Class("UseSkillEndTriggerEffect", BasicTriggerEffect)

function UseSkillEndTriggerEffect:onInit()
	if self.triggerSubType == 1 then
		self.argUseCardId = tonumber(self.triggerArgs[1])
		self.argNeedCount = tonumber(self.triggerArgs[2])
		self.nowCount = 0
	elseif self.triggerSubType == 2 then
		self.argUseCardType = tonumber(self.triggerArgs[1])
		self.argNeedCount = tonumber(self.triggerArgs[2])
		self.nowCount = 0
	end

	self:onCountChanged()
end

function UseSkillEndTriggerEffect:onTrigger(args)
	local cardId = args[1]
	local attackType = args[2]

	if self.triggerSubType == 1 then
		if self.needCheckCondition and not self:onCheckCondition() then
			return
		end

		if self.argUseCardId == BattleConst.SPECIAL_ID_COMMON_ATTACK then
			if attackType == BattleConst.ATTACK_CA then
				self.nowCount = self.nowCount + 1
			end
		elseif self.argUseCardId == BattleConst.SPECIAL_ID_ANY_SKILL then
			self.nowCount = self.nowCount + 1
		elseif self.argUseCardId == BattleConst.SPECIAL_ID_EXCEPT_COMMON_ATTACK then
			if attackType == BattleConst.ATTACK_SKILL then
				self.nowCount = self.nowCount + 1
			end
		elseif self.argUseCardId == cardId then
			self.nowCount = self.nowCount + 1
		end

		if self.nowCount >= self.argNeedCount then
			self.nowCount = 0

			self:raiseEffect()
		end

		self:onCountChanged()
	elseif self.triggerSubType == 2 then
		if self.needCheckCondition and not self:onCheckCondition() then
			return
		end

		local useCardType

		if cardId and cardId < BattleConst.SKILL_MAX_COMMON_ATTACK then
			useCardType = Const.CARD_TYPE_DAMAGE
		end

		if self.argUseCardType == useCardType then
			self.nowCount = self.nowCount + 1
		end

		if self.nowCount >= self.argNeedCount then
			self.nowCount = 0

			self:raiseEffect()
		end

		self:onCountChanged()
	end
end

local AttackResultTriggerEffect = Class("AttackResultTriggerEffect", BasicTriggerEffect)

function AttackResultTriggerEffect:onInit()
	if self.triggerSubType == 4 then
		self.argType = tonumber(self.triggerArgs[1])
		self.argNeedSuccess = tonumber(self.triggerArgs[2])
		self.argNeedMulti = tonumber(self.triggerArgs[3])
	elseif self.triggerSubType == 5 then
		self.argType = tonumber(self.triggerArgs[1])
		self.argNeedCount = tonumber(self.triggerArgs[2])
		self.argNeedStateId = tonumber(self.triggerArgs[3])
		self.nowCount = 0
	elseif self.triggerSubType == 6 then
		self.argNeedCount = tonumber(self.triggerArgs[1])
		self.nowCount = 0
	elseif self.triggerSubType == 7 then
		self.argType = tonumber(self.triggerArgs[1])
	elseif self.triggerSubType == 8 then
		self.argType = self.triggerArgs[1]
		self.argNeedCount = tonumber(self.triggerArgs[2])
		self.nowCount = 0
	else
		self.damageResult = true
		self.argRecordType = tonumber(self.triggerArgs[1])
		self.argNeedCount = tonumber(self.triggerArgs[2])
		self.critOnly = tonumber(self.triggerArgs[3])
		self.typeFilter = tonumber(self.triggerArgs[4]) or 0

		if self.triggerSubType == 1 then
			self.nowCount = 0
		elseif self.triggerSubType == 2 then
			self.recorder = {}
		elseif self.triggerSubType == 3 then
			self.nowCount = 0
			self.nowObject = nil
		end
	end

	self:onCountChanged()
end

function AttackResultTriggerEffect:onTrigger(args)
	local resultType = args[1]

	if self.damageResult and resultType == BattleConst.PASSIVE_TRIGGER_ATTACK_HIT_RESULT then
		local target = args[2]
		local damageType = args[3]
		local damage = args[4]
		local crit = args[5]
		local cardId = args[6]
		local skillId = args[8]

		if self.triggerSubType ~= 1 and self.triggerSubType ~= 2 and self.triggerSubType ~= 3 then
			return
		end

		if self.typeFilter == 1 then
			if damageType ~= BattleConst.DAMAGE_TYPE_HEAL then
				return
			end
		elseif self.typeFilter == 0 then
			if not BattleConst.HURT_DICT[damageType] then
				return
			end

			damage = damage[1] + damage[2]
		elseif self.typeFilter == 2 then
			if not BattleConst.HURT_DICT[damageType] then
				return
			end

			damage = damage[1]

			if damage <= 0 then
				return
			end
		elseif self.typeFilter == 3 or self.typeFilter == 4 then
			if not BattleConst.HURT_DICT[damageType] then
				return
			end

			local skillType

			if cardId then
				local cardData = ResSkillConfig[cardId]

				if cardData then
					skillType = cardData[1].skill_type
				end
			elseif skillId and ResSkillToCard[skillId] then
				skillType = ResSkillToCard[skillId].skill_type
			end

			if self.typeFilter == 3 and skillType ~= BattleConst.SKILL_CONFIG_CA then
				return
			end

			if self.typeFilter == 4 and skillType ~= BattleConst.SKILL_CONFIG_SKILL then
				return
			end

			damage = damage[1] + damage[2]
		elseif self.typeFilter == 5 then
			if damageType ~= BattleConst.DAMAGE_TYPE_SHIELD then
				return
			end
		else
			return
		end

		if self.needCheckCondition and not self:onCheckCondition(target) then
			return
		end

		if self.critOnly and self.critOnly > 0 and not crit then
			return
		end

		if self.triggerSubType == 1 then
			if self.argRecordType == 1 then
				self.nowCount = self.nowCount + 1
			else
				self.nowCount = self.nowCount + damage
			end

			if self.nowCount >= self.argNeedCount then
				self.nowCount = 0

				self:raiseEffect(target.id)
			end
		elseif self.triggerSubType == 2 then
			if not self.recorder[target.id] then
				self.recorder[target.id] = 0
			end

			if self.argRecordType == 1 then
				self.recorder[target.id] = self.recorder[target.id] + 1
			else
				self.recorder[target.id] = self.recorder[target.id] + damage
			end

			if self.recorder[target.id] >= self.argNeedCount then
				self.recorder[target.id] = 0

				self:raiseEffect(target.id)
			end
		elseif self.triggerSubType == 3 then
			if self.nowObject ~= target.id then
				self.nowObject = target.id
				self.nowCount = 0
			end

			if self.argRecordType == 1 then
				self.nowCount = self.nowCount + 1
			else
				self.nowCount = self.nowCount + damage
			end

			if self.nowCount >= self.argNeedCount then
				self.nowCount = 0

				self:raiseEffect(target.id)
			end
		end
	elseif resultType == BattleConst.PASSIVE_TRIGGER_ATTACK_DISPEL and self.triggerSubType == 4 then
		local target = args[2]

		if self.needCheckCondition and not self:onCheckCondition(target) then
			return
		end

		local dispelType = args[3]
		local dispelNum = args[4]

		if self.argType == 0 or self.argType == dispelType then
			if self.argNeedSuccess and self.argNeedSuccess > 0 then
				if dispelNum and dispelNum > 0 then
					if self.argNeedMulti and self.argNeedMulti > 0 then
						for i = 1, dispelNum do
							self:raiseEffect(target.id)
						end
					else
						self:raiseEffect(target.id)
					end
				end
			else
				self:raiseEffect(target.id)
			end
		end
	elseif resultType == BattleConst.PASSIVE_TRIGGER_ATTACK_STATE and self.triggerSubType == 5 then
		local target = args[2]

		if self.needCheckCondition and not self:onCheckCondition(target) then
			return
		end

		local stateId = args[3]
		local stateLevel = args[4]

		if self.argType == 0 then
			self.nowCount = self.nowCount + 1
		elseif self.argType == 1 then
			local stateData = BattleStateData.getStateData(stateId, stateLevel)

			if stateData and stateData.state_type == BattleConst.STATE_TYPE_BUFF then
				self.nowCount = self.nowCount + 1
			end
		elseif self.argType == 2 then
			local stateData = BattleStateData.getStateData(stateId, stateLevel)

			if stateData and stateData.state_type == BattleConst.STATE_TYPE_DEBUFF then
				self.nowCount = self.nowCount + 1
			end
		elseif self.argType == 3 and stateId == self.argNeedStateId then
			self.nowCount = self.nowCount + 1
		end

		if self.nowCount >= self.argNeedCount then
			self.nowCount = 0

			self:raiseEffect(target.id)
		end
	elseif resultType == BattleConst.PASSIVE_TRIGGER_ATTACK_KILL and self.triggerSubType == 6 then
		local target = args[2]

		if self.needCheckCondition and not self:onCheckCondition(target) then
			return
		end

		self.nowCount = self.nowCount + 1

		if self.nowCount >= self.argNeedCount then
			self.nowCount = 0

			self:raiseEffect(target.id)
		end
	elseif resultType == BattleConst.PASSIVE_TRIGGER_ATTACK_MANA and self.triggerSubType == 7 then
		local mana = args[2]

		if mana and mana > 0 then
			self:raiseEffect()
		end
	elseif resultType == BattleConst.PASSIVE_TRIGGER_ATTACK_CONTROLLED and self.triggerSubType == 8 then
		local target = args[2]

		if self.needCheckCondition and not self:onCheckCondition(target) then
			return
		end

		local hitedFlag = args[3]

		if self.argType == nil or self.argType == "" or self.argType == hitedFlag then
			self.nowCount = self.nowCount + 1

			if self.nowCount >= self.argNeedCount then
				self.nowCount = 0

				self:raiseEffect(target.id)
			end
		end
	end

	self:onCountChanged()
end

local BeingAttackedResultTriggerEffect = Class("BeingAttackedResultTriggerEffect", BasicTriggerEffect)

function BeingAttackedResultTriggerEffect:onInit()
	if self.triggerSubType == 1 then
		self.argRecordType = tonumber(self.triggerArgs[1])
		self.argNeedCount = tonumber(self.triggerArgs[2])

		if self.argRecordType == 3 then
			self.argNeedCount = self.master.mhp * self.argNeedCount * 0.0001
		end

		self.critOnly = tonumber(self.triggerArgs[3])
		self.typeFilter = tonumber(self.triggerArgs[4]) or 0
		self.selfFilter = tonumber(self.triggerArgs[5]) or 0
		self.specialFilter = tonumber(self.triggerArgs[6]) or 0
		self.conditionFilter = tonumber(self.triggerArgs[7]) or 0
		self.conditionFilterArg = tonumber(self.triggerArgs[8]) or 0

		if self.conditionFilterArg > 0 then
			self.conditionFilterArg = self.conditionFilterArg * 0.0001
		end

		self.nowCount = 0
	elseif self.triggerSubType == 2 then
		self.argNeedCount = tonumber(self.triggerArgs[1])
		self.nowCount = 0
	elseif self.triggerSubType == 3 then
		self.argNeedCount = tonumber(self.triggerArgs[1])
		self.nowCount = 0
	elseif self.triggerSubType == 4 then
		self.argNeedCount = tonumber(self.triggerArgs[1])
		self.typeFilter = tonumber(self.triggerArgs[2]) or 0
		self.nowCount = 0
	elseif self.triggerSubType == 5 then
		self.argNeedCount = tonumber(self.triggerArgs[1])
		self.nowCount = 0
	elseif self.triggerSubType == 6 then
		self.argType = tonumber(self.triggerArgs[1])
		self.argNeedCount = tonumber(self.triggerArgs[2])
		self.argNeedStateId = tonumber(self.triggerArgs[3])
		self.nowCount = 0
	elseif self.triggerSubType == 7 then
		self.argRecordType = tonumber(self.triggerArgs[1])
		self.argNeedCount = tonumber(self.triggerArgs[2])
		self.argAddCount = tonumber(self.triggerArgs[3]) or 0

		if self.argRecordType == 2 then
			self.argNeedCount = self.master.mhp * self.argNeedCount * 0.0001
			self.argAddCount = self.master.mhp * self.argAddCount * 0.0001
		end

		self.typeFilter = tonumber(self.triggerArgs[4]) or 0
		self.nowCount = 0
		self.effectCount = 0

		self.master:addOutput(BattleConst.MATRIX_EVENT_SPECIAL_DAMAGE_RECORD, {
			true,
			{
				self.typeFilter
			}
		})
	end

	self:onCountChanged()
end

function BeingAttackedResultTriggerEffect:onTrigger(args)
	local resultType = args[1]

	if resultType == BattleConst.PASSIVE_TRIGGER_ATTACK_KILL then
		local attacker = args[2]

		if self.triggerSubType == 3 then
			if self.needCheckCondition and not self:onCheckCondition(attacker) then
				return
			end

			self.nowCount = self.nowCount + 1

			if self.nowCount >= self.argNeedCount then
				self.nowCount = 0

				self:raiseEffect(attacker.id)
			end
		end
	elseif resultType == BattleConst.PASSIVE_TRIGGER_ATTACK_HIT_RESULT then
		local attacker = args[2]
		local damageType = args[3]
		local damage = args[4]
		local crit = args[5]
		local cardId = args[6]
		local block = args[7]
		local skillId = args[8]

		if damageType == BattleConst.DAMAGE_TYPE_MISS then
			if self.triggerSubType == 2 then
				if self.needCheckCondition and not self:onCheckCondition(attacker) then
					return
				end

				self.nowCount = self.nowCount + 1

				if self.nowCount >= self.argNeedCount then
					self.nowCount = 0

					self:raiseEffect(attacker.id)
				end
			end
		elseif self.triggerSubType == 5 then
			if damageType == BattleConst.DAMAGE_TYPE_HURT_IMMUE then
				if self.needCheckCondition and not self:onCheckCondition(attacker) then
					return
				end

				self.nowCount = self.nowCount + 1

				if self.nowCount >= self.argNeedCount then
					self.nowCount = 0

					self:raiseEffect(attacker.id)
				end
			end
		elseif self.triggerSubType == 1 then
			if self.needCheckCondition and not self:onCheckCondition(attacker) then
				return
			end

			if self.critOnly and self.critOnly > 0 and not crit then
				return
			end

			if self.specialFilter and self.specialFilter == 1 and not block then
				return
			end

			if self.selfFilter == 1 and attacker.id ~= self.master.id then
				return
			elseif self.selfFilter == 2 and attacker.id == self.master.id then
				return
			end

			if self.typeFilter == 1 then
				if damageType ~= BattleConst.DAMAGE_TYPE_HEAL then
					return
				end
			elseif self.typeFilter == 0 then
				if not BattleConst.HURT_DICT[damageType] then
					return
				end

				damage = damage[1] + damage[2]
			elseif self.typeFilter == 2 then
				if not BattleConst.HURT_DICT[damageType] then
					return
				end

				damage = damage[1]

				if damage <= 0 then
					return
				end
			elseif self.typeFilter == 3 then
				if not BattleConst.HURT_DICT[damageType] then
					return
				end

				damage = damage[1]

				if damage <= 0 then
					return
				end

				if self.master and self.master.mhp and self.master.mhp > 0 then
					damage = math.floor(damage / self.master.mhp * 10000)
				end
			elseif self.typeFilter == 4 then
				if not BattleConst.HURT_DICT[damageType] then
					return
				end

				local skillType

				if cardId then
					local cardData = ResSkillConfig[cardId]

					if cardData then
						skillType = cardData[1].skill_type
					end
				elseif skillId and ResSkillToCard[skillId] then
					skillType = ResSkillToCard[skillId].skill_type
				end

				if skillType ~= BattleConst.SKILL_CONFIG_CA then
					return
				end

				damage = damage[1] + damage[2]
			elseif self.typeFilter == 5 then
				if damageType ~= BattleConst.DAMAGE_TYPE_SHIELD then
					return
				end
			elseif self.typeFilter == 6 then
				if damageType ~= BattleConst.DAMAGE_TYPE_HURT_ICE then
					return
				end

				damage = damage[1] + damage[2]
			elseif self.typeFilter == 7 then
				if damageType ~= BattleConst.DAMAGE_TYPE_HURT_FIRE then
					return
				end

				damage = damage[1] + damage[2]
			elseif self.typeFilter == 8 then
				if damageType ~= BattleConst.DAMAGE_TYPE_HURT_ICE and damageType ~= BattleConst.DAMAGE_TYPE_HURT_FIRE then
					return
				end

				damage = damage[1] + damage[2]
			else
				return
			end

			if self.conditionFilter == 1 and damage < self.master.mhp * self.conditionFilterArg then
				return
			elseif self.conditionFilter == 2 and damage > self.master.mhp * self.conditionFilterArg then
				return
			end

			if self.argRecordType == 1 then
				self.nowCount = self.nowCount + 1
			else
				self.nowCount = self.nowCount + damage
			end

			if self.nowCount >= self.argNeedCount then
				self.nowCount = 0

				self:raiseEffect(attacker.id)
			end
		end
	elseif resultType == BattleConst.PASSIVE_TRIGGER_ATTACK_CONTROLLED then
		if self.triggerSubType == 4 then
			if self.needCheckCondition and not self:onCheckCondition() then
				return
			end

			local hitedFlag = args[2]
			local enterType = args[3]

			if self.typeFilter ~= enterType then
				return
			end

			self.nowCount = self.nowCount + 1

			if self.nowCount >= self.argNeedCount then
				self.nowCount = 0

				self:raiseEffect()
			end
		end
	elseif resultType == BattleConst.PASSIVE_TRIGGER_ATTACK_STATE and self.triggerSubType == 6 then
		local target = args[2]

		if self.needCheckCondition and not self:onCheckCondition(target) then
			return
		end

		local stateId = args[3]
		local stateLevel = args[4]

		if self.argType == 0 then
			self.nowCount = self.nowCount + 1
		elseif self.argType == 1 then
			local stateData = BattleStateData.getStateData(stateId, stateLevel)

			if stateData and stateData.state_type == BattleConst.STATE_TYPE_BUFF then
				self.nowCount = self.nowCount + 1
			end
		elseif self.argType == 2 then
			local stateData = BattleStateData.getStateData(stateId, stateLevel)

			if stateData and stateData.state_type == BattleConst.STATE_TYPE_DEBUFF then
				self.nowCount = self.nowCount + 1
			end
		elseif self.argType == 3 and stateId == self.argNeedStateId then
			self.nowCount = self.nowCount + 1
		end

		if self.nowCount >= self.argNeedCount then
			self.nowCount = 0

			self:raiseEffect(target.id)
		end
	elseif resultType == BattleConst.PASSIVE_TRIGGER_SPECIAL_DAMAGE and self.triggerSubType == 7 then
		local attacker = args[2]
		local damageType = args[3]
		local damage = args[4]

		if self.needCheckCondition and not self:onCheckCondition(attacker) then
			return
		end

		if self.typeFilter == 1 then
			if damageType ~= BattleConst.DAMAGE_TYPE_HURT_ICE then
				return
			end

			damage = damage[1] + damage[2]
		elseif self.typeFilter == 2 then
			if damageType ~= BattleConst.DAMAGE_TYPE_HURT_FIRE then
				return
			end

			damage = damage[1] + damage[2]
		elseif self.typeFilter == 3 then
			if damageType ~= BattleConst.DAMAGE_TYPE_HURT_ICE and damageType ~= BattleConst.DAMAGE_TYPE_HURT_FIRE then
				return
			end

			damage = damage[1] + damage[2]
		else
			return
		end

		local triggerOK = false

		self.nowCount = self.nowCount + damage

		if self.nowCount >= self.argNeedCount then
			triggerOK = true
			self.effectCount = self.effectCount + 1
			self.nowCount = self.nowCount - self.argNeedCount

			self:raiseEffect(attacker.id)

			self.argNeedCount = self.argNeedCount + self.argAddCount
		end

		self.master:addOutput(BattleConst.MATRIX_EVENT_SPECIAL_DAMAGE_RECORD, {
			false,
			{
				self.nowCount,
				self.argNeedCount,
				triggerOK,
				self.effectCount
			}
		})
	end

	self:onCountChanged()
end

local ImmediatelyTriggerEffect = Class("ImmediatelyTriggerEffect", BasicTriggerEffect)

function ImmediatelyTriggerEffect:onInit()
	if self.needCheckCondition and not self:onCheckCondition(nil) then
		return
	end

	self:raiseEffect()
end

local ShieldTriggerEffect = Class("ShieldTriggerEffect", BasicTriggerEffect)

function ShieldTriggerEffect:onInit()
	if self.triggerSubType == 1 then
		self.argConditionType = tonumber(self.triggerArgs[1])

		self:onCheckShield()
	end
end

function ShieldTriggerEffect:onCheckShield()
	if self.needCheckCondition and not self:onCheckCondition(nil) then
		return
	end

	local shield = self.master.shield

	if self.triggerSubType == 1 then
		local conditionCoincidence = false

		if self.argConditionType == 1 and shield > 0 then
			conditionCoincidence = true
		elseif self.argConditionType == 2 and shield <= 0 then
			conditionCoincidence = true
		end

		if conditionCoincidence ~= self.holdInfo then
			self.holdInfo = conditionCoincidence

			self:raiseEffect()
		end
	end
end

function ShieldTriggerEffect:onTrigger(args)
	if self.triggerSubType == 1 then
		self:onCheckShield()
	end
end

local DeathTriggerEffect = Class("DeathTriggerEffect", BasicTriggerEffect)

function DeathTriggerEffect:onInit()
	if self.triggerSubType == 1 then
		self.argRecordType = tonumber(self.triggerArgs[1])
		self.argNeedCount = tonumber(self.triggerArgs[2])
		self.argObjFilter = tonumber(self.triggerArgs[3])
		self.nowCount = 0
	end

	self:onCountChanged()
end

function DeathTriggerEffect:onTrigger(args)
	local target = args[1]

	if self.needCheckCondition and not self:onCheckCondition(target) then
		return
	end

	if self.triggerSubType == 1 then
		if self.argObjFilter == 1 and target.master then
			return
		elseif self.argObjFilter == 2 and not target.master then
			return
		end

		local deathCamp = target.camp

		if self.argRecordType == 1 then
			if self.master.camp ~= deathCamp then
				self.nowCount = self.nowCount + 1
			end
		elseif self.argRecordType == 2 then
			if self.master.camp == deathCamp then
				self.nowCount = self.nowCount + 1
			end
		else
			self.nowCount = self.nowCount + 1
		end

		if self.nowCount >= self.argNeedCount then
			self.nowCount = 0

			self:raiseEffect(target.id)
		end
	end

	self:onCountChanged()
end

local WinTriggerEffect = Class("WinTriggerEffect", BasicTriggerEffect)

function WinTriggerEffect:onInit()
	return
end

function WinTriggerEffect:onTrigger(args)
	if self.needCheckCondition and not self:onCheckCondition() then
		return
	end

	self:raiseEffect()
end

local SimpleEventTriggerEffect = Class("SimpleEventTriggerEffect", BasicTriggerEffect)

function SimpleEventTriggerEffect:onInit()
	if self.triggerSubType == 1 then
		self.argNeedCount = tonumber(self.triggerArgs[1])
		self.nowCount = 0
	elseif self.triggerSubType == 2 then
		self.skillCamp = tonumber(self.triggerArgs[1])
		self.skillAttacker = tonumber(self.triggerArgs[2])
		self.camp = self.master.camp
	elseif self.triggerSubType == 3 then
		self.camp = self.master.camp
		self.filterCamp = tonumber(self.triggerArgs[1])
	elseif self.triggerSubType == 5 then
		self.filterCamp = tonumber(self.triggerArgs[1])
		self.filterUnit = tonumber(self.triggerArgs[2])

		self:checkLayerTypeCount()
	elseif self.triggerSubType == 6 then
		self.argNeedCount = tonumber(self.triggerArgs[1])
		self.nowCount = 0
	elseif self.triggerSubType == 7 then
		self.argNeedCount = tonumber(self.triggerArgs[1])
		self.nowCount = 0
	elseif self.triggerSubType == 8 then
		self.camp = self.master.camp
		self.rebornType = tonumber(self.triggerArgs[1])
		self.targetType = tonumber(self.triggerArgs[2])
	end
end

function SimpleEventTriggerEffect:checkLayerTypeCount(targetId)
	if self.triggerSubType ~= 5 then
		return
	end

	local num = self.master.mgr:countPlayerNum(self.filterCamp, self.filterUnit, self.master)

	if self.holdInfo ~= num then
		self.holdInfo = num

		self:raiseEffect(targetId)
	end
end

function SimpleEventTriggerEffect:onTrigger(args)
	local eventType = args[1]
	local target = args[2]

	if self.triggerSubType == 1 and eventType == BattleConst.ENTITY_SOMETHING_IMMUE_PHYSICS then
		if self.needCheckCondition and not self:onCheckCondition(target) then
			return
		end

		self.nowCount = self.nowCount + 1

		if self.nowCount >= self.argNeedCount then
			self.nowCount = 0

			self:raiseEffect()
		end

		self:onCountChanged()
	elseif self.triggerSubType == 2 and eventType == BattleConst.PASSIVE_TRIGGER_SIMPLE_EVENT_SKILL then
		if self.needCheckCondition and not self:onCheckCondition(target) then
			return
		end

		if self.skillCamp == 1 and self.camp == target.camp or self.skillCamp == 2 and self.camp ~= target.camp then
			return
		end

		if self.skillAttacker ~= 1 and target.id == self.master.id then
			return
		end

		self:raiseEffect(target.id)
	elseif self.triggerSubType == 3 and eventType == BattleConst.PASSIVE_TRIGGER_SIMPLE_EVENT_SUMMON then
		if self.needCheckCondition and not self:onCheckCondition(target) then
			return
		end

		local summonMaster = args[3]

		if self.filterCamp == 1 and self.camp == summonMaster.camp then
			return
		elseif self.filterCamp == 0 and self.camp ~= summonMaster.camp then
			return
		elseif self.filterCamp == 2 and self.master.id ~= summonMaster.id then
			return
		end

		self:raiseEffect(target.id)
	elseif self.triggerSubType == 4 and eventType == BattleConst.PASSIVE_TRIGGER_SIMPLE_MANA_ZERO then
		if self.needCheckCondition and not self:onCheckCondition(target) then
			return
		end

		self:raiseEffect()
	elseif self.triggerSubType == 5 and eventType == BattleConst.PASSIVE_TRIGGER_SIMPLE_PLAYER_NUM then
		if self.needCheckCondition and not self:onCheckCondition(target) then
			return
		end

		self:checkLayerTypeCount(target.id)
	elseif self.triggerSubType == 6 and eventType == BattleConst.STATE_IMMUNE_DEBUFF then
		if self.needCheckCondition and not self:onCheckCondition(target) then
			return
		end

		self.nowCount = self.nowCount + 1

		if self.nowCount >= self.argNeedCount then
			self.nowCount = 0

			self:raiseEffect()
		end

		self:onCountChanged()
	elseif self.triggerSubType == 7 and eventType == BattleConst.STATE_IMMUNE_CONTROLLED then
		if self.needCheckCondition and not self:onCheckCondition(target) then
			return
		end

		self.nowCount = self.nowCount + 1

		if self.nowCount >= self.argNeedCount then
			self.nowCount = 0

			self:raiseEffect()
		end

		self:onCountChanged()
	elseif self.triggerSubType == 8 and eventType == BattleConst.PASSIVE_TRIGGER_SIMPLE_EVENT_REBORN then
		local deadMan = args[2]
		local attacker = args[3]

		if self.targetType == 1 then
			target = attacker
		end

		if self.needCheckCondition and not self:onCheckCondition(target) then
			return
		end

		if self.rebornType == 1 and self.camp ~= deadMan.camp then
			return
		elseif self.rebornType == 2 and self.camp == deadMan.camp then
			return
		elseif self.rebornType == 3 and self.master.id ~= attacker.id then
			return
		elseif self.rebornType == 4 and self.master.id ~= deadMan.id then
			return
		end

		self:raiseEffect(target.id)
	end
end

local TRIGGER_CLASS_CONFIG = {
	[BattleConst.PASSIVE_TRIGGER_TYPE_HP_CHANGE] = HpChangeTriggerEffect,
	[BattleConst.PASSIVE_TRIGGER_TYPE_USE_CARD] = UseSkillTriggerEffect,
	[BattleConst.PASSIVE_TRIGGER_TYPE_ATTACK_RESULT] = AttackResultTriggerEffect,
	[BattleConst.PASSIVE_TRIGGER_TYPE_BEING_ATTACKED_RESULT] = BeingAttackedResultTriggerEffect,
	[BattleConst.PASSIVE_TRIGGER_TYPE_IMMEDIATELY] = ImmediatelyTriggerEffect,
	[BattleConst.PASSIVE_TRIGGER_TYPE_SHIELD] = ShieldTriggerEffect,
	[BattleConst.PASSIVE_TRIGGER_TYPE_DEAD] = DeathTriggerEffect,
	[BattleConst.PASSIVE_TRIGGER_TYPE_GAME_WIN] = WinTriggerEffect,
	[BattleConst.PASSIVE_TRIGGER_TYPE_SIMPLE_EVENT] = SimpleEventTriggerEffect,
	[BattleConst.PASSIVE_TRIGGER_TYPE_USE_CARD_END] = UseSkillEndTriggerEffect
}
local strClassName = "PassiveSkillGroup"
local PassiveSkillGroup = Class(strClassName)

function PassiveSkillGroup:ctor(combatUnit)
	self.master = combatUnit
	self.passiveSkills = {}
	self.passiveEffects = {}
end

function PassiveSkillGroup:destroy()
	return
end

function PassiveSkillGroup:clear()
	self.passiveSkills = {}
	self.passiveEffects = {}
end

local function SortOfEffectId(a, b)
	if a.effPrior ~= b.effPrior then
		if a.effPrior == EFF_PRIOR_BOTTOM then
			return false
		elseif b.effPrior == EFF_PRIOR_BOTTOM then
			return true
		end
	end

	if a and a.effectId and b and b.effectId then
		return a.effectId < b.effectId
	end
end

function PassiveSkillGroup:addSkill(skillId, skillLevel, attackerId)
	if not self.master:isAlive() then
		return
	end

	if self.passiveSkills[skillId] then
		return
	end

	local effects = self:_getPassiveEffects(skillId, skillLevel, attackerId)

	for index, effect in ipairs(effects) do
		if not self.passiveEffects[effect.triggerType] then
			self.passiveEffects[effect.triggerType] = {}
		end

		local alreadyHad = false

		for order, eff in ipairs(self.passiveEffects[effect.triggerType]) do
			if eff and eff.effectId == effect.effectId then
				alreadyHad = true

				break
			end
		end

		if not alreadyHad then
			table.insert(self.passiveEffects[effect.triggerType], effect)
			table.sort(self.passiveEffects[effect.triggerType], SortOfEffectId)
		end
	end

	if #effects > 0 then
		self.passiveSkills[skillId] = effects
	end
end

function PassiveSkillGroup:delSkill(skillId, skillLevel)
	local effects = self.passiveSkills[skillId]

	if effects then
		for index, effect in ipairs(effects) do
			effect:onClearEffect()

			local typeEffects = self.passiveEffects[effect.triggerType]

			if typeEffects then
				for order, eff in ipairs(typeEffects) do
					if eff.effectId == effect.effectId then
						table.remove(typeEffects, order)
					end
				end
			end
		end
	end

	self.passiveSkills[skillId] = nil
end

function PassiveSkillGroup:_getPassiveEffects(skillId, skillLevel, attackerId)
	local output = {}
	local skillData = PassiveSkillData[skillId] or {}
	local levelData = skillData[skillLevel] or {}
	local effects = levelData.effects

	if effects then
		for index, einfo in ipairs(effects) do
			local eid = einfo.effectId
			local elevel = einfo.effectlevel
			local effect = self:_handlePassiveEffect(eid, elevel, attackerId)

			if effect then
				table.insert(output, effect)
			end
		end
	end

	return output
end

function PassiveSkillGroup:_handlePassiveEffect(effectId, effectlevel, attackerId)
	local effectData = PassiveEffectData[effectId] or {}
	local data = effectData[effectlevel]

	if data then
		if data.reborn_disable == 1 and self.master.inReborn then
			return
		end

		local triggerType = data.triggerType
		local class = TRIGGER_CLASS_CONFIG[triggerType]

		if class then
			local effect = class(self.master, effectId, effectlevel, attackerId)

			return effect
		end
	end
end

function PassiveSkillGroup:onPassiveTrigger(triggerType, args)
	if self.passiveEffects[triggerType] then
		local OrderEffects = {}

		for order, effect in ipairs(self.passiveEffects[triggerType]) do
			table.insert(OrderEffects, effect)
		end

		for _, effect in ipairs(OrderEffects) do
			effect:triggerPassiveEffect(args)
		end
	end
end

return PassiveSkillGroup
