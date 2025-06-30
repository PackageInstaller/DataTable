-- chunkname: @IQIGame\\UIExternalApi\\RestaurantGameCardUIApi.lua

RestaurantGameCardUIApi = BaseLangApi:Extend()

function RestaurantGameCardUIApi:Init()
	self:RegisterApi("TextRankIndex", self.GetTextRankIndex)
end

function RestaurantGameCardUIApi:GetTextRankIndex(index)
	if index == -1 then
		return self:GetCfgText(3810066)
	end

	return index
end

RestaurantGameCardUIApi:Init()
