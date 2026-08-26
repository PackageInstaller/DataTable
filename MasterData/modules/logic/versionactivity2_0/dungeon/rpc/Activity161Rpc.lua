-- chunkname: @modules/logic/versionactivity2_0/dungeon/rpc/Activity161Rpc.lua

module("modules.logic.versionactivity2_0.dungeon.rpc.Activity161Rpc", package.seeall)

local Activity161Rpc = class("Activity161Rpc", BaseRpc)

function Activity161Rpc:sendAct161GetInfoRequest(activityId, callback, callbackObj)
	local req = Activity161Module_pb.Act161GetInfoRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity161Rpc:onReceiveAct161GetInfoReply(resultCold, msg)
	if resultCold == 0 then
		Activity161Model.instance:setGraffitiInfo(msg)
		Activity161Controller.instance:checkGraffitiCdInfo()
	end
end

function Activity161Rpc:sendAct161RefreshElementsRequest(activityId)
	local req = Activity161Module_pb.Act161RefreshElementsRequest()

	req.activityId = activityId

	return self:sendMsg(req)
end

function Activity161Rpc:onReceiveAct161RefreshElementsReply(resultCold, msg)
	if resultCold == 0 then
		Activity161Controller.instance:dispatchEvent(Activity161Event.RefreshGraffitiView)

		if Activity161Model.instance.isNeedRefreshNewElement then
			DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnInitElements)
		end
	end
end

function Activity161Rpc:sendAct161GainMilestoneRewardRequest(activityId)
	local req = Activity161Module_pb.Act161GainMilestoneRewardRequest()

	req.activityId = activityId

	return self:sendMsg(req)
end

function Activity161Rpc:onReceiveAct161GainMilestoneRewardReply(resultCold, msg)
	if resultCold == 0 then
		Activity161Model.instance:setRewardInfo(msg)
		Activity161Controller.instance:dispatchEvent(Activity161Event.GetGraffitiReward)
	end
end

function Activity161Rpc:onReceiveAct161CdBeginPush(resultCold, msg)
	if resultCold == 0 then
		Activity161Model.instance:setGraffitiInfo(msg)
		Activity161Controller.instance:checkGraffitiCdInfo()
	end
end

Activity161Rpc.instance = Activity161Rpc.New()

return Activity161Rpc
