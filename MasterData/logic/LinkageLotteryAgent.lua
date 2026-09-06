-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkagelottery/agent/LinkageLotteryAgent.lua

module("logic.extensions.linkagelottery.agent.LinkageLotteryAgent", package.seeall)

local LinkageLotteryAgent = class("LinkageLotteryAgent", BaseAgent)

function LinkageLotteryAgent:sendPM_LinkageLotterygetInfoReq(activityId)
	local req = LinkageLotteryExtension_pb.PM_LinkageLotterygetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LinkageLotteryAgent:handlePM_LinkageLotterygetInfoRes(status, msg)
	if status == 0 then
		LinkageLotteryModel.instance:onLinkageLotterygetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.LinkageLotterygetInfoRes)
	end
end

function LinkageLotteryAgent:sendPM_LinkageLotteryBuyLotteryReq(activityId, buyNum)
	local req = LinkageLotteryExtension_pb.PM_LinkageLotteryBuyLotteryReq()

	req.activityId = activityId
	req.buyNum = buyNum

	self:sendMsg(req)
end

function LinkageLotteryAgent:handlePM_LinkageLotteryBuyLotteryRes(status, msg)
	if status == 0 then
		LinkageLotteryModel.instance:onLinkageLotteryBuyLotteryRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.LinkageLotteryBuyLotteryRes)
	end
end

function LinkageLotteryAgent:sendPM_LinkageLotteryRandReq(activityId)
	local req = LinkageLotteryExtension_pb.PM_LinkageLotteryRandReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LinkageLotteryAgent:handlePM_LinkageLotteryRandRes(status, msg)
	if status == 0 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		LinkageLotteryModel.instance:onLinkageLotteryRandRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.LinkageLotteryRandRes)
	end
end

LinkageLotteryAgent.instance = LinkageLotteryAgent.New()

return LinkageLotteryAgent
