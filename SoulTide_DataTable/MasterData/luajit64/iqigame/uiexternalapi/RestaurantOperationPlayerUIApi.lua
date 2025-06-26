-- chunkname: @IQIGame\\UIExternalApi\\RestaurantOperationPlayerUIApi.lua

RestaurantOperationPlayerUIApi = BaseLangApi:Extend()

function RestaurantOperationPlayerUIApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextMainAttr", self.GetTextMainAttr)
	self:RegisterApi("TextSelectDes", self.GetTextSelectDes)
	self:RegisterApi("TextSelectValue", self.GetTextSelectValue)
end

function RestaurantOperationPlayerUIApi:GetTextSelectValue(name, value)
	return string.format(self:GetCfgText(3810002), name, value)
end

function RestaurantOperationPlayerUIApi:GetTextSelectDes(name, attrName, value)
	return string.format("%s %s: %s", name, attrName, value)
end

function RestaurantOperationPlayerUIApi:GetTextMainAttr(attrName, value)
	return string.format("%s :           %s", attrName, value)
end

function RestaurantOperationPlayerUIApi:GetTextTitle()
	return self:GetCfgText(3810001)
end

RestaurantOperationPlayerUIApi:Init()
