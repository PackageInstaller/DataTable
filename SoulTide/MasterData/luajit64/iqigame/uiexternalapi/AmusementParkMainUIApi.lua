-- chunkname: @IQIGame\\UIExternalApi\\AmusementParkMainUIApi.lua

AmusementParkMainUIApi = BaseLangApi:Extend()

function AmusementParkMainUIApi:Init()
	self:RegisterApi("TextContent", self.GetTextContent)
	self:RegisterApi("TextValue", self.GetTextValue)
	self:RegisterApi("UnlockNeedBuildLv", self.GetUnlockNeedBuildLv)
end

function AmusementParkMainUIApi:GetUnlockNeedBuildLv(needLv)
	return string.format(self:GetCfgText(3830040), needLv)
end

function AmusementParkMainUIApi:GetTextValue(name, value)
	return string.format(self:GetCfgText(3830041), name, value)
end

function AmusementParkMainUIApi:GetTextContent(value, timStr)
	return string.format("%s/%s", value, timStr)
end

AmusementParkMainUIApi:Init()
