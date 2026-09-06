-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/maintainpowerpilla/agent/MaintainPowerPillaAgent.lua

module("logic.extensions.maintainpowerpilla.agent.MaintainPowerPillaAgent", package.seeall)

local MaintainPowerPillaAgent = class("MaintainPowerPillaAgent", BaseAgent)

function MaintainPowerPillaAgent:sendPM_MPPGetActInfoReq(activityId)
	local req = MaintainPowerPillaExtension_pb.PM_MPPGetActInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MaintainPowerPillaAgent:handlePM_MPPGetActInfoRes(status, msg)
	if status == 0 then
		PowerPillaModel.instance:onMPPGetActInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.MPPGetActInfoRes)
	end
end

function MaintainPowerPillaAgent:sendPM_MPPGetGameInfoReq(activityId, stageId)
	local req = MaintainPowerPillaExtension_pb.PM_MPPGetGameInfoReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function MaintainPowerPillaAgent:handlePM_MPPGetGameInfoRes(status, msg)
	if status == 0 then
		PowerPillaModel.instance:onMPPGetGameInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.MPPGetGameInfoRes)
	end
end

function MaintainPowerPillaAgent:sendPM_MPPSaveLocationReq(activityId, stageId, gridId)
	local req = MaintainPowerPillaExtension_pb.PM_MPPSaveLocationReq()

	req.activityId = activityId
	req.stageId = stageId
	req.gridId = gridId
	self._saveLocationGridId = gridId

	self:sendMsg(req)
end

function MaintainPowerPillaAgent:handlePM_MPPSaveLocationRes(status, msg)
	if status == 0 then
		if self._saveLocationGridId then
			PowerPillaModel.instance:onMPPSaveLocationRes(self._saveLocationGridId)

			self._saveLocationGridId = nil
		end

		GlobalDispatcher:dispatch(GlobalNotify.MPPSaveLocationRes)
	end
end

function MaintainPowerPillaAgent:sendPM_MPPGainDailyPrizeReq(activityId)
	local req = MaintainPowerPillaExtension_pb.PM_MPPGainDailyPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MaintainPowerPillaAgent:handlePM_MPPGainDailyPrizeRes(status, msg)
	if status == 0 then
		PowerPillaModel.instance:onMPPGainDailyPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.MPPGainDailyPrizeRes)
	end
end

function MaintainPowerPillaAgent:sendPM_MPPDoGridEventReq(activityId, stageId, eventGridId, playerGridId, form, param)
	local req = MaintainPowerPillaExtension_pb.PM_MPPDoGridEventReq()

	req.activityId = activityId
	req.stageId = stageId
	req.gridId = eventGridId
	req.curGrid.stageId = stageId
	req.curGrid.gridId = playerGridId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	if not string.nilorempty(param) then
		req.param = param
	end

	self:sendMsg(req)
end

function MaintainPowerPillaAgent:handlePM_MPPDoGridEventRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.MPPDoGridEventRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function MaintainPowerPillaAgent:sendPM_MPPGetBuffInfoReq(activityId)
	local req = MaintainPowerPillaExtension_pb.PM_MPPGetBuffInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MaintainPowerPillaAgent:handlePM_MPPGetBuffInfoRes(status, msg)
	if status == 0 then
		PowerPillaModel.instance:onMPPGetBuffInfoRes(msg)
		PowerPillaController.instance:updateBuffRed()
		GlobalDispatcher:dispatch(GlobalNotify.MPPGetBuffInfoRes)
	end
end

function MaintainPowerPillaAgent:sendPM_MPPUpgradeBuffReq(activityId, buffType)
	local req = MaintainPowerPillaExtension_pb.PM_MPPUpgradeBuffReq()

	req.activityId = activityId
	req.buffType = buffType

	self:sendMsg(req)
end

function MaintainPowerPillaAgent:handlePM_MPPUpgradeBuffRes(status, msg)
	if status == 0 then
		PowerPillaModel.instance:onMPPUpgradeBuffRes(msg)
		PowerPillaController.instance:updateBuffRed()
		GlobalDispatcher:dispatch(GlobalNotify.MPPUpgradeBuffRes)
	end
end

function MaintainPowerPillaAgent:sendPM_MPPGainStagePrizeReq(activityId, stageId)
	local req = MaintainPowerPillaExtension_pb.PM_MPPGainStagePrizeReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)

	self._stageId = stageId
end

function MaintainPowerPillaAgent:sendPM_ResetBuffReq(activityId)
	local req = MaintainPowerPillaExtension_pb.PM_ResetBuffReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MaintainPowerPillaAgent:handlePM_ResetBuffRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.MPPUpgradeBuffResetRes)
	end
end

function MaintainPowerPillaAgent:handlePM_MPPGainStagePrizeRes(status, msg)
	if status == 0 then
		if self._stageId then
			PowerPillaModel.instance:onMPPGainStagePrizeRes(self._stageId)
		end

		GlobalDispatcher:dispatch(GlobalNotify.MPPGainStagePrizeRes)
	end
end

function MaintainPowerPillaAgent:handlePM_MPPDoGridEventEndRes(status, msg)
	if status == 0 then
		if msg:HasField("challengeChangeSetId") then
			BattleSettlementModel.instance:setChangeSetId(msg.challengeChangeSetId)
		end

		PowerPillaController.instance:checkBoxEvent(msg)
		PowerPillaModel.instance:onMPPDoGridEventEndRes(msg)
		PowerPillaController.instance:updateBuffRed()
		GlobalDispatcher:dispatch(GlobalNotify.MPPDoGridEventEndRes, msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function MaintainPowerPillaAgent:sendPM_MPPUnlockStoryReq(activityId)
	local req = MaintainPowerPillaExtension_pb.PM_MPPUnlockStoryReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MaintainPowerPillaAgent:handlePM_MPPUnlockStoryRes(status, msg)
	if status == 0 then
		PowerPillaModel.instance:onUnlockStoryRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.MPPUnlockStoryRes)
	end
end

MaintainPowerPillaAgent.instance = MaintainPowerPillaAgent.New()

return MaintainPowerPillaAgent
