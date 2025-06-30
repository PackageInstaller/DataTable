-- chunkname: @IQIGame\\UIExternalApi\\AchievementApi.lua

AchievementApi = BaseLangApi:Extend()

function AchievementApi:TextAll()
	return self:GetCfgText(9050005)
end

function AchievementApi:TextHas()
	return self:GetCfgText(9050006)
end

function AchievementApi:TextNotHas()
	return self:GetCfgText(9050007)
end

function AchievementApi:TextBigIcon()
	return self:GetCfgText(9050008)
end

function AchievementApi:TextMiddleIcon()
	return self:GetCfgText(9050009)
end

function AchievementApi:TextSmallIcon()
	return self:GetCfgText(9050010)
end

function AchievementApi:TextChangedReturnTip()
	return self:GetCfgText(9050010)
end

function AchievementApi:TextHadGotReward()
	return self:GetCfgText(9050021)
end

function AchievementApi:TextAchieveAllCanGetReward()
	return self:GetCfgText(9050022)
end
