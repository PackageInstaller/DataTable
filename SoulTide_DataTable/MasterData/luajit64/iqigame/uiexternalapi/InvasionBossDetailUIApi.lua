-- chunkname: @IQIGame\\UIExternalApi\\InvasionBossDetailUIApi.lua

InvasionBossDetailUIApi = BaseLangApi:Extend()

function InvasionBossDetailUIApi:Init()
	self:RegisterApi("TextMonsterTitle", self.GetTextMonsterTitle)
	self:RegisterApi("TextBtnScore", self.GetTextBtnScore)
	self:RegisterApi("TextChallengeBtn", self.GetTextChallengeBtn)
	self:RegisterApi("TagText", self.GetTagText)
end

function InvasionBossDetailUIApi:GetTagText()
	return self:GetCfgText(3506001)
end

function InvasionBossDetailUIApi:GetTextChallengeBtn()
	return self:GetCfgText(3506003)
end

function InvasionBossDetailUIApi:GetTextBtnScore(currentScore, maxScore)
	return string.format(self:GetCfgText(3506002), currentScore, maxScore)
end

function InvasionBossDetailUIApi:GetTextMonsterTitle()
	return self:GetCfgText(3506004)
end

InvasionBossDetailUIApi:Init()
