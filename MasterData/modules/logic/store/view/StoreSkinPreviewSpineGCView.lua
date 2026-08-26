-- chunkname: @modules/logic/store/view/StoreSkinPreviewSpineGCView.lua

module("modules.logic.store.view.StoreSkinPreviewSpineGCView", package.seeall)

local StoreSkinPreviewSpineGCView = class("StoreSkinPreviewSpineGCView", BaseView)
local NeedGCSpineCount = 4

function StoreSkinPreviewSpineGCView:onInitView()
	self._skinList = {}
end

function StoreSkinPreviewSpineGCView:addEvents()
	self.addEventCb(self, StoreController.instance, StoreEvent.OnSwitchSpine, self._recordSkin, self)
end

function StoreSkinPreviewSpineGCView:removeEvents()
	self.removeEventCb(self, StoreController.instance, StoreEvent.OnSwitchSpine, self._recordSkin, self)
end

function StoreSkinPreviewSpineGCView:onOpenFinish()
	self:_recordSkin()
end

function StoreSkinPreviewSpineGCView:onUpdateParam()
	self:_recordSkin()
end

function StoreSkinPreviewSpineGCView:onClose()
	self._skinList = {}

	TaskDispatcher.cancelTask(self._delayGC, self)
end

function StoreSkinPreviewSpineGCView:_recordSkin(skinId)
	table.insert(self._skinList, skinId)

	if #self._skinList > NeedGCSpineCount then
		if #self._skinList < NeedGCSpineCount * 2 then
			TaskDispatcher.cancelTask(self._delayGC, self)
		end

		TaskDispatcher.runDelay(self._delayGC, self, 1)
	end
end

function StoreSkinPreviewSpineGCView:_delayGC()
	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC, self)

	self._skinList = {}
end

return StoreSkinPreviewSpineGCView
