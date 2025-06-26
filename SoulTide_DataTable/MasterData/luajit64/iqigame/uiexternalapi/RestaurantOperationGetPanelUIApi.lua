-- chunkname: @IQIGame\\UIExternalApi\\RestaurantOperationGetPanelUIApi.lua

RestaurantOperationGetPanelUIApi = BaseLangApi:Extend()

function RestaurantOperationGetPanelUIApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("goBtnTxt", self.GetBtnTxt)
	self:RegisterApi("ItemNameText", self.GetItemNameText)
	self:RegisterApi("TextEng", self.GetTextEng)
end

function RestaurantOperationGetPanelUIApi:GetTextEng()
	return self:GetCfgText(2700001)
end

function RestaurantOperationGetPanelUIApi:GetTextTitle()
	return self:GetCfgText(19)
end

function RestaurantOperationGetPanelUIApi:GetBtnTxt()
	return self:GetCfgText(79)
end

function RestaurantOperationGetPanelUIApi:GetItemNameText(text)
	return text
end

RestaurantOperationGetPanelUIApi:Init()
