-- chunkname: @IQIGame\\Module\\Setting\\SettingModule.lua

SettingModule = {
	CHANGE_PLAYER_HEAD_FRAME = 4,
	ultimateAnimationState = 1,
	closeDark = 0,
	targetFrameRate = 60,
	currentBG = 42000001,
	currentMusicVolume = 1,
	defaultTimeLimitType_1010303002 = 0,
	harmoniousResources = 0,
	openDrawCard = 0,
	CHANGE_PLAYER_NAME = 1,
	CHANGE_PLAYER_TITLE = 5,
	CHANGE_PLAYER_HEAD = 3,
	CHANGE_PLAYER_DESCRIBE = 2,
	currentSoundVolume = 1,
	messageMainSwitch = 0,
	defaultTimeLimitType_1010303001 = 0,
	currentCvVolume = 1,
	CHANGE_PLAYER_CHAT_BUBBLE = 6,
	pushMessage = {},
	musicGroup = {
		"ENVIRONMENT",
		"UI"
	},
	soundGroup = {
		"BGM"
	},
	cvGroup = {
		"CHARACTER",
		"LIVE2D"
	}
}

local SettingPlayerHeadData = require("IQIGame.Module.Setting.SettingPlayerHeadData")
local SettingLoginBGData = require("IQIGame.Module.Setting.SettingLoginBGData")
local SettingPlayerHeadFrameData = require("IQIGame.Module.Setting.SettingPlayerHeadFrameData")
local SettingPlayerTitleData = require("IQIGame.Module.Setting.SettingPlayerTitleData")

function SettingModule.ReloadData(data, loginBGs, unlockAvatarFrames, unlockTitle)
	SettingModule.GetPlayerCallBack = nil
	SettingModule.unlockHeadIcons = {}

	for i, v in pairsCfg(CfgPlayerHeadIconTable) do
		local settingHeadData
		local index = table.indexOf(data, v.Id)

		if index ~= -1 or v.IsLock == 0 then
			settingHeadData = SettingPlayerHeadData.New(v.Id, true)
		else
			settingHeadData = SettingPlayerHeadData.New(v.Id, false)
		end

		table.insert(SettingModule.unlockHeadIcons, settingHeadData)
	end

	table.sort(SettingModule.unlockHeadIcons, SettingModule.SortEvent)

	SettingModule.loginBgs = {}

	for i, v in pairsCfg(CfgLoginBGTable) do
		local loginBgData
		local index = table.indexOf(loginBGs, v.Id)

		if index ~= -1 or v.IsLock == 0 then
			loginBgData = SettingLoginBGData.New(v.Id, true)
		else
			loginBgData = SettingLoginBGData.New(v.Id, false)
		end

		table.insert(SettingModule.loginBgs, loginBgData)
	end

	table.sort(SettingModule.loginBgs, function(tb1, tb2)
		local r = false
		local aIsLock = tb1.isLock == true and 1 or 0
		local bIsLock = tb2.isLock == true and 1 or 0

		r = bIsLock < aIsLock

		return r
	end)

	SettingModule.unlockHeadFrames = {}

	for i, v in pairsCfg(CfgPlayerAvatarFrameTable) do
		local frameData
		local index = -1

		if unlockAvatarFrames then
			index = table.indexOf(unlockAvatarFrames, v.Id)
		end

		if index ~= -1 or v.IsLock == false then
			frameData = SettingPlayerHeadFrameData.New(v.Id, true)
		else
			frameData = SettingPlayerHeadFrameData.New(v.Id, false)
		end

		table.insert(SettingModule.unlockHeadFrames, frameData)
	end

	table.sort(SettingModule.unlockHeadFrames, SettingModule.SortEvent)

	SettingModule.unlockTitles = {}

	for i, v in pairsCfg(CfgPlayerCoatOfArmsTable) do
		local titleData
		local index = -1

		if unlockTitle then
			index = table.indexOf(unlockTitle, v.Id)
		end

		if index ~= -1 or v.IsLock == false then
			titleData = SettingPlayerTitleData.New(v.Id, true)
		else
			titleData = SettingPlayerTitleData.New(v.Id, false)
		end

		table.insert(SettingModule.unlockTitles, titleData)
	end

	table.sort(SettingModule.unlockTitles, SettingModule.SortEvent)
end

