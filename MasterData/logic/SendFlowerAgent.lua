-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sendflower/agent/SendFlowerAgent.lua

module("logic.extensions.sendflower.agent.SendFlowerAgent", package.seeall)

local SendFlowerAgent = class("SendFlowerAgent", BaseAgent)

function SendFlowerAgent:sendPM_GetHistoryInfoReq(targetUserId)
	local req = SendFlowerExtension_pb.PM_GetHistoryInfoReq()

	req.targetUserId = targetUserId

	self:sendMsg(req)
end

function SendFlowerAgent:handlePM_GetHistoryInfoRes(status, msg)
	if status == 0 then
		SendFlowerController.instance:handleOpenCharmValueView(msg)
	end
end

function SendFlowerAgent:sendPM_SendFlowerReq(targetUserId, flowerId, sendCount)
	local req = SendFlowerExtension_pb.PM_SendFlowerReq()

	req.targetUserId = targetUserId
	req.flowerId = flowerId
	req.sendCount = sendCount

	self:sendMsg(req)
end

function SendFlowerAgent:handlePM_SendFlowerRes(status, msg)
	if status == 0 then
		local changeSetId = msg.changeSetId

		MaterialController.instance:setChangeSetPopup(changeSetId, MaterialController.CI_SHOW_TYPE_FLY)
		GlobalDispatcher:dispatch(GlobalNotify.SendFlowerSuc)
	end
end

function SendFlowerAgent:sendPM_SupportFlowerReq(targetUserId)
	local req = SendFlowerExtension_pb.PM_SupportFlowerReq()

	req.targetUserId = targetUserId

	self:sendMsg(req)
end

function SendFlowerAgent:handlePM_SupportFlowerRes(status, msg)
	if status == 0 then
		local times = SendFlowerModel.instance:getDailySupporttimes()

		SendFlowerModel.instance:setDailySupporttimes(times + 1)
		GlobalDispatcher:dispatch(GlobalNotify.RankDataGet)
	end
end

function SendFlowerAgent:sendPM_GetFlowerSendRankReq()
	local req = SendFlowerExtension_pb.PM_GetFlowerSendRankReq()

	self:sendMsg(req)
end

function SendFlowerAgent:handlePM_GetFlowerSendRankRes(status, msg)
	if status == 0 then
		RankModel.instance:setRankData(msg, GameEnum.RankType.SendFlower_RANK, 4)
		GlobalDispatcher:dispatch(GlobalNotify.RankDataGet)
	end
end

function SendFlowerAgent:sendPM_GetFlowerCharmRankReq()
	local req = SendFlowerExtension_pb.PM_GetFlowerCharmRankReq()

	self:sendMsg(req)
end

function SendFlowerAgent:handlePM_GetFlowerCharmRankRes(status, msg)
	if status == 0 then
		local dailysupporttimes = msg.dailySupportTimes

		RankModel.instance:setRankData(msg, GameEnum.RankType.SendFlower_RANK, 3)
		SendFlowerModel.instance:setDailySupporttimes(dailysupporttimes)
		GlobalDispatcher:dispatch(GlobalNotify.RankDataGet)
	end
end

function SendFlowerAgent:sendPM_GetFlowerRecordReq(type)
	local req = SendFlowerExtension_pb.PM_GetFlowerRecordReq()

	req.type = type

	self:sendMsg(req)
end

function SendFlowerAgent:handlePM_GetFlowerRecordRes(status, msg)
	if status == 0 then
		SendFlowerController.instance:handleGetRecord(msg)
	end
end

function SendFlowerAgent:sendPM_GetIndividualRankReq(flowerId)
	local req = SendFlowerExtension_pb.PM_GetIndividualRankReq()

	req.flowerId = flowerId

	self:sendMsg(req)
end

function SendFlowerAgent:handlePM_GetIndividualRankRes(status, msg)
	if status == 0 then
		SendFlowerController.instance:handleIndividualRankRes(msg)
	end
end

function SendFlowerAgent:handlePM_NotifyReceiveFlowerRes(status, msg)
	if status == 0 then
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_GET_FLOWER, true)
	end
end

SendFlowerAgent.instance = SendFlowerAgent.New()

return SendFlowerAgent
