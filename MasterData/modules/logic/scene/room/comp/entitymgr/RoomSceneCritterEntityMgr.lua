-- chunkname: @modules/logic/scene/room/comp/entitymgr/RoomSceneCritterEntityMgr.lua

module("modules.logic.scene.room.comp.entitymgr.RoomSceneCritterEntityMgr", package.seeall)

local RoomSceneCritterEntityMgr = class("RoomSceneCritterEntityMgr", BaseSceneUnitMgr)

function RoomSceneCritterEntityMgr:onInit()
	return
end

function RoomSceneCritterEntityMgr:init(sceneId, levelId)
	self._scene = self:getCurScene()

	if RoomController.instance:isEditMode() then
		return
	end

	local roomCritterMOList = RoomCritterModel.instance:getList()

	for _, mo in ipairs(roomCritterMOList) do
		self:spawnRoomCritter(mo)
	end
end

function RoomSceneCritterEntityMgr:spawnRoomCritter(roomCritterMO)
	return self:_spawnRoomCritter(roomCritterMO, false)
end

function RoomSceneCritterEntityMgr:_spawnRoomCritter(roomCritterMO, isNotAdd)
	if not RoomController.instance:isObMode() and not RoomController.instance:isVisitMode() then
		return
	end

	local cititerRoot = self._scene.go.critterRoot
	local currentPosition = roomCritterMO.currentPosition
	local citterGO = gohelper.create3d(cititerRoot, string.format("%s", roomCritterMO.id))
	local critterEntity = MonoHelper.addNoUpdateLuaComOnceToGo(citterGO, RoomCritterEntity, roomCritterMO.id)

	if isNotAdd ~= true then
		self:addUnit(critterEntity)
	end

	gohelper.addChild(cititerRoot, citterGO)

	if currentPosition then
		critterEntity:setLocalPos(currentPosition.x, currentPosition.y, currentPosition.z)
	end

	return critterEntity
end

function RoomSceneCritterEntityMgr:delaySetFollow(critterUid, delay)
	local entity = self:getCritterEntity(critterUid, SceneTag.RoomCharacter)

	if entity and entity.critterfollower then
		entity.critterfollower:delaySetFollow(delay or 0.1)
	end
end

function RoomSceneCritterEntityMgr:moveTo(entity, position)
	entity:setLocalPos(position.x, position.y, position.z)
end

function RoomSceneCritterEntityMgr:destroyCritter(entity)
	self:removeUnit(entity:getTag(), entity.id)
end

function RoomSceneCritterEntityMgr:getCritterEntity(id, sceneTag)
	local tagEntitys = (not sceneTag or sceneTag == SceneTag.RoomCharacter) and self:getTagUnitDict(SceneTag.RoomCharacter)

	return tagEntitys and tagEntitys[id]
end

function RoomSceneCritterEntityMgr:spawnTempCritterByMO(roomCritterMO)
	if self._tempCritterEntity then
		if roomCritterMO and self._tempCritterEntity.id == roomCritterMO.id then
			return self._tempCritterEntity
		end

		local unit = self._tempCritterEntity

		self._tempCritterEntity = nil

		self:destroyUnit(unit)
	end

	if roomCritterMO then
		self._tempCritterEntity = self:_spawnRoomCritter(roomCritterMO, true)
	end

	return self._tempCritterEntity
end

function RoomSceneCritterEntityMgr:getTempCritterEntity()
	return self._tempCritterEntity
end

function RoomSceneCritterEntityMgr:getRoomCritterEntityDict()
	return self._tagUnitDict[SceneTag.RoomCharacter] or {}
end

function RoomSceneCritterEntityMgr:_onUpdate()
	return
end

function RoomSceneCritterEntityMgr:onSceneClose()
	RoomSceneCritterEntityMgr.super.onSceneClose(self)

	local unit = self._tempCritterEntity

	if unit then
		self._tempCritterEntity = nil

		self:destroyUnit(unit)
	end
end

return RoomSceneCritterEntityMgr
