-- chunkname: @IQIGame\\UIExternalApi\\PlaceGameChallengeDetailUIApi.lua

PlaceGameChallengeDetailUIApi = BaseLangApi:Extend()

function PlaceGameChallengeDetailUIApi:Init()
	self:RegisterApi("ChangeFormationBtnText", self.GetChangeFormationBtnText)
	self:RegisterApi("MoodTipViewText", self.GetMoodTipViewText)
	self:RegisterApi("DefaultFormationName", self.GetDefaultFormationName)
	self:RegisterApi("TextPower", self.GetTextPower)
end

function PlaceGameChallengeDetailUIApi:GetTextPower(num)
	return string.format(self:GetCfgText(3820007), num)
end

function PlaceGameChallengeDetailUIApi:GetDefaultFormationName(index, name)
	if name ~= nil and name ~= "" then
		return name
	end

	return self:GetCfgText(1214051) .. index
end

function PlaceGameChallengeDetailUIApi:GetMoodTipViewText()
	return self:GetCfgText(2300007)
end

function PlaceGameChallengeDetailUIApi:GetChangeFormationBtnText()
	return self:GetCfgText(2300011)
end

PlaceGameChallengeDetailUIApi:Init()
