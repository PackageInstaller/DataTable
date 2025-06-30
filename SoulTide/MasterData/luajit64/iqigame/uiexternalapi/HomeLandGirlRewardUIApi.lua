-- chunkname: @IQIGame\\UIExternalApi\\HomeLandGirlRewardUIApi.lua

HomeLandGirlRewardUIApi = BaseLangApi:Extend()

function HomeLandGirlRewardUIApi:Init()
	self:RegisterApi("TextDes", self.GetTextDes)
	self:RegisterApi("TextBtnGetReward", self.GetTextBtnGetReward)
end

function HomeLandGirlRewardUIApi:GetTextBtnGetReward()
	return self:GetCfgText(1015039)
end

function HomeLandGirlRewardUIApi:GetTextDes(str1, str2)
	return str1 .. "\n    " .. str2
end

HomeLandGirlRewardUIApi:Init()
