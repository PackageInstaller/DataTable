-- chunkname: @IQIGame\\UIExternalApi\\MonsterAcademyGameFruitUIApi.lua

MonsterAcademyGameFruitUIApi = BaseLangApi:Extend()

function MonsterAcademyGameFruitUIApi:Init()
	self:RegisterApi("GetTimeCountDownText", self.GetTimeCountDownText)
	self:RegisterApi("GetTargetScoreText", self.GetTargetScoreText)
	self:RegisterApi("GetScoreText", self.GetScoreText)
	self:RegisterApi("GetScoreTitleText", self.GetScoreTitleText)
	self:RegisterApi("GetTimeCountDownTitleText", self.GetTimeCountDownTitleText)
	self:RegisterApi("GetExitButtonText", self.GetExitButtonText)
	self:RegisterApi("GetStartButtonText", self.GetStartButtonText)
	self:RegisterApi("GetCloseButtonText", self.GetCloseButtonText)
end

function MonsterAcademyGameFruitUIApi:GetTimeCountDownText(seconds)
	return tostring(seconds) .. "s"
end

function MonsterAcademyGameFruitUIApi:GetTargetScoreText(score)
	return self:GetCfgText(3420303) .. tostring(score)
end

function MonsterAcademyGameFruitUIApi:GetScoreText(score)
	return tostring(score)
end

function MonsterAcademyGameFruitUIApi:GetScoreTitleText()
	return self:GetCfgText(3420306)
end

function MonsterAcademyGameFruitUIApi:GetTimeCountDownTitleText()
	return self:GetCfgText(3420302)
end

function MonsterAcademyGameFruitUIApi:GetExitButtonText()
	return self:GetCfgText(3420307)
end

function MonsterAcademyGameFruitUIApi:GetStartButtonText()
	return self:GetCfgText(3420308)
end

function MonsterAcademyGameFruitUIApi:GetCloseButtonText()
	return self:GetCfgText(3420309)
end

MonsterAcademyGameFruitUIApi:Init()
