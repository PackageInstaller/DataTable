-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/global/MainSceneHeroFactory.lua

module("logic.extensions.mainui.scene.global.MainSceneHeroFactory", package.seeall)

local M = class("MainSceneHeroFactory", ISceneFlowComp)

function M:ctor(flow)
	M.super.ctor(self, flow)

	self._units = {}

	self:initCreateDefine()
end

function M:onInit(sceneInfo)
	M.super.onInit(self, sceneInfo)
end

function M:initCreateDefine()
	self._unitDefine = {
		[UnitTag.Player] = {
			class = UnitMainSceneAdjutant,
			creator = M._createUnitAdjutant
		},
		[UnitTag.Npc] = {
			class = UnitMainSceneNpc,
			creator = M._createUnitNpc
		},
		Tmp = {
			class = UnitMainSceneTmpHero,
			creator = M.createTmpHero
		}
	}
end

function M:onEnter()
	return
end

function M:onSceneLoadDone()
	return
end

function M:onEnterDone()
	return
end

function M:onExit()
	self:removeAll()
end

function M:onExitDone()
	return
end

function M:onLeaveScene()
	self:removeAll()
end

function M:onReturnScene()
	return
end

function M:onReturnSceneFinished()
	return
end

function M:removeAll()
	for k, v in pairs(self._units or {}) do
		local sameUnits = v

		for k2, unit in pairs(sameUnits) do
			unit:returnSelf()

			sameUnits[k2] = nil
		end
	end

	self._units = {}
end

function M:getContainer()
	return nil
end

function M:addUnit(unit, unitTag)
	local container = self:getContainer()

	if not container or goutil.isNil(container) then
		printError("no container")
	else
		goutil.addChildToParent(unit.go, self:getContainer())
	end

	local tag = unitTag

	if not self._units then
		self._units = {}
	end

	if not self._units[tag] then
		self._units[tag] = {}
	end

	self._units[tag][unit:getHeroId()] = unit
end

function M:getUnits(unitTag)
	if self._units then
		return self._units[unitTag] or {}
	end

	return {}
end

function M:getUnitsCount(unitTag)
	local map = self:getUnits(unitTag)
	local len = 0

	for heroId, unit in pairs(map) do
		len = len + 1
	end

	return len
end

function M:getUnitHero(unitTag, heroId)
	if not heroId then
		printWarn("请传入heroId", debug.traceback())

		return nil
	end

	heroId = tonumber(heroId)

	local tag = unitTag
	local tagUnits = self:getUnits(tag)
	local theUnit

	for _heroId, _unit in pairs(tagUnits) do
		if _heroId == heroId then
			theUnit = _unit
		end
	end

	return theUnit
end

function M:getUnitHeroCustom(unitTag, funcCheck, funcHandler)
	if not funcCheck then
		return
	end

	local theUnit
	local tagUnits = self:getUnits(unitTag)

	for _, _unit in pairs(tagUnits) do
		if not theUnit then
			if funcHandler then
				if funcCheck(funcHandler, _unit) then
					theUnit = _unit
				end
			elseif funcCheck(_unit) then
				theUnit = _unit
			end
		end
	end

	return theUnit
end

function M:removeUnitByTag(unitTag)
	local removeMap = {}

	for _heroId, _unit in pairs(self._units[unitTag] or {}) do
		if _unit then
			removeMap[_heroId] = 1

			_unit:returnSelf()
		end
	end

	for _heroId, _ in pairs(removeMap) do
		self._units[unitTag][_heroId] = nil
	end

	removeMap = nil
end

function M:removeUnitHero(unitTag, heroId)
	if not heroId then
		printWarn("请传入heroId")

		return nil
	end

	if not self._units[unitTag] then
		return
	end

	heroId = tonumber(heroId)

	local removeMap = {}

	for _heroId, _unit in pairs(self._units[unitTag] or {}) do
		if _unit and _heroId == heroId then
			removeMap[_heroId] = 1

			_unit:returnSelf()
		end
	end

	for _heroId, _ in pairs(removeMap) do
		self._units[unitTag][_heroId] = nil
	end

	removeMap = nil
