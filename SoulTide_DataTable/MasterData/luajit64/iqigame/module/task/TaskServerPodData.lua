-- chunkname: @IQIGame\\Module\\Task\\TaskServerPodData.lua

TaskServerPodData = {
	finNum = -1,
	IsSendEvent = false,
	tgtNum = -1,
	CountDownTime = -1,
	createTime = -1,
	IsFail = false,
	cid = -1
}

function TaskServerPodData.New(taskPodData)
	local TaskData = Clone(TaskServerPodData)

	for key, value in pairs(taskPodData) do
		TaskData[key] = value
	end

	TaskData.CfgTaskData = CfgMainQuestTable[TaskData.cid]
	TaskData.IsSendEvent = false

	return TaskData
end

function TaskServerPodData:IsFailed()
	if self.CfgTaskData.FailCondition[1] == 1 then
		local second = self.createTime + self.CfgTaskData.FailCondition[2] - PlayerModule.GetServerTime()

		if second <= 0 then
			return true
		end
	end

	return false
end
