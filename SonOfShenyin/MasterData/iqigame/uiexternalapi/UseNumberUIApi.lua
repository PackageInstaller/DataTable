-- chunkname: @IQIGame\\UIExternalApi\\UseNumberUIApi.lua

UseNumberUIApi = BaseLangApi:Extend()

function UseNumberUIApi:GetDesc(name)
	return name
end

function UseNumberUIApi:GetUseNumDesc(value)
	return self:GetCfgText(120015) .. value
end

function UseNumberUIApi:GetBtnUseTxt()
	return self:GetCfgText(5100003)
end
