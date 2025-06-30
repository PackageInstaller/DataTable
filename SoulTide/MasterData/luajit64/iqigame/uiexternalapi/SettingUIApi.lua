-- chunkname: @IQIGame\\UIExternalApi\\SettingUIApi.lua

SettingUIApi = BaseLangApi:Extend()

function SettingUIApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextTitle1", self.GetTextTitle1)
	self:RegisterApi("ToggleText1", self.GetToggleText1)
	self:RegisterApi("ToggleText2", self.GetToggleText2)
	self:RegisterApi("ToggleText3", self.GetToggleText3)
	self:RegisterApi("ToggleText4", self.GetToggleText4)
	self:RegisterApi("TextTitle6", self.GetTextTitle6)
	self:RegisterApi("TextPlaceholder", self.GetTextPlaceholder)
	self:RegisterApi("TextBtnClean", self.GetTextBtnClean)
	self:RegisterApi("TextName1", self.GetTextName1)
	self:RegisterApi("TextName2", self.GetTextName2)
	self:RegisterApi("ChapterValue", self.GetChapterValue)
	self:RegisterApi("ProtocolCheckDetailBtnText", self.GetProtocolCheckDetailBtnText)
	self:RegisterApi("TextBtnContact", self.GetTextBtnContact)
	self:RegisterApi("TextCommunity", self.GetTextCommunity)
	self:RegisterApi("TextProto", self.GetTextProto)
	self:RegisterApi("imgLvPath", self.GetImgLvPath)
	self:RegisterApi("TextExp", self.GetTextExp)
	self:RegisterApi("TextBtnSave", self.GetTextBtnSave)
	self:RegisterApi("TextMaxLv", self.GetTextMaxLv)
	self:RegisterApi("InfoCarTitle", self.GetInfoCarTitle)
	self:RegisterApi("InfoMsgTitle", self.GetInfoMsgTitle)
	self:RegisterApi("InfoExhibitionTitle", self.GetInfoExhibitionTitle)
	self:RegisterApi("TextEmpty", self.GetTextEmpty)
	self:RegisterApi("TextBtnPreviewCard", self.GetTextBtnPreviewCard)
	self:RegisterApi("TextData", self.GetTextData)
	self:RegisterApi("TextTitle7", self.GetTextTitle7)
	self:RegisterApi("TextTitle8", self.GetTextTitle8)
	self:RegisterApi("TextTitle9", self.GetTextTitle9)
	self:RegisterApi("TextMusicTitle", self.GetTextMusicTitle)
	self:RegisterApi("TextPerformance", self.GetTextPerformance)
	self:RegisterApi("TextPerformanceDes", self.GetTextPerformanceDes)
	self:RegisterApi("TextSystemTitle", self.GetTextSystemTitle)
	self:RegisterApi("TextDark", self.GetTextDark)
	self:RegisterApi("TextDarkDes", self.GetTextDarkDes)
	self:RegisterApi("TextToggleOpen", self.GetTextToggleOpen)
	self:RegisterApi("TextToggleClose", self.GetTextToggleClose)
	self:RegisterApi("TextAnimation", self.GetTextAnimation)
	self:RegisterApi("TextMessage", self.GetTextMessage)
	self:RegisterApi("TextMessageDes", self.GetTextMessageDes)
	self:RegisterApi("ToggleAnimationTitle", self.GetToggleAnimationTitle)
	self:RegisterApi("GroupName", self.GetGroupName)
end

function SettingUIApi:GetGroupName(group)
	local groupName = ""

	if group == 0 then
		groupName = self:GetCfgText(2300327)
	elseif group == 1 then
		groupName = self:GetCfgText(2300328)
	elseif group == 2 then
		groupName = self:GetCfgText(2300329)
	elseif group == 3 then
		groupName = self:GetCfgText(2300330)
	elseif group == 4 then
		groupName = self:GetCfgText(2300331)
	elseif group == 5 then
		groupName = self:GetCfgText(2300332)
	elseif group == 6 then
		groupName = self:GetCfgText(2300333)
	elseif group == 7 then
		groupName = self:GetCfgText(2300334)
	else
		groupName = self:GetCfgText(2300335)
	end

	return groupName
end

function SettingUIApi:GetTextData(timeStr)
	return self:GetCfgText(2300326) .. "\n" .. timeStr
end

function SettingUIApi:GetTextBtnPreviewCard()
	return self:GetCfgText(2300320)
end

function SettingUIApi:GetTextEmpty()
	return self:GetCfgText(2300321)
end

function SettingUIApi:GetInfoExhibitionTitle()
	return self:GetCfgText(2300322)
