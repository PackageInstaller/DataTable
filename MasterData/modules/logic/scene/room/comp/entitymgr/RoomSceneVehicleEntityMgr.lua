-- chunkname: @modules/logic/scene/room/comp/entitymgr/RoomSceneVehicleEntityMgr.lua

module("modules.logic.scene.room.comp.entitymgr.RoomSceneVehicleEntityMgr", package.seeall)

local RoomSceneVehicleEntityMgr = class("RoomSceneVehicleEntityMgr", BaseSceneUnitMgr)

function RoomSceneVehicleEntityMgr:onInit()
	return
end

function RoomSceneVehicleEntityMgr:init(sceneId, levelId)
	self._scene = self:getCurScene()

	self:_startSpawnVehicle()
end

function RoomSceneVehicleEntityMgr:onStopMode()
	self:_onSwitchMode(true)
end

function RoomSceneVehicleEntityMgr:onSwitchMode()
	self:_onSwitchMode(RoomController.instance:isEditMode())
end

function RoomSceneVehicleEntityMgr:_onSwitchMode(isEditMode)
	local vehicleTag = RoomMapVehicleEntity:getTag()
	local entityDic = self:getTagUnitDict(vehicleTag)

	if isEditMode then
		self:_stopSpawnVehicle()

		if entityDic then
			for unitId, vehicleEntity in pairs(entityDic) do
				vehicleEntity:setShow(false)
			end
		end
	else
		if entityDic then
			local tRoomMapVehicleModel = RoomMapVehicleModel.instance

			for unitId, vehicleEntity in pairs(entityDic) do
				local mo = tRoomMapVehicleModel:getById(unitId)

				if mo then
					self:setVehiclePosByMO(vehicleEntity, mo)
					vehicleEntity:setShow(true)
				else
					self:removeUnit(vehicleTag, unitId)
				end
			end
		end

		self:_startSpawnVehicle()
	end
end

function RoomSceneVehicleEntityMgr:_stopSpawnVehicle()
	if self._isRuningSpawnVehicle then
		self._isRuningSpawnVehicle = false

		TaskDispatcher.cancelTask(self._onRepeatSpawnVehicle, self)
	end
end

function RoomSceneVehicleEntityMgr:_startSpawnVehicle()
	local vehicleTag = RoomMapVehicleEntity:getTag()
	local mapVehicleMOList = RoomMapVehicleModel.instance:getList()

	self._waitVehicleMOList = nil

	for i, mo in ipairs(mapVehicleMOList) do
		if not self:getUnit(vehicleTag, mo.id) then
			self._waitVehicleMOList = self._waitVehicleMOList or {}

			table.insert(self._waitVehicleMOList, mo)
		end
	end

	if self._waitVehicleMOList and not self._isRuningSpawnVehicle then
		self._isRuningSpawnVehicle = true

		TaskDispatcher.runRepeat(self._onRepeatSpawnVehicle, self, 0)
	end
end

function RoomSceneVehicleEntityMgr:_onRepeatSpawnVehicle()
	if self._waitVehicleMOList and #self._waitVehicleMOList > 0 then
		local mapVehicleMO = self._waitVehicleMOList[1]

		table.remove(self._waitVehicleMOList, 1)
		self:spawnMapVehicle(mapVehicleMO)
	else
		self:_stopSpawnVehicle()
	end
end

function RoomSceneVehicleEntityMgr:spawnMapVehicle(mapVehicleMO)
	local vehicleRoot = self._scene.go.vehicleRoot
	local vehicleGO = gohelper.create3d(vehicleRoot, mapVehicleMO.id)
	local vehicleEntity = MonoHelper.addNoUpdateLuaComOnceToGo(vehicleGO, RoomMapVehicleEntity, mapVehicleMO.id)

	self:addUnit(vehicleEntity)
	gohelper.addChild(vehicleRoot, vehicleGO)
	self:setVehiclePosByMO(vehicleEntity, mapVehicleMO)

	return vehicleEntity
end

function RoomSceneVehicleEntityMgr:setVehiclePosByMO(vehicleEntity, vehicleMO)
	local mapVehicleMO = vehicleMO or vehicleEntity:getMO()
	local node = mapVehicleMO:getCurNode()
	local hexPoint = node and node.hexPoint

	if not hexPoint then
		logError("RoomSceneVehicleEntityMgr: 没有位置信息")

		return
	end

	local position = HexMath.hexToPosition(hexPoint, RoomBlockEnum.BlockSize)

	vehicleEntity:setLocalPos(position.x, RoomBuildingEnum.VehicleInitOffestY, position.y)
end

function RoomSceneVehicleEntityMgr:getVehicleEntity(id)
	return self:getUnit(RoomMapVehicleEntity:getTag(), id)
end

function RoomSceneVehicleEntityMgr:destroyVehicle(entity)
	self:removeUnit(entity:getTag(), entity.id)
end

function RoomSceneVehicleEntityMgr:onSceneClose()
	RoomSceneVehicleEntityMgr.super.onSceneClose(self)
	self:_stopSpawnVehicle()
end

return RoomSceneVehicleEntityMgr
