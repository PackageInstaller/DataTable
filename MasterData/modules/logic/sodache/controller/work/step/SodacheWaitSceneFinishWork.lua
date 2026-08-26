-- chunkname: @modules/logic/sodache/controller/work/step/SodacheWaitSceneFinishWork.lua

module("modules.logic.sodache.controller.work.step.SodacheWaitSceneFinishWork", package.seeall)

local SodacheWaitSceneFinishWork = class("SodacheWaitSceneFinishWork", BaseWork)

function SodacheWaitSceneFinishWork:onStart(context)
	if GameGlobalMgr.instance:getLoadingState():getLoadingViewName() then
		self:waitLoadingFinish()
	else
		self:waitSceneGoLoading()
	end
end

function SodacheWaitSceneFinishWork:waitLoadingFinish()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onViewClose, self)
end

function SodacheWaitSceneFinishWork:_onViewClose()
	if not GameGlobalMgr.instance:getLoadingState():getLoadingViewName() then
		self:waitSceneGoLoading()
	end
end

function SodacheWaitSceneFinishWork:waitSceneGoLoading()
	local tb = {}

	SodacheController.instance:dispatchEvent(SodacheEvent.CheckSceneFinish, tb)

	if tb.isLoading then
		SodacheController.instance:registerCallback(SodacheEvent.OnSceneFinish, self.onSceneFinish, self)
	else
		self:onDone(true)
	end
end

function SodacheWaitSceneFinishWork:onSceneFinish()
	self:onDone(true)
end

function SodacheWaitSceneFinishWork:clearWork()
	SodacheController.instance:unregisterCallback(SodacheEvent.OnSceneFinish, self.onSceneFinish, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onViewClose, self)
end

return SodacheWaitSceneFinishWork
