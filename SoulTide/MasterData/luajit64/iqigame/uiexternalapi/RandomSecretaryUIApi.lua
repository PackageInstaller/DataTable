-- chunkname: @IQIGame\\UIExternalApi\\RandomSecretaryUIApi.lua

RandomSecretaryUIApi = BaseLangApi:Extend()

function RandomSecretaryUIApi:Init()
	self:RegisterApi("TextSelect", self.GetTextSelect)
end

function RandomSecretaryUIApi:GetTextSelect(num)
	return string.format(self:GetCfgText(9101701), num)
end

RandomSecretaryUIApi:Init()
