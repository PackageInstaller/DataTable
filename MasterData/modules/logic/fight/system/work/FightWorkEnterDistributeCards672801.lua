-- chunkname: @modules/logic/fight/system/work/FightWorkEnterDistributeCards672801.lua

module("modules.logic.fight.system.work.FightWorkEnterDistributeCards672801", package.seeall)

local FightWorkEnterDistributeCards672801 = class("FightWorkEnterDistributeCards672801", FightWorkItem)

function FightWorkEnterDistributeCards672801:onConstructor(fightViewHandCard, distributeCards)
	self.fightViewHandCard = fightViewHandCard
	self.distributeCards = distributeCards
	self.effectList = {}
end

function FightWorkEnterDistributeCards672801:onStart()
	local urlList = {
		"ui/viewres/fight/fightskin/0001/fight_skin_down_0001.prefab",
		"ui/viewres/fight/fightskin/0001/fight_skin_up_0001.prefab",
		"ui/animations/dynamic/fightcarditem_skin_0001.controller"
	}
	local parentRootList = {
		self.fightViewHandCard.skinDownEffectRoot,
		self.fightViewHandCard.skinUpEffectRoot
	}

	self:cancelFightWorkSafeTimer()
	self:com_loadListAsset(urlList, self.onLoaded, self.onAllLoaded, parentRootList)
end

function FightWorkEnterDistributeCards672801:onLoaded(success, loader, parentRoot)
	if success then
		if parentRoot then
			local obj = loader:GetResource()

			table.insert(self.effectList, gohelper.clone(obj, parentRoot))
		else
			self.runtimeAnimatorController = loader:GetResource()
		end
	end
end

function FightWorkEnterDistributeCards672801:onAllLoaded()
	local handCard = FightDataHelper.handCardMgr.handCard

	tabletool.addValues(handCard, self.distributeCards)
	FightCardDataHelper.combineCardListForPerformance(handCard)
	self.fightViewHandCard:_updateHandCards()

	local cardItemList = self.fightViewHandCard._handCardItemList

	gohelper.setActive(self.effectList[1], false)
	gohelper.setActive(self.effectList[2], false)

	local speed = FightModel.instance:getUISpeed()
	local sequence = self:com_registWorkDoneFlowSequence()

	sequence:registWork(FightWorkDelayTimer, 0.5 / speed)
	sequence:registWork(FightWorkFunction, self.showEffect, self)

	local parallel = sequence:registWork(FightWorkFlowParallel)

	for i = 1, #handCard do
		local tarCard = cardItemList[i]

		gohelper.setActive(tarCard.go, false)

		local cardFlow = parallel:registWork(FightWorkFlowSequence)
		local obj = tarCard._innerGO

		cardFlow:registWork(FightWorkDelayTimer, 0.06 / speed * i)
		cardFlow:registWork(FightWorkFunction, self.showCard, self, tarCard)
		cardFlow:registWork(FightWorkPlayAnimator, obj, "fightcarditem_skin_0001", speed, tarCard._onCardAniFinish, tarCard)
	end

	sequence:start()
end

function FightWorkEnterDistributeCards672801:showCard(tarCard)
	gohelper.setActive(tarCard.go, true)

	tarCard._cardAni.runtimeAnimatorController = self.runtimeAnimatorController
end

function FightWorkEnterDistributeCards672801:showEffect()
	gohelper.setActive(self.effectList[1], true)
	gohelper.setActive(self.effectList[2], true)
	self:com_registTimer(function()
		AudioMgr.instance:trigger(20300021)
	end, 0.5 / FightModel.instance:getSpeed())
end

function FightWorkEnterDistributeCards672801:onDestructor()
	for i, v in ipairs(self.effectList) do
		gohelper.destroy(v)
	end
end

return FightWorkEnterDistributeCards672801
