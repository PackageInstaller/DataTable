-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weekreward/agent/WeekRewardAgent.lua

module("logic.extensions.weekreward.agent.WeekRewardAgent", package.seeall)

local WeekRewardAgent = class("WeekRewardAgent", BaseAgent)

function WeekRewardAgent:sendSignInInfoReq()
	local req = SignInExtension_pb.SignInInfoReq()

	self:sendMsg(req)
end

function WeekRewardAgent:handleSignInInfoRes(status, msg)
	if status == 0 then
		WeekRewardModel.instance:onGetSignInData(msg)
		WeekRewardController.instance:localNotify("WeekInfoGot")
	end
end

function WeekRewardAgent:sendSignInGainPrizeReq()
	local req = SignInExtension_pb.SignInGainPrizeReq()

	req.prizeReq.petId = 0

	self:sendMsg(req)
end

function WeekRewardAgent:handleSignInGainPrizeRes(status, msg)
	if status == 0 then
		WeekRewardModel.instance:onGainSignInReward()
		WeekRewardController.instance:localNotify("WeekSignIn")
	end
end

WeekRewardAgent.instance = WeekRewardAgent.New()

return WeekRewardAgent
