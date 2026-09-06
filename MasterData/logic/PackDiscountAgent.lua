-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/packdiscount/agent/PackDiscountAgent.lua

module("logic.extensions.packdiscount.agent.PackDiscountAgent", package.seeall)

local PackDiscountAgent = class("PackDiscountAgent", BaseAgent)

function PackDiscountAgent:sendPM_PackDiscountGetInfoReq(activityId)
	local req = PackDiscountExtension_pb.PM_PackDiscountGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PackDiscountAgent:handlePM_PackDiscountGetInfoRes(status, msg)
	if status == 0 then
		PackDiscountController.instance:handlePM_PackDiscountGetInfoRes(status, msg)
	end
end

function PackDiscountAgent:handlePM_PackDiscountNotifyPaySucRes(status, msg)
	if status == 0 then
		PackDiscountController.instance:handlePM_PackDiscountNotifyPaySucRes(status, msg)
	end
end

PackDiscountAgent.instance = PackDiscountAgent.New()

return PackDiscountAgent
