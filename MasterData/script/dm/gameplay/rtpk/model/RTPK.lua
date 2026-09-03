-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/rtpk/model/RTPK.lua

require("dm.gameplay.rtpk.model.RTPKReport")

RTPK = class("RTPK", objectlua.Object, _M)

RTPK:has("_seasonId", {
	is = "r"
})
RTPK:has("_startTime", {
	is = "r"
})
RTPK:has("_endTime", {
	is = "r"
})
RTPK:has("_closeTime", {
	is = "r"
})
RTPK:has("_curGrade", {
	is = "r"
})
RTPK:has("_curScore", {
	is = "r"
})
RTPK:has("_curStatus", {
	is = "r"
})
RTPK:has("_todayCount", {
	is = "r"
})
RTPK:has("_leftCount", {
	is = "r"
})
RTPK:has("_reportList", {
	is = "r"
})
RTPK:has("_lastSeasonId", {
	is = "r"
})
RTPK:has("_lastSeasonScore", {
	is = "r"
})
RTPK:has("_dailyRewardGot", {
	is = "r"
})
RTPK:has("_gradeRewardGot", {
	is = "r"
})
RTPK:has("_maxScore", {
	is = "r"
})
RTPK:has("_seasonConfig", {
	is = "r"
})
RTPK:has("_serverRank", {
	is = "r"
})
RTPK:has("_globalRank", {
	is = "r"
})
RTPK:has("_matchCDTs", {
	is = "r"
})
RTPK:has("_battleCDTs", {
	is = "r"
})
RTPK:has("_doubleTimes", {
	is = "r"
})
RTPK:has("_historyRank", {
	is = "r"
})
RTPK:has("_totalWin", {
	is = "r"
})
RTPK:has("_totalWinGot", {
	is = "r"
})

function RTPK:initialize()
	super.initialize(self)

	self._seasonId = ""
	self._startTime = 0
	self._endTime = 0
	self._closeTime = 0
	self._curGrade = 1
	self._curScore = 0
	self._curStatus = RTPKSeasonStatus.kRest
	self._todayCount = 0
	self._lastSeasonId = ""
	self._lastSeasonScore = 0
	self._leftCount = 0
	self._reportList = {}
	self._dailyRewardGot = {}
	self._gradeRewardGot = {}
	self._maxScore = 0
	self._seasonConfig = {}
	self._serverRank = -1
	self._globalRank = -1
	self._matchCDTs = 0
	self._battleCDTs = 0
	self._doubleTimes = 0
	self._historyRank = 0
	self._totalWin = 0
	self._totalWinGot = {}

	self:initGrade()
end

function RTPK:synchronize(data)
	if not data then
		return
	end

	if data.seasonId then
		self._seasonId = data.seasonId
		self._seasonConfig = ConfigReader:getRecordById("RTPKSeason", self._seasonId)
	end

	if data.startTs then
		self._startTime = data.startTs
	end

	if data.endTs then
		self._endTime = data.endTs
	end

	if data.closeTs then
		self._closeTime = data.closeTs
	end

	if data.curStatus then
		self._curStatus = data.curStatus
	end

	if data.curPoint then
		self._curScore = data.curPoint

		self:setGrade()
	end

	if data.todayCount then
		self._todayCount = data.todayCount
	end

	if data.leftCount then
		self._leftCount = data.leftCount
	end

	if data.dailyGot then
		self._dailyRewardGot = data.dailyGot
	end

	if data.gradeGot then
		self._gradeRewardGot = data.gradeGot
	end

	if data.maxPoint then
		self._maxScore = data.maxPoint
	end

	if data.lastPoint then
		self._lastSeasonScore = data.lastPoint
	end

	if data.lastSeasonId then
		self._lastSeasonId = data.lastSeasonId
	end

	if data.serverRank then
		self._serverRank = data.serverRank
	end

	if data.globalRank then
		self._globalRank = data.globalRank
	end

	if data.matchCDTs then
		self._matchCDTs = data.matchCDTs
	end

	if data.battleCDTs then
		self._battleCDTs = data.battleCDTs
	end

	if data.doubleTimes then
		self._doubleTimes = data.doubleTimes
	end

	if data.historyRank then
		self._historyRank = data.historyRank
	end

	if data.totalWin then
		self._totalWin = data.totalWin
	end

	if data.totalWinGot then
		self._totalWinGot = data.totalWinGot
	end
