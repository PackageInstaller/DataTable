-- chunkname: @modules/logic/versionactivity3_9/hedone/controller/skill/HedoneSkill.lua

module("modules.logic.versionactivity3_9.hedone.controller.skill.HedoneSkill", package.seeall)

local HedoneSkill = class("HedoneSkill")

function HedoneSkill:ctor(uid, skillId, unitMO)
	self._uid = uid
	self._id = skillId
	self._unitMO = unitMO
	self._baseCD = HedoneConfig.instance:getHedoneSkillCd(self._id)
	self._skillType = HedoneConfig.instance:getHedoneSkillType(self._id)
	self._remainCD = 0

	self:_updateTotalCD()

	self._triggerList = {}
	self._triggerPoint2TriggerDict = {}

	local cfg = HedoneConfig.instance:getHedoneSkillCfg(self._id, true)

	if cfg then
		for i = 1, HedoneGameEnum.Const.SkillCfgMaxKeyIndex do
			local trigger = HedoneGameHelper.createTrigger(self._uid, self._id, i)

			if trigger then
				self._triggerList[#self._triggerList + 1] = trigger

				local triggerPointWithParam = trigger:getTriggerPointWithParam()
				local list = GameUtil.tabletool_checkDictTable(self._triggerPoint2TriggerDict, triggerPointWithParam)

				list[#list + 1] = trigger
			end
		end
	end

	self:setState(HedoneGameEnum.SkillState.Ready)
end

function HedoneSkill:onUpdateRemainCD(deltaTime)
	local state = self:getState()

	if state ~= HedoneGameEnum.SkillState.Cooldown then
		return
	end

	self._remainCD = self._remainCD <= HedoneGameEnum.Const.SkillCDEPS and 0 or math.max(0, self._remainCD - deltaTime)

	if self._remainCD == 0 then
		self:setState(HedoneGameEnum.SkillState.Ready)
	end
end

function HedoneSkill:onCDAttributeChange()
	if not self._totalCD then
		self:_updateTotalCD()

		local state = self:getState()

		if state ~= HedoneGameEnum.SkillState.Cooldown then
			return
		end

		self._remainCD = self._remainCD * (self._totalCD / self._totalCD)

		if self._remainCD <= HedoneGameEnum.Const.SkillCDEPS then
			self._remainCD = 0
		end
	end
end

function HedoneSkill:_updateTotalCD()
	local globalSkillCDAttr = 0
	local skillCDAttr = 0

	if self._unitMO then
		globalSkillCDAttr = self._unitMO:getAttrValue(HedoneGameEnum.Attribute.GlobalSkillCD)
		skillCDAttr = self._unitMO:getAttrValue(HedoneGameEnum.Attribute.SkillCD, self._skillType)
	end

	self._totalCD = self._baseCD

	local cdFactor = 1 + (globalSkillCDAttr + skillCDAttr) / HedoneGameEnum.Const.PercentBase

	if cdFactor > 0 then
		self._totalCD = self._baseCD / cdFactor
	end
end

function HedoneSkill:enterCD()
	self._remainCD = self._totalCD

	self:setState(HedoneGameEnum.SkillState.Cooldown)
end

function HedoneSkill:resetRemainCD()
	self._remainCD = 0
end

function HedoneSkill:setState(state)
	self._state = state
end

function HedoneSkill:tryTriggerCast(triggerPointWithParam, context, needHaveCD)
	needHaveCD = not not needHaveCD

	local hasCfgCD = self:getHasCfgCD()

	if hasCfgCD ~= needHaveCD or string.nilorempty(triggerPointWithParam) then
		return
	end

	local haveTrigger = false
	local triggerList = self._triggerPoint2TriggerDict[triggerPointWithParam]

	if not triggerList then
		return
	end

	for _, trigger in ipairs(triggerList) do
		local result = trigger:tryTrigger(context)

		if result then
			haveTrigger = true
		end
	end

	return haveTrigger
end

function HedoneSkill:triggerEffectDirectly(triggerIndex, context)
	local trigger = triggerIndex and self._triggerList[triggerIndex]

	if trigger then
		trigger:hitEffect(context)
	end
end

function HedoneSkill:getUid()
	return self._uid
end

function HedoneSkill:getId()
	return self._id
end

function HedoneSkill:getHasCfgCD()
	return self._baseCD and self._baseCD > 0
end

function HedoneSkill:getCDProgress()
	local eps = HedoneGameEnum.Const.SkillCDEPS

	if eps >= self._totalCD or eps >= self._remainCD then
		return 0
	end

	return GameUtil.clamp(self._remainCD / self._totalCD, 0, 1)
end

function HedoneSkill:getCDSkillCanCast()
	local hasCfgCD = self:getHasCfgCD()

	if not hasCfgCD then
		return
	end

	local state = self:getState()
	local cdProgress = self:getCDProgress()

	return cdProgress <= 0 and state == HedoneGameEnum.SkillState.Ready
end

function HedoneSkill:getRemainCD()
	return self._remainCD
end

function HedoneSkill:getEffectIdList()
	local result = {}

	for _, trigger in ipairs(self._triggerList) do
		local effect = trigger:getEffect()
		local effectId = effect and effect:getId()

		if effectId then
			result[#result + 1] = effectId
		end
	end

	return result
end

function HedoneSkill:getSkillType()
	return self._skillType
end

function HedoneSkill:getState()
	return self._state
end

function HedoneSkill:getTriggerPoint2TriggerDict()
	return self._triggerPoint2TriggerDict
end

return HedoneSkill
