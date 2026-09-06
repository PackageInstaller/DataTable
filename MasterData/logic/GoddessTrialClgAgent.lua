-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesstrial/agent/GoddessTrialClgAgent.lua

module("logic.extensions.goddesstrialclg.agent.GoddessTrialClgAgent", package.seeall)

local GoddessTrialClgAgent = class("GoddessTrialClgAgent", BaseAgent)

function GoddessTrialClgAgent:sendPM_GoddessTrialGetInfoReq(activityId)
	local req = GoddessTrialClgExtension_pb.PM_GoddessTrialGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GoddessTrialClgAgent:handlePM_GoddessTrialGetInfoRes(status, msg)
	if status == 0 then
		GoddessTrialController.instance:handlePM_GoddessTrialGetInfoRes(msg)
	end
end

function GoddessTrialClgAgent:sendPM_GoddessTrialFightReq(activityId, form, option)
	local req = GoddessTrialClgExtension_pb.PM_GoddessTrialFightReq()

	req.activityId = activityId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	req.option:ParseFromString(option:SerializeToString())
	self:sendMsg(req)
end

function GoddessTrialClgAgent:handlePM_GoddessTrialFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function GoddessTrialClgAgent:handlePM_GoddessTrialNormalFightRes(status, msg)
	if status == 0 then
		GoddessTrialController.instance:handlePM_GoddessTrialNormalFightRes(msg)
	end
end

function GoddessTrialClgAgent:handlePM_GoddessTrialSuperFightRes(status, msg)
	if status == 0 then
		GoddessTrialController.instance:handlePM_GoddessTrialSuperFightRes(msg)
	end
end

function GoddessTrialClgAgent:handlePM_GoddessTrialBossFightRes(status, msg)
	if status == 0 then
		GoddessTrialController.instance:handlePM_GoddessTrialBossFightRes(msg)
	end
end

function GoddessTrialClgAgent:sendPM_GoddessTrialGainPrizeReq(activityId, prizeIds)
	local req = GoddessTrialClgExtension_pb.PM_GoddessTrialGainPrizeReq()

	req.activityId = activityId

	if prizeIds then
		for i, v in ipairs(prizeIds) do
			req.prizeIds:append(v)
		end
	end

	self:sendMsg(req)
end

function GoddessTrialClgAgent:handlePM_GoddessTrialGainPrizeRes(status, msg)
	if status == 0 then
		GoddessTrialController.instance:handlePM_GoddessTrialGainPrizeRes(msg)
	end
end

function GoddessTrialClgAgent:sendPM_GoddessTrialRankViewReq(activityId, stepId)
	local req = GoddessTrialClgExtension_pb.PM_GoddessTrialRankViewReq()

	req.activityId = activityId
	req.stepId = stepId

	self:sendMsg(req)
end

function GoddessTrialClgAgent:handlePM_GoddessTrialRankViewRes(status, msg)
	if status == 0 then
		GoddessTrialController.instance:handlePM_GoddessTrialRankViewRes(msg)
	end
end

GoddessTrialClgAgent.instance = GoddessTrialClgAgent.New()

return GoddessTrialClgAgent
