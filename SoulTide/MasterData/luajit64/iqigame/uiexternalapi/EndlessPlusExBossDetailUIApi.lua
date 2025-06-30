-- chunkname: @IQIGame\\UIExternalApi\\EndlessPlusExBossDetailUIApi.lua

EndlessPlusExBossDetailUIApi = BaseLangApi:Extend()

function EndlessPlusExBossDetailUIApi:Init()
	self:RegisterApi("RecommendPowerText", self.GetRecommendPowerText)
	self:RegisterApi("TextPower", self.GetTextPower)
	self:RegisterApi("TextNotice3", self.GetTextNotice3)
	self:RegisterApi("RankingLabels", self.GetRankingLabels)
	self:RegisterApi("NoneRankText", self.GetNoneRankText)
	self:RegisterApi("ChallengeRankStr", self.GetChallengeRankStr)
	self:RegisterApi("ChallengeRankHurt", self.GetChallengeRankHurt)
	self:RegisterApi("MazeBossRankIconPath", self.GetMazeBossRankIconPath)
	self:RegisterApi("BtnRuneLabel", self.GetBtnRuneLabel)
	self:RegisterApi("SuitItemBg", self.GetSuitItemBg)
	self:RegisterApi("SuitItemText", self.GetSuitItemText)
	self:RegisterApi("RuneTitle", self.GetRuneTitle)
	self:RegisterApi("TextRuneNull", self.GetTextRuneNull)
	self:RegisterApi("TextMaxRunes", self.GetTextMaxRunes)
end

function EndlessPlusExBossDetailUIApi:GetTextMaxRunes()
	return self:GetCfgText(3410951)
end

function EndlessPlusExBossDetailUIApi:GetTextRuneNull()
	return self:GetCfgText(3410952)
end

function EndlessPlusExBossDetailUIApi:GetRuneTitle()
	return self:GetCfgText(3410953)
end

function EndlessPlusExBossDetailUIApi:GetSuitItemText(nameStr, quality)
	if quality == 1 then
		return nameStr
	elseif quality == 2 then
		return nameStr
	elseif quality == 3 then
		return nameStr
	elseif quality == 4 then
		return nameStr
	elseif quality == 5 then
		return nameStr
	end

	return nameStr
end

function EndlessPlusExBossDetailUIApi:GetSuitItemBg(quality)
	if quality == 1 then
		return self:GetResUrl(4800001)
	elseif quality == 2 then
		return self:GetResUrl(4800002)
	elseif quality == 3 then
		return self:GetResUrl(4800003)
	elseif quality == 4 then
		return self:GetResUrl(4800003)
	elseif quality == 5 then
		return self:GetResUrl(4800003)
	end

	return self:GetResUrl(4800001)
end

function EndlessPlusExBossDetailUIApi:GetBtnRuneLabel()
	return self:GetCfgText(3410954)
end

function EndlessPlusExBossDetailUIApi:GetMazeBossRankIconPath(rank, mySelf, type)
	if type == 1 then
		if rank < 11 then
			return self:GetResUrl(2700101)
		elseif rank < 51 then
			return self:GetResUrl(2700101)
		elseif rank < 101 then
			return self:GetResUrl(2700102)
		elseif rank < 501 then
			return self:GetResUrl(2700103)
		elseif rank <= 1000 then
			return self:GetResUrl(2700104)
		end
	elseif type == 2 then
		if rank < 11 then
			return self:GetResUrl(2700105)
		elseif rank < 21 then
			return self:GetResUrl(2700106)
		elseif rank < 31 then
			return self:GetResUrl(2700107)
		elseif rank < 41 then
			return self:GetResUrl(2700108)
		elseif rank < 61 then
			return self:GetResUrl(2700109)
		elseif rank < 81 then
			return self:GetResUrl(2700110)
		elseif rank <= 100 then
			return self:GetResUrl(2700111)
		end
	else
		return ""
	end
end

function EndlessPlusExBossDetailUIApi:GetChallengeRankHurt(hurt, mySelf)
	local str = hurt

	if mySelf then
		return self.TextColor[31] .. str .. self.TextColor[0]
	else
		return str
	end
end

function EndlessPlusExBossDetailUIApi:GetChallengeRankStr(rank, mySelf, type)
	local str = ""

	if type == 0 then
		str = "--"
	elseif type == 2 then
		str = ""
	elseif type == 1 and rank > 3 then
		str = rank
	end

	if mySelf then
		return self.TextColor[31] .. str .. self.TextColor[0]
	else
		return str
	end
end

function EndlessPlusExBossDetailUIApi:GetNoneRankText()
	return self:GetCfgText(1213068)
end

function EndlessPlusExBossDetailUIApi:GetRankingLabels()
	return {
		self:GetCfgText(1213073),
		self:GetCfgText(1213074),
		self:GetCfgText(1213075)
	}
end

function EndlessPlusExBossDetailUIApi:GetTextNotice3()
	return self:GetCfgText(1213047)
end

function EndlessPlusExBossDetailUIApi:GetRecommendPowerText(recommendPower)
	return self:GetCfgText(2100005) .. "：" .. recommendPower
end

function EndlessPlusExBossDetailUIApi:GetTextPower(power, needPower)
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

EndlessPlusExBossDetailUIApi:Init()
