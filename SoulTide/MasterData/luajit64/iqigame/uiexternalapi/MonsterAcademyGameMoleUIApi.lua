-- chunkname: @IQIGame\\UIExternalApi\\MonsterAcademyGameMoleUIApi.lua

MonsterAcademyGameMoleUIApi = BaseLangApi:Extend()

function MonsterAcademyGameMoleUIApi:Init()
	self:RegisterApi("GetTimeCountDownText", self.GetTimeCountDownText)
	self:RegisterApi("GetTargetScoreText", self.GetTargetScoreText)
	self:RegisterApi("GetScoreText", self.GetScoreText)
	self:RegisterApi("GetScoreTitleText", self.GetScoreTitleText)
	self:RegisterApi("GetTimeCountDownTitleText", self.GetTimeCountDownTitleText)
	self:RegisterApi("GetExitButtonText", self.GetExitButtonText)
	self:RegisterApi("GetStartButtonText", self.GetStartButtonText)
	self:RegisterApi("GetCloseButtonText", self.GetCloseButtonText)
end

function MonsterAcademyGameMoleUIApi:GetTimeCountDownText(seconds)
	return tostring(seconds) .. "s"
end

function MonsterAcademyGameMoleUIApi:GetTargetScoreText(score)
	return self:GetCfgText(3420303) .. tostring(score)
end

function MonsterAcademyGameMoleUIApi:GetScoreText(score)
	return tostring(score)
end

function MonsterAcademyGameMoleUIApi:GetScoreTitleText()
	return self:GetCfgText(3420306)
end

function MonsterAcademyGameMoleUIApi:GetTimeCountDownTitleText()
	return self:GetCfgText(3420302)
end

function MonsterAcademyGameMoleUIApi:GetExitButtonText()
	return self:GetCfgText(3420307)
end

function MonsterAcademyGameMoleUIApi:GetStartButtonText()
	return self:GetCfgText(3420308)
end

function MonsterAcademyGameMoleUIApi:GetCloseButtonText()
	return self:GetCfgText(3420309)
end

MonsterAcademyGameMoleUIApi:Init()
