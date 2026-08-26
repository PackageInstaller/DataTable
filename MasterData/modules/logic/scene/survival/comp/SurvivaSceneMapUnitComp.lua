-- chunkname: @modules/logic/scene/survival/comp/SurvivaSceneMapUnitComp.lua

module("modules.logic.scene.survival.comp.SurvivaSceneMapUnitComp", package.seeall)

local SurvivaSceneMapUnitComp = class("SurvivaSceneMapUnitComp", BaseSceneComp)

function SurvivaSceneMapUnitComp:onScenePrepared(sceneId, levelId)
	self._sceneGo = self:getCurScene().level:getSceneGo()
	self._unitRoot = gohelper.create3d(self._sceneGo, "UnitRoot")
	self._allUnits = {}

	local mapSceneMo = SurvivalMapModel.instance:getSceneMo()

	if not mapSceneMo then
		return
	end

	self:addEvents()

	self._player = SurvivalPlayerEntity.Create(mapSceneMo.player, self._unitRoot)

	SurvivalMapHelper.instance:addEntity(0, self._player)

	for id, unitMo in pairs(mapSceneMo.unitsById) do
		self._allUnits[id] = SurvivalUnitEntity.Create(unitMo, self._unitRoot)

		SurvivalMapHelper.instance:addEntity(id, self._allUnits[id])

		local warmingRange = unitMo:getWarmingRange()

		if warmingRange then
			self:_showEffect(unitMo.id, unitMo.pos, warmingRange)
		end
	end
end

function SurvivaSceneMapUnitComp:addEvents()
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapUnitAdd, self._onUnitAdd, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapUnitPosChange, self._onUnitPosChange, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapUnitChange, self._onUnitChange, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapUnitDel, self._onUnitDel, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnRoleDateChange, self._onRoleDateChange, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapDestoryPosAdd, self.onMapDestoryPosAdd, self)
end

function SurvivaSceneMapUnitComp:removeEvents()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapUnitAdd, self._onUnitAdd, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapUnitPosChange, self._onUnitPosChange, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapUnitChange, self._onUnitChange, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapUnitDel, self._onUnitDel, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnRoleDateChange, self._onRoleDateChange, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapDestoryPosAdd, self.onMapDestoryPosAdd, self)
end

function SurvivaSceneMapUnitComp:_onRoleDateChange()
	local mapSceneMo = SurvivalMapModel.instance:getSceneMo()

	if not mapSceneMo then
		return
	end

	for id, unitMo in pairs(mapSceneMo.unitsById) do
		if not unitMo:getWarmingRange() then
			SurvivalMapHelper.instance:getScene().pointEffect:clearPointsByKey(unitMo.id)
		end
	end
end

function SurvivaSceneMapUnitComp:onMapDestoryPosAdd()
	local mapSceneMo = SurvivalMapModel.instance:getSceneMo()

	if not mapSceneMo then
		return
	end

	for id, unitMo in pairs(mapSceneMo.unitsById) do
		local warmingRange = unitMo:getWarmingRange()

		if warmingRange then
			self:_showEffect(unitMo.id, unitMo.pos, warmingRange)
		end
	end
end

function SurvivaSceneMapUnitComp:_onUnitDel(unitMo, isPlayDeadAnim)
	if self._allUnits[unitMo.id] then
		local warmingRange = unitMo:getWarmingRange()

		if warmingRange then
			SurvivalMapHelper.instance:getScene().pointEffect:clearPointsByKey(unitMo.id)
		end

		self._allUnits[unitMo.id]:tryRemove(isPlayDeadAnim)

		self._allUnits[unitMo.id] = nil
	end
end

function SurvivaSceneMapUnitComp:_onUnitAdd(unitMo)
	if not self._allUnits[unitMo.id] then
		local warmingRange = unitMo:getWarmingRange()

		if warmingRange then
			self:_showEffect(unitMo.id, unitMo.pos, warmingRange)
		end

		self._allUnits[unitMo.id] = SurvivalUnitEntity.Create(unitMo, self._unitRoot)

		SurvivalMapHelper.instance:addEntity(unitMo.id, self._allUnits[unitMo.id])
	end
end

function SurvivaSceneMapUnitComp:_onUnitPosChange(_, unitMo, isDel)
	if unitMo.visionVal == 8 or isDel then
		return
	end

	local warmingRange = unitMo:getWarmingRange()

	if warmingRange then
		SurvivalMapHelper.instance:getScene().pointEffect:clearPointsByKey(unitMo.id)
		self:_showEffect(unitMo.id, unitMo.pos, warmingRange)
	end

	if SurvivalMapHelper.instance:isPetrifactionTar(unitMo) then
		local sceneMo = SurvivalMapModel.instance:getSceneMo()
		local blockType = sceneMo:getBlockTypeByPos(unitMo.pos)

		if blockType and blockType == SurvivalEnum.UnitSubType.Petrifaction then
			SurvivalController.instance:dispatchEvent(SurvivalEvent.ShowUnitBubble, unitMo.id, 1, 0)
		else
			SurvivalController.instance:dispatchEvent(SurvivalEvent.HideUnitBubble, unitMo.id, 1, 0)
		end
	end
end

function SurvivaSceneMapUnitComp:_onUnitChange(unitId)
	local unitMo = SurvivalMapModel.instance:getSceneMo().unitsById[unitId]

	if not unitMo then
		return
	end

	SurvivalMapHelper.instance:getScene().pointEffect:clearPointsByKey(unitId)

	local warmingRange = unitMo:getWarmingRange()

	if warmingRange and unitMo.visionVal ~= 8 then
		self:_showEffect(unitMo.id, unitMo.pos, warmingRange)
	end
end

function SurvivaSceneMapUnitComp:_showEffect(id, pos, range)
	local walkablePos = SurvivalMapModel.instance:getCurMapCo().walkables

	for i, v in ipairs(SurvivalHelper.instance:getAllPointsByDis(pos, range)) do
		if SurvivalHelper.instance:getValueFromDict(walkablePos, v) then
			SurvivalMapHelper.instance:getScene().pointEffect:setPointEffectType(id, v.q, v.r, 1)
		end
	end
end

function SurvivaSceneMapUnitComp:onSceneClose()
	self:removeEvents()
	gohelper.destroy(self._unitRoot)

	self._unitRoot = nil
	self._sceneGo = nil
	self._allUnits = {}
end

return SurvivaSceneMapUnitComp
