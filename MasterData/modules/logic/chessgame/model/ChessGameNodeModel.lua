-- chunkname: @modules/logic/chessgame/model/ChessGameNodeModel.lua

module("modules.logic.chessgame.model.ChessGameNodeModel", package.seeall)

local ChessGameNodeModel = class("ChessGameNodeModel", BaseModel)

function ChessGameNodeModel:onInit()
	self._nodes = {}
end

function ChessGameNodeModel:reInit()
	self:clear()
end

function ChessGameNodeModel:setNodeDatas(nodes)
	self._nodes = {}

	for _, node in pairs(nodes) do
		local nodeMo = ChessGameNodeMo.New()

		nodeMo:setNode(node)

		self._nodes[node.x] = self._nodes[node.x] or {}
		self._nodes[node.x][node.y] = nodeMo
	end
end

function ChessGameNodeModel:getNode(x, y)
	if not self._nodes[x] then
		return
	end

	return self._nodes[x][y]
end

function ChessGameNodeModel:getAllNodes()
	return self._nodes
end

function ChessGameNodeModel:clear()
	self._nodes = {}
end

ChessGameNodeModel.instance = ChessGameNodeModel.New()

return ChessGameNodeModel
