-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/BattleEntityManager.lua

BattleEntityManager = class("BattleEntityManager")

BattleEntityManager:has("_battleRecorder", {
	is = "rw"
})

function BattleEntityManager:initialize(id)
	super.initialize(self)

	self._entities = {}
	self._dyingEntities = {}
end

function BattleEntityManager:registerEntity(entity)
	local id = entity:getId()

	if self._entities[id] ~= nil then
		if self._battleRecorder then
			self._battleRecorder:recordEvent(kBRMainLine, "Error", {
				state = "EntityAlreadyRegistered",
				errorInfo = id
			})
		end

		assert(false, string.format("Entity with id=%s is already registered.", id))
	end

	self._entities[id] = entity
end

function BattleEntityManager:unregisterEntity(entityId)
	self._entities[entityId] = nil

	return self._entities[entityId]
end

function BattleEntityManager:fetchEntity(entityId)
	return self._entities[entityId]
end

function BattleEntityManager:createHeroUnit(heroData)
	local unit = BattleUnit:createHeroUnit(heroData.id)

	unit:initWithRawData(heroData)
	self:registerEntity(unit)

	return unit
end

function BattleEntityManager:createMasterUnit(masterData)
	local unit = BattleUnit:createMasterUnit(masterData.id)

	unit:initWithRawData(masterData)
	self:registerEntity(unit)

	return unit
end

function BattleEntityManager:createBattleFieldUnit(battleFieldData)
	local unit = BattleUnit:createBattleFieldUnit(battleFieldData.id)

	unit:initWithRawData(battleFieldData)
	self:registerEntity(unit)

	return unit
end

function BattleEntityManager:copyHeroUnit(srcUnit, entityId, ratio)
	local unit = BattleUnit:createHeroUnit(entityId)

	unit:copyUnit(srcUnit, ratio)
	self:registerEntity(unit)

	return unit
end

function BattleEntityManager:summonHeroUnit(srcUnit, entityId, info)
	local unit = BattleUnit:createHeroUnit(entityId)

	unit:inheritUnit(srcUnit, info)
	self:registerEntity(unit)

	return unit
end
