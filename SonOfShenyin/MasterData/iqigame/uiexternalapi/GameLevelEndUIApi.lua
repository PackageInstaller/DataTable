-- chunkname: @IQIGame\\UIExternalApi\\GameLevelEndUIApi.lua

GameLevelEndUIApi = BaseLangApi:Extend()

function GameLevelEndUIApi:GetPlayerLvTitle()
	return self:GetCfgText(6060000)
end

function GameLevelEndUIApi:GetIsFriendText()
	return self:GetCfgText(6060001)
end

function GameLevelEndUIApi:GetCancelText()
	return self:GetCfgText(6060002)
end

function GameLevelEndUIApi:GetAppalyFriendText()
	return self:GetCfgText(6060003)
end

function GameLevelEndUIApi:GetAppalyedFriendText()
	return self:GetCfgText(6060004)
end

function GameLevelEndUIApi:GetAddFriendTitle()
	return self:GetCfgText(6060005)
end

function GameLevelEndUIApi:GetReturnTitle()
	return self:GetCfgText(6060006)
end

function GameLevelEndUIApi:GetUpgradeTitles()
	return {
		self:GetCfgText(6060007),
		self:GetCfgText(6060008),
		self:GetCfgText(6060009),
		self:GetCfgText(6060010),
		self:GetCfgText(6060011),
		self:GetCfgText(6060012),
		self:GetCfgText(6060013),
		self:GetCfgText(6060014)
	}
end

function GameLevelEndUIApi:GetDefaultHeroCid()
	return 9001
end

function GameLevelEndUIApi:GetUnitAwardTitle(index)
	return string.format(self:GetCfgText(6060015), index)
end

function GameLevelEndUIApi:GetUnitAwardExpText(exp)
	return string.format("+%s", exp)
end

function GameLevelEndUIApi:GetFailedJumpInfoText()
	return {
		self:GetCfgText(6060007),
		self:GetCfgText(6060009),
		self:GetCfgText(6060011),
		(self:GetCfgText(6060013))
	}
end

function GameLevelEndUIApi:GetJumpInfoFunctionId()
	return {
		10207001,
		10207002,
		10207003,
		10202002
	}
end
