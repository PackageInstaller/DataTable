-- chunkname: @IQIGame\\UIExternalApi\\MiscApi.lua

MiscApi = BaseLangApi:Extend()

function MiscApi:Init()
	self:RegisterApi("SoulClass", self.GetSoulClassTxt)
	self:RegisterApi("SoulClassBgImage", self.GetSoulClassBgImage)
	self:RegisterApi("SoulDamageType", self.GetSoulDamageTypeTxt)
	self:RegisterApi("SoulDamageTypeIcon", self.GetSoulDamageTypeIcon)
	self:RegisterApi("SoulMoodImagePath", self.GetSoulMoodImagePath)
	self:RegisterApi("SoulWorkStatusText", self.GetSoulWorkStatusText)
	self:RegisterApi("SoulClassMixIconPath", self.GetSoulClassMixIconPath)
	self:RegisterApi("SkillTag", self.GetSkillTagTxt)
	self:RegisterApi("SkillTagBgImage", self.GetSkillTagBgImage)
	self:RegisterApi("MonsterResType", self.GetMonsterResType)
	self:RegisterApi("PositionType", self.GetPositionType)
	self:RegisterApi("OnlineText", self.GetOnlineText)
	self:RegisterApi("BuffBg", self.GetBuffBg)
	self:RegisterApi("BuffArrow", self.GetBuffArrow)
	self:RegisterApi("FunctionUserOpUnlockMazeName", self.GetFunctionUserOpUnlockMazeName)
	self:RegisterApi("UserProtocolNameText", self.GetUserProtocolNameText)
	self:RegisterApi("PrivacyPolicyNameText", self.GetPrivacyPolicyNameText)
	self:RegisterApi("ChildPrivacyNameText", self.GetChildPrivacyNameText)
	self:RegisterApi("UserProtocolUrl", self.GetUserProtocolUrl)
	self:RegisterApi("PrivacyPolicyUrl", self.GetPrivacyPolicyUrl)
	self:RegisterApi("ChildPrivacyUrl", self.GetChildPrivacyUrl)
	self:RegisterApi("moneySign", self.GetMoneySign)
	self:RegisterApi("GlobalGetSoulHeadQualityPath", self.GetGlobalGetSoulHeadQualityPath)
	self:RegisterApi("GlobalGetSkillQualityBottomPath", self.GetGlobalGetSkillQualityBottomPath)
	self:RegisterApi("DailySupplyEnergyTopLimit", self.GetDailySupplyEnergyTopLimit)
	self:RegisterApi("SoulClassIconForTip", self.GetSoulClassIconForTip)
	self:RegisterApi("SoulDamageTypeIconForTip", self.GetSoulDamageTypeIconForTip)
	self:RegisterApi("SoulPowerSourceIconForTip", self.GetSoulPowerSourceIconForTip)
	self:RegisterApi("MonsterIconForTip", self.GetMonsterIconForTip)
	self:RegisterApi("SoulClassDesc", self.GetSoulClassDesc)
	self:RegisterApi("SoulDamageDesc", self.GetSoulDamageDesc)
	self:RegisterApi("SoulPowerSourceDesc", self.GetSoulPowerSourceDesc)
	self:RegisterApi("MonsterDesc", self.GetMonsterDesc)
	self:RegisterApi("MonsterElementCellMainLabel", self.GetMonsterElementCellMainLabel)
	self:RegisterApi("FadeDuration", self.GetComExcessiveFadeDuration)
	self:RegisterApi("EndlessMazeDifficultyText", self.GetEndlessMazeDifficultyText)
	self:RegisterApi("equipClassTxt", self.GetEquipClassTxt)
	self:RegisterApi("equipClassIcon", self.GetEquipClassIcon)
	self:RegisterApi("IsHour12", self.GetIsHour12)
	self:RegisterApi("FinalTimeFormat", self.GetFinalTimeFormat)
	self:RegisterApi("DateTimeFormat", self.GetDateTimeFormat)
	self:RegisterApi("DateTimeFormatM", self.GetDateTimeFormatM)
	self:RegisterApi("DateFormat", self.GetDateFormat)
	self:RegisterApi("TimeFormat", self.GetTimeFormat)
	self:RegisterApi("MonthFormat", self.GetMonthFormat)
	self:RegisterApi("YearFormat", self.GetYearFormat)
	self:RegisterApi("WeekFormat", self.GetWeekFormat)
	self:RegisterApi("OnlyDateFormat", self.GetOnlyDateFormat)
	self:RegisterApi("HourFormat", self.GetHourFormat)
	self:RegisterApi("HourMinuteFormat", self.GetHourMinuteFormat)
	self:RegisterApi("MonthToMinuteFormat", self.GetMonthToMinuteFormat)
	self:RegisterApi("SoulSpine_IdleInterval", self.GetSoulSpineIdleInterval)
	self:RegisterApi("SoulSpine_MorningTime", self.GetSoulSpineMorningTime)
	self:RegisterApi("SoulSpine_NoonTime", self.GetSoulSpineNoonTime)
	self:RegisterApi("SoulSpine_NightTime", self.GetSoulSpineNightTime)
