-- chunkname: @IQIGame\\UIExternalApi\\BuySellGiftUIApi.lua

BuySellGiftUIApi = BaseLangApi:Extend()

function BuySellGiftUIApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextBtnMin", self.GetTextBtnMin)
	self:RegisterApi("TextBtnMax", self.GetTextBtnMax)
	self:RegisterApi("TextBtnBuy", self.GetTextBtnBuy)
	self:RegisterApi("TextSpend", self.GetTextSpend)
end

function BuySellGiftUIApi:GetTextSpend(num, ample)
	if ample then
		return num
	end

	return self.TextColor[41] .. num .. self.TextColor[0]
end

function BuySellGiftUIApi:GetTextBtnBuy()
	return self:GetCfgText(3400001)
end

function BuySellGiftUIApi:GetTextBtnMax()
	return self:GetCfgText(3400002)
end

function BuySellGiftUIApi:GetTextBtnMin()
	return self:GetCfgText(3400003)
end

function BuySellGiftUIApi:GetTextTitle()
	return self:GetCfgText(3400001)
end

BuySellGiftUIApi:Init()
