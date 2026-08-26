-- chunkname: @modules/logic/necrologiststory/view/control/NecrologistStoryControlMgrItem.lua

module("modules.logic.necrologiststory.view.control.NecrologistStoryControlMgrItem", package.seeall)

local NecrologistStoryControlMgrItem = class("NecrologistStoryControlMgrItem", UserDataDispose)

function NecrologistStoryControlMgrItem:ctor(mgr, itemCls)
	self:__onInit()

	self.mgrComp = mgr
	self.itemCls = itemCls
end

function NecrologistStoryControlMgrItem:setStoryId(storyId)
	self.storyId = storyId
end

function NecrologistStoryControlMgrItem:setParam(controlParam, controlDelay, isSkip, fromItem)
	self.controlParam = controlParam
	self.controlDelay = controlDelay
	self.isSkip = isSkip
	self.fromItem = fromItem
	self._isFinish = false

	if self.fromItem then
		self.addEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnStoryItemClickNext, self.onStoryItemClickNextInternal, self)
	end
end

function NecrologistStoryControlMgrItem:playControl()
	local delayTime = tonumber(self.controlDelay)

	if delayTime and delayTime > 0 and not self.isSkip then
		TaskDispatcher.runDelay(self.onPlayControl, self, delayTime)
		self:onPlayControlFinish()
	else
		self:onPlayControl()
	end
end

function NecrologistStoryControlMgrItem:getControlItem(cls)
	if not cls then
		self:onPlayControlFinish()

		return
	end

	self.mgrComp:createControlItem(cls, self.storyId, self.controlParam, self.onPlayControlFinish, self)
end

function NecrologistStoryControlMgrItem:isFinish()
	return self._isFinish
end

function NecrologistStoryControlMgrItem:onPlayControl()
	self:getControlItem(self.itemCls)
end

function NecrologistStoryControlMgrItem:onPlayControlFinish()
	if self._isFinish then
		return
	end

	self._isFinish = true

	self.mgrComp:onItemFinish(self)
end

function NecrologistStoryControlMgrItem:onStoryItemClickNextInternal(storyId)
	if storyId ~= self.storyId then
		return
	end

	self:onStoryItemClickNext()
end

function NecrologistStoryControlMgrItem:onStoryItemClickNext()
	TaskDispatcher.cancelTask(self.onPlayControl, self)
end

function NecrologistStoryControlMgrItem:onDestory()
	TaskDispatcher.cancelTask(self.onPlayControl, self)
	self:__onDispose()
end

return NecrologistStoryControlMgrItem
