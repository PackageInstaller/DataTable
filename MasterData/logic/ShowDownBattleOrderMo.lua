-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/data/ShowDownBattleOrderMo.lua

module("logic.extensions.showdown.data.ShowDownBattleOrderMo", package.seeall)

local ShowDownBattleOrderMo = class("ShowDownBattleOrderMo")

function ShowDownBattleOrderMo:ctor()
	self._roundId = 0
	self._formAdjustMos = {}
	self._teamIds = {}
end

function ShowDownBattleOrderMo:onReset()
	self._roundId = 0

	for _, formAdjustMo in pairs(self._formAdjustMos) do
		formAdjustMo:onReset()
	end

	table.clear(self._teamIds)
end

function ShowDownBattleOrderMo:updateData(value)
	self._roundId = value.roundId

	local myTeamId = value.teamId
	local enemyTeamId = value.enemyTeamId

	self._teamIds[GameEnum.BattleTeam.Left] = myTeamId
	self._teamIds[GameEnum.BattleTeam.Right] = enemyTeamId

	if self._formAdjustMos[myTeamId] == nil then
		self._formAdjustMos[myTeamId] = ShowDownFormAdjustMo.New()
	end

	if self._formAdjustMos[enemyTeamId] == nil then
		self._formAdjustMos[enemyTeamId] = ShowDownFormAdjustMo.New()
	end

	self._formAdjustMos[myTeamId]:updateData(value.mySideFormList)
	self._formAdjustMos[enemyTeamId]:updateData(value.enemyFormList)
end

function ShowDownBattleOrderMo:getTeamId(battleTeam)
	return self._teamIds[battleTeam]
end

function ShowDownBattleOrderMo:getFormAdjustMo(teamId)
	return self._formAdjustMos[teamId]
end

function ShowDownBattleOrderMo:getForm(teamId, userId)
	local formAdjustMo = self:getFormAdjustMo(teamId)

	return formAdjustMo:getForm(userId)
end

function ShowDownBattleOrderMo:getUserIdList(teamId)
	local formAdjustMo = self:getFormAdjustMo(teamId)

	return formAdjustMo:getUserIdList()
end

function ShowDownBattleOrderMo:getUserId(teamId, index)
	local list = self:getUserIdList(teamId)

	return list[index]
end

function ShowDownBattleOrderMo:getIndexInUserId(teamId, userId)
	local formAdjustMo = self:getFormAdjustMo(teamId)

	return formAdjustMo:getIndexInUserId(userId)
end

function ShowDownBattleOrderMo:setUserIdList(teamId, userIdList)
	local formAdjustMo = self:getFormAdjustMo(teamId)

	return formAdjustMo:setUserIdList(userIdList)
end

return ShowDownBattleOrderMo
