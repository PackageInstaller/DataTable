-- chunkname: @IQIGame\\UIExternalApi\\RestaurantGameBlocksUIApi.lua

RestaurantGameBlocksUIApi = BaseLangApi:Extend()

function RestaurantGameBlocksUIApi:Init()
	self:RegisterApi("TextRank", self.GetTextRank)
	self:RegisterApi("Title", self.GetTitle)
end

function RestaurantGameBlocksUIApi:GetTitle()
	return self:GetCfgText(3810065)
end

function RestaurantGameBlocksUIApi:GetTextRank(index)
	if index == -1 then
		return self:GetCfgText(3810066)
	end

	return index
end

RestaurantGameBlocksUIApi:Init()
