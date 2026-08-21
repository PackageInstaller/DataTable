-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/GuiTimelineGadgetView.lua

module("logic.extensions.common.view.GuiTimelineGadgetView", package.seeall)

local M = class("GuiTimelineGadgetView", ViewComponent)

function M:ctor()
	return
end

function M:buildUI()
	return
end

function M:destroyUI()
	removetimer(self._setOpenAniFinish, self)
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self._isEnter = true
	self._setByClick = false
	self._openAniFinish = false

	self:setEvent(true)
end

function M:onExit()
	removetimer(self._setOpenAniFinish, self)

	self._isEnter = false
	self._setByClick = false
	self._openAniFinish = false

	self:setEvent(false)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.INPUT_POINTER_PRESSED, self._handlePointerPressed, self)
		self:registerLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
	else
		GlobalDispatcher:removeEventListener(EventType.INPUT_POINTER_PRESSED, self._handlePointerPressed, self)
		self:unregisterLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
	end
end

function M:_handlePointerPressed(_, position)
	self:_tryDealClick()
end

function M:_handleViewAniDoneEvent(key, tagName, reason)
	if self._setByClick then
		return
	end

	if tagName == "open" then
		self._openAniFinish = true
	end
end

function M:getOpenAniFinish()
	return self._openAniFinish
end

function M:_tryDealClick()
	if not self._isEnter or self._openAniFinish then
		return
	end

	self._setByClick = true

	self._viewPresentor:jumpOpenAniToEnd()
	self:localNotify(EventType.ON_UI_TIMELINE_JUMP_TO_END)
	settimer(0, self._setOpenAniFinish, self, false)
end

function M:_setOpenAniFinish()
	self._openAniFinish = true
end

return M
