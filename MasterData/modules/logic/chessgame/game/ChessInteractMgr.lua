-- chunkname: @modules/logic/chessgame/game/ChessInteractMgr.lua

module("modules.logic.chessgame.game.ChessInteractMgr", package.seeall)

local ChessInteractMgr = class("ChessInteractMgr")

function ChessInteractMgr:ctor()
	self._list = {}
	self._dict = {}
	self._showList = {}
end

function ChessInteractMgr:add(interactObj)
	local id = interactObj.id

	self:remove(id)

	self._dict[id] = interactObj

	table.insert(self._list, interactObj)

	if interactObj:isShow() and interactObj:checkHaveAvatarPath() then
		table.insert(self._showList, interactObj)
	end
end

function ChessInteractMgr:remove(id)
	local interactObj = self._dict[id]

	if interactObj then
		self._dict[id] = nil

		for index, obj in ipairs(self._list) do
			if obj == interactObj then
				table.remove(self._list, index)
				table.remove(self._showList, index)
				obj:dispose()

				return true
			end
		end
	end

	return false
end

function ChessInteractMgr:getList()
	return self._list
end

function ChessInteractMgr:get(id)
	if self._dict then
		return self._dict[id]
	end

	return nil
end

function ChessInteractMgr:hideCompById(id)
	if self._dict and self._dict[id] then
		self._dict[id]:hideSelf()
	end
end

function ChessInteractMgr:getMainPlayer()
	local assistPlayer

	for _, obj in ipairs(self._list) do
		if obj.objType == ChessGameEnum.InteractType.Role then
			return obj
		end
	end

	return assistPlayer
end

function ChessInteractMgr:removeAll()
	for _, obj in ipairs(self._list) do
		obj:dispose()
	end

	self._list = {}
	self._dict = {}
	self._showList = {}
end

function ChessInteractMgr:checkCompleletedLoaded(id)
	self._checkDict = self._checkDict or {}

	table.insert(self._checkDict, id)

	if #self._checkDict == #self._showList then
		self:_onAllInteractLoadCompleleted()
	end
end

function ChessInteractMgr:_onAllInteractLoadCompleleted()
	self._checkDict = nil

	local player = self:getMainPlayer()

	if player then
		player:getHandler():calCanWalkArea()
	end
end

function ChessInteractMgr:dispose()
	if self._list then
		for _, obj in ipairs(self._list) do
			obj:dispose()
		end

		self._list = nil
		self._dict = nil
	end
end

return ChessInteractMgr
