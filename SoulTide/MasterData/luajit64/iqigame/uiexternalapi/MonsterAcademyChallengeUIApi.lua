-- chunkname: @IQIGame\\UIExternalApi\\MonsterAcademyChallengeUIApi.lua

MonsterAcademyChallengeUIApi = BaseLangApi:Extend()

function MonsterAcademyChallengeUIApi:Init()
	self:RegisterApi("TextLayer", self.GetTextLayer)
	self:RegisterApi("BtnExploreLabel", self.GetBtnExploreLabel)
	self:RegisterApi("TitleText", self.GetTitleText)
end

function MonsterAcademyChallengeUIApi:GetTextLayer(index)
	return string.format(self:GetCfgText(3420074), index)
end

function MonsterAcademyChallengeUIApi:GetBtnExploreLabel()
	return self:GetCfgText(3420080)
end

function MonsterAcademyChallengeUIApi:GetTitleText()
	return self:GetCfgText(3420081)
end

MonsterAcademyChallengeUIApi:Init()
