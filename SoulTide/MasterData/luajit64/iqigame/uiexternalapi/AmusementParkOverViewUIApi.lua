-- chunkname: @IQIGame\\UIExternalApi\\AmusementParkOverViewUIApi.lua

AmusementParkOverViewUIApi = BaseLangApi:Extend()

function AmusementParkOverViewUIApi:Init()
	self:RegisterApi("TextSort", self.GetTextSort)
	self:RegisterApi("TextLv", self.GetTextLv)
	self:RegisterApi("NotParticipating", self.GetNotParticipating)
end

function AmusementParkOverViewUIApi:GetNotParticipating()
	return self:GetCfgText(3830070)
end

function AmusementParkOverViewUIApi:GetTextLv(lv, maxLv)
	return string.format(self:GetCfgText(3830071), lv)
end

function AmusementParkOverViewUIApi:GetTextSort(num)
	return string.format(self:GetCfgText(3830072), num)
end

AmusementParkOverViewUIApi:Init()
