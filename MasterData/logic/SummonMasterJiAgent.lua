-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterji/agent/SummonMasterJiAgent.lua

module("logic.extensions.summonmasterji.agent.SummonMasterJiAgent", package.seeall)

local SummonMasterJiAgent = class("SummonMasterJiAgent", BaseAgent)

function SummonMasterJiAgent:sendPM_SummonMasterJiGetInfoReq(activityId)
	local req = SummonMasterJiExtension_pb.PM_SummonMasterJiGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SummonMasterJiAgent:handlePM_SummonMasterJiGetInfoRes(status, msg)
	if status == 0 then
		SummonMasterJiModel.instance:onSummonMasterJiGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SummonMasterJiGetInfoRes, msg.activityId)
	end
end

function SummonMasterJiAgent:sendPM_SummonMasterJiChallengeExtremeReq(activityId, stageId, itemId2Score, form)
	local req = SummonMasterJiExtension_pb.PM_SummonMasterJiChallengeExtremeReq()

	req.activityId = activityId
	req.stageId = stageId

	for i, v in ipairs(itemId2Score) do
		local item = req.itemId2Score:add()

		item.left = v.left
		item.right = v.right
	end

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)

	self._extremeActivityId = activityId
	self._extremeStageId = stageId
end

function SummonMasterJiAgent:handlePM_SummonMasterJiChallengeExtremeRes(status, msg)
	if status == 0 then
		SummonMasterJiModel.instance:onSummonMasterJiChallengeExtremeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SummonMasterJiChallengeExtremeRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function SummonMasterJiAgent:sendPM_SummonMasterJiResetExtremeReq(activityId)
	local req = SummonMasterJiExtension_pb.PM_SummonMasterJiResetExtremeReq()

	req.activityId = activityId

	self:sendMsg(req)

	self._resetActivityId = activityId
end

function SummonMasterJiAgent:handlePM_SummonMasterJiResetExtremeRes(status, msg)
	if status == 0 then
		SummonMasterJiModel.instance:onSummonMasterJiResetExtremeRes(msg, self._resetActivityId)
		GlobalDispatcher:dispatch(GlobalNotify.SummonMasterJiResetExtremeRes)
	end

	self._resetActivityId = nil
end

function SummonMasterJiAgent:sendPM_SummonMasterJiChallengeNormalReq(activityId, stageId, blessingId, form)
	local req = SummonMasterJiExtension_pb.PM_SummonMasterJiChallengeNormalReq()

	req.activityId = activityId
	req.stageId = stageId
	req.blessingId = blessingId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)

	self._normalActivityId = activityId
	self._normalStageId = stageId
end

function SummonMasterJiAgent:handlePM_SummonMasterJiChallengeNormalRes(status, msg)
	if status == 0 then
		SummonMasterJiModel.instance:onSummonMasterJiChallengeNormalRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SummonMasterJiChallengeNormalRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function SummonMasterJiAgent:sendPM_SummonMasterJiOneKeyPassNormalReq(activityId)
	local req = SummonMasterJiExtension_pb.PM_SummonMasterJiOneKeyPassNormalReq()

	req.activityId = activityId

	self:sendMsg(req)

	self._oneKeyActivityId = activityId
end

function SummonMasterJiAgent:handlePM_SummonMasterJiOneKeyPassNormalRes(status, msg)
	if status == 0 then
		SummonMasterJiModel.instance:onSummonMasterJiOneKeyPassNormalRes(msg, self._oneKeyActivityId)
		GlobalDispatcher:dispatch(GlobalNotify.SummonMasterJiOneKeyPassNormalRes, self._oneKeyActivityId)
	end

	self._oneKeyActivityId = nil
end

function SummonMasterJiAgent:handlePM_Notify_SummonMasterJiChallengeExtremeRes(status, msg)
	if status == 0 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
		SummonMasterJiModel.instance:onNotify_SummonMasterJiChallengeExtremeRes(msg, self._extremeActivityId, self._extremeStageId)
		GlobalDispatcher:dispatch(GlobalNotify.Notify_SummonMasterJiChallengeExtremeRes, self._extremeActivityId, self._extremeStageId)
	end

	self._extremeActivityId = nil
	self._extremeStageId = nil
end

function SummonMasterJiAgent:handlePM_Notify_SummonMasterJiChallengeNormalRes(status, msg)
	if status == 0 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
		SummonMasterJiModel.instance:onNotify_SummonMasterJiChallengeNormalRes(msg, self._normalActivityId, self._normalStageId)
		GlobalDispatcher:dispatch(GlobalNotify.Notify_SummonMasterJiChallengeNormalRes, self._normalActivityId)
	end

	self._normalActivityId = nil
	self._normalStageId = nil
end

SummonMasterJiAgent.instance = SummonMasterJiAgent.New()

return SummonMasterJiAgent
