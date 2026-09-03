-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/arena/service/ArenaService.lua

ArenaService = class("ArenaService", Service, _M)

local opType = {}

opType.requestArenaInfo = 21001
opType.beginBattle = 21002
opType.finishBattle = 21003
opType.getReportDetail = 21004
opType.refreshRivalList = 21005
opType.requestChangeTeamName = 10423
opType.failBattle = 21006
opType.quickBattle = 21007

function ArenaService:initialize()
	super.initialize(self)
end

function ArenaService:dispose()
	super.dispose(self)
end

function ArenaService:requestQuickBattle(params, callback, blockUI)
	local request = self:newRequest(opType.quickBattle, params, callback)

	self:sendRequest(request, blockUI)
end

function ArenaService:requestArenaInfo(params, callback, blockUI)
	local request = self:newRequest(opType.requestArenaInfo, params, callback)

	self:sendRequest(request, blockUI)
end

function ArenaService:requestBeginBattle(params, callback, blockUI)
	local request = self:newRequest(opType.beginBattle, params, callback)

	self:sendRequest(request, blockUI)
end

function ArenaService:requestFinishBattle(params, callback, blockUI)
	local request = self:newRequest(opType.finishBattle, params, callback)

	self:sendRequest(request, blockUI)
end

function ArenaService:requestRefreshRivalList(params, callback, blockUI)
	local request = self:newRequest(opType.refreshRivalList, params, callback)

	self:sendRequest(request, blockUI)
end

function ArenaService:requestReportDetail(params, callback, blockUI)
	local request = self:newRequest(opType.getReportDetail, params, callback)

	self:sendRequest(request, blockUI)
end

function ArenaService:requestRenameArenaTeam(params, callback, blockUI)
	local request = self:newRequest(opType.requestChangeTeamName, params, callback)

	self:sendRequest(request, blockUI)
end

function ArenaService:requestFailBattle(params, callback, blockUI)
	local request = self:newRequest(opType.failBattle, params, callback)

	self:sendRequest(request, blockUI)
end
