-- chunkname: @IQIGame\\UIExternalApi\\DualTeamExploreExBossDetailUIApi.lua

DualTeamExploreExBossDetailUIApi = BaseLangApi:Extend()

function DualTeamExploreExBossDetailUIApi:Init()
	self:RegisterApi("TitleName", self.GetTitleName)
	self:RegisterApi("TextWeakness", self.GetTextWeakness)
	self:RegisterApi("TextChallengeBtn", self.GetTextChallengeBtn)
	self:RegisterApi("TextPowerNum", self.GetTextPowerNum)
	self:RegisterApi("TextCurrentNum", self.GetTextCurrentNum)
	self:RegisterApi("NoFormations", self.GetNoFormations)
	self:RegisterApi("TextTimeCD", self.GetTextTimeCD)
	self:RegisterApi("TagText", self.GetTagText)
	self:RegisterApi("OpenEXBoss", self.GetOpenEXBoss)
end

function DualTeamExploreExBossDetailUIApi:GetOpenEXBoss()
	return self:GetCfgText(3410205)
end

function DualTeamExploreExBossDetailUIApi:GetTagText()
	return self:GetCfgText(3506001)
end

function DualTeamExploreExBossDetailUIApi:GetTextTimeCD(str)
	return string.format(self:GetCfgText(1315008) .. "：%s", str)
end

function DualTeamExploreExBossDetailUIApi:GetNoFormations()
	return self:GetCfgText(1213047)
end

function DualTeamExploreExBossDetailUIApi:GetTextWeakness()
	return self:GetCfgText(3410801)
end

function DualTeamExploreExBossDetailUIApi:GetTextChallengeBtn()
	return self:GetCfgText(3410802)
end

function DualTeamExploreExBossDetailUIApi:GetTextCurrentNum(power, needPower)
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

function DualTeamExploreExBossDetailUIApi:GetTextPowerNum(recommendPower)
	return self:GetCfgText(2100005) .. "：" .. recommendPower
end

function DualTeamExploreExBossDetailUIApi:GetTitleName(openCount)
	if openCount == 1 then
		return self:GetCfgText(3410803)
	elseif openCount == 2 then
		return self:GetCfgText(2000072)
	elseif openCount == 3 then
		return self:GetCfgText(3410803)
	end

	return ""
end

DualTeamExploreExBossDetailUIApi:Init()
