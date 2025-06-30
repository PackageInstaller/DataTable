-- chunkname: @IQIGame\\UIExternalApi\\RestaurantGameSelectLevelUIApi.lua

RestaurantGameSelectLevelUIApi = BaseLangApi:Extend()

function RestaurantGameSelectLevelUIApi:Init()
	self:RegisterApi("TextValue", self.GetTextValue)
end

function RestaurantGameSelectLevelUIApi:GetTextValue(num)
	return string.format(self:GetCfgText(3810068), num)
end

RestaurantGameSelectLevelUIApi:Init()
