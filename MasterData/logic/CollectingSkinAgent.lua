-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectingskin/agent/CollectingSkinAgent.lua

module("logic.extensions.collectingskin.agent.CollectingSkinAgent", package.seeall)

local CollectingSkinAgent = class("CollectingSkinAgent", BaseAgent)

function CollectingSkinAgent:sendPM_CollectingSkinGetInfoReq(activityId)
	local req = CollectingSkinExtension_pb.PM_CollectingSkinGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CollectingSkinAgent:handlePM_CollectingSkinGetInfoRes(status, msg)
	if status == 0 then
		CollectingSkinController.instance:handleGetInfo(msg)
	end
end

function CollectingSkinAgent:sendPM_CollectingSkinGainProgressPrizeReq(activityId, dataBitId)
	local req = CollectingSkinExtension_pb.PM_CollectingSkinGainProgressPrizeReq()

	req.activityId = activityId
	req.dataBitId = dataBitId

	self:sendMsg(req)
end

function CollectingSkinAgent:handlePM_CollectingSkinGainProgressPrizeRes(status, msg)
	if status == 0 then
		CollectingSkinController.instance:handleGainPrize(msg)
	end
end

function CollectingSkinAgent:sendPM_CollectingSkinGainSkinPrizeReq(activityId, skinId)
	local req = CollectingSkinExtension_pb.PM_CollectingSkinGainSkinPrizeReq()

	req.activityId = activityId
	req.skinId = skinId

	self:sendMsg(req)
end

function CollectingSkinAgent:handlePM_CollectingSkinGainSkinPrizeRes(status, msg)
	if status == 0 then
		CollectingSkinController.instance:handleGainSkinPrize(msg)
	end
end

function CollectingSkinAgent:sendPM_CollectingSkinGainItemPrizeReq(activityId, dataBitId)
	local req = CollectingSkinExtension_pb.PM_CollectingSkinGainItemPrizeReq()

	req.activityId = activityId
	req.dataBitId = dataBitId

	self:sendMsg(req)
end

function CollectingSkinAgent:handlePM_CollectingSkinGainItemPrizeRes(status, msg)
	if status == 0 then
		CollectingSkinController.instance:handleGainItemPrize(msg)
	end
end

function CollectingSkinAgent:sendPM_CollectingSkinItemRankInfoReq(activityId)
	local req = CollectingSkinExtension_pb.PM_CollectingSkinItemRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CollectingSkinAgent:handlePM_CollectingSkinItemRankInfoRes(status, msg)
	if status == 0 then
		CollectingSkinController.instance:handlePM_CollectingSkinItemRankInfoRes(msg)
	end
end

CollectingSkinAgent.instance = CollectingSkinAgent.New()

return CollectingSkinAgent
