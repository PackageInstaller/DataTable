-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/mazeTower/service/MazeTowerService.lua

MazeTowerService = class("MazeTowerService", Service, _M)

function MazeTowerService:initialize()
	super.initialize(self)
end

function MazeTowerService:dispose()
	super.dispose(self)
end

function MazeTowerService:requestMove(params, blockUI, callback)
	local request = self:newRequest(37001, params, callback)

	self:sendRequest(request, blockUI)
end

function MazeTowerService:requestFinishBattle(params, blockUI, callback)
	local request = self:newRequest(37002, params, callback)

	self:sendRequest(request, blockUI)
end

function MazeTowerService:requestTaskReward(params, blockUI, callback)
	local request = self:newRequest(37003, params, callback)

	self:sendRequest(request, blockUI)
end

function MazeTowerService:requestMainInfo(params, blockUI, callback)
	local request = self:newRequest(37004, params, callback)

	self:sendRequest(request, blockUI)
end

function MazeTowerService:requestQuickChallenge(params, blockUI, callback)
	local request = self:newRequest(37005, params, callback)

	self:sendRequest(request, blockUI)
end
