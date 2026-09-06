-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/darknessspring/agent/DarknessSpringAgent.lua

module("logic.extensions.darknessspring.agent.DarknessSpringAgent", package.seeall)

local DarknessSpringAgent = class("DarknessSpringAgent", BaseAgent)

function DarknessSpringAgent:sendPM_DarknessSpringGetInfoReq(activityId)
	local req = DarknessSpringExtension_pb.PM_DarknessSpringGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DarknessSpringAgent:handlePM_DarknessSpringGetInfoRes(status, msg)
	if status == 0 then
		DarknessSpringModel.instance:onDarknessSpringGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DarknessSpringGetInfoRes)
	end
end

function DarknessSpringAgent:sendPM_DarknessSpringUnlockReq(activityId, unlockItemId)
	local req = DarknessSpringExtension_pb.PM_DarknessSpringUnlockReq()

	req.activityId = activityId
	req.unlockItemId = unlockItemId

	self:sendMsg(req)
end

function DarknessSpringAgent:handlePM_DarknessSpringUnlockRes(status, msg)
	if status == 0 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		GlobalDispatcher:dispatch(GlobalNotify.DarknessSpringUnlockRes, msg)
	end
end

function DarknessSpringAgent:sendPM_DarknessSpringGainStage2PrizeReq(activityId, prizeId)
	local req = DarknessSpringExtension_pb.PM_DarknessSpringGainStage2PrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function DarknessSpringAgent:handlePM_DarknessSpringGainStage2PrizeRes(status, msg)
	if status == 0 then
		self:sendPM_DarknessSpringGetInfoReq(msg.activityId)
	end
end

DarknessSpringAgent.instance = DarknessSpringAgent.New()

return DarknessSpringAgent
