-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/team/TeamList.lua

require("dm.gameplay.develop.model.team.Team")

TeamList = class("TeamList", objectlua.Object, _M)

function TeamList:initialize(player)
	self._player = player
	self._activeTeam = nil
	self._teamList = {}
	self._stageTeamIds = {}
	self._spTeamList = {}
end

function TeamList:synchronize(data)
	for id, teamData in pairs(data) do
		local teamId = tonumber(id) + 1

		if self._teamList[teamId] then
			self._teamList[teamId]:synchronize(teamData)
		else
			self._teamList[teamId] = Team:new({
				teamId = teamId
			})

			self._teamList[teamId]:synchronize(teamData)
		end
	end

	table.sort(self._teamList, function(a, b)
		return a:getId() < b:getId()
	end)
end

function TeamList:synchronizeTeamTypes(data)
	for stageType, teamId in pairs(data) do
		self._stageTeamIds[stageType] = teamId
	end
end

function TeamList:synchronizeSpTeams(data)
	for key, teamType in pairs(StageTeamType) do
		if data[teamType] then
			if self._spTeamList[teamType] then
				self._spTeamList[teamType]:synchronize(data[teamType])
			else
				self._spTeamList[teamType] = Team:new({
					teamType = teamType
				})

				self._spTeamList[teamType]:synchronize(data[teamType])
			end
		end
	end
end

function TeamList:getAllTeams()
	return self._teamList
end

function TeamList:getTeam(teamId)
	return self._teamList[tonumber(teamId)]
end

function TeamList:getStageTeamIds()
	return self._stageTeamIds
end

function TeamList:getSpTeam(teamType)
	return self._spTeamList[teamType] or {}
end
