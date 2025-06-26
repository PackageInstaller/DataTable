-- chunkname: @IQIGame\\UIExternalApi\\MonsterAcademyMessageUIApi.lua

MonsterAcademyMessageUIApi = BaseLangApi:Extend()

function MonsterAcademyMessageUIApi:Init()
	self:RegisterApi("TextGameTime", self.GetTextGameTime)
	self:RegisterApi("TextDayOfPhase", self.GetTextDayOfPhase)
	self:RegisterApi("BtnBackLabel", self.GetBtnBackLabel)
	self:RegisterApi("BtnGossipLabel", self.GetBtnGossipLabel)
	self:RegisterApi("BtnAmusingLabel", self.GetBtnAmusingLabel)
	self:RegisterApi("BtnInvitationLabel", self.GetBtnInvitationLabel)
	self:RegisterApi("TextCount", self.GetTextCount)
	self:RegisterApi("TextPlayerSendMsg", self.GetTextPlayerSendMsg)
end

function MonsterAcademyMessageUIApi:GetTextPlayerSendMsg(count)
	return self:GetCfgText(3420121)
end

function MonsterAcademyMessageUIApi:GetTextCount(count)
	return string.format(self:GetCfgText(3420122), count)
end

function MonsterAcademyMessageUIApi:GetBtnInvitationLabel()
	return self:GetCfgText(3420123)
end

function MonsterAcademyMessageUIApi:GetBtnAmusingLabel()
	return self:GetCfgText(3420124)
end

function MonsterAcademyMessageUIApi:GetBtnGossipLabel()
	return self:GetCfgText(3420125)
end

function MonsterAcademyMessageUIApi:GetBtnBackLabel()
	return self:GetCfgText(3420126)
end

function MonsterAcademyMessageUIApi:GetTextGameTime(Y, M, D, dayOfPhase)
	return string.format(self:GetCfgText(3420127), Y, M, D, dayOfPhase)
end

function MonsterAcademyMessageUIApi:GetTextDayOfPhase(state)
	if state == 1 then
		return self:GetCfgText(3420002)
	elseif state == 2 then
		return self:GetCfgText(3420003)
	elseif state == 3 then
		return self:GetCfgText(3420004)
	elseif state == 4 then
		return self:GetCfgText(3420007)
	end

	return ""
end

MonsterAcademyMessageUIApi:Init()
