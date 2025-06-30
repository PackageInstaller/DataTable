-- chunkname: @IQIGame\\UIExternalApi\\AmusementParkGameFlappyBirdRankUIApi.lua

AmusementParkGameFlappyBirdRankUIApi = BaseLangApi:Extend()

function AmusementParkGameFlappyBirdRankUIApi:Init()
	self:RegisterApi("RankingLabels", self.GetRankingLabels)
	self:RegisterApi("NoneRankText", self.GetNoneRankText)
	self:RegisterApi("ChallengeRankStr", self.GetChallengeRankStr)
	self:RegisterApi("BossRankIconPath", self.GetBossRankIconPath)
	self:RegisterApi("PlayerNameText", self.GetPlayerNameText)
	self:RegisterApi("ChallengeRankHurt", self.GetChallengeRankHurt)
	self:RegisterApi("GameLv", self.GetGameLV)
end

function AmusementParkGameFlappyBirdRankUIApi:GetGameLV(lv, mySelf)
	local str = lv

	if mySelf then
		return self.TextColor[36] .. str .. self.TextColor[0]
	else
		return str
	end
end

function AmusementParkGameFlappyBirdRankUIApi:GetPlayerNameText(str)
	return self.TextColor[36] .. str .. self.TextColor[0]
end

function AmusementParkGameFlappyBirdRankUIApi:GetChallengeRankHurt(hurt, mySelf)
	local str = hurt

	if mySelf then
		return self.TextColor[36] .. str .. self.TextColor[0]
	else
		return str
	end
end

function AmusementParkGameFlappyBirdRankUIApi:GetChallengeRankStr(rank, mySelf, type)
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

function AmusementParkGameFlappyBirdRankUIApi:GetNoneRankText()
	return self:GetCfgText(1213068)
end

function AmusementParkGameFlappyBirdRankUIApi:GetRankingLabels()
	return {
		self:GetCfgText(3810041),
		"名称",
		"游戏等级",
		self:GetCfgText(3810044)
	}
end

AmusementParkGameFlappyBirdRankUIApi:Init()
