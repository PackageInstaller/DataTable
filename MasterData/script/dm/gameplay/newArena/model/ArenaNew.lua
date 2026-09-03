-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/newArena/model/ArenaNew.lua

require("dm.gameplay.newArena.model.ArenaNewReport")
require("dm.gameplay.newArena.model.ArenaNewRival")

ArenaNew = class("ArenaNew", objectlua.Object, _M)

ArenaNew:has("_rivalList", {
	is = "r"
})
ArenaNew:has("_reportList", {
	is = "r"
})
ArenaNew:has("_reportOfflineList", {
	is = "r"
})
ArenaNew:has("_seasonData", {
	is = "r"
})
ArenaNew:has("_seasonId", {
	is = "r"
})
ArenaNew:has("_curRank", {
	is = "r"
})
ArenaNew:has("_startTime", {
	is = "r"
})
ArenaNew:has("_endTime", {
	is = "r"
})
ArenaNew:has("_group", {
	is = "r"
})
ArenaNew:has("_beBattleTimes", {
	is = "r"
})

function ArenaNew:initialize()
	super.initialize(self)

	self._rivalList = {}
	self._reportList = {}
	self._startTime = 0
	self._endTime = 0
	self._curRank = 0
	self._group = ""
	self._seasonId = ""
	self._reportOfflineList = {}
	self._seasonData = nil
end

function ArenaNew:synchronize(data)
	if data then
		if data.rivalsData then
			self:syncRivals(data.rivalsData)
		end

		if data.season then
			if self._seasonId and self._seasonId ~= "null" then
				self._seasonId = data.season
				self._seasonData = ConfigReader:getRecordById("ChessArenaSeason", self._seasonId)
			else
				self._seasonId = ""
				self._seasonData = nil
			end
		end

		if data.rank then
			self._curRank = data.rank
		end

		if data.startTime then
			self._startTime = data.startTime / 1000
		end

		if data.endTime then
			self._endTime = data.endTime / 1000
		end

		if data.group then
			self._group = data.group
		end
	end
end

function ArenaNew:syncRivals(data)
	if data then
		self._rivalList = {}

		for index, enemyData in pairs(data) do
			local i = tonumber(index)
			local record = ArenaNewRival:new()

			record:synchronize(enemyData)

			self._rivalList[i] = record
		end
	end
end

function ArenaNew:synchronizeReportData(data)
	if data then
		self._reportList = {}

		for index, reportData in pairs(data) do
			local i = tonumber(index)
			local report = ArenaNewReport:new(i)

			report:synchronize(reportData)

			self._reportList[report:getId()] = report
		end
	end
end

function ArenaNew:synchronizeReportOfflineData(data)
	if data then
		local reports = data.reports

		self._beBattleTimes = data.beBattleTimes or 0
		self._reportOfflineList = {}

		if type(reports) == "table" then
			for index, reportData in pairs(reports) do
				local i = tonumber(index)
				local report = ArenaNewReport:new(i)

				report:synchronize(reportData)

				self._reportOfflineList[report:getId()] = report
			end
		end
	end
end

function ArenaNew:getRivalByIndex(index)
	return self._rivalList[index]
end

function ArenaNew:getReportById(id)
	return self._reportList[id] or self._reportOfflineList[id]
end

function ArenaNew:getReportList()
	local list = {}

	for i, v in pairs(self._reportList) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		return a:getRecordMills() > b:getRecordMills()
	end)

	return list
end

function ArenaNew:getReportOfflineList()
	local list = {}

	for i, v in pairs(self._reportOfflineList) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		return a:getRecordMills() > b:getRecordMills()
	end)

	return list
end

function ArenaNew:getCurRankStr()
	return (self._curRank > 0 or nil) and (self._curRank or Strings:get("StageArena_MainUI19"))
end
