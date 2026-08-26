-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/guessgame/GuessGamePlayNpcSelectGiftView.lua

module("modules.logic.versionactivity3_7.anniversary3.view.guessgame.GuessGamePlayNpcSelectGiftView", package.seeall)

local GuessGamePlayNpcSelectGiftView = class("GuessGamePlayNpcSelectGiftView", BaseView)

function GuessGamePlayNpcSelectGiftView:onInitView()
	self._gonpc0 = gohelper.findChild(self.viewGO, "#go_npc0")
	self._gonpc1 = gohelper.findChild(self.viewGO, "#go_npc1")
	self._gonpc2 = gohelper.findChild(self.viewGO, "#go_npc2")
	self._gonpc3 = gohelper.findChild(self.viewGO, "#go_npc3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GuessGamePlayNpcSelectGiftView:addEvents()
	return
end

function GuessGamePlayNpcSelectGiftView:removeEvents()
	return
end

function GuessGamePlayNpcSelectGiftView:_editableInitView()
	self._npcItems = self:getUserDataTb_()

	self:_addSelfEvents()
end

function GuessGamePlayNpcSelectGiftView:onUpdateParam()
	return
end

function GuessGamePlayNpcSelectGiftView:onOpen()
	self._round = self.viewParam and self.viewParam.round

	self:_initNpcs()
	self:_refreshNpcGifts()
end

function GuessGamePlayNpcSelectGiftView:_initNpcs()
	for i = 1, 3 do
		if not self._npcItems[i] then
			self._npcItems[i] = GuessGamePlayNpcItem.New()

			local posGo = self:getResInst(self.viewContainer._viewSetting.otherRes[1], self["_gonpc" .. i])
			local go = self:getResInst(self.viewContainer._viewSetting.otherRes[2], self["_gonpc" .. i])

			self._npcItems[i]:init(self["_gonpc" .. i], posGo, go)
		end

		self._npcItems[i]:refresh(i)
	end
end

function GuessGamePlayNpcSelectGiftView:_addSelfEvents()
	self.addEventCb(self, GuessGameController.instance, GuessGameEvent.OnStartNpcSelectingGifts, self._onStartNpcSelectingGifts, self)
	self.addEventCb(self, GuessGameController.instance, GuessGameEvent.OnShowNpcSelectGifts, self._onShowNpcSelectGifts, self)
	self.addEventCb(self, GuessGameController.instance, GuessGameEvent.OnHideNpcUnselectGifts, self._onHideNpcUnselectGifts, self)
	self.addEventCb(self, GuessGameController.instance, GuessGameEvent.OnRoundSelectBtnFinished, self._onRoundSelected, self)
end

function GuessGamePlayNpcSelectGiftView:_removeSelfEvents()
	self.removeEventCb(self, GuessGameController.instance, GuessGameEvent.OnStartNpcSelectingGifts, self._onStartNpcSelectingGifts, self)
	self.removeEventCb(self, GuessGameController.instance, GuessGameEvent.OnShowNpcSelectGifts, self._onShowNpcSelectGifts, self)
	self.removeEventCb(self, GuessGameController.instance, GuessGameEvent.OnHideNpcUnselectGifts, self._onHideNpcUnselectGifts, self)
	self.removeEventCb(self, GuessGameController.instance, GuessGameEvent.OnRoundSelectBtnFinished, self._onRoundSelected, self)
end

function GuessGamePlayNpcSelectGiftView:_onRoundSelected()
	if self._npcItems then
		for _, npcItem in pairs(self._npcItems) do
			npcItem:showGifts(false)
		end
	end
end

function GuessGamePlayNpcSelectGiftView:_refreshNpcGifts()
	if not self._round then
		return
	end

	if self._npcItems then
		for index, npcItem in pairs(self._npcItems) do
			local giftTabs = GuessGameModel.instance:getGiftDistribution(index)

			npcItem:showGifts(true)
			npcItem:showGift(giftTabs)
		end
	end
end

function GuessGamePlayNpcSelectGiftView:_onStartNpcSelectingGifts()
	if not self._round then
		return
	end

	if self._npcItems then
		for index, npcItem in pairs(self._npcItems) do
			npcItem:showGifts(true)
			npcItem:showNpc(index == self._round)
			npcItem:showNpcSelect(index == self._round)
		end
	end
end

function GuessGamePlayNpcSelectGiftView:_onShowNpcSelectGifts(giftIndexs)
	if not self._round then
		return
	end

	self._selectIndexs = giftIndexs

	self._npcItems[self._round]:showSelectByIndexs(giftIndexs)

	if self._npcItems then
		for index, npcItem in pairs(self._npcItems) do
			npcItem:showGifts(true)
			npcItem:showNpc(index == self._round)
			npcItem:showNpcSelect(false)
		end
	end
end

function GuessGamePlayNpcSelectGiftView:_onHideNpcUnselectGifts()
	if not self._round then
		return
	end

	if not self._selectIndexs or #self._selectIndexs <= 0 then
		return
	end

	self._npcItems[self._round]:hideGift(self._selectIndexs)
end

function GuessGamePlayNpcSelectGiftView:onClose()
	return
end

function GuessGamePlayNpcSelectGiftView:onDestroyView()
	if self._npcItems then
		for _, v in pairs(self._npcItems) do
			v:destroy()
		end

		self._npcItems = nil
	end

	self:_removeSelfEvents()
end

return GuessGamePlayNpcSelectGiftView
