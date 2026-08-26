-- chunkname: @modules/logic/versionactivity1_9/dungeon/view/store/VersionActivity1_9StoreView.lua

module("modules.logic.versionactivity1_9.dungeon.view.store.VersionActivity1_9StoreView", package.seeall)

local VersionActivity1_9StoreView = class("VersionActivity1_9StoreView", BaseView)

function VersionActivity1_9StoreView:onInitView()
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

function VersionActivity1_9StoreView:addEvents()
	return
end

function VersionActivity1_9StoreView:removeEvents()
	return
end

function VersionActivity1_9StoreView:_editableInitView()
	self._simagebg:LoadImage("singlebg/v1a9_mainactivity_singlebg/v1a9_store_fullbg.png")
	self.addEventCb(self, VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, self.onBuyGoodsSuccess, self)
	self.addEventCb(self, JumpController.instance, JumpEvent.BeforeJump, self.closeThis, self)
end

function VersionActivity1_9StoreView:onBuyGoodsSuccess()
	self:refreshStore()
end

function VersionActivity1_9StoreView:onOpen()
	self:refreshUI()
end

function VersionActivity1_9StoreView:refreshUI()
	self:refreshStore()
	self:refreshTime()
end

function VersionActivity1_9StoreView:refreshStore()
	VersionActivity1_9StoreListModel.instance:refreshStore()
end

function VersionActivity1_9StoreView:refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity1_9Enum.ActivityId.DungeonStore]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	self._txttime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
end

function VersionActivity1_9StoreView:onClose()
	return
end

function VersionActivity1_9StoreView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return VersionActivity1_9StoreView
