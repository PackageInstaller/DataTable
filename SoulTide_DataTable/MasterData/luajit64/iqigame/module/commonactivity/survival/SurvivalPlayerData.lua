-- chunkname: @IQIGame\\Module\\CommonActivity\\Survival\\SurvivalPlayerData.lua

local m = {
	grade = 1,
	specialEndTime = 0,
	maxLv = 1
}

function m.New(cid, lv)
	local o = Clone(m)

	o:Init(cid, lv)

	return o
end

function m:Init(cid, lv)
	self.cid = cid
	self.grade = lv
	self.maxLv = 1

	for i, v in pairsCfg(CfgSurvivalChallengePlayerLevelTable) do
		if v.Group == SurvivalModule.GlobalCid and v.AttPlayer == self.cid and v.Level > self.maxLv then
			self.maxLv = v.Level
		end
	end
end

function m:GetConfigData()
	return CfgSurvivalChallengePlayerTable[self.cid]
end

function m:GetConfigLevelData(lv)
	for i, v in pairsCfg(CfgSurvivalChallengePlayerLevelTable) do
		if v.Group == SurvivalModule.GlobalCid and v.AttPlayer == self.cid and v.Level == lv then
			return v
		end
	end

	return nil
end

function m:GetChallengePlayerAttr(attrID)
	local cfgData = self:GetConfigLevelData(self.grade)

	for i = 1, #cfgData.AttType do
		if cfgData.AttType[i] == attrID then
			return cfgData.AttValue[i]
		end
	end

	return 0
end

function m:CanBeUpgraded()
	local canUpgrade = false

	if self.grade < self.maxLv then
		canUpgrade = true

		local cfgData = self:GetConfigLevelData(self.grade)

		if cfgData then
			for i = 1, #cfgData.DepleteNum, 2 do
				local itemID = cfgData.DepleteNum[i]
				local needNum = cfgData.DepleteNum[i + 1]
				local num = WarehouseModule.GetItemNumByCfgID(itemID)

				if num < needNum then
					canUpgrade = false

					break
				end
			end
		end
	end

	return canUpgrade
end

function m:GetCfgSpecialData()
	local cfgData = self:GetConfigLevelData(self.grade)

	if cfgData.Features > 0 then
		return CfgSurvivalChallengeFeaturesTable[cfgData.Features]
	end

	return nil
end

function m:RefreshTakeSpecialEffect(isStart)
	local isPass, cfgData = self:IsTakeEffectSpecial()

	if not isPass and cfgData and (PlayerModule.GetServerTime() - self.specialEndTime >= cfgData.Interval or isStart) then
		self.specialEndTime = PlayerModule.GetServerTime() + cfgData.Duration
	end
end

function m:IsTakeEffectSpecial()
	local cfgData = self:GetCfgSpecialData()

	if cfgData and PlayerModule.GetServerTime() - self.specialEndTime < 0 then
		return true, cfgData
	end

	return false, cfgData
end

return m
