-- chunkname: @modules/logic/chessgame/model/ChessGameNodeMo.lua

module("modules.logic.chessgame.model.ChessGameNodeMo", package.seeall)

local ChessGameNodeMo = pureTable("ChessGameNodeMo")

function ChessGameNodeMo:setNode(node)
	self.x = node.x
	self.y = node.y
	self.noWalkCount = 0
	self.noWalkCanDestoryCount = 0
end

function ChessGameNodeMo:addNoWalkCount(count, isCanDestory)
	if isCanDestory then
		self.noWalkCanDestoryCount = self.noWalkCanDestoryCount + count
	else
		self.noWalkCount = self.noWalkCount + count
	end
end

function ChessGameNodeMo:isCanWalk(isCanDestory)
	if self.noWalkCount > 0 then
		return false
	end

	if isCanDestory then
		return true
	else
		return self.noWalkCanDestoryCount > 0
	end
end

return ChessGameNodeMo
