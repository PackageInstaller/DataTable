-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectingskin/agent/PosterStickersGainActivityAgent.lua

module("logic.extensions.posterstickersgainactivity.agent.PosterStickersGainActivityAgent", package.seeall)

local PosterStickersGainActivityAgent = class("PosterStickersGainActivityAgent", BaseAgent)

function PosterStickersGainActivityAgent:sendPM_PosterStickerGainActivityGetInfoReq(activityId)
	local req = PosterStickersGainActivityExtension_pb.PM_PosterStickerGainActivityGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PosterStickersGainActivityAgent:handlePM_PosterStickerGainActivityGetInfoRes(status, msg)
	if status == 0 then
		CollectingSkinModel.instance:onGetPosterMsg(msg)
		GlobalDispatcher:dispatch(GlobalNotify.CollectingPoseterInfo)
	end
end

function PosterStickersGainActivityAgent:sendPM_PosterStickerGainActivityReq(activityId)
	local req = PosterStickersGainActivityExtension_pb.PM_PosterStickerGainActivityReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PosterStickersGainActivityAgent:handlePM_PosterStickerGainActivityRes(status, msg)
	if status == 0 then
		CollectingSkinModel.instance:onGainPosterMsg(msg)
		GlobalDispatcher:dispatch(GlobalNotify.CollectingPoseterInfo)
	end
end

PosterStickersGainActivityAgent.instance = PosterStickersGainActivityAgent.New()

return PosterStickersGainActivityAgent
