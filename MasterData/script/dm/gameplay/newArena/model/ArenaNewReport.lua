-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/newArena/model/ArenaNewReport.lua

ArenaNewReportRole = class("ArenaNewReportRole", objectlua.Object, _M)

ArenaNewReportRole:has("_id", {
	is = "r"
})
ArenaNewReportRole:has("_level", {
	is = "r"
})
ArenaNewReportRole:has("_combat", {
	is = "r"
})
ArenaNewReportRole:has("_headImg", {
	is = "r"
})
ArenaNewReportRole:has("_status", {
	is = "r"
})
ArenaNewReportRole:has("_showId", {
	is = "r"
})
ArenaNewReportRole:has("_nickname", {
	is = "r"
})
ArenaNewReportRole:has("_extra", {
	is = "r"
})

function ArenaNewReportRole:initialize()
	super.initialize(self)

	self._id = nil
	self._level = 0
	self._combat = 0
	self._headImg = nil
	self._status = 0
	self._showId = "YFZZhu"
	self._nickname = ""
	self._extra = 0
end

function ArenaNewReportRole:synchronize(data)
	for i, v in pairs(data) do
		self["_" .. i] = v
	end
end

ArenaNewReport = class("ArenaNewReport", objectlua.Object, _M)

ArenaNewReport:has("_id", {
	is = "r"
})
ArenaNewReport:has("_attackerWin", {
	is = "r"
})
ArenaNewReport:has("_recordMills", {
	is = "r"
})
ArenaNewReport:has("_defender", {
	is = "r"
})
ArenaNewReport:has("_attacker", {
	is = "r"
})
ArenaNewReport:has("_index", {
	is = "r"
})
ArenaNewReport:has("_rankChange", {
	is = "r"
})
ArenaNewReport:has("_rank", {
	is = "r"
})
ArenaNewReport:has("_reward", {
	is = "r"
})
ArenaNewReport:has("_extraReward", {
	is = "r"
})
ArenaNewReport:has("_reprotType", {
	is = "r"
})

function ArenaNewReport:initialize(index)
	super.initialize(self)

	self._index = index
	self._id = nil
	self._recordMills = 0
	self._attackerWin = false
	self._attacker = nil
	self._defender = nil
	self._rankChange = 0
	self._rank = 0
	self._reward = {}
	self._extraReward = {}
	self._reprotType = "NEWARENA"
end

function ArenaNewReport:synchronize(data)
	if data.reportId then
		self._id = data.reportId
	end

	if data.attackerWin then
		self._attackerWin = data.attackerWin
	end

	if data.recordMills then
		self._recordMills = data.recordMills
	end

	if data.rankChange then
		self._rankChange = data.rankChange
	end

	if data.attackerRank then
		self._rank = data.attackerRank
	end

	if data.extraReward then
		self._extraReward = data.extraReward
	end

	if data.reward then
		self._reward = data.reward
	end

	if data.defender then
		self._defender = self._defender or ArenaNewReportRole:new()

		self._defender:synchronize(data.defender)
	end

	if data.attacker then
		self._attacker = self._attacker or ArenaNewReportRole:new()

		self._attacker:synchronize(data.attacker)
	end
end
