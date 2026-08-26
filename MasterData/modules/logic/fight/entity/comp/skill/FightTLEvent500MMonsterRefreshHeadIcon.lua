-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEvent500MMonsterRefreshHeadIcon.lua

module("modules.logic.fight.entity.comp.skill.FightTLEvent500MMonsterRefreshHeadIcon", package.seeall)

local FightTLEvent500MMonsterRefreshHeadIcon = class("FightTLEvent500MMonsterRefreshHeadIcon", FightTimelineTrackItem)

function FightTLEvent500MMonsterRefreshHeadIcon:onTrackStart(fightStepData, duration, paramsArr)
	local effectList = fightStepData.actEffect

	if not effectList then
		logError("FightTLEvent500MMonsterRefreshHeadIcon:onTrackStart effectList is nil")

		return
	end

	local modelId

	for _, effect in ipairs(effectList) do
		if effect.effectType == FightEnum.EffectType.MONSTERCHANGE then
			local entity = effect.entity

			modelId = entity and entity.modelId

			break
		end
	end

	if not modelId then
		logError("FightTLEvent500MMonsterRefreshHeadIcon:onTrackStart modelId is nil")

		return
	end

	FightController.instance:dispatchEvent(FightEvent.RefreshSpineHeadIcon, modelId)
end

function FightTLEvent500MMonsterRefreshHeadIcon:onTrackEnd()
	return
end

return FightTLEvent500MMonsterRefreshHeadIcon
