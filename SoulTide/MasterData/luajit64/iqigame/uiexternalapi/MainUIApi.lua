-- chunkname: @IQIGame\\UIExternalApi\\MainUIApi.lua

MainUIApi = BaseLangApi:Extend()

function MainUIApi:Init()
	self:RegisterApi("SoulInfoBtnText", self.GetSoulInfoBtnText)
	self:RegisterApi("PuppetBtnText", self.GetPuppetBtnText)
	self:RegisterApi("BagBtnText", self.GetBagBtnText)
	self:RegisterApi("ShopBtnText", self.GetShopBtnText)
	self:RegisterApi("PreviewBtnText", self.GetPreviewBtnText)
	self:RegisterApi("TaskBtnText", self.GetTaskBtnText)
	self:RegisterApi("ActiveRookieBtnText", self.GetActiveRookieBtnText)
	self:RegisterApi("MailBtnText", self.GetMailBtnText)
	self:RegisterApi("SignBtnText", self.GetSignBtnText)
	self:RegisterApi("EquipBtnText", self.GetEquipBtnText)
	self:RegisterApi("SettingBtnText", self.GetSettingBtnText)
	self:RegisterApi("LevelText", self.GetLevelText)
	self:RegisterApi("NameText", self.GetNameText)
	self:RegisterApi("RechargeBtnText", self.GetRechargeBtnText)
	self:RegisterApi("FriendBtnText", self.GetFriendBtnText)
	self:RegisterApi("GirlBtnText", self.GetGirlBtnText)
	self:RegisterApi("ActiveBtnText", self.GetActiveBtnText)
	self:RegisterApi("ActiveTaskBtnText", self.GetActiveTaskBtnText)
	self:RegisterApi("PassBtnText", self.GetPassBtnText)
	self:RegisterApi("GrowthFundBtnText", self.GetGrowthFundBtnText)
	self:RegisterApi("ExpBonusBtnText", self.GetExpBonusBtnText)
	self:RegisterApi("AchievementBtnText", self.GetAchievementBtnText)
	self:RegisterApi("StorageBtnText", self.GetStorageBtnText)
	self:RegisterApi("ChatContent", self.GetChatContent)
	self:RegisterApi("ChatEmotionText", self.GetChatEmotionText)
	self:RegisterApi("LvLabelText", self.GetLvLabelText)
	self:RegisterApi("LockTitle", self.GetLockTitle)
	self:RegisterApi("LvLabelColor", self.GetLvLabelColor)
	self:RegisterApi("HankBookBtnText", self.GetHankBookBtnText)
	self:RegisterApi("ChallengeBtnText", self.GetChallengeBtnText)
	self:RegisterApi("WishBtnText", self.GetWishBtnText)
	self:RegisterApi("FormationBtnText", self.GetFormationBtnText)
	self:RegisterApi("TextLv", self.GetTextLv)
	self:RegisterApi("LibraryBtnText", self.GetLibraryBtnText)
	self:RegisterApi("WorldMazeBtnText", self.GetWorldMazeBtnText)
	self:RegisterApi("HomeBtnText", self.GetHomeBtnText)
	self:RegisterApi("CardGameBtnText", self.GetCardGameBtnText)
	self:RegisterApi("TextMainCity", self.GetTextMainCity)
	self:RegisterApi("TextTown", self.GetTextTown)
	self:RegisterApi("TextMazeTitle", self.GetTextMazeTitle)
	self:RegisterApi("MainCityOrthographicSize", self.GetMainCityOrthographicSize)
	self:RegisterApi("SpeedAutoMove", self.GetSpeedAutoMove)
	self:RegisterApi("SpeedMove", self.GetSpeedMove)
	self:RegisterApi("CameraPos", self.GetCameraPos)
	self:RegisterApi("ActiveWeekBtnText", self.GetActiveWeekBtnText)
	self:RegisterApi("FirstRechargeBtnText", self.GetFirstRechargeBtnText)
	self:RegisterApi("TextBtnChange", self.GetTextBtnChange)
	self:RegisterApi("WorldMazeBtn", self.GetWorldMazeBtn)
	self:RegisterApi("WishBtn", self.GetWishBtn)
	self:RegisterApi("HomeBtn", self.GetHomeBtn)
	self:RegisterApi("WorldMazeNotice", self.GetWorldMazeNotice)
	self:RegisterApi("GirlBtn", self.GetGirlBtn)
	self:RegisterApi("ImgWishBtn", self.GetImgWishBtn)
	self:RegisterApi("ImgHomeBtn", self.GetImgHomeBtn)
	self:RegisterApi("ImgGirlBtn", self.GetImgGirlBtn)
	self:RegisterApi("ImgWorldMazeBtn", self.GetImgWorldMazeBtn)
	self:RegisterApi("ActivityHundredDayBtnText", self.GetActivityHundredDayBtnText)
	self:RegisterApi("ActivityHundredDayOpenTime", self.GetActivityHundredDayOpenTime)
	self:RegisterApi("ActivityHundredDayEndTime", self.GetActivityHundredDayEndTime)
	self:RegisterApi("ActivityHundredDayURLType", self.GetActivityHundredDayURLType)
	self:RegisterApi("ActivityHundredDayURL", self.GetActivityHundredDayURL)
	self:RegisterApi("ActiveUpgradeBtnText", self.GetActiveUpgradeBtnText)
	self:RegisterApi("BtnOathTitle", self.GetBtnOathTitle)
	self:RegisterApi("BtnSpineTitle", self.GetBtnSpineTitle)
	self:RegisterApi("BtnLive2DTitle", self.GetBtnLive2DTitle)
	self:RegisterApi("BtnWhisperLabel", self.GetBtnWhisperLabel)
	self:RegisterApi("TalkPos", self.GetTalkPos)
	self:RegisterApi("ActiveWelcomeNewBtnText", self.GetActiveWelcomeNewBtnText)
	self:RegisterApi("ActiveWelcomeBackBtnText", self.GetActiveWelcomeBackBtnText)
	self:RegisterApi("StorageBoxBtnText", self.GetStorageBoxBtnText)
	self:RegisterApi("StorageBoxTitle", self.GetStorageBoxTitle)
	self:RegisterApi("CameraBtnText", self.GetCameraBtnText)
	self:RegisterApi("BtnSwitchCD", self.GetBtnSwitchCD)
	self:RegisterApi("RebatePackageBtnText", self.GetRebatePackageBtnText)
	self:RegisterApi("PurchaseTipCDText", self.GetPurchaseTipCDText)
	self:RegisterApi("GuildBtnText", self.GuildBtnText)
	self:RegisterApi("CelebrationGiftBoxBtnText", self.GetCelebrationGiftBoxBtnText)
	self:RegisterApi("CommandChallengeBtnText", self.GetCommandChallengeBtnText)
	self:RegisterApi("HuaWeiLogoutURL", self.GetHuaWeiLogoutURL)
