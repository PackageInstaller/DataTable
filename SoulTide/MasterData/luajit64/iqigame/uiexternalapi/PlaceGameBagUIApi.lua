-- chunkname: @IQIGame\\UIExternalApi\\PlaceGameBagUIApi.lua

PlaceGameBagUIApi = BaseLangApi:Extend()

function PlaceGameBagUIApi:Init()
	self:RegisterApi("ExchangeCondition", self.GetExchangeCondition)
	self:RegisterApi("TextItemNum", self.GetTextItemNum)
end

function PlaceGameBagUIApi:GetTextItemNum(num, maxNum)
	if maxNum <= num then
		return string.format("%s/%s", num, maxNum)
	end

	return string.format("%s/%s", num, maxNum)
end

function PlaceGameBagUIApi:GetExchangeCondition(lv)
	return string.format(self:GetCfgText(3820006), lv)
end

PlaceGameBagUIApi:Init()
