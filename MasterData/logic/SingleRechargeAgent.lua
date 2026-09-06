-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/singlerecharge/agent/SingleRechargeAgent.lua

module("logic.extensions.singlerecharge.agent.SingleRechargeAgent", package.seeall)

local SingleRechargeAgent = class("SingleRechargeAgent", BaseAgent)

SingleRechargeAgent.PM_SingleRechargeGainPrizeRes = "SingleRechargeAgent_PM_SingleRechargeGainPrizeRes"
SingleRechargeAgent.PM_SingleRechargeGetInfoRes = "SingleRechargeAgent_PM_SingleRechargeGetInfoRes"

function SingleRechargeAgent:sendPM_SingleRechargeGetInfoReq(activityId)
	local req = SingleRechargeExtension_pb.PM_SingleRechargeGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SingleRechargeAgent:handlePM_SingleRechargeGetInfoRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(SingleRechargeAgent.PM_SingleRechargeGetInfoRes, status, msg)
end

function SingleRechargeAgent:sendPM_SingleRechargeGainPrizeReq(activityId, itemId)
	local req = SingleRechargeExtension_pb.PM_SingleRechargeGainPrizeReq()

	req.activityId = activityId
	req.itemId = itemId

	self:sendMsg(req)
end

function SingleRechargeAgent:handlePM_SingleRechargeGainPrizeRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(SingleRechargeAgent.PM_SingleRechargeGainPrizeRes, status, msg)
end

SingleRechargeAgent.instance = SingleRechargeAgent.New()

return SingleRechargeAgent
