-- chunkname: @IQIGame\\UIExternalApi\\MonsterAcademyAchievementTipUIApi.lua

MonsterAcademyAchievementTipUIApi = BaseLangApi:Extend()

function MonsterAcademyAchievementTipUIApi:Init()
	self:RegisterApi("goTitle", self.GetTitle)
end

function MonsterAcademyAchievementTipUIApi:GetTitle()
	return self:GetCfgText(3420221)
end

MonsterAcademyAchievementTipUIApi:Init()
