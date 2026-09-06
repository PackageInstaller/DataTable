-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holylight/agent/HolyLightAgent.lua

module("logic.extensions.holylight.agent.HolyLightAgent", package.seeall)

local HolyLightAgent = class("HolyLightAgent", BaseAgent)

function HolyLightAgent:sendPM_HolyLightGetInfoReq(activityId)
	local req = HolyLightExtension_pb.PM_HolyLightGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HolyLightAgent:handlePM_HolyLightGetInfoRes(status, msg)
	if status == 0 then
		HolyLightController.instance:handlePM_HolyLightGetInfoRes(msg)
	end
end

function HolyLightAgent:sendPM_HolyLightGoReq(activityId, item, step, diceId)
	local req = HolyLightExtension_pb.PM_HolyLightGoReq()

	req.activityId = activityId
	req.item = item
	req.step = step
	req.diceId = diceId

	self:sendMsg(req)
end

function HolyLightAgent:handlePM_HolyLightGoRes(status, msg)
	HolyLightController.instance:handlePM_HolyLightGoRes(status, msg)
end

function HolyLightAgent:sendPM_HolyLightRandCreepsReq(activityId)
	local req = HolyLightExtension_pb.PM_HolyLightRandCreepsReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HolyLightAgent:handlePM_HolyLightRandCreepsRes(status, msg)
	if status == 0 then
		HolyLightController.instance:handlePM_HolyLightRandCreepsRes(msg)
	end
end

function HolyLightAgent:sendPM_HolyLightChoiceCreepsReq(activityId, creepsId)
	local req = HolyLightExtension_pb.PM_HolyLightChoiceCreepsReq()

	req.activityId = activityId
	req.creepsId = creepsId

	self:sendMsg(req)
end

function HolyLightAgent:handlePM_HolyLightChoiceCreepsRes(status, msg)
	if status == 0 then
		HolyLightController.instance:handlePM_HolyLightChoiceCreepsRes(msg)
	end
end

function HolyLightAgent:sendPM_HolyLightChallengeReq(activityId, form)
	local req = HolyLightExtension_pb.PM_HolyLightChallengeReq()

	req.activityId = activityId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function HolyLightAgent:handlePM_HolyLightChallengeRes(status, msg)
	HolyLightController.instance:handlePM_HolyLightChallengeRes(status, msg)
end

function HolyLightAgent:handlePM_HolyLightChallengeResultRes(status, msg)
	if status == 0 then
		HolyLightController.instance:handlePM_HolyLightChallengeResultRes(msg)
	end
end

function HolyLightAgent:sendPM_HolyLightGetRankReq(activityId)
	local req = HolyLightExtension_pb.PM_HolyLightGetRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HolyLightAgent:handlePM_HolyLightGetRankRes(status, msg)
	if status == 0 then
		HolyLightController.instance:handlePM_HolyLightGetRankRes(msg)
	end
end

HolyLightAgent.instance = HolyLightAgent.New()

return HolyLightAgent
