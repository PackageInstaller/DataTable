-- chunkname: @modules/logic/store/view/StoreSummonView.lua

module("modules.logic.store.view.StoreSummonView", package.seeall)

local StoreSummonView = class("StoreSummonView", BaseView)

function StoreSummonView:onInitView()
	self._gostorecategoryitem = gohelper.findChild(self.viewGO, "top/scroll_category/viewport/categorycontent/#go_storecategoryitem")
	self._scrollprop = gohelper.findChildScrollRect(self.viewGO, "#scroll_prop")
	self._golock = gohelper.findChild(self.viewGO, "#scroll_prop/#go_lock")
	self._lineGo = gohelper.findChild(self.viewGO, "line")
	self._txtLockText = gohelper.findChildText(self.viewGO, "#scroll_prop/#go_lock/locktext")
	self._simagelockbg = gohelper.findChildSingleImage(self.viewGO, "#scroll_prop/#go_lock/#simage_lockbg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreSummonView:addEvents()
	return
end

function StoreSummonView:removeEvents()
	return
end

function StoreSummonView:_editableInitView()
	self._txtrefreshTime = gohelper.findChildText(self.viewGO, "#txt_refreshTime")

	gohelper.setActive(self._txtrefreshTime.gameObject, false)
	gohelper.setActive(self._gostorecategoryitem, false)

	self._lockClick = gohelper.getClickWithAudio(self._golock)
	self._isLock = false
	self._categoryItemContainer = {}

	self._simagelockbg:LoadImage(ResUrl.getStoreBottomBgIcon("bg_weijiesuodiban"))
end

function StoreSummonView:onDestroyView()
	if self._categoryItemContainer and #self._categoryItemContainer > 0 then
		for i = 1, #self._categoryItemContainer do
			local categotyItem = self._categoryItemContainer[i]

			categotyItem.btn:RemoveClickListener()
		end
	end

	self._simagelockbg:UnLoadImage()
end

function StoreSummonView:onOpen()
	self.storeId = StoreEnum.StoreId.LimitStore

	self.addEventCb(self, StoreController.instance, StoreEvent.GoodsModelChanged, self._updateInfo, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self._updateInfo, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, self._onRefreshRedDot, self)
	self._lockClick:AddClickListener(self._onLockClick, self)
end

function StoreSummonView:onClose()
	self.removeEventCb(self, StoreController.instance, StoreEvent.GoodsModelChanged, self._updateInfo, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self._updateInfo, self)
	self.removeEventCb(self, RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, self._onRefreshRedDot, self)
	self._lockClick:RemoveClickListener()
end

function StoreSummonView:refreshRemainTime()
	local storeEntranceCfg = StoreConfig.instance:getTabConfig(self.storeId)
	local remainTime = StoreHelper.getRemainExpireTime(storeEntranceCfg)

	self._txtrefreshTime.text = remainTime and remainTime > 0 and string.format(luaLang("summon_limit_shop_remaintime"), SummonModel.formatRemainTime(remainTime)) or ""
end

function StoreSummonView:refreshLockStatus()
	if self._selectThirdTabId > 0 then
		self._isLock = StoreModel.instance:isStoreTabLock(self.storeId)

		if self._isLock then
			local co = StoreConfig.instance:getStoreConfig(self.storeId)

			self._txtLockText.text = string.format(luaLang("lock_store_text"), StoreConfig.instance:getTabConfig(co.needClearStore).name)
		end

		gohelper.setActive(self._golock, self._isLock)
	else
		gohelper.setActive(self._golock, false)
	end
end

function StoreSummonView:_refreshSecondTabs(index, secondTabConfig)
	return
end

function StoreSummonView:_refreshGoods()
	return
end

function StoreSummonView:_onLockClick()
	if self._isLock then
		local currentStoreName = StoreConfig.instance:getTabConfig(self.storeId).name

		GameFacade.showToast(ToastEnum.NormalStoreIsLock, currentStoreName)
	end
end

function StoreSummonView:_updateInfo()
	return
end

function StoreSummonView:_onRefreshRedDot()
	for _, v in pairs(self._categoryItemContainer) do
		gohelper.setActive(v.go_reddot, StoreModel.instance:isTabFirstRedDotShow(v.tabId))
	end
end

function StoreSummonView:onUpdateParam()
	return
end

return StoreSummonView
