-- chunkname: @IQIGame\\UIExternalApi\\RestaurantOperationMainUIApi.lua

RestaurantOperationMainUIApi = BaseLangApi:Extend()

function RestaurantOperationMainUIApi:Init()
	self:RegisterApi("TextLv", self.GetTextLv)
	self:RegisterApi("TextContent", self.GetTextContent)
	self:RegisterApi("TextValue", self.GetTextValue)
end

function RestaurantOperationMainUIApi:GetTextValue(name, value)
	return string.format(self:GetCfgText(3810022), name, value)
end

function RestaurantOperationMainUIApi:GetTextContent(name, value, timStr)
	return string.format("%s: %s/%s", name, value, timStr)
end

function RestaurantOperationMainUIApi:GetTextLv()
	return self:GetCfgText(3810021)
end

RestaurantOperationMainUIApi:Init()
