-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/agent/TimedChallengeMiYaAgent.lua

module("logic.extensions.timedchallengemiya.agent.TimedChallengeMiYaAgent", package.seeall)

local TimedChallengeMiYaAgent = class("TimedChallengeMiYaAgent", BaseAgent)

TimedChallengeMiYaAgent.PM_TimedChallengeMiYaInfoRes = "TimedChallengeMiYaAgent_PM_TimedChallengeMiYaInfoRes"
TimedChallengeMiYaAgent.PM_TimedChallengeMiYaGainDailyPrizeRes = "TimedChallengeMiYaAgent_PM_TimedChallengeMiYaGainDailyPrizeRes"
TimedChallengeMiYaAgent.PM_TimedChallengeMiYaRandomModeRes = "TimedChallengeMiYaAgent_PM_TimedChallengeMiYaRandomModeRes"
TimedChallengeMiYaAgent.PM_TimedChallengeMiYaProcessModeRes = "TimedChallengeMiYaAgent_PM_TimedChallengeMiYaProcessModeRes"
TimedChallengeMiYaAgent.PM_TimedChallengeMiYaEventFinishRes = "TimedChallengeMiYaAgent_PM_TimedChallengeMiYaEventFinishRes"
TimedChallengeMiYaAgent.PM_TimedChallengeMiYaBuyAwakenGoodsRes = "TimedChallengeMiYaAgent_PM_TimedChallengeMiYaBuyAwakenGoodsRes"

function TimedChallengeMiYaAgent:ctor()
	return
end

function TimedChallengeMiYaAgent:setExtId(extId)
	TimedChallengeMiYaAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function TimedChallengeMiYaAgent:sendPM_TimedChallengeMiYaInfoReq(handler, handlerObj, errHandler)
	local req = TimedChallengeMiYaExtension_pb.PM_TimedChallengeMiYaInfoReq()

	self:sendMsg(req)
	self:addEventOnce(TimedChallengeMiYaAgent.PM_TimedChallengeMiYaInfoRes, handler, handlerObj, errHandler)
end

function TimedChallengeMiYaAgent:handlePM_TimedChallengeMiYaInfoRes(status, msg)
	self:dispatch(TimedChallengeMiYaAgent.PM_TimedChallengeMiYaInfoRes, status, msg)
end

function TimedChallengeMiYaAgent:sendPM_TimedChallengeMiYaGainDailyPrizeReq(handler, handlerObj, errHandler)
	local req = TimedChallengeMiYaExtension_pb.PM_TimedChallengeMiYaGainDailyPrizeReq()

	self:sendMsg(req)
	self:addEventOnce(TimedChallengeMiYaAgent.PM_TimedChallengeMiYaGainDailyPrizeRes, handler, handlerObj, errHandler)
end

function TimedChallengeMiYaAgent:handlePM_TimedChallengeMiYaGainDailyPrizeRes(status, msg)
	self:dispatch(TimedChallengeMiYaAgent.PM_TimedChallengeMiYaGainDailyPrizeRes, status, msg)
end

function TimedChallengeMiYaAgent:sendPM_TimedChallengeMiYaRandomModeReq(difficulty, handler, handlerObj, errHandler)
	local req = TimedChallengeMiYaExtension_pb.PM_TimedChallengeMiYaRandomModeReq()

	req.difficulty = difficulty

	self:sendMsg(req)
	self:addEventOnce(TimedChallengeMiYaAgent.PM_TimedChallengeMiYaRandomModeRes, handler, handlerObj, errHandler)
end

function TimedChallengeMiYaAgent:handlePM_TimedChallengeMiYaRandomModeRes(status, msg)
	self:dispatch(TimedChallengeMiYaAgent.PM_TimedChallengeMiYaRandomModeRes, status, msg)
end

function TimedChallengeMiYaAgent:sendPM_TimedChallengeMiYaProcessModeReq(processState, clientKey, encryptedKey, differentNum, questionIds_i32_Ary, answerIds_i32_Ary, handler, handlerObj, errHandler)
	if processState == 3 then
		print("MiyaEndGameReq")
		print(debug.traceback())
	end

	local req = TimedChallengeMiYaExtension_pb.PM_TimedChallengeMiYaProcessModeReq()

	req.processState = processState

	if clientKey ~= nil then
		req.clientKey = clientKey
	end

	if encryptedKey ~= nil then
		req.encryptedKey = encryptedKey
	end

	if differentNum ~= nil then
		req.differentNum = differentNum
	end

	if questionIds_i32_Ary then
		for i, v1 in ipairs(questionIds_i32_Ary) do
			req.questionIds:append(v1)
		end
	end

	if answerIds_i32_Ary then
		for i, v2 in ipairs(answerIds_i32_Ary) do
			req.answerIds:append(v2)
		end
	end

	self:sendMsg(req)
	self:addEventOnce(TimedChallengeMiYaAgent.PM_TimedChallengeMiYaProcessModeRes, handler, handlerObj, errHandler)
end

function TimedChallengeMiYaAgent:handlePM_TimedChallengeMiYaProcessModeRes(status, msg)
	self:dispatch(TimedChallengeMiYaAgent.PM_TimedChallengeMiYaProcessModeRes, status, msg)
end

function TimedChallengeMiYaAgent:handlePM_TimedChallengeMiYaEventFinishRes(status, msg)
	self:dispatch(TimedChallengeMiYaAgent.PM_TimedChallengeMiYaEventFinishRes, status, msg)
end

function TimedChallengeMiYaAgent:handlePM_TimedChallengeMiYaBuyAwakenGoodsRes(status, msg)
	self:dispatch(TimedChallengeMiYaAgent.PM_TimedChallengeMiYaBuyAwakenGoodsRes, status, msg)
end

TimedChallengeMiYaAgent.instance = TimedChallengeMiYaAgent.New()

return TimedChallengeMiYaAgent
