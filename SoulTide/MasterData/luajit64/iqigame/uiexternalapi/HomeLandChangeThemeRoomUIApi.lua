-- chunkname: @IQIGame\\UIExternalApi\\HomeLandChangeThemeRoomUIApi.lua

HomeLandChangeThemeRoomUIApi = BaseLangApi:Extend()

function HomeLandChangeThemeRoomUIApi:Init()
	self:RegisterApi("TextName", self.GetTextName)
	self:RegisterApi("TextDes", self.GetTextDes)
end

function HomeLandChangeThemeRoomUIApi:GetTextDes()
	return self:GetCfgText(1015510)
end

function HomeLandChangeThemeRoomUIApi:GetTextName(isEng)
	if isEng then
		return self:GetCfgText(1015511)
	end

	return self:GetCfgText(1015512)
end

HomeLandChangeThemeRoomUIApi:Init()
