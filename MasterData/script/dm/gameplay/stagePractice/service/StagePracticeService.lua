-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stagePractice/service/StagePracticeService.lua

StagePracticeService = class("StagePracticeService", Service, _M)

function StagePracticeService:initialize()
	super.initialize(self)
end

function StagePracticeService:dispose()
	super.dispose(self)
end

function StagePracticeService:requestEnterPracticeMain(params, blockUI, callback)
	local request = self:newRequest(13001, params, callback)

	self:sendRequest(request, blockUI)
end

function StagePracticeService:requestPracticeBattleBefor(params, blockUI, callback)
	local request = self:newRequest(13002, params, callback)

	self:sendRequest(request, blockUI)
end

function StagePracticeService:requestBattleAfter(params, blockUI, callback)
	local request = self:newRequest(13003, params, callback)

	self:sendRequest(request, blockUI)
end

function StagePracticeService:getPointReward(params, blockUI, callback)
	local request = self:newRequest(13004, params, callback)

	self:sendRequest(request, blockUI)
end

function StagePracticeService:requestEmbattle(params, blockUI, callback)
	local request = self:newRequest(13005, params, callback)

	self:sendRequest(request, blockUI)
end

function StagePracticeService:requestGetMapFullStarReward(params, blockUI, callback)
	local request = self:newRequest(13006, params, callback)

	self:sendRequest(request, blockUI)
end

function StagePracticeService:requestRank(params, blockUI, callback)
	local request = self:newRequest(10602, params, callback)

	self:sendRequest(request, blockUI)
end

function StagePracticeService:requestPublishPointComment(params, blockUI, callback)
	local request = self:newRequest(13007, params, callback)

	self:sendRequest(request, blockUI)
end

function StagePracticeService:requestSupportPointComment(params, blockUI, callback)
	local request = self:newRequest(13008, params, callback)

	self:sendRequest(request, blockUI)
end

function StagePracticeService:requestPointComment(params, blockUI, callback)
	local request = self:newRequest(13009, params, callback)

	self:sendRequest(request, blockUI)
end

function StagePracticeService:requestLevelStagePractice(params, blockUI, callback)
	local request = self:newRequest(13010, params, callback)

	self:sendRequest(request, blockUI)
end

function StagePracticeService:requestSaveStageTeam(params, blockUI, callback)
	local request = self:newRequest(13013, params, callback)

	self:sendRequest(request, blockUI)
end

function StagePracticeService:requestStageBattleBefore(params, blockUI, callback)
	local request = self:newRequest(13011, params, callback)

	self:sendRequest(request, blockUI)
end

function StagePracticeService:requestStageBattleAfter(params, blockUI, callback)
	local request = self:newRequest(13012, params, callback)

	self:sendRequest(request, blockUI)
end

function StagePracticeService:requestLeaveStagePoint(params, blockUI, callback)
	local request = self:newRequest(13014, params, callback)

	self:sendRequest(request, blockUI)
end
