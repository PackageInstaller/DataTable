-- chunkname: @IQIGame\\Module\\CommonActivity\\Survival\\SurvivalChallengeLevelData.lua

local m = {
	cid = 0
}

function m.New(cid, podData)
	local o = Clone(m)

	o:Init(cid, podData)

	return o
end

function m:Init(cid, podData)
	self.cid = cid

	self:UpdateData(podData)
end

function m:UpdateData(podData)
	self.levelStatusPod = podData
end

function m:IsOpen()
	if self:GetCfgData().FrontLoadedLv == 0 then
		return true
	end

	if SurvivalModule.dailyDupPOD then
		for i, v in pairs(SurvivalModule.dailyDupPOD.survivalPOD.pass) do
			if v.id == self:GetCfgData().FrontLoadedLv then
				return true
			end
		end
	end

	return false
end

function m:GetCfgData()
	return CfgSurvivalChallengeLevelTable[self.cid]
end

function m:RewardIsComplete(index)
	if self.levelStatusPod then
		local serverIndex = index - 1

		if table.indexOf(self.levelStatusPod.award, serverIndex) ~= -1 then
			return true
		end
	end

	return false
end

function m:GetRefreshMonsterByTime(time)
	local index = table.indexOf(self:GetCfgData().RefreshMonsterTime, time)

	if index ~= -1 then
		local groupID = self:GetCfgData().MonsterGroup[index]

		if groupID then
			return CfgSurvivalChallengeMonsterGroupTable[groupID].Monster
		end
	end

	return {}
end

return m
