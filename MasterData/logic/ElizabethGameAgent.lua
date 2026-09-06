-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elizabethgame/agent/ElizabethGameAgent.lua

module("logic.extensions.elizabethgame.agent.ElizabethGameAgent", package.seeall)

local ElizabethGameAgent = class("ElizabethGameAgent", BaseAgent)

function ElizabethGameAgent:sendPM_ElizabethGameGetInfoReq(activityId)
	local req = ElizabethGameExtension_pb.PM_ElizabethGameGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ElizabethGameAgent:handlePM_ElizabethGameGetInfoRes(status, msg)
	if status == 0 then
		ElizabethgameController.instance:handlePM_ElizabethGameGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ElizabethGameGetInfoRes)
	end
end

function ElizabethGameAgent:sendPM_ElizabethGameStartGameReq(activityId, clientKey)
	local req = ElizabethGameExtension_pb.PM_ElizabethGameStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function ElizabethGameAgent:handlePM_ElizabethGameStartGameRes(status, msg)
	if status == 0 then
		ElizabethgameModel.instance:setServerKey(msg.encryptedKey)
		ElizabethgameModel.instance:setReliveTimes(0)
		ElizabethgameModel.instance:addUsedTimes()
		GlobalDispatcher:dispatch(GlobalNotify.ElizabethGameStartGameRes)
	end
end

function ElizabethGameAgent:sendPM_ElizabethGameEndGameReq(activityId, isPass, clicks, scale, clientEncryptedKey)
	local req = ElizabethGameExtension_pb.PM_ElizabethGameEndGameReq()

	req.activityId = activityId
	req.isPass = isPass
	req.clicks = clicks
	req.scale = scale
	req.clientEncryptedKey = clientEncryptedKey

	self:sendMsg(req)
end

function ElizabethGameAgent:handlePM_ElizabethGameEndGameRes(status, msg)
	if status == 0 then
		ElizabethgameController.instance:handlePM_ElizabethGameEndGameRes(msg)
	else
		forcePrint("验证不通过, status:", status)
		FloatWordMgr.instance:show("eceg:status:" .. status)
	end

	GlobalDispatcher:dispatch(GlobalNotify.ElizabethGameEndGameRes)
end

function ElizabethGameAgent:sendPM_ElizabethGameReliveReq(activityId)
	local req = ElizabethGameExtension_pb.PM_ElizabethGameReliveReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ElizabethGameAgent:handlePM_ElizabethGameReliveRes(status, msg)
	if status == 0 then
		ElizabethgameModel.instance:setReliveTimes(msg.reliveTimes)
		GlobalDispatcher:dispatch(GlobalNotify.ElizabethGameReliveRes)
	end
end

function ElizabethGameAgent:sendPM_ElizabethGameBuyTimesReq(activityId)
	local req = ElizabethGameExtension_pb.PM_ElizabethGameBuyTimesReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ElizabethGameAgent:handlePM_ElizabethGameBuyTimesRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("购买成功")
		ElizabethgameModel.instance:addBuyedTimes(msg.activityId, msg.buyTimes)
		GlobalDispatcher:dispatch(GlobalNotify.ElizabethGameBuyTimesRes)
	end
end

function ElizabethGameAgent:sendPM_ElizabethGameGainPrizeReq(activityId, prizeId)
	local req = ElizabethGameExtension_pb.PM_ElizabethGameGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function ElizabethGameAgent:handlePM_ElizabethGameGainPrizeRes(status, msg)
	if status == 0 then
		ElizabethgameController.instance:handlePM_ElizabethGameGainPrizeRes(msg.activityId)
		GlobalDispatcher:dispatch(GlobalNotify.ElizabethGameGainPrizeRes)
	end
end

function ElizabethGameAgent:sendPM_ElizabethGameQuitGameReq(activityId)
	local req = ElizabethGameExtension_pb.PM_ElizabethGameQuitGameReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ElizabethGameAgent:handlePM_ElizabethGameQuitGameRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.ElizabethGameQuitGameRes)
	end
end

ElizabethGameAgent.instance = ElizabethGameAgent.New()

return ElizabethGameAgent
