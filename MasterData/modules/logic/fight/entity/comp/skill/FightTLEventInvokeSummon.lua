-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventInvokeSummon.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventInvokeSummon", package.seeall)

local FightTLEventInvokeSummon = class("FightTLEventInvokeSummon", FightTimelineTrackItem)

function FightTLEventInvokeSummon:onTrackStart(fightStepData, duration, paramsArr)
	self.summonList = {}

	self:getStepDataSummon(fightStepData)

	if #self.summonList < 1 then
		return
	end

	local flow = self:com_registFlowParallel()
	local workCls = FightStepBuilder.ActEffectWorkCls[FightEnum.EffectType.SUMMON]

	for _, array in ipairs(self.summonList) do
		local _fightStepData = array[1]
		local _actEffectData = array[2]

		flow:registWork(workCls, _fightStepData, _actEffectData)
	end

	self:addWork2TimelineFinishWork(flow)
	flow:start()
end

function FightTLEventInvokeSummon:getStepDataSummon(fightStepData)
	local effectTypeList = fightStepData and fightStepData.actEffect

	if not effectTypeList then
		return
	end

	for _, actEffectData in ipairs(effectTypeList) do
		if actEffectData.effectType == FightEnum.EffectType.SUMMON then
			table.insert(self.summonList, {
				fightStepData,
				actEffectData
			})
		elseif actEffectData.effectType == FightEnum.EffectType.FIGHTSTEP then
			self:getStepDataSummon(actEffectData.fightStep)
		end
	end
end

function FightTLEventInvokeSummon:onTrackEnd()
	return
end

function FightTLEventInvokeSummon:onDestructor()
	return
end

function FightTLEventInvokeSummon:dispose()
	return
end

return FightTLEventInvokeSummon
