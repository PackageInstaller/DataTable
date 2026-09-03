-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/service/StageService.lua

StageService = class("StageService", Service, _M)

local opType = {
	OPCODE_HEROSTORY_ENTER = 10501,
	OPCODE_HEROSTORY_GETBOXREWARD = 10503,
	OPCODE_STAGE_RESET_TIMES = 10407,
	OPCODE_HEROSTORY_ASKPROGRESS = 10505,
	OPCODE_HEROSTAGE_SWEEP = 10506,
	OPCODE_STAGE_GET_CLEARANCE_REWARD = 10405,
	OPCODE_STAGE_GET_MAP_DIAMOND = 10415,
	OPCODE_STAGE_GET_PROGRESS = 10401,
	OPCODE_STAGE_ENTER = 10402,
	OPCODE_STAGE_SWEEP = 10406,
	OPCODE_STAGE_RUNBOX = 10414,
	OPCODE_STAGE_LEAVE = 10416,
	OPCODE_STAGE_CHANGE_TEAM = 10417,
	OPCODE_STAGE_TEAM_NAME = 10418,
	OPCODE_STAGE_TEAM = 10419,
	OPCODE_SPSTAGE_CHANGE_TEAM = 10420,
	OPCODE_STAGE_GET_STARS_REWARD = 10404,
	OPCODE_STAGE_GET_SECTIONREWARD = 10422,
	OPCODE_FIGHT_RESOULT_CHECK = 10403,
	OPCODE_HEROSTORY_RESOULT_CHECK = 10502,
	OPCODE_HEROSTORY_LEAVE = 10504,
	OPCODE_STAGE_QUICKCHANGE_ENTER = 10425,
	OPCODE_STAGE_STORY = 10421
}

function StageService:initialize()
	super.initialize(self)
end

function StageService:dispose()
	super.dispose(self)
end

function StageService:requestStageProgress(params, blockUI, callback)
	local request = self:newRequest(opType.OPCODE_STAGE_GET_PROGRESS, params, function(response)
		if callback ~= nil then
			callback(response)
		end
	end)

	self:sendRequest(request, blockUI)
end

function StageService:requestHeroStoryProgress(params, blockUI, callback)
	local request = self:newRequest(opType.OPCODE_HEROSTORY_ASKPROGRESS, params, function(response)
		if callback ~= nil then
			callback(response)
		end
	end)

	self:sendRequest(request, blockUI)
end

function StageService:requestStageEnter(params, blockUI, callback)
	local request = self:newRequest(opType.OPCODE_STAGE_ENTER, params, function(response)
		if callback ~= nil then
			callback(response)
		end
	end)

	self:sendRequest(request, blockUI)
end

function StageService:requestQuickStageEnter(params, blockUI, callback)
	local request = self:newRequest(opType.OPCODE_STAGE_QUICKCHANGE_ENTER, params, function(response)
		if callback ~= nil then
			callback(response)
		end
	end)

	self:sendRequest(request, blockUI)
end

function StageService:requestStageGetClearanceReward(params, callback, blockUI)
	local request = self:newRequest(opType.OPCODE_STAGE_GET_CLEARANCE_REWARD, params, function(response)
		if callback ~= nil then
			callback(response)
		end
	end)

	self:sendRequest(request, blockUI)
end

function StageService:requestPass(params, callback, blockUI)
	local request = self:newRequest(opType.OPCODE_FIGHT_RESOULT_CHECK, params, function(response)
		if callback ~= nil then
			callback(response)
		end
	end)

	self:sendRequest(request, blockUI)
end

function StageService:requestStageStarsReward(params, callback, blockUI)
	local request = self:newRequest(opType.OPCODE_STAGE_GET_STARS_REWARD, params, function(response)
		if callback ~= nil then
			callback(response)
		end
	end)

	self:sendRequest(request, blockUI)
end

function StageService:requestStoryPass(params, callback, blockUI)
	local request = self:newRequest(opType.OPCODE_STAGE_STORY, params, function(response)
		if callback ~= nil then
			callback(response)
		end
	end)

	self:sendRequest(request, blockUI)
