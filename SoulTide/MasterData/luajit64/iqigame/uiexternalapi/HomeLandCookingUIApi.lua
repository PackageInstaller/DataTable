-- chunkname: @IQIGame\\UIExternalApi\\HomeLandCookingUIApi.lua

HomeLandCookingUIApi = BaseLangApi:Extend()

function HomeLandCookingUIApi:Init()
	self:RegisterApi("CameraPosition", self.GetCameraPosition)
	self:RegisterApi("CameraSize", self.GetCameraSize)
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextBtnMenu", self.GetTextBtnMenu)
	self:RegisterApi("TextNow3", self.GetTextNow3)
	self:RegisterApi("TextFinish3", self.GetTextFinish3)
	self:RegisterApi("TextQueueNum", self.GetTextQueueNum)
	self:RegisterApi("TextLock1", self.GetTextLock1)
	self:RegisterApi("TextLock2", self.GetTextLock2)
	self:RegisterApi("TextHelp", self.GetTextHelp)
	self:RegisterApi("TextNow2", self.GetTextNow2)
	self:RegisterApi("TextFinish1", self.GetTextFinish1)
	self:RegisterApi("TextItemName", self.GetTextItemName)
	self:RegisterApi("IconPath", self.GetIconPath)
	self:RegisterApi("PutFullErrorMsg", self.GetPutFullErrorMsg)
	self:RegisterApi("ErrorMsg1", self.GetErrorMsg1)
	self:RegisterApi("ErrorMsg2", self.GetErrorMsg2)
	self:RegisterApi("TextTitleMenu", self.GetTextTitleMenu)
	self:RegisterApi("ErrorMsg3", self.GetErrorMsg3)
	self:RegisterApi("TextBtnCleanCD", self.GetTextBtnCleanCD)
	self:RegisterApi("TextPutViewWait1", self.GetTextPutViewWait1)
	self:RegisterApi("TextPutViewWait2", self.GetTextPutViewWait2)
	self:RegisterApi("TextBtnCancel", self.GetTextBtnCancel)
	self:RegisterApi("TextLockNum", self.GetTextLockNum)
	self:RegisterApi("TextBtnCooking1", self.GetTextBtnCooking1)
	self:RegisterApi("ToggleText", self.GetToggleText)
	self:RegisterApi("TextNull1", self.GetTextNull1)
	self:RegisterApi("WayType", self.GetWayType)
	self:RegisterApi("TextNull2", self.GetTextNull2)
	self:RegisterApi("TextNeed", self.GetTextNeed)
	self:RegisterApi("TextEffect", self.GetTextEffect)
	self:RegisterApi("TextNeedTime", self.GetTextNeedTime)
	self:RegisterApi("TextCondition", self.GetTextCondition)
	self:RegisterApi("TextUnLock", self.GetTextUnLock)
	self:RegisterApi("TextUnlockTime", self.GetTextUnlockTime)
	self:RegisterApi("TextPutDes", self.GetTextPutDes)
	self:RegisterApi("TextMenuName", self.GetTextMenuName)
	self:RegisterApi("TextTip", self.GetTextTip)
	self:RegisterApi("TextBtnUpgrade", self.GetTextBtnUpgrade)
	self:RegisterApi("TextBuildingLvEffect", self.GetTextBuildingLvEffect)
	self:RegisterApi("TextTitle2", self.GetTextTitle2)
	self:RegisterApi("TextBtnMin", self.GetTextBtnMin)
	self:RegisterApi("TextBtnMax", self.GetTextBtnMax)
	self:RegisterApi("TextNumDes", self.GetTextNumDes)
	self:RegisterApi("TextMakingName", self.GetTextMakingName)
	self:RegisterApi("TextBtnGetAll", self.GetTextBtnGetAll)
	self:RegisterApi("TextGetAllTitle", self.GetTextGetAllTitle)
	self:RegisterApi("TextToggleNullDown", self.GetTextToggleNullDown)
	self:RegisterApi("TextToggleNullUp", self.GetTextToggleNullUp)
end

function HomeLandCookingUIApi:GetTextToggleNullUp()
	return self:GetCfgText(1238082)
end

function HomeLandCookingUIApi:GetTextToggleNullDown()
	return self:GetCfgText(1238082)
end

function HomeLandCookingUIApi:GetTextGetAllTitle()
	return self:GetCfgText(1238064)
end

function HomeLandCookingUIApi:GetTextBtnGetAll()
	return self:GetCfgText(1238080)
end

function HomeLandCookingUIApi:GetTextMakingName(name, num)
	return string.format("%s *%s", name, num)
end