end

function MiscApi:GetSoulSpineIdleInterval()
	return 30
end

function MiscApi:GetSoulSpineMorningTime()
	return {
		"06:00:00",
		"10:00:00"
	}
end

function MiscApi:GetSoulSpineNoonTime()
	return {
		"10:00:00",
		"18:00:00"
	}
end

function MiscApi:GetSoulSpineNightTime()
	return {
		"18:00:00",
		"24:00:00",
		"00:00:00",
		"06:00:00"
	}
end

function MiscApi:GetMoneySign()
	return "￥"
end

function MiscApi:GetGlobalGetSoulHeadQualityPath(woreSpecialEquip)
	if woreSpecialEquip then
		return self:GetResUrl(2400001)
	else
		return self:GetResUrl(2400002)
	end
end

function MiscApi:GetGlobalGetSkillQualityBottomPath(quality)
	if quality then
		return self:GetResUrl(4000001)
	end
end

function MiscApi:GetEquipClassIcon(type)
	if type == 1 then
		return self:GetResUrl(1900001)
	elseif type == 2 then
		return self:GetResUrl(1900001)
	elseif type == 3 then
		return self:GetResUrl(1900003)
	elseif type == 4 then
		return self:GetResUrl(1900004)
	elseif type == 5 then
		return self:GetResUrl(1900003)
	end
end

function MiscApi:GetEquipClassTxt(type)
	if type == 1 then
		return self:GetCfgText(1318021)
	elseif type == 2 then
		return self:GetCfgText(1318022)
	elseif type == 3 then
		return self:GetCfgText(1318023)
	elseif type == 4 then
		return self:GetCfgText(1318026)
	else
		return ""
	end
end

function MiscApi:GetEndlessMazeDifficultyText(mazeCid)
	if mazeCid == 25030001 then
		return self:GetCfgText(1150028)
	elseif mazeCid == 25030002 then
		return self:GetCfgText(1150029)
	elseif mazeCid == 25030003 then
		return self:GetCfgText(1213003)
	elseif mazeCid == 25030004 then
		return self:GetCfgText(1318027)
	elseif mazeCid == 25030005 then
		return self:GetCfgText(1150030)
	else
		return "--"
	end
end

function MiscApi:GetComExcessiveFadeDuration()
	return 0.17
end

function MiscApi:GetPositionType(type)
	if type == 1 then
		return self:GetCfgText(1318001)
	elseif type == 2 then
		return self:GetCfgText(1318002)
	end

	return ""
end

function MiscApi:GetMonsterResType(type)
	if type == 0 then
		return self:GetResUrl(1400003)
	elseif type == 1 then
		return self:GetResUrl(1400001)
	elseif type == 2 then
		return self:GetResUrl(1400002)
	elseif type == 3 then
		return self:GetResUrl(1400004)
	elseif type == 4 then
		return self:GetResUrl(1400005)
	elseif type == 5 then
		return self:GetResUrl(1400005)
	end
