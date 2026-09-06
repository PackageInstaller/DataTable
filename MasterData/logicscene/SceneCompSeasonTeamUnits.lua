-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/season/SceneCompSeasonTeamUnits.lua

module("logicscene.scene.component.season.SceneCompSeasonTeamUnits", package.seeall)

local SceneCompSeasonTeamUnits = class("SceneCompSeasonTeamUnits", SceneComponentBase)

function SceneCompSeasonTeamUnits:onEnterScene(sceneId, bornX, bornZ)
	SceneCompSeasonTeamUnits.super.onEnterScene(self, sceneId, bornX, bornZ)
	GlobalDispatcher:addListener(GlobalNotify.SeasonPVEDataUpdated, self._checkInitTeams, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonServerAddTeam, self._checkAddTeams, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonFmtTeamInfo, self._reloadTeams, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonLockTeamStateUpdated, self._reloadTeams, self)
	GlobalDispatcher:addListener(GlobalNotify.ChangeFocusTeam, self._reloadTeams, self)
end

function SceneCompSeasonTeamUnits:onEnterSceneFinished(sceneId, bornX, bornZ)
	self:_checkInitTeams()
end

function SceneCompSeasonTeamUnits:_checkInitTeams()
	self:_checkAddTeams()
end

function SceneCompSeasonTeamUnits:_checkAddTeams()
	local teams = SeasonTeamsModel.instance:getTeams()

	if #teams > 0 and self._scene.stage and self._scene.stage.wholeScene then
		self._teamUnits = self._teamUnits or {}

		for i = 1, #teams do
			local teamMo = teams[i]
			local unit = self:getTeamUnit(teamMo.teamId)
			local serverCurGridX, serverCurGridY = teamMo:getServerCurGridXY()

			if serverCurGridX ~= nil and serverCurGridY ~= nil then
				local x, y = self._scene:getPosWithOffsetY(serverCurGridX, serverCurGridY)

				if unit then
					unit.transform:setPos(x, y - 0.2)
				else
					unit = self._scene.unitFactory:createTeamLeader(teamMo, x, y, 3)

					table.insert(self._teamUnits, unit)
				end
			end
		end

		self:tryDepartTeamsPos()
	end

	local otherTeams = SeasonTeamsModel.instance:getOtherTeams() or {}

	if #otherTeams > 0 and self._scene.stage and self._scene.stage.wholeScene then
		self._teamUnits = self._teamUnits or {}

		for i = 1, #otherTeams do
			local teamMo = otherTeams[i]
			local unit = self:getTeamUnit(teamMo.teamId)
			local serverCurGridX, serverCurGridY = teamMo:getServerCurGridXY()

			if serverCurGridX ~= nil and serverCurGridY ~= nil then
				local x, y = self._scene:getPosWithOffsetY(serverCurGridX, serverCurGridY)

				if unit then
					unit.transform:setPos(x, y - 0.2)
				else
					unit = self._scene.unitFactory:createTeamLeader(teamMo, x, y, 3)

					table.insert(self._teamUnits, unit)
				end
			end
		end

		self:tryDepartTeamsPos()
	end
end

function SceneCompSeasonTeamUnits:tryDepartTeamsPos()
	local teams = SeasonTeamsModel.instance:getTeams()

	if #teams > 0 and self._scene.stage and self._scene.stage.wholeScene then
		local samePosMap = {}

		for i = 1, #teams do
			local teamMo = teams[i]

			if teamMo:getTransportGrid() == nil then
				local unit = self:getTeamUnit(teamMo.teamId)
				local serverCurGridX, serverCurGridY = teamMo:getServerCurGridXY()

				if serverCurGridX ~= nil and serverCurGridY ~= nil then
					local key = serverCurGridX .. "_" .. serverCurGridY

					samePosMap[key] = samePosMap[key] or {}

					table.insert(samePosMap[key], unit)
				end
			end
		end

		local otherTeams = SeasonTeamsModel.instance:getOtherTeams() or {}

		for i = 1, #otherTeams do
			local teamMo = otherTeams[i]

			if teamMo:getTransportGrid() == nil then
				local unit = self:getTeamUnit(teamMo.teamId)
				local serverCurGridX, serverCurGridY = teamMo:getServerCurGridXY()

				if serverCurGridX ~= nil and serverCurGridY ~= nil then
					local key = serverCurGridX .. "_" .. serverCurGridY

					samePosMap[key] = samePosMap[key] or {}

					table.insert(samePosMap[key], unit)
				end
			end
		end

		for k, arr in pairs(samePosMap) do
			local temp = {}

			for i, v in ipairs(arr) do
				table.insert(temp, v)
			end

			ArraySort.sortOn(temp, function(unit)
				if unit.teamData.teamId == SeasonTeamsModel.instance:getCurrTeamId() then
					return -1
				end

				return unit.teamData.teamId
			end)

			local len = #arr
			local helfLen = (len - 1) * 0.5
			local gapX = 1 / len

			for j, unit in ipairs(arr) do
				local offset = (j - helfLen - 1) * gapX
				local idxY = table.indexof(temp, unit)
				local offsetY = (idxY - helfLen - 1) * gapX
				local teamMo = unit.teamData
				local serverCurGridX, serverCurGridY = teamMo:getServerCurGridXY()

				if serverCurGridX ~= nil and serverCurGridY ~= nil then
					local x, y = self._scene:getPosWithOffsetY(serverCurGridX, serverCurGridY)

					unit.transform:setPos(x + offset, y + offsetY * 0.5 - 0.2, 0, true)
				end
			end
		end
	end
