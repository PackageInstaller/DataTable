-- chunkname: @IQIGame\\Net\\NetPlayerResponse.lua

local json = require("Util.json")

function net_player.loadPlayerResult_delegate(code, player, reconnectToken)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	local args = {}

	args.Player = player
	args.ReconnectToken = reconnectToken

	PlayerModule.GetAccountType()
	PlayerModule.Load(args.Player)
	SDKLoginModule.EnterGame(args.Player)
	EventDispatcher.Dispatch(EventID.UpdateConnectToken, args.ReconnectToken)

	local e = LoginSucceedEventArgs()

	GameEntry.LuaEvent:Fire(LoginModule, e)

	LoginModule.LoginTimeForLog = PlayerModule.GetServerTime()

	SceneTransferModule.LoginSceneToEmptyMainCityScene(args)
end

function net_player.reloadPlayerResult_delegate(code, lastMsgOrder, reconnectToken)
	NetCommController.Responded()

	if code == 0 then
		EventDispatcher.Dispatch(EventID.UpdateConnectToken, reconnectToken)
		LuaCodeInterface.SendAllFailMsgs(lastMsgOrder)
	else
		PlayerModule.StateLogOut()

		LoginModule.NeedReconnect = false

		NoticeModule.ShowNotice(21040011, LoginModule.AbandonReconnect, nil, nil)
	end
end

function net_player.changeDataResult(code, baseInfo)
	if code == 0 then
		UserInfoModule.ChangeUserDataResult(baseInfo)
	else
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, getErrorMsg(code))
	end
end

function net_player.changeShowHeroResult(code, baseInfo)
	if code == 0 then
		UserInfoModule.LoadOpera(baseInfo)

		PlayerModule.PlayerInfo.baseInfo = baseInfo

		FormatRoleModule.ChangeShowHcidResult(code)
	end
end

function net_player.changeDataResult_delegate(code, baseInfo)
	NetCommController.Responded()

	if code ~= 0 then
		if code == 11005 then
			NoticeModule.ShowNotice(21045002)
			EventDispatcher.Dispatch(EventID.ChangeNameSensitiveErrorEvent)
		elseif code == 11002 then
			NoticeModule.ShowNotice(21040123)
		else
			NoticeModule.ShowServerError(code)
		end

		return
	end

	UserInfoModule.ChangeUserDataResult(baseInfo)
	EventDispatcher.Dispatch(EventID.GetRePlayerNameResult, code)
end

function net_player.getPlayerInfoResult(code, baseInfo)
	if code == 0 then
		EventDispatcher.Dispatch(EventID.GetPlayerInfoResult, baseInfo)
	else
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, getErrorMsg(code))
	end
end

function net_player.setHelpHeroResult(code, baseInfo)
	PlayerModule.PlayerInfo.baseInfo = baseInfo

	AssistInFightingModule.SetHelpHeroSucceed(code, baseInfo)
end

function net_player.getHeroInfoResult(code, heroPOD)
	PlayerModule.GetHeroInfoResult(code, heroPOD)
end

function net_player.notifyPlayerDataChange(baseInfo)
	UserInfoModule.LoadOpera(baseInfo)

	PlayerModule.PlayerInfo.baseInfo = baseInfo

	EventDispatcher.Dispatch(EventID.NotifyPlayerDataChange)
end

function net_player.triggerGuideResult(code, id, step, type)
	if code == 0 then
		GuideModule.TriggerGuideResult(id, step, type)
	else
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, getErrorMsg(code))
	end
end

function net_player.sendGiftCodeResult_delegate(code, items)
	NetCommController.Responded()

	if code ~= 0 then
		EventDispatcher.Dispatch(EventID.SendGiftCodeResult, false)

		if code == 110010 then
			NoticeModule.ShowNoticeByType(1, SettingUIApi:GetErrorMsg())

			return
		end

		NoticeModule.ShowServerError(code)

		return
	end

	SettingModule.SendGiftCodeResult(items)
	EventDispatcher.Dispatch(EventID.SendGiftCodeResult, true)
end

function net_player.notifyUnlockFunc(funcTypes)
	UnlockFunctionModule.RefreshFuncTypes(funcTypes)
end

function net_player.notifyPlayerLevelChange(lv, items)
	PlayerModule.PlayerLevelChange(lv, items)
	SDKLoginModule.RoleLevelUp(lv)
end

function net_player.saveLittleInfomationResult()
	return
end

function net_player.achieveShowResult(code)
	AchievementModule.achieveShowResult(code)
end

function net_player.notifyQuestionnaires(questionnaires)
	PlayerModule.PlayerInfo.baseInfo.questionnaires = questionnaires

	EventDispatcher.Dispatch(EventID.QuestionnairStateChange)
end

function net_player.activeTalentResult(code, talents)
	UserInfoModule.ActiveTalentResult(talents)
end

function net_player.resetTalentResult(code, talentPOD, items)
	UserInfoModule.ResetTalentResult(talentPOD, items)
end

function net_player.gainEventAwardResult(code, items)
	PlayerModule.GetEventAwardResult(items)
end

function net_player.triggerEventResult(code)
	return
end

function net_player.notifyServerParamChange(serverParams)
	PlayerModule.PlayerInfo.serverParams = serverParams

	EventDispatcher.Dispatch(EventID.ServerParamChangeEvent)
end

function net_player.notifyLimitedTimePkg(limitedTimePkg)
	for k, v in pairs(limitedTimePkg) do
		PlayerModule.PlayerInfo.limitedTimePkg[k] = v
	end

	EventDispatcher.Dispatch(EventID.NotifyLimitedTimePkg)
end

function net_player.notifyCommodityBuyRecords(commodityBuyRecords)
	for k, v in pairs(commodityBuyRecords) do
		if v < 0 then
			PlayerModule.PlayerInfo.commodityBuyRecords[k] = nil
		else
			PlayerModule.PlayerInfo.commodityBuyRecords[k] = v
		end
	end

	EventDispatcher.Dispatch(EventID.NotifyCommodityBuyRecords)
	ShopModule.NotifychangeShopItems(commodityBuyRecords)
end

function net_player.setKanBanResult(code, baseInfo)
	UserInfoModule.LoadOpera(baseInfo)

	PlayerModule.PlayerInfo.baseInfo = baseInfo

	FormatRoleModule.ChangeShowHcidResult(code)
end

function net_player.setKanBanPoolResult(code)
	return
end

function net_player.setRandomKanBanResult(code)
	return
end

function net_player.notifyChangeKanBanPOD(kanBanPOD)
	PlayerModule.OnChangeKanBanPOD(kanBanPOD)
end

function net_player.notifyGlobalBuffPOD(globalBuffs)
	GlobalBuffModule.OnGlobalBuffChange(globalBuffs)
end

function net_player.saveDataResult(code)
	PlayerModule.OnSavePlayerCatchDataSuccess()
end

function net_player.notifyMonthCard(monthCard)
	MonthCardModule.notifyMonthCard_New(monthCard)
end
