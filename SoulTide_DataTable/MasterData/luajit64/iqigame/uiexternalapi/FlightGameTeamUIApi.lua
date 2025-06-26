-- chunkname: @IQIGame\\UIExternalApi\\FlightGameTeamUIApi.lua

FlightGameTeamUIApi = BaseLangApi:Extend()

function FlightGameTeamUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
end

function FlightGameTeamUIApi:GetTitleText()
	return self:GetCfgText(3300521)
end

FlightGameTeamUIApi:Init()
