-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/noahchallenge/agent/NoahChallengeAgent.lua

module("logic.extensions.noahchallenge.agent.NoahChallengeAgent", package.seeall)

local NoahChallengeAgent = class("NoahChallengeAgent", BaseAgent)

function NoahChallengeAgent:sendPM_NoahChallengeInfoReq(challengeId)
	local req = NoahChallengeExtension_pb.PM_NoahChallengeInfoReq()

	req.challengeId = challengeId

	self:sendMsg(req)

	self._infoChallengeId = challengeId
end

function NoahChallengeAgent:handlePM_NoahChallengeInfoRes(status, msg)
	if status == 0 then
		NoahChallengeModel.instance:onNoahChallengeInfoRes(self._infoChallengeId, msg)

		self._infoChallengeId = nil

		GlobalDispatcher:dispatch(GlobalNotify.NoahChallengeInfoRes)
	end
end

function NoahChallengeAgent:sendPM_NoahChallengeReq(challengeId, form)
	local req = NoahChallengeExtension_pb.PM_NoahChallengeReq()

	req.challengeId = challengeId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function NoahChallengeAgent:handlePM_NoahChallengeRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.NoahChallengeRes, status, msg)
end

function NoahChallengeAgent:sendPM_NoahChallengeResetReq(challengeId)
	local req = NoahChallengeExtension_pb.PM_NoahChallengeResetReq()

	req.challengeId = challengeId

	self:sendMsg(req)

	self._resetChallengeId = challengeId
end

function NoahChallengeAgent:handlePM_NoahChallengeResetRes(status, msg)
	if status == 0 then
		NoahChallengeModel.instance:onNoahChallengeResetRes(self._resetChallengeId, msg)

		self._resetChallengeId = nil

		GlobalDispatcher:dispatch(GlobalNotify.NoahChallengeResetRes)
	end
end

function NoahChallengeAgent:handlePM_NoahChallengeEndRes(status, msg)
	if status == 0 then
		if msg.isWin then
			NoahChallengeModel.instance:onNoahChallengeEndRes(msg)
		end

		GlobalDispatcher:dispatch(GlobalNotify.NoahChallengeEndRes, msg.challengeId)
	end
end

function NoahChallengeAgent:handlePM_NoahChallengeBuyEndRes(status, msg)
	if status == 0 then
		NoahChallengeModel.instance:onNoahChallengeBuyEndRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NoahChallengeBuyEndRes)
	end
end

function NoahChallengeAgent:sendPM_NoahChallengeBaseInfoReq()
	local req = NoahChallengeExtension_pb.PM_NoahChallengeBaseInfoReq()

	self:sendMsg(req)
end

function NoahChallengeAgent:handlePM_NoahChallengeBaseInfoRes(status, msg)
	if status == 0 then
		NoahChallengeModel.instance:onNoahChallengeBaseInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NoahChallengeBaseInfoRes)
	end
end

NoahChallengeAgent.instance = NoahChallengeAgent.New()

return NoahChallengeAgent
