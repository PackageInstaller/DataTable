-- chunkname: @IQIGame\\UIExternalApi\\HomeLandComfortUIApi.lua

HomeLandComfortUIApi = BaseLangApi:Extend()

function HomeLandComfortUIApi:Init()
	self:RegisterApi("TextName", self.SetTextName)
	self:RegisterApi("TextDes", self.SetTextDes)
	self:RegisterApi("TextTitle1", self.SetTextTitle1)
	self:RegisterApi("TextTitle2", self.SetTextTitle2)
	self:RegisterApi("TextCurrentDes1", self.GetTextCurrentDes1)
end

function HomeLandComfortUIApi:GetTextCurrentDes1(num1)
	return self:GetCfgText(1015550) .. "≥:" .. num1
end

function HomeLandComfortUIApi:SetTextName(isEng)
	if isEng then
		return self:GetCfgText(1015551)
	end

	return self:GetCfgText(1015552)
end

function HomeLandComfortUIApi:SetTextDes()
	return self:GetCfgText(1015553)
end

function HomeLandComfortUIApi:SetTextTitle1()
	return self:GetCfgText(1015554)
end

function HomeLandComfortUIApi:SetTextTitle2()
	return self:GetCfgText(1015555)
end

HomeLandComfortUIApi:Init()
