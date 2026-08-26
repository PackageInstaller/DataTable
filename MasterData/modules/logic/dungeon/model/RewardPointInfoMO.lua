-- chunkname: @modules/logic/dungeon/model/RewardPointInfoMO.lua

module("modules.logic.dungeon.model.RewardPointInfoMO", package.seeall)

local RewardPointInfoMO = pureTable("RewardPointInfoMO")

function RewardPointInfoMO:init(info)
	self.chapterId = info.chapterId
	self.rewardPoint = info.rewardPoint
	self.hasGetPointRewardIds = info.hasGetPointRewardIds or {}
end

function RewardPointInfoMO:setRewardPoint(value)
	self.rewardPoint = value
end

return RewardPointInfoMO
