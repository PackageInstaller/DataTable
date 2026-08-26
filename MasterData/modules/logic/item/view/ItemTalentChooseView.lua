-- chunkname: @modules/logic/item/view/ItemTalentChooseView.lua

module("modules.logic.item.view.ItemTalentChooseView", package.seeall)

local ItemTalentChooseView = class("ItemTalentChooseView", BaseView)

function ItemTalentChooseView:onInitView()
	self._txtTitle = gohelper.findChildText(self.viewGO, "hori/#txt_Title")
	self._gotipsbg = gohelper.findChild(self.viewGO, "TipsBG")
	self._gotips2 = gohelper.findChild(self.viewGO, "Tips2")
	self._txtnum = gohelper.findChildText(self.viewGO, "Tips2/#txt_num")
	self._txtnum1 = gohelper.findChildText(self.viewGO, "Tips2/#txt_num1")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self._btnconfirmgrey = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirmgrey")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_cancel")
	self._scrollheros = gohelper.findChildScrollRect(self.viewGO, "#scroll_heros")
	self._gostoreitem = gohelper.findChild(self.viewGO, "#scroll_heros/Viewport/#go_storeitem")
	self._txtname = gohelper.findChildText(self.viewGO, "#scroll_heros/Viewport/#go_storeitem/Title1/bg/#txt_name")
	self._gonogain = gohelper.findChild(self.viewGO, "#scroll_heros/Viewport/#go_storeitem/#go_nogain")
	self._gocanselect = gohelper.findChild(self.viewGO, "#scroll_heros/Viewport/#go_storeitem/#go_canselect")
	self._txtclose = gohelper.findChildText(self.viewGO, "#txt_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ItemTalentChooseView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
end

function ItemTalentChooseView:removeEvents()
	self._btnconfirm:RemoveClickListener()
	self._btncancel:RemoveClickListener()
end

function ItemTalentChooseView:_btnconfirmOnClick()
	local heroId = ItemTalentModel.instance:getCurSelectHero()

	if not heroId or heroId == 0 then
		return
	end

	local heroMo = HeroModel.instance:getByHeroId(heroId)
	local heroName = heroMo.config.name
	local filters = string.splitToNumber(self._itemConfig.effect, "#")
	local lv = heroMo.talent + filters[4]

	GameFacade.showMessageBox(MessageBoxIdDefine.ItemHeroTalentUpTip, MsgBoxEnum.BoxType.Yes_No, self._onYesCallback, self._onNoCallback, nil, self, self, self, heroName, lv)
end

function ItemTalentChooseView:_onYesCallback()
	local heroId = ItemTalentModel.instance:getCurSelectHero()

	if not heroId or heroId == 0 then
		return
	end

	local heroMo = HeroModel.instance:getByHeroId(heroId)

	ItemRpc.instance:sendUseTalentItemRequest(self.viewParam.itemUid, heroMo.uid)
	self:closeThis()
end

function ItemTalentChooseView:_onNoCallback()
	return
end

function ItemTalentChooseView:_btncancelOnClick()
	self:closeThis()
end

function ItemTalentChooseView:_btnCloseOnClick()
	self:closeThis()
end

function ItemTalentChooseView:_addSelfEvents()
	self._bgClick:AddClickListener(self._btnCloseOnClick, self)
	ItemTalentController.instance:registerCallback(ItemTalentEvent.ChooseHeroItem, self._refresh, self)
	ItemTalentController.instance:registerCallback(ItemTalentEvent.UseTalentItemSuccess, self._refresh, self)
end

function ItemTalentChooseView:_removeSelfEvents()
	self._bgClick:RemoveClickListener()
	ItemTalentController.instance:unregisterCallback(ItemTalentEvent.ChooseHeroItem, self._refresh, self)
	ItemTalentController.instance:unregisterCallback(ItemTalentEvent.UseTalentItemSuccess, self._refresh, self)
end

function ItemTalentChooseView:_editableInitView()
	local bg = gohelper.findChild(self.viewGO, "fullbg")

	self._bgClick = gohelper.getClickWithAudio(bg)
	self._goheroitem = gohelper.findChild(self.viewGO, "#scroll_heros/Viewport/#go_storeitem/#go_nogain/heroitem")

	gohelper.setActive(self._goheroitem, false)
	self:_addSelfEvents()
end

function ItemTalentChooseView:onUpdateParam()
	return
end

function ItemTalentChooseView:onOpen()
	NavigateMgr.instance:addEscape(self.viewName, self._btnCloseOnClick, self)
	ItemTalentModel.instance:setCurSelectHero(0)

	self._heroItems = {}
	self._itemConfig = ItemTalentConfig.instance:getTalentItemCo(self.viewParam.itemId)
	self._txtTitle.text = self._itemConfig.useTitle

	self:_refresh()
end

function ItemTalentChooseView:_refresh()
	self:_refreshUI()
	self:_refreshHeros()
end

function ItemTalentChooseView:_refreshUI()
	local curHeroId = ItemTalentModel.instance:getCurSelectHero()
	local hasSelectHero = curHeroId and curHeroId > 0

	gohelper.setActive(self._btnconfirm.gameObject, self.viewParam.itemUid and hasSelectHero)
	gohelper.setActive(self._btnconfirmgrey.gameObject, self.viewParam.itemUid and not hasSelectHero)
	gohelper.setActive(self._btncancel.gameObject, self.viewParam.itemUid)
	gohelper.setActive(self._gotipsbg, self.viewParam.itemUid)
	gohelper.setActive(self._gotips2, self.viewParam.itemUid)
end

function ItemTalentChooseView:_refreshHeros()
	for _, heroItem in pairs(self._heroItems) do
		gohelper.setActive(heroItem.go, false)
	end

	local heroList = ItemTalentModel.instance:getCouldUpgradeTalentHeroList(self.viewParam.itemId)

	for _, heroMo in pairs(heroList) do
		if not self._heroItems[heroMo.id] then
			self._heroItems[heroMo.id] = ItemTalentChooseHeroItem.New()

			local go = gohelper.cloneInPlace(self._goheroitem)

			self._heroItems[heroMo.id]:init(go)
		end

		self._heroItems[heroMo.id]:refresh(heroMo, self.viewParam.itemUid)
	end

	local showTip = #heroList > 0 and self.viewParam.itemUid

	gohelper.setActive(self._gotips2, showTip)

	if showTip then
		local curHeroId = ItemTalentModel.instance:getCurSelectHero()
		local hasSelectHero = curHeroId and curHeroId > 0

		self._txtnum.text = hasSelectHero and 1 or 0

		local filters = string.splitToNumber(self._itemConfig.effect, "#")

		self._txtnum1.text = "/" .. filters[1]
	end
end

function ItemTalentChooseView:onClose()
	ItemTalentModel.instance:setCurSelectHero(0)
end

function ItemTalentChooseView:onDestroyView()
	if self._heroItems then
		for _, heroItem in pairs(self._heroItems) do
			heroItem:destroy()
		end

		self._heroItems = nil
	end

	self:_removeSelfEvents()
end

return ItemTalentChooseView
