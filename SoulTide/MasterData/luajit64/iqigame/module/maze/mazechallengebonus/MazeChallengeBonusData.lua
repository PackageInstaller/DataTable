-- chunkname: @IQIGame\\Module\\Maze\\MazeChallengeBonus\\MazeChallengeBonusData.lua

local m = {
	buyState = 1,
	tasks = {}
}

function m.New(cid, buyState, tasks)
	local o = Clone(m)

	o:Init(cid, buyState, tasks)

	return o
end

function m:Init(cid, buyState, tasks)
	self.cid = cid
	self.buyState = buyState
	self.tasks = tasks
end

function m:GetConfig()
	return CfgMazeChallengeBonusTable[self.cid]
end

function m:GetCanGetRewardTasks()
	local tasks = {}

	if self.buyState == 2 then
		for i, v in pairs(self.tasks) do
			if v.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK and v.CurrentNum >= v.TargetNum then
				table.insert(tasks, v.cid)
			end
		end
	end

	return tasks
end

function m:GetFinishTasks()
	local tasks = {}

	if self.buyState == 2 then
		for i, v in pairs(self.tasks) do
			if v.TaskStatus == TaskModule.TaskStatus.FINISH_TASK then
				table.insert(tasks, v.cid)
			end
		end
	end

	return tasks
end

function m:GetState()
	if self.buyState == 2 then
		local taskNum = #self.tasks
		local finishNum = 0

		for i, v in pairs(self.tasks) do
			if v.TaskStatus == TaskModule.TaskStatus.FINISH_TASK then
				finishNum = finishNum + 1
			elseif v.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK and v.CurrentNum >= v.TargetNum then
				return 3
			end
		end

		if taskNum == finishNum then
			return 4
		else
			return 2
		end
	end

	return 1
end

return m
