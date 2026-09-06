-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luoshiqiordeal/controller/LuoShiQiOrdealController.lua

module("logic.extensions.luoshiqiordeal.controller.LuoShiQiOrdealController", package.seeall)

local LuoShiQiOrdealController = class("LuoShiQiOrdealController", BaseController)

LuoShiQiOrdealController.EnterGame = "onetouchdrawview_first"

function LuoShiQiOrdealController:ctor()
	return
end

function LuoShiQiOrdealController:onInit()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._updateInfo, self)
end

function LuoShiQiOrdealController:showRewards()
	local changeSetId = LuoShiQiOrdealModel.instance:getChangeSetId()

	MaterialController.instance:showChangeSetInTemp(changeSetId)
end

function LuoShiQiOrdealController:isFirstEnterGame()
	local isEntered = GameUtil.getUserData(LuoShiQiOrdealController.EnterGame)

	if isEntered then
		return false
	else
		return true
	end
end

function LuoShiQiOrdealController:markFirstEnterGame()
	GameUtil.saveUserData(LuoShiQiOrdealController.EnterGame, true)
end

function LuoShiQiOrdealController:_updateInfo()
	self:_resetModel()
end

function LuoShiQiOrdealController:_resetModel()
	local curDate = GameUtil.time2date(ServerTime.now())

	if curDate.year == 2022 then
		local activityId = LuoShiQiOrdealModel.instance:getActivityId()

		printInfo("test LuoShiQiOrdealController:_resetModel1", activityId)

		local cfg = LuoShiQiOrdealConfig.instance:getCrazyGameCfg(activityId)

		if cfg then
			local startDate = GameUtil.string2date(cfg.startTime)

			if startDate.year == curDate.year and startDate.month == curDate.month and startDate.day == curDate.day then
				printInfo("test LuoShiQiOrdealController:_resetModel2", cfg.startTime)
				LuoShiQiOrdealModel.instance:onReset()
				UIStateManager.instance:closeAllModalViews()
				GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoBirthdayChangeActivity)

				local content = "本期活动已结束，请重新进入界面！"

				local function func()
					UIStateManager.instance:popByName(ViewName.LsqOrdealBoxGameView)
					UIStateManager.instance:popByName(ViewName.LsqOrdealLevelView)
					UIStateManager.instance:popByName(ViewName.OneTouchDrawView)
					UIStateManager.instance:popByName(ViewName.LsqOrdealRankView)
				end

				TipsFacade.instance:openTipWindowNoX(lang("tip"), content, func, btnText)
			end
		end
	end
end

function LuoShiQiOrdealController:sendPM_XiaoNuoBirthdaySweepNormalGameReq(activityId, diffLv, score, times)
	XiaoNuoBirthdayGiftAgent.instance:sendPM_XiaoNuoBirthdaySweepNormalGameReq(activityId, diffLv, score, times)
end

function LuoShiQiOrdealController:handlePM_XiaoNuoBirthdaySweepNormalGameRes(msg)
	LuoShiQiOrdealModel.instance:handlePM_XiaoNuoBirthdaySweepNormalGameRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_XiaoNuoBirthdaySweepNormalGameRes)
end

function LuoShiQiOrdealController:sendPM_XiaoNuoBirthdaySweepCrazyGameReq(activityId, stageNum, times)
	XiaoNuoBirthdayGiftAgent.instance:sendPM_XiaoNuoBirthdaySweepCrazyGameReq(activityId, stageNum, times)
end

function LuoShiQiOrdealController:handlePM_XiaoNuoBirthdaySweepCrazyGameRes(msg)
	LuoShiQiOrdealModel.instance:handlePM_XiaoNuoBirthdaySweepCrazyGameRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_XiaoNuoBirthdaySweepCrazyGameRes)
end

function LuoShiQiOrdealController:getMaxScoreCrazy(activityId)
	local maxNumCrazy = LuoShiQiOrdealModel.instance:getMaxNumCrazy()
	local crazyGameCfg = LuoShiQiOrdealConfig.instance:getCrazyGameCfg(activityId)
	local crazyScorePlan = crazyGameCfg and crazyGameCfg.crazyScorePlan

	if crazyScorePlan then
		local scorePlanCfg = LuoShiQiOrdealConfig.instance:getCrazyScorePlan(crazyScorePlan, maxNumCrazy)

		if scorePlanCfg then
			if not scorePlanCfg.score then
				return 0
			end
		end
	end

	return 0
end

LuoShiQiOrdealController.instance = LuoShiQiOrdealController.New()

return LuoShiQiOrdealController
