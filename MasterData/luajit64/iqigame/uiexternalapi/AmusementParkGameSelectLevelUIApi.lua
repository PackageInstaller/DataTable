-- chunkname: @IQIGame\\UIExternalApi\\AmusementParkGameSelectLevelUIApi.lua

AmusementParkGameSelectLevelUIApi = BaseLangApi:Extend()

function AmusementParkGameSelectLevelUIApi:Init()
	self:RegisterApi("TextProcess", self.GetTextProcess)
end

function AmusementParkGameSelectLevelUIApi:GetTextProcess(passNum, totalNum)
	return string.format(self:GetCfgText(3830098), passNum, totalNum)
end

AmusementParkGameSelectLevelUIApi:Init()
