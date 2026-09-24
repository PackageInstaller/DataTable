-- chunkname: @modules/logic/versionactivity4_0/concertlimit/model/ActFlipCardInfoMo.lua

module("modules.logic.versionactivity4_0.concertlimit.model.ActFlipCardInfoMo", package.seeall)

local ActFlipCardInfoMo = class("ActFlipCardInfoMo")

function ActFlipCardInfoMo:ctor()
	self.cardId = 0
	self.unlocked = false
	self.openedBlocks = {}
end

function ActFlipCardInfoMo:init(info)
	self.cardId = info.cardId
	self.unlocked = info.unlocked

	self:_buildOpenedBlocks(info.openedBlocks)
end

function ActFlipCardInfoMo:_buildOpenedBlocks(infos)
	self.openedBlocks = {}

	for _, info in ipairs(infos or {}) do
		local blockMo = ActFlipOpenedBlockMo.New()

		blockMo:init(info)

		self.openedBlocks[info.topLeftIndex] = blockMo
	end
end

function ActFlipCardInfoMo:updateBlock(info)
	if not self.openedBlocks[info.rewardId] then
		local blockMo = ActFlipOpenedBlockMo.New()

		blockMo:init(info)

		self.openedBlocks[info.topLeftIndex] = blockMo
	else
		self.openedBlocks[info.topLeftIndex]:update(info)
	end
end

function ActFlipCardInfoMo:getBlockMos()
	return self.openedBlocks
end

function ActFlipCardInfoMo:getBlockMoByIndex(blockIndex)
	for _, blockMo in pairs(self.openedBlocks) do
		if blockMo.topLeftIndex == blockIndex then
			return blockMo
		end
	end
end

return ActFlipCardInfoMo
