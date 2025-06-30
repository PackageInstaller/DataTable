-- chunkname: @IQIGame\\UIExternalApi\\PandaChallengeDetailInfoUIApi.lua

PandaChallengeDetailInfoUIApi = BaseLangApi:Extend()

function PandaChallengeDetailInfoUIApi:Init()
	self:RegisterApi("TitleName", self.GetTitleName)
	self:RegisterApi("RecommendPowerText", self.GetRecommendPowerText)
	self:RegisterApi("TextPower", self.GetTextPower)
	self:RegisterApi("TextTitle1", self.GetTextTitle1)
	self:RegisterApi("TextTitle2", self.GetTextTitle2)
	self:RegisterApi("TextTitle3", self.GetTextTitle3)
	self:RegisterApi("TextName", self.GetTextName)
	self:RegisterApi("BtnFightLabel", self.GetBtnFightLabel)
	self:RegisterApi("TextDifficulty", self.GetTextDifficulty)
	self:RegisterApi("TextMsg", self.GetTextMsg)
end

function PandaChallengeDetailInfoUIApi:GetTextMsg()
	return self:GetCfgText(3800501)
end

function PandaChallengeDetailInfoUIApi:GetTextDifficulty(difficulty)
	if difficulty == 1 then
		return self:GetCfgText(1213091)
	elseif difficulty == 2 then
		return self:GetCfgText(1213092)
	elseif difficulty == 3 then
		return self:GetCfgText(1213093)
	elseif difficulty == 4 then
		return self:GetCfgText(1213094)
	elseif difficulty == 5 then
		return self:GetCfgText(1213095)
	elseif difficulty == 6 then
		return self:GetCfgText(1213096)
	elseif difficulty == 7 then
		return self:GetCfgText(1213097)
	elseif difficulty == 8 then
		return self:GetCfgText(1213098)
	elseif difficulty == 9 then
		return self:GetCfgText(1213099)
	elseif difficulty == 10 then
		return self:GetCfgText(1213100)
	end

	return ""
end

function PandaChallengeDetailInfoUIApi:GetBtnFightLabel()
	return self:GetCfgText(3800502)
end

function PandaChallengeDetailInfoUIApi:GetTextName()
	return self:GetCfgText(3800503)
end

function PandaChallengeDetailInfoUIApi:GetTextTitle3()
	return self:GetCfgText(1213049)
end

function PandaChallengeDetailInfoUIApi:GetTextTitle2()
	return self:GetCfgText(3800504)
end

function PandaChallengeDetailInfoUIApi:GetTextTitle1()
	return " "
end

function PandaChallengeDetailInfoUIApi:GetTextPower(power, needPower)
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

function PandaChallengeDetailInfoUIApi:GetRecommendPowerText(recommendPower)
	return self:GetCfgText(2100005) .. "：" .. recommendPower
end

function PandaChallengeDetailInfoUIApi:GetTitleName()
	return self:GetCfgText(3800505)
end

PandaChallengeDetailInfoUIApi:Init()
