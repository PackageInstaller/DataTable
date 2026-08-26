-- chunkname: @modules/logic/versionactivity3_9/racingcar/rpc/V3a9RacingCarRpc.lua

module("modules.logic.versionactivity3_9.racingcar.rpc.V3a9RacingCarRpc", package.seeall)

local V3a9RacingCarRpc = class("V3a9RacingCarRpc", BaseRpc)

function V3a9RacingCarRpc:sendGetAct243InfoRequest(activityId, callback, callbackObj)
	Activity243Rpc.instance:sendGetAct243InfoRequest(activityId, callback, callbackObj)
end

function V3a9RacingCarRpc:onReceiveGetAct243InfoReply(msg)
	V3a9RacingTalentModel.instance:onGetInfos(msg.activityId, msg.growth)
	V3a9RacingCarEpisodeModel.instance:initInfo(msg.episodes)
end

function V3a9RacingCarRpc:sendGetAct243ReportEpisodeRequest(activityId, episodeId, score, star, timeMs, record, callback, callbackObj)
	Activity243Rpc.instance:sendGetAct243ReportEpisodeRequest(activityId, episodeId, score, star, timeMs, record, callback, callbackObj)
end

function V3a9RacingCarRpc:onReceiveAct243ReportEpisodeReply(msg)
	return
end

function V3a9RacingCarRpc:sendAct243UpgradeGiftRequest(activityId, giftPoint, callback, callbackObj)
	Activity243Rpc.instance:sendAct243UpgradeGiftRequest(activityId, giftPoint, callback, callbackObj)
end

function V3a9RacingCarRpc:onReceiveAct243UpgradeGiftReply(msg)
	V3a9RacingCarController.instance:finishTalentGuide()
	V3a9RacingTalentModel.instance:onLevelUpTalent(msg.activityId, msg.gift)
	V3a9RacingCarController.instance:sendTalentUnlockStat(msg.gift)
	V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.onLevelUpTalent, msg.gift)
end

function V3a9RacingCarRpc:sendAct243UnlockRacerRequest(activityId, racerId, callback, callbackObj)
	Activity243Rpc.instance:sendAct243UnlockRacerRequest(activityId, racerId, callback, callbackObj)
end

function V3a9RacingCarRpc:onReceiveAct243UnlockRacerReply(msg)
	V3a9RacingRoleListModel.instance:onUnlockRole(msg.racerId)
	V3a9RacingCarController.instance:sendRacerUnlockStat(msg.racerId)
	V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.onUnlockRole, msg.racerId)
end

function V3a9RacingCarRpc:onReceiveAct243InfoPush(msg)
	return
end

V3a9RacingCarRpc.instance = V3a9RacingCarRpc.New()

return V3a9RacingCarRpc
