-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclefindtreasure/agent/MiracleFindTreasureAgent.lua

module("logic.extensions.miraclefindtreasure.agent.MiracleFindTreasureAgent", package.seeall)

local MiracleFindTreasureAgent = class("MiracleFindTreasureAgent", BaseAgent)

function MiracleFindTreasureAgent:sendPM_MiracleFindTreasureGetInfoReq(activityId)
	local req = MiracleFindTreasureExtension_pb.PM_MiracleFindTreasureGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MiracleFindTreasureAgent:handlePM_MiracleFindTreasureGetInfoRes(status, msg)
	if status == 0 then
		MiraclefindtreasureController.instance:handlePM_MiracleFindTreasureGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.MiracleFindTreasureGetInfoRes)
	end
end

function MiracleFindTreasureAgent:sendPM_MiracleFindTreasureLotteryReq(activityId)
	local req = MiracleFindTreasureExtension_pb.PM_MiracleFindTreasureLotteryReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MiracleFindTreasureAgent:handlePM_MiracleFindTreasureLotteryRes(status, msg)
	if status == 0 then
		MiraclefindtreasureController.instance:handlePM_MiracleFindTreasureLotteryRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.MiracleFindTreasureLotteryRes, msg.prizeInfo.prizeId)
	end
end

function MiracleFindTreasureAgent:sendPM_MiracleFindTreasureFinishDigReq(activityId)
	local req = MiracleFindTreasureExtension_pb.PM_MiracleFindTreasureFinishDigReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MiracleFindTreasureAgent:handlePM_MiracleFindTreasureFinishDigRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId

		MiraclefindtreasureModel.instance:finishDigRes(activityId)
		UIStateManager.instance:popByName(ViewName.MiraclefindtreasuredigView)
		MiraclefindtreasureController.instance:_autoWabao()
		GlobalDispatcher:dispatch(GlobalNotify.MiracleFindTreasureFinishDigRes)
	end
end

function MiracleFindTreasureAgent:sendPM_MiracleFindTreasureDirectGainPrizeReq(activityId, times)
	local req = MiracleFindTreasureExtension_pb.PM_MiracleFindTreasureDirectGainPrizeReq()

	req.activityId = activityId
	req.times = times

	self:sendMsg(req)
end

function MiracleFindTreasureAgent:handlePM_MiracleFindTreasureDirectGainPrizeRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId
		local prizeInfoList = msg.prizeInfoList

		MiraclefindtreasureModel.instance:updateGainPrizeList(activityId, prizeInfoList)
		MiraclefindtreasureController.instance:calRedpoint()
		GlobalDispatcher:dispatch(GlobalNotify.MiracleFindTreasureDirectGainPrizeRes)
	end
end

function MiracleFindTreasureAgent:sendPM_MiracleFindTreasureStartDigReq(activityId)
	local req = MiracleFindTreasureExtension_pb.PM_MiracleFindTreasureStartDigReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MiracleFindTreasureAgent:handlePM_MiracleFindTreasureStartDigRes(status, msg)
	if status == 0 then
		MiraclefindtreasureController.instance:startDigRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.MiracleFindTreasureStartDigRes)
	end
end

MiracleFindTreasureAgent.instance = MiracleFindTreasureAgent.New()

return MiracleFindTreasureAgent
