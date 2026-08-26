-- chunkname: @modules/logic/chessgame/model/ChessGameInteractModel.lua

module("modules.logic.chessgame.model.ChessGameInteractModel", package.seeall)

local ChessGameInteractModel = class("ChessGameInteractModel", BaseModel)

function ChessGameInteractModel:onInit()
	self._interacts = {}
	self._finishInteractMap = {}
	self._interactsByMapIndex = {}
	self._showEffect = {}
end

function ChessGameInteractModel:reInit()
	self:clear()
end

function ChessGameInteractModel:setInteractDatas(interactMoList, mapIndex)
	self._interacts = {}
	self._interactsByMapIndex = {}
	self._finishInteractMap = {}

	for _, mo in ipairs(interactMoList) do
		local interactMo = ChessGameInteractMo.New()
		local id = mo.id

		if not mo.mapGroupId then
			local mapGroupId = ChessGameConfig.instance:getCurrentMapGroupId()
			local co = ChessGameConfig.instance:getInteractCoById(mapGroupId, id)

			mo.mapIndex = mapIndex

			interactMo:init(co, mo)

			self._interacts[co.id] = interactMo
			self._interactsByMapIndex[mapIndex] = self._interactsByMapIndex[mapIndex] or {}
			self._interactsByMapIndex[mapIndex][co.id] = interactMo
		end
	end

	self:setInteractFinishMap()
end

function ChessGameInteractModel:addInteractMo(co, serverData)
	local interactMo = ChessGameInteractMo.New()

	interactMo:init(co, serverData)

	self._interacts[co.id] = interactMo

	return interactMo
end

function ChessGameInteractModel:getInteractById(interactId)
	return self._interacts[interactId]
end

function ChessGameInteractModel:deleteInteractById(interactId)
	self._interacts[interactId] = nil

	local mapIndex = ChessGameModel.instance.nowMapIndex

	self._interactsByMapIndex[mapIndex][interactId] = nil
end

function ChessGameInteractModel:getAllInteracts()
	return self._interacts
end

function ChessGameInteractModel:getInteractsByMapIndex(mapIndex)
	mapIndex = mapIndex or ChessGameModel.instance.nowMapIndex

	return self._interactsByMapIndex[mapIndex] or {}
end

function ChessGameInteractModel:getInteractByPos(x, y, mapIndex)
	local list = {}

	mapIndex = mapIndex or ChessGameModel.instance.nowMapIndex

	if not self._interactsByMapIndex[mapIndex] then
		return
	end

	for _, mo in pairs(self._interactsByMapIndex[mapIndex]) do
		local posX, psoY = mo:getXY()

		if posX == x and psoY == y then
			table.insert(list, mo)
		end
	end

	return list
end

function ChessGameInteractModel:setInteractFinishMap()
	for id, mo in pairs(self._interacts) do
		if mo:CheckInteractFinish() then
			self._finishInteractMap[id] = true
		end
	end
end

function ChessGameInteractModel:checkInteractFinish(id)
	return self._finishInteractMap[id]
end

function ChessGameInteractModel:setShowEffect(interactid)
	self._showEffect[interactid] = true
end

function ChessGameInteractModel:setHideEffect(interactid)
	self._showEffect[interactid] = false
end

function ChessGameInteractModel:getShowEffects()
	return self._showEffect
end

function ChessGameInteractModel:clear()
	self._interacts = {}
	self._interactsByMapIndex = {}
	self._finishInteractMap = {}
	self._showEffect = {}
end

ChessGameInteractModel.instance = ChessGameInteractModel.New()

return ChessGameInteractModel
