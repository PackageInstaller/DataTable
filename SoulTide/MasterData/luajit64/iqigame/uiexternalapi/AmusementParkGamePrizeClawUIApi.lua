-- chunkname: @IQIGame\\UIExternalApi\\AmusementParkGamePrizeClawUIApi.lua

AmusementParkGamePrizeClawUIApi = BaseLangApi:Extend()

function AmusementParkGamePrizeClawUIApi:Init()
	self:RegisterApi("TextLevel", self.GetTextLevel)
	self:RegisterApi("TextMaxScore", self.GetTextMaxScore)
	self:RegisterApi("TextGameLv", self.GetTextGameLv)
	self:RegisterApi("TextGameCount", self.GetTextGameCount)
	self:RegisterApi("TextRankNum", self.GetTextRankNum)
	self:RegisterApi("GameEndRoles", self.GetGameEndRoles)
	self:RegisterApi("GameEndTotalRoles", self.GetGameEndTotalRoles)
	self:RegisterApi("GameEndScore", self.GetGameEndScore)
	self:RegisterApi("GameEndTotalScore", self.GetGameEndTotalScore)
	self:RegisterApi("TextMaxLv", self.GetTextMaxLv)
end

function AmusementParkGamePrizeClawUIApi:GetTextMaxLv(lv)
	if lv == 0 then
		return self:GetCfgText(3830085)
	end

	return string.format(self:GetCfgText(3830092), lv)
end

function AmusementParkGamePrizeClawUIApi:GetGameEndTotalScore(score)
	return score
end

function AmusementParkGamePrizeClawUIApi:GetGameEndScore(score)
	return score
end

function AmusementParkGamePrizeClawUIApi:GetGameEndTotalRoles(count)
	return count
end

function AmusementParkGamePrizeClawUIApi:GetGameEndRoles(count)
	return count
end

function AmusementParkGamePrizeClawUIApi:GetTextRankNum(count)
	if count == nil or count <= 0 then
		return self:GetCfgText(3830093)
	end

	return count
end

function AmusementParkGamePrizeClawUIApi:GetTextGameCount(count)
	return string.format(self:GetCfgText(3830094), count)
end

function AmusementParkGamePrizeClawUIApi:GetTextGameLv(level)
	return string.format(self:GetCfgText(3830095), level)
end

function AmusementParkGamePrizeClawUIApi:GetTextMaxScore(score)
	return score
end

function AmusementParkGamePrizeClawUIApi:GetTextLevel(score)
	return score
end

AmusementParkGamePrizeClawUIApi:Init()
