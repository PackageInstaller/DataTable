-- chunkname: @IQIGame\\UIExternalApi\\ConvertUIApi.lua

ConvertUIApi = BaseLangApi:Extend()

function ConvertUIApi:GetUITitle()
	return self:GetCfgText(8050001)
end

function ConvertUIApi:GetConsumeTitle()
	return self:GetCfgText(6000026)
end

function ConvertUIApi:GetConvertTitle()
	return self:GetCfgText(8050002)
end

function ConvertUIApi:GetCancelBtnTitle()
	return self:GetCfgText(1600038)
end

function ConvertUIApi:GetConvertBtnTitle()
	return self:GetCfgText(1400011)
end

function ConvertUIApi:GetMaxBtnTitle()
	return self:GetCfgText(8050003)
end

function ConvertUIApi:GetMinBtnTitle()
	return self:GetCfgText(8050004)
end
