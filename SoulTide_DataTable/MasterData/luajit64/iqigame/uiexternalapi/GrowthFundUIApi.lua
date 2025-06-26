-- chunkname: @IQIGame\\UIExternalApi\\GrowthFundUIApi.lua

GrowthFundUIApi = BaseLangApi:Extend()

function GrowthFundUIApi:Init()
	self:RegisterApi("TargetViewTipText", self.GetTargetViewTipText)
	self:RegisterApi("RewardViewTreasureNumText", self.GetRewardViewTreasureNumText)
	self:RegisterApi("RewardViewLabel", self.GetRewardViewLabel)
	self:RegisterApi("LockViewTreasureNumText", self.GetLockViewTreasureNumText)
	self:RegisterApi("LockViewLabel", self.GetLockViewLabel)
	self:RegisterApi("ClaimTipDescText", self.GetClaimTipDescText)
	self:RegisterApi("ClaimTipTreasureNumText", self.GetClaimTipTreasureNumText)
	self:RegisterApi("ClaimTipLabel", self.GetClaimTipLabel)
	self:RegisterApi("TaskCellPrefab_RewardNumText", self.GetTaskCellPrefab_RewardNumText)
	self:RegisterApi("TaskCellPrefab_LevelText", self.GetTaskCellPrefab_LevelText)
	self:RegisterApi("GrowthFundMallCid", self.GetGrowthFundMallCid)
end

function GrowthFundUIApi:GetTargetViewTipText(diff)
	if diff <= 0 then
		return self:GetCfgText(8000001)
	else
		return string.format(self:GetCfgText(8000002), diff)
	end
end

function GrowthFundUIApi:GetRewardViewTreasureNumText(num)
	return string.format("x%s", num)
end

function GrowthFundUIApi:GetRewardViewLabel()
	return self:GetCfgText(8000003)
end

function GrowthFundUIApi:GetLockViewTreasureNumText()
	return " "
end

function GrowthFundUIApi:GetLockViewLabel()
	return self:GetCfgText(8000004)
end

function GrowthFundUIApi:GetClaimTipDescText()
	return self:GetCfgText(8000005)
end

function GrowthFundUIApi:GetClaimTipTreasureNumText(num)
	return string.format("x%s", num)
end

function GrowthFundUIApi:GetClaimTipLabel()
	return self:GetCfgText(8000007)
end

function GrowthFundUIApi:GetTaskCellPrefab_RewardNumText()
	return "2000"
end

function GrowthFundUIApi:GetTaskCellPrefab_LevelText()
	return "15"
end

function GrowthFundUIApi:GetSpeedUpUnlockViewText()
	return self:GetCfgText(8000008)
end

function GrowthFundUIApi:GetSpeedUpLockViewText()
	return self:GetCfgText(8000008)
end

function GrowthFundUIApi:GetClaimRewardBtnText()
	return self:GetCfgText(8000009)
end

function GrowthFundUIApi:GetDisabledClaimBtnText()
	return self:GetCfgText(8000009)
end

function GrowthFundUIApi:GetBuyFundBtnText(price)
	return string.format(self:GetCfgText(8000010), price)
end

function GrowthFundUIApi:GetCell_ProcessingViewText()
	return self:GetCfgText(8000011)
end

function GrowthFundUIApi:GetCell_RewardViewText()
	return self:GetCfgText(8000012)
end

function GrowthFundUIApi:GetCell_FinishViewText()
	return self:GetCfgText(8000013)
end

function GrowthFundUIApi:GetNumImage(num)
	local path

	if num == 0 then
		path = self:GetResUrl(4600000)
	elseif num == 1 then
		path = self:GetResUrl(4600001)
	elseif num == 2 then
		path = self:GetResUrl(4600002)
	elseif num == 3 then
		path = self:GetResUrl(4600003)
	elseif num == 4 then
		path = self:GetResUrl(4600004)
	elseif num == 5 then
		path = self:GetResUrl(4600005)
	elseif num == 6 then
		path = self:GetResUrl(4600006)
	elseif num == 7 then
		path = self:GetResUrl(4600007)
	elseif num == 8 then
		path = self:GetResUrl(4600008)
	elseif num == 9 then
		path = self:GetResUrl(4600009)
	end

	return path
end

function GrowthFundUIApi:GetGrowthFundMallCid()
	return 1010501024
end

GrowthFundUIApi:Init()
