-- chunkname: @IQIGame\\UIExternalApi\\OpenFuncTipsUIApi.lua

OpenFuncTipsUIApi = BaseLangApi:Extend()

function OpenFuncTipsUIApi:GetFunctionOpenTitleText()
	return self:GetCfgText(1600061)
end
