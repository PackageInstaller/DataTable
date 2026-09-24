-- chunkname: @modules/logic/versionactivity4_0/concertlimit/model/ActFlipOpenedBlockMo.lua

module("modules.logic.versionactivity4_0.concertlimit.model.ActFlipOpenedBlockMo", package.seeall)

local ActFlipOpenedBlockMo = class("ActFlipOpenedBlockMo")

function ActFlipOpenedBlockMo:ctor()
	self.rewardId = 0
	self.topLeftIndex = 0
	self.bottomRightIndex = 0
end

function ActFlipOpenedBlockMo:init(info)
	self.rewardId = info.rewardId
	self.topLeftIndex = info.topLeftIndex
	self.bottomRightIndex = info.bottomRightIndex
end

function ActFlipOpenedBlockMo:update(info)
	self.rewardId = info.rewardId
	self.topLeftIndex = info.topLeftIndex
	self.bottomRightIndex = info.bottomRightIndex
end

return ActFlipOpenedBlockMo
