-- chunkname: @modules/logic/scene/room/comp/entitymgr/RoomSceneCharacterEntityMgr.lua

module("modules.logic.scene.room.comp.entitymgr.RoomSceneCharacterEntityMgr", package.seeall)

local RoomSceneCharacterEntityMgr = class("RoomSceneCharacterEntityMgr", BaseSceneUnitMgr)

function RoomSceneCharacterEntityMgr:onInit()
	return
end

function RoomSceneCharacterEntityMgr:init(sceneId, levelId)
	self._scene = self:getCurScene()

	if RoomController.instance:isEditMode() then
		return
	end

	local characterMOList = RoomCharacterModel.instance:getList()

	for _, mo in ipairs(characterMOList) do
		self:spawnRoomCharacter(mo)
	end

	if not self:getUnit(SceneTag.Untagged, 1) then
		self:_spawnEffect(RoomEnum.EffectKey.CharacterFootPrintGOKey, RoomCharacterFootPrintEntity, 1)
	end
end

function RoomSceneCharacterEntityMgr:spawnRoomCharacter(roomCharacterMO)
	return self:_spawnRoomCharacter(roomCharacterMO)
end

function RoomSceneCharacterEntityMgr:_spawnRoomCharacter(roomCharacterMO, isNotAdd)
	if not RoomController.instance:isObMode() and not RoomController.instance:isVisitMode() then
		return
	end

	local characterRoot = self._scene.go.characterRoot
	local currentPosition = roomCharacterMO.currentPosition
	local characterGO = gohelper.create3d(characterRoot, string.format("%s", roomCharacterMO.id))
	local characterEntity = MonoHelper.addNoUpdateLuaComOnceToGo(characterGO, RoomCharacterEntity, roomCharacterMO.id)

	if isNotAdd ~= true then
		self:addUnit(characterEntity)
	end

	gohelper.addChild(characterRoot, characterGO)
	characterEntity:setLocalPos(currentPosition.x, currentPosition.y, currentPosition.z)
	RoomCharacterController.instance:dispatchEvent(RoomEvent.CharacterEntityChanged)

	return characterEntity
end

function RoomSceneCharacterEntityMgr:_spawnEffect(name, clsDefine, id)
	local effectRoot = self._scene.go.characterRoot
	local effectGO = gohelper.create3d(effectRoot, name)
	local effectEntity = MonoHelper.addNoUpdateLuaComOnceToGo(effectGO, clsDefine, id)

	gohelper.addChild(effectRoot, effectGO)
	self:addUnit(effectEntity)

	return effectEntity
end

function RoomSceneCharacterEntityMgr:moveTo(entity, position)
	entity:setLocalPos(position.x, position.y, position.z)
end

function RoomSceneCharacterEntityMgr:destroyCharacter(entity)
	self:removeUnit(entity:getTag(), entity.id)
	RoomCharacterController.instance:dispatchEvent(RoomEvent.CharacterEntityChanged)
end

function RoomSceneCharacterEntityMgr:getCharacterEntity(id, sceneTag)
	local tagEntitys = (not sceneTag or sceneTag == SceneTag.RoomCharacter) and self:getTagUnitDict(SceneTag.RoomCharacter)

	return tagEntitys and tagEntitys[id]
end

function RoomSceneCharacterEntityMgr:spawnTempCharacterByMO(roomCharacterMO)
	if self._tempCharacterEntity then
		if roomCharacterMO and self._tempCharacterEntity.id == roomCharacterMO.id then
			return self._tempCharacterEntity
		end

		local unit = self._tempCharacterEntity

		self._tempCharacterEntity = nil

		self:destroyUnit(unit)
	end

	if roomCharacterMO then
		self._tempCharacterEntity = self:_spawnRoomCharacter(roomCharacterMO, true)
	end

	return self._tempCharacterEntity
end

function RoomSceneCharacterEntityMgr:getTempCharacterEntity()
	return self._tempCharacterEntity
end

function RoomSceneCharacterEntityMgr:getRoomCharacterEntityDict()
	return self._tagUnitDict[SceneTag.RoomCharacter] or {}
end

function RoomSceneCharacterEntityMgr:_onUpdate()
	return
end

function RoomSceneCharacterEntityMgr:onSceneClose()
	RoomSceneCharacterEntityMgr.super.onSceneClose(self)

	local unit = self._tempCharacterEntity

	if unit then
		self._tempCharacterEntity = nil

		self:destroyUnit(unit)
	end
end

return RoomSceneCharacterEntityMgr
