-- chunkname: @IQIGame\\UIExternalApi\\HomeLandChooseCastleApi.lua

HomeLandChooseCastleApi = BaseLangApi:Extend()

function HomeLandChooseCastleApi:Init()
	self:RegisterApi("TextBtnLock", self.SetTextBtnLock)
	self:RegisterApi("TextBtnTheme", self.GetTextBtnTheme)
	self:RegisterApi("TextTitle", self.SetTextTitle)
	self:RegisterApi("RoomFunBtnText", self.GetRoomFunBtnText)
	self:RegisterApi("VisitFunBtnText", self.GetVisitFunBtnText)
	self:RegisterApi("TextCondition", self.GetTextCondition)
	self:RegisterApi("TextBtnNoReached", self.GetTextBtnNoReached)
	self:RegisterApi("TextError1", self.GetTextError1)
	self:RegisterApi("TextError2", self.GetTextError2)
	self:RegisterApi("GoHomeFunBtnText", self.GetGoHomeFunBtnText)
	self:RegisterApi("VisitNextFriendText", self.GetVisitNextFriendText)
	self:RegisterApi("TextVisitHomeLandName", self.GetTextVisitHomeLandName)
	self:RegisterApi("HelpTextTitle", self.GetHelpTextTitle)
	self:RegisterApi("HelpTextMsg1", self.GetHelpTextMsg1)
	self:RegisterApi("HelpTextMsg2", self.GetHelpTextMsg2)
	self:RegisterApi("TreasureTextTitle", self.GetTreasureTextTitle)
	self:RegisterApi("TreasureTextMsg1", self.GetTreasureTextMsg1)
	self:RegisterApi("TreasureTextMsg2", self.GetTreasureTextMsg2)
	self:RegisterApi("TextShowCount", self.TextShowCount)
	self:RegisterApi("ImgLockPath", self.GetImgLockPath)
	self:RegisterApi("ImgThemePath", self.GetImgThemePath)
	self:RegisterApi("TextBtnFunction", self.GetTextBtnFunction)
	self:RegisterApi("ImgBtnFunctionPath", self.GetImgBtnFunctionPath)
	self:RegisterApi("ImgBuildBubbleBgPath", self.GetImgBuildBubbleBgPath)
	self:RegisterApi("ImgBuildBubbleIconPath", self.GetImgBuildBubbleIconPath)
	self:RegisterApi("ImgBuildBubbleWorkPath", self.GetImgBuildBubbleWorkPath)
	self:RegisterApi("TextBtnBackGift", self.GetTextBtnBackGift)
	self:RegisterApi("ImgBtnBackGiftPath", self.GetImgBtnBackGiftPath)
	self:RegisterApi("QuitCameraPosition", self.GetQuitCameraPosition)
	self:RegisterApi("QuitCameraSize", self.GetQuitCameraSize)
	self:RegisterApi("FunctionBuildGuideSize", self.GetFunctionBuildGuideSize)
	self:RegisterApi("UnlockRoomPanelBGM", self.GetUnlockRoomPanelBGM)
	self:RegisterApi("OverviewBtnText", self.GetOverviewBtnText)
	self:RegisterApi("ShopBtnText", self.GetShopBtnText)
	self:RegisterApi("FishBtnText", self.GetFishBtnText)
end

function HomeLandChooseCastleApi:GetFishBtnText()
	return self:GetCfgText(1015742)
end

function HomeLandChooseCastleApi:GetShopBtnText()
	return self:GetCfgText(1109033)
end

function HomeLandChooseCastleApi:GetOverviewBtnText()
	return self:GetCfgText(1016016)
end

function HomeLandChooseCastleApi:GetUnlockRoomPanelBGM()
	return 10341
end

function HomeLandChooseCastleApi:GetFunctionBuildGuideSize(functionBuilding)
	local size = Vector2.New(40, 40)
	local offPosition = Vector3.New(0, 0, 0)

	if functionBuilding == Constant.HomelandBuildType.BuildGold then
		-- block empty
	elseif functionBuilding == Constant.HomelandBuildType.BuildManufacture then
		size = Vector2.New(30, 30)
		offPosition = Vector3.New(-0.2, 0, 0)
	elseif functionBuilding == Constant.HomelandBuildType.BuildPlant then
		size = Vector2.New(20, 10)
	elseif functionBuilding == Constant.HomelandBuildType.BuildDutyBoard then
		-- block empty
	elseif functionBuilding == Constant.HomelandBuildType.BuildCooking then
		size = Vector2.New(40, 16)
		offPosition = Vector3.New(0, 0.4, 0)
	elseif functionBuilding == Constant.HomelandBuildType.BuildWork then
		-- block empty
	elseif functionBuilding == Constant.HomelandBuildType.BuildBackGift then
		size = Vector2.New(20, 22)
		offPosition = Vector3.New(0, 0.2, 0)
	end

	return size, offPosition
end

function HomeLandChooseCastleApi:GetQuitCameraSize()
	return 34
end

function HomeLandChooseCastleApi:GetQuitCameraPosition()
	return Vector3.New(-0.44, 0, -47)
end

function HomeLandChooseCastleApi:GetImgBtnBackGiftPath()
	return self:GetResUrl(3002001)
end

function HomeLandChooseCastleApi:GetTextBtnBackGift()
	return self:GetCfgText(1015520)
end