end

function MainUIApi:GetCommandChallengeBtnText()
	return self:GetCfgText(1019251)
end

function MainUIApi:GetCelebrationGiftBoxBtnText()
	return self:GetCfgText(1019248)
end

function MainUIApi:GetPurchaseTipCDText(name, timeStr)
	return string.format("%s:%s", name, timeStr)
end

function MainUIApi:GuildBtnText(type)
	if type == 2 then
		return "Guild"
	end

	return self:GetCfgText(1110005)
end

function MainUIApi:GetRebatePackageBtnText(type)
	if type == 2 then
		return self:GetCfgText(1019246)
	end

	return self:GetCfgText(1019247)
end

function MainUIApi:GetBtnSwitchCD()
	return 3
end

function MainUIApi:GetCameraBtnText(type)
	if type == 2 then
		return "Camera"
	end

	return self:GetCfgText(1019242)
end

function MainUIApi:GetStorageBoxTitle()
	return self:GetCfgText(1019243)
end

function MainUIApi:GetStorageBoxBtnText(type)
	if type == 2 then
		return ""
	end

	return ""
end

function MainUIApi:GetActiveWelcomeBackBtnText(type)
	if type == 2 then
		return "WelcomeBack"
	end

	return self:GetCfgText(1019229)
end

function MainUIApi:GetActiveWelcomeNewBtnText(type)
	if type == 2 then
		return "WelcomeNew"
	end

	return self:GetCfgText(1019230)
