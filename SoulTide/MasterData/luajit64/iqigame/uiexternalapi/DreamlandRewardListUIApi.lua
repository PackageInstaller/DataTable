-- chunkname: @IQIGame\\UIExternalApi\\DreamlandRewardListUIApi.lua

DreamlandRewardListUIApi = BaseLangApi:Extend()

function DreamlandRewardListUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("RewardProgressText", self.GetRewardProgressText)
end

function DreamlandRewardListUIApi:GetTitleText()
	return self:GetCfgText(3700101)
end

function DreamlandRewardListUIApi:GetRewardProgressText(gotNum, totalNum)
	return string.format("%s/%s", totalNum - gotNum, totalNum)
end

DreamlandRewardListUIApi:Init()
