-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventInvokeLookBack.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventInvokeLookBack", package.seeall)

local FightTLEventInvokeLookBack = class("FightTLEventInvokeLookBack", FightTimelineTrackItem)

function FightTLEventInvokeLookBack:onTrackStart(fightStepData, duration, paramsArr)
	local effectTypeList = fightStepData and fightStepData.actEffect

	if not effectTypeList then
		return
	end

	local effectList = {}
	local start = false

	for _, actEffectData in ipairs(effectTypeList) do
		if actEffectData.effectType == FightEnum.EffectType.SAVEFIGHTRECORDSTART then
			start = true
		elseif actEffectData.effectType == FightEnum.EffectType.SAVEFIGHTRECORDEND then
			break
		elseif start then
			table.insert(effectList, actEffectData)
		end
	end

	if #effectList < 1 then
		return
	end

	local flow = self:com_registFlowParallel()

	for _, actEffectData in ipairs(effectList) do
		local workCls = FightStepBuilder.ActEffectWorkCls[actEffectData.effectType]

		if workCls then
			flow:registWork(workCls, fightStepData, actEffectData)
		end
	end

	self:addWork2TimelineFinishWork(flow)
	flow:start()
end

function FightTLEventInvokeLookBack:onTrackEnd()
	return
end

function FightTLEventInvokeLookBack:onDestructor()
	return
end

return FightTLEventInvokeLookBack