end

function MainUIApi:GetTalkPos(soulMarryID)
	local cfgSoulMarry = CfgSoulMarryTable[soulMarryID]

	return Vector2.New(cfgSoulMarry.ChatPos[1], cfgSoulMarry.ChatPos[2])
end

function MainUIApi:GetBtnWhisperLabel()
	return self:GetCfgText(1019231)
end

function MainUIApi:GetBtnLive2DTitle()
	return self:GetCfgText(1019232)
end

function MainUIApi:GetBtnSpineTitle()
	return self:GetCfgText(1019233)
end

function MainUIApi:GetBtnOathTitle()
	return self:GetCfgText(1019234)
end

function MainUIApi:GetActiveUpgradeBtnText(type)
	if type == 2 then
		return "ActiveUpgradeBtnText"
	end

	return self:GetCfgText(3900004)
end

function MainUIApi:GetActivityHundredDayEndTime()
	return "2024/8/22 12:00:00"
end

function MainUIApi:GetActivityHundredDayOpenTime()
	return "2024/7/31 23:59:59"
end

function MainUIApi:GetActivityHundredDayURLType()
	return 2
end

function MainUIApi:GetActivityHundredDayURL()
	return "https://lhcx.iqigame.net/p/thmain.html"
end

function MainUIApi:GetActivityHundredDayBtnText(type)
	if type == 2 then
		return "HundredDayActivity"
	end

	return "周年庆典"
end

function MainUIApi:GetHuaWeiLogoutURL()
	return "https://cdn-sdk.iqigame.com/iqisdk/agreement/hw_close_account.html"
end

function MainUIApi:GetImgWorldMazeBtn(showSpine, isOaths)
	if showSpine then
		return self:GetResUrl(4100004)
	end

	if isOaths then
		return self:GetResUrl(4200004)
	end

	return self:GetResUrl(4200004)
end

function MainUIApi:GetImgGirlBtn(showSpine, isOaths)
	if showSpine then
		return self:GetResUrl(4100003)
	end

	if isOaths then
		return self:GetResUrl(4200007)
	end

	return self:GetResUrl(4200003)
end

function MainUIApi:GetImgHomeBtn(showSpine, isOaths)
	if showSpine then
		return self:GetResUrl(4100001)
	end

	if isOaths then
		return self:GetResUrl(4200005)
	end

	return self:GetResUrl(4200001)
end

function MainUIApi:GetImgWishBtn(showSpine, isOaths)
	if showSpine then
		return self:GetResUrl(4100002)
	end

	if isOaths then
		return self:GetResUrl(4200006)
	end

	return self:GetResUrl(4200002)
end

function MainUIApi:GetGirlBtn(showSpine, marry, soulID)
	if showSpine then
		return Vector2.New(322, -92)
	end

	if marry then
		local cfgSoulMarry = GirlModule.GetSoulOathData(soulID)

		return Vector2.New(cfgSoulMarry.GirlPos[1], cfgSoulMarry.GirlPos[2])
	end

	return Vector2.New(511, -174.3)
end

function MainUIApi:GetWorldMazeNotice(showSpine, marry, soulID)
	if showSpine then
		return Vector2.New(161, 54)
	end

	if marry then
		local cfgSoulMarry = GirlModule.GetSoulOathData(soulID)

		return Vector2.New(cfgSoulMarry.MazeStatePos[1], cfgSoulMarry.MazeStatePos[2])
	end

	return Vector2.New(159.7, 51.9)
end

function MainUIApi:GetHomeBtn(showSpine, marry, soulID)
	if showSpine then
		return Vector2.New(198, -205)
	end

	if marry then
		local cfgSoulMarry = GirlModule.GetSoulOathData(soulID)

		return Vector2.New(cfgSoulMarry.HomePos[1], cfgSoulMarry.HomePos[2])
	end

	return Vector2.New(197, -93)
end