function HomeLandCookingUIApi:GetTextNumDes()
	return self:GetCfgText(1238081)
end

function HomeLandCookingUIApi:GetTextBtnMax()
	return "MAX"
end

function HomeLandCookingUIApi:GetTextBtnMin()
	return "MIN"
end

function HomeLandCookingUIApi:GetTextTitle2()
	return self:GetCfgText(1238040)
end

function HomeLandCookingUIApi:GetTextBuildingLvEffect(buildLv)
	if buildLv == 1 then
		return buildLv .. self:GetCfgText(1238041) .. "1%"
	elseif buildLv == 2 then
		return buildLv .. self:GetCfgText(1238041) .. "2%"
	elseif buildLv == 3 then
		return buildLv .. self:GetCfgText(1238041) .. "3%"
	elseif buildLv == 4 then
		return buildLv .. self:GetCfgText(1238041) .. "4%"
	elseif buildLv == 5 then
		return buildLv .. self:GetCfgText(1238041) .. "5%"
	elseif buildLv == 6 then
		return buildLv .. self:GetCfgText(1238041) .. "6%"
	elseif buildLv == 7 then
		return buildLv .. self:GetCfgText(1238041) .. "7%"
	elseif buildLv == 8 then
		return buildLv .. self:GetCfgText(1238041) .. "8%"
	elseif buildLv == 9 then
		return buildLv .. self:GetCfgText(1238041) .. "9%"
	elseif buildLv == 10 then
		return buildLv .. self:GetCfgText(1238041) .. "10%"
	elseif buildLv == 11 then
		return buildLv .. self:GetCfgText(1238041) .. "11%"
	elseif buildLv == 12 then
		return buildLv .. self:GetCfgText(1238041) .. "12%"
	elseif buildLv == 13 then
		return buildLv .. self:GetCfgText(1238041) .. "13%"
	elseif buildLv == 14 then
		return buildLv .. self:GetCfgText(1238041) .. "14%"
	elseif buildLv == 15 then
		return buildLv .. self:GetCfgText(1238041) .. "15%"
	elseif buildLv == 16 then
		return buildLv .. self:GetCfgText(1238041) .. "16%"
	elseif buildLv == 17 then
		return buildLv .. self:GetCfgText(1238041) .. "17%"
	elseif buildLv == 18 then
		return buildLv .. self:GetCfgText(1238041) .. "18%"
	elseif buildLv == 19 then
		return buildLv .. self:GetCfgText(1238041) .. "19%"
	elseif buildLv == 20 then
		return buildLv .. self:GetCfgText(1238041) .. "20%"
	end

	return buildLv .. self:GetCfgText(1238041) .. "20%"
end

function HomeLandCookingUIApi:GetTextBtnUpgrade()
	return self:GetCfgText(1015022)
end

