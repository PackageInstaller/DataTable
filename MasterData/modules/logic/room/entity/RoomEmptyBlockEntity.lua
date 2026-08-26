-- chunkname: @modules/logic/room/entity/RoomEmptyBlockEntity.lua

module("modules.logic.room.entity.RoomEmptyBlockEntity", package.seeall)

local RoomEmptyBlockEntity = class("RoomEmptyBlockEntity", RoomBaseBlockEntity)

function RoomEmptyBlockEntity:ctor(entityId)
	RoomEmptyBlockEntity.super.ctor(self, entityId)

	self._nearWaveList = {}
	self._nearRiverList = {}

	for direction = 1, 6 do
		table.insert(self._nearWaveList, false)
		table.insert(self._nearRiverList, false)
	end
end

function RoomEmptyBlockEntity:getTag()
	return SceneTag.RoomEmptyBlock
end

function RoomEmptyBlockEntity:init(go)
	RoomEmptyBlockEntity.super.init(self, go)
end

function RoomEmptyBlockEntity:initComponents()
	RoomEmptyBlockEntity.super.initComponents(self)
end

function RoomEmptyBlockEntity:onStart()
	RoomEmptyBlockEntity.super.onStart(self)
end

function RoomEmptyBlockEntity:refreshLand()
	self:refreshWater()
	self:refreshWaveEffect()
end

function RoomEmptyBlockEntity:refreshWater()
	return
end

function RoomEmptyBlockEntity:refreshBlock()
	RoomEmptyBlockEntity.super.refreshBlock(self)
end

function RoomEmptyBlockEntity:refreshWaveEffect()
	local blockMO = self:getMO()
	local hexPoint = blockMO.hexPoint
	local nearWaveList = self._nearWaveList
	local nearRiverList = self._nearRiverList
	local tRoomMapBlockModel = RoomMapBlockModel.instance

	for direction = 1, 6 do
		local neighbor = HexPoint.directions[direction]
		local nearWave = false
		local nearRiver = false
		local neighborMO = tRoomMapBlockModel:getBlockMO(hexPoint.x + neighbor.x, hexPoint.y + neighbor.y)

		if neighborMO and neighborMO:isInMapBlock() then
			nearWave = true
			nearRiver = neighborMO:hasRiver(true)
		end

		nearWaveList[direction] = nearWave
		nearRiverList[direction] = nearRiver
	end

	local resList, directionList, abPathList = RoomWaveHelper.getWaveList(nearWaveList, nearRiverList)
	local isRefresh = false
	local waveEffectKeys = RoomEnum.EffectKey.BlockWaveEffectKeys

	for i = 1, #resList do
		local res = resList[i]
		local abPath = abPathList[i]
		local direction = directionList[i]

		if not self.effect:isSameResByKey(waveEffectKeys[i], res) then
			self.effect:addParams({
				[waveEffectKeys[i]] = {
					res = res,
					ab = abPath,
					localRotation = Vector3(0, (direction - 1) * 60, 0)
				}
			})

			isRefresh = true
		end
	end

	for i = #resList + 1, 6 do
		if self.effect:getEffectRes(waveEffectKeys[i]) then
			self.effect:removeParams({
				waveEffectKeys[i]
			})

			isRefresh = true
		end
	end

	if isRefresh then
		self.effect:refreshEffect()
	end
end

function RoomEmptyBlockEntity:beforeDestroy()
	RoomEmptyBlockEntity.super.beforeDestroy(self)
end

function RoomEmptyBlockEntity:getMO()
	return RoomMapBlockModel.instance:getEmptyBlockMOById(self.id)
end

return RoomEmptyBlockEntity
