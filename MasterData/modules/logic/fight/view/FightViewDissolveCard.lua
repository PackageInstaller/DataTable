-- chunkname: @modules/logic/fight/view/FightViewDissolveCard.lua

module("modules.logic.fight.view.FightViewDissolveCard", package.seeall)

local FightViewDissolveCard = class("FightViewDissolveCard", BaseView)

function FightViewDissolveCard:onInitView()
	self.cardContainer = gohelper.findChild(self.viewGO, "root/dissolveCard")
	self.goCardItem = gohelper.findChild(self.viewGO, "root/dissolveCard/#scroll_cards/Viewport/Content/cardItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightViewDissolveCard:addEvents()
	return
end

function FightViewDissolveCard:removeEvents()
	return
end

FightViewDissolveCard.CardScale = 0.62
FightViewDissolveCard.ShowCardDuration = 0.5
FightViewDissolveCard.DissolveCardDuration = 1

function FightViewDissolveCard:_editableInitView()
	gohelper.setActive(self.cardContainer, false)
	gohelper.setActive(self.goCardItem, false)

	self.cardItemList = {}
end

function FightViewDissolveCard:onDeleteCard(cardInfoList)
	if not cardInfoList then
		return self:dissolveCardDone()
	end

	for _, cardItem in ipairs(self.cardItemList) do
		gohelper.setActive(cardItem.go, false)
	end

	gohelper.setActive(self.cardContainer, true)

	for index, cardInfo in ipairs(cardInfoList) do
		local cardItem = self:getCardItem(index)

		gohelper.setActive(cardItem.innerCardGo, true)
		cardItem.innerCardItem:updateItem(cardInfo.uid, cardInfo.skillId, cardInfo)

		local isBigSkill = FightCardDataHelper.isBigSkill(cardInfo.skillId)

		gohelper.setActive(cardItem.goPlaySkillEffect, not isBigSkill)
		gohelper.setActive(cardItem.goPlayBigSkillEffect, isBigSkill)
	end

	TaskDispatcher.cancelTask(self.dissolveCardDone, self)
	TaskDispatcher.cancelTask(self.startDissolve, self)
	TaskDispatcher.runDelay(self.startDissolve, self, self.ShowCardDuration / FightModel.instance:getUISpeed())
end

function FightViewDissolveCard:startDissolve()
	local cardScale = self.CardScale

	for _, cardItem in ipairs(self.cardItemList) do
		cardItem.innerCardItem:dissolveCard(cardScale)
		gohelper.setActive(cardItem.goPlaySkillEffect, false)
		gohelper.setActive(cardItem.goPlayBigSkillEffect, false)
	end

	TaskDispatcher.cancelTask(self.dissolveCardDone, self)
	TaskDispatcher.runDelay(self.dissolveCardDone, self, self.DissolveCardDuration / FightModel.instance:getUISpeed())
end

function FightViewDissolveCard:getCardItem(index)
	local cardItem = self.cardItemList[index]

	if cardItem then
		gohelper.setActive(cardItem.go, true)

		return cardItem
	end

	cardItem = self:getUserDataTb_()
	cardItem.go = gohelper.cloneInPlace(self.goCardItem)

	gohelper.setActive(cardItem.go, true)

	local cardPath = self.viewContainer:getSetting().otherRes[1]

	cardItem.innerCardGo = self:getResInst(cardPath, cardItem.go, "card")
	cardItem.innerCardItem = MonoHelper.addNoUpdateLuaComOnceToGo(cardItem.innerCardGo, FightViewCardItem)

	local cardScale = self.CardScale

	transformhelper.setLocalScale(cardItem.innerCardGo.transform, cardScale, cardScale, cardScale)

	cardItem.goPlaySkillEffect = self:addPlaySkillEffect(cardItem.go)
	cardItem.goPlayBigSkillEffect = self:addPlayBigSkillEffect(cardItem.go)

	gohelper.setActive(cardItem.goPlaySkillEffect, false)
	gohelper.setActive(cardItem.goPlayBigSkillEffect, false)
	transformhelper.setLocalScale(cardItem.goPlaySkillEffect.transform, cardScale, cardScale, cardScale)
	transformhelper.setLocalScale(cardItem.goPlayBigSkillEffect.transform, cardScale, cardScale, cardScale)
	table.insert(self.cardItemList, cardItem)

	return cardItem
end

function FightViewDissolveCard:addPlaySkillEffect(goCardItem)
	local url = ResUrl.getUIEffect(FightPreloadViewWork.ui_chupai_02)
	local assetItem = FightGameMgr.loaderMgr:getAsset(url).assetItem

	return gohelper.clone(assetItem:GetResource(url), goCardItem)
end

function FightViewDissolveCard:addPlayBigSkillEffect(goCardItem)
	local url = ResUrl.getUIEffect(FightPreloadViewWork.ui_chupai_03)
	local assetItem = FightGameMgr.loaderMgr:getAsset(url).assetItem

	return gohelper.clone(assetItem:GetResource(url), goCardItem)
end

function FightViewDissolveCard:dissolveCardDone()
	gohelper.setActive(self.cardContainer, false)
	FightController.instance:dispatchEvent(FightEvent.CardDeckDeleteDone)
end

function FightViewDissolveCard:onDestroyView()
	TaskDispatcher.cancelTask(self.dissolveCardDone, self)
	TaskDispatcher.cancelTask(self.startDissolve, self)
end

return FightViewDissolveCard
