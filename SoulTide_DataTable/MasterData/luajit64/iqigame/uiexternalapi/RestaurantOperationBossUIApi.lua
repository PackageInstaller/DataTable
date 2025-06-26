-- chunkname: @IQIGame\\UIExternalApi\\RestaurantOperationBossUIApi.lua

RestaurantOperationBossUIApi = BaseLangApi:Extend()

function RestaurantOperationBossUIApi:Init()
	self:RegisterApi("TextPowerNum", self.GetTextPowerNum)
	self:RegisterApi("TextCurrentNum", self.GetTextCurrentNum)
	self:RegisterApi("ChallengeRankStr", self.GetChallengeRankStr)
	self:RegisterApi("ChallengeRankHurt", self.GetChallengeRankHurt)
	self:RegisterApi("BossRankIconPath", self.GetBossRankIconPath)
	self:RegisterApi("PlayerNameText", self.GetPlayerNameText)
	self:RegisterApi("RankingLabels", self.GetRankingLabels)
	self:RegisterApi("NoneRankText", self.GetNoneRankText)
end

function RestaurantOperationBossUIApi:GetNoneRankText()
	return self:GetCfgText(1213068)
end

function RestaurantOperationBossUIApi:GetRankingLabels()
	return {
		self:GetCfgText(1213073),
		self:GetCfgText(1213074),
		self:GetCfgText(1213075)
	}
end

function RestaurantOperationBossUIApi:GetPlayerNameText(str)
	return self.TextColor[31] .. str .. self.TextColor[0]
end

function RestaurantOperationBossUIApi:GetBossRankIconPath(rank, mySelf, type)
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

function RestaurantOperationBossUIApi:GetChallengeRankHurt(hurt, mySelf)
	local str = hurt

	if mySelf then
		return self.TextColor[31] .. str .. self.TextColor[0]
	else
		return str
	end
end

function RestaurantOperationBossUIApi:GetChallengeRankStr(rank, mySelf, type)
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

function RestaurantOperationBossUIApi:GetTextCurrentNum(power, needPower)
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

function RestaurantOperationBossUIApi:GetTextPowerNum(recommendPower)
	return self:GetCfgText(2100005) .. "：" .. recommendPower
end

RestaurantOperationBossUIApi:Init()
