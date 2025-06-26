-- chunkname: @IQIGame\\UIExternalApi\\BattleSettlementUIApi.lua

BattleSettlementUIApi = BaseLangApi:Extend()

function BattleSettlementUIApi:Init()
	self:RegisterApi("DeadText", self.GetDeadText)
	self:RegisterApi("RecordBarPercent", self.GetRecordBarPercent)
	self:RegisterApi("RecordPercentText", self.GetRecordPercentText)
	self:RegisterApi("RecordValueText", self.GetRecordValueText)
	self:RegisterApi("RecordTweenDuration", self.GetRecordTweenDuration)
end

function BattleSettlementUIApi:GetDeadText()
	return self:GetCfgText(1229042)
end

function BattleSettlementUIApi:GetRecordBarPercent(value, maxValue, totalValue)
	local percent

	percent = maxValue == 0 and 0 or value / maxValue

	return percent
end

function BattleSettlementUIApi:GetRecordPercentText(value, maxValue, totalValue)
	local percent

	percent = totalValue == 0 and 0 or value / totalValue

	return math.round(percent * 10000) / 100 .. "%"
end

function BattleSettlementUIApi:GetRecordValueText(value)
	return tostring(math.ceil(value))
end

function BattleSettlementUIApi:GetRecordTweenDuration()
	return 1
end

BattleSettlementUIApi:Init()
