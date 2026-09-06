-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaoxiaoleskin/agent/ScratchLotteryAgent.lua

module("logic.extensions.xiaoxiaoleskin.agent.ScratchLotteryAgent", package.seeall)

local ScratchLotteryAgent = class("ScratchLotteryAgent", BaseAgent)

function ScratchLotteryAgent:sendPM_ScratchLotteryInfoReq(activityId)
	local req = ScratchLotteryExtension_pb.PM_ScratchLotteryInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ScratchLotteryAgent:handlePM_ScratchLotteryInfoRes(status, msg)
	if status == 0 then
		ScratchLotteryModel.instance:setGameInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ScratchLotteryGetInfoRes)
	end
end

function ScratchLotteryAgent:sendPM_ScratchLotteryDigReq(activityId, xAxis, yAxis, useCoupon)
	self._lastActivityId = activityId

	local req = ScratchLotteryExtension_pb.PM_ScratchLotteryDigReq()

	req.activityId = activityId
	req.xAxis = xAxis
	req.yAxis = yAxis
	req.useCoupon = useCoupon

	self:sendMsg(req)
end

function ScratchLotteryAgent:handlePM_ScratchLotteryDigRes(status, msg)
	if status == 0 then
		ScratchLotteryModel.instance:setFlipInfo(msg, self._lastActivityId)
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		GlobalDispatcher:dispatch(GlobalNotify.ScratchLotteryDigRes)
	end
end

ScratchLotteryAgent.instance = ScratchLotteryAgent.New()

return ScratchLotteryAgent
