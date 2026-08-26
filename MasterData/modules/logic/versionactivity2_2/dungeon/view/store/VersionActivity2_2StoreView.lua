-- chunkname: @modules/logic/versionactivity2_2/dungeon/view/store/VersionActivity2_2StoreView.lua

module("modules.logic.versionactivity2_2.dungeon.view.store.VersionActivity2_2StoreView", package.seeall)

local VersionActivity2_2StoreView = class("VersionActivity2_2StoreView", BaseView)

function VersionActivity2_2StoreView:onInitView()
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

function VersionActivity2_2StoreView:addEvents()
	return
end

function VersionActivity2_2StoreView:removeEvents()
	return
end

function VersionActivity2_2StoreView:_editableInitView()
	self.addEventCb(self, VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, self.onBuyGoodsSuccess, self)
	self.addEventCb(self, JumpController.instance, JumpEvent.BeforeJump, self.closeThis, self)
end

function VersionActivity2_2StoreView:onBuyGoodsSuccess()
	self:refreshStore()
end

function VersionActivity2_2StoreView:onOpen()
	self:refreshUI()
end

function VersionActivity2_2StoreView:refreshUI()
	self:refreshStore()
	self:refreshTime()
end

function VersionActivity2_2StoreView:refreshStore()
	VersionActivity2_2StoreListModel.instance:refreshStore()
end

function VersionActivity2_2StoreView:refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity2_2Enum.ActivityId.DungeonStore]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	self._txttime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
end

function VersionActivity2_2StoreView:onClose()
	return
end

function VersionActivity2_2StoreView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return VersionActivity2_2StoreView
