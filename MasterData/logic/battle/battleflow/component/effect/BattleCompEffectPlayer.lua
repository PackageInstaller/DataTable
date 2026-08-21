-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/effect/BattleCompEffectPlayer.lua

module("logic.battle.battleflow.component.effect.BattleCompEffectPlayer", package.seeall)

local BattleCompEffectPlayer = class("BattleCompEffectPlayer", IBattleFlowComp, AbstractGlobalReusable)

function BattleCompEffectPlayer:onStart()
	self._timeScale = 1
	self._loopEffectList = {}
	self._onceEffectList = {}
	self._linkEffectGroupTable = {}
end

function BattleCompEffectPlayer:onClear()
	self._timeScale = 1

	self:_clearAllEffect()
end

function BattleCompEffectPlayer:onUndoReset()
	self:_clearAllEffect()
end

function BattleCompEffectPlayer:onUpdateTimeScale()
	self._timeScale = BattleTime.timeScale

	self:_updateSpeed()
end

function BattleCompEffectPlayer:playEffect(effectCode, goParent, effectClass)
	goParent = goParent or BattleGameObjectRootUtil.effectsRoot

	local effectUnit = EffectUtil.playEffectWithClass(effectCode, effectClass, goParent)

	effectUnit.main:setPlaySpeed(self._timeScale)
	effectUnit.lifeTime:setFinishListener(self._onEffectFinish, self)
	table.insert(self._onceEffectList, effectUnit)

	return effectUnit
end

function BattleCompEffectPlayer:playUniqueEffect(effectCode, goParent)
	local effect = self:_getEffect(effectCode)

	if effect then
		return effect
	end

	return self:playEffect(effectCode, goParent)
end

function BattleCompEffectPlayer:playOverrideEffect(effectCode, goParent)
	self:stopEffect(effectCode)

	return self:playEffect(effectCode, goParent)
end

function BattleCompEffectPlayer:stopEffect(effectCode)
	local effect = self:_getEffect(effectCode)

	if effect then
		self:_onEffectFinish(effect)
		EffectUtil.destroyEffect(effect)
	end
end

function BattleCompEffectPlayer:playLoopEffect(effectCode, key, mountHeight, goParent, isUnique)
	key = key or tostring(effectCode)

	local effectUnit = self:_getLoopEffect(key)

	if effectUnit then
		return effectUnit
	end

	effectUnit = EffectUtil.playEffectWithClass(effectCode, EffectUnit, goParent or BattleGameObjectRootUtil.effectsRoot)

	table.insert(self._loopEffectList, effectUnit)
	effectUnit.main:setEffectKey(key)
	effectUnit.transform:setLocalPositionXYZ(0, mountHeight or 0, 0)
	effectUnit.main:setPlaySpeed(1)
	effectUnit.main:setKeepSpeed(true)

	return effectUnit
end

function BattleCompEffectPlayer:stopLoopEffect(effectKey)
	local keyStr = tostring(effectKey)

	for i, effectUnit in pairs(self._loopEffectList) do
		if effectUnit.main:getEffectKey() == keyStr then
			EffectUtil.destroyEffect(effectUnit)
			table.remove(self._loopEffectList, i)

			return
		end
	end
end

function BattleCompEffectPlayer:stopLoopEffectWithAnim(effectKey, trackName, time)
	local keyStr = tostring(effectKey)

	time = time or 0.5

	for i, effectUnit in pairs(self._loopEffectList) do
		if effectUnit.main:getEffectKey() == keyStr then
			table.remove(self._loopEffectList, i)
			effectUnit.main:setPlaySpeed(self._timeScale)
			effectUnit.lifeTime:setFinishListener(self._onEffectFinish, self)
			effectUnit.transform:playEffectAnim(trackName)
			table.insert(self._onceEffectList, effectUnit)
			effectUnit.lifeTime:setLifeTime(time)

			return
		end
	end
end

function BattleCompEffectPlayer:stopAllLoopEffect()
	for i, effectUnit in pairs(self._loopEffectList) do
		EffectUtil.destroyEffect(effectUnit)
	end

	BattleTableUtil.clearTable(self._loopEffectList)
end

function BattleCompEffectPlayer:clearAllOnceEffect()
	self:_clearAllOnceEffect()
end

function BattleCompEffectPlayer:addLinkLine(effectCode, fromEntityId, toEntityId)
	local effectGroup = self:_getOrCreateGroup(effectCode)

	effectGroup:addLinkeLine(fromEntityId, toEntityId)
end

function BattleCompEffectPlayer:removeLinkLine(effectCode, fromEntityId, toEntityId)
	local effectGroup = self:_getOrCreateGroup(effectCode)

	effectGroup:removeLinkLine(fromEntityId, toEntityId)
end

function BattleCompEffectPlayer:removeLinkLineContainsEntityId(effectCode, entityId)
	local effectGroup = self:_getOrCreateGroup(effectCode)

	effectGroup:removeLinkLineContainsEntityId(entityId)
end

function BattleCompEffectPlayer:_onEffectFinish(unit)
	table.removebyvalue(self._onceEffectList, unit)
end

function BattleCompEffectPlayer:_getEffect(effectKey)
	local keyStr = tostring(effectKey)

	for _, effectUnit in pairs(self._onceEffectList) do
		if effectUnit.main:getEffectKey() == keyStr then
			return effectUnit
		end
	end

	return false
end

function BattleCompEffectPlayer:_getLoopEffect(effectKey)
	local keyStr = tostring(effectKey)

	for _, effectUnit in pairs(self._loopEffectList) do
		if effectUnit.main:getEffectKey() == keyStr then
			return effectUnit
		end
	end

	return false
end

function BattleCompEffectPlayer:_clearAllEffect()
	self:_clearAllOnceEffect()
	self:_clearAllLoopEffect()
	self:_clearAllLinkEffect()
end

function BattleCompEffectPlayer:_clearAllOnceEffect()
	for _, effectUnit in pairs(self._onceEffectList) do
		EffectUtil.destroyEffect(effectUnit)
	end

	BattleTableUtil.clearTable(self._onceEffectList)
end

function BattleCompEffectPlayer:_clearAllLoopEffect()
	for _, effectUnit in pairs(self._loopEffectList) do
		EffectUtil.destroyEffect(effectUnit)
	end

	BattleTableUtil.clearTable(self._loopEffectList)
end

function BattleCompEffectPlayer:_clearAllLinkEffect()
	for _, effectGroup in pairs(self._linkEffectGroupTable) do
		effectGroup:destroy()
	end

	BattleTableUtil.clearTable(self._linkEffectGroupTable)
end

function BattleCompEffectPlayer:_updateSpeed()
	for _, effectUnit in pairs(self._onceEffectList) do
		effectUnit.main:setPlaySpeed(self._timeScale)
	end

	for _, effectUnit in pairs(self._loopEffectList) do
		effectUnit.main:setPlaySpeed(self._timeScale)
	end
end

function BattleCompEffectPlayer:_getOrCreateGroup(effectCode)
	local effectGroup = self._linkEffectGroupTable[effectCode]

	if not effectGroup then
		effectGroup = BattleLinkEffectGroup.New()

		effectGroup:setUrl(EffectUtil.getEffectUrl(effectCode))

		self._linkEffectGroupTable[effectCode] = effectGroup
	end

	return effectGroup
end

return BattleCompEffectPlayer
