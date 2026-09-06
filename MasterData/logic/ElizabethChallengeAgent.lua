-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/agent/ElizabethChallengeAgent.lua

module("logic.extensions.elizabethchallenge.agent.ElizabethChallengeAgent", package.seeall)

local ElizabethChallengeAgent = class("ElizabethChallengeAgent", BaseAgent)

function ElizabethChallengeAgent:sendPM_ElizabethClgGetInfoReq()
	local req = ElizabethChallengeExtension_pb.PM_ElizabethClgGetInfoReq()

	self:sendMsg(req)
end

function ElizabethChallengeAgent:handlePM_ElizabethClgGetInfoRes(status, msg)
	if status == 0 then
		ElizabethModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.EliGetInfoRes)
	end
end

function ElizabethChallengeAgent:sendPM_ElizabethClgStartGameReq(clientKey)
	local req = ElizabethChallengeExtension_pb.PM_ElizabethClgStartGameReq()

	req.clientKey = clientKey

	self:sendMsg(req)
end

function ElizabethChallengeAgent:handlePM_ElizabethClgStartGameRes(status, msg)
	if status == 0 then
		ElizabethModel.instance:setServerKey(msg.encryptedKey)
		ElizabethModel.instance:setReliveTimes(0)
		ElizabethModel.instance:addUsedTimes()
		GlobalDispatcher:dispatch(GlobalNotify.EliStartGameRes)
	end
end

function ElizabethChallengeAgent:sendPM_ElizabethClgEndGameReq(isPass, clicks, scale, clientEncryptedKey)
	local req = ElizabethChallengeExtension_pb.PM_ElizabethClgEndGameReq()

	req.isPass = isPass
	req.clicks = clicks
	req.scale = scale
	req.clientEncryptedKey = clientEncryptedKey

	self:sendMsg(req)
end

function ElizabethChallengeAgent:handlePM_ElizabethClgEndGameRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.EliEndGameRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.EliEndGameRes)
		forcePrint("验证不通过, status:", status)
		FloatWordMgr.instance:show("eceg:status:" .. status)
	end
end

function ElizabethChallengeAgent:sendPM_ElizabethClgReliveReq()
	local req = ElizabethChallengeExtension_pb.PM_ElizabethClgReliveReq()

	self:sendMsg(req)
end

function ElizabethChallengeAgent:handlePM_ElizabethClgReliveRes(status, msg)
	if status == 0 then
		ElizabethModel.instance:setReliveTimes(msg.relivetimes)
		GlobalDispatcher:dispatch(GlobalNotify.EliReliveRes)
	end
end

function ElizabethChallengeAgent:sendPM_ElizabethClgBuyTimesReq(successCb)
	self._cb = successCb

	local req = ElizabethChallengeExtension_pb.PM_ElizabethClgBuyTimesReq()

	self:sendMsg(req)
end

function ElizabethChallengeAgent:handlePM_ElizabethClgBuyTimesRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("购买成功")
		ElizabethModel.instance:addBuyedTimes()
		GlobalDispatcher:dispatch(GlobalNotify.EliBuyTimesRes)
		GameUtil.callBack(self._cb)
	end
end

function ElizabethChallengeAgent:sendPM_ElizabethClgGainPrizeReq(prizeIndex)
	local req = ElizabethChallengeExtension_pb.PM_ElizabethClgGainPrizeReq()

	req.prizeIndex = prizeIndex
	self._prizeIndex = prizeIndex

	self:sendMsg(req)
end

function ElizabethChallengeAgent:handlePM_ElizabethClgGainPrizeRes(status, msg)
	if status == 0 then
		ElizabethModel.instance:setPrizeGained(self._prizeIndex)
		GlobalDispatcher:dispatch(GlobalNotify.EliGainPrizeRes)
	end
end

ElizabethChallengeAgent.instance = ElizabethChallengeAgent.New()

return ElizabethChallengeAgent
