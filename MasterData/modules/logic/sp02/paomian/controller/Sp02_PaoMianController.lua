-- chunkname: @modules/logic/sp02/paomian/controller/Sp02_PaoMianController.lua

module("modules.logic.sp02.paomian.controller.Sp02_PaoMianController", package.seeall)

local Sp02_PaoMianController = class("Sp02_PaoMianController", BaseController)

function Sp02_PaoMianController:openGuessMeView(actId, param)
	Activity238Rpc.instance:sendGetAct238InfoRequest(actId, function()
		ViewMgr.instance:openView(ViewName.Sp02_GuessMeView, param)
	end)
end

function Sp02_PaoMianController:openMarcusView(actId, param)
	Activity239Rpc.instance:sendGetAct239InfoRequest(actId, function()
		ViewMgr.instance:openView(ViewName.Sp02_MarcusView, param)
	end)
end

function Sp02_PaoMianController:openShopView(actId, goodsId)
	local param = {
		actId = actId,
		goodsId = goodsId
	}

	ViewMgr.instance:openView(ViewName.Sp02_PaoMian_ShopPanelView, param)
end

function Sp02_PaoMianController:isPlayedMarcusDesc(activityId, dayId)
	local key = string.format("%s_%s_%s", PlayerPrefsKey.Sp02MarcusPlayedDesc, activityId, dayId)
	local isPlayed = GameUtil.playerPrefsGetNumberByUserId(key, 0)

	return isPlayed and isPlayed ~= 0
end

function Sp02_PaoMianController:setPlayedMarcusDesc(activityId, dayId)
	local key = string.format("%s_%s_%s", PlayerPrefsKey.Sp02MarcusPlayedDesc, activityId, dayId)

	GameUtil.playerPrefsSetNumberByUserId(key, 1)
end

function Sp02_PaoMianController:getMarcusRemainTimeStr(actId)
	local timeStr = ""
	local activityCo = ActivityConfig.instance:getActivityCo(actId)
	local actMo = ActivityModel.instance:getActMO(actId)

	if not activityCo or not actMo then
		return timeStr
	end

	local status = ActivityHelper.getActivityStatus(actId)

	if status == ActivityEnum.ActivityStatus.NotOpen then
		local openTime = actMo and actMo:getRealStartTimeStamp() or 0
		local remainTime = openTime - ServerTime.now()

		timeStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("sp02_paomian_mainview_open"), TimeUtil.SecondToActivityTimeFormat(remainTime))
	elseif status == ActivityEnum.ActivityStatus.Normal then
		local nextOpenTime = Sp02_MarcusModel.instance:getNextOpenBonusTime(actId)

		if not nextOpenTime then
			timeStr = ActivityHelper.getActivityRemainTimeStr(actId)
		else
			local limitTimeStr = TimeUtil.SecondToActivityTimeFormat(nextOpenTime)

			timeStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("sp02_paomian_marcusentryitem_unlock"), limitTimeStr)
		end
	elseif status == ActivityEnum.ActivityStatus.NotUnlock then
		if activityCo and activityCo.openId ~= 0 then
			timeStr = OpenHelper.getActivityUnlockTxt(activityCo.openId)
		end
	else
		timeStr = luaLang("turnback_end")
	end

	return timeStr
end

function Sp02_PaoMianController:isShowWebEntry(actId)
	local isOpen = ActivityHelper.isOpen(actId)

	if not isOpen then
		return
	end

	if SettingsModel.instance:isZhRegion() then
		return SettingsModel.isBilibili() or SettingsModel.isOfficial()
	end

	return true
end

function Sp02_PaoMianController:isShowWebReddot()
	local webActId = ActivityEnum.Activity.SP02_PaoMianActivityWeb
	local reddotId = ActivityConfig.instance:getActivityRedDotId(webActId)
	local hasReddot = reddotId and reddotId ~= 0
	local isShow = hasReddot and self:isShowWebEntry(webActId) and self:getWebWeekFirstLoginRed()

	return isShow, reddotId
end

function Sp02_PaoMianController:setWebWeekFirstLoginRed()
	if self:isShowWebEntry(ActivityEnum.Activity.SP02_PaoMianActivityWeb) then
		local weekEndTime = self:getWeekEndTime()

		GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.Sp02PaoMainWebReddot, weekEndTime)
	end

	RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
end

function Sp02_PaoMianController:getWebWeekFirstLoginRed()
	local weekEndTime = self:getWeekEndTime()
	local cur_save = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.Sp02PaoMainWebReddot, 0)

	return cur_save ~= weekEndTime
end

function Sp02_PaoMianController:getWeekEndTime()
	local weekEndTime = ServerTime.getWeekEndTimeStamp(true)
	local timeOffset = weekEndTime - ServerTime.now()

	if timeOffset > 0 and timeOffset <= TimeUtil.OneDaySecond then
		weekEndTime = weekEndTime + TimeUtil.OneWeekSecond
	end

	return math.floor(weekEndTime / TimeUtil.OneHourSecond)
end

Sp02_PaoMianController.instance = Sp02_PaoMianController.New()

LuaEventSystem.addEventMechanism(Sp02_PaoMianController.instance)

return Sp02_PaoMianController
