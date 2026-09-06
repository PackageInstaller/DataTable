-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishtreebottle/agent/WishTreeBottleAgent.lua

module("logic.extensions.wishtreebottle.agent.WishTreeBottleAgent", package.seeall)

local WishTreeBottleAgent = class("WishTreeBottleAgent", BaseAgent)

function WishTreeBottleAgent:sendPM_WishTreeBottleInfoReq(activityId)
	local req = WishTreeBottleExtension_pb.PM_WishTreeBottleInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function WishTreeBottleAgent:handlePM_WishTreeBottleInfoRes(status, msg)
	if status == 0 then
		WiShTreeBottleController.instance:handlePM_WishTreeBottleInfoRes(status, msg)
	end
end

function WishTreeBottleAgent:sendPM_WishTreeBottleViewReq(activityId)
	local req = WishTreeBottleExtension_pb.PM_WishTreeBottleViewReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function WishTreeBottleAgent:handlePM_WishTreeBottleViewRes(status, msg)
	if status == 0 then
		WiShTreeBottleController.instance:handlePM_WishTreeBottleViewRes(status, msg)
	end
end

function WishTreeBottleAgent:sendPM_WishTreeBottleLikeReq(activityId, targetUserId)
	local req = WishTreeBottleExtension_pb.PM_WishTreeBottleLikeReq()

	req.activityId = activityId
	req.targetUserId = targetUserId

	self:sendMsg(req)
end

function WishTreeBottleAgent:handlePM_WishTreeBottleLikeRes(status, msg)
	if status == 0 then
		WiShTreeBottleController.instance:handlePM_WishTreeBottleLikeRes(status, msg)
	end
end

function WishTreeBottleAgent:sendPM_WishTreeBottleSendReq(activityId, typeId, titleId, content)
	local req = WishTreeBottleExtension_pb.PM_WishTreeBottleSendReq()

	req.activityId = activityId
	req.typeId = typeId
	req.titleId = titleId
	req.content = content

	self:sendMsg(req)
end

function WishTreeBottleAgent:handlePM_WishTreeBottleSendRes(status, msg)
	if status == 0 then
		WiShTreeBottleController.instance:handlePM_WishTreeBottleSendRes(status, msg)
	end
end

WishTreeBottleAgent.instance = WishTreeBottleAgent.New()

return WishTreeBottleAgent
