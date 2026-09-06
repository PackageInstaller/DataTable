-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jackpot/agent/JackpotAgent.lua

module("logic.extensions.jackpot.agent.JackpotAgent", package.seeall)

local JackpotAgent = class("JackpotAgent", BaseAgent)

function JackpotAgent:sendGetJackpotDrawInfoReq(activityId)
	local req = JackpotExtension_pb.GetJackpotDrawInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function JackpotAgent:handleGetJackpotDrawInfoRes(status, msg)
	if status == 0 then
		local orderid = msg.orderId
		local hasdrawids = msg.hasDrawIds

		JackpotModel.instance:setDrawInfos(orderid, hasdrawids)
	end
end

function JackpotAgent:sendJackpotDrawReq(activityId)
	local req = JackpotExtension_pb.JackpotDrawReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function JackpotAgent:handleJackpotDrawRes(status, msg)
	if status == 0 then
		JackpotController.instance:handleJackpotDrawRes(status, msg)
	end
end

function JackpotAgent:showChangeSet(changeSetId, name)
	if name == "handleJackpotDrawRes" then
		-- block empty
	else
		JackpotAgent.super.showChangeSet(self, changeSetId, name)
	end
end

JackpotAgent.instance = JackpotAgent.New()

return JackpotAgent
