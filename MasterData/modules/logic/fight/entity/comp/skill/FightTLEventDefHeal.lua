-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventDefHeal.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventDefHeal", package.seeall)

local FightTLEventDefHeal = class("FightTLEventDefHeal", FightTimelineTrackItem)
local HealEffectType = {
	[FightEnum.EffectType.HEAL] = true,
	[FightEnum.EffectType.HEALCRIT] = true,
	[FightEnum.EffectType.AVERAGELIFE] = true
}

function FightTLEventDefHeal:setContext(tlEventContext)
	self._context = tlEventContext
end

function FightTLEventDefHeal:onTrackStart(fightStepData, duration, paramsArr)
	self.fightStepData = fightStepData
	self._hasRatio = not string.nilorempty(paramsArr[1])
	self._ratio = tonumber(paramsArr[1]) or 0

	for _, actEffectData in ipairs(fightStepData.actEffect) do
		local oneDefender = FightHelper.getEntity(actEffectData.targetId)

		if oneDefender then
			if HealEffectType[actEffectData.effectType] then
				self:_playDefHeal(oneDefender, actEffectData)
			end
		else
			logNormal("defender heal fail, entity not exist: " .. actEffectData.targetId)
		end
	end

	local effectTemplate = paramsArr[2]

	self:_buildSkillEffect(effectTemplate)
	self:_playSkillBehavior()
end

function FightTLEventDefHeal:_playDefHeal(oneDefender, actEffectData)
	if actEffectData.effectType == FightEnum.EffectType.HEAL or actEffectData.effectType == FightEnum.EffectType.HEALCRIT then
		FightDataHelper.playEffectData(actEffectData)

		local numAbs = self:_calcNum(actEffectData.clientId, actEffectData.targetId, actEffectData.effectNum, self._ratio)

		if oneDefender.nameUI then
			oneDefender.nameUI:addHp(numAbs)
		end

		if actEffectData.effectType == FightEnum.EffectType.HEAL then
			if not FightEnum.FloatType.heal then
				local floatType = FightEnum.FloatType.crit_heal

				FightFloatMgr.instance:float(actEffectData.targetId, floatType, numAbs, nil, actEffectData.effectNum1 == 1)
				FightController.instance:dispatchEvent(FightEvent.OnHpChange, oneDefender, numAbs)
			end
		end
	elseif actEffectData.effectType == FightEnum.EffectType.AVERAGELIFE and not actEffectData.hasDoAverageLiveEffect then
		FightDataHelper.playEffectData(actEffectData)

		actEffectData.hasDoAverageLiveEffect = true

		local oldHp = oneDefender.nameUI and oneDefender.nameUI:getHp() or 0
		local newHp = actEffectData.effectNum
		local offsetHp = newHp - oldHp

		if oneDefender.nameUI then
			oneDefender.nameUI:addHp(offsetHp)
		end

		FightController.instance:dispatchEvent(FightEvent.OnHpChange, oneDefender, offsetHp)
	end

	FightController.instance:dispatchEvent(FightEvent.OnTimelineHeal, actEffectData)
end

function FightTLEventDefHeal:_calcNum(actEffectDataId, targetId, effectNum, ratio)
	if self._hasRatio then
		self._context.healFloatNum = self._context.healFloatNum or {}
		self._context.healFloatNum[targetId] = self._context.healFloatNum[targetId] or {}
		self._context.healFloatNum[targetId][actEffectDataId] = self._context.healFloatNum[targetId][actEffectDataId] or {}

		local numTable = self._context.healFloatNum[targetId][actEffectDataId]

		if not numTable.ratio then
			local preRatio = 0

			if not numTable.total then
				local preTotal = 0
				local nowRatio = ratio + preRatio

				nowRatio = nowRatio < 1 and nowRatio or 1

				local num = math.floor(nowRatio * effectNum) - preTotal

				numTable.ratio = ratio + preRatio
				numTable.total = preTotal + num

				return num
			end
		end
	else
		return 0
	end
end

function FightTLEventDefHeal:_buildSkillEffect(effectTemplate)
	self._behaviorTypeDict = nil

	local skillEffectIds = FightStrUtil.instance:getSplitToNumberCache(effectTemplate, "#")

	for _, skillEffectId in ipairs(skillEffectIds) do
		local skillEffectCO = lua_skill_effect.configDict[skillEffectId]

		if skillEffectCO then
			for i = 1, FightEnum.MaxBehavior do
				local behavior = skillEffectCO["behavior" .. i]
				local sp = FightStrUtil.instance:getSplitToNumberCache(behavior, "#")
				local behaviorType = sp[1]

				if sp and #sp > 0 then
					self._behaviorTypeDict = self._behaviorTypeDict or {}
					self._behaviorTypeDict[behaviorType] = true
				end
			end
		else
			logError("技能调用效果不存在" .. skillEffectId)
		end
	end
end

function FightTLEventDefHeal:_playSkillBehavior()
	if not self._behaviorTypeDict then
		return
	end

	FightSkillBehaviorMgr.instance:playSkillBehavior(self.fightStepData, self._behaviorTypeDict, true)
end

return FightTLEventDefHeal
