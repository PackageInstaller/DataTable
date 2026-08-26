-- chunkname: @modules/logic/fight/mgr/FightEntityMgr.lua

module("modules.logic.fight.mgr.FightEntityMgr", package.seeall)

local FightEntityMgr = class("FightEntityMgr", FightBaseClass)

function FightEntityMgr:onConstructor()
	self.entityDic = {}
	self.diffEntityIdForCompareUpdate = {}
	self.enableSpineRotate = true
	self._forward = Vector3.New(0, 0, 0)
	self._containerGO = gohelper.findChild(GameSceneMgr.instance:getScene(SceneType.Fight):getSceneContainerGO(), "Entitys")

	self:com_registFightEvent(FightEvent.OnUpdateSpeed, self._onUpdateSpeed)

	local transformListener = ZProj.TransformListener.Get(CameraMgr.instance:getUnitCameraGO())

	transformListener:AddPositionCallback(self._adjustSpinesLookRotation, self)
	transformListener:AddRotationCallback(self._adjustSpinesLookRotation, self)
end

function FightEntityMgr:getEntityContainer()
	return self._containerGO
end

function FightEntityMgr:getAllEntity()
	return self.entityDic
end

function FightEntityMgr:getMyVertin()
	return self.entityDic[FightEntityScene.MySideId]
end

function FightEntityMgr:newEntity(entityData, ...)
	local work = self:registNewEntityWork(entityData, ...)

	work:start()

	return self.entityDic[entityData.id]
end

function FightEntityMgr:registNewEntityWork(entityData, ...)
	return (self:com_registWork(FightWorkNewEntity, entityData, ...))
end

function FightEntityMgr:delEntity(entityId)
	local tarEntity = self.entityDic[entityId]

	if tarEntity then
		if FightSkillMgr.instance:isEntityPlayingTimeline(entityId) then
			FightSkillMgr.instance:afterTimeline(tarEntity)
		end

		FightController.instance:dispatchEvent(FightEvent.BeforeDestroyEntity, tarEntity)
		tarEntity:disposeSelf()

		self.entityDic[entityId] = nil
	end
end

function FightEntityMgr:delAllEntity()
	for entityId, entity in pairs(self.entityDic) do
		self:delEntity(entityId)
	end
end

function FightEntityMgr:newAllEntity()
	local flow = self:registNewAllEntityWork()

	flow:start()
end

function FightEntityMgr:registNewAllEntityWork()
	local flow = self:com_registFlowParallel()
	local myVertinData = FightDataHelper.entityMgr:getMyVertin()

	if not myVertinData then
		myVertinData = FightEntityMO.New()

		local proto = FightDef_pb.FightEntityInfo()

		proto.uid = FightEntityScene.MySideId
		proto.teamType = FightEnum.TeamType.MySide

		myVertinData:init(proto, FightEnum.EntitySide.MySide)
	end

	flow:addWork(self:registNewEntityWork(myVertinData))

	local enemyVertinData = FightDataHelper.entityMgr:getEnemyVertin()

	if not enemyVertinData then
		enemyVertinData = FightEntityMO.New()

		local proto = FightDef_pb.FightEntityInfo()

		proto.uid = FightEntityScene.EnemySideId
		proto.teamType = FightEnum.TeamType.EnemySide

		enemyVertinData:init(proto, FightEnum.EntitySide.EnemySide)
	end

	flow:addWork(self:registNewEntityWork(enemyVertinData))
	flow:addWork(self:registAddASFDUnitWork())
	flow:addWork(self:registAddVorpalithUnitWork())

	for _, entityData in ipairs(FightDataHelper.entityMgr:getMyNormalList()) do
		flow:addWork(self:registNewEntityWork(entityData, FightEnum.EntityCreateStage.Init))
	end

	for _, entityData in ipairs(FightDataHelper.entityMgr:getEnemyNormalList()) do
		flow:addWork(self:registNewEntityWork(entityData, FightEnum.EntityCreateStage.Init))
	end

	local mySideSub = FightDataHelper.entityMgr:getMySubList()

	table.sort(mySideSub, FightEntityDataHelper.sortSubEntityList)

	for _, entityData in ipairs(mySideSub) do
		flow:addWork(self:registNewEntityWork(entityData, FightEnum.EntityCreateStage.Init))

		break
	end

	for _, entityData in ipairs(FightDataHelper.entityMgr:getSpList(FightEnum.EntitySide.MySide)) do
		flow:addWork(self:registNewEntityWork(entityData, FightEnum.EntityCreateStage.Init))
	end

	for _, entityData in ipairs(FightDataHelper.entityMgr:getSpList(FightEnum.EntitySide.EnemySide)) do
		flow:addWork(self:registNewEntityWork(entityData, FightEnum.EntityCreateStage.Init))
	end

	local assistBoss = FightDataHelper.entityMgr:getAssistBoss()

	if assistBoss and not FightDataHelper.paTaMgr:checkIsAssistRole() then
		flow:addWork(self:registNewEntityWork(assistBoss, FightEnum.EntityCreateStage.Init))
	end

	local spFightEntities = FightDataHelper.entityMgr:getSpFightEntities(FightEnum.EntitySide.MySide)

	for i, entityData in ipairs(spFightEntities) do
		flow:addWork(self:registNewEntityWork(entityData, FightEnum.EntityCreateStage.Init))
	end

	spFightEntities = FightDataHelper.entityMgr:getSpFightEntities(FightEnum.EntitySide.EnemySide)

	for i, entityData in ipairs(spFightEntities) do
		flow:addWork(self:registNewEntityWork(entityData, FightEnum.EntityCreateStage.Init))
	end

	return flow
