-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/data/ShowDownMainRaceInfoMo.lua

module("logic.extensions.showdown.data.ShowDownMainRaceInfoMo", package.seeall)

local ShowDownMainRaceInfoMo = class("ShowDownMainRaceInfoMo")

function ShowDownMainRaceInfoMo:ctor()
	self._isHasApply = false
	self._isHasSendEnlistEver = false
	self._myTeamId = -1
	self._isLeader = false
	self._teamIdLists = {}
	self._teamSimpleViewMoDics = {}
	self._teamSimpleViewMoLists = {}
	self._teamResultDic = {}
end

function ShowDownMainRaceInfoMo:onReset()
	self._isHasApply = false
	self._isHasSendEnlistEver = false

	self:setMyTeamId(-1)

	self._isLeader = false

	table.clear(self._teamIdLists)
	table.clear(self._teamSimpleViewMoDics)
	table.clear(self._teamSimpleViewMoLists)
end

function ShowDownMainRaceInfoMo:updateDataOfTeamList(groupId, value)
	self._teamIdLists[groupId] = {}
	self._teamSimpleViewMoDics[groupId] = {}
	self._teamResultDic[groupId] = {}

	for i, v in ipairs(value) do
		local mo = ShowDownTeamSimpleViewMo.New()

		mo:updateData(v)

		local teamId = mo:getTeamId()

		if self._teamSimpleViewMoDics[groupId][teamId] ~= nil then
			self._teamResultDic[groupId][teamId] = true
		else
			table.insert(self._teamIdLists[groupId], teamId)
		end

		self._teamSimpleViewMoDics[groupId][teamId] = mo
	end
end

function ShowDownMainRaceInfoMo:getTeamIdListInGroup(groupId)
	return self._teamIdLists[groupId] or {}
end

function ShowDownMainRaceInfoMo:getTeamSimpleViewMoList(groupId)
	local teamSimpleViewMoList = {}
	local teamIdList = self:getTeamIdListInGroup(groupId)

	for _, teamId in ipairs(teamIdList) do
		table.insert(teamSimpleViewMoList, self._teamSimpleViewMoDics[groupId][teamId])
	end

	return teamSimpleViewMoList
end

function ShowDownMainRaceInfoMo:getTeamSimpleViewMo(groupId, teamId)
	return self._teamSimpleViewMoDics[groupId][teamId]
end

function ShowDownMainRaceInfoMo:isWinTeam(groupId, teamId)
	if self._teamResultDic[groupId] and self._teamResultDic[groupId][teamId] then
		return true
	end

	return false
end

function ShowDownMainRaceInfoMo:isTheTeamInTheGroup(groupId, teamId)
	local mo = self:getTeamSimpleViewMo(groupId, teamId)

	return mo ~= nil
end

function ShowDownMainRaceInfoMo:isHasApply()
	return self._isHasApply
end

function ShowDownMainRaceInfoMo:setIsHasApply(value)
	self._isHasApply = checkbool(value)
end

function ShowDownMainRaceInfoMo:isHasSendEnlistEver()
	return self._isHasSendEnlistEver
end

function ShowDownMainRaceInfoMo:setIsHasSendEnlistEver(value)
	self._isHasSendEnlistEver = checkbool(value)
end

function ShowDownMainRaceInfoMo:getMyTeamId()
	return self._myTeamId
end

function ShowDownMainRaceInfoMo:setMyTeamId(value)
	self._myTeamId = checknumber(value)
end

function ShowDownMainRaceInfoMo:isLeader()
	return self._isLeader
end

function ShowDownMainRaceInfoMo:setIsLeader(value)
	self._isLeader = checkbool(value)
end

function ShowDownMainRaceInfoMo:isPromotionGroup()
	local teamId = self:getMyTeamId()

	return teamId >= 0
end

function ShowDownMainRaceInfoMo:getMyGroupId()
	local myGroupId = -1

	for groupId, teamIdList in pairs(self._teamIdLists) do
		for _, teamId in pairs(teamIdList) do
			if self._myTeamId == teamId and teamId > 0 then
				myGroupId = groupId

				break
			end
		end

		if myGroupId > -1 then
			break
		end
	end

	return myGroupId
end

return ShowDownMainRaceInfoMo
