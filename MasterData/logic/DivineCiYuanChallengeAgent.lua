-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineciyuan/agent/DivineCiYuanChallengeAgent.lua

module("logic.extensions.divineciyuanchallenge.agent.DivineCiYuanChallengeAgent", package.seeall)

local DivineCiYuanChallengeAgent = class("DivineCiYuanChallengeAgent", BaseAgent)

function DivineCiYuanChallengeAgent:sendPM_DivineCiYuanGetInfoReq(activityId)
	local req = DivineCiYuanChallengeExtension_pb.PM_DivineCiYuanGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineCiYuanChallengeAgent:handlePM_DivineCiYuanGetInfoRes(status, msg)
	if status == 0 then
		DivineCiYuanController.instance:handlePM_DivineCiYuanGetInfoRes(status, msg)
	end
end

function DivineCiYuanChallengeAgent:sendPM_DivineCiYuanGainPrizeReq(activityId, type)
	local req = DivineCiYuanChallengeExtension_pb.PM_DivineCiYuanGainPrizeReq()

	req.activityId = activityId
	req.type = type

	self:sendMsg(req)
end

function DivineCiYuanChallengeAgent:handlePM_DivineCiYuanGainPrizeRes(status, msg)
	if status == 0 then
		DivineCiYuanController.instance:handlePM_DivineCiYuanGainPrizeRes(status, msg)
	end
end

function DivineCiYuanChallengeAgent:sendPM_DivineCiYuanGainSelectBuffReq(activityId, tabId, buffId)
	local req = DivineCiYuanChallengeExtension_pb.PM_DivineCiYuanGainSelectBuffReq()

	req.activityId = activityId
	req.tabId = tabId
	req.buffId = buffId

	self:sendMsg(req)
end

function DivineCiYuanChallengeAgent:handlePM_DivineCiYuanGainSelectBuffRes(status, msg)
	if status == 0 then
		DivineCiYuanController.instance:handlePM_DivineCiYuanGainSelectBuffRes(status, msg)
	end
end

function DivineCiYuanChallengeAgent:sendPM_DivineCiYuanExtremeChallengeReq(activityId, tabId, stageId, teamIndex, form)
	local req = DivineCiYuanChallengeExtension_pb.PM_DivineCiYuanExtremeChallengeReq()

	req.activityId = activityId
	req.tabId = tabId
	req.stageId = stageId
	req.teamIndex = teamIndex

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineCiYuanChallengeAgent:handlePM_DivineCiYuanExtremeChallengeRes(status, msg)
	DivineCiYuanController.instance:handlePM_DivineCiYuanExtremeChallengeRes(status, msg)
end

function DivineCiYuanChallengeAgent:sendPM_DivineCiYuanExtremeResetReq(activityId, tabId, stageId, teamIndex)
	local req = DivineCiYuanChallengeExtension_pb.PM_DivineCiYuanExtremeResetReq()

	req.activityId = activityId
	req.tabId = tabId
	req.stageId = stageId
	req.teamIndex = teamIndex

	self:sendMsg(req)
end

function DivineCiYuanChallengeAgent:handlePM_DivineCiYuanExtremeResetRes(status, msg)
	if status == 0 then
		DivineCiYuanController.instance:handlePM_DivineCiYuanExtremeResetRes(status, msg)
	end
end

function DivineCiYuanChallengeAgent:sendPM_DivineCiYuanUniversalChallengeReq(activityId, tabId, bossId, form)
	local req = DivineCiYuanChallengeExtension_pb.PM_DivineCiYuanUniversalChallengeReq()

	req.activityId = activityId
	req.tabId = tabId
	req.bossId = bossId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineCiYuanChallengeAgent:handlePM_DivineCiYuanUniversalChallengeRes(status, msg)
	DivineCiYuanController.instance:handlePM_DivineCiYuanUniversalChallengeRes(status, msg)
end

function DivineCiYuanChallengeAgent:sendPM_DivineCiYuanUniversalOneKeyPassReq(activityId, priceCount)
	local req = DivineCiYuanChallengeExtension_pb.PM_DivineCiYuanUniversalOneKeyPassReq()

	req.activityId = activityId
	req.priceCount = priceCount

	self:sendMsg(req)
end

function DivineCiYuanChallengeAgent:handlePM_DivineCiYuanUniversalOneKeyPassRes(status, msg)
	if status == 0 then
		DivineCiYuanController.instance:handlePM_DivineCiYuanUniversalOneKeyPassRes(status, msg)
	end
end

function DivineCiYuanChallengeAgent:sendPM_DivineCiYuanUniversalSignInReq(activityId, tabId)
	local req = DivineCiYuanChallengeExtension_pb.PM_DivineCiYuanUniversalSignInReq()

	req.activityId = activityId
	req.tabId = tabId

	self:sendMsg(req)
end

function DivineCiYuanChallengeAgent:handlePM_DivineCiYuanUniversalSignInRes(status, msg)
	if status == 0 then
		DivineCiYuanController.instance:handlePM_DivineCiYuanUniversalSignInRes(status, msg)
	end
end

function DivineCiYuanChallengeAgent:sendPM_DivineCiYuanUniversalOneKeySignInReq(activityId)
	local req = DivineCiYuanChallengeExtension_pb.PM_DivineCiYuanUniversalOneKeySignInReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineCiYuanChallengeAgent:handlePM_DivineCiYuanUniversalOneKeySignInRes(status, msg)
	if status == 0 then
		DivineCiYuanController.instance:handlePM_DivineCiYuanUniversalOneKeySignInRes(status, msg)
	end
end

function DivineCiYuanChallengeAgent:handlePM_Notify_DivineCiYuanExtremeChallengeRes(status, msg)
	DivineCiYuanController.instance:handlePM_Notify_DivineCiYuanExtremeChallengeRes(status, msg)
end

function DivineCiYuanChallengeAgent:handlePM_Notify_DivineCiYuanUniversalChallengeRes(status, msg)
	if status == 0 then
		DivineCiYuanController.instance:handlePM_Notify_DivineCiYuanUniversalChallengeRes(status, msg)
	end
end

DivineCiYuanChallengeAgent.instance = DivineCiYuanChallengeAgent.New()

return DivineCiYuanChallengeAgent