end

function FightEntityMgr:getTagList(tag)
	local list = {}

	for k, entity in pairs(self.entityDic) do
		if entity:getTag() == tag then
			table.insert(list, entity)
		end
	end

	return list
end

function FightEntityMgr:addVorpalithUnit()
	local work = self:registAddVorpalithUnitWork()

	work:start()
end

function FightEntityMgr:registAddVorpalithUnitWork()
	local flow = self:com_registFlowParallel()

	flow:addWork(self:registNewEntityWork(FightDataHelper.entityMgr:getVorpalith()))

	return flow
end

function FightEntityMgr:addASFDUnit()
	local flow = self:registAddASFDUnitWork()

	flow:start()
end

function FightEntityMgr:registAddASFDUnitWork()
	local flow = self:com_registFlowParallel()

	flow:addWork(self:registNewEntityWork(FightDataHelper.entityMgr:getASFDEntityMo(FightEnum.EntitySide.MySide)))
	flow:addWork(self:registNewEntityWork(FightDataHelper.entityMgr:getASFDEntityMo(FightEnum.EntitySide.EnemySide)))

	return flow
end

function FightEntityMgr:_adjustSpinesLookRotation()
	if not self.enableSpineRotate then
		return
	end

	local cameraPosX, cameraPosY, cameraPosZ = self:_getCameraPos()

	for k, entity in pairs(self.entityDic) do
		self:adjustSpineLookRotation(entity)
	end
end

function FightEntityMgr:adjustSpineLookRotation(entity)
	if not self.enableSpineRotate then
		return
	end

	if entity and not gohelper.isNil(entity.go) and FightDataHelper.entityExMgr:getById(entity.id).needLookCamera then
		local entityTr = entity.go.transform
		local mainCameraTrs = CameraMgr.instance:getMainCameraTrs()

		transformhelper.setLocalRotation(entityTr, transformhelper.getLocalRotation(mainCameraTrs))
	end
end

function FightEntityMgr:_getCameraPos()
	local subCameraGO = CameraMgr.instance:getSubCameraGO()

	if subCameraGO.activeInHierarchy then
		return transformhelper.getPos(CameraMgr.instance:getSubCameraTrs())
	end

	return transformhelper.getPos(CameraMgr.instance:getUnitCameraTrs())
end

function FightEntityMgr:_onUpdateSpeed()
	local speed = FightModel.instance:getSpeed()

	for k, entity in pairs(self.entityDic) do
		entity:setSpeed(speed)
	end
end

function FightEntityMgr:compareUpdate(fight, changeWave)
	FightModel.instance:updateFight(fight, changeWave)
	self:newAllEntityAndRemoveDiff()
end

function FightEntityMgr:newAllEntityAndRemoveDiff()
	self.diffEntityIdForCompareUpdate = {}

	local flow = self:registNewAllEntityWork()

	flow:start()

	for entityId, entity in pairs(self.entityDic) do
		if not self.diffEntityIdForCompareUpdate[entityId] then
			if (entity.isTempEntity or nil) and false then
				self:delEntity(entityId)
			end
		end
	end
end

function FightEntityMgr:changeWave(fight)
	self:compareUpdate(fight, true)
end

function FightEntityMgr:getEntity(id)
	return self.entityDic[id]
end

function FightEntityMgr:getById(id)
	return self.entityDic[id]
end

function FightEntityMgr:getEntityByPosId(tag, posId)
	for entityId, entity in pairs(self.entityDic) do
		if entity:getTag() == tag and entity.entityData.position == posId then
			return entity
		end
	end
end

