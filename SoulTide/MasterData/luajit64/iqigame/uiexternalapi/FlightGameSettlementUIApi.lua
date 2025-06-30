-- chunkname: @IQIGame\\UIExternalApi\\FlightGameSettlementUIApi.lua

FlightGameSettlementUIApi = BaseLangApi:Extend()

function FlightGameSettlementUIApi:Init()
	self:RegisterApi("TextTotalNum", self.GetTextTotalNum)
end

function FlightGameSettlementUIApi:GetTextTotalNum(num)
	return string.format(self:GetCfgText(3300530), num)
end

FlightGameSettlementUIApi:Init()
