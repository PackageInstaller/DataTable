-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschool/agent/MagicSchoolAgent.lua

module("logic.extensions.magicschool.agent.MagicSchoolAgent", package.seeall)

local MagicSchoolAgent = class("MagicSchoolAgent", BaseAgent)

function MagicSchoolAgent:sendPM_MagicSchoolGetInfoReq(activityId)
	local req = MagicSchoolExtension_pb.PM_MagicSchoolGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MagicSchoolAgent:handlePM_MagicSchoolGetInfoRes(status, msg)
	MagicSchoolController.instance:handlePM_MagicSchoolGetInfoRes(status, msg)
end

function MagicSchoolAgent:sendPM_MagicSchoolVisitReq(activityId, prizeId)
	local req = MagicSchoolExtension_pb.PM_MagicSchoolVisitReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function MagicSchoolAgent:handlePM_MagicSchoolVisitRes(status, msg)
	if status == 0 then
		MagicSchoolController.instance:handlePM_MagicSchoolVisitRes(msg)
	end
end

function MagicSchoolAgent:sendPM_MagicSchoolJoinCampReq(activityId)
	local req = MagicSchoolExtension_pb.PM_MagicSchoolJoinCampReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MagicSchoolAgent:handlePM_MagicSchoolJoinCampRes(status, msg)
	MagicSchoolController.instance:handlePM_MagicSchoolJoinCampRes(status, msg)
end

function MagicSchoolAgent:sendPM_MagicSchoolSelectBuffReq(activityId, buffId)
	local req = MagicSchoolExtension_pb.PM_MagicSchoolSelectBuffReq()

	req.activityId = activityId
	req.buffId = buffId

	self:sendMsg(req)
end

function MagicSchoolAgent:handlePM_MagicSchoolSelectBuffRes(status, msg)
	if status == 0 then
		MagicSchoolController.instance:handlePM_MagicSchoolSelectBuffRes(msg)
	end
end

function MagicSchoolAgent:sendPM_MagicSchoolChallengeReq(activityId, stageId, form)
	local req = MagicSchoolExtension_pb.PM_MagicSchoolChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function MagicSchoolAgent:handlePM_MagicSchoolChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function MagicSchoolAgent:sendPM_MagicSchoolGainLevelPrizeReq(activityId, level)
	local req = MagicSchoolExtension_pb.PM_MagicSchoolGainLevelPrizeReq()

	req.activityId = activityId
	req.level = level

	self:sendMsg(req)
end

function MagicSchoolAgent:handlePM_MagicSchoolGainLevelPrizeRes(status, msg)
	if status == 0 then
		MagicSchoolController.instance:handlePM_MagicSchoolGainLevelPrizeRes(msg)
	end
end

function MagicSchoolAgent:handlePM_Notify_MagicSchoolChallengeResult(status, msg)
	if status == 0 then
		MagicSchoolController.instance:handlePM_Notify_MagicSchoolChallengeResult(msg)
	end
end

MagicSchoolAgent.instance = MagicSchoolAgent.New()

return MagicSchoolAgent
