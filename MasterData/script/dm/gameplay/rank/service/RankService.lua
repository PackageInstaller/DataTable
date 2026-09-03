-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/rank/service/RankService.lua

RankService = class("RankService", Service, _M)

local opType = {}

opType.requestNormalRankData = 10601
opType.requestAloneRankData = 10602
opType.getRewardList = 10603
opType.obtainRewardList = 10604
opType.getSubsboard = 10605
opType.getRTPKAllserverList = 14306

function RankService:initialize()
	super.initialize(self)
end

function RankService:dispose()
	super.dispose(self)
end

function RankService:requestSupportRankData(params, blockUI, callback)
	local request = self:newRequest(opType.getSubsboard, params, callback)

	self:sendRequest(request, blockUI)
end

function RankService:requestRankData(params, blockUI, callback)
	local request = self:newRequest(opType.requestNormalRankData, params, callback)

	self:sendRequest(request, blockUI)
end

function RankService:requestNormalRankData(params, callback, blockUI)
	local request = self:newRequest(opType.requestNormalRankData, params, callback)

	self:sendRequest(request, blockUI)
end

function RankService:requestAloneRankData(params, blockUI, callback)
	local request = self:newRequest(opType.requestAloneRankData, params, callback)

	self:sendRequest(request, blockUI)
end

function RankService:requestGetRewardList(params, blockUI, callback)
	local request = self:newRequest(opType.getRewardList, params, callback)

	self:sendRequest(request, blockUI)
end

function RankService:requestObtainRewardList(params, blockUI, callback)
	local request = self:newRequest(opType.obtainRewardList, params, callback)

	self:sendRequest(request, blockUI)
end

function RankService:requestRTPKAllServerRankData(params, blockUI, callback)
	local request = self:newRequest(opType.getRTPKAllserverList, params, callback)

	self:sendRequest(request, blockUI)
end

function RankService:requestStageAreanaAllServerRankData(params, blockUI, callback)
	local request = self:newRequest(14402, params, callback)

	self:sendRequest(request, blockUI)
end
