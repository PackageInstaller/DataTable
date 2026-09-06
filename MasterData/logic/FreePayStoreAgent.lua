-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doubleeleven/agent/FreePayStoreAgent.lua

module("logic.extensions.doubleeleven.agent.FreePayStoreAgent", package.seeall)

local FreePayStoreAgent = class("FreePayStoreAgent", BaseAgent)

function FreePayStoreAgent:sendPM_FreePayStoreGetInfoReq(activityId)
	local req = FreePayStoreExtension_pb.PM_FreePayStoreGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FreePayStoreAgent:handlePM_FreePayStoreGetInfoRes(status, msg)
	if status == 0 then
		DoubleElevenController.instance:csSendFreePayStoreGetInfo(msg)
	end
end

function FreePayStoreAgent:sendPM_FreePayStoreBuyReq(activityId, itemId)
	local req = FreePayStoreExtension_pb.PM_FreePayStoreBuyReq()

	req.activityId = activityId
	req.itemId = itemId

	self:sendMsg(req)
end

function FreePayStoreAgent:handlePM_FreePayStoreBuyRes(status, msg)
	if status == 0 then
		DoubleElevenController.instance:csSendFreePayStoreBuy(msg)
	end
end

function FreePayStoreAgent:sendPM_FreePayStoreGetRanTextReq(activityId)
	local req = FreePayStoreExtension_pb.PM_FreePayStoreGetRanTextReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FreePayStoreAgent:handlePM_FreePayStoreGetRanTextRes(status, msg)
	if status == 0 then
		DoubleElevenController.instance:csSendFreePayStoreGetRanText(msg)
	end
end

FreePayStoreAgent.instance = FreePayStoreAgent.New()

return FreePayStoreAgent
