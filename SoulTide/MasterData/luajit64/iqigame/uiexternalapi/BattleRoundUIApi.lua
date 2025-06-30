-- chunkname: @IQIGame\\UIExternalApi\\BattleRoundUIApi.lua

BattleRoundUIApi = BaseLangApi:Extend()

function BattleRoundUIApi:Init()
	self:RegisterApi("RushModeLabelPart1", self.GetRushModeLabelPart1)
	self:RegisterApi("RushModeLabelPart2", self.GetRushModeLabelPart2)
	self:RegisterApi("RushModeDescText", self.GetRushModeDescText)
end

function BattleRoundUIApi:GetRushModeLabelPart1()
	return self:GetCfgText(1107011)
end

function BattleRoundUIApi:GetRushModeLabelPart2()
	return self:GetCfgText(1150033)
end

function BattleRoundUIApi:GetRushModeDescText()
	return ""
end

BattleRoundUIApi:Init()