function MainUIApi:GetWishBtn(showSpine, marry, soulID)
	if showSpine then
		return Vector2.New(199, 88)
	end

	if marry then
		local cfgSoulMarry = GirlModule.GetSoulOathData(soulID)

		return Vector2.New(cfgSoulMarry.WishPos[1], cfgSoulMarry.WishPos[2])
	end

	return Vector2.New(287, 44.4)
end

function MainUIApi:GetWorldMazeBtn(showSpine, marry, soulID)
	if showSpine then
		return Vector2.New(-47, -101)
	end

	if marry then
		local cfgSoulMarry = GirlModule.GetSoulOathData(soulID)

		return Vector2.New(cfgSoulMarry.MazePos[1], cfgSoulMarry.MazePos[2])
	end

	return Vector2.New(-12, 4.7)
end

function MainUIApi:GetTextBtnChange(showSpine)
	return self:GetCfgText(1106173)
end

function MainUIApi:GetActiveWeekBtnText(type)
	if type == 2 then
		return "ActiveWeekBtnText"
	end

	return self:GetCfgText(2900001)
end

function MainUIApi:GetFirstRechargeBtnText(type)
	if type == 2 then
		return "FirstRechargeBtnText"
	end

	return self:GetCfgText(2900501)
end

function MainUIApi:GetCameraPos()
	local minPos = Vector3.New(-138, 0, 0)
	local maxPos = Vector3.New(138, 0, 0)

	return minPos, maxPos
end

function MainUIApi:GetSpeedMove()
	return 0.06
end

function MainUIApi:GetSpeedAutoMove()
	return 0.06
end

function MainUIApi:GetMainCityOrthographicSize()
	return 37.5
end

function MainUIApi:GetTextMazeTitle()
	return self:GetCfgText(1019216)
end

function MainUIApi:GetTextTown()
	return self:GetCfgText(1180004)
end

function MainUIApi:GetTextMainCity()
	return self:GetCfgText(1019217)
end

function MainUIApi:GetCardGameBtnText(type)
	if type == 2 then
		return "Card"
	end

	return "翻牌"
end

function MainUIApi:GetHomeBtnText(type)
	if type == 2 then
		return self:GetCfgText(1019226)
	end

	return self:GetCfgText(1015540)
end

function MainUIApi:GetWorldMazeBtnText(type)
	if type == 2 then
		return self:GetCfgText(1019225)
	end

	return self:GetCfgText(1106168)
end

function MainUIApi:GetLibraryBtnText(type)
	if type == 2 then
		return self:GetCfgText(1019224)
	end

	return self:GetCfgText(1019013)
end

function MainUIApi:GetTextLv(lv, openMaxLv)
	return lv
end

function MainUIApi:GetFormationBtnText(type)
	if type == 2 then
		return self:GetCfgText(1019200)
	end

	return self:GetCfgText(1214060)
end

function MainUIApi:GetWishBtnText(type)
	if type == 2 then
		return self:GetCfgText(1019201)
	end

	return self:GetCfgText(1317001)
end

function MainUIApi:GetChallengeBtnText(type)
	if type == 2 then
		return self:GetCfgText(1019202)
	end

	return self:GetCfgText(1213003)
end

function MainUIApi:GetHankBookBtnText(type)
	if type == 2 then
		return self:GetCfgText(1019203)
	end

	return self:GetCfgText(1019014)
end

function MainUIApi:GetLockTitle(value)
	return self:GetCfgText(1015021) .. "：" .. value .. " "
end

function MainUIApi:GetSoulInfoBtnText(type)
	if type == 2 then
		return self:GetCfgText(1019204)
	end

	return self:GetCfgText(1019001)
end

function MainUIApi:GetPuppetBtnText(type)
	if type == 2 then
		return self:GetCfgText(1019204)
	end

	return self:GetCfgText(1019002)
end

function MainUIApi:GetBagBtnText(type)
	if type == 2 then
		return self:GetCfgText(1019205)
	end

	return self:GetCfgText(1019003)
end

function MainUIApi:GetShopBtnText(type)
	if type == 2 then
		return self:GetCfgText(1019206)
	end

	return self:GetCfgText(1019025)
