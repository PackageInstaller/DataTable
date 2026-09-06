-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lanternfestival/controller/LanternFestivalController.lua

module("logic.extensions.lanternfestival.controller.LanternFestivalController", package.seeall)

local LanternFestivalController = class("LanternFestivalController", BaseController)

LanternFestivalController.MAIN_UI_CHANNEL_RED_POINT_1 = "LanternFestival_MainUI_Channel_RedPoint_1"
LanternFestivalController.MAIN_UI_CHANNEL_RED_POINT_2 = "LanternFestival_MainUI_Channel_RedPoint_2"

function LanternFestivalController:onInit()
	self:onReset()
end

function LanternFestivalController:onReset()
	return
end

function LanternFestivalController:getInfo(activityId)
	LanternFestivalAgent.instance:sendPM_LanternFestivalGetInfoReq(activityId)
end

function LanternFestivalController:handlePM_LanternFestivalGetInfoRes(msg)
	LanternFestivalModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LanternFestivalInfoRes)
	self:updateMainUIRedPoint()
end

function LanternFestivalController:answerChannelQuestion(activityId, answer)
	LanternFestivalAgent.instance:sendPM_LanternFestivalAnswerChannelQuestionPeq(activityId, answer)
end

function LanternFestivalController:handlePM_LanternFestivalAnswerChannelQuestionPes(msg)
	LanternFestivalModel.instance:onAnswerChannelQuestion(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LanternFestivalAnswerChannelQuestionRes)
	self:updateMainUIRedPoint()
end

function LanternFestivalController:finishPersionQuestion(activityId)
	LanternFestivalAgent.instance:sendPM_LanternFestivalfinishPersionQuestionPeq(activityId)
end

function LanternFestivalController:handlePM_LanternFestivalfinishPersionQuestionPes(msg)
	LanternFestivalModel.instance:onfinishPersionQuestion(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LanternFestivalFinishPersionQuestionRes)
end

function LanternFestivalController:gainExtPrize(activityId)
	LanternFestivalAgent.instance:sendPM_LanternFestivalGainExtPrizeReq(activityId)
end

function LanternFestivalController:handlePM_LanternFestivalGainExtPrizeRes(msg)
	LanternFestivalModel.instance:onGainExtPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LanternFestivalGainExtPrizeRes)
end

function LanternFestivalController:exchangeCollectPrize(activityId, prizeId)
	LanternFestivalAgent.instance:sendPM_LanternFestivalExchangeCollectPrizeReq(activityId, prizeId)
end

function LanternFestivalController:handlePM_LanternFestivalExchangeCollectPrizeRes(msg)
	LanternFestivalModel.instance:onExchangeCollectPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LanternFestivalExchangeCollectPrizeRes)
end

function LanternFestivalController:getCurrentWeekDay()
	local nowTime = ServerTime.now() - GameUtil.SERVER_TICK_DAILYR_EFRESH * 3600
	local timetable = GameUtil.time2date(nowTime)

	return timetable.wday - 1
end

function LanternFestivalController:getCurActId()
	return 566001
end

function LanternFestivalController:isShowInChatChannel()
	local curActId = self:getCurActId()

	return ActivityDefineController.instance:checkIsInActivityTimeByActivityId(curActId)
end

function LanternFestivalController:loadLanternFestival()
	local curActId = self:getCurActId()

	if not self:isShowInChatChannel() then
		return
	end

	self:getInfo(curActId)
end

function LanternFestivalController:updateMainUIRedPoint()
	RedPointController.instance:setRedPointInfo(LanternFestivalController.MAIN_UI_CHANNEL_RED_POINT_1, false, true)
	RedPointController.instance:setRedPointInfo(LanternFestivalController.MAIN_UI_CHANNEL_RED_POINT_2, false, true)

	local curActId = self:getCurActId()
	local info = LanternFestivalModel.instance:getInfoByActId(curActId)
	local curAnwerCount = 0

	if not info then
		return
	end

	curAnwerCount = info.todayChannelPrizeTimes or 0

	local actCfg = LanternFestivalConfig.instance:getActivityCfg(curActId)

	if (actCfg and actCfg.dailyChannelPrizeLimit or 0) <= curAnwerCount then
		return
	end

	local groupCfgs = LanternFestivalConfig.instance:getGroupCfgs(curActId) or {}

	for i, cfg in ipairs(groupCfgs) do
		if not cfg.openTime then
			local openTime = ""
			local timeStrs = string.split(openTime, "#")
			local startTime = GameUtil.string2time("0-0-0 " .. timeStrs[1])
			local endTime = GameUtil.string2time("0-0-0 " .. timeStrs[2])

			if endTime <= startTime then
				endTime = endTime + 86400
			end

			if i == 1 then
				RedPointController.instance:setRedPointInfo(LanternFestivalController.MAIN_UI_CHANNEL_RED_POINT_1, true, true, startTime, endTime)
			elseif i == 2 then
				RedPointController.instance:setRedPointInfo(LanternFestivalController.MAIN_UI_CHANNEL_RED_POINT_2, true, true, startTime, endTime)
			end
		end
	end
end

LanternFestivalController.instance = LanternFestivalController.New()

return LanternFestivalController
