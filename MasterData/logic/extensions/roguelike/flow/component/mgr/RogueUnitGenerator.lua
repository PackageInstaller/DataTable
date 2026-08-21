-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/mgr/RogueUnitGenerator.lua

module("logic.extensions.roguelike.flow.component.mgr.RogueUnitGenerator", package.seeall)

local M = {}
local kSceneRoot = SceneMgr.instance:getSceneRoot()
local kUnitsRoot = goutil.create("RogueUnits")

goutil.addChildToParent(kUnitsRoot, kSceneRoot)

function M.getUnitsRoot()
	return kUnitsRoot
end

function M.clear()
	goutil.clearChildren(kUnitsRoot)
end

function M.createRoleUnit(entityInfo)
	local unit = RogueRole:createInstance(entityInfo.entityCode)

	M.addUnitToScene(unit)
	M.setRoleInfo(unit, entityInfo)

	return unit
end

function M.createMonsterUnit(entityInfo)
	local unit = RogueMonster:createInstance(entityInfo.entityCode)

	M.addUnitToScene(unit)
	M.setMonsterInfo(unit, entityInfo)

	return unit
end

function M.createEventUnit(eventInfo)
	local unit = RogueEvent:createInstance(eventInfo.eventType)

	M.addUnitToScene(unit)
	M.setEventInfo(unit, eventInfo)

	return unit
end

function M.createPropUnit(entityInfo)
	local unit = RogueProp:createInstance(entityInfo.propId)

	return unit
end

function M.setRoleInfo(unit, entityInfo)
	local roleId = entityInfo.entityCode
	local characterCO = CharacterConfig.instance:getCfgInfoByID(roleId)
	local modelId = characterCO.modelId
	local modelCO = ModelConfig.instance:getModelConfig(modelId)

	unit.meshModel:setBody(GameUrl.getRoguelikeMeshModelUrl(modelCO.rogueResName))
end

function M.setMonsterInfo(unit, entityInfo)
	local monsterId = entityInfo.entityCode
	local monsterCo = RoguelikeConfig.instance:getRoguelikeMonsterById(monsterId)

	if not monsterCo then
		return
	end

	local co = RoguelikeConfig.instance:getRoguelikeMonsterById(entityInfo.entityCode)

	unit.monsterProp:initByConfig(co)
	unit.meshModel:setBody(GameUrl.getRoguelikeMeshModelUrl(monsterCo.spine), true)
	unit.infoBar:setVisible(true)
end

function M.setEventInfo(unit, eventInfo)
	local replyCo = eventInfo.replyCo

	if not replyCo then
		return
	end

	unit.meshModel:setBody(GameUrl.getRoguelikeMeshModelUrl("shijian"), true)
end

function M.addUnitToScene(unit)
	goutil.addChildToParent(unit.go, kUnitsRoot)
end

function M.destroyUnit(unit)
	unit:destroy()
end

return M
