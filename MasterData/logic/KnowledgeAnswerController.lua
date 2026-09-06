-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/knowledgeanswer/controller/KnowledgeAnswerController.lua

module("logic.extensions.knowledgeanswer.controller.KnowledgeAnswerController", package.seeall)

local KnowledgeAnswerController = class("KnowledgeAnswerController", BaseController)

function KnowledgeAnswerController:ctor()
	return
end

function KnowledgeAnswerController:onReset()
	return
end

function KnowledgeAnswerController:getInfo(activityId)
	KnowledgeAnswerAgent.instance:sendPM_KnowledgeAnswerInfoReq(activityId)
end

function KnowledgeAnswerController:handleGetInfo(msg)
	KnowledgeAnswerModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.KnowledgeAnswerUpdateInfo)
end

function KnowledgeAnswerController:sendAnswer(activityId, questionId, optionId)
	KnowledgeAnswerAgent.instance:sendPM_KnowledgeAnswerReq(activityId, questionId, optionId)
end

function KnowledgeAnswerController:handleSendAnswer(msg)
	GlobalDispatcher:dispatch(GlobalNotify.KnowledgeAnswerSendAnswer, msg)
end

function KnowledgeAnswerController:gainPrize(activityId, prizeId)
	KnowledgeAnswerAgent.instance:sendPM_KnowledgeAnswerGainScorePrizeReq(activityId, prizeId)
end

function KnowledgeAnswerController:handleGainPrize(msg)
	KnowledgeAnswerModel.instance:onGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.KnowledgeAnswerUpdateInfo)
end

function KnowledgeAnswerController:seekHelp(activityId, type)
	KnowledgeAnswerAgent.instance:sendPM_KnowledgeAnswerSeekHelpReq(activityId, type)
end

function KnowledgeAnswerController:handleSeekHelp(msg)
	KnowledgeAnswerModel.instance:onSeekHelp(msg)
	GlobalDispatcher:dispatch(GlobalNotify.KnowledgeAnswerSeekHelp, msg)
end

function KnowledgeAnswerController:joinRoom(activityId)
	local actCfg = KnowledgeAnswerConfig.instance:getActivityCfgById(activityId)

	if actCfg then
		local startTime = actCfg.startTime
		local endTime = actCfg.endTime

		if GameUtil.checkIsInTimePeriod(startTime, endTime, true) then
			local baseInfo = KnowledgeAnswerModel.instance:getBaseInfoByActId(activityId)

			if baseInfo.report.anwerTimes >= actCfg.dailyAnswerTimes then
				TipsFacade.instance:openCommonTips("今日答题已完成，明日再来")
			else
				KnowledgeAnswerAgent.instance:sendPM_KnowledgeAnswerJoinRoomReq(activityId)
			end
		else
			TipsFacade.instance:openCommonTips(string.format("每日开放时间：%s - %s", startTime, endTime))
		end
	end
end

function KnowledgeAnswerController:handleJoinRoom(msg)
	local info = GameUtil.pbToTable(msg)

	UIStateManager.instance:push(ViewName.KnowledgeAnswerView, info)
end

function KnowledgeAnswerController:leaveRoom(activityId)
	KnowledgeAnswerAgent.instance:sendPM_KnowledgeAnswerLeaveRoomReq(activityId)
end

function KnowledgeAnswerController:handleLeaveRoom(msg)
	UIStateManager.instance:popByName(ViewName.KnowledgeAnswerView)
end

function KnowledgeAnswerController:notifyUpdateNewQuestion(msg)
	GlobalDispatcher:dispatch(GlobalNotify.KnowledgeAnswerPuzzlesRefresh, msg)
end

function KnowledgeAnswerController:notifyAnswerQuestion(msg)
	GlobalDispatcher:dispatch(GlobalNotify.KnowledgeAnswerPuzzlesSettlement, msg)
end

function KnowledgeAnswerController:notifyUpdateRoomMembers(msg)
	local info = GameUtil.pbToTable(msg)

	GlobalDispatcher:dispatch(GlobalNotify.KnowledgeAnswerUpdateMemberInfo, info.members)
end

KnowledgeAnswerController.instance = KnowledgeAnswerController.New()

return KnowledgeAnswerController
