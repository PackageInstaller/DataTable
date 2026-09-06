-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flowergoddess/agent/FlowerGoddessAgent.lua

module("logic.extensions.flowergoddess.agent.FlowerGoddessAgent", package.seeall)

local FlowerGoddessAgent = class("FlowerGoddessAgent", BaseAgent)

function FlowerGoddessAgent:ctor()
	return
end

function FlowerGoddessAgent:sendPM_SendGoddessFlowerGetInfoReq(activityId)
	local req = SendGoddessFlowerExtension_pb.PM_SendGoddessFlowerGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FlowerGoddessAgent:handlePM_SendGoddessFlowerGetInfoRes(status, msg)
	if status == 0 then
		FlowerGoddessController.instance:onHandlePM_SendGoddessFlowerGetInfoRes(msg)
	end
end

function FlowerGoddessAgent:sendPM_SendGoddessFlowerReq(activityId, flowerId, flowerNum)
	local req = SendGoddessFlowerExtension_pb.PM_SendGoddessFlowerReq()

	req.activityId = activityId
	req.flowerId = flowerId
	req.flowerNum = flowerNum

	self:sendMsg(req)
end

function FlowerGoddessAgent:handlePM_SendGoddessFlowerRes(status, msg)
	if status == 0 then
		FlowerGoddessController.instance:onHandlePM_SendGoddessFlowerRes(msg)
	end
end

function FlowerGoddessAgent:sendPM_SendGoddessFlowerGainProgressPrizeReq(activityId, prizeId)
	local req = SendGoddessFlowerExtension_pb.PM_SendGoddessFlowerGainProgressPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function FlowerGoddessAgent:handlePM_SendGoddessFlowerGainProgressPrizeRes(status, msg)
	if status == 0 then
		FlowerGoddessController.instance:onHandlePM_SendGoddessFlowerGainProgressPrizeRes(msg)
	end
end

FlowerGoddessAgent.instance = FlowerGoddessAgent.New()

return FlowerGoddessAgent