end

function StageService:requestStageSweep(params, callback, blockUI)
	local request = self:newRequest(opType.OPCODE_STAGE_SWEEP, params, function(response)
		if callback ~= nil then
			callback(response)
		end
	end)

	self:sendRequest(request, blockUI)
end

function StageService:requestHeroStageSweep(params, callback, blockUI)
	local request = self:newRequest(opType.OPCODE_HEROSTAGE_SWEEP, params, function(response)
		if callback ~= nil then
			callback(response)
		end
	end)

	self:sendRequest(request, blockUI)
end

function StageService:requestResetPointTimes(params, callback, notShowWaiting)
	local request = self:newRequest(opType.OPCODE_STAGE_RESET_TIMES, params, callback)

	self:sendRequest(request, not notShowWaiting)
end

function StageService:requestRunBox(params, callback, notShowWaiting)
	local request = self:newRequest(opType.OPCODE_STAGE_RUNBOX, params, callback)

	self:sendRequest(request, not notShowWaiting)
end

function StageService:requestMapDiamond(params, callback, notShowWaiting)
	local request = self:newRequest(opType.OPCODE_STAGE_GET_MAP_DIAMOND, params, callback)

	self:sendRequest(request, not notShowWaiting)
end

function StageService:requestLeaveStage(params, callback, notShowWaiting)
	local request = self:newRequest(opType.OPCODE_STAGE_LEAVE, params, callback)

	self:sendRequest(request, not notShowWaiting)
end

function StageService:requestChangeTeam(params, callback, blockUI)
	local request = self:newRequest(opType.OPCODE_STAGE_CHANGE_TEAM, params, function(response)
		if callback then
			callback(response)
		end
	end)

	self:sendRequest(request, blockUI)
end

function StageService:requestStageTeam(params, callback, blockUI)
	local request = self:newRequest(opType.OPCODE_STAGE_TEAM, params, function(response)
		if callback then
			callback(response)
		end
	end)

	self:sendRequest(request, blockUI)
end

function StageService:requestChangeTeamName(params, callback, blockUI)
	local request = self:newRequest(opType.OPCODE_STAGE_TEAM_NAME, params, function(response)
		if callback then
			callback(response)
		end
	end)

	self:sendRequest(request, blockUI)
end

function StageService:requestSPChangeTeam(params, callback, blockUI)
	local request = self:newRequest(opType.OPCODE_SPSTAGE_CHANGE_TEAM, params, function(response)
		if callback then
			callback(response)
		end
	end)

	self:sendRequest(request, blockUI)
end

function StageService:requestSectionReward(params, callback, blockUI)
	local request = self:newRequest(opType.OPCODE_STAGE_GET_SECTIONREWARD, params, function(response)
		if callback then
			callback(response)
		end
	end)

	self:sendRequest(request, blockUI)
end

function StageService:requestEnterHeroStory(params, callback, blockUI)
	local request = self:newRequest(opType.OPCODE_HEROSTORY_ENTER, params, function(response)
		if callback then
			callback(response)
		end
	end)

	self:sendRequest(request, blockUI)
end

function StageService:requestPassHeroStory(params, callback, blockUI)
	local request = self:newRequest(opType.OPCODE_HEROSTORY_RESOULT_CHECK, params, function(response)
		if callback then
			callback(response)
		end
	end)

	self:sendRequest(request, blockUI)
end

function StageService:requestHeroStoryStarsReward(params, callback, blockUI)
	local request = self:newRequest(opType.OPCODE_HEROSTORY_GETBOXREWARD, params, function(response)
		if callback then
			callback(response)
		end
	end)

	self:sendRequest(request, blockUI)
end

function StageService:requestLeaveHeroStory(params, callback, blockUI)
	local request = self:newRequest(opType.OPCODE_HEROSTORY_LEAVE, params, function(response)
		if callback then
			callback(response)
		end
	end)

	self:sendRequest(request, blockUI)
end
