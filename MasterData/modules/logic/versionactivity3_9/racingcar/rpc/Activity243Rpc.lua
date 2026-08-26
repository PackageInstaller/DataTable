-- chunkname: @modules/logic/versionactivity3_9/racingcar/rpc/Activity243Rpc.lua

module("modules.logic.versionactivity3_9.racingcar.rpc.Activity243Rpc", package.seeall)

local Activity243Rpc = class("Activity243Rpc", BaseRpc)

function Activity243Rpc:sendGetAct243InfoRequest(activityId, callback, callbackObj)
	local req = Activity243Module_pb.GetAct243InfoRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity243Rpc:onReceiveGetAct243InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if msg.activityId == V3a9BirdModel.instance:getActId() then
		V3a9BirdRpc.instance:onReceiveGetAct243InfoReply(msg)
	elseif msg.activityId == VersionActivity3_9Enum.ActivityId.Racing then
		V3a9RacingCarRpc.instance:onReceiveGetAct243InfoReply(msg)
	end
end

function Activity243Rpc:sendGetAct243ReportEpisodeRequest(activityId, episodeId, score, star, timeMs, record, callback, callbackObj)
	local req = Activity243Module_pb.Act243ReportEpisodeRequest()

	req.activityId = activityId
	req.episodeId = episodeId
	req.score = score
	req.star = star
	req.timeMs = timeMs
	req.record = record

	return self:sendMsg(req, callback, callbackObj)
end

function Activity243Rpc:onReceiveAct243ReportEpisodeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if msg.activityId == V3a9BirdModel.instance:getActId() then
		V3a9BirdRpc.instance:onReceiveAct243ReportEpisodeReply(msg)
	elseif msg.activityId == VersionActivity3_9Enum.ActivityId.Racing then
		V3a9RacingCarRpc.instance:onReceiveAct243ReportEpisodeReply(msg)
	end
end

function Activity243Rpc:sendAct243UpgradeGiftRequest(activityId, giftPoint, callback, callbackObj)
	local req = Activity243Module_pb.Act243UpgradeGiftRequest()

	req.activityId = activityId
	req.giftPoint = giftPoint

	return self:sendMsg(req, callback, callbackObj)
end

function Activity243Rpc:onReceiveAct243UpgradeGiftReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if msg.activityId == V3a9BirdModel.instance:getActId() then
		V3a9BirdRpc.instance:onReceiveAct243UpgradeGiftReply(msg)
	elseif msg.activityId == VersionActivity3_9Enum.ActivityId.Racing then
		V3a9RacingCarRpc.instance:onReceiveAct243UpgradeGiftReply(msg)
	end
end

function Activity243Rpc:sendAct243UnlockRacerRequest(activityId, racerId, callback, callbackObj)
	local req = Activity243Module_pb.Act243UnlockRacerRequest()

	req.activityId = activityId
	req.racerId = racerId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity243Rpc:onReceiveAct243UnlockRacerReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if msg.activityId == V3a9BirdModel.instance:getActId() then
		V3a9BirdRpc.instance:onReceiveAct243UnlockRacerReply(msg)
	elseif msg.activityId == VersionActivity3_9Enum.ActivityId.Racing then
		V3a9RacingCarRpc.instance:onReceiveAct243UnlockRacerReply(msg)
	end
end

function Activity243Rpc:onReceiveAct243InfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if msg.activityId == V3a9BirdModel.instance:getActId() then
		V3a9BirdRpc.instance:onReceiveAct243InfoPush(msg)
	elseif msg.activityId == VersionActivity3_9Enum.ActivityId.Racing then
		V3a9RacingCarRpc.instance:onReceiveAct243InfoPush(msg)
	end
end

Activity243Rpc.instance = Activity243Rpc.New()

return Activity243Rpc
