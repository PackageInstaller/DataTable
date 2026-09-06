-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesslantern/agent/GuessLanternAgent.lua

module("logic.extensions.guesslantern.agent.GuessLanternAgent", package.seeall)

local GuessLanternAgent = class("GuessLanternAgent", BaseAgent)

function GuessLanternAgent:sendPM_GuessLanternGetInfoReq(actId)
	local req = GuessLanternExtension_pb.PM_GuessLanternGetInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function GuessLanternAgent:handlePM_GuessLanternGetInfoRes(status, msg)
	if status == 0 then
		GuessLanternModel.instance:onGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GuessLanternGetInfoRes)
	end
end

function GuessLanternAgent:sendPM_GuessLanternIncProgressReq(actId, problemId)
	local req = GuessLanternExtension_pb.PM_GuessLanternIncProgressReq()

	req.actId = actId
	req.problemId = problemId

	self:sendMsg(req)
end

function GuessLanternAgent:handlePM_GuessLanternIncProgressRes(status, msg)
	if status == 0 then
		GuessLanternModel.instance:onIncProgressRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GuessLanternIncProgressRes)
	end
end

function GuessLanternAgent:sendPM_GuessLanternGainPrizeReq(actId, prizeId)
	local req = GuessLanternExtension_pb.PM_GuessLanternGainPrizeReq()

	req.actId = actId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function GuessLanternAgent:handlePM_GuessLanternGainPrizeRes(status, msg)
	if status == 0 then
		GuessLanternModel.instance:onGainPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GuessLanternGainPrizeRes)
	end
end

GuessLanternAgent.instance = GuessLanternAgent.New()

return GuessLanternAgent
