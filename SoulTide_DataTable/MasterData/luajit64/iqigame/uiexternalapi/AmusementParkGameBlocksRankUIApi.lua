-- chunkname: @IQIGame\\UIExternalApi\\AmusementParkGameBlocksRankUIApi.lua

AmusementParkGameBlocksRankUIApi = BaseLangApi:Extend()

function AmusementParkGameBlocksRankUIApi:Init()
	self:RegisterApi("RankingLabels", self.GetRankingLabels)
	self:RegisterApi("NoneRankText", self.GetNoneRankText)
	self:RegisterApi("ChallengeRankStr", self.GetChallengeRankStr)
	self:RegisterApi("BossRankIconPath", self.GetBossRankIconPath)
	self:RegisterApi("PlayerNameText", self.GetPlayerNameText)
	self:RegisterApi("ChallengeRankHurt", self.GetChallengeRankHurt)
	self:RegisterApi("GameLv", self.GetGameLV)
end

function AmusementParkGameBlocksRankUIApi:GetGameLV(lv, mySelf)
	local str = lv

	if mySelf then
		return self.TextColor[36] .. str .. self.TextColor[0]
	else
		return str
	end
end

function AmusementParkGameBlocksRankUIApi:GetPlayerNameText(str)
	return self.TextColor[36] .. str .. self.TextColor[0]
end

function AmusementParkGameBlocksRankUIApi:GetChallengeRankHurt(hurt, mySelf)
	local str = hurt

	if mySelf then
		return self.TextColor[36] .. str .. self.TextColor[0]
	else
		return str
	end
end

function AmusementParkGameBlocksRankUIApi:GetChallengeRankStr(rank, mySelf, type)
	local str = ""

	if type == 0 then
		str = "--"
	elseif type == 2 then
		str = ""
	elseif type == 1 and rank > 3 then
		str = rank
	end

	if mySelf then
		return str
	else
		return str
	end
end

function AmusementParkGameBlocksRankUIApi:GetNoneRankText()
	return self:GetCfgText(1213068)
end

function AmusementParkGameBlocksRankUIApi:GetRankingLabels()
	return {
		self:GetCfgText(3810041),
		self:GetCfgText(3830086),
		self:GetCfgText(3830087),
		self:GetCfgText(3810044)
	}
end

AmusementParkGameBlocksRankUIApi:Init()
