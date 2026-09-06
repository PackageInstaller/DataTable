-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktower/agent/PeakTowerAgent.lua

module("logic.extensions.peaktower.agent.PeakTowerAgent", package.seeall)

local PeakTowerAgent = class("PeakTowerAgent", BaseAgent)

function PeakTowerAgent:sendPM_PeakTowerInfoReq(activityId)
	local req = PeakTowerExtension_pb.PM_PeakTowerInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PeakTowerAgent:handlePM_PeakTowerInfoRes(status, msg)
	if status == 0 then
		PeakTowerController.instance:handlePM_PeakTowerInfoRes(msg)
	end
end

function PeakTowerAgent:sendPM_PeakTowerResetFloorReq(activityId, type, floorId)
	local req = PeakTowerExtension_pb.PM_PeakTowerResetFloorReq()

	req.activityId = activityId
	req.type = type
	req.floorId = floorId

	self:sendMsg(req)
end

function PeakTowerAgent:handlePM_PeakTowerResetFloorRes(status, msg)
	if status == 0 then
		PeakTowerController.instance:handlePM_PeakTowerResetFloorRes(msg)
	end
end

function PeakTowerAgent:sendPM_PeakTowerBasicClgReq(activityId, form, floorId, stageId)
	local req = PeakTowerExtension_pb.PM_PeakTowerBasicClgReq()

	req.activityId = activityId
	req.floorId = floorId
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function PeakTowerAgent:handlePM_PeakTowerBasicClgRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function PeakTowerAgent:handlePM_PeakTowerNotifyBasicClgRes(status, msg)
	if status == 0 then
		PeakTowerController.instance:handlePM_PeakTowerNotifyBasicClgRes(msg)
	end
end

function PeakTowerAgent:sendPM_PeakTowerLegendClgReq(activityId, form, floorId, stageId)
	local req = PeakTowerExtension_pb.PM_PeakTowerLegendClgReq()

	req.activityId = activityId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	req.floorId = floorId
	req.stageId = stageId

	self:sendMsg(req)
end

function PeakTowerAgent:handlePM_PeakTowerNotifyLegendClgRes(status, msg)
	if status == 0 then
		PeakTowerController.instance:handlePM_PeakTowerNotifyLegendClgRes(msg)
	end
end

function PeakTowerAgent:handlePM_PeakTowerLegendClgRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function PeakTowerAgent:sendPM_PeakTowerGainProgressPrizeReq(activityId, type)
	local req = PeakTowerExtension_pb.PM_PeakTowerGainProgressPrizeReq()

	req.activityId = activityId
	req.type = type

	self:sendMsg(req)
end

function PeakTowerAgent:handlePM_PeakTowerGainProgressPrizeRes(status, msg)
	if status == 0 then
		PeakTowerController.instance:handlePM_PeakTowerGainProgressPrizeRes(msg)
	end
end

function PeakTowerAgent:sendPM_PeakTowerVerifyRaceReq(activityId, petId)
	local req = PeakTowerExtension_pb.PM_PeakTowerVerifyRaceReq()

	req.activityId = activityId
	req.petId = petId

	self:sendMsg(req)
end

function PeakTowerAgent:handlePM_PeakTowerVerifyRaceRes(status, msg)
	if status == 0 then
		PeakTowerController.instance:handlePM_PeakTowerVerifyRaceRes(msg)
	end
end

function PeakTowerAgent:sendPM_PeakTowerLegendRankViewReq(activityId)
	local req = PeakTowerExtension_pb.PM_PeakTowerLegendRankViewReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PeakTowerAgent:handlePM_PeakTowerLegendRankViewRes(status, msg)
	if status == 0 then
		PeakTowerController.instance:handlePM_PeakTowerLegendRankViewRes(msg)
	end
end

function PeakTowerAgent:sendPM_PeakTowerBasicRankViewReq(activityId)
	local req = PeakTowerExtension_pb.PM_PeakTowerBasicRankViewReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PeakTowerAgent:handlePM_PeakTowerBasicRankViewRes(status, msg)
	if status == 0 then
		PeakTowerController.instance:handlePM_PeakTowerBasicRankViewRes(msg)
	end
end

PeakTowerAgent.instance = PeakTowerAgent.New()

return PeakTowerAgent
