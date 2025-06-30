-- chunkname: @IQIGame\\UIExternalApi\\CommonHeroScreenViewApi.lua

CommonHeroScreenViewApi = BaseLangApi:Extend()

function CommonHeroScreenViewApi:GetTipsText(tipsId)
	return self:GetCfgText(tipsId)
end
