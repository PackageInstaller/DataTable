-- chunkname: @IQIGame\\UIExternalApi\\GirlUIApi.lua

GirlUIApi = BaseLangApi:Extend()

function GirlUIApi:Init()
	self:RegisterApi("FavorUpperLimitTxt", self.GetFavorTxt)
	self:RegisterApi("VitalitySourceTxt", self.GetVitalitySourceTxt)
	self:RegisterApi("GetUpStrTxt", self.GetUpStr)
	self:RegisterApi("FavorTxt", self.GetFavorStr)
	self:RegisterApi("TextTitleName", self.GetTextTitleName)
	self:RegisterApi("TextPerTitle", self.GetTextPerTitle)
	self:RegisterApi("TextPer", self.GetTextPer)
	self:RegisterApi("BtnOathIconPath", self.GetBtnOathIconPath)
	self:RegisterApi("TextFavorLv", self.GetTextFavorLv)
	self:RegisterApi("TextFavor", self.GetTextFavor)
	self:RegisterApi("DatingTxt", self.GetDatingTxt)
	self:RegisterApi("NewMemoryTxt", self.GetNewMemoryTxt)
	self:RegisterApi("MemoryTxt", self.GetMemoryTxt)
	self:RegisterApi("GiftTxt", self.GetGiftTxt)
	self:RegisterApi("ClosetTxt", self.GetClosetTxt)
	self:RegisterApi("ChangeShowSoul", self.GetChangeShowSoul)
	self:RegisterApi("TextBtnGift", self.GetTextBtnGift)
	self:RegisterApi("TextBtnSoulLibrary", self.GetTextBtnSoulLibrary)
	self:RegisterApi("TextBtnPv", self.GetTextBtnPv)
	self:RegisterApi("labLifePowerTitleTxt", self.GetLifePowerTitleTxt)
	self:RegisterApi("labCurPowerTxt", self.GetCurPowerTxt)
	self:RegisterApi("labNextPowerTxt", self.GetNextPowerTxt)
	self:RegisterApi("labUpPowerTxt", self.GetLabUpPowerTxt)
	self:RegisterApi("PresetTxt", self.GetPresetTxt)
	self:RegisterApi("GiftSourceTxt", self.GetGiftSourceTxt)
	self:RegisterApi("GiftCatTxt", self.GetGiftCatTxt)
	self:RegisterApi("labBoxGiftRecommendTxt", self.GetLabBoxGiftRecommendTxt)
	self:RegisterApi("labSendGiftTxt", self.GetLabSendGiftTxt)
	self:RegisterApi("labUpMaxPowerTxt", self.GetLabUpMaxPowerTxt)
	self:RegisterApi("TagTxt", self.GetTagTxt)
	self:RegisterApi("TextBtnCloseGift", self.GetTextBtnCloseGift)
	self:RegisterApi("labFavorTitleTxt", self.GetLabFavorTitleTxt)
	self:RegisterApi("labUpFavorTitleTxt", self.GetLabUpFavorTitleTxt)
	self:RegisterApi("LoveUpTxt", self.GetLoveUpTxt)
	self:RegisterApi("labTouchText", self.GetLabTouchText)
	self:RegisterApi("labFateTitleTxt", self.GetLabFateTitleTxt)
	self:RegisterApi("labLoveStageTxt", self.GetLabLoveStageTxt)
	self:RegisterApi("UnlockMemoryLv", self.GetUnlockMemoryLv)
	self:RegisterApi("UnlockNewMemoryLv", self.GetUnlockNewMemoryLv)
	self:RegisterApi("TextSpecificSoul", self.GetTextSpecificSoul)
	self:RegisterApi("GiftType", self.GetGiftType)
	self:RegisterApi("TextBtnHideList", self.GetTextBtnHideList)
	self:RegisterApi("TextBtnShowList", self.GetTextBtnShowList)
	self:RegisterApi("SoulHeadScale", self.GetSoulHeadScale)
	self:RegisterApi("TextMoodValue", self.GetTextMoodValue)
	self:RegisterApi("TextMoodSpeed", self.GetTextMoodSpeed)
	self:RegisterApi("dressViewTitle", self.GetDressViewTitle)
	self:RegisterApi("dressViewDressName", self.GetDressViewDressName)
	self:RegisterApi("dressViewSignWoreTxt", self.GetDressViewSignWoreTxt)
	self:RegisterApi("dressViewCondition", self.GetDressViewCondition)
	self:RegisterApi("dressViewBtnDressTxt", self.GetDressViewBtnDressTxt)
	self:RegisterApi("dressViewBtnCloseTxt", self.GetDressViewBtnCloseTxt)
	self:RegisterApi("dressViewBottomSignWoreTxt", self.GetDressViewBottomSignWoreTxt)
	self:RegisterApi("dressShowView", self.GetDressShowViewClickDesc)
	self:RegisterApi("FondleTime", self.GetFondleTime)
	self:RegisterApi("HeadPoint", self.GetHeadPoint)
	self:RegisterApi("WhisperTitle", self.GetWhisperTitle)
	self:RegisterApi("WhisperBtnLinkLabel", self.GetWhisperBtnLinkLabel)
	self:RegisterApi("WhisperBtnPlayLabel", self.GetWhisperBtnPlayLabel)
	self:RegisterApi("BGTextBGTitle", self.GetBGTextBGTitle)
	self:RegisterApi("BGBtnUseLabel", self.GetBtnUseLabel)
	self:RegisterApi("BGTextUseTag", self.GetBGTextUseTag)
	self:RegisterApi("BGTextCurrent", self.GetBGTextCurrent)
