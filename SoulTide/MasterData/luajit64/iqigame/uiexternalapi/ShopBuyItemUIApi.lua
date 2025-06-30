-- chunkname: @IQIGame\\UIExternalApi\\ShopBuyItemUIApi.lua

ShopBuyItemUIApi = BaseLangApi:Extend()

function ShopBuyItemUIApi:Init()
	self:RegisterApi("goViewTitleTxt", self.GetViewTitleTxt)
	self:RegisterApi("ItemNameTxt", self.GetItemNameTxt)
	self:RegisterApi("HaveNumTxt", self.GetHaveNumTxt)
	self:RegisterApi("ItemDescTxt", self.GetItemDescTxt)
	self:RegisterApi("goOldPriceTitleTxt", self.GetOldPriceTitleTxt)
	self:RegisterApi("OldPriceTxt", self.GetOldPriceTxt)
	self:RegisterApi("goNewPriceTitleTxt", self.GetNewPriceTitleTxt)
	self:RegisterApi("NewPriceTxt", self.GetNewPriceTxt)
	self:RegisterApi("goTimeTitleTxt", self.GetTimeTitleTxt)
	self:RegisterApi("CountDownTimeTxt", self.GetCountDownTimeTxt)
	self:RegisterApi("goBtnBuyTxt", self.GetBtnBuyTxt)
	self:RegisterApi("goDiscount", self.GetDiscount)
	self:RegisterApi("goMoneyCost", self.GetMoneyCost)
	self:RegisterApi("goCondition", self.GetCondition)
	self:RegisterApi("goCount", self.GetCount)
end

function ShopBuyItemUIApi:GetCount(count, isOver)
	return "x" .. count
end

function ShopBuyItemUIApi:GetCondition(desc, isOver)
	return desc
end

function ShopBuyItemUIApi:GetDiscount(value, isOver)
	return "-" .. value .. "%"
end

function ShopBuyItemUIApi:GetMoneyCost(value, ownCount, isOver)
	if ownCount < value then
		return self.TextColor[105] .. value .. self.TextColor[0]
	else
		return value
	end
end

function ShopBuyItemUIApi:GetViewTitleTxt()
	return self:GetCfgText(1140009)
end

function ShopBuyItemUIApi:GetItemNameTxt(name, isOver)
	return name
end

function ShopBuyItemUIApi:GetHaveNumTxt(num)
	return self:GetCfgText(1140010) .. num
end

function ShopBuyItemUIApi:GetItemDescTxt(desc)
	return desc
end

function ShopBuyItemUIApi:GetOldPriceTitleTxt()
	return self:GetCfgText(1140011)
end

function ShopBuyItemUIApi:GetOldPriceTxt(price)
	return tostring(price)
end

function ShopBuyItemUIApi:GetNewPriceTitleTxt()
	return self:GetCfgText(1140012)
end

function ShopBuyItemUIApi:GetNewPriceTxt(price, isEnough)
	if isEnough then
		return "A" .. price
	else
		return "A" .. self.TextColor[28] .. price .. self.TextColor[0]
	end
end

function ShopBuyItemUIApi:GetTimeTitleTxt()
	return self:GetCfgText(1140013)
end

function ShopBuyItemUIApi:GetCountDownTimeTxt(countDownTime)
	local ret = ""

	ret = countDownTime == 0 and "00:00:00" or tostring(getTimeDurationText(countDownTime))

	return ret
end

function ShopBuyItemUIApi:GetBtnBuyTxt()
	return self:GetCfgText(1140014)
end

ShopBuyItemUIApi:Init()
