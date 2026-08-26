-- chunkname: @modules/logic/fight/system/work/FightWorkEnterDistributeCards672802.lua

module("modules.logic.fight.system.work.FightWorkEnterDistributeCards672802", package.seeall)

local FightWorkEnterDistributeCards672802 = class("FightWorkEnterDistributeCards672802", FightWorkItem)

function FightWorkEnterDistributeCards672802:onConstructor(fightViewHandCard, distributeCards)
	self.fightViewHandCard = fightViewHandCard
	self.distributeCards = distributeCards
	self.effectList = {}
end

function FightWorkEnterDistributeCards672802:onStart()
	local urlList = {
		"ui/viewres/fight/fightskin/0002/fight_skin_down_0002.prefab",
		"ui/viewres/fight/fightskin/0002/fight_skin_up_0002.prefab",
		"ui/animations/dynamic/fightcarditem_skin_0001.controller"
	}
	local parentRootList = {
		self.fightViewHandCard.skinDownEffectRoot,
		self.fightViewHandCard.skinUpEffectRoot
	}

	self:cancelFightWorkSafeTimer()

	local mgr = FightMsgMgr.sendMsg(FightMsgId.GetCardSkin672802Mgr)

	self.skinMgr = mgr

	if mgr then
		mgr.loader:loadListAsset(urlList, self.onLoaded, self.onAllLoaded, self, parentRootList)
	else
		self:onDone(true)
	end
end

function FightWorkEnterDistributeCards672802:onLoaded(success, loader, parentRoot)
	if success then
		if parentRoot then
			local obj = loader:GetResource()

			if parentRoot == self.fightViewHandCard.skinDownEffectRoot then
				table.insert(self.effectList, 1, gohelper.clone(obj, parentRoot))
			else
				table.insert(self.effectList, gohelper.clone(obj, parentRoot))
			end
		else
			self.runtimeAnimatorController = loader:GetResource()
		end
	end
end

function FightWorkEnterDistributeCards672802:onAllLoaded()
	local handCard = FightDataHelper.handCardMgr.handCard

	tabletool.addValues(handCard, self.distributeCards)
	FightCardDataHelper.combineCardListForPerformance(handCard)
	self.fightViewHandCard:_updateHandCards()

	local cardItemList = self.fightViewHandCard._handCardItemList

	gohelper.setActive(self.effectList[1], false)
	self.skinMgr:setFloorEffect(self.effectList[1])
	gohelper.setActive(self.effectList[2], false)

	local speed = FightModel.instance:getUISpeed()
	local sequence = self:com_registWorkDoneFlowSequence()

	sequence:registWork(FightWorkDelayTimer, 0.5 / speed)
	sequence:registWork(FightWorkFunction, self.showEffect, self)
	sequence:registWork(FightWorkDelayTimer, 0.5 / speed)

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

	sequence:registWork(FightWorkDelayTimer, 0.8 / speed)
	sequence:start()
end

function FightWorkEnterDistributeCards672802:showCard(tarCard)
	gohelper.setActive(tarCard.go, true)

	tarCard._cardAni.runtimeAnimatorController = self.runtimeAnimatorController
end

function FightWorkEnterDistributeCards672802:showEffect()
	gohelper.setActive(self.effectList[1], true)

	local animator = gohelper.onceAddComponent(self.effectList[1].gameObject, gohelper.Type_Animator)

	animator.speed = FightModel.instance:getUISpeed()

	animator:Play("fightskin_02_chupai1", 0, 0)
	gohelper.setActive(self.effectList[2], true)
	self:com_registTimer(function()
		AudioMgr.instance:trigger(20300021)
	end, 0.5 / FightModel.instance:getSpeed())
end

function FightWorkEnterDistributeCards672802:onDestructor()
	for i, v in ipairs(self.effectList) do
		if i > 1 then
			gohelper.destroy(v)
		end
	end
end

return FightWorkEnterDistributeCards672802
