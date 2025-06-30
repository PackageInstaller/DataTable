-- chunkname: @IQIGame\\Net\\NetPlayerResponse.lua

local json = require("Util.json")

function net_player.loadPlayerResult_delegate(code, player)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)
		SDKLoginModule.LogLogin(2, tostring(code))

		return
	end

	PlayerModule.Load(player)
	SDKLoginModule.LogLogin(1)
	SDKLoginModule.LogGetUserInfoAfterLogin()
	LoginModule.LoginComplete(player)
end

function net_player.updateBaseInfo(baseInfo)
	PlayerModule.UpdateHeroInfo(baseInfo)
end

function net_player.notifyUnlockEvent(eventCid)
	PlayerModule.UnlockEvent(eventCid)
end

function net_player.notifyFunctionTypeOpen(functionTypeId)
	PlayerModule.FunctionTypeOpen(functionTypeId)
	UnlockFunctionModule.OpenUnlock(functionTypeId)
end

function net_player.updatePlayerGlobalBuff(globalBuffs)
	PlayerModule.UpdatePlayerGlobalBuff(globalBuffs)
end

function net_player.notifyEnergyRecovery(energy, nextRecoveryEnergyTime)
	PlayerModule.EnergyRecovery(energy, nextRecoveryEnergyTime)
end

function net_player.notifyUpdatePlayerParams(paramID, value)
	PlayerModule.UpdatePlayerParams(paramID, value)
end

function net_player.notifyNumAttr(numAttr)
	PlayerModule.UpdateNumAttrs(numAttr)
end

function net_player.changeDataResult(code, type, baseInfo)
	if code == 0 then
		SettingModule.ChangeDataResult(type, baseInfo)
	else
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, getErrorMsg(code))
	end
end

function net_player.changeDataResult_delegate(code, type, baseInfo)
	NetCommController.Responded()

	if code ~= 0 then
		if code == 11005 then
			NoticeModule.ShowNotice(21045002)
		elseif code == 11002 then
			NoticeModule.ShowNotice(21040123)
		else
			NoticeModule.ShowServerError(code)
		end

		return
	end

	SettingModule.ChangeDataResult(type, baseInfo)
end

function net_player.notifyUnLockHeadIcon(headIconId, remove)
	if remove then
		local index = table.indexOf(PlayerModule.PlayerInfo.unlockHeadIcons, headIconId)

		if index ~= -1 then
			table.remove(PlayerModule.PlayerInfo.unlockHeadIcons, index)
		end
	else
		table.insert(PlayerModule.PlayerInfo.unlockHeadIcons, headIconId)
	end

	SettingModule.NotifyUnLockHeadIcon(headIconId, remove)
end

function net_player.notifyUnLockAvatarFrame(avatarFrame, remove)
	if remove then
		local index = table.indexOf(PlayerModule.PlayerInfo.unlockAvatarFrames, avatarFrame)

		if index ~= -1 then
			table.remove(PlayerModule.PlayerInfo.unlockAvatarFrames, index)
		end
	else
		table.insert(PlayerModule.PlayerInfo.unlockAvatarFrames, avatarFrame)
	end

	SettingModule.NotifyUnLockAvatarFrame(avatarFrame, remove)
end

function net_player.notifyUnLockLoginBackground(background)
	table.insert(PlayerModule.PlayerInfo.unlockLoginBackgrounds, background)
	SettingModule.NotifyUnLockLoginBackground(background)
end

function net_player.notifyWeather(weatherCid)
	WeatherModule.NotifyWeather(weatherCid)
end

function net_player.notifyReadPoint(readPoint)
	RedModule.SetServerRed(readPoint)
end

function net_player.notifyEffectNotice(effectType, effectParams, num)
	NoticeModule.NotifyEffectNotice(effectType, effectParams, num)
end

function net_player.triggerGuideResult(code, id, step, type)
	if code == 0 then
		GuideModule.TriggerGuideResult(id, step, type)
	else
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, getErrorMsg(code))
	end
end

function net_player.changeShowSoulResult(code)
	if code == 0 then
		SoulModule.ChangeShowSoulResult()
	else
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, getErrorMsg(code))
	end
end

function net_player.notifyTodayOpenVisitTreasureChest(todayOpenVisitTreasureChest)
	PlayerModule.NotifyTodayOpenVisitTreasureChest(todayOpenVisitTreasureChest)
end

function net_player.notifyTodayHelpHomeCount(todayHelpHomeCount)
	PlayerModule.NotifyTodayHelpHomeCount(todayHelpHomeCount)
end

function net_player.notifyTodayHelpBuildingCount(todayHelpBuildingCount)
	PlayerModule.NotifyTodayHelpBuildingCount(todayHelpBuildingCount)
end

function net_player.notifyUnlockTownEvent(eventCid)
	PlayerModule.NotifyUnlockTownEvent(eventCid)
end

function net_player.sendGiftCodeResult_delegate(code, items)
	NetCommController.Responded()

	if code ~= 0 then
		if code == 110010 then
			NoticeModule.ShowNoticeByType(1, SettingInputViewApi:GetString("ErrorMsg"))

			return
		end

		NoticeModule.ShowServerError(code)

		return
	end

	SettingModule.SendGiftCodeResult(items)
end

