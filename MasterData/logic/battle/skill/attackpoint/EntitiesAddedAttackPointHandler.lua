-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/attackpoint/EntitiesAddedAttackPointHandler.lua

module("logic.battle.skill.attackpoint.EntitiesAddedAttackPointHandler", package.seeall)

local EntitiesAddedAttackPointHandler = class("EntitiesAddedAttackPointHandler", AbstractGlobalReusable, ISkillAttackPointHandler)

function EntitiesAddedAttackPointHandler:parseEventNO(entities)
	local handler = EntitiesAddedAttackPointHandler:createInstance()

	for _, entityNO in ipairs(entities) do
		handler:addEntityInfo(BattleNOConverter:entityNO2EntityInfo(entityNO))
	end

	return handler
end

function EntitiesAddedAttackPointHandler:ctor()
	self._entityInfos = {}

	self:reuse()
end

function EntitiesAddedAttackPointHandler:reset()
	self._isExecuted = false

	BattleTableUtil.clearReusableTable(self._entityInfos)

	if self._timelineTask then
		self._timelineTask:clear()
	end
end

function EntitiesAddedAttackPointHandler:clear()
	self:reset()
end

function EntitiesAddedAttackPointHandler:destroy()
	self:reset()
end

function EntitiesAddedAttackPointHandler:collectEntityIds(entityIdList)
	return
end

function EntitiesAddedAttackPointHandler:build(context)
	return
end

function EntitiesAddedAttackPointHandler:handleAttackPoint(context, weight)
	if self._isExecuted then
		return
	end

	self._isExecuted = true

	self:_createUnits()
	self:_playCreateEffects(context)
	BattleTableUtil.clearTable(self._entityInfos)
end

function EntitiesAddedAttackPointHandler:_createUnits()
	local model = BattleMgr.instance:getModel()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local battleFieldInfo = model:getBattleFieldInfo()

	for _, entityInfo in ipairs(self._entityInfos) do
		battleFieldInfo:addEntityInfo(entityInfo)
		unitMgr:createUnit(entityInfo)
	end

	BattleDispatcher:dispatchEvent(BattleEventType.OnEntitiesAdded)
end

function EntitiesAddedAttackPointHandler:_playCreateEffects(context)
	self:_handleCameraAdjust(context)

	local goTimeline = context:getTimelineGameObject()
	local goAoeAttackedRoot = GameObjectUtils.FindChildRecursively(goTimeline, 10, SkillTimelineContext.AOEAttackedRoot)

	if not goAoeAttackedRoot then
		return
	end

	local template = goAoeAttackedRoot.transform:GetChild(0)

	if not template then
		if BattleLog.enableError then
			BattleLog.error("Cannot find any effect template gameobject")
		end

		return
	end

	local goEffectTemplate = template.gameObject
	local unitMgr = BattleMgr.instance:getUnitMgr()

	for _, entityInfo in ipairs(self._entityInfos) do
		local unit = unitMgr:getUnit(entityInfo.entityId)
		local goEffect = goutil.clone(goEffectTemplate)

		goutil.setActive(goEffect, true)
		goutil.addChildToParent(goEffect, goAoeAttackedRoot)

		local x, y, z = BattleUnitUtil.getUnitCellCenterPos(unit)

		Astral.TransformUtil.SetPos(goEffect.transform, x, y, z)
	end

	goutil.setActive(goEffectTemplate, false)
end

function EntitiesAddedAttackPointHandler:_handleCameraAdjust(context)
	local cameraUnionIndex = self:_findFarestUnionIndex(context)

	if cameraUnionIndex then
		local adjustCameraCmd = BattleAdjustFollowCenter2Command:create(cameraUnionIndex, cameraUnionIndex)

		adjustCameraCmd:setDuration(0.3 / BattleTime.timeScale)
		adjustCameraCmd:execute(BattleMgr.instance:getActiveBattleFlow())

		self._timelineTask = self._timelineTask or TimelineTask.New()

		self._timelineTask:clear()
		self._timelineTask:addTask(0.5, self._cameraBackToAttacker, self)
		self._timelineTask:addFinishListener(self._onTimelineTaskFinish, self)
		self._timelineTask:start(context)
	end
end

function EntitiesAddedAttackPointHandler:_cameraBackToAttacker(context)
	local attackerUnionIndex = self:_getAttackerUnionIndex(context)
	local adjustCameraCmd = BattleAdjustFollowCenter2Command:create(attackerUnionIndex, attackerUnionIndex)

	adjustCameraCmd:setDuration(0.3 / BattleTime.timeScale)
	adjustCameraCmd:execute(BattleMgr.instance:getActiveBattleFlow())
end

function EntitiesAddedAttackPointHandler:_findFarestUnionIndex(context)
	local attackInfo = context:getAttackInfo()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local attacker = attackInfo:getAttacker()

	if not attacker then
		return
	end

	local attackerX, attackZ = attacker.transform:getCoordinates()
	local farRange = 0
	local farUnit = false

	for _, entityInfo in ipairs(self._entityInfos) do
		local unit = unitMgr:getUnit(entityInfo.entityId)
		local x, z = unit.transform:getCoordinates()
		local range = math.abs(x - attackerX) + math.abs(z - attackZ)

		if farRange < range then
			farRange = range
			farUnit = unit
		end
	end

	if farRange >= 3 then
		return BattleUnitUtil.getUnionIndex(farUnit)
	end

	return false
end

function EntitiesAddedAttackPointHandler:_getAttackerUnionIndex(context)
	local attackInfo = context:getAttackInfo()
	local attacker = attackInfo:getAttacker()

	if not attacker then
		return
	end

	return BattleUnitUtil.getUnionIndex(attacker)
end

function EntitiesAddedAttackPointHandler:toString()
	return string.format("[entities added attack handler, count = %s]", #self._entityInfos)
end

function EntitiesAddedAttackPointHandler:setEntityId(entityId)
	return
end

function EntitiesAddedAttackPointHandler:addEntityInfo(entityInfo)
	table.insert(self._entityInfos, entityInfo)
end

return EntitiesAddedAttackPointHandler