function SettingModule.DefaultSetting()
	SettingModule.harmoniousResources = PlayerPrefsUtil.GetInt("", Constant.PlayerPrefsConst.OpenHarmoniousResources)
	SettingModule.defaultTimeLimitType_1010303001 = CfgMallTable[1010303001].TimeLimitType
	SettingModule.defaultTimeLimitType_1010303002 = CfgMallTable[1010303002].TimeLimitType
	SettingModule.openDrawCard = PlayerPrefsUtil.GetInt("", Constant.PlayerPrefsConst.OpenDrawCard)

	SettingModule.ChangeMallCfg()

	local cvVolume = tonumber(PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.UserCvVolume))

	if cvVolume ~= nil then
		SettingModule.currentCvVolume = cvVolume
	end

	local musicVolume = tonumber(PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.UserMusicVolume))

	if musicVolume ~= nil then
		SettingModule.currentMusicVolume = musicVolume
	end

	local soundVolume = tonumber(PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.UserSoundVolume))

	if soundVolume ~= nil then
		SettingModule.currentSoundVolume = soundVolume
	end

	local targetFrameRate = tonumber(PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.UserTargetFrameRate))

	if targetFrameRate then
		SettingModule.targetFrameRate = targetFrameRate
	end

	SettingModule.closeDark = PlayerPrefsUtil.GetInt("", Constant.PlayerPrefsConst.UserSettingDark)
	GameEntry.UI.IsTransitionAnimationDisabled = SettingModule.closeDark == 1

	local ultimateAnimationState = PlayerPrefsUtil.GetInt("", Constant.PlayerPrefsConst.UserSettingUltimateAnimationSate)

	if ultimateAnimationState > 0 then
		SettingModule.ultimateAnimationState = ultimateAnimationState
	end

	SettingModule.messageMainSwitch = PlayerPrefsUtil.GetInt("", Constant.PlayerPrefsConst.UserSettingMessageMainSwitch)
	SettingModule.pushMessage = PlayerPrefsUtil.GetLuaTable("", Constant.PlayerPrefsConst.UserSettingMessageChildSwitch)

	if SettingModule.pushMessage == nil then
		SettingModule.pushMessage = {}
	end

	SettingModule.SetCVGroupValue()
	SettingModule.SetMusicGroupValue()
	SettingModule.SetSoundGroupValue()
	SettingModule.SetFrameRate()
end

function SettingModule.SetCVGroupValue()
	for i, v in pairs(SettingModule.cvGroup) do
		GameEntry.Sound:SetGroupVolume(v, SettingModule.currentCvVolume)
	end
end

function SettingModule.SetMusicGroupValue()
	for i, v in pairs(SettingModule.musicGroup) do
		GameEntry.Sound:SetGroupVolume(v, SettingModule.currentMusicVolume)
	end
end

function SettingModule.SetSoundGroupValue()
	for i, v in pairs(SettingModule.soundGroup) do
		GameEntry.Sound:SetGroupVolume(v, SettingModule.currentSoundVolume)
	end
end

function SettingModule.SetFrameRate()
	UnityEngine.Application.targetFrameRate = SettingModule.targetFrameRate
end

function SettingModule.SaveCurrentCvVolume(value)
	SettingModule.currentCvVolume = value

	if SettingModule.currentCvVolume < 0 then
		SettingModule.currentCvVolume = 0
	end

	if SettingModule.currentCvVolume > 1 then
		SettingModule.currentCvVolume = 1
	end

	PlayerPrefsUtil.SetString("", Constant.PlayerPrefsConst.UserCvVolume, tostring(SettingModule.currentCvVolume))
	SettingModule.SetCVGroupValue()
end

function SettingModule.SaveCurrentMusicVolume(value)
	SettingModule.currentMusicVolume = value

	if SettingModule.currentMusicVolume < 0 then
		SettingModule.currentMusicVolume = 0
	end

	if SettingModule.currentMusicVolume > 1 then
		SettingModule.currentMusicVolume = 1
	end

	PlayerPrefsUtil.SetString("", Constant.PlayerPrefsConst.UserMusicVolume, tostring(SettingModule.currentMusicVolume))
	SettingModule.SetMusicGroupValue()
end

function SettingModule.SaveCurrentSoundVolume(value)
	SettingModule.currentSoundVolume = value

	if SettingModule.currentSoundVolume < 0 then
		SettingModule.currentSoundVolume = 0
	end

	if SettingModule.currentSoundVolume > 1 then
		SettingModule.currentSoundVolume = 1
	end

	PlayerPrefsUtil.SetString("", Constant.PlayerPrefsConst.UserSoundVolume, tostring(SettingModule.currentSoundVolume))
	SettingModule.SetSoundGroupValue()
