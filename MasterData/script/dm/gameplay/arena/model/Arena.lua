-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/arena/model/Arena.lua

require("dm.gameplay.arena.model.ArenaReport")
require("dm.gameplay.arena.model.ArenaRival")

Arena = class("Arena", objectlua.Object, _M)

Arena:has("_enemyList", {
	is = "r"
})
Arena:has("_refreshCDMills", {
	is = "r"
})
Arena:has("_totalExtra", {
	is = "r"
})
Arena:has("_reportList", {
	is = "r"
})
Arena:has("_totalPage", {
	is = "r"
})
Arena:has("_rank", {
	is = "r"
})
Arena:has("_winReward", {
	is = "r"
})
Arena:has("_historyRank", {
	is = "r"
})

function Arena:initialize()
	super.initialize(self)

	self._enemyList = {}
	self._reportList = {}
	self._totalExtra = 0
	self._totalPage = 0
	self._rank = 0
	self._refreshCDMills = 0
	self._winReward = {}
	self._historyRank = ""
end

function Arena:synchronize(data)
	if data then
		if data.rivals then
			self:synchronizeEnemies(data.rivals)
		end

		if data.battleReports then
			self:synchronizeReportData(data.battleReports)
		end

		if data.refreshCDMills then
			self._refreshCDMills = data.refreshCDMills
		end

		if data.totalExtra then
			self._totalExtra = data.totalExtra
		end

		if data.totalPage then
			self._totalPage = data.totalPage
		end

		if data.rank then
			self._rank = data.rank
		end

		if data.winReward then
			self._winReward = data.winReward
		end

		if data.historyRank then
			self._historyRank = data.historyRank
		end

		if data.season then
			self._season = data.season
		end
	end
end

function Arena:getFirstReward()
	return self._winReward
end

function Arena:synchronizeEnemies(data)
	if data then
		self._enemyList = {}

		for index, enemyData in pairs(data) do
			local i = tonumber(index)
			local record = ArenaRival:new()

			record:synchronize(enemyData)

			self._enemyList[i] = record
		end
	end
end

function Arena:synchronizeReportData(data)
	if data then
		self._reportList = {}

		for index, reportData in pairs(data) do
			local i = tonumber(index) + 1
			local report = ArenaReport:new(i)

			report:synchronize(reportData)

			self._reportList[report:getId()] = report
		end
	end
end

function Arena:getRivalByIndex(index)
	return self._enemyList[index]
end

function Arena:getReportById(id)
	return self._reportList[id]
end

function Arena:getRefreshTime()
	return self._refreshCDMills / 1000
end

function Arena:getSeasonData()
	return self._season
end

function Arena:getReportList()
	local list = {}

	for i, v in pairs(self._reportList) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		return a:getRecordMills() > b:getRecordMills()
	end)

	return list
end
