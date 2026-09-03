-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/rtpk/model/RTPKReport.lua

RTPKReportRole = class("RTPKReportRole", objectlua.Object, _M)

RTPKReportRole:has("_id", {
	is = "r"
})
RTPKReportRole:has("_level", {
	is = "r"
})
RTPKReportRole:has("_headImg", {
	is = "r"
})
RTPKReportRole:has("_nickname", {
	is = "r"
})

function RTPKReportRole:initialize()
	super.initialize(self)

	self._id = nil
	self._level = 0
	self._headImg = nil
	self._nickname = ""
end

function RTPKReportRole:synchronize(data)
	for i, v in pairs(data) do
		self["_" .. i] = v
	end
end

RTPKReport = class("RTPKReport", objectlua.Object, _M)

RTPKReport:has("_id", {
	is = "r"
})
RTPKReport:has("_attackerWin", {
	is = "r"
})
RTPKReport:has("_recordMills", {
	is = "r"
})
RTPKReport:has("_defender", {
	is = "r"
})
RTPKReport:has("_attacker", {
	is = "r"
})
RTPKReport:has("_index", {
	is = "r"
})
RTPKReport:has("_rankChange", {
	is = "r"
})
RTPKReport:has("_reprotType", {
	is = "r"
})
RTPKReport:has("_seasonId", {
	is = "r"
})
RTPKReport:has("_outOfTime", {
	is = "r"
})

function RTPKReport:initialize(index)
	super.initialize(self)

	self._index = index
	self._id = nil
	self._recordMills = 0
	self._attackerWin = false
	self._attacker = nil
	self._defender = nil
	self._rankChange = 0
	self._seasonId = nil
	self._battleResult = nil
	self._outOfTime = false
	self._reprotType = "RTPK"
end

function RTPKReport:synchronize(data)
	if data.id then
		self._id = data.id
	end

	if data.win then
		self._attackerWin = data.win
	end

	if data.createMillis then
		self._recordMills = data.createMillis
	end

	if data.increase then
		self._rankChange = data.increase
	end

	if data.seasonId then
		self._seasonId = data.seasonId
	end

	if data.outOfTime then
		self._outOfTime = data.outOfTime
	end

	if data.rivalId then
		self._defender = self._defender or RTPKReportRole:new()

		local var_4_0 = {
			id = data.rivalId,
			level = data.rivalLevel,
			headImg = data.rivalHeadImage
		}

		var_4_0.nickname = data.rivalNickname or ""

		local d = var_4_0

		self._defender:synchronize(d)
	end

	if data.rid then
		self._attacker = self._attacker or RTPKReportRole:new()

		local d = {
			id = data.rid,
			level = data.level,
			headImg = data.headImg,
			nickname = data.nickname
		}

		self._attacker:synchronize(d)
	end
end
