-- chunkname: @modules/logic/versionactivity2_8/dungeontaskstore/view/store/VersionActivity2_8StoreView.lua

module("modules.logic.versionactivity2_8.dungeontaskstore.view.store.VersionActivity2_8StoreView", package.seeall)

local VersionActivity2_8StoreView = class("VersionActivity2_8StoreView", BaseView)

function VersionActivity2_8StoreView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._scrollstore = gohelper.findChildScrollRect(self.viewGO, "#scroll_store")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content")
	self._gostoreItem = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem")
	self._gostoregoodsitem = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem/#go_storegoodsitem")
	self._txttime = gohelper.findChildText(self.viewGO, "title/#txt_time")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_8StoreView:addEvents()
	return
end

function VersionActivity2_8StoreView:removeEvents()
	return
end

function VersionActivity2_8StoreView:_editableInitView()
	self.addEventCb(self, VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, self.onBuyGoodsSuccess, self)
	self.addEventCb(self, JumpController.instance, JumpEvent.BeforeJump, self.closeThis, self)
end

function VersionActivity2_8StoreView:onBuyGoodsSuccess()
	self:refreshStore()
end

function VersionActivity2_8StoreView:onOpen()
	self:refreshUI()
	TaskDispatcher.runRepeat(self.refreshTime, self, 1)
end

function VersionActivity2_8StoreView:refreshUI()
	self:refreshStore()
	self:refreshTime()
end

function VersionActivity2_8StoreView:refreshStore()
	VersionActivity2_8StoreListModel.instance:refreshStore()
end

function VersionActivity2_8StoreView:refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity2_8DungeonTaskStoreController.instance:getModuleConfig().DungeonStore]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	self._txttime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
end

function VersionActivity2_8StoreView:onClose()
	TaskDispatcher.cancelTask(self.refreshTime, self)
end

function VersionActivity2_8StoreView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return VersionActivity2_8StoreView
