-- chunkname: @IQIGame\\UIExternalApi\\HomeLandUnlockFieldUIApi.lua

HomeLandUnlockFieldUIApi = BaseLangApi:Extend()

function HomeLandUnlockFieldUIApi:Init()
	self:RegisterApi("TextBtnNoReached", self.GetTextBtnNoReached)
	self:RegisterApi("TextDes", self.GetTextDes)
	self:RegisterApi("TextCondition", self.GetTextCondition)
	self:RegisterApi("TextComfort", self.GetTextComfort)
	self:RegisterApi("TextName", self.GetTextName)
end

function HomeLandUnlockFieldUIApi:GetTextCondition(str, isTop)
	if isTop then
		return self.TextColor[14] .. "<size=34>" .. str .. "</size>" .. self.TextColor[0]
	end

	return self.TextColor[28] .. "<size=34>" .. str .. "</size>" .. self.TextColor[0]
end

function HomeLandUnlockFieldUIApi:GetTextDes()
	return self:GetCfgText(1015361)
end

function HomeLandUnlockFieldUIApi:GetTextComfort()
	return self:GetCfgText(1015362)
end

function HomeLandUnlockFieldUIApi:GetTextBtnNoReached()
	return self:GetCfgText(1015363)
end

function HomeLandUnlockFieldUIApi:GetTextName()
	return self:GetCfgText(1015364)
end

HomeLandUnlockFieldUIApi:Init()
