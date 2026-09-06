-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/factory/SeasonTilingSceneUnitFactory.lua

module("logicscene.scene.component.factory.SeasonTilingSceneUnitFactory", package.seeall)

local SeasonTilingSceneUnitFactory = class("SeasonTilingSceneUnitFactory", CityUnitFactory)

function SeasonTilingSceneUnitFactory:createTeamLeader(teamData, posx, posy, speed)
	local insId = self:generateObjectInstanceId()
	local resPath = SeasonTeamsModel.instance:getTeamSceneResPath(teamData)

	self._scene.stage.wholeScene:CreateCommonObject(UnitTag.Player, insId, teamData.leaderSkinId, resPath, posx, posy, 2, 2, 1, speed > 0, "sts_team_leader", 0)

	local unit = self:getUnit(UnitTag.Player, insId)

	unit.teamData = teamData

	unit.transform:setMoveSpeed(speed)
	unit.syncPos:syncPos()
	unit.leaderIcon:setTeamData(teamData)

	return unit
end

function SeasonTilingSceneUnitFactory:destroyTeamLeader(insId)
	self:destroyCommonObject(UnitTag.Player, insId)
end

function SeasonTilingSceneUnitFactory:createCustomSeasonUnit(itemId, resPath, posx, posy)
	local insId = self:generateObjectInstanceId()

	self._scene.stage.wholeScene:CreateCommonObject(UnitTag.Untagged, insId, itemId, resPath, posx, posy, 2, 2, 1, false, "sts_custom_unit", 0)

	local unit = self:getUnit(UnitTag.Untagged, insId)

	unit.itemId = itemId

	unit.transform:setMoveSpeed(0)

	return unit
end

function SeasonTilingSceneUnitFactory:destroyCustomSeasonUnit(insId)
	self:destroyCommonObject(UnitTag.Untagged, insId)
end

function SeasonTilingSceneUnitFactory:createCommonObjectUnit(tag, insId, itemId, usrData)
	if usrData == "sts_team_leader" then
		local unitGo = goutil.create("leader_" .. insId, false)
		local unit = UnitSeasonTeamLeader.New(unitGo)

		unit.scene = self._scene
		unit.radius = 1
		unit.id = insId
		unit.leaderSkinId = itemId
		unit.userData = usrData

		unit:Awake()
		self:addUnit(unit)

		return unit
	end

	if usrData == "sts_custom_unit" then
		local unitGo = goutil.create("custom_" .. insId, false)
		local unit = UnitSeasonCustom.New(unitGo)

		unit.scene = self._scene
		unit.radius = 1
		unit.id = insId

		unit:Awake()
		self:addUnit(unit)

		return unit
	end

	return SeasonTilingSceneUnitFactory.super.createCommonObjectUnit(self, tag, insId, itemId, usrData)
end

function SeasonTilingSceneUnitFactory:createGridUnit(elementId, row, col)
	local unitGo = goutil.create("grid_unit_" .. elementId .. "_" .. row .. "_" .. col, false)
	local unit = UnitSeasonGrid.New(unitGo)

	unit.scene = self._scene
	unit.radius = 1
	unit.row = row
	unit.col = col
	unit.id = elementId

	unit:Awake()
	self:addUnit(unit)

	return unit
end

function SeasonTilingSceneUnitFactory:createGridElem(elementId, row, col)
	local unitGo = goutil.create("grid_elem_" .. elementId .. "_" .. row .. "_" .. col, false)
	local unit = UnitSeasonGridElem.New(unitGo)

	unit.scene = self._scene
	unit.radius = 1
	unit.id = elementId
	unit.row = row
	unit.col = col

	unit:Awake()
	self:addUnit(unit)

	return unit
end

function SeasonTilingSceneUnitFactory:createGridEvent(elementId, row, col)
	local unitGo = goutil.create("grid_event_" .. elementId .. "_" .. row .. "_" .. col, false)
	local unit = UnitSeasonGridEvent.New(unitGo)

	unit.scene = self._scene
	unit.radius = 1
	unit.id = elementId
	unit.row = row
	unit.col = col

	unit:Awake()
	self:addUnit(unit)

	return unit
end

function SeasonTilingSceneUnitFactory:createGridFog(elementId, row, col)
	local unitGo = goutil.create("grid_fog_" .. elementId .. "_" .. row .. "_" .. col, false)
	local unit = UnitSeasonGridFog.New(unitGo)

	unit.scene = self._scene
	unit.radius = 1
	unit.id = elementId
	unit.row = row
	unit.col = col

	unit:Awake()
	self:addUnit(unit)

	return unit
end

return SeasonTilingSceneUnitFactory
