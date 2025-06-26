-- chunkname: @IQIGame\\UIExternalApi\\CookingUIApi.lua

CookingUIApi = BaseLangApi:Extend()

function CookingUIApi:Init()
	self:RegisterApi("TextTitle2", self.GetTextTitle2)
	self:RegisterApi("ErrorMsg1", self.GetErrorMsg1)
	self:RegisterApi("ErrorMsg2", self.GetErrorMsg2)
	self:RegisterApi("ErrorMsg3", self.GetErrorMsg3)
end

function CookingUIApi:GetErrorMsg3()
	return self:GetCfgText(1238007)
end

function CookingUIApi:GetErrorMsg2()
	return self:GetCfgText(1238012)
end

function CookingUIApi:GetErrorMsg1()
	return self:GetCfgText(1238013)
end

function CookingUIApi:GetTextTitle2()
	return self:GetCfgText(1238015)
end

CookingUIApi:Init()
