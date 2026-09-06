-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalegod/controller/FemaleGodController.lua

module("logic.extensions.femalegod.controller.FemaleGodController", package.seeall)

local FemaleGodController = class("FemaleGodController", BaseController)

function FemaleGodController:sendPM_InflationMoneyGetInfoReq(activityId)
	FemaleGodAgent.instance:sendPM_InflationMoneyGetInfoReq(activityId)
end

function FemaleGodController:handlePM_InflationMoneyGetInfoRes(msg)
	FemaleGodModel.instance:handlePM_InflationMoneyGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_InflationMoneyGetInfoRes)
end

function FemaleGodController:sendPM_InflationMoneyGainOncePrizeReq(activityId)
	FemaleGodAgent.instance:sendPM_InflationMoneyGainOncePrizeReq(activityId)
end

function FemaleGodController:handlePM_InflationMoneyGainOncePrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_InflationMoneyGainOncePrizeRes)
end

function FemaleGodController:sendPM_InflationMoneyGainProgressPrizeReq(activityId, prizeId)
	FemaleGodAgent.instance:sendPM_InflationMoneyGainProgressPrizeReq(activityId, prizeId)
end

function FemaleGodController:handlePM_InflationMoneyGainProgressPrizeRes(msg)
	FemaleGodModel.instance:handlePM_InflationMoneyGainProgressPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_InflationMoneyGainProgressPrizeRes)
end

function FemaleGodController:getNewCanExpendIdx(activityId, curScore, gainedPrizeIds)
	local progressCfg = FemaleGodConfig.instance:getProgressCfg(activityId)

	for prizeId, data in ipairs(progressCfg) do
		local hasGained = table.indexof(gainedPrizeIds, prizeId)
		local canGain = curScore >= data.progress

		if canGain and not hasGained then
			return prizeId
		end
	end
end

function FemaleGodController:_caculateSalePrizeNum(activityId, costMatNum)
	local relateCfg = FemaleGodConfig.instance:findRelatedCfgByRelateActId(activityId)
	local actCfg = FemaleGodConfig.instance:getActivityCfgByRelateActId(activityId)
	local deductMaxCount = relateCfg.deductMaxCount
	local deductWanPercent = relateCfg.deductWanPercent
	local finalSaleNum = 0
	local expendMoneyMatStr = actCfg.inflationMoneyMaterialKey
	local arr = string.split(expendMoneyMatStr, ":")
	local hasExpendMoneyNum = MaterialModel.instance:getMaterialsNumber(arr[1], arr[2])

	if deductMaxCount ~= 0 then
		finalSaleNum = deductMaxCount <= hasExpendMoneyNum and (costMatNum - deductMaxCount >= 0 and costMatNum - deductMaxCount or 0) or costMatNum - hasExpendMoneyNum >= 0 and costMatNum - hasExpendMoneyNum or 0
	else
		local saleScale = (10000 - deductWanPercent) / 10000

		finalSaleNum = costMatNum * saleScale

		if hasExpendMoneyNum < costMatNum - costMatNum * saleScale then
			finalSaleNum = costMatNum - hasExpendMoneyNum
		end
	end

	return math.floor(finalSaleNum)
end

function FemaleGodController:hasEnoughMoney(activityId, curPrize, costStr)
	local relateCfg = FemaleGodConfig.instance:findRelatedCfgByRelateActId(activityId)
	local actCfg = FemaleGodConfig.instance:getActivityCfgByRelateActId(activityId)
	local hasCostNum = MaterialMgr.getMatCount(costStr)

	if actCfg and relateCfg then
		local afterSaleMoney = self:_caculateSalePrizeNum(activityId, curPrize)

		return afterSaleMoney <= hasCostNum
	end
end

function FemaleGodController:isExpendMoneyActivity(activityId)
	return FemaleGodConfig.instance:findRelatedCfgByRelateActId(activityId) ~= nil
end

function FemaleGodController:showCostTipType(activityId, costStr, price, halfAfterDesc, okFunc)
	UIStateManager.instance:push(ViewName.FemaleGodUseTipView, activityId, costStr, price, halfAfterDesc, okFunc)
end

FemaleGodController.instance = FemaleGodController.New()

return FemaleGodController