function HomeLandCookingUIApi:GetTextTip(lv)
	if lv == 1 then
		return "1." .. self.TextColor[32] .. self:GetCfgText(1238075) .. self.TextColor[0] .. self:GetCfgText(1238076) .. self.TextColor[32] .. "1级" .. self.TextColor[0] .. self:GetCfgText(1238078) .. self.TextColor[32] .. "1%" .. self.TextColor[0] .. self:GetCfgText(1238079)
	elseif lv == 2 then
		return "1." .. self.TextColor[32] .. self:GetCfgText(1238075) .. self.TextColor[0] .. self:GetCfgText(1238076) .. self.TextColor[32] .. "2级" .. self.TextColor[0] .. self:GetCfgText(1238078) .. self.TextColor[32] .. "2%" .. self.TextColor[0] .. self:GetCfgText(1238079)
	elseif lv == 3 then
		return "1." .. self.TextColor[32] .. self:GetCfgText(1238075) .. self.TextColor[0] .. self:GetCfgText(1238076) .. self.TextColor[32] .. "3级" .. self.TextColor[0] .. self:GetCfgText(1238078) .. self.TextColor[32] .. "3%" .. self.TextColor[0] .. self:GetCfgText(1238079)
	elseif lv == 4 then
		return "1." .. self.TextColor[32] .. self:GetCfgText(1238075) .. self.TextColor[0] .. self:GetCfgText(1238076) .. self.TextColor[32] .. "4级" .. self.TextColor[0] .. self:GetCfgText(1238078) .. self.TextColor[32] .. "4%" .. self.TextColor[0] .. self:GetCfgText(1238079)
	elseif lv == 5 then
		return "1." .. self.TextColor[32] .. self:GetCfgText(1238075) .. self.TextColor[0] .. self:GetCfgText(1238076) .. self.TextColor[32] .. "5级" .. self.TextColor[0] .. self:GetCfgText(1238078) .. self.TextColor[32] .. "5%" .. self.TextColor[0] .. self:GetCfgText(1238079)
	elseif lv == 6 then
		return "1." .. self.TextColor[32] .. self:GetCfgText(1238075) .. self.TextColor[0] .. self:GetCfgText(1238076) .. self.TextColor[32] .. "6级" .. self.TextColor[0] .. self:GetCfgText(1238078) .. self.TextColor[32] .. "6%" .. self.TextColor[0] .. self:GetCfgText(1238079)
	elseif lv == 7 then
		return "1." .. self.TextColor[32] .. self:GetCfgText(1238075) .. self.TextColor[0] .. self:GetCfgText(1238076) .. self.TextColor[32] .. "7级" .. self.TextColor[0] .. self:GetCfgText(1238078) .. self.TextColor[32] .. "7%" .. self.TextColor[0] .. self:GetCfgText(1238079)
	elseif lv == 8 then
		return "1." .. self.TextColor[32] .. self:GetCfgText(1238075) .. self.TextColor[0] .. self:GetCfgText(1238076) .. self.TextColor[32] .. "8级" .. self.TextColor[0] .. self:GetCfgText(1238078) .. self.TextColor[32] .. "8%" .. self.TextColor[0] .. self:GetCfgText(1238079)
	elseif lv == 9 then
		return "1." .. self.TextColor[32] .. self:GetCfgText(1238075) .. self.TextColor[0] .. self:GetCfgText(1238076) .. self.TextColor[32] .. "9级" .. self.TextColor[0] .. self:GetCfgText(1238078) .. self.TextColor[32] .. "9%" .. self.TextColor[0] .. self:GetCfgText(1238079)
	elseif lv == 10 then
		return "1." .. self.TextColor[32] .. self:GetCfgText(1238075) .. self.TextColor[0] .. self:GetCfgText(1238076) .. self.TextColor[32] .. "10级" .. self.TextColor[0] .. self:GetCfgText(1238078) .. self.TextColor[32] .. "10%" .. self.TextColor[0] .. self:GetCfgText(1238079)
	elseif lv == 11 then
		return "1." .. self.TextColor[32] .. self:GetCfgText(1238075) .. self.TextColor[0] .. self:GetCfgText(1238076) .. self.TextColor[32] .. "11级" .. self.TextColor[0] .. self:GetCfgText(1238078) .. self.TextColor[32] .. "11%" .. self.TextColor[0] .. self:GetCfgText(1238079)
	elseif lv == 12 then
		return "1." .. self.TextColor[32] .. self:GetCfgText(1238075) .. self.TextColor[0] .. self:GetCfgText(1238076) .. self.TextColor[32] .. "12级" .. self.TextColor[0] .. self:GetCfgText(1238078) .. self.TextColor[32] .. "12%" .. self.TextColor[0] .. self:GetCfgText(1238079)
	elseif lv == 13 then
		return "1." .. self.TextColor[32] .. self:GetCfgText(1238075) .. self.TextColor[0] .. self:GetCfgText(1238076) .. self.TextColor[32] .. "13级" .. self.TextColor[0] .. self:GetCfgText(1238078) .. self.TextColor[32] .. "13%" .. self.TextColor[0] .. self:GetCfgText(1238079)
	elseif lv == 14 then
		return "1." .. self.TextColor[32] .. self:GetCfgText(1238075) .. self.TextColor[0] .. self:GetCfgText(1238076) .. self.TextColor[32] .. "14级" .. self.TextColor[0] .. self:GetCfgText(1238078) .. self.TextColor[32] .. "14%" .. self.TextColor[0] .. self:GetCfgText(1238079)
	elseif lv == 15 then
		return "1." .. self.TextColor[32] .. self:GetCfgText(1238075) .. self.TextColor[0] .. self:GetCfgText(1238076) .. self.TextColor[32] .. "15级" .. self.TextColor[0] .. self:GetCfgText(1238078) .. self.TextColor[32] .. "15%" .. self.TextColor[0] .. self:GetCfgText(1238079)
	elseif lv == 16 then
		return "1." .. self.TextColor[32] .. self:GetCfgText(1238075) .. self.TextColor[0] .. self:GetCfgText(1238076) .. self.TextColor[32] .. "16级" .. self.TextColor[0] .. self:GetCfgText(1238078) .. self.TextColor[32] .. "16%" .. self.TextColor[0] .. self:GetCfgText(1238079)
	elseif lv == 17 then
		return "1." .. self.TextColor[32] .. self:GetCfgText(1238075) .. self.TextColor[0] .. self:GetCfgText(1238076) .. self.TextColor[32] .. "17级" .. self.TextColor[0] .. self:GetCfgText(1238078) .. self.TextColor[32] .. "17%" .. self.TextColor[0] .. self:GetCfgText(1238079)
	elseif lv == 18 then
		return "1." .. self.TextColor[32] .. self:GetCfgText(1238075) .. self.TextColor[0] .. self:GetCfgText(1238076) .. self.TextColor[32] .. "18级" .. self.TextColor[0] .. self:GetCfgText(1238078) .. self.TextColor[32] .. "18%" .. self.TextColor[0] .. self:GetCfgText(1238079)
	elseif lv == 19 then
		return "1." .. self.TextColor[32] .. self:GetCfgText(1238075) .. self.TextColor[0] .. self:GetCfgText(1238076) .. self.TextColor[32] .. "19级" .. self.TextColor[0] .. self:GetCfgText(1238078) .. self.TextColor[32] .. "19%" .. self.TextColor[0] .. self:GetCfgText(1238079)
	elseif lv == 20 then
		return "1." .. self.TextColor[32] .. self:GetCfgText(1238075) .. self.TextColor[0] .. self:GetCfgText(1238076) .. self.TextColor[32] .. "20级" .. self.TextColor[0] .. self:GetCfgText(1238078) .. self.TextColor[32] .. "20%" .. self.TextColor[0] .. self:GetCfgText(1238079)
	end

	return "1." .. self.TextColor[32] .. self:GetCfgText(1238075) .. self.TextColor[0] .. self:GetCfgText(1238076) .. self.TextColor[32] .. self:GetCfgText(1238077) .. self.TextColor[0] .. self:GetCfgText(1238078) .. self.TextColor[32] .. "24%" .. self.TextColor[0] .. self:GetCfgText(1238079)
