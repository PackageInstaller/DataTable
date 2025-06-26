-- chunkname: @IQIGame\\UIExternalApi\\UseGiftUIApi.lua

UseGiftUIApi = BaseLangApi:Extend()

function UseGiftUIApi.GetGiftTitle()
	return BaseLangApi:GetCfgText(1400013)
end
