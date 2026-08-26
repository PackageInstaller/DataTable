-- chunkname: @modules/logic/versionactivity2_5/challenge/view/store/Act183StoreEntry.lua

module("modules.logic.versionactivity2_5.challenge.view.store.Act183StoreEntry", package.seeall)

local Act183StoreEntry = class("Act183StoreEntry", BaseViewExtended)

function Act183StoreEntry:onInitView()
	self._btnstore = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_click")
	self._txtNum = gohelper.findChildText(self.viewGO, "root/#txt_Num")
	self._gostoretips = gohelper.findChild(self.viewGO, "root/#go_storetips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act183StoreEntry:addEvents()
	self._btnstore:AddClickListener(self._btnstoreOnClick, self)
end

function Act183StoreEntry:removeEvents()
	self._btnstore:RemoveClickListener()
end

function Act183StoreEntry:_btnstoreOnClick()
	Act183Controller.instance:openAct183StoreView()
end

function Act183StoreEntry:_editableInitView()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.refreshStoreTag, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateActTag, self.refreshStoreTag, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshCurrency, self)
	self.addEventCb(self, BossRushController.instance, BossRushEvent.OnEnterStoreView, self.refreshStoreTag, self)

	self._actId = Act183Model.instance:getActivityId()
end

function Act183StoreEntry:onOpen()
	self:refreshCurrency()
	self:refreshStoreTag()
end

function Act183StoreEntry:refreshCurrency()
	local count = V1a6_BossRush_StoreModel.instance:getCurrencyCount(self._actId)

	self._txtNum.text = count or 0
end

function Act183StoreEntry:refreshStoreTag()
	local isNew = V1a6_BossRush_StoreModel.instance:isHasNewGoodsInStore()

	gohelper.setActive(self._gostoretips, isNew)
end

return Act183StoreEntry
