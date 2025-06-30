-- chunkname: @IQIGame\\UIExternalApi\\HomeLandSoulCheckInUIApi.lua

HomeLandSoulCheckInUIApi = BaseLangApi:Extend()

function HomeLandSoulCheckInUIApi:Init()
	self:RegisterApi("TextName", self.GetTextName)
	self:RegisterApi("TextTitle1", self.GetTextTitle1)
	self:RegisterApi("TextTitle2", self.GetTextTitle2)
	self:RegisterApi("TextTitle3", self.GetTextTitle3)
	self:RegisterApi("ToggleTitle1", self.GetToggleTitle1)
	self:RegisterApi("ToggleTitle2", self.GetToggleTitle2)
	self:RegisterApi("BtnRemoveTitle", self.GetBtnRemoveTitle)
	self:RegisterApi("BtnNullTitle", self.GetBtnNullTitle)
	self:RegisterApi("DefaultTxt", self.GetDefaultTxt)
end

function HomeLandSoulCheckInUIApi:GetDefaultTxt()
	return self:GetCfgText(1015556)
end

function HomeLandSoulCheckInUIApi:GetBtnNullTitle()
	return self:GetCfgText(1015557)
end

function HomeLandSoulCheckInUIApi:GetBtnRemoveTitle()
	return self:GetCfgText(1214302)
end

function HomeLandSoulCheckInUIApi:GetToggleTitle2()
	return self:GetCfgText(2300318)
end

function HomeLandSoulCheckInUIApi:GetToggleTitle1()
	return self:GetCfgText(1015558)
end

function HomeLandSoulCheckInUIApi:GetTextTitle3()
	return self:GetCfgText(1015559)
end

function HomeLandSoulCheckInUIApi:GetTextTitle2()
	return self:GetCfgText(1015560)
end

function HomeLandSoulCheckInUIApi:GetTextTitle1()
	return self:GetCfgText(1015561)
end

function HomeLandSoulCheckInUIApi:GetTextName(isEng)
	if isEng then
		return self:GetCfgText(1015562)
	end

	return self:GetCfgText(1015563)
end

HomeLandSoulCheckInUIApi:Init()
