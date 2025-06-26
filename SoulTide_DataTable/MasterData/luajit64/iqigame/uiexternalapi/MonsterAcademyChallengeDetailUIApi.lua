-- chunkname: @IQIGame\\UIExternalApi\\MonsterAcademyChallengeDetailUIApi.lua

MonsterAcademyChallengeDetailUIApi = BaseLangApi:Extend()

function MonsterAcademyChallengeDetailUIApi:Init()
	self:RegisterApi("TextLayer", self.GetTextLayer)
	self:RegisterApi("BtnChallengeLabel", self.GetBtnChallengeLabel)
	self:RegisterApi("TextCost", self.GetTextCost)
	self:RegisterApi("TitleAttributes", self.GetTitleAttributes)
	self:RegisterApi("TextCostValue", self.GetTextCostValue)
end

function MonsterAcademyChallengeDetailUIApi:GetTextCostValue(name, value)
	return string.format("%s x%s", name, value)
end

function MonsterAcademyChallengeDetailUIApi:GetTitleAttributes()
	return self:GetCfgText(3420071)
end

function MonsterAcademyChallengeDetailUIApi:GetTextCost()
	return self:GetCfgText(3420072)
end

function MonsterAcademyChallengeDetailUIApi:GetBtnChallengeLabel()
	return self:GetCfgText(3420073)
end

function MonsterAcademyChallengeDetailUIApi:GetTextLayer(index)
	return string.format(self:GetCfgText(3420074), index)
end

MonsterAcademyChallengeDetailUIApi:Init()
