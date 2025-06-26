-- chunkname: @IQIGame\\UIExternalApi\\CommonItemTipsUIApi.lua

CommonItemTipsUIApi = BaseLangApi:Extend()

function CommonItemTipsUIApi:GetItemName(name, quality)
	return name
end

function CommonItemTipsUIApi:GetQualityBackground(quality)
	return string.format(self:GetResUrl(2100), quality)
end
