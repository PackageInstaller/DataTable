-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/agent/SummonMasterTowerAgent.lua

module("logic.extensions.summontower.agent.SummonMasterTowerAgent", package.seeall)

local SummonMasterTowerAgent = class("SummonMasterTowerAgent", BaseAgent)

function SummonMasterTowerAgent:sendPM_SMTGetActInfoReq(activityId)
	local req = SummonMasterTowerExtension_pb.PM_SMTGetActInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SummonMasterTowerAgent:handlePM_SMTGetActInfoRes(status, msg)
	if status == 0 then
		SummontowerController.instance:onActivityInfo(msg)
	end
end

function SummonMasterTowerAgent:sendPM_SMTChooseSummonMasterReq(activityId, creepsId)
	local req = SummonMasterTowerExtension_pb.PM_SMTChooseSummonMasterReq()

	req.activityId = activityId
	req.creepsId = creepsId

	self:sendMsg(req)
end

function SummonMasterTowerAgent:handlePM_SMTChooseSummonMasterRes(status, msg)
	if status == 0 then
		SummontowerController.instance:onSelectSummonMaster(msg)
	end
end

function SummonMasterTowerAgent:sendPM_SMTSweepReq(activityId, useGameTimes)
	local req = SummonMasterTowerExtension_pb.PM_SMTSweepReq()

	req.activityId = activityId
	req.useGameTimes = useGameTimes

	self:sendMsg(req)
end

function SummonMasterTowerAgent:handlePM_SMTSweepRes(status, msg)
	if status == 0 then
		SummontowerController.instance:onSweepRespond(msg)
	end
end

function SummonMasterTowerAgent:sendPM_SMTBuyGameTimesReq(activityId)
	local req = SummonMasterTowerExtension_pb.PM_SMTBuyGameTimesReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SummonMasterTowerAgent:handlePM_SMTBuyGameTimesRes(status, msg)
	if status == 0 then
		SummontowerController.instance:onBuyPlayTimesRespond(msg)
	end
end

function SummonMasterTowerAgent:sendPM_SMTGainFirstPassPrizeReq(activityId, prizeId)
	local req = SummonMasterTowerExtension_pb.PM_SMTGainFirstPassPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function SummonMasterTowerAgent:handlePM_SMTGainFirstPassPrizeRes(status, msg)
	if status == 0 then
		SummontowerController.instance:onGainFirstPassPrize(msg)
	end
end

function SummonMasterTowerAgent:sendPM_SMTGetRankInfoReq(activityId)
	local req = SummonMasterTowerExtension_pb.PM_SMTGetRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SummonMasterTowerAgent:handlePM_SMTGetRankInfoRes(status, msg)
	if status == 0 then
		SummontowerController.instance:onGetRankInfoMsg(msg)
	end
end

function SummonMasterTowerAgent:sendPM_SMTGetGameInfoReq(activityId)
	local req = SummonMasterTowerExtension_pb.PM_SMTGetGameInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SummonMasterTowerAgent:handlePM_SMTGetGameInfoRes(status, msg)
	if status == 0 then
		SummontowerController.instance:onGameInfo(msg)
	end
end

function SummonMasterTowerAgent:sendPM_SMTDoGridEventReq(activityId, gridId, param)
	local req = SummonMasterTowerExtension_pb.PM_SMTDoGridEventReq()

	req.activityId = activityId
	req.gridId = gridId

	if param then
		req.param:ParseFromString(param:SerializeToString())
	end

	SummontowerController.instance:setOpGridId(gridId)
	self:sendMsg(req)
end

function SummonMasterTowerAgent:handlePM_SMTDoGridEventRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function SummonMasterTowerAgent:handlePM_SMTDoGridEventEndRes(status, msg)
	if status == 0 then
		SummontowerController.instance:onDoGridEvent(msg)
	end
end

SummonMasterTowerAgent.instance = SummonMasterTowerAgent.New()

return SummonMasterTowerAgent
