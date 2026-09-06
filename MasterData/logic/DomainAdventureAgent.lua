-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/agent/DomainAdventureAgent.lua

module("logic.extensions.domainadventure.agent.DomainAdventureAgent", package.seeall)

local DomainAdventureAgent = class("DomainAdventureAgent", BaseAgent)

function DomainAdventureAgent:sendPM_DomainAdventureGetInfoReq(activityId)
	local req = DomainAdventureExtension_pb.PM_DomainAdventureGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DomainAdventureAgent:handlePM_DomainAdventureGetInfoRes(status, msg)
	DomainAdventureController.instance:handlePM_DomainAdventureGetInfoRes(status, msg)
end

function DomainAdventureAgent:sendPM_DomainAdventureLoadMapReq(activityId, blockIds, startIdx, endIdx)
	local req = DomainAdventureExtension_pb.PM_DomainAdventureLoadMapReq()

	req.activityId = activityId
	startIdx = startIdx or 1
	endIdx = endIdx or #blockIds

	for i = startIdx, endIdx do
		req.blockIds:append(blockIds[i])
	end

	self:sendMsg(req)
end

function DomainAdventureAgent:sendPM_DomainAdventureLoadMapReqInHighPer(req)
	self:sendMsg(req)
end

function DomainAdventureAgent:handlePM_DomainAdventureLoadMapRes(status, msg)
	if status == 0 then
		DomainAdventureController.instance:handlePM_DomainAdventureLoadMapRes(msg)
	end
end

function DomainAdventureAgent:sendPM_DomainAdventureActionReq(activityId, blockId, extParam, simpleForm)
	local req = DomainAdventureExtension_pb.PM_DomainAdventureActionReq()
	local actionParam = DomainAdventureExtension_pb.PM_DomainAdventureActionParam()

	actionParam.activityId = activityId
	actionParam.blockId = blockId

	if not string.nilorempty(extParam) then
		actionParam.extParam = extParam
	end

	if simpleForm then
		actionParam.simpleForm:ParseFromString(simpleForm:SerializeToString())
	end

	req.actionParam:ParseFromString(actionParam:SerializeToString())
	self:sendMsg(req)
end

function DomainAdventureAgent:handlePM_DomainAdventureActionRes(status, msg)
	DomainAdventureController.instance:handlePM_DomainAdventureActionRes(status, msg)
end

function DomainAdventureAgent:sendPM_DomainAdventureGainGlobalPrizeReq(activityId, prizeId)
	local req = DomainAdventureExtension_pb.PM_DomainAdventureGainGlobalPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function DomainAdventureAgent:handlePM_DomainAdventureGainGlobalPrizeRes(status, msg)
	if status == 0 then
		DomainAdventureController.instance:handlePM_DomainAdventureGainGlobalPrizeRes(msg)
	end
end

function DomainAdventureAgent:sendPM_DomainAdventureRankViewReq(activityId, type)
	local req = DomainAdventureExtension_pb.PM_DomainAdventureRankViewReq()

	req.activityId = activityId
	req.type = type

	self:sendMsg(req)
end

function DomainAdventureAgent:handlePM_DomainAdventureRankViewRes(status, msg)
	if status == 0 then
		DomainAdventureController.instance:handlePM_DomainAdventureRankViewRes(msg)
	end
end

function DomainAdventureAgent:handlePM_DomainAdventureNotifyActionRes(status, msg)
	if status == 0 then
		DomainAdventureController.instance:handlePM_DomainAdventureNotifyActionRes(msg)
	end
end

function DomainAdventureAgent:handlePM_DomainAdventureOccupiedChangesRes(status, msg)
	if status == 0 then
		DomainAdventureController.instance:handlePM_DomainAdventureOccupiedChangesRes(msg)
	end
end

DomainAdventureAgent.instance = DomainAdventureAgent.New()

return DomainAdventureAgent
