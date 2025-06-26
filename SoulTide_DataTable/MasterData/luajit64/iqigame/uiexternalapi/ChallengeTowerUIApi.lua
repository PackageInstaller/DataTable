-- chunkname: @IQIGame\\UIExternalApi\\ChallengeTowerUIApi.lua

ChallengeTowerUIApi = BaseLangApi:Extend()

function ChallengeTowerUIApi:Init()
	self:RegisterApi("TextShop", self.GetTextShop)
	self:RegisterApi("TextBtnForward", self.GetTextBtnForward)
	self:RegisterApi("TextMaxFloor", self.GetTextMaxFloor)
	self:RegisterApi("TextMonster", self.GetTextMonster)
	self:RegisterApi("TextReward", self.GetTextReward)
	self:RegisterApi("TextTimeCD", self.GetTextTimeCD)
	self:RegisterApi("TextNotOpen", self.GetTextNotOpen)
	self:RegisterApi("NoFormations", self.GetNoFormations)
	self:RegisterApi("GetTimeCD", self.GetTimeCD)
	self:RegisterApi("TextMonsterInfoTip2", self.GetTextMonsterInfoTip2)
	self:RegisterApi("TextMonsterInfoTip3", self.GetTextMonsterInfoTip3)
	self:RegisterApi("TextTips", self.GetTextTips)
end

function ChallengeTowerUIApi:GetTextTips()
	return self:GetCfgText(1213104)
end

function ChallengeTowerUIApi:GetTextMonsterInfoTip3()
	return self:GetCfgText(1213020)
end

function ChallengeTowerUIApi:GetTextMonsterInfoTip2()
	return self:GetCfgText(1213045)
end

function ChallengeTowerUIApi:GetTimeCD()
	return self:GetCfgText(1213046)
end

function ChallengeTowerUIApi:GetNoFormations()
	return self:GetCfgText(1213047)
end

function ChallengeTowerUIApi:GetTextNotOpen()
	return self:GetCfgText(1213048)
end

function ChallengeTowerUIApi:GetTextTimeCD(str)
	return string.format(self:GetCfgText(1315008) .. "：%s", str)
end

function ChallengeTowerUIApi:GetTextReward()
	return self:GetCfgText(1213020)
end

function ChallengeTowerUIApi:GetTextMonster()
	return self:GetCfgText(1213049)
end

function ChallengeTowerUIApi:GetTextMaxFloor()
	return self:GetCfgText(1213006)
end

function ChallengeTowerUIApi:GetTextBtnForward()
	return self:GetCfgText(1213003)
end

function ChallengeTowerUIApi:GetTextShop()
	return self:GetCfgText(1213025)
end

ChallengeTowerUIApi:Init()
