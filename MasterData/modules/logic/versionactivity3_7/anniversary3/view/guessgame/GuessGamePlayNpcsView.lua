-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/guessgame/GuessGamePlayNpcsView.lua

module("modules.logic.versionactivity3_7.anniversary3.view.guessgame.GuessGamePlayNpcsView", package.seeall)

local GuessGamePlayNpcsView = class("GuessGamePlayNpcsView", BaseView)

function GuessGamePlayNpcsView:onInitView()
	self._gonpc0 = gohelper.findChild(self.viewGO, "#go_npc0")
	self._gonpc1 = gohelper.findChild(self.viewGO, "#go_npc1")
	self._gonpc2 = gohelper.findChild(self.viewGO, "#go_npc2")
	self._gonpc3 = gohelper.findChild(self.viewGO, "#go_npc3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GuessGamePlayNpcsView:addEvents()
	return
end

function GuessGamePlayNpcsView:removeEvents()
	return
end

function GuessGamePlayNpcsView:_editableInitView()
	self._npcItems = self:getUserDataTb_()

	self:_addSelfEvents()
end

function GuessGamePlayNpcsView:onUpdateParam()
	return
end

function GuessGamePlayNpcsView:onOpen()
	self:_initNpcs()
	self:_refreshNpcGifts()
end

function GuessGamePlayNpcsView:_initNpcs()
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

function GuessGamePlayNpcsView:_addSelfEvents()
	self.addEventCb(self, GuessGameController.instance, GuessGameEvent.OnDistributeGifts, self._onShowDistributeGifts, self)
	self.addEventCb(self, GuessGameController.instance, GuessGameEvent.OnStartNpcSelectingGifts, self._onStartNpcSelectingGifts, self)
	self.addEventCb(self, GuessGameController.instance, GuessGameEvent.OnShowNpcSelectGifts, self._onShowNpcSelectGifts, self)
	self.addEventCb(self, GuessGameController.instance, GuessGameEvent.OnHideNpcUnselectGifts, self._onHideNpcUnselectGifts, self)
end

function GuessGamePlayNpcsView:_removeSelfEvents()
	self.removeEventCb(self, GuessGameController.instance, GuessGameEvent.OnDistributeGifts, self._onShowDistributeGifts, self)
	self.removeEventCb(self, GuessGameController.instance, GuessGameEvent.OnStartNpcSelectingGifts, self._onStartNpcSelectingGifts, self)
	self.removeEventCb(self, GuessGameController.instance, GuessGameEvent.OnShowNpcSelectGifts, self._onShowNpcSelectGifts, self)
	self.removeEventCb(self, GuessGameController.instance, GuessGameEvent.OnHideNpcUnselectGifts, self._onHideNpcUnselectGifts, self)
end

function GuessGamePlayNpcsView:_refreshNpcGifts()
	for index, npcItem in pairs(self._npcItems) do
		local giftTabs = GuessGameModel.instance:getGiftDistribution(index)

		npcItem:showGift(giftTabs)
		npcItem:showGiftOpen(false)
	end
end

function GuessGamePlayNpcsView:_onShowDistributeGifts()
	self:_refreshNpcGifts()
end

function GuessGamePlayNpcsView:_onStartNpcSelectingGifts()
	local round = GuessGameModel.instance:getRound()

	if not self._npcItems[round] then
		return
	end

	self._npcItems[round]:showNpc(true)
end

function GuessGamePlayNpcsView:_onShowNpcSelectGifts(giftIndexs)
	local round = GuessGameModel.instance:getRound()

	self._selectIndexs = giftIndexs

	if not self._npcItems[round] then
		return
	end
end

function GuessGamePlayNpcsView:_onHideNpcUnselectGifts()
	if not self._selectIndexs or #self._selectIndexs <= 0 then
		return
	end

	local round = GuessGameModel.instance:getRound()

	if not self._npcItems[round] then
		return
	end

	self._npcItems[round]:hideGift(self._selectIndexs)
end

function GuessGamePlayNpcsView:onClose()
	return
end

function GuessGamePlayNpcsView:onDestroyView()
	if self._npcItems then
		for _, v in pairs(self._npcItems) do
			v:destroy()
		end

		self._npcItems = nil
	end

	self:_removeSelfEvents()
end

return GuessGamePlayNpcsView
