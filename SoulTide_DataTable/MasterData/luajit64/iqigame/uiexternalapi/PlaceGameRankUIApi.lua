-- chunkname: @IQIGame\\UIExternalApi\\PlaceGameRankUIApi.lua

PlaceGameRankUIApi = BaseLangApi:Extend()

function PlaceGameRankUIApi:Init()
	self:RegisterApi("RankingLabels", self.GetRankingLabels)
	self:RegisterApi("NoneRankText", self.GetNoneRankText)
	self:RegisterApi("ChallengeRankStr", self.GetChallengeRankStr)
	self:RegisterApi("ChallengeRankHurt", self.GetChallengeRankHurt)
	self:RegisterApi("PlayerNameText", self.GetPlayerNameText)
end

function PlaceGameRankUIApi:GetPlayerNameText(str)
	return self.TextColor[31] .. str .. self.TextColor[0]
end

function PlaceGameRankUIApi:GetChallengeRankHurt(hurt, mySelf)
	local str = hurt

	if mySelf then
		return self.TextColor[31] .. str .. self.TextColor[0]
	else
		return str
	end
end

function PlaceGameRankUIApi:GetChallengeRankStr(rank, mySelf, type)
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

function PlaceGameRankUIApi:GetNoneRankText()
	return self:GetCfgText(1213068)
end

function PlaceGameRankUIApi:GetRankingLabels()
	return {
		self:GetCfgText(3820003),
		self:GetCfgText(3820004),
		self:GetCfgText(3820005)
	}
end

PlaceGameRankUIApi:Init()
