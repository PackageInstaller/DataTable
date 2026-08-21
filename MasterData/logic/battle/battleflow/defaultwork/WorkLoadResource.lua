-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/WorkLoadResource.lua

module("logic.battle.battleflow.defaultwork.WorkLoadResource", package.seeall)

local WorkLoadResource = class("WorkLoadResource", WorkBase)

function WorkLoadResource:onEnter(context)
	self._resMgr = context.resMgr

	self._resMgr:load(self._onResourceLoaded, self)
end

function WorkLoadResource:onExit(isInterrupt)
	self._resMgr:removeListener()
end

function WorkLoadResource:_onResourceLoaded(isSuccess)
	if isSuccess then
		self:onDone(WorkResult.Succeed)
	else
		self:onDone(WorkResult.Fail)
	end
end

return WorkLoadResource