function HomeLandChooseCastleApi:GetImgBuildBubbleWorkPath()
	return self:GetResUrl(3002007)
end

function HomeLandChooseCastleApi:GetImgBuildBubbleIconPath(buildId)
	if buildId == 36000001 then
		return self:GetResUrl(3002004)
	elseif buildId == 36000002 then
		return self:GetResUrl(3002007)
	elseif buildId == 36000003 then
		return self:GetResUrl(3002005)
	elseif buildId == 36000005 then
		return self:GetResUrl(3002006)
	elseif buildId == 36000006 then
		return self:GetResUrl(3002004)
	end

	return self:GetResUrl(3002004)
end

function HomeLandChooseCastleApi:GetImgBuildBubbleBgPath(type)
	local path = UIGlobalApi.GetImagePath("/Home/HomeUI/UI/HomeLandChooseCastleUI_Image_87.png")

	if type == 1 then
		return self:GetResUrl(3002002)
	elseif type == 2 then
		return self:GetResUrl(3002003)
	end

	return self:GetResUrl(3002002)
end

function HomeLandChooseCastleApi:GetTextBtnFunction(buildId)
	if buildId == 36000001 then
		return self:GetCfgText(1015521)
	elseif buildId == 36000002 then
		return self:GetCfgText(1015522)
	elseif buildId == 36000005 then
		return self:GetCfgText(1015523)
	elseif buildId == 36000006 then
		return self:GetCfgText(1015524)
	elseif buildId == 36000008 then
		return self:GetCfgText(1015525)
	end

	return ""
end

function HomeLandChooseCastleApi:GetImgBtnFunctionPath(buildId)
	if buildId == 36000001 then
		return self:GetResUrl(3002010)
	elseif buildId == 36000002 then
		return self:GetResUrl(3002013)
	elseif buildId == 36000003 then
		return self:GetResUrl(3002012)
	elseif buildId == 36000005 then
		return self:GetResUrl(3002011)
	elseif buildId == 36000006 then
		return self:GetResUrl(3002014)
	elseif buildId == 36000007 then
		return self:GetResUrl(3002014)
	elseif buildId == 36000008 then
		return self:GetResUrl(3002014)
	end

	return self:GetResUrl(3002009)
end

function HomeLandChooseCastleApi:GetImgThemePath()
	return self:GetResUrl(3002009)
end

function HomeLandChooseCastleApi:GetImgLockPath()
	return self:GetResUrl(3002008)
end

function HomeLandChooseCastleApi:GetTextBtnTheme()
	return self:GetCfgText(1015059)
end

function HomeLandChooseCastleApi:TextShowCount(num1, num2)
	return num1 .. "/" .. num2
end

function HomeLandChooseCastleApi:GetTreasureTextMsg2()
	return self:GetCfgText(1015527)
end

function HomeLandChooseCastleApi:GetTreasureTextMsg1(num1, num2)
	return self:GetCfgText(1015528) .. ":" .. num1 .. "/" .. num2
end

function HomeLandChooseCastleApi:GetTreasureTextTitle()
	return self:GetCfgText(1015526)
end

function HomeLandChooseCastleApi:GetHelpTextMsg2()
	return self:GetCfgText(1015529)
end

function HomeLandChooseCastleApi:GetHelpTextMsg1(num1, num2)
	return self:GetCfgText(1015530) .. ":" .. num1 .. "/" .. num2
end

function HomeLandChooseCastleApi:GetHelpTextTitle()
	return self:GetCfgText(1015531)
end

function HomeLandChooseCastleApi:GetTextVisitHomeLandName(name)
	return name .. self:GetCfgText(1015532)
end

function HomeLandChooseCastleApi:GetTextError2()
	return self:GetCfgText(1015533)
end

function HomeLandChooseCastleApi:GetTextError1()
	return self:GetCfgText(1015534)
end

function HomeLandChooseCastleApi:GetTextBtnNoReached(type)
	if type == 1 then
		return self:GetCfgText(1015535)
	end

	return self:GetCfgText(1015536)
end

function HomeLandChooseCastleApi:GetTextCondition(str, isTop)
	if isTop then
		return self.TextColor[14] .. "<size=34>" .. str .. "</size>" .. self.TextColor[0]
	end

	return self.TextColor[28] .. "<size=34>" .. str .. "</size>" .. self.TextColor[0]
end

function HomeLandChooseCastleApi:GetVisitNextFriendText(isEng)
	if isEng then
		return self:Blank("VISITNEXT", 1)
	end

	return self:GetCfgText(1015519)
end

function HomeLandChooseCastleApi:GetGoHomeFunBtnText(isEng)
	if isEng then
		return self:Blank("BACK", 1)
	end

	return self:GetCfgText(1015537)
end

function HomeLandChooseCastleApi:GetVisitFunBtnText(isEng)
	if isEng then
		return self:Blank("VISIT", 1)
	end

	return self:GetCfgText(1015538)
end

function HomeLandChooseCastleApi:GetRoomFunBtnText(isEng)
	if isEng then
		return self:Blank("ROOM", 1)
	end

	return self:GetCfgText(1015539)
end

function HomeLandChooseCastleApi:SetTextTitle()
	return self:GetCfgText(1015540)
end

function HomeLandChooseCastleApi:SetTextBtnLock()
	return self:GetCfgText(1015021)
end

HomeLandChooseCastleApi:Init()