end

function HomeLandCookingUIApi:GetTextMenuName(isSelect, str)
	if isSelect then
		return str
	end

	return str
end

function HomeLandCookingUIApi:GetTextPutDes()
	return self:GetCfgText(1238042)
end

function HomeLandCookingUIApi:GetTextUnlockTime()
	return self:GetCfgText(1238043)
end

function HomeLandCookingUIApi:GetTextUnLock(lv)
	return string.format(self:GetCfgText(1238068), lv)
end

function HomeLandCookingUIApi:GetTextCondition(top)
	if top == false then
		return self:GetCfgText(1238044)
	end

	return self:GetCfgText(1238045)
end

function HomeLandCookingUIApi:GetTextNeedTime(str)
	return self:GetCfgText(1238069) .. "：" .. "<color=#90d9fe>" .. "<size=25>" .. str .. "</size>" .. "</color>"
end

function HomeLandCookingUIApi:GetTextEffect(str)
	return self:GetCfgText(1238070) .. "：" .. str
end

function HomeLandCookingUIApi:GetTextNeed(str)
	return self:GetCfgText(1238071) .. "：" .. str
end

function HomeLandCookingUIApi:GetTextNull2()
	return self:GetCfgText(1238046)
end

function HomeLandCookingUIApi:GetWayType(type)
	if type == 1 then
		return self:GetCfgText(1238047)
	elseif type == 2 then
		return self:GetCfgText(1238048)
	elseif type == 3 then
		return self:GetCfgText(1238049)
	end

	return ""
end

function HomeLandCookingUIApi:GetTextNull1()
	return self:GetCfgText(1238050)
end

function HomeLandCookingUIApi:GetToggleText()
	return self:GetCfgText(1238051)
end

function HomeLandCookingUIApi:GetTextBtnCooking1()
	return self:GetCfgText(1238083)
end

function HomeLandCookingUIApi:GetTextLockNum(num1, num2)
	return num1 .. "/" .. num2
end

function HomeLandCookingUIApi:GetTextBtnCancel()
	return self:GetCfgText(1238052)
end

function HomeLandCookingUIApi:GetTextPutViewWait2()
	return self:GetCfgText(1238053)
end

function HomeLandCookingUIApi:GetTextPutViewWait1()
	return self:GetCfgText(1238054)
end

function HomeLandCookingUIApi:GetTextBtnCleanCD()
	return self:GetCfgText(1238055)
end

function HomeLandCookingUIApi:GetErrorMsg3()
	return self:GetCfgText(1238056)
end

function HomeLandCookingUIApi:GetTextTitleMenu(isEng)
	if isEng then
		return self:GetCfgText(1238057)
	end

	return self:GetCfgText(1238058)
end

function HomeLandCookingUIApi:GetErrorMsg2()
	return self:GetCfgText(1238059)
