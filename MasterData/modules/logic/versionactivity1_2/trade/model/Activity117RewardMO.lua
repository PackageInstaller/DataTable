-- chunkname: @modules/logic/versionactivity1_2/trade/model/Activity117RewardMO.lua

module("modules.logic.versionactivity1_2.trade.model.Activity117RewardMO", package.seeall)

local Activity117RewardMO = pureTable("Activity117RewardMO")

function Activity117RewardMO:init(co)
	self.actId = co.activityId
	self.id = co.id
	self.needScore = co.needScore
	self.co = co
	self.rewardItems = self:getRewardItems()

	self:resetData()
end

function Activity117RewardMO:resetData()
	self.alreadyGot = false
end

function Activity117RewardMO:updateServerData(alreadyGot)
	self.alreadyGot = alreadyGot
end

function Activity117RewardMO:getRewardItems()
	local list = {}
	local rewards = string.split(self.co.bonus, "|")

	for i, v in ipairs(rewards) do
		list[i] = string.splitToNumber(v, "#")
	end

	return list
end

function Activity117RewardMO:getStatus()
	if self.alreadyGot then
		return Activity117Enum.Status.AlreadyGot
	end

	local score = Activity117Model.instance:getCurrentScore(self.actId)

	if score >= self.needScore then
		return Activity117Enum.Status.CanGet
	end

	return Activity117Enum.Status.NotEnough
end

function Activity117RewardMO.sortFunc(a, b)
	local astatus = a:getStatus()
	local bstatus = b:getStatus()

	if astatus ~= bstatus then
		return astatus < bstatus
	end

	return a.id < b.id
end

return Activity117RewardMO
