-- chunkname: @IQIGame\\UIExternalApi\\MazeBossChallengeDetailUIApi.lua

MazeBossChallengeDetailUIApi = BaseLangApi:Extend()

function MazeBossChallengeDetailUIApi:Init()
	self:RegisterApi("TextReward", self.GetTextReward)
	self:RegisterApi("TextChallengeBtn", self.GetTextChallengeBtn)
	self:RegisterApi("RankingLabels", self.GetRankingLabels)
	self:RegisterApi("NoneRankText", self.GetNoneRankText)
	self:RegisterApi("TextNotice3", self.GetTextNotice3)
	self:RegisterApi("TitleName", self.GetTitleName)
	self:RegisterApi("TextTimeCD", self.GetTextTimeCD)
	self:RegisterApi("TimeCD", self.GetTimeCD)
	self:RegisterApi("ChallengeRankStr", self.GetChallengeRankStr)
	self:RegisterApi("ChallengeRankHurt", self.GetChallengeRankHurt)
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextRewardTitle", self.GetTextRewardTitle)
	self:RegisterApi("TextMsg", self.GetTextMsg)
	self:RegisterApi("TextRewardIndex", self.GetTextRewardIndex)
	self:RegisterApi("RankRewardIconPath", self.GetRankRewardIconPath)
	self:RegisterApi("MazeBossRankIconPath", self.GetMazeBossRankIconPath)
	self:RegisterApi("TextNoRank", self.GetTextNoRank)
end

function MazeBossChallengeDetailUIApi:GetTextNoRank()
	return self:GetCfgText(1213066)
end

function MazeBossChallengeDetailUIApi:GetTextMsg()
	return self:GetCfgText(3100601)
end

function MazeBossChallengeDetailUIApi:GetTextRewardTitle()
	return self:GetCfgText(1213077)
end

function MazeBossChallengeDetailUIApi:GetTextTitle()
	return self:GetCfgText(1213001)
end

function MazeBossChallengeDetailUIApi:GetRankRewardIconPath(num1, num2, type)
	if type == 1 then
		if num1 == 4 then
			return self:GetResUrl(2700101)
		elseif num1 == 11 then
			return self:GetResUrl(2700101)
		elseif num1 == 51 then
			return self:GetResUrl(2700102)
		elseif num1 == 101 then
			return self:GetResUrl(2700103)
		elseif num1 == 501 then
			return self:GetResUrl(2700104)
		end
	elseif type == 2 then
		if num1 == 1 then
			return self:GetResUrl(2700105)
		elseif num1 == 11 then
			return self:GetResUrl(2700106)
		elseif num1 == 21 then
			return self:GetResUrl(2700107)
		elseif num1 == 31 then
			return self:GetResUrl(2700108)
		elseif num1 == 41 then
			return self:GetResUrl(2700109)
		elseif num1 == 61 then
			return self:GetResUrl(2700110)
		elseif num1 == 81 then
			return self:GetResUrl(2700111)
		end
	end
end

function MazeBossChallengeDetailUIApi:GetMazeBossRankIconPath(rank, mySelf, type)
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

function MazeBossChallengeDetailUIApi:GetTextRewardIndex(num1, num2, type)
	if type == 1 and num1 > 3 then
		return string.format("%s-%s", num1, num2)
	elseif type == 2 then
		if num1 == 1 then
			return string.format("1001-" .. "%s" .. "%%", num2)
		elseif num1 > 1 then
			return string.format("%s" .. "%%-" .. "%s" .. "%%", num1, num2)
		end
	end

	return ""
end

function MazeBossChallengeDetailUIApi:GetChallengeRankHurt(hurt, mySelf)
	local str = hurt

	if mySelf then
		return self.TextColor[31] .. str .. self.TextColor[0]
	else
		return str
	end
end

function MazeBossChallengeDetailUIApi:GetChallengeRankStr(rank, mySelf, type)
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

function MazeBossChallengeDetailUIApi:GetTimeCD()
	return self:GetCfgText(1213046)
end

function MazeBossChallengeDetailUIApi:GetTextTimeCD(str)
	return string.format(self:GetCfgText(1315008) .. "：%s", str)
end

function MazeBossChallengeDetailUIApi:GetTitleName()
	return self:GetCfgText(2000079)
end

function MazeBossChallengeDetailUIApi:GetTextNotice3()
	return self:GetCfgText(1213047)
end

function MazeBossChallengeDetailUIApi:GetNoneRankText()
	return self:GetCfgText(1213068)
end

function MazeBossChallengeDetailUIApi:GetRankingLabels()
	return {
		self:GetCfgText(1213073),
		self:GetCfgText(1213074),
		self:GetCfgText(1213075)
	}
end

function MazeBossChallengeDetailUIApi:GetTextChallengeBtn()
	return self:GetCfgText(1213003)
end

function MazeBossChallengeDetailUIApi:GetTextReward()
	return self:GetCfgText(1213071)
end

MazeBossChallengeDetailUIApi:Init()
