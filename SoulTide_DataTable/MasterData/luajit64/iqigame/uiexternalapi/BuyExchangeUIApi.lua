-- chunkname: @IQIGame\\UIExternalApi\\BuyExchangeUIApi.lua

BuyExchangeUIApi = BaseLangApi:Extend()

function BuyExchangeUIApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextBtnTitle", self.GetTextBtnTitle)
	self:RegisterApi("TextTimes", self.GetTextTimes)
	self:RegisterApi("ErrorMsg1", self.GetErrorMsg1)
	self:RegisterApi("ErrorMsg2", self.GetErrorMsg2)
	self:RegisterApi("TextDes", self.GetTextDes)
	self:RegisterApi("TextBtnCancel", self.GetTextBtnCancel)
	self:RegisterApi("TextHaveNum", self.GetTextHaveNum)
	self:RegisterApi("TextBtnExchange", self.GetTextBtnExchange)
	self:RegisterApi("GetAddValueStr", self.GetGetAddValueStr)
end

function BuyExchangeUIApi:GetGetAddValueStr(nameStr, addValue)
	return string.format("%s +%s", nameStr, addValue)
end

function BuyExchangeUIApi:GetTextBtnExchange()
	return self:GetCfgText(1109074)
end

function BuyExchangeUIApi:GetTextHaveNum(num)
	return string.format(self:GetCfgText(1109075), num)
end

function BuyExchangeUIApi:GetTextBtnCancel()
	return self:GetCfgText(1111011)
end

function BuyExchangeUIApi:GetTextDes(str1, str2)
	return str1 .. self:GetCfgText(1109053) .. str2
end

function BuyExchangeUIApi:GetErrorMsg2(str)
	return str .. self:GetCfgText(1014010)
end

function BuyExchangeUIApi:GetErrorMsg1()
	return self:GetCfgText(1109050)
end

function BuyExchangeUIApi:GetTextTimes(num, limitNum)
	return self:GetCfgText(1109051) .. num
end

function BuyExchangeUIApi:GetTextBtnTitle()
	return self:GetCfgText(1109006)
end

function BuyExchangeUIApi:GetTextTitle()
	return self:GetCfgText(1109076)
end

BuyExchangeUIApi:Init()
