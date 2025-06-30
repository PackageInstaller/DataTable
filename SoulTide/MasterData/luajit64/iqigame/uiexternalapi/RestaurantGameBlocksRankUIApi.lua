-- chunkname: @IQIGame\\UIExternalApi\\RestaurantGameBlocksRankUIApi.lua

RestaurantGameBlocksRankUIApi = BaseLangApi:Extend()

function RestaurantGameBlocksRankUIApi:Init()
	self:RegisterApi("RankingLabels", self.GetRankingLabels)
	self:RegisterApi("NoneRankText", self.GetNoneRankText)
	self:RegisterApi("ChallengeRankStr", self.GetChallengeRankStr)
	self:RegisterApi("BossRankIconPath", self.GetBossRankIconPath)
	self:RegisterApi("PlayerNameText", self.GetPlayerNameText)
	self:RegisterApi("ChallengeRankHurt", self.GetChallengeRankHurt)
end

function RestaurantGameBlocksRankUIApi:GetPlayerNameText(str)
	return self.TextColor[36] .. str .. self.TextColor[0]
end

function RestaurantGameBlocksRankUIApi:GetChallengeRankHurt(hurt, mySelf)
	local str = hurt

	if mySelf then
		return self.TextColor[36] .. str .. self.TextColor[0]
	else
		return str
	end
end

function RestaurantGameBlocksRankUIApi:GetChallengeRankStr(rank, mySelf, type)
	local str = ""

	if type == 0 then
		str = "--"
	elseif type == 2 then
		str = ""
	elseif type == 1 and rank > 3 then
		str = rank
	end

	if mySelf then
		return self.TextColor[36] .. str .. self.TextColor[0]
	else
		return str
	end
end

function RestaurantGameBlocksRankUIApi:GetNoneRankText()
	return self:GetCfgText(1213068)
end

function RestaurantGameBlocksRankUIApi:GetRankingLabels()
	return {
		self:GetCfgText(3810041),
		"",
		"",
		self:GetCfgText(3810044)
	}
end

RestaurantGameBlocksRankUIApi:Init()
