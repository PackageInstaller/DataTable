-- chunkname: @IQIGame\\UIExternalApi\\DualTeamExploreExBossChallengeUIApi.lua

DualTeamExploreExBossChallengeUIApi = BaseLangApi:Extend()

function DualTeamExploreExBossChallengeUIApi:Init()
	self:RegisterApi("TitleName", self.GetTitleName)
	self:RegisterApi("TextChallengeBtn", self.GetTextChallengeBtn)
	self:RegisterApi("ToggleTeam", self.GetToggleTeam)
	self:RegisterApi("RecommendPowerText", self.GetRecommendPowerText)
	self:RegisterApi("TextFormation", self.GetTextFormation)
	self:RegisterApi("TextMaxScore", self.GetTextMaxScore)
	self:RegisterApi("ChallengeRankStr", self.GetChallengeRankStr)
	self:RegisterApi("ChallengeRankHurt", self.GetChallengeRankHurt)
	self:RegisterApi("MazeBossRankIconPath", self.GetMazeBossRankIconPath)
	self:RegisterApi("RankingText", self.GetRankingText)
	self:RegisterApi("RankingLabels", self.GetRankingLabels)
	self:RegisterApi("NoneRankText", self.GetNoneRankText)
	self:RegisterApi("TextTimeCD", self.GetTextTimeCD)
end

function DualTeamExploreExBossChallengeUIApi:GetTextTimeCD(str)
	return string.format(self:GetCfgText(1315008) .. "：%s", str)
end

function DualTeamExploreExBossChallengeUIApi:GetNoneRankText()
	return self:GetCfgText(1213068)
end

function DualTeamExploreExBossChallengeUIApi:GetRankingLabels()
	return {
		self:GetCfgText(1213073),
		self:GetCfgText(1213074),
		self:GetCfgText(3410705)
	}
end

function DualTeamExploreExBossChallengeUIApi:GetRankingText(ranking)
	if ranking == -1 then
		return "--"
	end

	if ranking == 0 then
		return "500+"
	end

	return ranking
end

function DualTeamExploreExBossChallengeUIApi:GetMazeBossRankIconPath(rank, mySelf, type)
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

function DualTeamExploreExBossChallengeUIApi:GetChallengeRankHurt(hurt, mySelf)
	local str = hurt

	if mySelf then
		return self.TextColor[31] .. str .. self.TextColor[0]
	else
		return str
	end
end

function DualTeamExploreExBossChallengeUIApi:GetChallengeRankStr(rank, mySelf, type)
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

function DualTeamExploreExBossChallengeUIApi:GetTextMaxScore(score)
	return string.format(self:GetCfgText(3410701), score)
end

function DualTeamExploreExBossChallengeUIApi:GetTextFormation()
	return self:GetCfgText(3410702)
end

function DualTeamExploreExBossChallengeUIApi:GetRecommendPowerText(recommendPower)
	return self:GetCfgText(2100005) .. "：" .. recommendPower
end

function DualTeamExploreExBossChallengeUIApi:GetToggleTeam(index)
	if index == 1 then
		return "-1-"
	end

	return "-2-"
end

function DualTeamExploreExBossChallengeUIApi:GetTextChallengeBtn()
	return self:GetCfgText(3410703)
end

function DualTeamExploreExBossChallengeUIApi:GetTitleName(openCount)
	if openCount == 1 then
		return self:GetCfgText(3410803)
	elseif openCount == 2 then
		return self:GetCfgText(2000072)
	elseif openCount == 3 then
		return self:GetCfgText(3410803)
	end

	return ""
end

DualTeamExploreExBossChallengeUIApi:Init()
