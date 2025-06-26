-- chunkname: @IQIGame\\UIExternalApi\\RestaurantGameConnectUIApi.lua

RestaurantGameConnectUIApi = BaseLangApi:Extend()

function RestaurantGameConnectUIApi:Init()
	self:RegisterApi("TextRankIndex", self.GetTextRankIndex)
end

function RestaurantGameConnectUIApi:GetTextRankIndex(index)
	if index == -1 then
		return self:GetCfgText(3810066)
	end

	return index
end

RestaurantGameConnectUIApi:Init()
