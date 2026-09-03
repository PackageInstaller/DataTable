-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/service/MazeService.lua

MazeService = class("MazeService", Service, _M)

function MazeService:initialize()
	super.initialize(self)
end

function MazeService:dispose()
	super.dispose(self)
end

function MazeService:requestFirstEnterMaze(params, blockUI, callback)
	local request = self:newRequest(12801, params, callback)

	self:sendRequest(request, blockUI)
end

function MazeService:requestNextChapterMaze(params, blockUI, callback)
	local request = self:newRequest(12802, params, callback)

	self:sendRequest(request, blockUI)
end

function MazeService:requestDelOneOption(params, blockUI, callback)
	local request = self:newRequest(12803, params, callback)

	self:sendRequest(request, blockUI)
end

function MazeService:requestMazeBattleBefor(params, blockUI, callback)
	local request = self:newRequest(12804, params, callback)

	self:sendRequest(request, blockUI)
end

function MazeService:requestMazestStartOption(params, blockUI, callback)
	local request = self:newRequest(12805, params, callback)

	self:sendRequest(request, blockUI)
end

function MazeService:requestOverMaze(params, blockUI, callback)
	local request = self:newRequest(12806, params, callback)

	self:sendRequest(request, blockUI)
end

function MazeService:requestMazestUseTreasure(params, blockUI, callback)
	local request = self:newRequest(12807, params, callback)

	self:sendRequest(request, blockUI)
end

function MazeService:requestGetDpReward(params, blockUI, callback)
	local request = self:newRequest(12808, params, callback)

	self:sendRequest(request, blockUI)
end

function MazeService:requestMazeEnableTalent(params, blockUI, callback)
	local request = self:newRequest(12809, params, callback)

	self:sendRequest(request, blockUI)
end

function MazeService:requestMazeResetTalent(params, blockUI, callback)
	local request = self:newRequest(12810, params, callback)

	self:sendRequest(request, blockUI)
end

function MazeService:requestMazeFinalBossBattleBefore(params, blockUI, callback)
	local request = self:newRequest(12811, params, callback)

	self:sendRequest(request, blockUI)
end

function MazeService:requestMazeFinalBossBattleResult(params, blockUI, callback)
	local request = self:newRequest(12812, params, callback)

	self:sendRequest(request, blockUI)
end

function MazeService:requestMazeSelectMasterBuff(params, blockUI, callback)
	local request = self:newRequest(12813, params, callback)

	self:sendRequest(request, blockUI)
end

function MazeService:requestMazeEventSkillId(params, blockUI, callback)
	local request = self:newRequest(12814, params, callback)

	self:sendRequest(request, blockUI)
end
