-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/controller/SeasonModeWarOrderController.lua

module("logic.extensions.season.controller.SeasonModeWarOrderController", package.seeall)

local SeasonModeWarOrderController = class("SeasonModeWarOrderController", BaseController)

function SeasonModeWarOrderController:onInit()
	self:onReset()
end

function SeasonModeWarOrderController:onReset()
	return
end

function SeasonModeWarOrderController:sendRequestSeasonInfo()
	SeasonModeWarOrderAgent.instance:sendPM_SMPVEWarOrderInfoReq()
end

function SeasonModeWarOrderController:sendSeasonPassGetReward(isSuper, prizeId)
	SeasonModeWarOrderAgent.instance:sendPM_SMPVEWarOrderGainPrizeReq(isSuper, prizeId)
end

function SeasonModeWarOrderController:sendSeasonPassOneKeyGetReward()
	SeasonModeWarOrderAgent.instance:sendPM_SMPVEWarOrderOneKeyGainPrizeReq()
end

function SeasonModeWarOrderController:sendSeasonPassPortReceiveFinalPrize()
	SeasonModeWarOrderAgent.instance:sendPM_SMPVEWarOrderGainFinalPrizeReq()
end

function SeasonModeWarOrderController:sendSeasonPassPortLuckDraw()
	SeasonModeWarOrderAgent.instance:sendPM_SMPVEWarOrderLotteryReq()
end

function SeasonModeWarOrderController:sendSeasonPassPortBuy(data)
	PayController.instance:pay(data.payGoodsId, data.subGoodsType, data.seasonId)
end

function SeasonModeWarOrderController:sendSeasonFindEnergy(data)
	SeasonModeWarOrderAgent.instance:sendPM_SMPVEWarOrderRecoverReq()
end

function SeasonModeWarOrderController:sendSeasonPassBuyLevel(targetLevel)
	SeasonModeWarOrderAgent.instance:sendPM_SMPVEWarOrderBuyLevelReq(targetLevel)
end

function SeasonModeWarOrderController:sendRequestSeasonTaskInfo()
	SeasonModeWarOrderAgent.instance:sendPM_SMPVEWarOrderTaskInfoReq()
end

function SeasonModeWarOrderController:sendRequestSeasonGetTaskPrize(taskId)
	SeasonModeWarOrderAgent.instance:sendPM_SMPVEWarOrderGainTaskPrizeReq(taskId)
end

function SeasonModeWarOrderController:handleSMPVEWarOrderInfoRes(status, msg)
	if status == 0 then
		SeasonPassPortModel.instance:refreshSeasonPassRewardData(msg)
	end
end

function SeasonModeWarOrderController:handleSMPVEWarOrderBuyLevelRes(status, msg)
	if status == 0 then
		SeasonPassPortModel.instance:refreshSeasonPassBuyLevelData(msg)
	end
end

function SeasonModeWarOrderController:handleSMPVEWarOrderGainPrizeRes(status, msg)
	if status == 0 then
		SeasonPassPortModel.instance:refreshSeasonPassReceiveRewardData(msg, false)
	end
end

function SeasonModeWarOrderController:handleSMPVEWarOrderOneKeyGainPrizeRes(status, msg)
	if status == 0 then
		SeasonPassPortModel.instance:refreshSeasonPassReceiveRewardData(msg, true)
	end
end

function SeasonModeWarOrderController:handleSMPVEWarOrderTaskInfoRes(status, msg)
	if status == 0 then
		SeasonPassPortModel.instance:refreshSeasonPassTaskData(msg)
	end
end

function SeasonModeWarOrderController:handleSMPVEWarOrderGainTaskPrizeRes(status, msg)
	if status == 0 then
		SeasonPassPortModel.instance:refreshSeasonPassReceiveTaskData(msg)
	end
end

function SeasonModeWarOrderController:handleSMPVEWarOrderLotteryRes(status, msg)
	if status == 0 then
		SeasonPassPortModel.instance:refreshSeasonPassLuckDrawData(msg)
	end
end

function SeasonModeWarOrderController:handleSMPVENotifyBuyWarOrderRes(status, msg)
	if status == 0 then
		SeasonPassPortModel.instance:refreshSeasonPassBuySuccess()
	end
end

function SeasonModeWarOrderController:handleSMPVEWarOrderGainFinalPrizeRes(status, msg)
	if status == 0 then
		SeasonPassPortModel.instance:refreshSeasonPassGetFinalReward()
	end
end

function SeasonModeWarOrderController:handleSMPVEWarOrderRecoverRes(status, msg)
	if status == 0 then
		SeasonPassPortModel.instance:refreshSeasonPassGetFindEnergy(msg)
	end
end

SeasonModeWarOrderController.instance = SeasonModeWarOrderController.New()

return SeasonModeWarOrderController
