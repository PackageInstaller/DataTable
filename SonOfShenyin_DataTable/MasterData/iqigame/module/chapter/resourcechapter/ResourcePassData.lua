-- chunkname: @IQIGame\\Module\\Chapter\\ResourceChapter\\ResourcePassData.lua

local ResourcePassData = {
	isUnLock = false,
	cid = 0
}

function ResourcePassData.New(cid, Status)
	local obj = Clone(ResourcePassData)

	obj:RefreshData(cid, Status)

	return obj
end

function ResourcePassData:RefreshData(cid, Status)
	self.cid = cid
	self.Status = Status
	self.isUnLock = ConditionModule.CheckMultipleAllIsPass(ConditionModule.CheckMultiple(self:GetCfg().UnlockConditionId))
end

function ResourcePassData:GetCfg()
	return CfgDailyDupStageTable[self.cid]
end

return ResourcePassData