end

function MiscApi:GetSoulClassTxt(type)
	if type == 1 then
		return self:GetCfgText(1318021)
	elseif type == 2 then
		return self:GetCfgText(1318022)
	elseif type == 3 then
		return self:GetCfgText(1318023)
	elseif type == 4 then
		return self:GetCfgText(1318024)
	end
end

function MiscApi:GetSoulClassBgImage(type)
	if type == 1 then
		return self:GetResUrl(1900011)
	elseif type == 2 then
		return self:GetResUrl(1900013)
	elseif type == 3 then
		return self:GetResUrl(1900012)
	elseif type == 4 then
		return self:GetResUrl(1900014)
	else
		return self:GetResUrl(1900014)
	end
end

function MiscApi:GetSkillTagTxt(tag)
	if tag == 1 then
		return self:GetCfgText(2200030)
	elseif tag == 2 then
		return self:GetCfgText(2200031)
	elseif tag == 3 then
		return self:GetCfgText(1318037)
	elseif tag == 4 then
		return self:GetCfgText(1318022)
	elseif tag == 5 then
		return self:GetCfgText(1318023)
	elseif tag == 6 then
		return self:GetCfgText(1318029)
	elseif tag == 7 then
		return self:GetCfgText(2200032)
	elseif tag == 8 then
		return self:GetCfgText(2200025)
	elseif tag == 9 then
		return self:GetCfgText(2200036)
	elseif tag == 10 then
		return self:GetCfgText(1318034)
	elseif tag == 11 then
		return self:GetCfgText(1318035)
	elseif tag == 12 then
		return self:GetCfgText(1318033)
	elseif tag == 13 then
		return self:GetCfgText(1318031)
	elseif tag == 14 then
		return self:GetCfgText(1318032)
	end
end

function MiscApi:GetSkillTagBgImage(type)
	return self:GetResUrl(1900014)
end

function MiscApi:GetSoulDamageTypeTxt(type)
	if type == 1 then
		return self:GetCfgText(1318031)
	elseif type == 2 then
		return self:GetCfgText(1318032)
	elseif type == 3 then
		return self:GetCfgText(1318033)
	elseif type == 5 then
		return self:GetCfgText(1318034)
	elseif type == 6 then
		return self:GetCfgText(1318035)
	elseif type == 7 then
		return self:GetCfgText(1318036)
	elseif type == 99 then
		return self:GetCfgText(1318024)
	end
end

function MiscApi:GetSoulClassMixIconPath(type)
	if type == 1 then
		return self:GetResUrl(1900015)
	elseif type == 2 then
		return self:GetResUrl(1900016)
	elseif type == 3 then
		return self:GetResUrl(1900017)
	elseif type == 4 then
		return self:GetResUrl(1900018)
	elseif type == 5 then
		return self:GetResUrl(1900019)
	elseif type == 6 then
		return self:GetResUrl(1900020)
	end
end

function MiscApi:GetSoulDamageTypeIcon(type, useBlack)
	local iconName

	if type == 1 then
		if useBlack then
			return self:GetResUrl(1400002)
		else
			return self:GetResUrl(1400002)
		end
	elseif type == 2 then
		if useBlack then
			return self:GetResUrl(1400005)
		else
			return self:GetResUrl(1400005)
		end
	elseif type == 3 then
		if useBlack then
			return self:GetResUrl(1400004)
		else
			return self:GetResUrl(1400004)
		end
	elseif type == 5 then
		if useBlack then
			return self:GetResUrl(1400003)
		else
			return self:GetResUrl(1400003)
		end
	elseif type == 6 then
		if useBlack then
			return self:GetResUrl(1400001)
		else
			return self:GetResUrl(1400001)
		end
	elseif type == 7 then
		if useBlack then
			return self:GetResUrl(1400003)
		else
			return self:GetResUrl(1400003)
		end
	elseif type == 99 then
		if useBlack then
			return self:GetResUrl(1400003)
		else
			return self:GetResUrl(1400003)
		end
	end
