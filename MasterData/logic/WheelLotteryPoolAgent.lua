-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wheellotterypool/agent/WheelLotteryPoolAgent.lua

module("logic.extensions.wheellotterypool.agent.WheelLotteryPoolAgent", package.seeall)

local WheelLotteryPoolAgent = class("WheelLotteryPoolAgent", BaseAgent)

function WheelLotteryPoolAgent:sendPM_WheelLotteryGetInfoReq(activityId)
	local req = WheelLotteryExtension_pb.PM_WheelLotteryGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function WheelLotteryPoolAgent:handlePM_WheelLotteryGetInfoRes(status, msg)
	if status == 0 then
		WheelLotteryPoolController.instance:handlePM_WheelLotteryGetInfoRes(msg)
	end
end

function WheelLotteryPoolAgent:sendPM_WheelLotteryLotteryReq(activityId, poolId)
	local req = WheelLotteryExtension_pb.PM_WheelLotteryLotteryReq()

	req.activityId = activityId
	req.poolId = poolId

	self:sendMsg(req)
end

function WheelLotteryPoolAgent:handlePM_WheelLotteryLotteryRes(status, msg)
	if status == 0 then
		WheelLotteryPoolController.instance:handlePM_WheelLotteryLotteryRes(msg)
	end
end

WheelLotteryPoolAgent.instance = WheelLotteryPoolAgent.New()

return WheelLotteryPoolAgent
