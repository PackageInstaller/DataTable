-- chunkname: @IQIGame\\UIExternalApi\\MonsterAcademyCallPhoneUIApi.lua

MonsterAcademyCallPhoneUIApi = BaseLangApi:Extend()

function MonsterAcademyCallPhoneUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("TextDes", self.GetTextDes)
	self:RegisterApi("BtnHangUpLabel", self.GetBtnHangUpLabel)
	self:RegisterApi("BtnAnswerLabel", self.GetBtnAnswerLabel)
end

function MonsterAcademyCallPhoneUIApi:GetBtnAnswerLabel()
	return self:GetCfgText(3420321)
end

function MonsterAcademyCallPhoneUIApi:GetBtnHangUpLabel()
	return self:GetCfgText(3420322)
end

function MonsterAcademyCallPhoneUIApi:GetTextDes()
	return self:GetCfgText(3420323)
end

function MonsterAcademyCallPhoneUIApi:GetTitleText()
	return self:GetCfgText(3420324)
end

MonsterAcademyCallPhoneUIApi:Init()
