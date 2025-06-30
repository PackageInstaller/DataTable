-- chunkname: @IQIGame\\Module\\Guild\\GuildMissData.lua

local m = {
	TargetNum = 0,
	TotalStage = 0,
	CurrentNum = 0,
	GetRewardStatus = 0,
	TaskStatus = 0,
	Cid = 0
}

function m.New(cid, currentNum, targetNum, taskStatus)
	local obj = Clone(m)

	obj:Init(cid, currentNum, targetNum, taskStatus)

	return obj
end

function m:Init(cid, currentNum, targetNum, taskStatus)
	self.Cid = cid
	self.CfgInfo = CfgGuildMissionTable[self.Cid]
	self.CurrentNum = currentNum
	self.TargetNum = targetNum
	self.TaskStatus = taskStatus
	self.TotalStage = self:GetMaxState()
end

function m:RefreshData(currentNum, status)
	self.CurrentNum = currentNum
	self.TaskStatus = status
end

function m:GetMaxState()
	local maxStage = 0

	for i, v in pairsCfg(CfgGuildMissionTable) do
		if v.Group == self.CfgInfo.Group and maxStage < v.DisplayOrder then
			maxStage = v.DisplayOrder
		end
	end

	return maxStage
end

return m
