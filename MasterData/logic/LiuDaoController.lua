-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liudao/controller/LiuDaoController.lua

module("logic.extensions.liudao.controller.LiuDaoController", package.seeall)

local LiuDaoController = class("LiuDaoController", BaseController)

function LiuDaoController:ctor()
	return
end

function LiuDaoController:onInit()
	GlobalDispatcher:addListener(LiuDaoAgent.handlePM_LiuDaoGetInfoRes, self.handlePM_LiuDaoGetInfoRes, self)
	GlobalDispatcher:addListener(LiuDaoAgent.handlePM_LiuDaoRefreshStageRes, self.handlePM_LiuDaoRefreshStageRes, self)
	GlobalDispatcher:addListener(LiuDaoAgent.handlePM_LiuDaoChallengeRes, self.handlePM_LiuDaoChallengeRes, self)
	GlobalDispatcher:addListener(LiuDaoAgent.handlePM_LiuDaoNotifyChallengeRes, self.handlePM_LiuDaoNotifyChallengeRes, self)
	GlobalDispatcher:addListener(LiuDaoAgent.handlePM_LiuDaoGetTaskInfoRes, self.handlePM_LiuDaoGetTaskInfoRes, self)
	GlobalDispatcher:addListener(LiuDaoAgent.handlePM_LiuDaoGainTaskPrizeRes, self.handlePM_LiuDaoGainTaskPrizeRes, self)
	GlobalDispatcher:addListener(LiuDaoAgent.handlePM_LiuDaoGainProgressPrizeRes, self.handlePM_LiuDaoGainProgressPrizeRes, self)
end

function LiuDaoController:onReset()
	return
end

function LiuDaoController:sendPM_LiuDaoGetInfoReq(activityId)
	LiuDaoModel.instance:setActivityId(activityId)
	LiuDaoAgent.instance:sendPM_LiuDaoGetInfoReq(activityId)
end

function LiuDaoController:handlePM_LiuDaoGetInfoRes(status, msg)
	LiuDaoModel.instance:SetStageData(msg)
	GlobalDispatcher:dispatch(GlobalNotify.LiuDaoGetInfoRes)
end

function LiuDaoController:handlePM_LiuDaoRefreshStageRes(status, msg)
	local stageindex = msg.stageIndex
	local stageid = msg.stageId
	local curtimes = msg.curTimes

	LiuDaoModel.instance:refreshMonster(stageindex + 1, stageid, curtimes)
	GlobalDispatcher:dispatch(GlobalNotify.LiuDaoRefreshStageRes, stageindex)
end

function LiuDaoController:handlePM_LiuDaoChallengeRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.LiuDaoChallengeRes)
end

function LiuDaoController:handlePM_LiuDaoNotifyChallengeRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.LiuDaoNotifyChallengeRes)

	if msg.win == true then
		if msg.changeSetId ~= nil then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
		end

		if msg.doubledChangeSetId ~= nil then
			BattleSettlementModel.instance:setRewardChangeSetId(msg.doubledChangeSetId, true)
		end
	end

	UIJumper.instance:pushOneStack(ViewName.LiuDaoMainView, true)
end

function LiuDaoController:sendPM_LiuDaoGetTaskInfoReq(activityId)
	LiuDaoModel.instance:setActivityId(activityId)
	LiuDaoAgent.instance:sendPM_LiuDaoGetTaskInfoReq(activityId)
end

function LiuDaoController:handlePM_LiuDaoGetTaskInfoRes(status, msg)
	LiuDaoModel.instance:SetTaskData(msg)
	GlobalDispatcher:dispatch(GlobalNotify.LiuDaoGetTaskInfoRes)
end

function LiuDaoController:handlePM_LiuDaoGainTaskPrizeRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.LiuDaoGainTaskPrizeRes)
end

function LiuDaoController:handlePM_LiuDaoGainProgressPrizeRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.LiuDaoGainProgressPrizeRes)
end

LiuDaoController.instance = LiuDaoController.New()

return LiuDaoController