end

function GirlUIApi:GetBGTextCurrent()
	return self:GetCfgText(9101301)
end

function GirlUIApi:GetBGTextUseTag()
	return self:GetCfgText(9101302)
end

function GirlUIApi:GetBtnUseLabel()
	return self:GetCfgText(9101303)
end

function GirlUIApi:GetBGTextBGTitle()
	return self:GetCfgText(9101304)
end

function GirlUIApi:GetTextFavor(num1, num2)
	if num2 == 0 then
		return num1
	end

	return string.format("%s/%s", num1, num2)
end

function GirlUIApi:GetTextFavorLv()
	return self:GetCfgText(1190020)
end

function GirlUIApi:GetBtnOathIconPath(top)
	if top then
		return UIGlobalApi.GetImagePath("/Girl/GirlUI/GirlUI/GirlUI_GirlUI_Image_12.png")
	end

	return UIGlobalApi.GetImagePath("/Girl/GirlUI/GirlUI/GirlUI_GirlUI_Image_13.png")
end

function GirlUIApi:GetWhisperBtnPlayLabel()
	return self:GetCfgText(1160061)
end

function GirlUIApi:GetWhisperBtnLinkLabel()
	return self:GetCfgText(1160062)
end

function GirlUIApi:GetWhisperTitle()
	return self:GetCfgText(1160063)
end

function GirlUIApi:GetGiftType(type)
	if type == 3 then
		return self:GetCfgText(1014074)
	elseif type == 2 then
		return self:GetCfgText(1014075)
	elseif type == 1 then
		return self:GetCfgText(1014076)
	end

	return ""
end

function GirlUIApi:GetTextBtnPv()
	return "PV"
end

