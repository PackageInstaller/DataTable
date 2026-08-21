-- chunkname: @IQIGame\\UIExternalApi\\RestaurantOperationUpdateUIApi.lua

RestaurantOperationUpdateUIApi = BaseLangApi:Extend()

function RestaurantOperationUpdateUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("AddValue", self.GetAddValue)
	self:RegisterApi("TextTotalAttr", self.GetTextTotalAttr)
	self:RegisterApi("TextCost", self.GetTextCost)
end

function RestaurantOperationUpdateUIApi:GetTextCost(needNum, top)
	if top then
		return needNum
	end

	return needNum
end

function RestaurantOperationUpdateUIApi:GetTextTotalAttr(value)
	return string.format(self:GetCfgText(3810011), value)
end

function RestaurantOperationUpdateUIApi:GetAddValue(value)
	return string.format("+%s", value)
end

function RestaurantOperationUpdateUIApi:GetTitleText()
	return self:GetCfgText(3810012)
end

RestaurantOperationUpdateUIApi:Init()
