-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/data/ShowDownBattleRecordOneSide.lua

module("logic.extensions.showdown.data.ShowDownBattleRecordOneSide", package.seeall)

local ShowDownBattleRecordOneSide = class("ShowDownBattleRecordOneSide")

function ShowDownBattleRecordOneSide:ctor()
	self._headInfo = nil
	self._score = 0
	self._buffId = 0
	self._teamId = 0
end

function ShowDownBattleRecordOneSide:onReset()
	self._headInfo = nil
	self._score = 0
	self._buffId = 0
	self._teamId = 0
end

function ShowDownBattleRecordOneSide:updateData(value)
	self._headInfo = value.headInfo

	if string.nilorempty(self._headInfo.userName) then
		self._headInfo = RoleModel.instance:getHeadInfo()
	end

	self._score = value.score
	self._buffId = value.buffId
	self._teamId = value.teamId
end

function ShowDownBattleRecordOneSide:getHeadInfo()
	return self._headInfo
end

function ShowDownBattleRecordOneSide:getUserName()
	if self._headInfo then
		return self._headInfo.userName
	end

	return ""
end

function ShowDownBattleRecordOneSide:getScore()
	return self._score
end

function ShowDownBattleRecordOneSide:getBuffId()
	return self._buffId
end

function ShowDownBattleRecordOneSide:getTeamId()
	return self._teamId
end

return ShowDownBattleRecordOneSide
