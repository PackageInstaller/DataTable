-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/strength/controller/SupplymergeController.lua

module("logic.extensions.strength.controller.SupplymergeController", package.seeall)

local SupplymergeController = class("SupplymergeController", BaseController)

function SupplymergeController:ctor()
	return
end

function SupplymergeController:onInit()
	self:onReset()
end

function SupplymergeController:onReset()
	return
end

function SupplymergeController:sendBasicBenefitsGetInfoReq()
	BasicBenefitsAgent.instance:sendPM_BasicBenefitsGetInfoReq()
end

function SupplymergeController:handleBasicBenefitsGetInfoRes(msg)
	SupplymergeModel.instance:onBasicBenefitsGetInfoRes(msg)
	self:updateAllPrizeRed()
	GlobalDispatcher:dispatch(GlobalNotify.BasicBenefitsGetInfoRes)
end

function SupplymergeController:isStrengthPrize()
	return SupplymergeModel.instance:isStrengthPrize()
end

function SupplymergeController:sendasicBenefitsGainStrengthPrizeReq()
	BasicBenefitsAgent.instance:sendPM_BasicBenefitsGainStrengthPrizeReq()
end

function SupplymergeController:sendQuickEatReq()
	self:sendBasicBenefitsGainPrizeReq()
end

function SupplymergeController:handleBasicBenefitsGainStrengthPrizeRes(msg)
	SupplymergeModel.instance:onBasicBenefitsGainStrengthPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.BasicBenefitsGainStrengthPrizeRes)
end

function SupplymergeController:sendBasicBenefitsGainPrizeReq()
	BasicBenefitsAgent.instance:sendPM_BasicBenefitsGainPrizeReq()
end

function SupplymergeController:handleBasicBenefitsGainPrizeResult(status, msg)
	if status ~= 0 then
		return
	end

	self:handleBasicBenefitsGainPrizeRes(msg)
end

function SupplymergeController:handleBasicBenefitsGainPrizeRes(msg)
	self:sendBasicBenefitsGetInfoReq()
end

function SupplymergeController:sendBasicBenefitsCompensateReq(index)
	self._prizeIndex = index

	BasicBenefitsAgent.instance:sendPM_BasicBenefitsCompensateReq(index)
end

function SupplymergeController:handleBasicBenefitsCompensateRes(msg)
	SupplymergeModel.instance:onBasicBenefitsGainPrizeRes({
		self._prizeIndex
	})
	GlobalDispatcher:dispatch(GlobalNotify.BasicBenefitsCompensateRes, self._prizeIndex)
end

function SupplymergeController:updateAllPrizeRed()
	local dataList = SupplyConfig.instance:getBaseGiftList()

	for _, data in ipairs(dataList) do
		if SupplymergeModel.instance:getCellState(data.index) then
			RedPointController.instance:saveUserDayRedPoint(data.prizeRedId)
		end
	end
end

function SupplymergeController:isCanGetPrize(index)
	return self:getTimeState(index) == 1
end

function SupplymergeController:getTimeState(index)
	local data = SupplyConfig.instance:getBaseGiftData(index)
	local state = GameUtil.getTimePeriodType(data.startTime, data.endTime, true)

	if state == GameUtil.beforeTimePeriod then
		return 0
	elseif state == GameUtil.inTimePeriod and not SupplymergeModel.instance:getCellState(index) then
		return 1
	elseif state == GameUtil.afterTimePeriod and not SupplymergeModel.instance:getCellState(index) then
		return 2
	end
end

SupplymergeController.instance = SupplymergeController.New()

return SupplymergeController
