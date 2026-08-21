-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/BattleUnitCompEffectPlayer.lua

module("logic.battle.unit.comp.BattleUnitCompEffectPlayer", package.seeall)

local BattleUnitCompEffectPlayer = class("BattleUnitCompEffectPlayer", BattleUnitCompBase)

function BattleUnitCompEffectPlayer:onInit()
	self._timeScale = 1
	self._loopEffectList = {}
	self._onceEffectList = {}

	self:_setEvents(true)
end

function BattleUnitCompEffectPlayer:onReuse()
	self:_setEvents(true)
end

function BattleUnitCompEffectPlayer:onReset()
	self:_setEvents(false)

	self._timeScale = 1

	self:_clearAllEffect()
end

function BattleUnitCompEffectPlayer:onDestroy()
	self:_setEvents(false)
	self:_clearAllEffect()
end

function BattleUnitCompEffectPlayer:_setEvents(isOn)
	if isOn then
		self._unit:addInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
		self._unit:addInnerEventListener(UnitActionType.BattleBodyClear, self._onBodyClear, self)
	else
		self._unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
		self._unit:removeInnerEventListener(UnitActionType.BattleBodyClear, self._onBodyClear, self)
	end
end

function BattleUnitCompEffectPlayer:onUpdateTimeScale(timeScale)
	self._timeScale = timeScale

	self:_updateSpeed()
end

function BattleUnitCompEffectPlayer:playEffect(effectCode, effectClass)
	local goParent = self._unit.mountRoot:getRoot()
	local x, z = BattleUnitUtil.getXZCenter(self._unit)
	local effectUnit = EffectUtil.playEffectWithClass(effectCode, effectClass, goParent)

	effectUnit.main:setPlaySpeed(self._timeScale)
	effectUnit.lifeTime:setFinishListener(self._onEffectFinish, self)
	self:_adjustEffectPositionAndScale(effectUnit, effectCode)
	self:_tryAddResLoadedListener(effectCode, effectUnit)
	table.insert(self._onceEffectList, effectUnit)

	return effectUnit
end

function BattleUnitCompEffectPlayer:playUniqueEffect(effectCode)
	local effect = self:_getEffect(effectCode)

	if effect then
		return effect
	end

	return self:playEffect(effectCode)
end

function BattleUnitCompEffectPlayer:playOverrideEffect(effectCode)
	self:stopEffect(effectCode)

	return self:playEffect(effectCode)
end

function BattleUnitCompEffectPlayer:stopEffect(effectCode)
	local effect = self:_getEffect(effectCode)

	if effect then
		self:_onEffectFinish(effect)
		EffectUtil.destroyEffect(effect)
	end
end

function BattleUnitCompEffectPlayer:playLoopEffect(effectCode, mountRoot)
	local effectUnit = self:_getLoopEffect(effectCode)

	if effectUnit then
		return effectUnit
	end

	effectUnit = EffectUtil.playEffectWithClass(effectCode, EffectUnit, mountRoot or self._unit.mountRoot:getSignRoot())

	self:_adjustEffectPositionAndScale(effectUnit, effectCode)
	self:_tryAddResLoadedListener(effectCode, effectUnit)
	table.insert(self._loopEffectList, effectUnit)
	effectUnit.main:setPlaySpeed(1)
	effectUnit.main:setKeepSpeed(true)

	return effectUnit
end

function BattleUnitCompEffectPlayer:stopLoopEffect(effectCode)
	local url = EffectUtil.getEffectUrl(effectCode)

	for i, effectUnit in pairs(self._loopEffectList) do
		if effectUnit.loader:getUrl() == url then
			EffectUtil.destroyEffect(effectUnit)
			table.remove(self._loopEffectList, i)

			return
		end
	end
end