end

function SettingUIApi:GetInfoMsgTitle()
	return self:GetCfgText(2300323)
end

function SettingUIApi:GetInfoCarTitle()
	return self:GetCfgText(2300324)
end

function SettingUIApi:GetTextBtnSave()
	return self:GetCfgText(2300319)
end

function SettingUIApi:GetTextMaxLv(maxLv)
	return "/" .. maxLv
end

function SettingUIApi:GetTextExp(exp, maxExp, lv, openMaxLv)
	if lv == openMaxLv then
		return self:GetCfgText(2300325)
	else
		return exp .. "/" .. maxExp
	end
end

function SettingUIApi:GetImgLvPath(value)
	if value == 0 then
		return self:GetResUrl(1102000)
	elseif value == 1 then
		return self:GetResUrl(1102001)
	elseif value == 2 then
		return self:GetResUrl(1102002)
	elseif value == 3 then
		return self:GetResUrl(1102003)
	elseif value == 4 then
		return self:GetResUrl(1102004)
	elseif value == 5 then
		return self:GetResUrl(1102005)
	elseif value == 6 then
		return self:GetResUrl(1102006)
	elseif value == 7 then
		return self:GetResUrl(1102007)
	elseif value == 8 then
		return self:GetResUrl(1102008)
	elseif value == 9 then
		return self:GetResUrl(1102009)
	end
end

function SettingUIApi:GetToggleAnimationTitle()
	return {
		self:GetCfgText(2300316),
		self:GetCfgText(2300317),
		self:GetCfgText(2300318)
	}
end

function SettingUIApi:GetTextMessageDes()
	return self:GetCfgText(2300315)
end

function SettingUIApi:GetTextMessage()
	return self:GetCfgText(2300314)
end

function SettingUIApi:GetTextAnimation()
	return self:GetCfgText(2300313)
end

function SettingUIApi:GetTextToggleClose()
	return self:GetCfgText(2300302)
end

function SettingUIApi:GetTextToggleOpen()
	return self:GetCfgText(2300306)
end

function SettingUIApi:GetTextDarkDes()
	return self:GetCfgText(2300312)
end

function SettingUIApi:GetTextDark()
	return self:GetCfgText(2300311)
end

function SettingUIApi:GetTextProto()
	return self:GetCfgText(2300310)
end

function SettingUIApi:GetTextCommunity()
	return self:GetCfgText(2300309)
end

function SettingUIApi:GetTextBtnContact()
	return self:GetCfgText(1111119)
end

function SettingUIApi:GetTextSystemTitle()
	return self:GetCfgText(1111120)
end

function SettingUIApi:GetTextMusicTitle()
	return self:GetCfgText(2300307)
end

function SettingUIApi:GetTextPerformanceDes()
	return self:GetCfgText(2300303)
end

function SettingUIApi:GetTextPerformance()
	return self:GetCfgText(2300304)
end

function SettingUIApi:GetChapterValue(num1, num2)
	if num1 == 1 then
		if num2 <= 3 then
			return "0-" .. num2
		else
			return num1 .. "-" .. num2 - 3
		end
	else
		return num1 .. "-" .. num2
	end

	return string.format("%s-%s", num1, num2)
end

function SettingUIApi:GetTextName2()
	return self:GetCfgText(2300300)
end

function SettingUIApi:GetTextName1()
	return self:GetCfgText(2300301)
end

function SettingUIApi:GetTextBtnClean()
	return self:GetCfgText(1111011)
end

function SettingUIApi:GetTextPlaceholder()
	return self:GetCfgText(1111012)
end

function SettingUIApi:GetTextTitle9()
	return self:GetCfgText(1111001)
end

function SettingUIApi:GetTextTitle8()
	return self:GetCfgText(1111002)
end

function SettingUIApi:GetTextTitle7()
	return self:GetCfgText(1111003)
end

function SettingUIApi:GetTextTitle6()
	return self:GetCfgText(1111004)
end

function SettingUIApi:GetToggleText4()
	return self:GetCfgText(1111006)
end

function SettingUIApi:GetToggleText3()
	return self:GetCfgText(2300307)
end

function SettingUIApi:GetToggleText2()
	return self:GetCfgText(1111005)
end

function SettingUIApi:GetToggleText1()
	return self:GetCfgText(2300308)
end

function SettingUIApi:GetTextTitle1()
	return self:GetCfgText(1111009)
end

function SettingUIApi:GetTextTitle()
	return self:GetCfgText(1111010)
end

function SettingUIApi:GetProtocolCheckDetailBtnText()
	return self:GetCfgText(1016011)
end

SettingUIApi:Init()
