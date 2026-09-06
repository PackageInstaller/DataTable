-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/data/ShowDownBattleRecord.lua

module("logic.extensions.showdown.data.ShowDownBattleRecord", package.seeall)

local ShowDownBattleRecord = class("ShowDownBattleRecord")

function ShowDownBattleRecord:ctor()
	self._result = ShowDownEnum.BattleRecordResult_Fail
	self._teamRecords = {}

	for _, teamId in ipairs(GameEnum.BattleTeamList) do
		self._teamRecords[teamId] = ShowDownBattleRecordOneSide.New()
	end

	self._battleId = 0
	self._recordTimeMillis = 0
	self._recordTimeStamp = 0
	self._shelfLife = 604800
	self._qualType = ShowDownEnum.QualType_Normal
end

function ShowDownBattleRecord:onReset()
	self._result = ShowDownEnum.BattleRecordResult_Fail

	for k, v in pairs(self._teamRecords) do
		v:onReset()
	end

	self._battleId = 0
	self._recordTimeMillis = 0
	self._recordTimeStamp = 0
	self._qualType = ShowDownEnum.QualType_Normal
end

function ShowDownBattleRecord:updateData(value)
	self._result = value.result

	local list

	if value.right.headInfo == nil or string.nilorempty(value.right.headInfo.userName) then
		list = {
			value.right,
			value.left
		}

		if self._result == ShowDownEnum.BattleRecordResult_Win then
			self._result = ShowDownEnum.BattleRecordResult_Fail
		elseif self._result == ShowDownEnum.BattleRecordResult_Fail then
			self._result = ShowDownEnum.BattleRecordResult_Win
		end
	else
		list = {
			value.left,
			value.right
		}
	end

	for i, v in ipairs(list) do
		local teamId = GameEnum.BattleTeamList[i]

		self._teamRecords[teamId]:updateData(v)
	end

	self._battleId = value.battleId
	self._recordTimeMillis = value.recordTimeMillis
	self._recordTimeStamp = checknumber(value.recordTimeMillis) / 1000
	self._qualType = value.type
end

function ShowDownBattleRecord:getResult()
	return self._result
end

function ShowDownBattleRecord:isWin(teamId)
	if teamId == GameEnum.BattleTeam.Left then
		return self._result == 1
	else
		return self._result ~= 1
	end
end

function ShowDownBattleRecord:getTeamBattleRecord(teamId)
	return self._teamRecords[teamId]
end

function ShowDownBattleRecord:getBattleId()
	return self._battleId
end

function ShowDownBattleRecord:getRecordTimeMillis()
	return self._recordTimeMillis
end

function ShowDownBattleRecord:getRecordTimeStamp()
	return self._recordTimeStamp
end

function ShowDownBattleRecord:isHasExpiredBattleVideo()
	local max = self._recordTimeStamp + self._shelfLife

	return max <= ServerTime.now()
end

function ShowDownBattleRecord:getQualType()
	return self._qualType
end

return ShowDownBattleRecord
