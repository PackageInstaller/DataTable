-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/niannianchall/agent/NianChallengeAgent.lua

module("logic.extensions.nianchallenge.agent.NianChallengeAgent", package.seeall)

local NianChallengeAgent = class("NianChallengeAgent", BaseAgent)

function NianChallengeAgent:sendPM_NianChallengeInfoReq()
	local req = NianChallengeExtension_pb.PM_NianChallengeInfoReq()

	self:sendMsg(req)
end

function NianChallengeAgent:handlePM_NianChallengeInfoRes(status, msg)
	if status == 0 then
		local allclear = msg.allClear
		local stage = msg.stage
		local challengetimes = msg.challengeTimes
		local buytimes = msg.buyTimes
		local bufflevel = msg.buffLevel
		local gotbuff = msg.gotBuff
		local processprize = msg.processPrize
		local growthpath = msg.growthPath

		NianNianChallModel.instance:setAllClear(allclear)
		NianNianChallModel.instance:setStageId(stage)
		NianNianChallModel.instance:setChallengeTimes(challengetimes)
		NianNianChallModel.instance:setBuyTimes(buytimes)
		NianNianChallModel.instance:setBuffLevel(bufflevel)
		NianNianChallModel.instance:setGotBuff(gotbuff)

		for k, v in ipairs(processprize) do
			NianNianChallModel.instance:setProcessPrize(v)
		end

		NianNianChallModel.instance:setGrowthPath(growthpath)
		GlobalDispatcher:dispatch(GlobalNotify.NianNianChallGetInfo)
	end
end

function NianChallengeAgent:sendPM_NianChallengeReq(form)
	local req = NianChallengeExtension_pb.PM_NianChallengeReq()

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function NianChallengeAgent:handlePM_NianChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.NianNianChallChallRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)
	end
end

function NianChallengeAgent:sendPM_NianChallengeBuyTimesReq()
	local req = NianChallengeExtension_pb.PM_NianChallengeBuyTimesReq()

	self:sendMsg(req)
end

function NianChallengeAgent:handlePM_NianChallengeBuyTimesRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function NianChallengeAgent:sendPM_NianChallengeGetBuffReq()
	local req = NianChallengeExtension_pb.PM_NianChallengeGetBuffReq()

	self:sendMsg(req)
end

function NianChallengeAgent:handlePM_NianChallengeGetBuffRes(status, msg)
	if status == 0 then
		local bufflevel = NianNianChallModel.instance:getBuffLevel()

		NianNianChallModel.instance:setBuffLevel(bufflevel + 1)
		NianNianChallModel.instance:setGotBuff(true)
		GlobalDispatcher:dispatch(GlobalNotify.NianNianChallBuff)
	end
end

function NianChallengeAgent:sendPM_NianChallengeGainProcessPrizeReq(id)
	local req = NianChallengeExtension_pb.PM_NianChallengeGainProcessPrizeReq()

	req.id = id
	self._prizeId = id

	self:sendMsg(req)
end

function NianChallengeAgent:handlePM_NianChallengeGainProcessPrizeRes(status, msg)
	if status == 0 then
		NianNianChallModel.instance:setProcessPrize(self._prizeId)
		GlobalDispatcher:dispatch(GlobalNotify.NianNianChallGetPrize)
	end
end

function NianChallengeAgent:handlePM_NotifyNianChallengeEndRes(status, msg)
	if status == 0 then
		local iswin = msg.isWin

		if iswin then
			local times = NianNianChallModel.instance:getChallengeTimes()

			NianNianChallModel.instance:setChallengeTimes(times + 1)

			local stageId = NianNianChallModel.instance:getStageId()

			NianNianChallModel.instance:setStageId(stageId + 1)
		end

		GlobalDispatcher:dispatch(GlobalNotify.NianNianChallResult, msg)
	end
end

NianChallengeAgent.instance = NianChallengeAgent.New()

return NianChallengeAgent
