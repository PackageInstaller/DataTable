-- chunkname: @modules/logic/versionactivity1_3/act125/view/Activity125TaskViewBaseContainer.lua

module("modules.logic.versionactivity1_3.act125.view.Activity125TaskViewBaseContainer", package.seeall)

local Activity125TaskViewBaseContainer = class("Activity125TaskViewBaseContainer", Activity125ViewBaseContainer)

function Activity125TaskViewBaseContainer:onContainerInit()
	Activity125TaskViewBaseContainer.super.onContainerInit(self)

	self._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self._taskScrollView)

	self._taskAnimRemoveItem:setMoveInterval(0)
end

function Activity125TaskViewBaseContainer:removeByIndex(index, cb, cbObj)
	self._taskAnimRemoveItem:removeByIndex(index, cb, cbObj)
end

return Activity125TaskViewBaseContainer
