-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yunuotongxing/agent/WalkWithNoahAgent.lua

module("logic.extensions.walkwithnoah.agent.WalkWithNoahAgent", package.seeall)

local WalkWithNoahAgent = class("WalkWithNoahAgent", BaseAgent)

function WalkWithNoahAgent:sendPM_WalkWithNoahGetInfoReq(activityId)
	local req = WalkWithNoahExtension_pb.PM_WalkWithNoahGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function WalkWithNoahAgent:handlePM_WalkWithNoahGetInfoRes(status, msg)
	if status == 0 then
		YuNuoTongXingController.instance:onGetInfo(msg)
	end
end

function WalkWithNoahAgent:sendPM_WalkWithNoahPlacePieceReq(activityId, pieceId)
	local req = WalkWithNoahExtension_pb.PM_WalkWithNoahPlacePieceReq()

	req.activityId = activityId
	req.pieceId = pieceId

	self:sendMsg(req)
end

function WalkWithNoahAgent:handlePM_WalkWithNoahPlacePieceRes(status, msg)
	if status == 0 then
		YuNuoTongXingController.instance:onSetPiece(msg)
	end
end

function WalkWithNoahAgent:sendPM_WalkWithNoahGainPrizeReq(activityId, prizeId)
	local req = WalkWithNoahExtension_pb.PM_WalkWithNoahGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function WalkWithNoahAgent:handlePM_WalkWithNoahGainPrizeRes(status, msg)
	if status == 0 then
		YuNuoTongXingController.instance:onGetPrize(msg)
	end
end

WalkWithNoahAgent.instance = WalkWithNoahAgent.New()

return WalkWithNoahAgent
