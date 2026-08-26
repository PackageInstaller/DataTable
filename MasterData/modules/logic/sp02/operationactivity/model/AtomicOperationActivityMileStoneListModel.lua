-- chunkname: @modules/logic/sp02/operationactivity/model/AtomicOperationActivityMileStoneListModel.lua

module("modules.logic.sp02.operationactivity.model.AtomicOperationActivityMileStoneListModel", package.seeall)

local AtomicOperationActivityMileStoneListModel = class("AtomicOperationActivityMileStoneListModel", MixScrollModel)

function AtomicOperationActivityMileStoneListModel:init(actMo)
	self.actMo = actMo
end

function AtomicOperationActivityMileStoneListModel:refresh()
	local list = Activity186Config.instance:getMileStoneList(self.actMo.id)
	local dataList = {}

	for i, v in ipairs(list) do
		local mo = {}

		mo.id = v.rewardId
		mo.rewardId = v.rewardId
		mo.activityId = v.activityId
		mo.isLoopBonus = v.isLoopBonus
		mo.bonus = v.bonus
		mo.isSpBonus = v.isSpBonus

		table.insert(dataList, mo)
	end

	self:setList(dataList)
end

function AtomicOperationActivityMileStoneListModel:caleProgressIndex()
	local list = Activity186Config.instance:getMileStoneList(self.actMo.id)
	local index = 0
	local currencyParam = AtomicOperationActivityConfig.instance:getConstStr(AtomicOperationActivityEnum.ConstId.CurrencyId)
	local currencyData = string.splitToNumber(currencyParam, "#")
	local currencyMo = CurrencyModel.instance:getCurrency(currencyData[2])

	if currencyMo then
		if not currencyMo.quantity then
			local hasCurrencyNum = 0
			local lastCoinNum = 0

			for i, v in ipairs(list) do
				local coinNum = v.coinNum

				if hasCurrencyNum < coinNum then
					index = i + (hasCurrencyNum - lastCoinNum) / (coinNum - lastCoinNum) - 1

					return i + (hasCurrencyNum - lastCoinNum) / (coinNum - lastCoinNum) - 1
				end

				lastCoinNum = coinNum
			end

			local listLen = #list

			lastCoinNum = list[listLen - 1] and list[listLen - 1].coinNum or 0

			local loopConfig = list[listLen]
			local progress = self.actMo.getMilestoneProgress

			if not loopConfig.loopBonusIntervalNum then
				local loopNum = 1
				local coinNum = loopConfig.coinNum

				if progress < coinNum then
					index = listLen
				else
					local canGetTimesValue = (hasCurrencyNum - coinNum) / loopNum
					local canGetTimes = math.floor(canGetTimesValue)
					local getTimes = math.floor((progress - coinNum) / loopNum)

					index = getTimes < canGetTimes and listLen or listLen - 1 + canGetTimesValue - canGetTimes
				end

				return index
			end
		end
	end
end

function AtomicOperationActivityMileStoneListModel:getMaxMileStoneValue()
	local count = self:getCount()

	for i = count, 1, -1 do
		local mo = self:getByIndex(i)
		local actMo = Activity186Model.instance:getById(mo.activityId)

		if actMo and not mo.isLoopBonus then
			return actMo:getMilestoneValue(mo.rewardId)
		end
	end

	return 0
end

AtomicOperationActivityMileStoneListModel.instance = AtomicOperationActivityMileStoneListModel.New()

return AtomicOperationActivityMileStoneListModel
