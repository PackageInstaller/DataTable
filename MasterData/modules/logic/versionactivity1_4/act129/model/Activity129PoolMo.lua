-- chunkname: @modules/logic/versionactivity1_4/act129/model/Activity129PoolMo.lua

module("modules.logic.versionactivity1_4.act129.model.Activity129PoolMo", package.seeall)

local Activity129PoolMo = class("Activity129PoolMo")

function Activity129PoolMo:ctor(poolCfg)
	self.activityId = poolCfg.activityId
	self.poolId = poolCfg.poolId
	self.poolType = poolCfg.type
	self.count = 0
	self.rewardDict = {}
end

function Activity129PoolMo:init(info)
	self.count = info.count
	self.rewardDict = {}

	for i = 1, #info.rewards do
		local reward = info.rewards[i]
		local item = self:getRewardItem(reward.rare, reward.rewardType, reward.rewardId)

		item.num = item.num + reward.num
	end
end

function Activity129PoolMo:onLotterySuccess(info)
	self.count = self.count + info.num

	for i = 1, #info.rewards do
		local reward = info.rewards[i]
		local item = self:getRewardItem(reward.rare, reward.rewardType, reward.rewardId)

		item.num = item.num + reward.num
	end
end

function Activity129PoolMo:getRewardItem(rare, rewardType, rewardId)
	self.rewardDict[rare] = self.rewardDict[rare] or {}
	self.rewardDict[rare][rewardType] = self.rewardDict[rare][rewardType] or {}
	self.rewardDict[rare][rewardType][rewardId] = self.rewardDict[rare][rewardType][rewardId] or {
		num = 0,
		rare = rare,
		rewardType = rewardType,
		rewardId = rewardId
	}

	return self.rewardDict[rare][rewardType][rewardId]
end

function Activity129PoolMo:getGoodsGetNum(rare, rewardType, rewardId)
	local item = self:getRewardItem(rare, rewardType, rewardId)

	return item.num
end

function Activity129PoolMo:checkPoolIsEmpty()
	local drawCount, maxCount = self:getPoolDrawCount()

	return maxCount ~= 0 and maxCount <= drawCount
end

function Activity129PoolMo:getPoolDrawCount()
	local maxCount = 0
	local drawCount = 0
	local goodsDict = Activity129Config.instance:getGoodsDict(self.poolId)

	for k, goods in pairs(goodsDict) do
		local rewards = GameUtil.splitString2(goods.goodsId, true)

		if rewards then
			for i, reward in ipairs(rewards) do
				if reward[4] > 0 then
					maxCount = maxCount + reward[4]
					drawCount = drawCount + self:getGoodsGetNum(k, reward[1], reward[2])
				end
			end
		end
	end

	return drawCount, maxCount
end

return Activity129PoolMo
