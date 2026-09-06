-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/reviveelizabeth/agent/ReviveElizabethAgent.lua

module("logic.extensions.reviveelizabeth.agent.ReviveElizabethAgent", package.seeall)

local ReviveElizabethAgent = class("ReviveElizabethAgent", BaseAgent)

function ReviveElizabethAgent:sendPM_ReviveElizabethGetInfoReq(activityId)
	local req = ReviveElizabethExtension_pb.PM_ReviveElizabethGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ReviveElizabethAgent:handlePM_ReviveElizabethGetInfoRes(status, msg)
	if status == 0 then
		ReviveElizabethModel.instance:onReviveElizabethGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ReviveElizabethGetInfoRes)
	end
end

function ReviveElizabethAgent:sendPM_ReviveElizabethHandleFieldReq(activityId, fieldId, handleType)
	local req = ReviveElizabethExtension_pb.PM_ReviveElizabethHandleFieldReq()

	req.activityId = activityId
	req.fieldId = fieldId
	req.handleType = handleType

	self:sendMsg(req)
end

function ReviveElizabethAgent:handlePM_ReviveElizabethHandleFieldRes(status, msg)
	if status == 0 then
		ReviveElizabethModel.instance:onReviveElizabethHandleFieldRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ReviveElizabethHandleFieldRes)
	end
end

function ReviveElizabethAgent:sendPM_ReviveElizabethGainPrizeReq(activityId, prizeType, prizeId)
	local req = ReviveElizabethExtension_pb.PM_ReviveElizabethGainPrizeReq()

	req.activityId = activityId
	req.prizeType = prizeType
	req.prizeId = prizeId

	self:sendMsg(req)
end

function ReviveElizabethAgent:handlePM_ReviveElizabethGainPrizeRes(status, msg)
	if status == 0 then
		ReviveElizabethModel.instance:onReviveElizabethGainPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ReviveElizabethGainPrizeRes, msg)
	end
end

function ReviveElizabethAgent:sendPM_ReviveElizabethInjectSoulReq(activityId, prizeId)
	local req = ReviveElizabethExtension_pb.PM_ReviveElizabethInjectSoulReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function ReviveElizabethAgent:handlePM_ReviveElizabethInjectSoulRes(status, msg)
	if status == 0 then
		ReviveElizabethModel.instance:onReviveElizabethInjectSoulRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ReviveElizabethInjectSoulRes)
	end
end

ReviveElizabethAgent.instance = ReviveElizabethAgent.New()

return ReviveElizabethAgent