function BattleUnitCompEffectPlayer:stopLoopEffectWithAnim(effectCode, trackName, time)
	time = time or 0.5

	local url = EffectUtil.getEffectUrl(effectCode)

	for i, effectUnit in pairs(self._loopEffectList) do
		if effectUnit.loader:getUrl() == url then
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

function BattleUnitCompEffectPlayer:stopAllLoopEffect()
	for i, effectUnit in pairs(self._loopEffectList) do
		EffectUtil.destroyEffect(effectUnit)
	end

	BattleTableUtil.clearTable(self._loopEffectList)
end

function BattleUnitCompEffectPlayer:clearAllOnceEffect()
	self:_clearAllOnceEffect()
end

function BattleUnitCompEffectPlayer:getLoopEffect(effectCode)
	return self:_getLoopEffect(effectCode)
end

function BattleUnitCompEffectPlayer:_adjustEffectPositionAndScale(effect, effectCode)
	local unit = self._unit
	local x, z = BattleUnitUtil.getXZCenter(unit)
	local heightFactor = EffectUtil.getMountHeightFactor(effectCode)
	local originalBodySizeY = unit.meshModel:getOriginalBodySizeY()

	effect.transform:setLocalPositionXYZ(x, originalBodySizeY * heightFactor, z)

	if unit.transform:isComposite() then
		local rectangle = unit.transform:getRectangle()
		local scale = rectangle:getMaxx() - rectangle:getMinx() + 1

		effect.transform:setScaleXYZ(scale, scale, scale)
	end
end

function BattleUnitCompEffectPlayer:_onEffectFinish(unit)
	table.removebyvalue(self._onceEffectList, unit)
end

function BattleUnitCompEffectPlayer:_getEffect(effectCode)
	local url = EffectUtil.getEffectUrl(effectCode)

	for _, effectUnit in pairs(self._onceEffectList) do
		if effectUnit.loader:getUrl() == url then
			return effectUnit
		end
	end

	return false
end

function BattleUnitCompEffectPlayer:_getLoopEffect(effectCode)
	local url = EffectUtil.getEffectUrl(effectCode)

	for _, effectUnit in pairs(self._loopEffectList) do
		if effectUnit.loader:getUrl() == url then
			return effectUnit
		end
	end

	return false
end

function BattleUnitCompEffectPlayer:_clearAllEffect()
	self:_clearAllOnceEffect()
	self:_clearAllLoopEffect()
end

function BattleUnitCompEffectPlayer:clearAllEffect()
	self:_clearAllEffect()
end

function BattleUnitCompEffectPlayer:_clearAllOnceEffect()
	for _, effectUnit in pairs(self._onceEffectList) do
		EffectUtil.destroyEffect(effectUnit)
	end

	BattleTableUtil.clearTable(self._onceEffectList)
end

function BattleUnitCompEffectPlayer:_clearAllLoopEffect()
	for _, effectUnit in pairs(self._loopEffectList) do
		EffectUtil.destroyEffect(effectUnit)
	end

	BattleTableUtil.clearTable(self._loopEffectList)
end

function BattleUnitCompEffectPlayer:_updateSpeed()
	for _, effectUnit in pairs(self._onceEffectList) do
		effectUnit.main:setPlaySpeed(self._timeScale)
	end

	for _, effectUnit in pairs(self._loopEffectList) do
		effectUnit.main:setPlaySpeed(self._timeScale)
	end
end

function BattleUnitCompEffectPlayer:_playPermanentEffect()
	if self._unit.meshModel:getInst() then
		local effectCode

		if self._unit.property:getMonsterType() == BattleEnum.MonsterType.ELITE then
			effectCode = BattleConst.ELITE_ENEMY_EFFECT
		end

		local entityCode = self._unit.property:getEntityCode()

		if BattleUnitUtil.isMonster(self._unit) then
			local monsterCO = MonsterConfig.instance:getMonsterCO(entityCode)

			if monsterCO.bodyEffect == "ma_common_body_40002_red" then
				effectCode = BattleConst.BOSS_COVERED_BURN_EFFECT
			end
		end

		if effectCode then
			local effectUnit = self:playLoopEffect(effectCode, false)

			self:_tryAddResLoadedListener(effectCode, effectUnit)
			self._unit.modelMountFollow:addFollowGO(MeshModelMount.Foot, effectUnit.mainGO, 0, 1, 0)
		end
	end
