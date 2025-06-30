-- chunkname: @IQIGame\\Module\\Chapter\\BossChapter\\BossChapterData.lua

local bossPassData = require("IQIGame.Module.Chapter.BossChapter.BossPassData")
local BossChapterData = {
	Index = 0,
	cid = 0
}

function BossChapterData.New(DupPOD, pass)
	local obj = Clone(BossChapterData)

	obj:RefreshData(DupPOD, pass)

	return obj
end

function BossChapterData:RefreshData(DupPOD, pass)
	for k, v in pairs(DupPOD) do
		self[k] = v
	end

	self.cid = DupPOD.cid
	self.Index = self:GetCfg().Index
	self.passStatus = {}
	self.optimalIntegral = DupPOD.optimalIntegral
	self.totalIntegral = DupPOD.totalIntegral

	for k, v in pairs(pass) do
		local state

		state = DupPOD.passStatus[v.Id] == nil and 0 or DupPOD.passStatus[v.Id]

		if self.passStatus[v.Id] ~= nil then
			self.passStatus[v.Id]:RefreshData(v.Id, state)
		else
			table.insert(self.passStatus, v.Id, bossPassData.New(v.Id, state))
		end
	end
end

function BossChapterData:GetCfg()
	return CfgBossChapterTable[self.cid]
end

function BossChapterData:SubStageIsUnLock()
	return ConditionModule.Check(self:GetCfg().UnlockConditionId)
end

return BossChapterData
