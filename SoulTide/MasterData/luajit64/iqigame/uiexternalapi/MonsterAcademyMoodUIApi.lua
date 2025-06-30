-- chunkname: @IQIGame\\UIExternalApi\\MonsterAcademyMoodUIApi.lua

MonsterAcademyMoodUIApi = BaseLangApi:Extend()

function MonsterAcademyMoodUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("PowerLabel", self.GetPowerLabel)
	self:RegisterApi("BtnPhoneLabel", self.GetBtnPhoneLabel)
	self:RegisterApi("TextRelation", self.GetTextRelation)
	self:RegisterApi("LockNoticeText", self.GetLockNoticeText)
	self:RegisterApi("TextOpen", self.GetTextOpen)
	self:RegisterApi("BtnMessageLabel", self.GetBtnMessageLabel)
end

function MonsterAcademyMoodUIApi:GetBtnMessageLabel()
	return self:GetCfgText(3420203)
end

function MonsterAcademyMoodUIApi:GetTextOpen()
	return self:GetCfgText(3420206)
end

function MonsterAcademyMoodUIApi:GetLockNoticeText()
	return self:GetCfgText(3420201)
end

function MonsterAcademyMoodUIApi:GetTextRelation()
	return self:GetCfgText(3420202)
end

function MonsterAcademyMoodUIApi:GetBtnPhoneLabel()
	return self:GetCfgText(3420204)
end

function MonsterAcademyMoodUIApi:GetPowerLabel()
	return self:GetCfgText(3420205)
end

function MonsterAcademyMoodUIApi:GetTitleText()
	return self:GetCfgText(3420081)
end

MonsterAcademyMoodUIApi:Init()
