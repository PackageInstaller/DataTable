-- chunkname: @IQIGame\\Module\\Chapter\\ResourceChapter\\ResourceChapterData.lua

local resourcePassData = require("IQIGame.Module.Chapter.ResourceChapter.ResourcePassData")
local ResourceChapterData = {
	extraReward = 0,
	cid = 0
}

function ResourceChapterData.New(DailyDupPOD, pass)
	local obj = Clone(ResourceChapterData)

	obj:RefreshData(DailyDupPOD, pass)

	return obj
end

function ResourceChapterData:RefreshData(DailyDupPOD, pass)
	for k, v in pairs(DailyDupPOD) do
		self[k] = v
	end

	self.cid = DailyDupPOD.cid
	self.extraReward = DailyDupPOD.extraReward
	self.passStatus = {}

	for k, v in pairs(pass) do
		local state

		state = DailyDupPOD.passStatus[v.Id] == nil and 0 or DailyDupPOD.passStatus[v.Id]

		if self.passStatus[v.Id] ~= nil then
			self.passStatus[v.Id]:RefreshData(v.Id, state)
		else
			table.insert(self.passStatus, v.Id, resourcePassData.New(v.Id, state))
		end
	end
end

function ResourceChapterData:GetCfg()
	return CfgDailyDupChapterTable[self.cid]
end

function ResourceChapterData:IsOpen()
	return ActivityModule.IsOpenByTime(self:GetCfg().ActivityId)
end

function ResourceChapterData:SubStageIsUnLock()
	return ConditionModule.Check(self:GetCfg().UnlockConditionId)
end

return ResourceChapterData
