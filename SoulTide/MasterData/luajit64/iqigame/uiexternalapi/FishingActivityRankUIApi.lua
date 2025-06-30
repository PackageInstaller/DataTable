-- chunkname: @IQIGame\\UIExternalApi\\FishingActivityRankUIApi.lua

FishingActivityRankUIApi = BaseLangApi:Extend()

function FishingActivityRankUIApi:Init()
	self:RegisterApi("RankingLabels", self.GetRankingLabels)
	self:RegisterApi("NoneRankText", self.GetNoneRankText)
	self:RegisterApi("ChallengeRankStr", self.GetChallengeRankStr)
	self:RegisterApi("ChallengeRankHurt", self.GetChallengeRankHurt)
	self:RegisterApi("PlayerNameText", self.GetPlayerNameText)
	self:RegisterApi("BossRankIconPath", self.GetBossRankIconPath)
end

function FishingActivityRankUIApi:GetRankingLabels()
	return {
		"排名",
		"名称",
		"鱼名",
		"单次最高重量(kg)"
	}
end

function FishingActivityRankUIApi:GetNoneRankText()
	return self:GetCfgText(1213068)
end

function FishingActivityRankUIApi:GetBossRankIconPath(rank, mySelf, type)
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

function FishingActivityRankUIApi:GetPlayerNameText(str)
	return self.TextColor[36] .. str .. self.TextColor[0]
end

function FishingActivityRankUIApi:GetChallengeRankHurt(hurt, mySelf)
	local str = hurt

	if mySelf then
		return self.TextColor[36] .. str .. self.TextColor[0]
	else
		return str
	end
end

function FishingActivityRankUIApi:GetChallengeRankStr(rank, mySelf, type)
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

FishingActivityRankUIApi:Init()
