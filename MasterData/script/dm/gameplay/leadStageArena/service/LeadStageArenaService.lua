-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/leadStageArena/service/LeadStageArenaService.lua

LeadStageArenaService = class("LeadStageArenaService", Service, _M)

function LeadStageArenaService:initialize()
	super.initialize(self)
end

function LeadStageArenaService:dispose()
	super.dispose(self)
end

function LeadStageArenaService:requestBeginBattle(params, callback, blockUI)
	dump(params)

	local request = self:newRequest(14410, params, callback)

	self:sendRequest(request, blockUI)
end

function LeadStageArenaService:requestQuickBeginBattle(params, callback, blockUI)
	dump(params)

	local request = self:newRequest(14413, params, callback)

	self:sendRequest(request, blockUI)
end

function LeadStageArenaService:requestFinishBattle(params, callback, blockUI)
	local request = self:newRequest(14412, params, callback)

	self:sendRequest(request, blockUI)
end

function LeadStageArenaService:requestGetSeasonInfo(params, callback, blockUI)
	local request = self:newRequest(14401, params, callback)

	self:sendRequest(request, blockUI)
end

function LeadStageArenaService:requestGetMainInfo(params, callback, blockUI)
	local request = self:newRequest(14411, params, callback)

	self:sendRequest(request, blockUI)
end

function LeadStageArenaService:requestEnter(params, callback, blockUI)
	local request = self:newRequest(14403, params, callback)

	self:sendRequest(request, blockUI)
end

function LeadStageArenaService:requestRefreshRival(params, callback, blockUI)
	local request = self:newRequest(14404, params, callback)

	self:sendRequest(request, blockUI)
end

function LeadStageArenaService:requestBuyTimes(params, callback, blockUI)
	local request = self:newRequest(14414, params, callback)

	self:sendRequest(request, blockUI)
end

function LeadStageArenaService:requestSpeedUp(params, callback, blockUI)
	local request = self:newRequest(14405, params, callback)

	self:sendRequest(request, blockUI)
end

function LeadStageArenaService:requestCheers(params, callback, blockUI)
	local request = self:newRequest(14406, params, callback)

	self:sendRequest(request, blockUI)
end

function LeadStageArenaService:requestBattleReportList(params, callback, blockUI)
	local request = self:newRequest(14407, params, callback)

	self:sendRequest(request, blockUI)
end

function LeadStageArenaService:requestBattleReport(params, callback, blockUI)
	local request = self:newRequest(14408, params, callback)

	self:sendRequest(request, blockUI)
end

function LeadStageArenaService:requestLineUp(params, callback, blockUI)
	local request = self:newRequest(14409, params, callback)

	self:sendRequest(request, blockUI)
end

function LeadStageArenaService:requestObtainCoinReward(params, callback, blockUI)
	local request = self:newRequest(14413, params, callback)

	self:sendRequest(request, blockUI)
end
