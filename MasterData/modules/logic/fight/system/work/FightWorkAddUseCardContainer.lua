-- chunkname: @modules/logic/fight/system/work/FightWorkAddUseCardContainer.lua

module("modules.logic.fight.system.work.FightWorkAddUseCardContainer", package.seeall)

local FightWorkAddUseCardContainer = class("FightWorkAddUseCardContainer", FightStepEffectFlow)

FightWorkAddUseCardContainer.IndexList = {}
FightWorkAddUseCardContainer.BehaviourIdList = {}

function FightWorkAddUseCardContainer:onStart()
	local dataList = self:getAdjacentSameEffectList(nil, false)

	self:customPlayEffectData(dataList)

	local indexList = FightWorkAddUseCardContainer.IndexList
	local behaviourIdList = FightWorkAddUseCardContainer.BehaviourIdList

	tabletool.clear(indexList)
	tabletool.clear(behaviourIdList)

	local waitTime = 0.5

	for _, data in ipairs(dataList) do
		local actEffectData = data.actEffectData
		local index = actEffectData.effectNum
		local curUsedCards = FightPlayCardModel.instance:getUsedCards()

		if index - 1 > #curUsedCards then
			index = #curUsedCards + 1
		end

		table.insert(indexList, index)
		FightPlayCardModel.instance:addUseCard(index, actEffectData.cardInfo, actEffectData.effectNum1)

		local _waitTime = self:getWaitTime(actEffectData)
		local var_1_0

		if waitTime < _waitTime then
			waitTime = _waitTime
			var_1_0 = tonumber(actEffectData.reserveId) or 0
		end

		table.insert(behaviourIdList, var_1_0)
	end

	FightController.instance:dispatchEvent(FightEvent.AddUseCard, indexList, behaviourIdList)
	FightController.instance:dispatchEvent(FightEvent.AfterAddUseCardContainer, self.fightStepData)
	self:com_registTimer(self._delayAfterPerformance, waitTime / FightModel.instance:getUISpeed())
end

function FightWorkAddUseCardContainer:getWaitTime(actEffectData)
	if FightHeroALFComp.ALFSkillDict[actEffectData.effectNum1] then
		return 1.8
	end

	local behaviourId = tonumber(actEffectData.reserveId)

	if behaviourId == FightEnum.SkillBehaviourId.UseCardCopy then
		return 1.8
	end

	return 0.5
end

function FightWorkAddUseCardContainer:customPlayEffectData(dataList)
	for _, data in ipairs(dataList) do
		FightDataHelper.playEffectData(data.actEffectData)
	end
end

function FightWorkAddUseCardContainer:clearWork()
	return
end

return FightWorkAddUseCardContainer
