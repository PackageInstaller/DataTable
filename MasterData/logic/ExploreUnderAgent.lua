-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/agent/ExploreUnderAgent.lua

module("logic.extensions.exploreunder.agent.ExploreUnderAgent", package.seeall)

local ExploreUnderAgent = class("ExploreUnderAgent", BaseAgent)

function ExploreUnderAgent:sendPM_ExploreUnderInfoReq(activityId)
	local req = ExploreUnderExtension_pb.PM_ExploreUnderInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ExploreUnderAgent:handlePM_ExploreUnderInfoRes(status, msg)
	if status == 0 then
		ExploreUnderController.instance:handleGetInfo(msg)
	end
end

function ExploreUnderAgent:sendPM_ExploreUnderDiceReq(activityId, diceNum)
	local req = ExploreUnderExtension_pb.PM_ExploreUnderDiceReq()

	req.activityId = activityId
	req.diceNum = diceNum

	self:sendMsg(req)
end

function ExploreUnderAgent:handlePM_ExploreUnderDiceRes(status, msg)
	if status == 0 then
		ExploreUnderController.instance:handleDice(msg)
	end
end

function ExploreUnderAgent:sendPM_ExploreUnderDoEventReq(activityId, action, actionParam)
	local req = ExploreUnderExtension_pb.PM_ExploreUnderDoEventReq()

	req.activityId = activityId
	req.action = action

	if actionParam then
		for i, v in ipairs(actionParam) do
			local param = req.actionParam:add()

			param:ParseFromString(v:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function ExploreUnderAgent:handlePM_ExploreUnderDoEventRes(status, msg)
	ExploreUnderController.instance:handleDealEvent(status, msg)
end

function ExploreUnderAgent:handlePM_NotifyEventInfoChanged(status, msg)
	if status == 0 then
		ExploreUnderController.instance:handleNotifyEventInfoChanged(msg)
	end
end

function ExploreUnderAgent:sendPM_ExploreUnderDialogueFightReq(activityId, form)
	local req = ExploreUnderExtension_pb.PM_ExploreUnderDialogueFightReq()

	req.activityId = activityId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function ExploreUnderAgent:handlePM_ExploreUnderDialogueFightRes(status, msg)
	if status == 0 then
		ExploreUnderController.instance:handlePM_ExploreUnderDialogueFightRes(msg)
	end
end

ExploreUnderAgent.instance = ExploreUnderAgent.New()

return ExploreUnderAgent
