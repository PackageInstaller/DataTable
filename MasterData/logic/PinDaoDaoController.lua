-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pindaodao/controller/PinDaoDaoController.lua

module("logic.extensions.pindaodao.controller.PinDaoDaoController", package.seeall)

local PinDaoDaoController = class("PinDaoDaoController", BaseController)

function PinDaoDaoController:onInit()
	self:onReset()
end

function PinDaoDaoController:onReset()
	return
end

function PinDaoDaoController:getInfo(activityId)
	PinDaoDaoAgent.instance:sendPM_PinDaoDaoGetInfoReq(activityId)
end

function PinDaoDaoController:handleGetInfo(msg)
	PinDaoDaoModel.instance:handlePM_PinDaoDaoInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PinDaoDaoInfoRes)
end

function PinDaoDaoController:helpReduce(activityId, targetPlayerId)
	PinDaoDaoAgent.instance:sendPM_PinDaoDaoHelpReduceReq(activityId, targetPlayerId)
end

function PinDaoDaoController:handleHelpReduce(msg)
	PinDaoDaoModel.instance:handlePM_PinDaoDaoHelpReduceRes(msg)

	local Info = GameUtil.pbToTable(msg)

	GlobalDispatcher:dispatch(GlobalNotify.PM_PinDaoDaoHelpReduceRes, Info)
end

function PinDaoDaoController:buyGoods(activityId, goodsId)
	PinDaoDaoAgent.instance:sendPM_PinDaoDaoBuyGoodsReq(activityId, goodsId)
end

function PinDaoDaoController:handleBuyGoods(msg)
	PinDaoDaoModel.instance:handlePM_PinDaoDaoBuyGoodsRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PinDaoDaoBuyGoodsRes)
end

function PinDaoDaoController:viewPlayerGoodsInfo(activityId, targetPlayerId)
	PinDaoDaoAgent.instance:sendPM_PinDaoDaoPlayerInfoReq(activityId, targetPlayerId)
end

function PinDaoDaoController:handleViewPlayerGoodsInfo(msg)
	local Info = GameUtil.pbToTable(msg)

	GlobalDispatcher:dispatch(GlobalNotify.PM_PinDaoDaoPlayerInfoRes, Info)
end

function PinDaoDaoController:notifyReduceInfoChange(msg)
	PinDaoDaoModel.instance:handleNotifyPinDaoDaoReduceInfoChange(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PinDaoDaoReduceInfoChange)
end

function PinDaoDaoController:sendHelpInfo(activityId, friendUserId_i64_Ary, goodsId)
	PinDaoDaoAgent.instance:sendPM_PinDaoDaoChatReq(activityId, friendUserId_i64_Ary, goodsId)
end

function PinDaoDaoController:handlePM_PinDaoDaoChatRes(msg)
	FloatWordMgr.instance:show("已发送邀请，请等待好友帮助砍价")
end

PinDaoDaoController.instance = PinDaoDaoController.New()

return PinDaoDaoController
