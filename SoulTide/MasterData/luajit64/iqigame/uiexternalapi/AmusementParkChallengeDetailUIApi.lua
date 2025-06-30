-- chunkname: @IQIGame\\UIExternalApi\\AmusementParkChallengeDetailUIApi.lua

AmusementParkChallengeDetailUIApi = BaseLangApi:Extend()

function AmusementParkChallengeDetailUIApi:Init()
	self:RegisterApi("RecommendPowerText", self.GetRecommendPowerText)
	self:RegisterApi("TextPower", self.GetTextPower)
	self:RegisterApi("TextBossLevel", self.GetTextBossLevel)
end

function AmusementParkChallengeDetailUIApi:GetTextBossLevel(boosLv)
	if boosLv == 1 then
		return self:GetCfgText(1213091)
	elseif boosLv == 2 then
		return self:GetCfgText(1213092)
	elseif boosLv == 3 then
		return self:GetCfgText(1213093)
	elseif boosLv == 4 then
		return self:GetCfgText(1213094)
	elseif boosLv == 5 then
		return self:GetCfgText(1213095)
	elseif boosLv == 6 then
		return self:GetCfgText(1213096)
	elseif boosLv == 7 then
		return self:GetCfgText(1213097)
	elseif boosLv == 8 then
		return self:GetCfgText(1213098)
	elseif boosLv == 9 then
		return self:GetCfgText(1213099)
	elseif boosLv == 10 then
		return self:GetCfgText(1213100)
	end

	return ""
end

function AmusementParkChallengeDetailUIApi:GetTextPower(power, needPower)
	local rate = needPower / power

	if rate >= 1.25 then
		return self.TextColor[203] .. power .. self.TextColor[0]
	elseif rate >= 1.05 then
		return self.TextColor[218] .. power .. self.TextColor[0]
	elseif rate >= 0.95 then
		return self.TextColor[206] .. power .. self.TextColor[0]
	elseif rate >= 0.75 then
		return self.TextColor[201] .. power .. self.TextColor[0]
	else
		return self.TextColor[219] .. power .. self.TextColor[0]
	end
end

function AmusementParkChallengeDetailUIApi:GetRecommendPowerText(recommendPower)
	return string.format(self:GetCfgText(2100005) .. "：%s", recommendPower)
end

AmusementParkChallengeDetailUIApi:Init()
