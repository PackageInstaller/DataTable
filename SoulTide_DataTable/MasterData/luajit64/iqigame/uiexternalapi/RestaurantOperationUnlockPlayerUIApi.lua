-- chunkname: @IQIGame\\UIExternalApi\\RestaurantOperationUnlockPlayerUIApi.lua

RestaurantOperationUnlockPlayerUIApi = BaseLangApi:Extend()

function RestaurantOperationUnlockPlayerUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("TextTotalAttr", self.GetTextTotalAttr)
	self:RegisterApi("TextDes", self.GetTextDes)
	self:RegisterApi("TextGetAllPlayer", self.GetTextGetAllPlayer)
end

function RestaurantOperationUnlockPlayerUIApi:GetTextGetAllPlayer(count)
	if count >= 39 then
		return self:GetCfgText(3810071)
	end

	return self:GetCfgText(3810072)
end

function RestaurantOperationUnlockPlayerUIApi:GetTextDes(lv, count)
	return string.format(self:GetCfgText(3810073), lv, count)
end

function RestaurantOperationUnlockPlayerUIApi:GetTextTotalAttr(num)
	return string.format(self:GetCfgText(3810074), num)
end

function RestaurantOperationUnlockPlayerUIApi:GetTitleText()
	return self:GetCfgText(3810075)
end

RestaurantOperationUnlockPlayerUIApi:Init()
