-- chunkname: @modules/logic/rouge/model/RougeActivityMileStoneListModel.lua

module("modules.logic.rouge.model.RougeActivityMileStoneListModel", package.seeall)

local RougeActivityMileStoneListModel = class("RougeActivityMileStoneListModel", MixScrollModel)

function RougeActivityMileStoneListModel:init(actMo)
	self.actMo = actMo
end

function RougeActivityMileStoneListModel:refresh()
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

function RougeActivityMileStoneListModel:caleProgressIndex()
	local list = Activity186Config.instance:getMileStoneList(self.actMo.id)
	local index = 0
	local currencyId = Activity186Config.instance:getConstNum(self.actMo.id, Activity186Enum.ConstId.CurrencyId)
	local hasCurrencyNum = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, currencyId)
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

function RougeActivityMileStoneListModel:getMaxMileStoneValue()
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

RougeActivityMileStoneListModel.instance = RougeActivityMileStoneListModel.New()

return RougeActivityMileStoneListModel
