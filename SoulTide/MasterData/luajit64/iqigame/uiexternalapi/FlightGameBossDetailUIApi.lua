-- chunkname: @IQIGame\\UIExternalApi\\FlightGameBossDetailUIApi.lua

FlightGameBossDetailUIApi = BaseLangApi:Extend()

function FlightGameBossDetailUIApi:Init()
	self:RegisterApi("TitleName", self.GetTitleName)
	self:RegisterApi("RuneTitle", self.GetRuneTitle)
	self:RegisterApi("TextMaxRunes", self.GetTextMaxRunes)
	self:RegisterApi("TextChallengeBtn", self.GetTextChallengeBtn)
	self:RegisterApi("TextPowerNum", self.GetTextPowerNum)
	self:RegisterApi("TextCurrentNum", self.GetTextCurrentNum)
	self:RegisterApi("RankingLabels", self.GetRankingLabels)
	self:RegisterApi("NoneRankText", self.GetNoneRankText)
	self:RegisterApi("ChallengeRankStr", self.GetChallengeRankStr)
	self:RegisterApi("ChallengeRankHurt", self.GetChallengeRankHurt)
	self:RegisterApi("BossRankIconPath", self.GetBossRankIconPath)
	self:RegisterApi("PlayerNameText", self.GetPlayerNameText)
end

function FlightGameBossDetailUIApi:GetPlayerNameText(str)
	return self.TextColor[31] .. str .. self.TextColor[0]
end

function FlightGameBossDetailUIApi:GetBossRankIconPath(rank, mySelf, type)
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

function FlightGameBossDetailUIApi:GetChallengeRankHurt(hurt, mySelf)
	local str = hurt

	if mySelf then
		return self.TextColor[31] .. str .. self.TextColor[0]
	else
		return str
	end
end

function FlightGameBossDetailUIApi:GetChallengeRankStr(rank, mySelf, type)
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

function FlightGameBossDetailUIApi:GetNoneRankText()
	return self:GetCfgText(1213068)
end

function FlightGameBossDetailUIApi:GetRankingLabels()
	return {
		self:GetCfgText(1213073),
		self:GetCfgText(1213074),
		self:GetCfgText(1213075)
	}
end

function FlightGameBossDetailUIApi:GetTextCurrentNum(power, needPower)
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

function FlightGameBossDetailUIApi:GetTextPowerNum(recommendPower)
	return self:GetCfgText(2100005) .. "：" .. recommendPower
end

function FlightGameBossDetailUIApi:GetTextChallengeBtn()
	return self:GetCfgText(3100402)
end

function FlightGameBossDetailUIApi:GetTextMaxRunes(number)
	return string.format(self:GetCfgText(3300501), number)
end

function FlightGameBossDetailUIApi:GetRuneTitle(number)
	return string.format("%s", number)
end

function FlightGameBossDetailUIApi:GetTitleName()
	return self:GetCfgText(3300502)
end

FlightGameBossDetailUIApi:Init()
