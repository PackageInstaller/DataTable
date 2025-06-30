-- chunkname: @IQIGame\\UIExternalApi\\RestaurantGameConnectRankUIApi.lua

RestaurantGameConnectRankUIApi = BaseLangApi:Extend()

function RestaurantGameConnectRankUIApi:Init()
	self:RegisterApi("RankingLabels", self.GetRankingLabels)
	self:RegisterApi("NoneRankText", self.GetNoneRankText)
	self:RegisterApi("ChallengeRankStr", self.GetChallengeRankStr)
	self:RegisterApi("ChallengeRankHurt", self.GetChallengeRankHurt)
	self:RegisterApi("PlayerNameText", self.GetPlayerNameText)
end

function RestaurantGameConnectRankUIApi:GetPlayerNameText(str)
	return self.TextColor[36] .. str .. self.TextColor[0]
end

function RestaurantGameConnectRankUIApi:GetChallengeRankHurt(hurt, mySelf)
	local str = hurt

	if mySelf then
		return self.TextColor[36] .. str .. self.TextColor[0]
	else
		return str
	end
end

function RestaurantGameConnectRankUIApi:GetChallengeRankStr(rank, mySelf, type)
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

function RestaurantGameConnectRankUIApi:GetNoneRankText()
	return self:GetCfgText(1213068)
end

function RestaurantGameConnectRankUIApi:GetRankingLabels()
	return {
		self:GetCfgText(3810041),
		self:GetCfgText(3810042),
		self:GetCfgText(3810043)
	}
end

RestaurantGameConnectRankUIApi:Init()