end

function SettingModule.SaveTargetFrameRate(value)
	SettingModule.targetFrameRate = value

	PlayerPrefsUtil.SetString("", Constant.PlayerPrefsConst.UserTargetFrameRate, tostring(SettingModule.targetFrameRate))
	SettingModule.SetFrameRate()
end

function SettingModule.SaveDark(value)
	SettingModule.closeDark = value
	GameEntry.UI.IsTransitionAnimationDisabled = SettingModule.closeDark == 1

	PlayerPrefsUtil.SetInt("", Constant.PlayerPrefsConst.UserSettingDark, SettingModule.closeDark)
end

function SettingModule.SaveUltimateAnimationState(value)
	SettingModule.ultimateAnimationState = value

	PlayerPrefsUtil.SetInt("", Constant.PlayerPrefsConst.UserSettingUltimateAnimationSate, SettingModule.ultimateAnimationState)
end

function SettingModule.SaveMessageMainSwitch(value)
	SettingModule.messageMainSwitch = value

	PlayerPrefsUtil.SetInt("", Constant.PlayerPrefsConst.UserSettingMessageMainSwitch, SettingModule.messageMainSwitch)

	if value == 1 then
		PushMessageModule.RemoveAllLocalNotification()
	else
		PushMessageModule.SetDefaultPushMessage()
	end
end

function SettingModule.SaveMessageChildSwitch(cid, value)
	SettingModule.pushMessage[tostring(cid)] = value

	PlayerPrefsUtil.SetLuaTable("", Constant.PlayerPrefsConst.UserSettingMessageChildSwitch, SettingModule.pushMessage)

	if SettingModule.messageMainSwitch == 0 then
		if value == 0 then
			PushMessageModule.AddLocalNotification(cid)
		else
			PushMessageModule.RemoveLocalNotification(cid)
		end
	end
end

function SettingModule.SaveHarmoniousResources(stateNum)
	PlayerPrefsUtil.SetInt("", Constant.PlayerPrefsConst.OpenHarmoniousResources, stateNum)

	SettingModule.harmoniousResources = stateNum

	EventDispatcher.Dispatch(EventID.ChangeHarmoniousResourcesEvent)
	log("缓存和谐资源开启状态 " .. stateNum)
end

function SettingModule.SaveOpenDrawCard(stateNum)
	PlayerPrefsUtil.SetInt("", Constant.PlayerPrefsConst.OpenDrawCard, stateNum)

	SettingModule.openDrawCard = stateNum

	SettingModule.ChangeMallCfg()
	log("缓存GM抽卡开启状态 " .. stateNum)
end

function SettingModule.GetMessageChildSwitch(cid)
	local value = SettingModule.pushMessage[tostring(cid)]

	if value == nil then
		value = 0
	end

	return value
end

function SettingModule.SortEvent(tb1, tb2)
	local r = false
	local aIsLock = tb1.isLock == true and 1 or 0
	local bIsLock = tb2.isLock == true and 1 or 0

	if aIsLock == bIsLock then
		r = tb1.cfgInfo.Sort < tb2.cfgInfo.Sort
	else
		r = bIsLock < aIsLock
	end

	return r
end

function SettingModule.GetPlayHeadData(cid)
	for i, v in pairs(SettingModule.unlockHeadIcons) do
		if v.cfgID == cid then
			return v
		end
	end

	return nil
end

function SettingModule.GetLoginBGData(cid)
	for i, v in pairs(SettingModule.loginBgs) do
		if v.cfgID == cid then
			return v
		end
	end

	return nil
end

function SettingModule.GetPlayHeadFrameData(cid)
	for i, v in pairs(SettingModule.unlockHeadFrames) do
		if v.cfgID == cid then
			return v
		end
	end

	return nil
end

function SettingModule.GetPlayerTitleData(cid)
	for i, v in pairs(SettingModule.unlockTitles) do
		if v.cfgID == cid then
			return v
		end
	end

	return nil
end

function SettingModule.ChangeMallCfg()
	if SettingModule.openDrawCard == 1 then
		CfgMallTable[1010303001].TimeLimitType = 0
		CfgMallTable[1010303002].TimeLimitType = 0
	else
		CfgMallTable[1010303001].TimeLimitType = SettingModule.defaultTimeLimitType_1010303001
		CfgMallTable[1010303002].TimeLimitType = SettingModule.defaultTimeLimitType_1010303002
	end
