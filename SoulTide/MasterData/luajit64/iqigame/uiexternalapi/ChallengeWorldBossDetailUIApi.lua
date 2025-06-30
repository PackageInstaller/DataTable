-- chunkname: @IQIGame\\UIExternalApi\\ChallengeWorldBossDetailUIApi.lua

ChallengeWorldBossDetailUIApi = BaseLangApi:Extend()

function ChallengeWorldBossDetailUIApi:Init()
	self:RegisterApi("TextShop", self.GetTextShop)
	self:RegisterApi("TextReward", self.GetTextReward)
	self:RegisterApi("TextLevelTitle", self.GetTextLevelTitle)
	self:RegisterApi("TextBtnKillReward", self.GetTextBtnKillReward)
	self:RegisterApi("RankingLabels", self.GetRankingLabels)
	self:RegisterApi("ChallengeRankStr", self.GetChallengeRankStr)
	self:RegisterApi("ChallengeRankHurt", self.GetChallengeRankHurt)
	self:RegisterApi("ChallengeRankBossLv", self.GetChallengeRankBossLv)
	self:RegisterApi("NoneRankText", self.GetNoneRankText)
	self:RegisterApi("TextTimesNum", self.GetTextTimesNum)
	self:RegisterApi("TextTimes", self.GetTextTimes)
	self:RegisterApi("TextNotice1", self.GetTextNotice1)
	self:RegisterApi("TextNotice2", self.GetTextNotice2)
	self:RegisterApi("TextNotice3", self.GetTextNotice3)
	self:RegisterApi("TextChallengeBtn", self.GetTextChallengeBtn)
	self:RegisterApi("TextNotice", self.GetTextNotice)
	self:RegisterApi("TextBtnBossTip", self.GetTextBtnBossTip)
	self:RegisterApi("ToggleStr", self.GetToggleStr)
	self:RegisterApi("BossLevel", self.GetBossLevel)
	self:RegisterApi("Tips", self.GetTips)
	self:RegisterApi("TextKillRank", self.GetTextKillRank)
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextRewardTitle", self.GetTextRewardTitle)
	self:RegisterApi("TextMsg", self.GetTextMsg)
	self:RegisterApi("TextRewardIndex", self.GetTextRewardIndex)
	self:RegisterApi("ChallengeRankRewardIconPath", self.GetChallengeRankRewardIconPath)
	self:RegisterApi("ChallengeRankIconPath", self.GetChallengeRankIconPath)
	self:RegisterApi("TextNoRank", self.GetTextNoRank)
end

function ChallengeWorldBossDetailUIApi:GetTips()
	return self:GetCfgText(1213040)
end

function ChallengeWorldBossDetailUIApi:GetBossLevel(level, IsExBoss)
	if IsExBoss then
		return "∞"
	end

	return level
end

function ChallengeWorldBossDetailUIApi:GetToggleStr(index)
	if index == 1 then
		return self:GetCfgText(1213101)
	elseif index == 2 then
		return self:GetCfgText(1213102)
	end

	return ""
end

function ChallengeWorldBossDetailUIApi:GetTextBtnBossTip()
	return self:GetCfgText(1213103)
end

function ChallengeWorldBossDetailUIApi:GetTextNotice()
	return self:GetCfgText(1213065)
end

function ChallengeWorldBossDetailUIApi:GetTextNoRank()
	return self:GetCfgText(1213066)
end

function ChallengeWorldBossDetailUIApi:GetChallengeRankRewardIconPath(num1, num2, type)
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

function ChallengeWorldBossDetailUIApi:GetTextRewardIndex(num1, num2, type)
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

function ChallengeWorldBossDetailUIApi:GetTextMsg()
	return self:GetCfgText(1213076)
end

function ChallengeWorldBossDetailUIApi:GetTextRewardTitle()
	return self:GetCfgText(1213077)
end

function ChallengeWorldBossDetailUIApi:GetTextTitle()
	return self:GetCfgText(1213001)
end

function ChallengeWorldBossDetailUIApi:GetTextChallengeBtn()
	return self:GetCfgText(1213003)
end

function ChallengeWorldBossDetailUIApi:GetTextTimes()
	return self:GetCfgText(1213051)
end

function ChallengeWorldBossDetailUIApi:GetTextNotice3()
	return self:GetCfgText(1213047)
end

function ChallengeWorldBossDetailUIApi:GetTextNotice2()
	return self:GetCfgText(1213067)
end

function ChallengeWorldBossDetailUIApi:GetTextNotice1()
	return self:GetCfgText(1213065)
end

function ChallengeWorldBossDetailUIApi:GetTextTimesNum(num1, num2)
	return string.format("%s/%s", num1, num2)
end

function ChallengeWorldBossDetailUIApi:GetNoneRankText()
	return self:GetCfgText(1213068)
end

function ChallengeWorldBossDetailUIApi:GetChallengeRankIconPath(rank, mySelf, type)
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

function ChallengeWorldBossDetailUIApi:GetChallengeRankStr(rank, mySelf, type)
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

function ChallengeWorldBossDetailUIApi:GetChallengeRankBossLv(bossLv, mySelf)
	local str = bossLv
	local num = tonumber(bossLv)

	if num ~= nil and num > 35 then
		str = "∞"
	end

	if mySelf then
		return self.TextColor[12] .. str .. self.TextColor[0]
	else
		return str
	end
end

function ChallengeWorldBossDetailUIApi:GetChallengeRankHurt(hurt, mySelf)
	local str = hurt

	if mySelf then
		return self.TextColor[12] .. str .. self.TextColor[0]
	else
		return str
	end
end

function ChallengeWorldBossDetailUIApi:GetRankingLabels()
	return {
		self:GetCfgText(1213073),
		self:GetCfgText(1213074),
		self:GetCfgText(1213080),
		self:GetCfgText(1213075)
	}
end

function ChallengeWorldBossDetailUIApi:GetTextKillRank()
	return self:GetCfgText(1213069)
end

function ChallengeWorldBossDetailUIApi:GetTextBtnKillReward()
	return self:GetCfgText(1213070)
end

function ChallengeWorldBossDetailUIApi:GetTextLevelTitle()
	return self:GetCfgText(1213079)
end

function ChallengeWorldBossDetailUIApi:GetTextReward()
	return self:GetCfgText(1213071)
end

function ChallengeWorldBossDetailUIApi:GetTextShop()
	return self:GetCfgText(1213072)
end

ChallengeWorldBossDetailUIApi:Init()