end

function MainUIApi:GetPreviewBtnText(type)
	if type == 2 then
		return "Preview"
	end

	return self:GetCfgText(1019027)
end

function MainUIApi:GetTaskBtnText(type)
	if type == 2 then
		return self:GetCfgText(1019207)
	end

	return self:GetCfgText(1019024)
end

function MainUIApi:GetActiveRookieBtnText(type)
	if type == 2 then
		return self:GetCfgText(1019208)
	end

	return self:GetCfgText(1019015)
end

function MainUIApi:GetMailBtnText(type)
	if type == 2 then
		return self:GetCfgText(1019209)
	end

	return self:GetCfgText(1019023)
end

function MainUIApi:GetSignBtnText()
	if type == 2 then
		return self:GetCfgText(1019223)
	end

	return self:GetCfgText(1019042)
end

function MainUIApi:GetEquipBtnText(type)
	if type == 2 then
		return self:GetCfgText(1019210)
	end

	return self:GetCfgText(1019002)
end

function MainUIApi:GetSettingBtnText(type)
	if type == 2 then
		return self:GetCfgText(1019211)
	end

	return self:GetCfgText(1019026)
end

function MainUIApi:GetActiveBtnText(type)
	if type == 2 then
		return self:GetCfgText(1019212)
	end

	return self:GetCfgText(1019042)
end

function MainUIApi:GetRechargeBtnText(type)
	if type == 2 then
		return self:GetCfgText(1019213)
	end

	return self:GetCfgText(1019041)
end

function MainUIApi:GetFriendBtnText(type)
	if type == 2 then
		return self:GetCfgText(1019214)
	end

	return self:GetCfgText(1019021)
end

function MainUIApi:GetGirlBtnText(type)
	if type == 2 then
		return self:GetCfgText(1019215)
	end

	return self:GetCfgText(1019004)
end

function MainUIApi:GetLevelText(exp, maxExp, lv, openMaxLv)
	if lv == openMaxLv then
		return self:GetCfgText(1019218)
	end

	return string.format(self:GetCfgText(1019219), maxExp - exp)
end

function MainUIApi:GetActiveTaskBtnText(type)
	if type == 2 then
		return self:GetCfgText(1019212)
	end

	return self:GetCfgText(1019006)
end

function MainUIApi:GetPassBtnText(type)
	if type == 2 then
		return self:GetCfgText(1019220)
	end

	return self:GetCfgText(1019221)
end

function MainUIApi:GetGrowthFundBtnText(type)
	if type == 2 then
		return self:GetCfgText(1019244)
	end

	return self:GetCfgText(1019245)
end

function MainUIApi:GetExpBonusBtnText()
	return self:GetCfgText(1019222)
end

function MainUIApi:GetAchievementBtnText(type)
	if type == 2 then
		return self:GetCfgText(1019215)
	end

	return self:GetCfgText(1019064)
end

function MainUIApi:GetNameText(name)
	return name
end

function MainUIApi:GetStorageBtnText(type)
	if type == 2 then
		return self:GetCfgText(1019215)
	end

	return self:GetCfgText(1019007)
end

function MainUIApi:GetChatContent(channel, name, content)
	if channel == 1 or channel == 2 then
		return self:GetCfgText(1019008) .. content
	elseif channel == 3 then
		return self:GetCfgText(1019009) .. name .. "：" .. content
	elseif channel == 4 then
		return name .. "：" .. content
	elseif channel == 5 then
		return self:GetCfgText(1019010) .. name .. "：" .. content
	end

	return ""
end

function MainUIApi:GetChatEmotionText()
	return self:GetCfgText(1019011)
end

function MainUIApi:GetLvLabelText()
	return self:GetCfgText(1019012)
end

function MainUIApi:GetLvLabelColor()
	return Color(0.5, 0.5, 0.5, 1)
end

function MainUIApi:GetWhisperUpdateBtnText(isUpdating)
	if not isUpdating then
		return self:GetCfgText(1019044)
	else
		return self:GetCfgText(1019045)
	end
end

MainUIApi:Init()
