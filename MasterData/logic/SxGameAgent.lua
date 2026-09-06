-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/agent/SxGameAgent.lua

module("logic.extensions.sxgame.agent.SxGameAgent", package.seeall)

local SxGameAgent = class("SxGameAgent", BaseAgent)

function SxGameAgent:sendStartGameReq(clientKey, callback)
	self.startGameCallback = callback

	local req = AncientFossilSiteExtension_pb.StartGameReq()

	req.clientKey = clientKey

	self:sendMsg(req)
end

function SxGameAgent:handleStartGameRes(state, msg)
	if state == 0 then
		SxGameModel.instance:setServerKey(msg.serverKey)
		GameUtil.callBack(self.startGameCallback)

		self.startGameCallback = nil
	end
end

function SxGameAgent:sendEndGameReq(step, changeSetId, redNum, greenNum, blueNum, purpleNum)
	local req = AncientFossilSiteExtension_pb.EndGameReq()

	req.step = step

	local tb = {}

	table.insert(tb, redNum)
	table.insert(tb, greenNum)
	table.insert(tb, blueNum)
	table.insert(tb, purpleNum)

	local encryptedKey = 0
	local clientKey = SxGameModel.instance:getClientKey()
	local serverKey = GenEncryptedKeyUtil.dxor(SxGameModel.instance:getServerKey(), clientKey)

	for i, num in ipairs(tb) do
		req.fossilNums:append(num)

		encryptedKey = num % 2 == 0 and encryptedKey + (num + serverKey) * 5381 or encryptedKey + (num + clientKey) * 31
	end

	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function SxGameAgent:handleEndGameRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function SxGameAgent:sendGainScorePrizeReq(periodId, prizeId)
	local req = AncientFossilSiteExtension_pb.GainScorePrizeReq()

	req.periodId = periodId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function SxGameAgent:handleGainScorePrizeRes(status, msg)
	if status == 0 then
		SxGameController.instance:onGetProgressPrize(msg)
	end
end

function SxGameAgent:sendAncientFossilSiteGetInfoReq()
	local req = AncientFossilSiteExtension_pb.AncientFossilSiteGetInfoReq()

	self:sendMsg(req)
end

function SxGameAgent:handleAncientFossilSiteGetInfoRes(status, msg)
	if status == 0 then
		SxGameController.instance:onGetActInfo(msg)
	end
end

SxGameAgent.instance = SxGameAgent.New()

return SxGameAgent
