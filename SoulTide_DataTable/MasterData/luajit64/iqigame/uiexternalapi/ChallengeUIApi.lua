-- chunkname: @IQIGame\\UIExternalApi\\ChallengeUIApi.lua

ChallengeUIApi = BaseLangApi:Extend()

function ChallengeUIApi:Init()
	self:RegisterApi("TextDifficulty", self.GetTextDifficulty)
	self:RegisterApi("TextTitle1", self.GetTextTitle1)
	self:RegisterApi("TextTitle2", self.GetTextTitle2)
	self:RegisterApi("TextTitle3", self.GetTextTitle3)
	self:RegisterApi("TextRewardTitle", self.GetTextRewardTitle)
	self:RegisterApi("TextChallenge", self.GetTextChallenge)
	self:RegisterApi("TextTimes", self.GetTextTimes)
	self:RegisterApi("TextNotice1", self.GetTextNotice1)
	self:RegisterApi("TextNotice2", self.GetTextNotice2)
	self:RegisterApi("TextNotice3", self.GetTextNotice3)
	self:RegisterApi("TextNotice4", self.GetTextNotice4)
	self:RegisterApi("TextNotice5", self.GetTextNotice5)
	self:RegisterApi("TextNotice6", self.GetTextNotice6)
	self:RegisterApi("TextNotice7", self.GetTextNotice7)
	self:RegisterApi("TextNotice8", self.GetTextNotice8)
	self:RegisterApi("TextNotice9", self.GetTextNotice9)
	self:RegisterApi("TextMsg2", self.GetTextMsg2)
	self:RegisterApi("TextMsg3", self.GetTextMsg3)
	self:RegisterApi("TextTitle4", self.GetTextTitle4)
	self:RegisterApi("TextTitle6", self.GetTextTitle6)
	self:RegisterApi("TextSweepingBtn", self.GetTextSweepingBtn)
	self:RegisterApi("TextLoseHurt", self.GetTextLoseHurt)
	self:RegisterApi("TimesTitle", self.GetTimesTitle)
	self:RegisterApi("TextLock1", self.GetTextLock1)
	self:RegisterApi("OnText2", self.GetOnText2)
	self:RegisterApi("TextPower", self.GetTextPower)
	self:RegisterApi("SpendEnergy", self.GetSpendEnergy)
end

function ChallengeUIApi:GetSpendEnergy(needNu, haveNum)
	if haveNum < needNu then
		return needNu
	end

	return needNu
end

function ChallengeUIApi:GetTextPower(power, needPower)
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

function ChallengeUIApi:GetOnText2()
	return ""
end

function ChallengeUIApi:GetTextLock1()
	return self:GetCfgText(1015021)
end

function ChallengeUIApi:GetTimesTitle()
	return self:GetCfgText(1213051)
end

function ChallengeUIApi:GetTextLoseHurt()
	return self:GetCfgText(1213052)
end

function ChallengeUIApi:GetTextSweepingBtn()
	return self:GetCfgText(1213023)
end

function ChallengeUIApi:GetTextTitle6(num)
	return num .. self:GetCfgText(1015045)
end

function ChallengeUIApi:GetTextTitle4(type)
	if type == 2 then
		return self:GetCfgText(1213019)
	end

	return self:GetCfgText(1150076)
end

function ChallengeUIApi:GetTextNotice9()
	return self:GetCfgText(1213053)
end

function ChallengeUIApi:GetTextMsg3(num)
	return self:GetCfgText(1213054) .. num
end

function ChallengeUIApi:GetTextMsg2(num)
	return self:GetCfgText(1213055) .. num
end

function ChallengeUIApi:GetTextNotice8()
	return self:GetCfgText(1213050)
end

function ChallengeUIApi:GetTextNotice7()
	return self:GetCfgText(1213056)
end

function ChallengeUIApi:GetTextNotice6()
	return self:GetCfgText(1213057)
end

function ChallengeUIApi:GetTextNotice5()
	return self:GetCfgText(1213058)
end

function ChallengeUIApi:GetTextNotice4()
	return self:GetCfgText(1213059)
end

function ChallengeUIApi:GetTextNotice3()
	return self:GetCfgText(1213046)
end

function ChallengeUIApi:GetTextNotice2()
	return self:GetCfgText(1213047)
end

function ChallengeUIApi:GetTextNotice1()
	return self:GetCfgText(1213048)
end

function ChallengeUIApi:GetTextTimes(num1, num2)
	return num1 .. "/" .. num2
end

function ChallengeUIApi:GetTextChallenge()
	return self:GetCfgText(1213003)
end

function ChallengeUIApi:GetTextRewardTitle(type, win, lang)
	local str = ""

	if lang == 1 then
		if type == 1 then
			if win then
				str = self:GetCfgText(1213060)
			else
				str = self:GetCfgText(1213061)
			end
		elseif type == 2 then
			if win then
				str = self:GetCfgText(1213062)
			else
				str = self:GetCfgText(1213063)
			end
		end
	elseif type == 1 then
		if win then
			str = self:GetCfgText(1213089)
		else
			str = self:GetCfgText(1213090)
		end
	elseif type == 2 then
		if win then
			str = self:GetCfgText(1213089)
		else
			str = self:GetCfgText(1213090)
		end
	end

	return str
end

function ChallengeUIApi:GetTextTitle3(type)
	if type == 2 then
		return self:GetCfgText(1213081)
	end

	return self:GetCfgText(1213049)
end

function ChallengeUIApi:GetTextTitle2(type)
	if type == 2 then
		return self:GetCfgText(1213082)
	end

	return self:GetCfgText(1213064)
end

function ChallengeUIApi:GetTextTitle1(type)
	if type == 2 then
		return self:GetCfgText(1213019)
	end

	return self:GetCfgText(1213029)
end

function ChallengeUIApi:GetTextDifficulty(index, type)
	if type == 1 then
		if index == 1 then
			return self:GetCfgText(1213091)
		elseif index == 2 then
			return self:GetCfgText(1213092)
		elseif index == 3 then
			return self:GetCfgText(1213093)
		elseif index == 4 then
			return self:GetCfgText(1213094)
		elseif index == 5 then
			return self:GetCfgText(1213095)
		elseif index == 6 then
			return self:GetCfgText(1213096)
		elseif index == 7 then
			return self:GetCfgText(1213097)
		elseif index == 8 then
			return self:GetCfgText(1213098)
		elseif index == 9 then
			return self:GetCfgText(1213099)
		elseif index == 10 then
			return self:GetCfgText(1213100)
		end
	elseif index == 1 then
		return self:GetCfgText(1213083)
	elseif index == 2 then
		return self:GetCfgText(1213083)
	elseif index == 3 then
		return self:GetCfgText(1213084)
	elseif index == 4 then
		return self:GetCfgText(1213084)
	elseif index == 5 then
		return self:GetCfgText(1213085)
	elseif index == 6 then
		return self:GetCfgText(1213085)
	elseif index == 7 then
		return self:GetCfgText(1213086)
	elseif index == 8 then
		return self:GetCfgText(1213086)
	elseif index == 9 then
		return self:GetCfgText(1213087)
	elseif index == 10 then
		return self:GetCfgText(1213087)
	end

	return ""
end

ChallengeUIApi:Init()
