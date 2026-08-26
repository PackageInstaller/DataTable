-- chunkname: @modules/logic/scene/cachot/comp/CachotEventComp.lua

module("modules.logic.scene.cachot.comp.CachotEventComp", package.seeall)

local CachotEventComp = class("CachotEventComp", BaseSceneComp)

function CachotEventComp:init()
	self._isShowEvents = true
	self._eventItems = {}
	self._preloadComp = self:getCurScene().preloader
	self._levelComp = self:getCurScene().level

	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.RoomChangeBegin, self._clearEvents, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.TriggerEvent, self._clearEvents, self)
	self._levelComp:registerCallback(CommonSceneLevelComp.OnLevelLoaded, self.onSceneLevelLoaded, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._checkHaveViewOpen, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._checkHaveViewOpen, self)

	if self._levelComp:getSceneGo() then
		self:onSceneLevelLoaded()
	end
end

function CachotEventComp:_checkHaveViewOpen()
	local isShowEvents = ViewHelper.instance:checkViewOnTheTop(ViewName.V1a6_CachotRoomView, {
		ViewName.GuideView,
		ViewName.GuideView2,
		ViewName.GuideStepEditor
	})

	if PopupController.instance:getPopupCount() > 0 then
		isShowEvents = false
	end

	isShowEvents = (ViewMgr.instance:isOpen(ViewName.LoadingView) or ViewMgr.instance:isOpen(ViewName.V1a6_CachotLoadingView) or ViewMgr.instance:isOpen(ViewName.V1a6_CachotLayerChangeView)) and false

	if self._isShowEvents ~= isShowEvents then
		self._isShowEvents = isShowEvents

		for _, eventItem in pairs(self._eventItems) do
			gohelper.setActive(eventItem.go, isShowEvents)
		end
	end
end

function CachotEventComp:_clearEvents()
	for _, eventItem in pairs(self._eventItems) do
		gohelper.destroy(eventItem.go)
	end

	self._eventItems = {}
end

function CachotEventComp:onSceneLevelLoaded()
	self:_checkHaveViewOpen()

	local events = V1a6_CachotRoomModel.instance:getRoomEventMos()

	for i = 1, #events do
		local mo = events[i]
		local eventParent = self._levelComp:getEventTr(mo.index).gameObject
		local eventGo = self._preloadComp:getResInst(CachotScenePreloader.EventItem, eventParent)

		gohelper.removeEffectNode(eventGo)

		self._eventItems[i] = MonoHelper.addNoUpdateLuaComOnceToGo(eventGo, CachotEventItem)

		self._eventItems[i]:updateMo(mo)
		gohelper.setActive(eventGo, self._isShowEvents)
	end
end

function CachotEventComp:onSceneClose()
	self._eventItems = {}

	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.RoomChangeBegin, self._clearEvents, self)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.TriggerEvent, self._clearEvents, self)
	self._levelComp:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, self.onSceneLevelLoaded, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._checkHaveViewOpen, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._checkHaveViewOpen, self)
end

return CachotEventComp
