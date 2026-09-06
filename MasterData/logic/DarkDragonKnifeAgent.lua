-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/darkdragonknife/agent/DarkDragonKnifeAgent.lua

module("logic.extensions.darkdragonknife.agent.DarkDragonKnifeAgent", package.seeall)

local DarkDragonKnifeAgent = class("DarkDragonKnifeAgent", BaseAgent)

function DarkDragonKnifeAgent:sendPM_DarkDragonKnifeGetInfoReq(activityId)
	local req = DarkDragonKnifeExtension_pb.PM_DarkDragonKnifeGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DarkDragonKnifeAgent:handlePM_DarkDragonKnifeGetInfoRes(status, msg)
	if status == 0 then
		local maxgametime = msg.maxGameTime
		local hasgainprize = msg.hasGainPrize
		local buytimes = msg.buyTimes
		local usedtimes = msg.usedTimes
		local hasprop = msg.hasProp
		local propid = msg.propId
		local totalscore = msg.totalScore

		DDragonKModel.instance:setGameTime(maxgametime)
		DDragonKModel.instance:setHasGainPrize(hasgainprize)
		DDragonKModel.instance:setBuyTimes(buytimes)
		DDragonKModel.instance:setUseTimes(usedtimes)
		DDragonKModel.instance:setHasProp(hasprop)
		DDragonKModel.instance:setPropId(propid)
		DDragonKModel.instance:setTotalScore(totalscore)
		GlobalDispatcher:dispatch(GlobalNotify.DarkDragonKnifeGetInfo)
	end
end

function DarkDragonKnifeAgent:sendPM_DarkDragonKnifeGainPrizeReq(activityId, prizeId)
	local req = DarkDragonKnifeExtension_pb.PM_DarkDragonKnifeGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId
	self._resPrizeId = prizeId

	self:sendMsg(req)
end

function DarkDragonKnifeAgent:handlePM_DarkDragonKnifeGainPrizeRes(status, msg)
	if status == 0 then
		DDragonKModel.instance:setGainPrize(self._resPrizeId, true)
		GlobalDispatcher:dispatch(GlobalNotify.DarkDragonKnifeGainPrize)
	end
end

function DarkDragonKnifeAgent:sendPM_DarkDragonKnifeStartGameReq(activityId, clientKey)
	local req = DarkDragonKnifeExtension_pb.PM_DarkDragonKnifeStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function DarkDragonKnifeAgent:handlePM_DarkDragonKnifeStartGameRes(status, msg)
	if status == 0 then
		local clientkey = msg.clientKey
		local serverkey = msg.serverKey

		DDragonKModel.instance:setServerKey(serverkey)
		DDragonKModel.instance:setClientKey(clientkey)
		GlobalDispatcher:dispatch(GlobalNotify.DarkDragonKnifeGameStart)
	end
end

function DarkDragonKnifeAgent:sendPM_DarkDragonKnifeEndGameReq(time, encryptedKey)
	local req = DarkDragonKnifeExtension_pb.PM_DarkDragonKnifeEndGameReq()

	req.time = time
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function DarkDragonKnifeAgent:handlePM_DarkDragonKnifeEndGameRes(status, msg)
	if status == 0 then
		local maxgametime = msg.maxGameTime
		local totalscore = msg.totalScore

		DDragonKModel.instance:setTotalScore(totalscore)
		DDragonKModel.instance:setGameTime(maxgametime)

		local useTime = DDragonKModel.instance:getUseTimes()

		DDragonKModel.instance:setUseTimes(useTime + 1)
		GlobalDispatcher:dispatch(GlobalNotify.DarkDragonKnifeGetInfo)
	end
end

function DarkDragonKnifeAgent:sendPM_DarkDragonKnifeBuyTimesReq(activityId)
	local req = DarkDragonKnifeExtension_pb.PM_DarkDragonKnifeBuyTimesReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DarkDragonKnifeAgent:handlePM_DarkDragonKnifeBuyTimesRes(status, msg)
	if status == 0 then
		local buytimes = msg.buyTimes

		DDragonKModel.instance:setBuyTimes(buytimes)
		FloatWordMgr.instance:show("购买成功")
		GlobalDispatcher:dispatch(GlobalNotify.DarkDragonKnifeBuyTime)
	end
end

function DarkDragonKnifeAgent:sendPM_DarkDragonKnifeExchangeReq(activityId, propId)
	local req = DarkDragonKnifeExtension_pb.PM_DarkDragonKnifeExchangeReq()

	req.activityId = activityId
	req.propId = propId
	self._resExchangePropId = propId

	self:sendMsg(req)
end

function DarkDragonKnifeAgent:handlePM_DarkDragonKnifeExchangeRes(status, msg)
	if status == 0 then
		local propid = msg.propId
		local totalscore = msg.totalScore

		DDragonKModel.instance:setPropId(propid)
		DDragonKModel.instance:setTotalScore(totalscore)
		DDragonKModel.instance:setHasPropItem(self._resExchangePropId)
		FloatWordMgr.instance:show("兑换成功")
		GlobalDispatcher:dispatch(GlobalNotify.DarkDragonKnifeRefreshExchange)
	end
end

function DarkDragonKnifeAgent:sendPM_DarkDragonKnifeChangePropReq(activityId, propId)
	local req = DarkDragonKnifeExtension_pb.PM_DarkDragonKnifeChangePropReq()

	req.activityId = activityId
	req.propId = propId

	self:sendMsg(req)
end

function DarkDragonKnifeAgent:handlePM_DarkDragonKnifeChangePropRes(status, msg)
	if status == 0 then
		local propid = msg.propId

		DDragonKModel.instance:setPropId(propid)
		GlobalDispatcher:dispatch(GlobalNotify.DarkDragonKnifeRefreshExchange)
	end
end

DarkDragonKnifeAgent.instance = DarkDragonKnifeAgent.New()

return DarkDragonKnifeAgent