end

function M:removeUnitHeroCustom(unitTag, funcCheck, funcHandler)
	if not funcCheck then
		return
	end

	local removeMap = {}
	local tagUnits = self:getUnits(unitTag)

	for _heroId, _unit in pairs(tagUnits) do
		if _unit then
			if funcHandler then
				if funcCheck(funcHandler, _unit) then
					removeMap[_heroId] = 1

					_unit:returnSelf()
				end
			elseif funcCheck(_unit) then
				removeMap[_heroId] = 1

				_unit:returnSelf()
			end
		end
	end

	for _heroId, _ in pairs(removeMap) do
		self._units[unitTag][_heroId] = nil
	end

	removeMap = nil
end

function M:createUnit(unitTag, entityInfo)
	local defineInfo = self._unitDefine[unitTag]

	if defineInfo then
		local theUnit = self:getUnitHero(unitTag, entityInfo.entityCode)

		if theUnit then
			return theUnit
		end

		local unit = defineInfo.creator(self, unitTag, entityInfo, defineInfo)

		if unit then
			self:addUnit(unit, unitTag)

			return unit
		end
	end

	return nil
end

function M:_createBaseUnit(unitTag, entityInfo, defineInfo)
	local heroId = tonumber(entityInfo.entityCode)
	local skinId = entityInfo.skinId
	local modelId = CharacterUtil.getModelId(heroId, skinId)
	local modelData = ModelConfig.instance:getModelData(modelId)

	if not modelData then
		printError(string.format("无法找到model[%s]的配置,heroId[%s],skinId[%s]", modelId, heroId, skinId))

		return nil
	end

	local goName = unitTag .. "_" .. heroId .. "_" .. entityInfo.point
	local pos = entityInfo.pos or {}
	local rotate = entityInfo.rotate or {}
	local scale = entityInfo.scale or {}
	local unit = defineInfo.class:createInstance(goName, pos.x or 0, pos.y or 0, pos.z or 0)

	Astral.TransformUtil.SetLocalRotation(unit:getTransform(), rotate.x or 0, rotate.y or 0, rotate.z or 0)
	Astral.TransformUtil.SetLocalScale(unit:getTransform(), scale.x or 1, scale.y or 1, scale.z or 1)

	unit.id = heroId

	unit:setHeroId(heroId)
	unit:setModelId(modelId)
	unit:setSkinId(skinId)

	if unit.setPointId then
		unit:setPointId(entityInfo.point)
	end

	if unit.setElementId then
		unit:setElementId(entityInfo.elementId)
	end

	if unit.animClip then
		unit.animClip:setAnimLoadList(entityInfo.loadAnimList)
	end

	if unit.animCtrl then
		unit.animCtrl:setAnimStepStr(entityInfo.animStepStr)
	end

	if unit.changeEff then
		unit.changeEff:setBlockChangeEff(entityInfo.blockChangeEff)
	end

	if unit.materialComp then
		unit.materialComp:setBlockChangeEff(entityInfo.blockChangeEff)
	end

	local resPaths = {}

	table.insert(resPaths, {
		typ = MainPerformEnum.ResTyp.Model,
		path = modelData:getMainModelResPath()
	})
	table.insert(resPaths, {
		typ = MainPerformEnum.ResTyp.Timeline,
		path = modelData:getMainTimelinePath()
	})
	table.insert(resPaths, {
		typ = MainPerformEnum.ResTyp.Item,
		path = MainScenePerformUtil.getHeroAnimItemPath(modelId, entityInfo.point)
	})
	table.insert(resPaths, {
		typ = MainPerformEnum.ResTyp.ActivationItem,
		path = MainScenePerformUtil.getHeroActivationItemPathTable(modelId, entityInfo.point)
	})

	return unit, resPaths
