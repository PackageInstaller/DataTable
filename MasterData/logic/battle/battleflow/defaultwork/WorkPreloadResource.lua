-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/WorkPreloadResource.lua

module("logic.battle.battleflow.defaultwork.WorkPreloadResource", package.seeall)

local WorkPreloadResource = class("WorkPreloadResource", WorkBase)

function WorkPreloadResource:onEnter(context)
	self._preloadMgr = context.preloadMgr

	self._preloadMgr:preload(self._onResourceLoaded, self)
end

function WorkPreloadResource:onExit(isInterrupt)
	self._preloadMgr:removeListener()
end

function WorkPreloadResource:_onResourceLoaded(isSuccess)
	if isSuccess then
		self:onDone(WorkResult.Succeed)
	else
		self:onDone(WorkResult.Fail)
	end
end

return WorkPreloadResource