function FightEntityMgr:showSubEntity()
	if self._showSubWork then
		self._showSubWork:disposeSelf()
	end

	self._showSubWork = FightWorkBuildSubEntityAfterChangeHero.New()

	self._showSubWork:start()
end

function FightEntityMgr:getTempEntityIdBySpineNameOrSpecificId(spineName, specificId)
	local id = tostring(specificId)

	id = string.nilorempty(id) and spineName or id

	if FightGameMgr.entityMgr:getEntity(id) then
		id = id .. "_1"
	end

	return id
end

function FightEntityMgr:buildTempSpineByName(spineName, specificId, specificSide, mirror, skin, param, reverseLookDir, useScaleReplaceSpineScale)
	local id = self:getTempEntityIdBySpineNameOrSpecificId(spineName, specificId)

	if self.entityDic[id] then
		self.diffEntityIdForCompareUpdate[id] = true

		return
	end

	local entityData = FightEntityMO.New()
	local entityExData = FightDataHelper.entityExMgr:getById(id)
	local entityProto = FightDef_pb.FightEntityInfo()

	entityProto.uid = id

	if specificSide == FightEnum.EntitySide.MySide then
		entityProto.teamType = FightEnum.TeamType.MySide or FightEnum.TeamType.EnemySide
	end

	if entityExData.skin then
		entityProto.skin = entityExData.skin
	end

	entityData:init(entityProto, specificSide)

	entityExData.entityClass = entityExData.entityClass or FightEntityTemp
	entityExData.entityObjectName = id
	entityExData.useScaleReplaceSpineScale = useScaleReplaceSpineScale
	entityExData.lookDir = mirror and specificSide and FightHelper.getSpineLookDir(specificSide) or SpineLookDir.Left

	if reverseLookDir then
		if FightHelper.getSpineLookDir(specificSide) == SpineLookDir.Left then
			entityExData.lookDir = SpineLookDir.Right or SpineLookDir.Left
		end
	end

	entityExData.needLookCamera = false
	entityExData.spineUrl = entityExData.spineUrl or skin and ResUrl.getSpineFightPrefabBySkin(skin) or ResUrl.getSpineFightPrefab(spineName)

	local entity = self:newEntity(entityData)

	entity.isTempEntity = true

	if param and param.ingoreRainEffect then
		entity.ingoreRainEffect = true
	end

	return entity
end

function FightEntityMgr:buildTempSpine(spinePath, entityId, side, layer, cls, containerName)
	if self.entityDic[entityId] then
		self.diffEntityIdForCompareUpdate[entityId] = true

		return
	end

	local goName = containerName

	if not goName then
		local array = FightStrUtil.split(spinePath, "/")

		goName = array[#array]
	end

	local entityData = FightEntityMO.New()
	local entityProto = FightDef_pb.FightEntityInfo()

	entityProto.uid = entityId

	if side == FightEnum.EntitySide.MySide then
		entityProto.teamType = FightEnum.TeamType.MySide or FightEnum.TeamType.EnemySide
	end

	entityData:init(entityProto, side)

	local entityExData = FightDataHelper.entityExMgr:getById(entityId)

	entityExData.entityClass = cls or FightEntityTemp
	entityExData.entityObjectName = goName

	if side == FightEnum.EntitySide.MySide then
		entityExData.lookDir = SpineLookDir.Left or SpineLookDir.Right
	end

	entityExData.spineUrl = spinePath
	entityExData.needLookCamera = false

	local entity = self:newEntity(entityData)

	entity.isTempEntity = true

	if layer then
		entity.spine:setLayer(layer, true)
	end

	return entity
end

function FightEntityMgr:buildTempSceneEntity(name)
	local id = "Temp_" .. name

	if self.entityDic[id] then
		self.diffEntityIdForCompareUpdate[id] = true

		return
	end

	local entityData = FightEntityMO.New()
	local entityProto = FightDef_pb.FightEntityInfo()

	entityProto.uid = id
	entityProto.teamType = FightEnum.TeamType.MySide

	entityData:init(entityProto, FightEnum.EntitySide.MySide)

	local entityExData = FightDataHelper.entityExMgr:getById(id)

	entityExData.entityClass = FightEntityScene
	entityExData.entityObjectName = id

	local entity = self:newEntity(entityData)

	entity.isTempEntity = true

	return entity
end

function FightEntityMgr:onDestructor()
	local transformListener = ZProj.TransformListener.Get(CameraMgr.instance:getUnitCameraGO())

	transformListener:RemovePositionCallback()
	transformListener:RemoveRotationCallback()

	if self._showSubWork then
		self._showSubWork:disposeSelf()

		self._showSubWork = nil
	end
end

return FightEntityMgr
