-- chunkname: @IQIGame\\UIExternalApi\\LunaMazeSettlementUIApi.lua

LunaMazeSettlementUIApi = BaseLangApi:Extend()

function LunaMazeSettlementUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("ScoreLabel", self.GetScoreLabel)
	self:RegisterApi("DangerLabel", self.GetDangerLabel)
	self:RegisterApi("CloseBtnText", self.GetCloseBtnText)
	self:RegisterApi("DangerValue", self.GetDangerValue)
end

function LunaMazeSettlementUIApi:GetTitleText()
	return self:GetCfgText(2200303), self:GetCfgText(2200304)
end

function LunaMazeSettlementUIApi:GetScoreLabel()
	return self:GetCfgText(2200306)
end

function LunaMazeSettlementUIApi:GetDangerLabel()
	return self:GetCfgText(2200018)
end

function LunaMazeSettlementUIApi:GetCloseBtnText()
	return self:GetCfgText(2200305)
end

function LunaMazeSettlementUIApi:GetDangerValue(monsterGrade, endlessPowerCid, chapterType)
	if chapterType == 8 then
		return math.round((monsterGrade * 0.2 + 1) * 10 * (1 + (endlessPowerCid - 1000) * 0.1))
	else
		return math.round((monsterGrade * 0.2 + 1) * 10 * (1 + (endlessPowerCid - 2000) * 0.1))
	end
end

LunaMazeSettlementUIApi:Init()
