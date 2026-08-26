-- chunkname: @modules/logic/scene/room/comp/entitymgr/RoomSceneInventoryEntitySelectMgr.lua

module("modules.logic.scene.room.comp.entitymgr.RoomSceneInventoryEntitySelectMgr", package.seeall)

local RoomSceneInventoryEntitySelectMgr = class("RoomSceneInventoryEntitySelectMgr", BaseSceneUnitMgr)

function RoomSceneInventoryEntitySelectMgr:onInit()
	return
end

function RoomSceneInventoryEntitySelectMgr:init(sceneId, levelId)
	self._scene = self:getCurScene()
	self._inventoryRootGO = self._scene.go.inventoryRootGO
	self._inventoryBlockIdList = {}
	self._entityPosInfoList = {}
	self._locationParamDic = {}

	for i = 1, 24 do
		table.insert(self._entityPosInfoList, {
			blockId = 0,
			remove = false,
			index = i
		})
	end

	self:refreshInventoryBlock()
end

function RoomSceneInventoryEntitySelectMgr:refreshInventoryBlock()
	if not RoomController.instance:isEditMode() then
		return
	end

	if self:_isHasEntity() then
		self._scene.camera:refreshOrthCamera()
	end
end

function RoomSceneInventoryEntitySelectMgr:_isHasEntity()
	if self._entityPosInfoList then
		for i, posInfo in ipairs(self._entityPosInfoList) do
			if posInfo.blockId ~= 0 then
				return true
			end
		end
	end

	return false
end

function RoomSceneInventoryEntitySelectMgr:addBlockEntity(blockId, isWaterReform)
	if blockId then
		local blockEntity = self:_getOrcreateUnit(blockId, isWaterReform)

		self:_setTransform(blockEntity, self:_findIndexById(blockId))
		self:refreshInventoryBlock()
	end
end

function RoomSceneInventoryEntitySelectMgr:removeBlockEntity(blockId)
	if blockId then
		self:_deleteById(blockId)
		self:refreshInventoryBlock()
	end
end

function RoomSceneInventoryEntitySelectMgr:removeAllBlockEntity()
	local tagEntityDict = self:getTagUnitDict(SceneTag.RoomInventoryBlock)

	for blockId, _ in pairs(tagEntityDict) do
		self:_removeIndexById(blockId)
	end

	if not self._isHasDelayCheckRetainTask then
		self._isHasDelayCheckRetainTask = true

		TaskDispatcher.runDelay(self._onDelayCheckRetain, self, 0.01)
	end

	self:refreshInventoryBlock()
end

function RoomSceneInventoryEntitySelectMgr:getIndexById(blockId)
	for i, posInfo in ipairs(self._entityPosInfoList) do
		if posInfo.blockId == blockId then
			return posInfo.index
		end
	end
end

function RoomSceneInventoryEntitySelectMgr:_removeIndexById(blockId)
	for i, posInfo in ipairs(self._entityPosInfoList) do
		if posInfo.blockId == blockId then
			posInfo.blockId = 0

			return posInfo.index
		end
	end
end

function RoomSceneInventoryEntitySelectMgr:_findIndexById(blockId)
	local index = self:getIndexById(blockId)

	if index then
		return index
	end

	for i, posInfo in ipairs(self._entityPosInfoList) do
		if posInfo.blockId == 0 then
			posInfo.blockId = blockId

			return posInfo.index
		end
	end
end

function RoomSceneInventoryEntitySelectMgr:_getOrcreateUnit(blockId, isWaterReform)
	local blockEntity = self:getUnit(SceneTag.RoomInventoryBlock, blockId)

	if not blockEntity then
		local blockGO = gohelper.create3d(self._inventoryRootGO, string.format("block_%d", blockId))

		blockEntity = MonoHelper.addNoUpdateLuaComOnceToGo(blockGO, RoomInventoryBlockEntity, {
			entityId = blockId,
			isWaterReform = isWaterReform
		})
		blockEntity.retainCount = 1

		self:addUnit(blockEntity)
		table.insert(self._inventoryBlockIdList, blockId)
		gohelper.addChild(self._inventoryRootGO, blockGO)
	else
		blockEntity.retainCount = blockEntity.retainCount + 1
	end

	self:refreshInventoryBlock()

	return blockEntity
end

