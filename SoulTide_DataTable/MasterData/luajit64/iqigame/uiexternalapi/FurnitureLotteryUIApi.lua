-- chunkname: @IQIGame\\UIExternalApi\\FurnitureLotteryUIApi.lua

FurnitureLotteryUIApi = BaseLangApi:Extend()

function FurnitureLotteryUIApi:Init()
	self:RegisterApi("TextBtnList", self.SetTextBtnList)
	self:RegisterApi("TextTip1", self.SetTextTip1)
	self:RegisterApi("TextTip2", self.SetTextTip2)
	self:RegisterApi("TextBtn", self.SetTextBtn)
	self:RegisterApi("TextBtnMoney1", self.SetTextBtnMoney1)
	self:RegisterApi("TextBtnMoney2", self.SetTextBtnMoney2)
	self:RegisterApi("TextStar", self.SetTextStar)
	self:RegisterApi("TextInfo", self.SetTextInfo)
	self:RegisterApi("TextDes", self.SetTextTextDes)
	self:RegisterApi("TextCome", self.SetTextCome)
	self:RegisterApi("TextNum", self.SetTextNum)
	self:RegisterApi("TextSure", self.SetTextSure)
	self:RegisterApi("TextReward", self.SetTextReward)
	self:RegisterApi("TextBtnShow", self.SetTextBtnShow)
end

function FurnitureLotteryUIApi:SetTextBtnShow()
	return self:GetCfgText(1102000)
end

function FurnitureLotteryUIApi:SetTextReward(str)
	return self:GetCfgText(1102001) .. str .. self:GetCfgText(1102002)
end

function FurnitureLotteryUIApi:SetTextSure()
	return self:GetCfgText(1102000)
end

function FurnitureLotteryUIApi:SetTextNum(num1, num2)
	return self:GetCfgText(1102004) .. num1 .. "/" .. num2
end

function FurnitureLotteryUIApi:SetTextTextDes()
	return self:GetCfgText(1102005)
end

function FurnitureLotteryUIApi:SetTextCome()
	return self:GetCfgText(1102006)
end

function FurnitureLotteryUIApi:SetTextInfo()
	return self:GetCfgText(1102007)
end

function FurnitureLotteryUIApi:SetTextStar()
	return self:GetCfgText(1102008)
end

function FurnitureLotteryUIApi:SetTextBtnList()
	return self:GetCfgText(1102009)
end

function FurnitureLotteryUIApi:SetTextTip1()
	return self:GetCfgText(1102010)
end

function FurnitureLotteryUIApi:SetTextTip2()
	return self:GetCfgText(1102011)
end

function FurnitureLotteryUIApi:SetTextBtn()
	return self:GetCfgText(1102012)
end

function FurnitureLotteryUIApi:SetTextBtnMoney1()
	return self:GetCfgText(1102013)
end

function FurnitureLotteryUIApi:SetTextBtnMoney2()
	return self:GetCfgText(1102014)
end

FurnitureLotteryUIApi:Init()
