-- chunkname: @IQIGame\\UIExternalApi\\MonsterAcademyAchievementUIApi.lua

MonsterAcademyAchievementUIApi = BaseLangApi:Extend()

function MonsterAcademyAchievementUIApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextState", self.GetTextState)
	self:RegisterApi("TextTargetNum", self.GetTextTargetNum)
end

function MonsterAcademyAchievementUIApi:GetTextTargetNum(num)
	return string.format(self:GetCfgText(3420231), num)
end

function MonsterAcademyAchievementUIApi:GetTextState(state)
	if state == 1 then
		return self:GetCfgText(3420232)
	end

	return self:GetCfgText(3420233)
end

function MonsterAcademyAchievementUIApi:GetTextTitle()
	return self:GetCfgText(3420081)
end

MonsterAcademyAchievementUIApi:Init()