end

function RTPK:syncReportList(data)
	self._reportList = {}

	if next(data) then
		for index, reportData in pairs(data) do
			local i = tonumber(index) + 1
			local report = RTPKReport:new(i)

			report:synchronize(reportData)

			self._reportList[report:getId()] = report
		end
	end
end

function RTPK:getReportById(id)
	return self._reportList[id]
end

function RTPK:getReportList()
	local list = {}

	for i, v in pairs(self._reportList) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		return a:getRecordMills() > b:getRecordMills()
	end)

	return list
end

function RTPK:initGrade()
	self._gradeList = {}

	local config = ConfigReader:getDataTable("RTPKGrade")

	for k, v in pairs(config) do
		self._gradeList[#self._gradeList + 1] = v
	end

	table.sort(self._gradeList, function(a, b)
		return tonumber(a.Id) < tonumber(b.Id)
	end)
end

function RTPK:setGrade()
	for k, v in pairs(self._gradeList) do
		if self._curScore >= v.ScoreLow and self._curScore <= v.ScoreHigh then
			self._curGrade = v
		end
	end
end

function RTPK:isGetDailyReward(key)
	for i, v in pairs(self._dailyRewardGot) do
		if tonumber(v) == tonumber(key) then
			return true
		end
	end

	return false
end

function RTPK:getDailyRewardData()
	local showReward = self._seasonConfig.DailyWinRewardShow
	local list = {}

	for k, v in pairs(showReward) do
		list[#list + 1] = {
			count = tonumber(k),
			reward = v,
			getStatus = self:isGetDailyReward(k)
		}
	end

	table.sort(list, function(a, b)
		return a.count < b.count
	end)

	return list
end

function RTPK:isMaxGrade(grageId)
	grageId = grageId or self._curGrade.Id

	local maxGrade = self._gradeList[#self._gradeList]

	if grageId == maxGrade.Id then
		return true
	end

	return false
end

function RTPK:getSeasonRule()
	return self._seasonConfig.SeasonRule
end

function RTPK:getGradeByScore(score)
	for i, v in ipairs(self._gradeList) do
		local low = v.ScoreLow
		local high = v.ScoreHigh

		if i == #self._gradeList then
			if low <= score then
				return v
			end
		elseif low <= score and score <= high then
			return v
		end
	end

	return nil
end

function RTPK:isGetGradeReward(key)
	for i, v in pairs(self._gradeRewardGot) do
		if tonumber(v) == key then
			return true
		end
	end

	return false
end

function RTPK:getGradeConfigInfo()
	local gradeInfo = ConfigReader:getDataTable("RTPKGrade")
	local info = {}

	for k, v in pairs(gradeInfo) do
		info[#info + 1] = v

		local grade = tonumber(v.Id)

		info[#info].state = self:isGetGradeReward(grade) and RTPKGradeRewardState.kHadGet or self._maxScore >= tonumber(v.ScoreLow) and RTPKGradeRewardState.kCanGet or RTPKGradeRewardState.kCanNotGet
	end

	table.sort(info, function(a, b)
		if a.state ~= b.state then
			return a.state < b.state
		else
			return tonumber(a.Id) < tonumber(b.Id)
		end
	end)

	return info
end

function RTPK:getSeasonBackground()
	return self._seasonConfig.SeasonBackground
end

function RTPK:getSeasonShowModel()
	return self._seasonConfig.SeasonShowModel
end

function RTPK:isGotWinReward(key)
	for i, v in pairs(self._totalWinGot) do
		if v == tostring(key) then
			return true
		end
	end
end

function RTPK:getWinTaskData()
	local winTask = self._seasonConfig.SeasonWinTask
	local info = {}

	for i, v in pairs(winTask) do
		for k, reward in pairs(v) do
			local data = {}

			data.num = k
			data.state = RTPKGradeRewardState.kCanNotGet
			data.rewardId = reward
			info[#info + 1] = data

			if self:isGotWinReward(data.num) then
				data.state = RTPKGradeRewardState.kHadGet
			elseif self._totalWin >= tonumber(data.num) then
				data.state = RTPKGradeRewardState.kCanGet
			end
		end
	end

	table.sort(info, function(a, b)
		if a.state ~= b.state then
			return a.state < b.state
		else
			return tonumber(a.num) < tonumber(b.num)
		end
	end)

	return info
end
