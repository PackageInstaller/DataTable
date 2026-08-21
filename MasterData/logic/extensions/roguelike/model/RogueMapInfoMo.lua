-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/model/RogueMapInfoMo.lua

module("logic.extensions.roguelike.model.RogueMapInfoMo", package.seeall)

local M = class("RogueMapInfoMo")

function M:ctor(mapId)
	self._roomMos = {}

	local mapCo = RoguelikeConfig.instance:getMapById(mapId)

	self:initByCo(mapCo)
end

function M:initByCo(mapCo)
	local eventIndex = mapCo.eventIndex
	local fightIndex = mapCo.fightIndex
	local propIndex = mapCo.propIndex
	local betGameIndex = mapCo.betGameIndex
	local shopIndex = mapCo.shopIndex

	self:addRoomMo(eventIndex)
	self:addRoomMo(fightIndex)
	self:addRoomMo(propIndex)
	self:addRoomMo(betGameIndex)
	self:addRoomMo(shopIndex)
end

function M:addRoomMo(indexs)
	for i = 1, #indexs, 2 do
		local index = indexs[i]
		local roomId = indexs[i + 1]
		local roomMo = RogueRoomMo.New(roomId)

		self._roomMos[index] = roomMo
	end
end

function M:getRoomType(index)
	return self._roomMos[index] and self._roomMos[index]:getRoomType() or 0
end

function M:getRoomState(index)
	return self._roomMos[index] and self._roomMos[index]:getRoomState() or 0
end

function M:setRoomState(index, state)
	if self._roomMos[index] then
		self._roomMos[index]:setRoomState(state)
	end
end

function M:getRoomIcon(index)
	if self._roomMos[index] then
		return self._roomMos[index]:getRoomIcon()
	end
end

function M:getRoomMo(index)
	return self._roomMos[index]
end

return M
