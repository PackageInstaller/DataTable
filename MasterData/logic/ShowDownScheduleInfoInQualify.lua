-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/data/ShowDownScheduleInfoInQualify.lua

module("logic.extensions.showdown.data.ShowDownScheduleInfoInQualify", package.seeall)

local ShowDownScheduleInfoInQualify = class("ShowDownScheduleInfoInQualify")

function ShowDownScheduleInfoInQualify:ctor()
	self._battleRecordList = {}
	self._winCount = 0
	self._loseCount = 0
	self._myScore = 0
	self._myRank = 0
end

function ShowDownScheduleInfoInQualify:onReset()
	table.clear(self._battleRecordList)

	self._winCount = 0
	self._loseCount = 0
	self._myScore = 0
	self._myRank = 0
end

function ShowDownScheduleInfoInQualify:updateData(value)
	local myQualifyInfo = value.myQualifyInfo

	if myQualifyInfo then
		for i, v in ipairs(myQualifyInfo.records) do
			if self._battleRecordList[i] == nil then
				self._battleRecordList[i] = ShowDownBattleRecord.New()
			end

			self._battleRecordList[i]:updateData(v)
		end

		for i = #myQualifyInfo.records + 1, #self._battleRecordList do
			self._battleRecordList[i] = nil
		end

		table.sort(self._battleRecordList, function(a, b)
			return a:getRecordTimeStamp() > b:getRecordTimeStamp()
		end)

		self._winCount = myQualifyInfo.winLoseMark.left
		self._loseCount = myQualifyInfo.winLoseMark.right
		self._myScore = myQualifyInfo.myScore
		self._myRank = myQualifyInfo.myRank
	else
		table.clear(self._battleRecordList)

		self._winCount = 0
		self._loseCount = 0
		self._myScore = 0
		self._myRank = 0
	end
end

function ShowDownScheduleInfoInQualify:getBattleRecordList()
	return self._battleRecordList
end

function ShowDownScheduleInfoInQualify:getWinCount()
	return self._winCount
end

function ShowDownScheduleInfoInQualify:getLoseCount()
	return self._loseCount
end

function ShowDownScheduleInfoInQualify:getMyScore()
	return self._myScore
end

function ShowDownScheduleInfoInQualify:getMyRank()
	return self._myRank
end

return ShowDownScheduleInfoInQualify
