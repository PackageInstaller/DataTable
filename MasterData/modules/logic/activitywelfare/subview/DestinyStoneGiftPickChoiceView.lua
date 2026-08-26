-- chunkname: @modules/logic/activitywelfare/subview/DestinyStoneGiftPickChoiceView.lua

module("modules.logic.activitywelfare.subview.DestinyStoneGiftPickChoiceView", package.seeall)

local DestinyStoneGiftPickChoiceView = class("DestinyStoneGiftPickChoiceView", BaseView)

function DestinyStoneGiftPickChoiceView:onInitView()
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self._btnconfirmgrey = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm_grey")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_cancel")
	self._scrollstone = gohelper.findChildScrollRect(self.viewGO, "#scroll_stone")
	self._gostonegrid1 = gohelper.findChild(self.viewGO, "#scroll_stone/Viewport/Content/#go_stonegrid1")
	self._gostonegrid2 = gohelper.findChild(self.viewGO, "#scroll_stone/Viewport/Content/#go_stonegrid2")
	self._gostonegrid3 = gohelper.findChild(self.viewGO, "#scroll_stone/Viewport/Content/#go_stonegrid3")
	self._gostonegrid4 = gohelper.findChild(self.viewGO, "#scroll_stone/Viewport/Content/#go_stonegrid4")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DestinyStoneGiftPickChoiceView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btnconfirmgrey:AddClickListener(self._btnconfirmgreyOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
end

function DestinyStoneGiftPickChoiceView:removeEvents()
	self._btnconfirm:RemoveClickListener()
	self._btnconfirmgrey:RemoveClickListener()
	self._btncancel:RemoveClickListener()
end

function DestinyStoneGiftPickChoiceView:_btnconfirmOnClick()
	local type = DestinyStoneGiftPickChoiceModel.instance:getCurrentSelectStoneType()
	local currentSelectMo = DestinyStoneGiftPickChoiceModel.instance:getCurrentSelectStoneMo()

	if type == DestinyStoneGiftPickChoiceEnum.HeroStoneType.OwnHeroStoneCouldUp then
		if currentSelectMo then
			local heroDestinyStoneMO = currentSelectMo.heroMo.destinyStoneMo

			heroDestinyStoneMO:setUpStoneId(currentSelectMo.stoneId)
			DestinyStoneGiftPickChoiceController.instance:openCharacterDestinyStoneUpView(self._itemId, currentSelectMo.heroMo, currentSelectMo.stoneMo)
		end
	else
		DestinyStoneGiftPickChoiceController.instance:openCharacterDestinyStoneDetailView(currentSelectMo.heroId, currentSelectMo.stoneId, currentSelectMo.stoneMo, type)
	end
end

function DestinyStoneGiftPickChoiceView:_btncancelOnClick()
	self:closeThis()
end

function DestinyStoneGiftPickChoiceView:_btnconfirmgreyOnClick()
	GameFacade.showToast(ToastEnum.NoChoiceHeroStoneUp)
end

function DestinyStoneGiftPickChoiceView:_onStoneUpFinished()
	self:closeThis()
end

function DestinyStoneGiftPickChoiceView:_editableInitView()
	self._typeItems = self:getUserDataTb_()

	self:_addSelfEvents()
end

function DestinyStoneGiftPickChoiceView:_addSelfEvents()
	self.addEventCb(self, DestinyStoneGiftPickChoiceController.instance, DestinyStoneGiftPickChoiceEvent.onCustomPickListChanged, self._refreshUI, self)
	self.addEventCb(self, DestinyStoneGiftPickChoiceController.instance, DestinyStoneGiftPickChoiceEvent.hadStoneUp, self._onStoneUpFinished, self)
end

function DestinyStoneGiftPickChoiceView:_removeSelfEvents()
	self.removeEventCb(self, DestinyStoneGiftPickChoiceController.instance, DestinyStoneGiftPickChoiceEvent.onCustomPickListChanged, self._refreshUI, self)
	self.removeEventCb(self, DestinyStoneGiftPickChoiceController.instance, DestinyStoneGiftPickChoiceEvent.hadStoneUp, self._onStoneUpFinished, self)
end

function DestinyStoneGiftPickChoiceView:onOpen()
	self._itemId = self.viewParam and self.viewParam.itemId

	self:_refreshUI()
	self:_refreshStoneChoiceItems()
end

function DestinyStoneGiftPickChoiceView:_refreshUI()
	local curStoneId = DestinyStoneGiftPickChoiceModel.instance:getCurrentSelectStoneId()
	local isSelect = curStoneId and curStoneId > 0

	gohelper.setActive(self._btnconfirm.gameObject, isSelect)
	gohelper.setActive(self._btnconfirmgrey.gameObject, not isSelect)
end

function DestinyStoneGiftPickChoiceView:_refreshStoneChoiceItems()
	for i = 1, 4 do
		if not self._typeItems[i] then
			self._typeItems[i] = DestinyStoneGiftPickChoiceListItem.New()

			self._typeItems[i]:init(self["_gostonegrid" .. tostring(i)], i, self._itemId)
		end

		self._typeItems[i]:refresh()
	end
end

function DestinyStoneGiftPickChoiceView:onClose()
	DestinyStoneGiftPickChoiceModel.instance:setCurrentSelectStoneMo()
end

function DestinyStoneGiftPickChoiceView:onDestroyView()
	self:_removeSelfEvents()

	if self._typeItems then
		for _, typeItem in ipairs(self._typeItems) do
			typeItem:destroy()
		end

		self._typeItems = nil
	end
end

return DestinyStoneGiftPickChoiceView
