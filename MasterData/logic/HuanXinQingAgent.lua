-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/huanxinqing/agent/HuanXinQingAgent.lua

module("logic.extensions.huanxinqing.agent.HuanXinQingAgent", package.seeall)

local HuanXinQingAgent = class("HuanXinQingAgent", BaseAgent)

function HuanXinQingAgent:sendPM_PetActiveGetInfoReq(activityId)
	local req = PetActiveGetExtension_pb.PM_PetActiveGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HuanXinQingAgent:handlePM_PetActiveGetInfoRes(status, msg)
	if status == 0 then
		HuanXinQingController.instance:handlePM_PetActiveGetInfoRes(msg)
	end
end

function HuanXinQingAgent:sendPM_PetActiveGetUnlockReq(activityId, itemId)
	local req = PetActiveGetExtension_pb.PM_PetActiveGetUnlockReq()

	req.activityId = activityId
	req.itemId = itemId

	self:sendMsg(req)
end

function HuanXinQingAgent:handlePM_PetActiveGetUnlockRes(status, msg)
	if status == 0 then
		HuanXinQingController.instance:handlePM_PetActiveGetUnlockRes(msg)
	end
end

function HuanXinQingAgent:sendPM_PetActiveGetDirectBuyReq(activityId)
	local req = PetActiveGetExtension_pb.PM_PetActiveGetDirectBuyReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HuanXinQingAgent:handlePM_PetActiveGetDirectBuyRes(status, msg)
	if status == 0 then
		HuanXinQingController.instance:handlePM_PetActiveGetDirectBuyRes(msg)
	end
end

function HuanXinQingAgent:sendPM_PetActiveGetExchangePropReq(activityId, propId, num)
	local req = PetActiveGetExtension_pb.PM_PetActiveGetExchangePropReq()

	req.activityId = activityId
	req.propId = propId
	req.num = num

	self:sendMsg(req)
end

function HuanXinQingAgent:handlePM_PetActiveGetExchangePropRes(status, msg)
	if status == 0 then
		HuanXinQingController.instance:handlePM_PetActiveGetExchangePropRes(msg)
	end
end

HuanXinQingAgent.instance = HuanXinQingAgent.New()

return HuanXinQingAgent
