-- chunkname: @modules/logic/fight/system/work/FightWorkNewEntity.lua

module("modules.logic.fight.system.work.FightWorkNewEntity", package.seeall)

local FightWorkNewEntity = class("FightWorkNewEntity", FightWorkItem)

function FightWorkNewEntity:onConstructor(entityData, createStage)
	self.entityData = entityData
	self.createStage = createStage
end

function FightWorkNewEntity:onStart()
	if not self.entityData then
		return self:onDone(true)
	end

	local entityData = self.entityData

	self.entityExData = FightDataHelper.entityExMgr:getById(entityData.id)

	if lua_fight_monster_3d.configDict[entityData.skin] then
		self.entityExData.needLookCamera = false
	end

	self.customDefaultEntityInitData = self.entityExData:getCustomDefaultEntityInitData(entityData.id)
	self.entityExData.customDefaultEntityInitData = nil
	FightGameMgr.entityMgr.diffEntityIdForCompareUpdate[entityData.id] = true

	local entityMgr = FightGameMgr.entityMgr
	local entity = entityMgr.entityDic[entityData.id]

	if entity then
		if not entity.spine then
			self:onDone(true)

			return
		else
			local spineObj = entity.spine:getSpineGO()

			if not gohelper.isNil(spineObj) then
				self:onDone(true)

				return
			else
				local spineUrl = entity.spine:getSpineUrl()

				if string.nilorempty(spineUrl) then
					self:onDone(true)

					return
				else
					self:cancelFightWorkSafeTimer()
					self:com_registFightEvent(FightEvent.AfterInitSpine, self.onAfterInitSpine)

					return
				end
			end
		end
	end

	local entityClass, entityName = self:getEntityClass()

	entityName = entityName or "entity" .. entityData.id
	entity = entityMgr:newClass(entityClass, entityName, entityData)

	entity:setSpeed(FightModel.instance:getSpeed())

	entityMgr.entityDic[entity.id] = entity

	entity:setUseGoScaleReplaceSpineScale(self.entityExData.useScaleReplaceSpineScale)
	entity:resetEntity()

	if self.createStage then
		entity:setCreateStage(self.createStage)
	end

	local flow = self:com_registFlowSequence()

	if entity.spine then
		flow:addWork(entity:registLoadSpineWork())
	end

	if not self.customDefaultEntityInitData.entityAlphaWhenInit then
		flow:registWork(FightWorkFunction, entity.setAlpha, entity, (FightDataHelper.stateMgr:hasMark(FightStateDataMgr.Mark.NewAllEntityWhenEnter) or nil) and 0)

		if entity.nameUI then
			flow:registWork(FightWorkFunction, entity.nameUI.load, entity.nameUI, ResUrl.getSceneUIPrefab("fight", "fightname"))
		end

		flow:registWork(FightWorkSendEvent, FightEvent.OnAddNewEntity, entity.id, entityData)
		self:playWorkAndDone(flow)
	end
end

function FightWorkNewEntity:getEntityClass()
	local entityData = self.entityData
	local entitySide = entityData.side
	local entityId = entityData.id

	if self.entityExData.entityClass then
		return self.entityExData.entityClass, self.entityExData.entityObjectName
	end

	if lua_fight_monster_3d.configDict[entityData.skin] then
		return Fight3DEntityObject, entityData:getIdName()
	end

	if entityId == FightEntityScene.MySideId or entityId == FightEntityScene.EnemySideId then
		return FightEntityScene, entitySide == FightEnum.EntitySide.MySide and "MyVertin" or "EnemyVertin"
	end

	if entityData:isASFDEmitter() then
		return FightEntityASFD, entitySide == FightEnum.EntitySide.MySide and "MyASFDEntityGo" or "EnemyASFDEntityGo"
	end

	if entityData:isRouge2Music() then
		return FightEntityRouge2Music, "rouge2Music"
	end

	if entityData:isVorpalith() then
		return FightEntityVorpalith, "Vorpalith"
	end

	local modelCo = lua_fight_sp_500m_model.configDict[entityData.modelId]

	if modelCo then
		return FightEntityMonster_500M, entityData:getIdName()
	end

	if FightDataHelper.entityMgr:isSub(entityId) then
		local EntityGOName = entityData:getIdName()

		return FightEntitySub, EntityGOName
	end

	local assembledMonsterConfig = lua_fight_assembled_monster.configDict[entityData.skin]

	if assembledMonsterConfig then
		if assembledMonsterConfig.part == 1 then
			return FightEntityAssembledMonsterMain, entityData:getIdName()
		else
			return FightEntityAssembledMonsterSub, entityData:getIdName()
		end
	end

	local isMySide = entityData.side == FightEnum.EntitySide.MySide

	return (isMySide or nil) and (FightEntityPlayer or FightEntityMonster), entityData:getIdName()
end

function FightWorkNewEntity:onAfterInitSpine(spineComp)
	if spineComp.entity.id == self.entityData.id then
		self:onDone(true)
	end
end

return FightWorkNewEntity
