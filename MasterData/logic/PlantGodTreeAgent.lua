-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plantgodtree/agent/PlantGodTreeAgent.lua

module("logic.extensions.plantgodtree.agent.PlantGodTreeAgent", package.seeall)

local PlantGodTreeAgent = class("PlantGodTreeAgent", BaseAgent)

function PlantGodTreeAgent:sendPM_PlantGodTreeGetInfoReq(activityId)
	local req = PlantGodTreeExtension_pb.PM_PlantGodTreeGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PlantGodTreeAgent:handlePM_PlantGodTreeGetInfoRes(status, msg)
	if status == 0 then
		PlantGodTreeController.instance:handlePM_PlantGodTreeGetInfoRes(status, msg)
	end
end

function PlantGodTreeAgent:sendPM_PlantGodTreePushStepReq(activityId, treeId)
	local req = PlantGodTreeExtension_pb.PM_PlantGodTreePushStepReq()

	req.activityId = activityId
	req.treeId = treeId

	self:sendMsg(req)
end

function PlantGodTreeAgent:handlePM_PlantGodTreePushStepRes(status, msg)
	if status == 0 then
		PlantGodTreeController.instance:handlePM_PlantGodTreePushStepRes(status, msg)
	end
end

function PlantGodTreeAgent:sendPM_PlantGodTreeDoEventReq(activityId, treeId, eventId, count)
	local req = PlantGodTreeExtension_pb.PM_PlantGodTreeDoEventReq()

	req.activityId = activityId
	req.treeId = treeId
	req.eventId = eventId
	req.count = count

	self:sendMsg(req)
end

function PlantGodTreeAgent:handlePM_PlantGodTreeDoEventRes(status, msg)
	if status == 0 then
		PlantGodTreeController.instance:handlePM_PlantGodTreeDoEventRes(status, msg)
	end
end

function PlantGodTreeAgent:sendPM_PlantGodTreeGainPrizeReq(activityId, treeId)
	local req = PlantGodTreeExtension_pb.PM_PlantGodTreeGainPrizeReq()

	req.activityId = activityId
	req.treeId = treeId

	self:sendMsg(req)
end

function PlantGodTreeAgent:handlePM_PlantGodTreeGainPrizeRes(status, msg)
	if status == 0 then
		PlantGodTreeController.instance:handlePM_PlantGodTreeGainPrizeRes(status, msg)
	end
end

PlantGodTreeAgent.instance = PlantGodTreeAgent.New()

return PlantGodTreeAgent