end

function M:_createUnitAdjutant(unitTag, entityInfo, defineInfo)
	local unit, resPaths = self:_createBaseUnit(unitTag, entityInfo, defineInfo)

	if unit then
		table.insert(resPaths, {
			typ = MainPerformEnum.ResTyp.ChangeTimeline,
			path = MainScenePerformUtil.getHeroChangeShowTimelinePath(unit:getModelId())
		})
		unit.meshModel:setBody(resPaths, entityInfo)
		unit.meshModel:originRotation(entityInfo.rotate)
		unit.collider:setColliderCenter(-0.1, 0.6, 0)
		unit.collider:setColliderSize(0.7, 1, 0.24)
	end

	return unit
end

function M:_createUnitNpc(unitTag, entityInfo, defineInfo)
	local unit, resPaths = self:_createBaseUnit(unitTag, entityInfo, defineInfo)

	if unit then
		unit.meshModel:setBody(resPaths, entityInfo)
		unit.meshModel:originRotation(entityInfo.rotate)
	end

	return unit
end

function M:createTmpHero(unitTag, entityInfo, defineInfo)
	local pos, angle, scale = entityInfo.pos, entityInfo.angle, entityInfo.scale
	local heroId = entityInfo.heroId
	local skinId = entityInfo.skinId
	local modelId

	if skinId and skinId > 0 then
		local skinCo = HeroSkinConfig.instance:getInfo(skinId)

		if skinCo then
			modelId = skinCo.module
		end
	else
		local entityCO = BattleConfigUtil.getEntityConfig(heroId)

		if entityCO then
			modelId = entityCO.modelId
		else
			printError(string.format("无法找到[%s]的配置", heroId))
		end
	end

	local modelCO = ModelConfig.instance:getModelConfig(modelId)

	if not modelCO then
		printError(string.format("无法找到model[%s]的配置,heroId[%s],skinId[%s]", modelId, heroId, skinId))

		return nil
	end

	local goName = "Tmp_" .. heroId
	local unit = UnitMainSceneTmpHero:createInstance(goName, pos and pos.x or 0, pos and pos.y or 0, pos and pos.z or 0)

	Astral.TransformUtil.SetLocalRotation(unit:getTransform(), angle and angle.x or 0, angle and angle.y or 0, angle and angle.z or 0)
	Astral.TransformUtil.SetLocalScale(unit:getTransform(), scale and scale.x or 1, scale and scale.y or 1, scale and scale.z or 1)
	unit:setHeroId(heroId)
	unit:setSkinId(skinId)
	unit:setPointId(-1)
	unit:setElementId(-1)
	unit:setModelId(modelId)
	unit.animClip:setAnimLoadList({
		entityInfo.defaultAnim
	})
	unit.animCtrl:setAnimStepStr(entityInfo.defaultAnim)

	unit.id = heroId

	local resPaths = {}
	local fakePointId = 0
	local fakeElementId = MainPerformConfig.instance:getHeroElementId(heroId, fakePointId, skinId)

	table.insert(resPaths, {
		typ = MainPerformEnum.ResTyp.Model,
		path = GameUrl.getMainSceneMeshModelUrl(modelCO.mainSceneResName)
	})
	table.insert(resPaths, {
		typ = MainPerformEnum.ResTyp.Timeline,
		path = GameUrl.getMainSceneRoleTimelineUrl(modelCO)
	})
	table.insert(resPaths, {
		typ = MainPerformEnum.ResTyp.Item,
		path = MainScenePerformUtil.getHeroAnimItemPath(modelId, fakePointId)
	})
	table.insert(resPaths, {
		typ = MainPerformEnum.ResTyp.ActivationItem,
		path = MainScenePerformUtil.getHeroActivationItemPathTable(modelId, fakePointId)
	})
	unit.meshModel:setBody(resPaths, entityInfo)

	return unit
end

return M
