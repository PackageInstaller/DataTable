-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/rtpk/service/RTPKService.lua

RTPKService = class("RTPKService", Service, _M)

local opType = {
	getInfo = 14301,
	robotBattleFinish = 14309,
	cancelMatch = 14305,
	battleReport = 14307,
	getReward = 14302,
	startMatch = 14304,
	battleReportList = 14308,
	lineUp = 14303,
	robotSurrender = 14311,
	pvpBattleFinish = 14310,
	useEmoji = 10035,
	getTotalWinReward = 14312
}

function RTPKService:initialize()
	super.initialize(self)
end

function RTPKService:dispose()
	super.dispose(self)
end

function RTPKService:requestGetInfo(params, callback, blockUI)
	local request = self:newRequest(opType.getInfo, params, callback)

	self:sendRequest(request, blockUI)
end

function RTPKService:requestGetReward(params, callback, blockUI)
	local request = self:newRequest(opType.getReward, params, callback)

	self:sendRequest(request, blockUI)
end

function RTPKService:requestStartMatch(params, callback, blockUI)
	local request = self:newRequest(opType.startMatch, params, callback)

	self:sendRequest(request, blockUI)
end

function RTPKService:requestCancelMatch(params, callback, blockUI)
	local request = self:newRequest(opType.cancelMatch, params, callback)

	self:sendRequest(request, blockUI)
end

function RTPKService:requestRTPKChangeTeam(params, callback, blockUI)
	local request = self:newRequest(opType.lineUp, params, callback)

	self:sendRequest(request, blockUI)
end

function RTPKService:requestBattleReport(params, callback, blockUI)
	local request = self:newRequest(opType.battleReport, params, callback)

	self:sendRequest(request, blockUI)
end

function RTPKService:requestRobotBattleFinish(params, callback, blockUI)
	local request = self:newRequest(opType.robotBattleFinish, params, callback)

	self:sendRequest(request, blockUI)
end

function RTPKService:requestPvpBattleFinish(params, callback, blockUI)
	local request = self:newRequest(opType.pvpBattleFinish, params, callback)

	self:sendRequest(request, blockUI)
end

function RTPKService:listenRTPKMatchInfo(callback)
	self:addPushHandler(1151, function(op, response)
		callback(response)
	end)
end

function RTPKService:requestBattleReportList(params, callback, blockUI)
	local request = self:newRequest(opType.battleReportList, params, callback)

	self:sendRequest(request, blockUI)
end

function RTPKService:requestRobotBattleSurrender(params, callback, blockUI)
	local request = self:newRequest(opType.robotSurrender, params, callback)

	self:sendRequest(request, blockUI)
end

function RTPKService:requestTotalWinReward(params, callback, blockUI)
	local request = self:newRequest(opType.getTotalWinReward, params, callback)

	self:sendRequest(request, blockUI)
end

function RTPKService:requestUseEmoji(params, callback, blockUI)
	local request = self:newRequest(opType.useEmoji, params, callback)

	self:sendRequest(request, blockUI)
end