end

function MiscApi:GetSoulMoodImagePath(status)
	if status == 1 then
		return self:GetResUrl(1200003)
	elseif status == 2 then
		return self:GetResUrl(1200002)
	elseif status == 3 then
		return self:GetResUrl(1200001)
	end
end

function MiscApi:GetSoulWorkStatusText()
	return self:GetCfgText(1318028)
end

function MiscApi:GetSoulClassIconForTip(type)
	if type == 1 then
		return self:GetResUrl(1900001)
	elseif type == 2 then
		return self:GetResUrl(1900003)
	elseif type == 3 then
		return self:GetResUrl(1900004)
	elseif type == 4 then
		return self:GetResUrl(1900006)
	end
end

function MiscApi:GetSoulDamageTypeIconForTip(type)
	return MiscApi:GetString("SoulDamageTypeIcon", type, true)
end

function MiscApi:GetSoulPowerSourceIconForTip(type)
	if type == 1 then
		return self:GetResUrl(1900007)
	elseif type == 2 then
		return self:GetResUrl(1900008)
	elseif type == 3 then
		return self:GetResUrl(1900009)
	elseif type == 4 then
		return self:GetResUrl(1900010)
	end
end

function MiscApi:GetMonsterIconForTip(type)
	if type == 0 then
		return self:GetResUrl(1900021)
	elseif type == 1 then
		return self:GetResUrl(1400006)
	elseif type == 2 then
		return self:GetResUrl(1400007)
	elseif type == 3 then
		return self:GetResUrl(1400008)
	elseif type == 4 then
		return self:GetResUrl(1400009)
	elseif type == 5 then
		return self:GetResUrl(1400010)
	elseif type == 6 then
		return self:GetResUrl(1400011)
	end
end

function MiscApi:GetSoulClassDesc(type)
	if type == 1 then
		return self:GetCfgText(1318041)
	elseif type == 2 then
		return self:GetCfgText(1318042)
	elseif type == 3 then
		return self:GetCfgText(1318043)
	elseif type == 4 then
		return self:GetCfgText(1318044)
	end
end

function MiscApi:GetSoulDamageDesc(type)
	if type == 1 then
		return self:GetCfgText(1318051)
	elseif type == 2 then
		return self:GetCfgText(1318052)
	elseif type == 3 then
		return self:GetCfgText(1318053)
	elseif type == 5 then
		return self:GetCfgText(1318054)
	elseif type == 6 then
		return self:GetCfgText(1318055)
	elseif type == 7 then
		return self:GetCfgText(1318056)
	elseif type == 99 then
		return self:GetCfgText(1318057)
	end
end

function MiscApi:GetSoulPowerSourceDesc(type)
	if type == 1 then
		return self:GetCfgText(1318061)
	elseif type == 2 then
		return self:GetCfgText(1318062)
	elseif type == 3 then
		return self:GetCfgText(1318063)
	elseif type == 4 then
		return self:GetCfgText(1318064)
	end
end

function MiscApi:GetMonsterDesc(type)
	if type == 0 then
		return self:GetCfgText(1318071)
	elseif type == 1 then
		return self:GetCfgText(1318072)
	elseif type == 2 then
		return self:GetCfgText(1318073)
	elseif type == 3 then
		return self:GetCfgText(1318074)
	elseif type == 4 then
		return self:GetCfgText(1318075)
	elseif type == 5 then
		return self:GetCfgText(1318076)
	elseif type == 6 then
		return self:GetCfgText(1318077)
	end
end

function MiscApi:GetOnlineText()
	return self:GetCfgText(232)
end

function MiscApi:GetBuffBg(tags)
	if table.indexOf(tags, 21) ~= -1 then
		return self:GetResUrl(1900023)
	elseif table.indexOf(tags, 22) ~= -1 then
		return self:GetResUrl(1900022)
	end

	return nil
end

