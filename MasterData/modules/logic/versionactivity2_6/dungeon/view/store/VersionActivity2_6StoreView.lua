-- chunkname: @modules/logic/versionactivity2_6/dungeon/view/store/VersionActivity2_6StoreView.lua

module("modules.logic.versionactivity2_6.dungeon.view.store.VersionActivity2_6StoreView", package.seeall)

local VersionActivity2_6StoreView = class("VersionActivity2_6StoreView", BaseView)

function VersionActivity2_6StoreView:onInitView()
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

function VersionActivity2_6StoreView:addEvents()
	return
end

function VersionActivity2_6StoreView:removeEvents()
	return
end

function VersionActivity2_6StoreView:_editableInitView()
	self.addEventCb(self, VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, self.onBuyGoodsSuccess, self)
	self.addEventCb(self, JumpController.instance, JumpEvent.BeforeJump, self.closeThis, self)
end

function VersionActivity2_6StoreView:onBuyGoodsSuccess()
	self:refreshStore()
end

function VersionActivity2_6StoreView:onOpen()
	self:refreshUI()
end

function VersionActivity2_6StoreView:refreshUI()
	self:refreshStore()
	self:refreshTime()
end

function VersionActivity2_6StoreView:refreshStore()
	VersionActivity2_6StoreListModel.instance:refreshStore()
end

function VersionActivity2_6StoreView:refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity2_6Enum.ActivityId.DungeonStore]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	self._txttime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
end

function VersionActivity2_6StoreView:onClose()
	return
end

function VersionActivity2_6StoreView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return VersionActivity2_6StoreView
