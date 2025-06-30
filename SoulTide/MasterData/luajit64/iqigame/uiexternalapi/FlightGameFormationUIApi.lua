-- chunkname: @IQIGame\\UIExternalApi\\FlightGameFormationUIApi.lua

FlightGameFormationUIApi = BaseLangApi:Extend()

function FlightGameFormationUIApi:Init()
	self:RegisterApi("SpendValue", self.GetSpendValue)
end

function FlightGameFormationUIApi:GetSpendValue(value)
	return string.format("x%s", value)
end

FlightGameFormationUIApi:Init()