function MiscApi:GetBuffArrow(tags)
	if table.indexOf(tags, 14) ~= -1 then
		return self:GetResUrl(1900025)
	elseif table.indexOf(tags, 15) ~= -1 then
		return self:GetResUrl(1900024)
	end

	return nil
end

function MiscApi:GetFunctionUserOpUnlockMazeName(chapterName, chapterOrder, mazeName, mazeOrder)
	local orderStr = ""

	if mazeOrder ~= 0 and chapterOrder == 1 then
		if mazeOrder <= 3 then
			orderStr = "0-" .. mazeOrder
		else
			orderStr = chapterOrder .. "-" .. mazeOrder - 3
		end
	end

	return chapterName .. orderStr
end

function MiscApi:GetUserProtocolNameText()
	return self:GetCfgText(1009037)
end

function MiscApi:GetPrivacyPolicyNameText()
	return self:GetCfgText(1009038)
end

function MiscApi:GetChildPrivacyNameText()
	return self:GetCfgText(1009040)
end

function MiscApi:GetUserProtocolUrl()
	return "http://cdn-sdk.iqigame.com/iqisdk/agreement/%E9%AC%BC%E8%84%B8%E6%B8%B8%E6%88%8F%E7%94%A8%E6%88%B7%E5%8D%8F%E8%AE%AE.html"
end

function MiscApi:GetPrivacyPolicyUrl()
	return "http://cdn-sdk.iqigame.com/iqisdk/agreement/%E9%AC%BC%E8%84%B8%E4%B8%AA%E4%BA%BA%E4%BF%A1%E6%81%AF%E4%BF%9D%E6%8A%A4%E6%94%BF%E7%AD%96.html"
end

function MiscApi:GetChildPrivacyUrl()
	return "http://cdn-sdk.iqigame.com/iqisdk/agreement/%E5%84%BF%E7%AB%A5%E4%B8%AA%E4%BA%BA%E4%BF%A1%E6%81%AF%E4%BF%9D%E6%8A%A4%E6%94%BF%E7%AD%96.html"
end

function MiscApi:GetIsHour12()
	return false
end

function MiscApi:GetFinalTimeFormat(formatStr, hasAmOrPm, isAm)
	if hasAmOrPm then
		local ext

		ext = isAm and " AM" or " PM"

		return formatStr .. ext
	else
		return formatStr
	end
end

function MiscApi:GetDateTimeFormat(isH12)
	if isH12 then
		return "!%Y-%m-%d %I:%M:%S", isH12
	end

	return "!%Y-%m-%d %H:%M:%S"
end

function MiscApi:GetDateTimeFormatM(isH12)
	if isH12 then
		return "!%Y-%m-%d %I:%M", isH12
	end

	return "!%Y-%m-%d %H:%M"
end

function MiscApi:GetDateFormat(isH12)
	return "!%Y-%m-%d"
end

function MiscApi:GetTimeFormat(isH12)
	if isH12 then
		return "!%I:%M:%S", isH12
	end

	return "!%H:%M:%S"
end

function MiscApi:GetYearFormat(isH12)
	return "!%Y"
end

function MiscApi:GetMonthFormat(isH12)
	return "!%m"
end

function MiscApi:GetWeekFormat(isH12)
	return "!%w"
end

function MiscApi:GetOnlyDateFormat(isH12)
	return "!%d"
end

function MiscApi:GetHourFormat(isH12)
	if isH12 then
		return "!%I", isH12
	end

	return "!%H"
end

function MiscApi:GetHourMinuteFormat(isH12)
	if isH12 then
		return "!%I:%M", isH12
	end

	return "!%H:%M"
end

function MiscApi:GetMonthToMinuteFormat(isH12)
	if isH12 then
		return "!%m-%d %I:%M", isH12
	end

	return "!%m-%d %H:%M"
end

function MiscApi:GetMonsterElementCellMainLabel()
	return self:GetCfgText(1318030)
end

function MiscApi:GetDailySupplyEnergyTopLimit()
	return 500
end

MiscApi:Init()
