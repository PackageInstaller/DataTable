-- chunkname: @IQIGame\\UIExternalApi\\GirlMoodUINoticeUIApi.lua

GirlMoodUINoticeUIApi = BaseLangApi:Extend()

function GirlMoodUINoticeUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("StatePath", self.GetStatePath)
	self:RegisterApi("TextState", self.GetTextState)
	self:RegisterApi("TextMood", self.GetTextMood)
	self:RegisterApi("TextSpeed", self.GetTextSpeed)
	self:RegisterApi("TextMoodChange", self.GetTextMoodChange)
	self:RegisterApi("TextMsg", self.GetTextMsg)
	self:RegisterApi("TextBtnSetMood", self.GetTextBtnSetMood)
	self:RegisterApi("TextMoodValue", self.GetTextMoodValue)
	self:RegisterApi("TextTitle1", self.GetTextTitle1)
	self:RegisterApi("TextDes1", self.GetTextDes1)
	self:RegisterApi("TextDes2", self.GetTextDes2)
	self:RegisterApi("TextDes1_Title_1", self.GetTextDes1_Title_1)
	self:RegisterApi("TextDes1_Title_2", self.GetTextDes1_Title_2)
	self:RegisterApi("TextDes2_Title_1", self.GetTextDes2_Title_1)
	self:RegisterApi("TextDes2_Title_2", self.GetTextDes2_Title_2)
	self:RegisterApi("StateBGPath", self.GetStateBGPath)
	self:RegisterApi("ImgTitleBG", self.GetImgTitleBG)
	self:RegisterApi("ImgValueBG", self.GetImgValueBG)
end

function GirlMoodUINoticeUIApi:GetImgValueBG(state)
	if state == 2 then
		return self:GetResUrl(1200005)
	elseif state == 3 then
		return self:GetResUrl(1200006)
	end

	return self:GetResUrl(1200004)
end

function GirlMoodUINoticeUIApi:GetImgTitleBG(state)
	if state == 2 then
		return self:GetResUrl(1200007)
	elseif state == 3 then
		return self:GetResUrl(1200008)
	end

	return self:GetResUrl(1200005)
end

function GirlMoodUINoticeUIApi:GetStateBGPath(state)
	if state == 2 then
		return self:GetResUrl(1200010)
	elseif state == 3 then
		return self:GetResUrl(1200011)
	end

	return self:GetResUrl(1200009)
end

function GirlMoodUINoticeUIApi:GetTextDes2_Title_2()
	return self:GetCfgText(1014050)
end

function GirlMoodUINoticeUIApi:GetTextDes2_Title_1()
	return "2"
end

function GirlMoodUINoticeUIApi:GetTextDes1_Title_2()
	return self:GetCfgText(1014051)
end

function GirlMoodUINoticeUIApi:GetTextDes1_Title_1()
	return "1"
end

function GirlMoodUINoticeUIApi:GetTextDes2()
	return self:GetCfgText(1014052)
end

function GirlMoodUINoticeUIApi:GetTextDes1()
	return self:GetCfgText(1014053)
end

function GirlMoodUINoticeUIApi:GetTextTitle1()
	return self:GetCfgText(1014054)
end

function GirlMoodUINoticeUIApi:GetTextMoodValue(state)
	if state == 1 then
		return "<color=#de6851>" .. self:GetCfgText(1014055) .. "%" .. "</color>"
	elseif state == 2 then
		return self:GetCfgText(1014056)
	elseif state == 3 then
		return self:GetCfgText(1014057) .. "%"
	end

	return ""
end

function GirlMoodUINoticeUIApi:GetTextBtnSetMood()
	return self:GetCfgText(1014058)
end

function GirlMoodUINoticeUIApi:GetTextMsg()
	return self:GetCfgText(1014053)
end

function GirlMoodUINoticeUIApi:GetTextMoodChange(str1, str2)
	return str1 .. self:GetCfgText(1014059)
end

function GirlMoodUINoticeUIApi:GetTextSpeed(value)
	return self:GetCfgText(1014060) .. string.format(self:GetCfgText(1014061), value)
end

function GirlMoodUINoticeUIApi:GetTextMood(str)
	return "" .. str
end

function GirlMoodUINoticeUIApi:GetTextState(state)
	local str = ""

	if state == 1 then
		str = self.TextColor[31] .. self:GetCfgText(1014062) .. self.TextColor[0]
	elseif state == 2 then
		str = self:GetCfgText(1014063)
	else
		str = self:GetCfgText(1014064)
	end

	return str
end

function GirlMoodUINoticeUIApi:GetStatePath(state)
	if state == 2 then
		return self:GetResUrl(1200002)
	elseif state == 3 then
		return self:GetResUrl(1200001)
	end

	return self:GetResUrl(1200003)
end

function GirlMoodUINoticeUIApi:GetTitleText()
	return self:GetCfgText(1014065)
end

GirlMoodUINoticeUIApi:Init()
