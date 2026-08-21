-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/mgr/RogueMapGenerator.lua

module("logic.extensions.roguelike.flow.component.mgr.RogueMapGenerator", package.seeall)

local M = {}
local kSceneRoot = SceneMgr.instance:getSceneRoot()
local kMapsRoot = goutil.create("RogueMap")
local kMapsRoot2 = goutil.create("RogueMap2")
local kRolesRoot = goutil.create("RogueRole")

goutil.addChildToParent(kMapsRoot, kSceneRoot)
goutil.addChildToParent(kMapsRoot2, kSceneRoot)
goutil.addChildToParent(kRolesRoot, kSceneRoot)

kMapsRoot.transform.position = Vector3.New(0, 0, 0)
kMapsRoot2.transform.position = Vector3.New(0, 0, 0)
kRolesRoot.transform.position = Vector3.New(0, 0, 0)

function M.getMapsRoot()
	return kMapsRoot
end

function M.getMapsRoot2()
	return kMapsRoot2
end

function M.getRoleRoot()
	return kRolesRoot
end

function M.createMapUnit(idx)
	local unit = RogueMapItem:createInstance(idx)

	M.addUnitToScene(unit)

	return unit
end

function M.createSecondMapUnit(idx)
	local unit = RogueMapItem:createInstance(idx)

	M.addUnitToScene2(unit)

	return unit
end

function M.createMapRole()
	local unit = RogueMapRole:createInstance("Role")

	M.addRoleToScene(unit)

	return unit
end

function M.createMapModel()
	local unit = RogueMapModel:createInstance("Model")

	M.addRoleToScene(unit)

	return unit
end

function M.addUnitToScene(unit)
	goutil.addChildToParent(unit.go, kMapsRoot)
end

function M.addUnitToScene2(unit)
	goutil.addChildToParent(unit.go, kMapsRoot2)
end

function M.addRoleToScene(unit)
	goutil.addChildToParent(unit.go, kRolesRoot)
end

function M.destroyUnit(unit)
	unit:returnSelf()
end

return M
