-- chunkname: @modules/logic/versionactivity3_9/bird/rpc/V3a9BirdRpc.lua

module("modules.logic.versionactivity3_9.bird.rpc.V3a9BirdRpc", package.seeall)

local V3a9BirdRpc = class("V3a9BirdRpc", BaseRpc)

function V3a9BirdRpc:sendGetAct243InfoRequest(activityId, callback, callbackObj)
	Activity243Rpc.instance:sendGetAct243InfoRequest(activityId, callback, callbackObj)
end

function V3a9BirdRpc:onReceiveGetAct243InfoReply(msg)
	V3a9BirdModel.instance:onGetInfos(msg.activityId, msg.episodes)
end

function V3a9BirdRpc:sendGetAct243ReportEpisodeRequest(activityId, episodeId, score, star, timeMs, callback, callbackObj)
	Activity243Rpc.instance:sendGetAct243ReportEpisodeRequest(activityId, episodeId, score, star, timeMs, "", callback, callbackObj)
end

function V3a9BirdRpc:onReceiveAct243ReportEpisodeReply(msg)
	return
end

function V3a9BirdRpc:sendAct243UpgradeGiftRequest(activityId, giftPoint, callback, callbackObj)
	Activity243Rpc.instance:sendAct243UpgradeGiftRequest(activityId, giftPoint, callback, callbackObj)
end

function V3a9BirdRpc:onReceiveAct243UpgradeGiftReply(msg)
	return
end

function V3a9BirdRpc:sendAct243UnlockRacerRequest(activityId, racerId, callback, callbackObj)
	Activity243Rpc.instance:sendAct243UnlockRacerRequest(activityId, racerId, callback, callbackObj)
end

function V3a9BirdRpc:onReceiveAct243UnlockRacerReply(msg)
	return
end

function V3a9BirdRpc:onReceiveAct243InfoPush(msg)
	return
end

V3a9BirdRpc.instance = V3a9BirdRpc.New()

return V3a9BirdRpc
