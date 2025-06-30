-- chunkname: @IQIGame\\UIExternalApi\\FlightGameUpTipUIApi.lua

FlightGameUpTipUIApi = BaseLangApi:Extend()

function FlightGameUpTipUIApi:Init()
	self:RegisterApi("AttTitle", self.GetAttTitle)
	self:RegisterApi("AttrName", self.GetAttrName)
end

function FlightGameUpTipUIApi:GetAttrName(str)
	return string.format("%s:", str)
end

function FlightGameUpTipUIApi:GetAttTitle(str)
	return string.format(self:GetCfgText(3300526), str)
end

FlightGameUpTipUIApi:Init()
