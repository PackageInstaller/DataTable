-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/task/service/TaskService.lua

TaskService = class("TaskService", Service, _M)

function TaskService:requestTaskList(params, blockUI, callback)
	local request = self:newRequest(22001, params, callback)

	self:sendRequest(request, blockUI)
end

function TaskService:requestTaskReward(params, blockUI, callback)
	local request = self:newRequest(22002, params, callback)

	self:sendRequest(request, blockUI)
end

function TaskService:requestBoxReward(params, blockUI, callback)
	local request = self:newRequest(22003, params, callback)

	self:sendRequest(request, blockUI)
end

function TaskService:requestWeekBoxReward(params, blockUI, callback)
	local request = self:newRequest(22004, params, callback)

	self:sendRequest(request, blockUI)
end

function TaskService:requestAchievementReward(params, callback, blockUI)
	local request = self:newRequest(22005, params, callback)

	self:sendRequest(request, blockUI)
end

function TaskService:requestOneKeyDailyTaskReward(params, blockUI, callback)
	local request = self:newRequest(22006, params, callback)

	self:sendRequest(request, blockUI)
end

function TaskService:requestOneKeyAchievementReward(params, blockUI, callback)
	local request = self:newRequest(22007, params, callback)

	self:sendRequest(request, blockUI)
end

function TaskService:oneKeyURTaskReward(params, blockUI, callback)
	local request = self:newRequest(22009, params, callback)

	self:sendRequest(request, blockUI)
end

function TaskService:requestObtainCoinRewardOneKey(params, blockUI, callback)
	local request = self:newRequest(22008, params, callback)

	self:sendRequest(request, blockUI)
end
