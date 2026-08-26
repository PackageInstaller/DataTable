-- chunkname: @modules/logic/fight/view/FightLorentzCardView.lua

module("modules.logic.fight.view.FightLorentzCardView", package.seeall)

local FightLorentzCardView = class("FightLorentzCardView", FightBaseView)

function FightLorentzCardView:onInitView()
	self.goGrid = gohelper.findChild(self.viewGO, "Grid")

	local viewContainer = self.viewContainer
	local viewSetting = viewContainer:getSetting()
	local res = viewSetting.otherRes[1]

	self.cardPrefab = viewContainer:getRes(res)
	self.cardItemList = {}

	self:loadCardPrefab()
end

function FightLorentzCardView:loadCardPrefab()
	return
end

function FightLorentzCardView:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.AddRecordSkillCard, self.onAddRecordSkillCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.AddRecordSkillCardDone, self.onAddRecordSkillCardDone, self)
end

function FightLorentzCardView:onAddRecordSkillCard(actEffectList)
	if not actEffectList then
		return
	end

	if #actEffectList < 1 then
		return
	end

	for _, cardItem in ipairs(self.cardItemList) do
		gohelper.setActive(cardItem.go, false)
	end

	for i, actEffect in ipairs(actEffectList) do
		local cardItem = self.cardItemList[i]

		if not cardItem then
			local go = gohelper.clone(self.cardPrefab, self.goGrid)

			cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, FightViewCardItem, FightEnum.CardShowType.LorentzCard)

			table.insert(self.cardItemList, cardItem)
		end

		gohelper.setActive(cardItem.go, true)

		local cardInfo = actEffect.cardInfo

		cardItem:updateItem(cardInfo.uid, cardInfo.skillId, cardInfo)
	end

	self:showView()
end

function FightLorentzCardView:onAddRecordSkillCardDone()
	self:hideView()
end

function FightLorentzCardView:showView()
	gohelper.setActive(self.viewGO, true)
end

function FightLorentzCardView:hideView()
	gohelper.setActive(self.viewGO, false)
end

function FightLorentzCardView:onDestroyView()
	return
end

return FightLorentzCardView
