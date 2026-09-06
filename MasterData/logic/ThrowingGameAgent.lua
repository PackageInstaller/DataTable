-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throwshells/agent/ThrowingGameAgent.lua

module("logic.extensions.throwinggame.agent.ThrowingGameAgent", package.seeall)

local ThrowingGameAgent = class("ThrowingGameAgent", BaseAgent)

function ThrowingGameAgent:sendPM_ThrowingGameGetInfoReq(activityId)
	local req = ThrowingGameExtension_pb.PM_ThrowingGameGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ThrowingGameAgent:handlePM_ThrowingGameGetInfoRes(status, msg)
	if status == 0 then
		local maxbarrierid = msg.maxBarrierId
		local buytimes = msg.buyTimes
		local usedtimes = msg.usedTimes

		ThrowShellsModel.instance:setBarrierId(maxbarrierid)
		ThrowShellsModel.instance:setBuyTimes(buytimes)
		ThrowShellsModel.instance:setUseTimes(usedtimes)
		GlobalDispatcher:dispatch(GlobalNotify.ThrowShellsGetInfo)
	end
end

function ThrowingGameAgent:sendPM_ThrowingGameStartGameReq(activityId, barrierId, clientKey)
	local req = ThrowingGameExtension_pb.PM_ThrowingGameStartGameReq()

	req.activityId = activityId
	req.barrierId = barrierId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function ThrowingGameAgent:handlePM_ThrowingGameStartGameRes(status, msg)
	if status == 0 then
		local clientkey = msg.clientKey
		local serverkey = msg.serverKey

		ThrowShellsModel.instance:setServerKey(serverkey)
		ThrowShellsModel.instance:setClientKey(clientkey)
		GlobalDispatcher:dispatch(GlobalNotify.ThrowShellsGameStart)
	end
end

function ThrowingGameAgent:sendPM_ThrowingGameEndGameReq(barrierId, isPass, encryptedKey)
	local req = ThrowingGameExtension_pb.PM_ThrowingGameEndGameReq()

	req.barrierId = barrierId
	req.isPass = isPass
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function ThrowingGameAgent:handlePM_ThrowingGameEndGameRes(status, msg)
	if status == 0 then
		local usedtimes = msg.usedTimes
		local maxbarrierid = msg.maxBarrierId

		ThrowShellsModel.instance:setBarrierId(maxbarrierid)
		ThrowShellsModel.instance:setUseTimes(usedtimes)
		GlobalDispatcher:dispatch(GlobalNotify.ThrowShellsGetInfo)
	end
end

function ThrowingGameAgent:sendPM_ThrowingGameBuyTimesReq(activityId)
	local req = ThrowingGameExtension_pb.PM_ThrowingGameBuyTimesReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ThrowingGameAgent:handlePM_ThrowingGameBuyTimesRes(status, msg)
	if status == 0 then
		local buytimes = msg.buyTimes

		ThrowShellsModel.instance:setBuyTimes(buytimes)
		FloatWordMgr.instance:show("购买成功")
		GlobalDispatcher:dispatch(GlobalNotify.ThrowShellsBuyTime)
	end
end

ThrowingGameAgent.instance = ThrowingGameAgent.New()

return ThrowingGameAgent
