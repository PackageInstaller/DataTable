-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/team/unit/TeamUnitGenerator.lua

module("logic.extensions.team.unit.TeamUnitGenerator", package.seeall)

local TeamUnitGenerator = {}
local kSceneRoot = SceneMgr.instance:getSceneRoot()
local kUnitsRoot = goutil.create("TeamUnits")

goutil.addChildToParent(kUnitsRoot, kSceneRoot)

function TeamUnitGenerator.getUnitsRoot()
	return kUnitsRoot
end

function TeamUnitGenerator.createUnit(heroMO, index)
	local unit = UnitTeamPlayer:createInstance(heroMO:getId())

	unit.heroId = heroMO:getId()

	local indexstr = index and index or "0"

	unit.go.name = unit.heroId .. "_" .. indexstr

	TeamUnitGenerator.setUnitInfo(unit, heroMO)
	KeepRotationWithFocus.Get(unit.go)
	TeamUnitGenerator.addUnitToScene(unit)

	return unit
end

function TeamUnitGenerator.setUnitInfo(unit, heroMO)
	local modelCO = heroMO:getModelCo()

	unit.meshModel:setBody(GameUrl.getMeshModelUrl(modelCO.resName))
	unit.namebar:setVisible(true)
end

function TeamUnitGenerator.addUnitToScene(unit)
	goutil.addChildToParent(unit.go, kUnitsRoot)
end

function TeamUnitGenerator.destroyUnit(unit)
	if unit.namebar then
		unit.namebar:setVisible(false, true)
	end

	unit:returnSelf()
end

return TeamUnitGenerator