function net_player.notifyDailyReset(dailyReset)
	PlayerModule.PlayerInfo.dailySupplyList = dailyReset.dailySupplyList

	GiftModule.ReloadGift(dailyReset.remainderGiveGiftNum)
	ChurchModule.NotifyExchangeRecords(dailyReset.exchangeRecords)
	HLWorkModule.OnNotifyDailyReset(dailyReset.dailyWorkCount)

	PlayerModule.PlayerInfo.isGuildSign = dailyReset.isGuildSign
	PlayerModule.PlayerInfo.guildQuestGetRecord = dailyReset.guildQuestGetRecord

	EventDispatcher.Dispatch(EventID.UpdateDailySupply)
end

function net_player.notifyPayInfo(payCount, payExBonus)
	PlayerModule.PlayerInfo.payExBonus = payExBonus

	MallModule.OnNotifyPayInfo()
end

function net_player.notifyRecharge(getPayPoint, exBonus, open_id, order_id, game_order_id, product_id, product_type, amount, unit, pay_time, role_name)
	SDKLoginModule.LogChargeInfo(open_id, order_id, game_order_id, product_id, product_type, amount, unit, pay_time, role_name)
	MallModule.OnNotifyRecharge(product_id, getPayPoint, exBonus)
end

function net_player.notifyMonthCard(monthCard)
	PlayerModule.PlayerInfo.monthCard = monthCard

	MallModule.OnNotifyMonthCard()
end

function net_player.notifyItemDebts(itemDebts)
	PlayerModule.UpdateItemDebts(itemDebts)
end

function net_player.notifyChatEmojiUnlock(cid)
	ChatModule.UpdateChatEmojiUnlock(cid)
end

function net_player.saveShowCollectItemsResult(code, items)
	SettingModule.SaveShowCollectItemsResult(items)
end

function net_player.getPlayerInfoResult(code, playerInfo)
	SettingModule.GetPlayerInfoResult(playerInfo)
end

function net_player.notifyUnLockTitle(title, remove)
	if remove then
		local index = table.indexOf(PlayerModule.PlayerInfo.unlockTitle, title)

		if index ~= -1 then
			table.remove(PlayerModule.PlayerInfo.unlockTitle, index)
		end
	else
		table.insert(PlayerModule.PlayerInfo.unlockTitle, title)
	end

	SettingModule.NotifyUnLockTitle(title)
end

function net_player.buyAdvanceLevelChaseResult(code)
	PlayerModule.PlayerInfo.advanceLevelChaseFlag = true

	EventDispatcher.Dispatch(EventID.UpdateChaseEvent)
	NoticeModule.ShowNotice(21045040)
end

function net_player.notifyExecution(id)
	PlayerModule.OnNotifyExecution(id)
end

function net_player.notifySoulWhisperUnlock(whisperId)
	PlayerModule.NotifySoulWhisperUnlock(whisperId)
end

function net_player.notifyHeadIconTimelimit(headIconTimelimit)
	PlayerModule.PlayerInfo.headIconTimelimit = headIconTimelimit

	EventDispatcher.Dispatch(EventID.UpdatePlayerHeadIcon)
end

function net_player.notifyAvatarFrameTimelimit(avatarFrameTimelimit)
	PlayerModule.PlayerInfo.avatarFrameTimelimit = avatarFrameTimelimit

	EventDispatcher.Dispatch(EventID.UpdatePlayerAvatarFrame)
end

function net_player.notifyTitleTimelimit(titleTimelimit)
	PlayerModule.PlayerInfo.titleTimelimit = titleTimelimit

	EventDispatcher.Dispatch(EventID.UpdatePlayerTitle)
end

function net_player.notifyEquipSkinUpdate(cid, status)
	PlayerModule.PlayerInfo.equipSkins[cid] = status

	EventDispatcher.Dispatch(EventID.EquipSkinChanged, cid)
end

function net_player.useEquipSkinResult(code, id)
	return
end

function net_player.notifyRandomMallUpdate(randomMalls)
	PlayerModule.PlayerInfo.randomMalls = randomMalls

	MallModule.OnNotifyPayInfo()
end

function net_player.notifyUnLockGirlBackground(background)
	if table.indexOf(PlayerModule.PlayerInfo.unlockGirlBackgrounds, background) == -1 then
		table.insert(PlayerModule.PlayerInfo.unlockGirlBackgrounds, background)
	end

	EventDispatcher.Dispatch(EventID.UpdateUnlockGirlBackgroundEvent)
end

function net_player.notifyUnLockChatBackground(background)
	if table.indexOf(PlayerModule.PlayerInfo.unlockChatBackgrounds, background) == -1 then
		table.insert(PlayerModule.PlayerInfo.unlockChatBackgrounds, background)
	end

	EventDispatcher.Dispatch(EventID.UpdateChatBubbleEvent)
end

function net_player.savePlayerSettingResult_delegate(code, key, value)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)
	end

	SettingModule.OnChangeSettingResponse(code, key, value)
end

function net_player.dressUpRotateSwitchResult(code, value)
	RandomSecretaryModule.DressUpRotateSwitchResult(value)
end

function net_player.dressUpRotateListResult(code, ids)
	RandomSecretaryModule.DressUpRotateListResult(ids)
end
