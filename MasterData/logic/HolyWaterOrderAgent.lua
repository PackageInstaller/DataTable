-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holywaterorder/agent/HolyWaterOrderAgent.lua

module("logic.extensions.holywaterorder.agent.HolyWaterOrderAgent", package.seeall)

local HolyWaterOrderAgent = class("HolyWaterOrderAgent")

module("logic.extensions.holywaterorder.agent.HolyWaterOrderAgent", package.seeall)

local HolyWaterOrderAgent = class("HolyWaterOrderAgent", BaseAgent)

function HolyWaterOrderAgent:sendPM_HolyWaterOrderInfoReq(activityId)
	local req = HolyWaterOrderChallengeExtension_pb.PM_HolyWaterOrderInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HolyWaterOrderAgent:handlePM_HolyWaterOrderInfoRes(status, msg)
	if status == 0 then
		HolyWaterOrderModel.instance:onInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.HolyWaterOrderInfoRes)
	end
end

function HolyWaterOrderAgent:sendPM_HolyWaterOrderSelectPetsReq(activityId, petIds)
	local req = HolyWaterOrderChallengeExtension_pb.PM_HolyWaterOrderSelectPetsReq()

	req.activityId = activityId

	if petIds then
		for i, v in ipairs(petIds) do
			req.petIds:append(v)
		end
	end

	self:sendMsg(req)

	self._petIds = petIds
end

function HolyWaterOrderAgent:handlePM_HolyWaterOrderSelectPetsRes(status, msg)
	if status == 0 then
		HolyWaterOrderModel.instance:onSelectPetsRes(self._petIds)

		self._petIds = nil

		GlobalDispatcher:dispatch(GlobalNotify.HolyWaterOrderSelectPetsRes)
	end
end

function HolyWaterOrderAgent:sendPM_HolyWaterOrderChallengeReq(activityId, stageId, difficulty, form)
	local req = HolyWaterOrderChallengeExtension_pb.PM_HolyWaterOrderChallengeReq()

	req.activityId = activityId
	req.stageId = stageId
	req.difficulty = difficulty

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function HolyWaterOrderAgent:handlePM_HolyWaterOrderChallengeRes(status, msg)
	if status == 0 then
		HolyWaterOrderModel.instance:onChallengeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.HolyWaterOrderChallengeRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function HolyWaterOrderAgent:sendPM_HolyWaterOrderResetReq(activityId)
	local req = HolyWaterOrderChallengeExtension_pb.PM_HolyWaterOrderResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HolyWaterOrderAgent:handlePM_HolyWaterOrderResetRes(status, msg)
	if status == 0 then
		HolyWaterOrderModel.instance:onResetRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.HolyWaterOrderResetRes)
	end
end

function HolyWaterOrderAgent:sendPM_HolyWaterOrderConfirmRecordReq(randomNumber)
	local req = HolyWaterOrderChallengeExtension_pb.PM_HolyWaterOrderConfirmRecordReq()

	req.randomNumber = randomNumber

	self:sendMsg(req)
end

function HolyWaterOrderAgent:handlePM_HolyWaterOrderConfirmRecordRes(status, msg)
	if status == 0 then
		HolyWaterOrderModel.instance:onConfirmRecordRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.HolyWaterOrderConfirmRecordRes)
	end
end

function HolyWaterOrderAgent:handlePM_HolyWaterOrderNotifyChallengeResultRes(status, msg)
	if status == 0 then
		HolyWaterOrderModel.instance:onNotifyChallengeResultRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.HolyWaterOrderNotifyChallengeResultRes)
	end
end

function HolyWaterOrderAgent:sendPM_HolyWaterOrderActivityRankReq(activityId)
	local req = HolyWaterOrderChallengeExtension_pb.PM_HolyWaterOrderActivityRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HolyWaterOrderAgent:handlePM_HolyWaterOrderActivityRankRes(status, msg)
	if status == 0 then
		HolyWaterOrderModel.instance:onActivityRankRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.HolyWaterOrderActivityRankRes)
	end
end

function HolyWaterOrderAgent:sendPM_HolyWaterOrderDailyRankReq(activityId)
	local req = HolyWaterOrderChallengeExtension_pb.PM_HolyWaterOrderDailyRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HolyWaterOrderAgent:handlePM_HolyWaterOrderDailyRankRes(status, msg)
	if status == 0 then
		HolyWaterOrderModel.instance:onDailyRankRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.HolyWaterOrderDailyRankRes)
	end
end

HolyWaterOrderAgent.instance = HolyWaterOrderAgent.New()

return HolyWaterOrderAgent
