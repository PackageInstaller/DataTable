-- chunkname: @IQIGame\\UIExternalApi\\HorizontalRPGMazeBossChallengeDetailUIApi.lua

HorizontalRPGMazeBossChallengeDetailUIApi = BaseLangApi:Extend()

function HorizontalRPGMazeBossChallengeDetailUIApi:Init()
	self:RegisterApi("TitleName", self.GetTitleName)
	self:RegisterApi("RankingLabels", self.GetRankingLabels)
	self:RegisterApi("NoneRankText", self.GetNoneRankText)
	self:RegisterApi("ChallengeRankStr", self.GetChallengeRankStr)
	self:RegisterApi("ChallengeRankHurt", self.GetChallengeRankHurt)
	self:RegisterApi("MazeBossRankIconPath", self.GetMazeBossRankIconPath)
	self:RegisterApi("RecommendPowerText", self.GetRecommendPowerText)
	self:RegisterApi("TextPower", self.GetTextPower)
	self:RegisterApi("TextReward", self.GetTextReward)
	self:RegisterApi("TextChallengeBtn", self.GetTextChallengeBtn)
	self:RegisterApi("CostValue", self.GetCostValue)
	self:RegisterApi("BtnShopLabel", self.GetBtnShopLabel)
end

function HorizontalRPGMazeBossChallengeDetailUIApi:GetBtnShopLabel()
	return self:GetCfgText(1213161)
end

function HorizontalRPGMazeBossChallengeDetailUIApi:GetCostValue(num)
	return string.format("x%s", num)
end

function HorizontalRPGMazeBossChallengeDetailUIApi:GetTextChallengeBtn()
	return self:GetCfgText(1213003)
end

function HorizontalRPGMazeBossChallengeDetailUIApi:GetTextReward()
	return self:GetCfgText(1213071)
end

function HorizontalRPGMazeBossChallengeDetailUIApi:GetTextPower(power, needPower)
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

function HorizontalRPGMazeBossChallengeDetailUIApi:GetRecommendPowerText(recommendPower)
	return self:GetCfgText(2100005) .. "：" .. recommendPower
end

function HorizontalRPGMazeBossChallengeDetailUIApi:GetMazeBossRankIconPath(rank, mySelf, type)
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

function HorizontalRPGMazeBossChallengeDetailUIApi:GetChallengeRankHurt(hurt, mySelf)
	local str = hurt

	if mySelf then
		return self.TextColor[222] .. str .. self.TextColor[0]
	else
		return str
	end
end

function HorizontalRPGMazeBossChallengeDetailUIApi:GetChallengeRankStr(rank, mySelf, type)
	local str = ""

	if type == 0 then
		str = "--"
	elseif type == 2 then
		str = ""
	elseif type == 1 and rank > 3 then
		str = rank
	end

	if mySelf then
		return self.TextColor[12] .. str .. self.TextColor[0]
	else
		return str
	end
end

function HorizontalRPGMazeBossChallengeDetailUIApi:GetNoneRankText()
	return self:GetCfgText(1213068)
end

function HorizontalRPGMazeBossChallengeDetailUIApi:GetRankingLabels()
	return {
		self:GetCfgText(1213073),
		self:GetCfgText(1213074),
		self:GetCfgText(1213075)
	}
end

function HorizontalRPGMazeBossChallengeDetailUIApi:GetTitleName()
	return self:GetCfgText(3430003)
end

HorizontalRPGMazeBossChallengeDetailUIApi:Init()
