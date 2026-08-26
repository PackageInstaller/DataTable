-- chunkname: @modules/logic/versionactivity1_2/trade/model/Activity117OrderMO.lua

module("modules.logic.versionactivity1_2.trade.model.Activity117OrderMO", package.seeall)

local Activity117OrderMO = pureTable("Activity117OrderMO")

function Activity117OrderMO:init(actId, id)
	self.activityId = actId

	local co = Activity117Config.instance:getOrderConfig(actId, id)

	self:resetCo(co)
	self:resetData()
end

function Activity117OrderMO:resetCo(co)
	self.co = co
	self.id = co.id
	self.order = co.order
	self.minScore = co.minDealScore
	self.maxScore = co.maxDealScore
	self.maxAcceptScore = co.maxAcceptScore
	self.maxProgress = co.maxProgress
	self.desc = co.name or ""
	self.jumpId = co.jumpId
end

function Activity117OrderMO:resetData()
	self.hasGetBonus = false
	self.userDealScores = {}
	self.progress = 0
end

function Activity117OrderMO:updateServerData(serverData)
	self.hasGetBonus = serverData.hasGetBonus
	self.userDealScores = serverData.userDealScores
	self.progress = serverData.progress

	self:updateStatus()
end

function Activity117OrderMO:getLastRound()
	return self.userDealScores[#self.userDealScores]
end

function Activity117OrderMO.sortOrderFunc(a, b)
	if a.hasGetBonus and b.hasGetBonus then
		return a.order < b.order
	end

	if not a.hasGetBonus and not b.hasGetBonus then
		if a:isProgressEnough() and not b:isProgressEnough() then
			return true
		end

		if not a:isProgressEnough() and b:isProgressEnough() then
			return false
		end

		return a.order < b.order
	end

	return not a.hasGetBonus
end

function Activity117OrderMO:getDesc()
	return self.desc
end

function Activity117OrderMO:isProgressEnough()
	return self.progress >= self.maxProgress
end

function Activity117OrderMO:updateStatus()
	if self.hasGetBonus then
		self.status = Activity117Enum.Status.AlreadyGot

		return
	end

	if self:isProgressEnough() then
		self.status = Activity117Enum.Status.CanGet

		return
	end

	self.status = Activity117Enum.Status.NotEnough
end

function Activity117OrderMO:getStatus()
	return self.status
end

function Activity117OrderMO:checkPrice(price)
	local x = self.minScore
	local y = self.maxAcceptScore

	if y < price then
		return Activity117Enum.PriceType.Bad
	end

	local per = (y - x) / 3

	if price <= x + per then
		return Activity117Enum.PriceType.Best
	end

	if price <= x + 2 * per then
		return Activity117Enum.PriceType.Better
	end

	return Activity117Enum.PriceType.Common
end

function Activity117OrderMO:getMinPrice()
	for i = #self.userDealScores, 1, -1 do
		if self:checkPrice(self.userDealScores[i]) ~= Activity117Enum.PriceType.Bad then
			return self.userDealScores[i]
		end
	end

	return self.minScore
end

return Activity117OrderMO
