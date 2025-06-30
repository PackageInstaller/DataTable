-- chunkname: @IQIGame\\UIExternalApi\\MonsterAcademyGameJigsawUIApi.lua

MonsterAcademyGameJigsawUIApi = BaseLangApi:Extend()

function MonsterAcademyGameJigsawUIApi:Init()
	self:RegisterApi("GetTimeCountDownText", self.GetTimeCountDownText)
	self:RegisterApi("GetMoveErrorTips", self.GetMoveErrorTips)
	self:RegisterApi("GetTimeCountDownTitleText", self.GetTimeCountDownTitleText)
	self:RegisterApi("GetExitButtonText", self.GetExitButtonText)
	self:RegisterApi("GetStartButtonText", self.GetStartButtonText)
	self:RegisterApi("GetCloseButtonText", self.GetCloseButtonText)
end

function MonsterAcademyGameJigsawUIApi:GetTimeCountDownText(seconds)
	return tostring(seconds) .. "s"
end

function MonsterAcademyGameJigsawUIApi:GetMoveErrorTips()
	return self:GetCfgText(3420301)
end

function MonsterAcademyGameJigsawUIApi:GetTimeCountDownTitleText()
	return self:GetCfgText(3420302)
end

function MonsterAcademyGameJigsawUIApi:GetExitButtonText()
	return self:GetCfgText(3420307)
end

function MonsterAcademyGameJigsawUIApi:GetStartButtonText()
	return self:GetCfgText(3420308)
end

function MonsterAcademyGameJigsawUIApi:GetCloseButtonText()
	return self:GetCfgText(3420309)
end

MonsterAcademyGameJigsawUIApi:Init()
