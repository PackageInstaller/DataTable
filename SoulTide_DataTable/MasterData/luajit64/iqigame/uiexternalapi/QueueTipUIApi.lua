-- chunkname: @IQIGame\\UIExternalApi\\QueueTipUIApi.lua

QueueTipUIApi = BaseLangApi:Extend()

function QueueTipUIApi:Init()
	self:RegisterApi("hideTime", self.GetHideTime)
	self:RegisterApi("hideSpeed", self.GetHideSpeed)
	self:RegisterApi("shortShowTime", self.GetShortShowTime)
	self:RegisterApi("maxShowTime", self.GetMaxShowTime)
	self:RegisterApi("achievementTitle", self.GetAchievementTitle)
	self:RegisterApi("achievementViewName", self.GetAchievementName)
	self:RegisterApi("unlockFunctionTitle", self.GetUnlockFunctionTitle)
	self:RegisterApi("unlockFunctionIconName", self.GetUnlockFunctionIconName)
	self:RegisterApi("unlockFunctionDesc", self.GetUnlockFunctionDesc)
end

function QueueTipUIApi:GetHideTime()
	return 0.2
end

function QueueTipUIApi:GetHideSpeed()
	return 2
end

function QueueTipUIApi:GetShortShowTime()
	return 1
end

function QueueTipUIApi:GetMaxShowTime()
	return 3
end

function QueueTipUIApi:GetAchievementTitle()
	return self:GetCfgText(1241001)
end

function QueueTipUIApi:GetAchievementName(name)
	return name
end

function QueueTipUIApi:GetUnlockFunctionTitle()
	return self:GetCfgText(1241002)
end

function QueueTipUIApi:GetUnlockFunctionIconName(name)
	return name
end

function QueueTipUIApi:GetUnlockFunctionDesc(desc)
	return desc
end

QueueTipUIApi:Init()
