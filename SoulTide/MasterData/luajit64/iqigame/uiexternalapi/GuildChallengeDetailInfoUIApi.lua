-- chunkname: @IQIGame\\UIExternalApi\\GuildChallengeDetailInfoUIApi.lua

GuildChallengeDetailInfoUIApi = BaseLangApi:Extend()

function GuildChallengeDetailInfoUIApi:Init()
	self:RegisterApi("TitleName", self.GetTitleName)
	self:RegisterApi("BtnChallengeLabel", self.GetBtnChallengeLabel)
	self:RegisterApi("BtnQuickChallengeLabel", self.GetBtnQuickChallengeLabel)
	self:RegisterApi("TextRewardTitle", self.GetTextRewardTitle)
	self:RegisterApi("RecommendPowerText", self.GetRecommendPowerText)
	self:RegisterApi("TextPower", self.GetTextPower)
	self:RegisterApi("SpendNumber", self.GetSpendNumber)
	self:RegisterApi("TextDailyGetRecord", self.GetTextDailyGetRecord)
	self:RegisterApi("NowTextTarget", self.GetNowTextTarget)
	self:RegisterApi("TextTarget", self.GetTextTarget)
end

function GuildChallengeDetailInfoUIApi:GetTextTarget()
	return self:GetCfgText(9100001)
end

function GuildChallengeDetailInfoUIApi:GetNowTextTarget(num)
	return string.format(self:GetCfgText(9100002), num)
end

function GuildChallengeDetailInfoUIApi:GetTextDailyGetRecord(num, maxNum)
	return string.format(self:GetCfgText(9100003), num, maxNum)
end

function GuildChallengeDetailInfoUIApi:GetSpendNumber(num, ample)
	if ample then
		return string.format("%s", num)
	end

	return string.format("%s", num)
end

function GuildChallengeDetailInfoUIApi:GetTextPower(power, needPower)
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

function GuildChallengeDetailInfoUIApi:GetRecommendPowerText(recommendPower)
	return self:GetCfgText(2100005) .. "：" .. recommendPower
end

function GuildChallengeDetailInfoUIApi:GetTextRewardTitle()
	return self:GetCfgText(9100004)
end

function GuildChallengeDetailInfoUIApi:GetBtnQuickChallengeLabel()
	return self:GetCfgText(9100005)
end

function GuildChallengeDetailInfoUIApi:GetBtnChallengeLabel()
	return self:GetCfgText(9100006)
end

function GuildChallengeDetailInfoUIApi:GetTitleName()
	return self:GetCfgText(9100007)
end

GuildChallengeDetailInfoUIApi:Init()
