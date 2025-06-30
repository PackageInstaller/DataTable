-- chunkname: @IQIGame\\UIExternalApi\\BuyMallPanelUIApi.lua

BuyMallPanelUIApi = BaseLangApi:Extend()

function BuyMallPanelUIApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextBtnCancel", self.GetTextBtnCancel)
	self:RegisterApi("TextBtnTitle", self.GetTextBtnTitle)
	self:RegisterApi("TextBtnMin", self.GetTextBtnMin)
	self:RegisterApi("TextBtnMax", self.GetTextBtnMax)
	self:RegisterApi("TextMsg", self.GetTextMsg)
	self:RegisterApi("TextBuyCount", self.GetBuyCount)
end

function BuyMallPanelUIApi:GetBuyCount(buyNum, haveNum)
	if haveNum < buyNum then
		return self.TextColor[41] .. buyNum .. self.TextColor[0]
	end

	return buyNum
end

function BuyMallPanelUIApi:GetTextMsg(name1, num1, name2, num2, haveNum)
	if haveNum < num1 then
		return self:GetCfgText(1140101) .. "x" .. self.TextColor[28] .. haveNum .. self.TextColor[0] .. "\n" .. self:GetCfgText(1140102) .. "【" .. name1 .. "】x" .. num1 .. self:GetCfgText(1140103) .. "  【" .. name2 .. "】x" .. num2
	else
		return string.format(self:GetCfgText(1140104), haveNum, name1, num1, name2, num2)
	end
end

function BuyMallPanelUIApi:GetTextBtnMax()
	return self:GetCfgText(1140105)
end

function BuyMallPanelUIApi:GetTextBtnMin()
	return self:GetCfgText(1140106)
end

function BuyMallPanelUIApi:GetTextBtnCancel()
	return self:GetCfgText(1111011)
end

function BuyMallPanelUIApi:GetTextBtnTitle()
	return self:GetCfgText(1109006)
end

function BuyMallPanelUIApi:GetTextTitle()
	return self:GetCfgText(1109052)
end

BuyMallPanelUIApi:Init()