end

function SettingModule.ChangeData(type, content)
	if type == SettingModule.CHANGE_PLAYER_DESCRIBE or type == SettingModule.CHANGE_PLAYER_NAME then
		SDKLoginModule.checkDirtyWords(content, function(contain, replaceContent)
			if contain then
				NoticeModule.ShowNotice(21045002)

				return
			end

			net_player.changeData(type, content)
		end)
	else
		net_player.changeData(type, content)
	end
end

function SettingModule.SaveShowCollectItems(items)
	net_player.saveShowCollectItems(items)
end

function SettingModule.GetPlayerInfo(targetServerId, targetPid, callBack)
	SettingModule.GetPlayerCallBack = callBack

	net_player.getPlayerInfo(targetServerId, targetPid)
end

function SettingModule.SendChangeSetting(key, value)
	net_player.savePlayerSetting(key, value)
end

function SettingModule.ChangeDataResult(type, baseInfo)
	if type == SettingModule.CHANGE_PLAYER_DESCRIBE then
		PlayerModule.PlayerInfo.baseInfo.intro = baseInfo.intro
	elseif type == SettingModule.CHANGE_PLAYER_HEAD then
		PlayerModule.PlayerInfo.baseInfo.headIcon = baseInfo.headIcon
	elseif type == SettingModule.CHANGE_PLAYER_NAME then
		PlayerModule.PlayerInfo.baseInfo.pName = baseInfo.pName
	elseif type == SettingModule.CHANGE_PLAYER_HEAD_FRAME then
		PlayerModule.PlayerInfo.baseInfo.avatarFrame = baseInfo.avatarFrame
	elseif type == SettingModule.CHANGE_PLAYER_TITLE then
		PlayerModule.PlayerInfo.baseInfo.title = baseInfo.title
	elseif type == SettingModule.CHANGE_PLAYER_CHAT_BUBBLE then
		PlayerModule.PlayerInfo.baseInfo.chatBackground = baseInfo.chatBackground
	end

	EventDispatcher.Dispatch(EventID.PlayerSettingChangeEvent)
end

function SettingModule.SaveShowCollectItemsResult(items)
	PlayerModule.PlayerInfo.showCollectItems = items

	EventDispatcher.Dispatch(EventID.PlayerSettingChangeEvent)
end

function SettingModule.NotifyUnLockHeadIcon(headIconId, remove)
	for i, v in pairs(SettingModule.unlockHeadIcons) do
		if v.cfgID == headIconId then
			if remove then
				v.isLock = false
			else
				v.isLock = true
			end
		end
	end

	EventDispatcher.Dispatch(EventID.UpdatePlayerHeadIcon)
end

function SettingModule.NotifyUnLockLoginBackground(background)
	for i, v in pairs(SettingModule.loginBgs) do
		if v.cfgID == background then
			v.isLock = true
		end
	end
end

function SettingModule.NotifyUnLockTitle(title, remove)
	for i, v in pairs(SettingModule.unlockTitles) do
		if v.cfgID == title then
			if remove then
				v.isLock = false
			else
				v.isLock = true
			end
		end
	end

	EventDispatcher.Dispatch(EventID.UpdatePlayerTitle)
end

function SettingModule.SendGiftCodeResult(items)
	if items ~= nil then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, items)
	end
end

function SettingModule.NotifyUnLockAvatarFrame(avatarFrame, remove)
	for i, v in pairs(SettingModule.unlockHeadFrames) do
		if v.cfgID == avatarFrame then
			if remove then
				v.isLock = false
			else
				v.isLock = true
			end
		end
	end

	EventDispatcher.Dispatch(EventID.UpdatePlayerAvatarFrame)
end

function SettingModule.GetPlayerInfoResult(playerInfo)
	if SettingModule.GetPlayerCallBack then
		SettingModule.GetPlayerCallBack(playerInfo)
	end

	SettingModule.GetPlayerCallBack = nil
end

function SettingModule.OnChangeSettingResponse(code, key, value)
	local isSuccess = code == 0

	if isSuccess then
		PlayerModule.PlayerInfo.playerSetting = PlayerModule.PlayerInfo.playerSetting or {}
		PlayerModule.PlayerInfo.playerSetting[key] = value
	end

	EventDispatcher.Dispatch(EventID.OnChangeSettingComplete, isSuccess, key, value)
end
