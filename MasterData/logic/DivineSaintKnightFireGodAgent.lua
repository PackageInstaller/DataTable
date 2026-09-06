-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/DivineSaintKnightFireGod/agent/DivineSaintKnightFireGodAgent.lua

module("logic.extensions.divinesaintknightfiregod.agent.DivineSaintKnightFireGodAgent", package.seeall)

local DivineSaintKnightFireGodAgent = class("DivineSaintKnightFireGodAgent", BaseAgent)

function DivineSaintKnightFireGodAgent:sendPM_DivineSaintKnightFireGodInfoReq(activityId)
	local req = DivineSaintKnightFireGodExtension_pb.PM_DivineSaintKnightFireGodInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineSaintKnightFireGodAgent:handlePM_DivineSaintKnightFireGodInfoRes(status, msg)
	if status == 0 then
		DivineSaintKnightFireGodModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineSaintKnightFireGodInfoRes)
	end
end

function DivineSaintKnightFireGodAgent:sendPM_DivineSaintKnightFireGodChallengeReq(activityId, form, buffAddTimes, stageId)
	local req = DivineSaintKnightFireGodExtension_pb.PM_DivineSaintKnightFireGodChallengeReq()

	req.activityId = activityId

	req.form:ParseFromString(form:SerializeToString())

	for i, v in ipairs(buffAddTimes) do
		req.buffAddTimes:append(v)
	end

	req.stageId = stageId

	self:sendMsg(req)
end

function DivineSaintKnightFireGodAgent:handlePM_DivineSaintKnightFireGodChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.DivineSaintKnightFireGodChallengeRes)
	end
end

function DivineSaintKnightFireGodAgent:handlePM_DivineSaintKnightFireGodNotifyChallengeRes(status, msg)
	if status == 0 then
		DivineSaintKnightFireGodModel.instance:onChallengeRes(msg)

		if DivineSaintKnightFireGodController.instance:isClgPass(msg.activityId) then
			UIJumper.instance:removeTopState(ViewName.DivinesaintknightfiregodstageView)
		end

		GlobalDispatcher:dispatch(GlobalNotify.DivineSaintKnightFireGodNotifyChallengeRes)
	end
end

DivineSaintKnightFireGodAgent.instance = DivineSaintKnightFireGodAgent.New()

return DivineSaintKnightFireGodAgent
