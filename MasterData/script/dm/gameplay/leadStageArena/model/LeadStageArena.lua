-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/leadStageArena/model/LeadStageArena.lua

require("dm.gameplay.leadStageArena.model.LeadStageArenaReport")

LeadStageArenaState = {
	KShow = 2,
	KReset = 3,
	kFighting = 0,
	KNoSeason = 4
}
LeadStageArenaHeroInfo = class("LeadStageArenaHeroInfo", objectlua.Object, _M)

LeadStageArenaHeroInfo:has("_rid", {
	is = "r"
})
LeadStageArenaHeroInfo:has("_nickName", {
	is = "r"
})
LeadStageArenaHeroInfo:has("_level", {
	is = "r"
})
LeadStageArenaHeroInfo:has("_head", {
	is = "r"
})
LeadStageArenaHeroInfo:has("_headFrame", {
	is = "r"
})
LeadStageArenaHeroInfo:has("_modelId", {
	is = "r"
})
LeadStageArenaHeroInfo:has("_rankIndex", {
	is = "r"
})
LeadStageArenaHeroInfo:has("_oldCoin", {
	is = "r"
})
LeadStageArenaHeroInfo:has("_bubbleSet", {
	is = "r"
})

function LeadStageArenaHeroInfo:initialize()
	super.initialize(self)

	self._rid = ""
	self._nickName = ""
	self._level = 0
	self._head = ""
	self._headFrame = ""
	self._modelId = 0
	self._rankIndex = 0
	self._oldCoin = 0
	self._bubbleSet = {}
end

function LeadStageArenaHeroInfo:synchronize(data)
	if not data then
		return
	end

	if data.r then
		self._rid = data.r
	end

	if data.n then
		self._nickName = data.n
	end

	if data.l then
		self._level = data.l
	end

	if data.h then
		self._head = data.h
	end

	if data.f then
		self._headFrame = data.f
	end

	if data.s then
		self._modelId = data.s
	end

	if data.rank then
		self._rankIndex = data.rank
	end

	if data.p then
		self._oldCoin = data.p
	end

	if data.bubbleSet then
		self._bubbleSet = data.bubbleSet
	end
end

LeadStageArena = class("LeadStageArena", objectlua.Object, _M)

LeadStageArena:has("_seasonId", {
	is = "r"
})
LeadStageArena:has("_startTime", {
	is = "r"
})
LeadStageArena:has("_endTime", {
	is = "r"
})
LeadStageArena:has("_closeTime", {
	is = "r"
})
LeadStageArena:has("_curStatus", {
	is = "r"
})
LeadStageArena:has("_oldCoin", {
	is = "r"
})
LeadStageArena:has("_globalRank", {
	is = "r"
})
LeadStageArena:has("_powerCount", {
	is = "r"
})
LeadStageArena:has("_powerCountLastRefreshTs", {
	is = "r"
})
LeadStageArena:has("_rival", {
	is = "r"
})
LeadStageArena:has("_freshRivalNum", {
	is = "r"
})
LeadStageArena:has("_ownTeams", {
	is = "r"
})
LeadStageArena:has("_reportList", {
	is = "r"
})
LeadStageArena:has("_config", {
	is = "r"
})
LeadStageArena:has("_myInfo", {
	is = "r"
})
LeadStageArena:has("_historyRank", {
	is = "r"
})

function LeadStageArena:initialize()
	super.initialize(self)

	self._seasonId = ""
	self._startTime = 0
	self._endTime = 0
	self._closeTime = 0
	self._curStatus = LeadStageArenaState.KReset
	self._oldCoin = 0
	self._globalRank = -1
	self._powerCount = 0
	self._powerCountLastRefreshTs = 0
	self._coinRewardList = {}
	self._config = {}
	self._freshRivalNum = 0
	self._rival = {}
	self._ownTeams = {}
	self._reportList = {}
	self._myInfo = {}
	self._historyRank = 0
end

function LeadStageArena:synchronize(data)
	if not data then
		return
	end

	if data.seasonId then
		self._seasonId = data.seasonId
		self._config = ConfigReader:getRecordById("StageArenaSeason", self._seasonId)
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

	if data.globalRank then
		self._globalRank = data.globalRank
	end

	if data.rlyehCoin then
		self._oldCoin = data.rlyehCoin
	end

	if data.bacchusCount then
		self._powerCount = data.bacchusCount
	end

	if data.bacchusLastRefreshTs then
		self._powerCountLastRefreshTs = data.bacchusLastRefreshTs
	end

	if data.freshRivalNum then
		self._freshRivalNum = data.freshRivalNum
	end

	if data.rival then
		self._rival = data.rival
	end

	if data.myTeams then
		for i = 1, 3 do
			local teamInfo = data.myTeams["STAGE_ARENA_" .. i]

			if teamInfo then
				local heros = {}

				for i, v in pairs(teamInfo.heroes) do
					heros[#heros + 1] = v
				end

				self._ownTeams[i] = teamInfo
				self._ownTeams[i].heroes = heros
				self._ownTeams[i].teamId = "STAGE_ARENA_" .. i
			end
		end
	end

	if data.myInfo then
		self._myInfo = LeadStageArenaHeroInfo:new()

		self._myInfo:synchronize(data.myInfo)
	end

	if data.historyRank then
		self._historyRank = data.historyRank
	end
end

function LeadStageArena:syncReportList(data)
	self._reportList = {}

	if next(data) then
		for index, reportData in pairs(data) do
			local i = tonumber(index)
			local report = LeadStageArenaReport:new(i)

			report:synchronize(reportData)

			self._reportList[report:getId()] = report
		end
	end
end

function LeadStageArena:getReportById(id)
	return self._reportList[id]
end

function LeadStageArena:getReportList()
	local list = {}

	for i, v in pairs(self._reportList) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		return a:getIndex() < b:getIndex()
	end)

	return list
end

function LeadStageArena:getConfig()
	return self._config
end

function LeadStageArena:getPositionNum()
	return self._config.PositionNum
end

function LeadStageArena:getRewardConfigInfo()
	local gradeInfo = ConfigReader:getDataTable("StageArenaGold")
	local info = {}

	for k, v in pairs(gradeInfo) do
		info[#info + 1] = v

		local grade = tonumber(v.Id)

		info[#info].state = self:isGetGradeReward(grade) and RTPKGradeRewardState.kHadGet or grade <= tonumber(self._curGrade.Id) and RTPKGradeRewardState.kCanGet or RTPKGradeRewardState.kCanNotGet
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