function GirlUIApi:GetHeadPoint(soulID)
	if soulID == 20010018 then
		return Vector3.New(-225.6, 150.9, 0)
	elseif soulID == 20010019 then
		return Vector3.New(-225.6, 150.9, 0)
	elseif soulID == 20010004 then
		return Vector3.New(-198.62, 110, 0)
	elseif soulID == 20010006 then
		return Vector3.New(-170, 180, 0)
	elseif soulID == 20010002 then
		return Vector3.New(-165, 90, 0)
	elseif soulID == 20010005 then
		return Vector3.New(-195, 90, 0)
	elseif soulID == 20010008 then
		return Vector3.New(-165, 178, 0)
	elseif soulID == 20010009 then
		return Vector3.New(-165, 178, 0)
	elseif soulID == 20010010 then
		return Vector3.New(-165, 128, 0)
	elseif soulID == 20010011 then
		return Vector3.New(-195, 218, 0)
	elseif soulID == 20010014 then
		return Vector3.New(-195, 218, 0)
	elseif soulID == 31000003 then
		return Vector3.New(-314.6, 98.4, 0)
	elseif soulID == 20010020 then
		return Vector3.New(-243.1, 219.4, 0)
	elseif soulID == 20010021 then
		return Vector3.New(-165.2, 194.7, 0)
	elseif soulID == 31000003 then
		return Vector3.New(-314.6, 98.4, 0)
	elseif soulID == 20010007 then
		return Vector3.New(-186, 210, 0)
	elseif soulID == 20010017 then
		return Vector3.New(-315, 79, 0)
	elseif soulID == 20010012 then
		return Vector3.New(-195, 213, 0)
	elseif soulID == 20010016 then
		return Vector3.New(-172, 197, 0)
	elseif soulID == 20010023 then
		return Vector3.New(-209, 207, 0)
	elseif soulID == 20010024 then
		return Vector3.New(-202, 234, 0)
	elseif soulID == 20010025 then
		return Vector3.New(-185, 228, 0)
	elseif soulID == 20010027 then
		return Vector3.New(-203, 138, 0)
	elseif soulID == 20010028 then
		return Vector3.New(-157, 198, 0)
	elseif soulID == 20010029 then
		return Vector3.New(-191, 198, 0)
	elseif soulID == 20010030 then
		return Vector3.New(-175, 233, 0)
	elseif soulID == 20010031 then
		return Vector3.New(-141, 179, 0)
	elseif soulID == 20010032 then
		return Vector3.New(-210, 92, 0)
	elseif soulID == 20010034 then
		return Vector3.New(-157, 167, 0)
	elseif soulID == 20010035 then
		return Vector3.New(-157, 144, 0)
	elseif soulID == 20010036 then
		return Vector3.New(-157, 144, 0)
	elseif soulID == 20010037 then
		return Vector3.New(-160, 200, 0)
	elseif soulID == 20010038 then
		return Vector3.New(-195, 221, 0)
	elseif soulID == 20010039 then
		return Vector3.New(-176, 158, 0)
	elseif soulID == 20010040 then
		return Vector3.New(-195, 218, 0)
	elseif soulID == 20010041 then
		return Vector3.New(-177, 150, 0)
	elseif soulID == 20010042 then
		return Vector3.New(-185, 116, 0)
	elseif soulID == 20010043 then
		return Vector3.New(-223, 203, 0)
	elseif soulID == 20010044 then
		return Vector3.New(-234, 138, 0)
	elseif soulID == 20010045 then
		return Vector3.New(-195, 242, 0)
	elseif soulID == 20010046 then
		return Vector3.New(-238, 196, 0)
	elseif soulID == 20010047 then
		return Vector3.New(-209, 239, 0)
	elseif soulID == 20010048 then
		return Vector3.New(-198, 169, 0)
	elseif soulID == 20010049 then
		return Vector3.New(-203, 170, 0)
	end

	return Vector3.New(-195, 188, 0)
end

function GirlUIApi:GetFondleTime()
	return 1
end

function GirlUIApi:GetDressViewBtnCloseTxt()
	return self:GetCfgText(1160056)
end

function GirlUIApi:GetDressViewBottomSignWoreTxt()
	return self:GetCfgText(1160057)
end

function GirlUIApi:GetDressShowViewClickDesc()
	return self:GetCfgText(1014077)
end

function GirlUIApi:GetDressViewBtnDressTxt()
	return self:GetCfgText(1160058)
end

function GirlUIApi:GetDressViewSignWoreTxt()
	return self:GetCfgText(1160059)
end

function GirlUIApi:GetDressViewCondition(desc)
	return desc
end

function GirlUIApi:GetDressViewDressName(name)
	return name
end

function GirlUIApi:GetDressViewTitle()
	return self:GetCfgText(1160060)
end

function GirlUIApi:GetTextMoodSpeed(str)
	return string.format(self:GetCfgText(1014061), str)
end

function GirlUIApi:GetTextMoodValue(num, maxNum)
	return string.format(self:GetCfgText(1160053) .. ":" .. "<color=#3e9ada>%s/%s</color>", num, maxNum)
end

function GirlUIApi:GetSoulHeadScale(isSelect)
	if isSelect then
		return Vector3.New(1, 1, 1)
	end

	return Vector3.New(0.9, 0.9, 0.9)
end

function GirlUIApi:GetTextBtnHideList()
	return self:GetCfgText(1103001)
end

function GirlUIApi:GetTextBtnShowList()
	return self:GetCfgText(1103000)
end

function GirlUIApi:GetTextTitleName()
	return self:GetCfgText(1019004)
end

function GirlUIApi:GetTextPerTitle(lock, lv)
	if lock then
		return string.format(self:GetCfgText(1014088), lv)
	else
		return self:GetCfgText(1015201)
	end
end

function GirlUIApi:GetTextPer(str)
	return string.format("%s", str) .. "<size=30>%</size>"
end

function GirlUIApi:GetLoveUpTxt(num)
	return "+" .. num .. self:GetCfgText(1160025)
