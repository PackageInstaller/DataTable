-- chunkname: @modules/logic/scene/room/comp/entitymgr/RoomSceneMapEntityMgr.lua

module("modules.logic.scene.room.comp.entitymgr.RoomSceneMapEntityMgr", package.seeall)

local RoomSceneMapEntityMgr = class("RoomSceneMapEntityMgr", BaseSceneUnitMgr)

function RoomSceneMapEntityMgr:onInit()
	return
end

function RoomSceneMapEntityMgr:init(sceneId, levelId)
	self._scene = self:getCurScene()

	local mapBlockMOList = RoomMapBlockModel.instance:getBlockMOList()

	for _, mo in ipairs(mapBlockMOList) do
		local blockEntity = mo.blockState == RoomBlockEnum.BlockState.Water and self:getUnit(SceneTag.RoomEmptyBlock, mo.id) or self:getUnit(SceneTag.RoomMapBlock, mo.id)

		if not blockEntity then
			self:spawnMapBlock(mo)
		else
			self:_refreshBlockEntiy(blockEntity, mo)
		end
	end

	if not self:getUnit(SceneTag.Untagged, 1) then
		self:_spawnBlockEffect(RoomEnum.EffectKey.BlockCanPlaceKey, RoomBlockCanPlaceEntity, 1)
	end
end

function RoomSceneMapEntityMgr:onSwitchMode()
	local tRoomMapBlockModel = RoomMapBlockModel.instance
	local tempTags = {
		SceneTag.RoomEmptyBlock,
		SceneTag.RoomMapBlock
	}

	for _, tempSceneTag in ipairs(tempTags) do
		local entityDic = self:getTagUnitDict(tempSceneTag)

		if entityDic then
			local removeIds = {}

			for unitId, entity in pairs(entityDic) do
				local mo

				if not (tempSceneTag == SceneTag.RoomEmptyBlock and tRoomMapBlockModel:getEmptyBlockMOById(unitId) or tRoomMapBlockModel:getFullBlockMOById(unitId)) then
					table.insert(removeIds, unitId)
				end
			end

			for i = 1, #removeIds do
				self:removeUnit(tempSceneTag, removeIds[i])
			end
		end
	end
end

function RoomSceneMapEntityMgr:_spawnBlockEffect(name, clsDefine, id)
	local blockRoot = self._scene.go.blockRoot
	local blockGO = gohelper.create3d(blockRoot, name)
	local blockEffEntity = MonoHelper.addNoUpdateLuaComOnceToGo(blockGO, clsDefine, id)

	gohelper.addChild(blockRoot, blockGO)
	self:addUnit(blockEffEntity)

	return blockEffEntity
end

function RoomSceneMapEntityMgr:spawnMapBlock(mapBlockMO)
	local blockRoot = self._scene.go.blockRoot
	local hexPoint = mapBlockMO.hexPoint

	if not hexPoint then
		logError("RoomSceneMapEntityMgr: 没有位置信息")

		return
	end

	local blockGO = gohelper.create3d(blockRoot, RoomResHelper.getBlockName(hexPoint))
	local blockEntity = mapBlockMO.blockState == RoomBlockEnum.BlockState.Water and MonoHelper.addNoUpdateLuaComOnceToGo(blockGO, RoomEmptyBlockEntity, mapBlockMO.id) or MonoHelper.addNoUpdateLuaComOnceToGo(blockGO, RoomMapBlockEntity, mapBlockMO.id)

	self:addUnit(blockEntity)
	gohelper.addChild(blockRoot, blockGO)
	self:_refreshBlockEntiy(blockEntity, mapBlockMO)

	return blockEntity
end

function RoomSceneMapEntityMgr:_refreshBlockEntiy(blockEntity, mapBlockMO)
	local position = HexMath.hexToPosition(mapBlockMO.hexPoint, RoomBlockEnum.BlockSize)

	blockEntity:setLocalPos(position.x, 0, position.y)
	blockEntity:refreshBlock()
	blockEntity:refreshRotation()
end

function RoomSceneMapEntityMgr:moveTo(entity, hexPoint)
	local position = HexMath.hexToPosition(hexPoint, RoomBlockEnum.BlockSize)

	entity:setLocalPos(position.x, 0, position.y)
end

function RoomSceneMapEntityMgr:destroyBlock(entity)
	self:removeUnit(entity:getTag(), entity.id)
end

function RoomSceneMapEntityMgr:getBlockEntity(id, sceneTag)
	local tagEntitys = (not sceneTag or sceneTag == SceneTag.RoomMapBlock) and self:getTagUnitDict(SceneTag.RoomMapBlock)
	local entity = tagEntitys and tagEntitys[id]

	if entity then
		return entity
	end

	tagEntitys = (not sceneTag or sceneTag == SceneTag.RoomEmptyBlock) and self:getTagUnitDict(SceneTag.RoomEmptyBlock)

	return tagEntitys and tagEntitys[id]
end

function RoomSceneMapEntityMgr:getMapBlockEntityDict()
	return self._tagUnitDict[SceneTag.RoomMapBlock]
end

function RoomSceneMapEntityMgr:refreshAllBlockEntity(sceneTag)
	local entityDict = self:getTagUnitDict(sceneTag)

	if entityDict then
		for _, blockEntity in pairs(entityDict) do
			local blockMO = blockEntity:getMO()

			self:_refreshBlockEntiy(blockEntity, blockMO)
		end
	end
end

function RoomSceneMapEntityMgr:getPropertyBlock()
	self._propertyBlock = self._propertyBlock or UnityEngine.MaterialPropertyBlock.New()

	return self._propertyBlock
end

function RoomSceneMapEntityMgr:onSceneClose()
	RoomSceneMapEntityMgr.super.onSceneClose(self)

	if self._propertyBlock then
		self._propertyBlock:Clear()

		self._propertyBlock = nil
	end
end

return RoomSceneMapEntityMgr
