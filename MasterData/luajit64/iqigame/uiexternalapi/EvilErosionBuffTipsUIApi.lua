-- chunkname: @IQIGame\\UIExternalApi\\EvilErosionBuffTipsUIApi.lua

EvilErosionBuffTipsUIApi = BaseLangApi:Extend()

function EvilErosionBuffTipsUIApi:Init()
	self:RegisterApi("BuffInfoItemPrefab_DescText", self.GetBuffInfoItemPrefab_DescText)
end

function EvilErosionBuffTipsUIApi:GetBuffInfoItemPrefab_DescText(name, desc)
	if name == "" then
		return desc
	else
		return "[" .. name .. "]" .. desc
	end
end

EvilErosionBuffTipsUIApi:Init()
