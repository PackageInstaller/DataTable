-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/arena/model/ArenaReport.lua

ArenaReportRole = class("ArenaReportRole", objectlua.Object, _M)

ArenaReportRole:has("_id", {
	is = "r"
})
ArenaReportRole:has("_level", {
	is = "r"
})
ArenaReportRole:has("_combat", {
	is = "r"
})
ArenaReportRole:has("_headImg", {
	is = "r"
})
ArenaReportRole:has("_status", {
	is = "r"
})
ArenaReportRole:has("_showId", {
	is = "r"
})
ArenaReportRole:has("_nickname", {
	is = "r"
})
ArenaReportRole:has("_extra", {
	is = "r"
})

function ArenaReportRole:initialize()
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

function ArenaReportRole:synchronize(data)
	for i, v in pairs(data) do
		self["_" .. i] = v
	end
end

ArenaReport = class("ArenaReport", objectlua.Object, _M)

ArenaReport:has("_id", {
	is = "r"
})
ArenaReport:has("_attackerWin", {
	is = "r"
})
ArenaReport:has("_recordMills", {
	is = "r"
})
ArenaReport:has("_defender", {
	is = "r"
})
ArenaReport:has("_attacker", {
	is = "r"
})
ArenaReport:has("_index", {
	is = "r"
})
ArenaReport:has("_rankChange", {
	is = "r"
})
ArenaReport:has("_rank", {
	is = "r"
})
ArenaReport:has("_reward", {
	is = "r"
})
ArenaReport:has("_extraReward", {
	is = "r"
})

function ArenaReport:initialize(index)
	super.initialize(self)

	self._index = index
	self._id = nil
	self._recordMills = 0
	self._attackerWin = false
	self._attacker = nil
	self._defender = nil
	self._rankChange = 0
	self._rank = 999999
	self._reward = {}
	self._extraReward = {}
end

function ArenaReport:synchronize(data)
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
		for i = 1, #data.reward do
			local rewardData = data.reward[i]

			if rewardData.code == CurrencyIdKind.kHonor then
				rewardData.amount = rewardData.amount + self._extraReward
			end

			table.insert(self._reward, rewardData)
		end
	end

	if data.defender then
		self._defender = self._defender or ArenaReportRole:new()

		self._defender:synchronize(data.defender)
	end

	if data.attacker then
		self._attacker = self._attacker or ArenaReportRole:new()

		self._attacker:synchronize(data.attacker)
	end
end