end

function HomeLandCookingUIApi:GetErrorMsg1()
	return self:GetCfgText(1238060)
end

function HomeLandCookingUIApi:GetPutFullErrorMsg()
	return self:GetCfgText(1238061)
end

function HomeLandCookingUIApi:GetIconPath()
	return self:GetResUrl(3004001)
end

function HomeLandCookingUIApi:GetTextItemName()
	return self:GetCfgText(1238043)
end

function HomeLandCookingUIApi:GetTextNow2(str)
	return self:GetCfgText(1238072) .. "<color=#9CFF70>" .. str .. "</color>"
end

function HomeLandCookingUIApi:GetTextHelp(num1, num2)
	return num1 .. "/<Size=20>" .. num2 .. self:GetCfgText(1238073) .. "</Size>"
end

function HomeLandCookingUIApi:GetTextLock2()
	return self:GetCfgText(1238062)
end

function HomeLandCookingUIApi:GetTextLock1()
	return self:GetCfgText(1238063)
end

function HomeLandCookingUIApi:GetTextQueueNum(num1, num2)
	return self.TextColor[12] .. "<Size=24>" .. num1 .. "</Size>" .. self.TextColor[0] .. self.TextColor[213] .. "/" .. num2 .. self:GetCfgText(1238074) .. self.TextColor[0]
end

function HomeLandCookingUIApi:GetTextFinish3()
	return self:GetCfgText(1238064)
end

function HomeLandCookingUIApi:GetTextFinish1()
	return self:GetCfgText(1238065)
end

function HomeLandCookingUIApi:GetTextNow3()
	return self:GetCfgText(1238066)
end

function HomeLandCookingUIApi:GetTextBtnMenu()
	return self:GetCfgText(1238067)
end

function HomeLandCookingUIApi:GetTextTitle(name, lv)
	return string.format("%s <Size=16>Lv.%s</Size>", name, lv)
end

function HomeLandCookingUIApi:GetCameraSize()
	return 1.8
end

function HomeLandCookingUIApi:GetCameraPosition(lv, suitCid)
	if suitCid == 70100 then
		if lv == 1 or lv == 2 or lv == 3 or lv == 4 or lv == 0 then
			return Vector3.New(-49.9, -20.4, -100)
		elseif lv == 5 or lv == 6 or lv == 7 or lv == 8 then
			return Vector3.New(-49.9, -20.9, -100)
		elseif lv == 9 or lv == 10 or lv == 11 or lv == 12 then
			return Vector3.New(-49.9, -20.4, -100)
		elseif lv == 13 or lv == 14 or lv == 15 or lv == 16 then
			return Vector3.New(-49.9, -20.4, -100)
		elseif lv == 17 or lv == 18 or lv == 19 or lv == 20 then
			return Vector3.New(-49.9, -20.4, -100)
		end

		return Vector3.New(-49.9, -20.4, -100)
	elseif suitCid == 70200 then
		if lv == 1 or lv == 2 or lv == 3 or lv == 4 or lv == 0 then
			return Vector3.New(-49.9, -20.43, -100)
		elseif lv == 5 or lv == 6 or lv == 7 or lv == 8 then
			return Vector3.New(-49.9, -20.43, -100)
		elseif lv == 9 or lv == 10 or lv == 11 or lv == 12 then
			return Vector3.New(-49.9, -20.43, -100)
		elseif lv == 13 or lv == 14 or lv == 15 or lv == 16 then
			return Vector3.New(-49.9, -20.43, -100)
		elseif lv == 17 or lv == 18 or lv == 19 or lv == 20 then
			return Vector3.New(-49.9, -20.45, -100)
		end

		return Vector3.New(-49.9, -20.43, -100)
	elseif suitCid == 70400 then
		if lv == 1 or lv == 2 or lv == 3 or lv == 4 or lv == 0 then
			return Vector3.New(-49.9, -19.8, -100)
		elseif lv == 5 or lv == 6 or lv == 7 or lv == 8 then
			return Vector3.New(-49.9, -19.8, -100)
		elseif lv == 9 or lv == 10 or lv == 11 or lv == 12 then
			return Vector3.New(-49.9, -19.8, -100)
		elseif lv == 13 or lv == 14 or lv == 15 or lv == 16 then
			return Vector3.New(-49.9, -19.8, -100)
		elseif lv == 17 or lv == 18 or lv == 19 or lv == 20 then
			return Vector3.New(-49.9, -19.8, -100)
		end

		return Vector3.New(-49.9, -19.8, -100)
	end

	return Vector3.New(-49.51, -20.4, -100)
end

HomeLandCookingUIApi:Init()
