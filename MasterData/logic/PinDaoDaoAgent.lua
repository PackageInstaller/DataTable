-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pindaodao/agent/PinDaoDaoAgent.lua

module("logic.extensions.pindaodao.agent.PinDaoDaoAgent", package.seeall)

local PinDaoDaoAgent = class("PinDaoDaoAgent", BaseAgent)

function PinDaoDaoAgent:sendPM_PinDaoDaoGetInfoReq(activityId)
	local req = PinDaoDaoExtension_pb.PM_PinDaoDaoGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PinDaoDaoAgent:handlePM_PinDaoDaoGetInfoRes(status, msg)
	if status == 0 then
		PinDaoDaoController.instance:handleGetInfo(msg)
	end
end

function PinDaoDaoAgent:sendPM_PinDaoDaoHelpReduceReq(activityId, targetPlayerId)
	local req = PinDaoDaoExtension_pb.PM_PinDaoDaoHelpReduceReq()

	req.activityId = activityId
	req.targetPlayerId = targetPlayerId

	self:sendMsg(req)
end

function PinDaoDaoAgent:handlePM_PinDaoDaoHelpReduceRes(status, msg)
	if status == 0 then
		PinDaoDaoController.instance:handleHelpReduce(msg)
	end
end

function PinDaoDaoAgent:sendPM_PinDaoDaoBuyGoodsReq(activityId, goodsId)
	local req = PinDaoDaoExtension_pb.PM_PinDaoDaoBuyGoodsReq()

	req.activityId = activityId
	req.goodsId = goodsId

	self:sendMsg(req)
end

function PinDaoDaoAgent:handlePM_PinDaoDaoBuyGoodsRes(status, msg)
	if status == 0 then
		PinDaoDaoController.instance:handleBuyGoods(msg)
	end
end

function PinDaoDaoAgent:sendPM_PinDaoDaoPlayerInfoReq(activityId, playerId)
	local req = PinDaoDaoExtension_pb.PM_PinDaoDaoPlayerInfoReq()

	req.activityId = activityId
	req.playerId = playerId

	self:sendMsg(req)
end

function PinDaoDaoAgent:handlePM_PinDaoDaoPlayerInfoRes(status, msg)
	if status == 0 then
		PinDaoDaoController.instance:handleViewPlayerGoodsInfo(msg)
	end
end

function PinDaoDaoAgent:sendPM_PinDaoDaoChatReq(activityId, friendUserId_i64_Ary, goodsId)
	local req = PinDaoDaoExtension_pb.PM_PinDaoDaoChatReq()

	req.activityId = activityId

	for i, v1 in ipairs(friendUserId_i64_Ary) do
		req.friendUserId:append(v1)
	end

	req.goodsId = goodsId

	self:sendMsg(req)
end

function PinDaoDaoAgent:handlePM_PinDaoDaoChatRes(status, msg)
	if status == 0 then
		PinDaoDaoController.instance:handlePM_PinDaoDaoChatRes(msg)
	end
end

function PinDaoDaoAgent:handlePM_PinDaoDaoNotifyReduceRes(status, msg)
	if status == 0 then
		PinDaoDaoController.instance:notifyReduceInfoChange(msg)
	end
end

PinDaoDaoAgent.instance = PinDaoDaoAgent.New()

return PinDaoDaoAgent
