-- chunkname: @IQIGame\\UIExternalApi\\DualTeamExploreBossDetailUIApi.lua

DualTeamExploreBossDetailUIApi = BaseLangApi:Extend()

function DualTeamExploreBossDetailUIApi:Init()
	self:RegisterApi("TextChallengeBtn", self.GetTextChallengeBtn)
	self:RegisterApi("TitleName", self.GetTitleName)
	self:RegisterApi("TextPowerNum", self.GetTextPowerNum)
	self:RegisterApi("TextCurrentNum", self.GetTextCurrentNum)
	self:RegisterApi("NoFormations", self.GetNoFormations)
	self:RegisterApi("TextWeakness", self.GetTextWeakness)
end

function DualTeamExploreBossDetailUIApi:GetTextWeakness()
	return self:GetCfgText(3410601)
end

function DualTeamExploreBossDetailUIApi:GetNoFormations()
	return self:GetCfgText(1213047)
end

function DualTeamExploreBossDetailUIApi:GetTextCurrentNum(power, needPower)
	local rate = needPower / power

	if rate >= 1.25 then
		return self.TextColor[203] .. power .. self.TextColor[0]
	elseif rate >= 1.05 then
		return self.TextColor[218] .. power .. self.TextColor[0]
	elseif rate >= 0.95 then
		return self.TextColor[206] .. power .. self.TextColor[0]
	elseif rate >= 0.75 then
		return self.TextColor[201] .. power .. self.TextColor[0]
	else
		return self.TextColor[219] .. power .. self.TextColor[0]
	end
end

function DualTeamExploreBossDetailUIApi:GetTextPowerNum(recommendPower)
	return self:GetCfgText(2100005) .. "：" .. recommendPower
end

function DualTeamExploreBossDetailUIApi:GetTextChallengeBtn()
	return self:GetCfgText(3410602)
end

function DualTeamExploreBossDetailUIApi:GetTitleName()
	return self:GetCfgText(3410603)
end

DualTeamExploreBossDetailUIApi:Init()