end

function GirlUIApi:GetTextSpecificSoul(str1, str2)
	return str1 .. self:GetCfgText(1014083) .. str2 .. self:GetCfgText(1014084)
end

function GirlUIApi:GetLabLoveStageTxt(str)
	return string.format(self:GetCfgText(1014081) .. self:GetCfgText(1014082), str)
end

function GirlUIApi:GetUnlockMemoryLv(str)
	return string.format(self:GetCfgText(1014081) .. self:GetCfgText(1014078), str)
end

function GirlUIApi:GetUnlockNewMemoryLv(str)
	return string.format(self:GetCfgText(1014081) .. self:GetCfgText(1014079), str)
end

function GirlUIApi:GetLabFateTitleTxt()
	return self:GetCfgText(1014080)
end

function GirlUIApi:GetLabTouchText(value)
	return self:GetCfgText(1160035) .. value
end

function GirlUIApi:GetLabFavorTitleTxt()
	return self:GetCfgText(1160028)
end

function GirlUIApi:GetLabUpFavorTitleTxt()
	return self:GetCfgText(1160027)
end

function GirlUIApi:GetLabUpPowerTxt()
	return self:GetCfgText(1160026)
end

function GirlUIApi:GetLabUpMaxPowerTxt()
	return self:GetCfgText(1160030)
end

function GirlUIApi:GetFeedback(name)
	return name .. self:GetCfgText(1014086)
end

function GirlUIApi:GetFeedbackTitle()
	return self:GetCfgText(1014087)
end

function GirlUIApi:GetTagTxt()
	return self:GetCfgText(1314429)
end

function GirlUIApi:GetTextBtnCloseGift()
	return self:GetCfgText(2000003)
end

function GirlUIApi:GetLifePowerTitleTxt()
	return self:GetCfgText(1160000)
end

function GirlUIApi:GetCurPowerTxt()
	return self:GetCfgText(1160001)
end

function GirlUIApi:GetNextPowerTxt()
	return self:GetCfgText(1160002)
end

function GirlUIApi:GetLabSendGiftTxt(value)
	if value == 0 then
		return self:GetCfgText(1160029) .. self.TextColor[203] .. value .. self.TextColor[0]
	else
		return self:GetCfgText(1160029) .. self.TextColor[221] .. value .. self.TextColor[0]
	end
end

function GirlUIApi:GetLabBoxGiftRecommendTxt()
	return self:GetCfgText(1160025)
end

function GirlUIApi:GetPresetTxt()
	return self:GetCfgText(1160003)
end

function GirlUIApi:GetGiftSourceTxt()
	return self:GetCfgText(1160004)
end

function GirlUIApi:GetGiftCatTxt()
	return self:GetCfgText(1160005)
end

function GirlUIApi:GetDatingTxt(type)
	if type == 1 then
		return self:GetCfgText(1160007)
	end

	return self:GetCfgText(1160050)
end

function GirlUIApi:GetNewMemoryTxt(type)
	if type == 1 then
		return self:GetCfgText(1160032)
	end

	return self:GetCfgText(1160054)
end

function GirlUIApi:GetMemoryTxt(type)
	if type == 1 then
		return self:GetCfgText(1160031)
	end

	return self:GetCfgText(1160055)
end

function GirlUIApi:GetGiftTxt(type)
	if type == 1 then
		return self:GetCfgText(1160012)
	end

	return self:GetCfgText(1160052)
end

function GirlUIApi:GetClosetTxt()
	return self:GetCfgText(1160011)
end

function GirlUIApi:GetTextBtnSoulLibrary()
	return self:GetCfgText(1019013)
end

function GirlUIApi:GetTextBtnGift()
	return self:GetCfgText(1160009)
end

function GirlUIApi:GetChangeShowSoul()
	return self:GetCfgText(1014085)
end

function GirlUIApi:GetFavorTxt(value)
	return self:GetCfgText(1160014) .. value
end

function GirlUIApi:GetVitalitySourceTxt()
	return self:GetCfgText(1160017)
end

function GirlUIApi:GetUpStr()
	return self:GetCfgText(1160019)
end

function GirlUIApi:GetFavorStr(value)
	return self:GetCfgText(1160021) .. value
end

function GirlUIApi:GetDownloadLabelText(isDownloading)
	if isDownloading then
		return self:GetCfgText(1160038)
	else
		return self:GetCfgText(1160039)
	end
end

GirlUIApi:Init()
