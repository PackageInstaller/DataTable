-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/data/ShowDownMainRaceInfoMoInFinal.lua

module("logic.extensions.showdown.data.ShowDownMainRaceInfoMoInFinal", package.seeall)

local ShowDownMainRaceInfoMoInFinal = class("ShowDownMainRaceInfoMoInFinal")

function ShowDownMainRaceInfoMoInFinal:ctor()
	self._teamIdLists = {}
	self._teamSimpleViewMoDics = {}
	self._pairTeamIds = {}
	self._winTeamIds = {}
end

function ShowDownMainRaceInfoMoInFinal:onReset()
	table.clear(self._teamIdLists)
	table.clear(self._teamSimpleViewMoDics)
end

function ShowDownMainRaceInfoMoInFinal:updateDataOfRoundInfoList(groupId, value)
	if self._teamIdLists[groupId] == nil then
		self._teamIdLists[groupId] = {}
	end

	table.clear(self._teamIdLists[groupId])

	if self._teamSimpleViewMoDics[groupId] == nil then
		self._teamSimpleViewMoDics[groupId] = {}
	end

	table.clear(self._teamSimpleViewMoDics[groupId])

	self._pairTeamIds[groupId] = {}
	self._winTeamIds[groupId] = {}

	for pairIndex, roundInfo in ipairs(value) do
		self._pairTeamIds[groupId][pairIndex] = {}

		local teamSimpleViewList = {
			roundInfo.teamAView,
			roundInfo.teamBView
		}

		for idx, teamSimpleView in ipairs(teamSimpleViewList) do
			local mo = ShowDownTeamSimpleViewMo.New()

			mo:updateData(teamSimpleView)

			local teamId = mo:getTeamId()

			self._teamSimpleViewMoDics[groupId][teamId] = mo

			table.insert(self._teamIdLists[groupId], teamId)

			self._pairTeamIds[groupId][pairIndex][idx] = teamId
		end

		if roundInfo:HasField("winTeamId") then
			self._winTeamIds[groupId][roundInfo.winTeamId] = true
		end
	end
end

function ShowDownMainRaceInfoMoInFinal:getPairTeamIdListInGroup(groupId)
	return self._pairTeamIds[groupId] or {}
end

function ShowDownMainRaceInfoMoInFinal:getTeamIdListInGroup(groupId)
	return self._teamIdLists[groupId] or {}
end

function ShowDownMainRaceInfoMoInFinal:getTeamSimpleViewMoList(groupId)
	local teamSimpleViewMoList = {}
	local teamIdList = self:getTeamIdListInGroup(groupId)

	for _, teamId in ipairs(teamIdList) do
		table.insert(teamSimpleViewMoList, self._teamSimpleViewMoDics[groupId][teamId])
	end

	return teamSimpleViewMoList
end

function ShowDownMainRaceInfoMoInFinal:getTeamSimpleViewMo(groupId, teamId)
	return self._teamSimpleViewMoDics[groupId][teamId]
end

function ShowDownMainRaceInfoMoInFinal:isTheTeamInTheGroup(groupId, teamId)
	local mo = self:getTeamSimpleViewMo(groupId, teamId)

	return mo ~= nil
end

function ShowDownMainRaceInfoMoInFinal:isWin(groupId, teamId)
	return (self._winTeamIds[groupId] or nil) and (self._winTeamIds[groupId][teamId] or false)
end

return ShowDownMainRaceInfoMoInFinal
