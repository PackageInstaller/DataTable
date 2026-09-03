-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/newArena/service/ArenaNewService.lua

ArenaNewService = class("ArenaNewService", Service, _M)

function ArenaNewService:initialize()
	super.initialize(self)
end

function ArenaNewService:dispose()
	super.dispose(self)
end

function ArenaNewService:requestGainChessArena(params, callback, blockUI)
	local request = self:newRequest(32001, params, callback)

	self:sendRequest(request, blockUI)
end

function ArenaNewService:requestBeginBattle(params, callback, blockUI)
	local request = self:newRequest(32002, params, callback)

	self:sendRequest(request, blockUI)
end

function ArenaNewService:requestReport(params, callback, blockUI)
	local request = self:newRequest(32003, params, callback)

	self:sendRequest(request, blockUI)
end

function ArenaNewService:resetChallengeTime(params, callback, blockUI)
	local request = self:newRequest(32004, params, callback)

	self:sendRequest(request, blockUI)
end

function ArenaNewService:queryRivalRank(params, callback, blockUI)
	local request = self:newRequest(32005, params, callback)

	self:sendRequest(request, blockUI)
end

function ArenaNewService:requestOfflineReport(params, callback, blockUI)
	local request = self:newRequest(32006, params, callback)

	self:sendRequest(request, blockUI)
end

function ArenaNewService:requestReportDetail(params, callback, blockUI)
	local request = self:newRequest(32007, params, callback)

	self:sendRequest(request, blockUI)
end

function ArenaNewService:requestMainInfoChessArena(params, callback, blockUI)
	local request = self:newRequest(32008, params, callback)

	self:sendRequest(request, blockUI)
end

function ArenaNewService:requestGetChessArenaReward(params, callback, blockUI)
	local request = self:newRequest(32009, params, callback)

	self:sendRequest(request, blockUI)
end