end

function SceneCompSeasonTeamUnits:_reloadTeams()
	if self._teamUnits then
		local teams = SeasonTeamsModel.instance:getTeams()

		for i = 1, #teams do
			local teamMo = teams[i]
			local unit = self:getTeamUnit(teamMo.teamId)

			if unit then
				unit.teamData = teamMo

				unit.leaderIcon:setTeamData(teamMo)
			end
		end

		local otherTeams = SeasonTeamsModel.instance:getOtherTeams() or {}

		for i = 1, #otherTeams do
			local teamMo = otherTeams[i]
			local unit = self:getTeamUnit(teamMo.teamId)

			if unit then
				unit.teamData = teamMo

				unit.leaderIcon:setTeamData(teamMo)
			end
		end

		self:tryDepartTeamsPos()
	end
end

function SceneCompSeasonTeamUnits:getTeamUnits()
	return self._teamUnits
end

function SceneCompSeasonTeamUnits:getTeamUnit(teamId)
	if not self._teamUnits then
		return
	end

	for i = 1, #self._teamUnits do
		if self._teamUnits[i].teamData.teamId == teamId then
			return self._teamUnits[i]
		end
	end
end

function SceneCompSeasonTeamUnits:startBossPhase()
	local pevCfg = SeasonConfig.instance:getSeasonPVEConfig(SeasonModel.instance:getSeasonId())
	local doppelgangerPhaseId = checknumber(pevCfg.bossDoppelgangerPhaseId)
	local doppelgangerFinishedPhaseId = doppelgangerPhaseId + 1
	local seasonId = SeasonModel.instance:getSeasonId()
	local phaseConfigs = SeasonConfig.instance:getBossPhaseConfigs(seasonId)

	if not phaseConfigs or not phaseConfigs[doppelgangerFinishedPhaseId] then
		return
	end

	local positions = string.split(phaseConfigs[doppelgangerFinishedPhaseId].positions, ",")

	for i = 1, #positions do
		if not self._teamUnits[i] then
			break
		end

		local position = string.split("_")
		local gridId = checknumber(position[2])
		local row, col = SeasonPathFindingDataModel.instance:id2Grid(gridId)
		local gridUnit = self._scene.gridUnitsMgr:getGridUnit(row, col)

		if gridUnit then
			local posx, posy = gridUnit.transform:getPos()

			self._teamUnits[i].transform:setPos(posx, posy)
		end
	end
end

function SceneCompSeasonTeamUnits:update(deltaTime)
	if not self._teamUnits then
		return
	end

	for i = 1, #self._teamUnits do
		self._teamUnits[i]:update(deltaTime)
	end
end

function SceneCompSeasonTeamUnits:onExitScene()
	GlobalDispatcher:removeListener(GlobalNotify.SeasonPVEDataUpdated, self._checkInitTeams, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonServerAddTeam, self._checkAddTeams, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonFmtTeamInfo, self._reloadTeams, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonLockTeamStateUpdated, self._reloadTeams, self)
	GlobalDispatcher:removeListener(GlobalNotify.ChangeFocusTeam, self._reloadTeams, self)

	self._teamUnits = nil
end

return SceneCompSeasonTeamUnits
