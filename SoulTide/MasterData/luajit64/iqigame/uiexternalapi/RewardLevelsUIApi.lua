-- chunkname: @IQIGame\\UIExternalApi\\RewardLevelsUIApi.lua

RewardLevelsUIApi = BaseLangApi:Extend()

function RewardLevelsUIApi:Init()
	self:RegisterApi("goTitle", self.GetGoTitle)
	self:RegisterApi("TextSoul", self.GetTextSoul)
	self:RegisterApi("BtnGetRewardLabel1", self.GetBtnGetRewardLabel1)
	self:RegisterApi("BtnGetRewardLabel2", self.GetBtnGetRewardLabel2)
end

function RewardLevelsUIApi:GetBtnGetRewardLabel2()
	return self:GetCfgText(3900001)
end

function RewardLevelsUIApi:GetBtnGetRewardLabel1()
	return self:GetCfgText(3900002)
end

function RewardLevelsUIApi:GetTextSoul()
	return self:GetCfgText(3900003)
end

function RewardLevelsUIApi:GetGoTitle()
	return self:GetCfgText(3900004)
end

RewardLevelsUIApi:Init()