end

function BattleUnitCompEffectPlayer:_adjustAllLoopEffectPositionAndScale()
	for _, effectUnit in pairs(self._loopEffectList) do
		local effectCode = effectUnit.main:getEffectCode()

		self:_adjustEffectPositionAndScale(effectUnit, effectCode)
	end
end

function BattleUnitCompEffectPlayer:_onMeshModelLoaded()
	self:_playPermanentEffect()
	self:_adjustAllLoopEffectPositionAndScale()
end

function BattleUnitCompEffectPlayer:_tryAddResLoadedListener(effectCode, effectUnit)
	local effectCO = EffectConfig.instance:getEffectCO(effectCode)

	if not effectCO then
		return false
	end

	if effectCO.attachToMesh == 1 then
		local effectGo = effectUnit.loader:getInst()

		if effectGo then
			self:_onAttachEffectResLoaded(effectGo)
		else
			effectUnit.loader:setListener(self._onAttachEffectResLoaded, self)
		end
	end
end

function BattleUnitCompEffectPlayer:_onAttachEffectResLoaded(effectGo)
	local bodyGo = self._unit.meshModel:getBodyGo()

	if bodyGo then
		local bodyMesh = bodyGo:GetComponent("SkinnedMeshRenderer")

		if bodyMesh then
			SpaceX.ParticleUtils.BindShapeSkinMeshRender(effectGo, bodyMesh)

			bodyMesh.updateWhenOffscreen = true
			self._bodyMesh = bodyMesh

			settimer(0, self._closeUpdateWhenOffScreen, self, false)
		end
	end
end

function BattleUnitCompEffectPlayer:_closeUpdateWhenOffScreen()
	if self._bodyMesh then
		self._bodyMesh.updateWhenOffscreen = false
		self._bodyMesh = false
	end
end

function BattleUnitCompEffectPlayer:_onBodyClear()
	if self._bodyMesh then
		self._bodyMesh = false

		removetimer(self._closeUpdateWhenOffScreen, self)
	end
end

function BattleUnitCompEffectPlayer:switchEffectWithModelUpdate(isHighModel)
	local effectUnit = self:_getLoopEffect(BattleConst.ELITE_ENEMY_EFFECT)

	effectUnit = effectUnit or self:_getLoopEffect(BattleConst.BOSS_COVERED_BURN_EFFECT)

	if effectUnit then
		local effectGo = effectUnit.loader:getInst()
		local effectSmokeGo = goutil.findChild(effectGo, "set/smoke")

		if isHighModel then
			SpaceX.ParticleUtils.SetScalingModel(effectSmokeGo, UnityEngine.ParticleSystemScalingMode.Local)
			SpaceX.ParticleUtils.SetStartSizeConst(effectSmokeGo, 0.7, 1)
		else
			SpaceX.ParticleUtils.SetScalingModel(effectSmokeGo, UnityEngine.ParticleSystemScalingMode.Hierarchy)
			SpaceX.ParticleUtils.SetStartSizeConst(effectSmokeGo, 1.8, 1.5)
		end
	end
end

function BattleUnitCompEffectPlayer:delayShowEliteAndBossEffect()
	local effectUnit = self:_getLoopEffect(BattleConst.ELITE_ENEMY_EFFECT)

	effectUnit = effectUnit or self:_getLoopEffect(BattleConst.BOSS_COVERED_BURN_EFFECT)

	if effectUnit then
		effectUnit.main:delayShowEffect(0.3)
	end
end

return BattleUnitCompEffectPlayer
