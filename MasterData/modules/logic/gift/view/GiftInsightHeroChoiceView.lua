-- chunkname: @modules/logic/gift/view/GiftInsightHeroChoiceView.lua

module("modules.logic.gift.view.GiftInsightHeroChoiceView", package.seeall)

local GiftInsightHeroChoiceView = class("GiftInsightHeroChoiceView", BaseView)

function GiftInsightHeroChoiceView:onInitView()
	self._txtTitle = gohelper.findChildText(self.viewGO, "Title")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self._goconfirm = gohelper.findChild(self.viewGO, "#btn_confirm/#go_confirm")
	self._gonoconfirm = gohelper.findChild(self.viewGO, "#btn_confirm/#go_noconfirm")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_cancel")
	self._scrollrule = gohelper.findChildScrollRect(self.viewGO, "#scroll_rule")
	self._gostoreItem = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem")
	self._gotitle1 = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title1")
	self._gonogain = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_nogain")
	self._gotitle2 = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title2")
	self._goown = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_own")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GiftInsightHeroChoiceView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
end

function GiftInsightHeroChoiceView:removeEvents()
	self._btnconfirm:RemoveClickListener()
	self._btncancel:RemoveClickListener()
end

function GiftInsightHeroChoiceView:_btnconfirmOnClick()
	local itemUid = self.viewParam.uid

	if ItemInsightModel.instance:getInsightItemCount(itemUid) < 1 then
		GameFacade.showToast(ToastEnum.GiftInsightNoEnoughItem)

		return
	end

	local heroId = GiftInsightHeroChoiceModel.instance:getCurHeroId()

	if heroId > 0 then
		ItemRpc.instance:sendUseInsightItemRequest(itemUid, heroId, self._onUseFinished, self)

		return
	end

	GameFacade.showToast(ToastEnum.GiftInsightNoChooseHero)
end

function GiftInsightHeroChoiceView:_onUseFinished(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	TaskDispatcher.runDelay(self._useItemSuccess, self, 0.5)
end

function GiftInsightHeroChoiceView:_useItemSuccess()
	self:_refreshHeros()
	self:closeThis()
end

function GiftInsightHeroChoiceView:_btncancelOnClick()
	self:closeThis()
end

function GiftInsightHeroChoiceView:_btncloseOnClick()
	self:closeThis()
end

function GiftInsightHeroChoiceView:_addEvents()
	return
end

function GiftInsightHeroChoiceView:_removeEvents()
	return
end

function GiftInsightHeroChoiceView:_editableInitView()
	self._upHeroItems = {}
	self._noUpHeroItems = {}

	self:_addEvents()
end

function GiftInsightHeroChoiceView:onUpdateParam()
	return
end

function GiftInsightHeroChoiceView:onOpen()
	self._itemConfig = ItemConfig.instance:getInsightItemCo(self.viewParam.id)
	self._txtTitle.text = self._itemConfig.useTitle

	self:_refreshHeros()
end

function GiftInsightHeroChoiceView:onClose()
	GiftInsightHeroChoiceModel.instance:setCurHeroId(0)
end

function GiftInsightHeroChoiceView:_refreshHeros()
	local upHeros, noUpHeros = GiftInsightHeroChoiceModel.instance:getFitHeros(self.viewParam.id)

	gohelper.setActive(self._gotitle1, upHeros and #upHeros > 0)
	gohelper.setActive(self._gonoconfirm, not upHeros or #upHeros < 1)
	gohelper.setActive(self._goconfirm, upHeros and #upHeros > 0)
	self:_refreshUpHeros(upHeros)
	gohelper.setActive(self._gotitle2, #noUpHeros > 0)
	self:_refreshNoUpHeros(noUpHeros)
end

function GiftInsightHeroChoiceView:_refreshUpHeros(heros)
	for _, v in pairs(self._upHeroItems) do
		v:hide()
	end

	for k, heroMO in ipairs(heros) do
		if not self._upHeroItems[k] then
			local itemPath = self.viewContainer:getSetting().otherRes[1]
			local itemGo = self:getResInst(itemPath, self._gonogain)

			self._upHeroItems[k] = GiftInsightHeroChoiceListItem.New()

			self._upHeroItems[k]:init(itemGo)
		end

		self._upHeroItems[k]:refreshItem(heroMO)
		self._upHeroItems[k]:showUp(true)
	end
end

function GiftInsightHeroChoiceView:_refreshNoUpHeros(heros)
	for _, v in pairs(self._noUpHeroItems) do
		v:hide()
	end

	for k, heroMO in ipairs(heros) do
		if not self._noUpHeroItems[k] then
			local itemPath = self.viewContainer:getSetting().otherRes[1]
			local itemGo = self:getResInst(itemPath, self._goown)

			self._noUpHeroItems[k] = GiftInsightHeroChoiceListItem.New()

			self._noUpHeroItems[k]:init(itemGo)
		end

		self._noUpHeroItems[k]:refreshItem(heroMO)
		self._noUpHeroItems[k]:showUp(false)
	end
end

function GiftInsightHeroChoiceView:onDestroyView()
	TaskDispatcher.cancelTask(self._useItemSuccess, self)
	self:_removeEvents()

	if self._upHeroItems then
		for _, v in pairs(self._upHeroItems) do
			v:destroy()
		end

		self._upHeroItems = nil
	end

	if self._noUpHeroItems then
		for _, v in pairs(self._noUpHeroItems) do
			v:destroy()
		end

		self._noUpHeroItems = nil
	end
end

return GiftInsightHeroChoiceView