function RoomSceneInventoryEntitySelectMgr:_deleteById(blockId)
	local blockEntity = self:getUnit(SceneTag.RoomInventoryBlock, blockId)

	if blockEntity then
		blockEntity.retainCount = blockEntity.retainCount - 1

		if blockEntity.retainCount < 1 then
			blockEntity.retainCount = 0

			self:_removeIndexById(blockId)
		end
	else
		self:_removeIndexById(blockId)
	end

	if not self._isHasDelayCheckRetainTask then
		self._isHasDelayCheckRetainTask = true

		TaskDispatcher.runDelay(self._onDelayCheckRetain, self, 0.01)
	end

	self:refreshInventoryBlock()
end

function RoomSceneInventoryEntitySelectMgr:_onDelayCheckRetain()
	self._isHasDelayCheckRetainTask = false

	local blockIdList = self._inventoryBlockIdList

	for i = #blockIdList, 1, -1 do
		local blockId = blockIdList[i]

		if not self:getIndexById(blockId) then
			table.remove(blockIdList, i)
			self:removeUnit(SceneTag.RoomInventoryBlock, blockId)
		end
	end

	self:refreshInventoryBlock()
end

function RoomSceneInventoryEntitySelectMgr:_setTransform(blockEntity, index)
	local tGoTrs = blockEntity.goTrs
	local param = self:_getLocationParam(index)

	transformhelper.setLocalScale(tGoTrs, param.scale, param.scale, param.scale)
	transformhelper.setLocalRotation(tGoTrs, param.rotationX, param.rotationY, param.rotationZ)
	blockEntity:setLocalPos(param.positionX, param.positionY, param.positionZ)
	blockEntity:refreshBlock()
	blockEntity:refreshRotation()
	self:refreshInventoryBlock()
end

function RoomSceneInventoryEntitySelectMgr:moveForward()
	self:refreshInventoryBlock()
end

function RoomSceneInventoryEntitySelectMgr:playForwardAnim(callback, callbackObj)
	self:_removeAnim()

	if callback then
		self._forwardAnimCallback = callback
		self._forwardAnimCallbackObj = callbackObj
		self._isDelayForwardAminRun = true

		TaskDispatcher.runDelay(self._delayForwardAnimCallback, self, 0.11)
	end

	self:refreshInventoryBlock()
end

function RoomSceneInventoryEntitySelectMgr:_removeAnim()
	self._forwardAnimCallback = nil
	self._forwardAnimCallbackObj = nil

	if self._isDelayForwardAminRun then
		self._isDelayForwardAminRun = false

		TaskDispatcher.cancelTask(self._delayForwardAnimCallback, self)
	end
end

function RoomSceneInventoryEntitySelectMgr:_delayForwardAnimCallback()
	self._isDelayForwardAminRun = false

	if self._forwardAnimCallback then
		if self._forwardAnimCallbackObj then
			self._forwardAnimCallback(self._forwardAnimCallbackObj)
		else
			self._forwardAnimCallback()
		end
	end

	self:refreshInventoryBlock()
end

function RoomSceneInventoryEntitySelectMgr:_getLocationParam(index)
	local posParam = self._locationParamDic[index]

	if not posParam then
		posParam = {}
		self._locationParamDic[index] = posParam

		local tIndex = index - 1
		local dx = 1
		local dz = 1.3125
		local idxX = math.floor(tIndex % 6)
		local idxZ = math.floor(tIndex / 6)

		posParam.positionX = -2.51 + idxX * dx
		posParam.positionY = 0.15
		posParam.positionZ = -1.55 + idxZ * dz
		posParam.rotationX = 26
		posParam.rotationY = 0
		posParam.rotationZ = 0
		posParam.scale = 0.9
	end

	return posParam
end

function RoomSceneInventoryEntitySelectMgr:refreshRemainBlock()
	return
end

function RoomSceneInventoryEntitySelectMgr:getBlockEntity(id)
	local tagEntitys = self:getTagUnitDict(SceneTag.RoomInventoryBlock)

	return tagEntitys and tagEntitys[id]
end

function RoomSceneInventoryEntitySelectMgr:onSceneClose()
	RoomSceneInventoryEntitySelectMgr.super.onSceneClose(self)

	self._isHasDelayCheckRetainTask = false

	TaskDispatcher.cancelTask(self._onDelayCheckRetain, self)

	self._inventoryBlockIdList = {}

	self:_removeAnim()
	self:removeAllUnits()
end

function RoomSceneInventoryEntitySelectMgr:addUnit(unit)
	RoomSceneInventoryEntitySelectMgr.super.addUnit(self, unit)
end

return RoomSceneInventoryEntitySelectMgr
