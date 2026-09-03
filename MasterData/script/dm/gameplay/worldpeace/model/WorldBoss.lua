-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/model/WorldBoss.lua

WorldBoss = class("WorldBoss", objectlua.Object)

WorldBoss:has("_lastAttackTime", {
	is = "rw"
})
WorldBoss:has("_dayTimes", {
	is = "rw"
})
WorldBoss:has("_rewardStatus", {
	is = "rw"
})
WorldBoss:has("_status", {
	is = "rw"
})
WorldBoss:has("_matchedPlayers", {
	is = "rw"
})
WorldBoss:has("_rankMap", {
	is = "rw"
})
WorldBoss:has("_matchBollList", {
	is = "rw"
})
WorldBoss:has("_attackBollList", {
	is = "rw"
})
WorldBoss:has("_lastClientCalHurt", {
	is = "rw"
})

WorldBossStatus = {
	kOver = 3,
	kInit = 1,
	kFinish = 4,
	kContinue = 2
}

function WorldBoss:initialize(id)
	super.initialize(self)

	self._id = id
	self._lastAttackTime = 0
	self._dayTimes = 0
	self._rewardStatus = 0
	self._status = 0
	self._matchedPlayers = {}
	self._rankMap = {}
	self._matchBollList = {}
	self._attackBollList = {}
	self._lastClientCalHurt = 0
end

function WorldBoss:synchronize(_data)
	if _data.lastAttackTime then
		self._lastAttackTime = _data.lastAttackTime
	end

	if _data.dayTimes then
		self._dayTimes = _data.dayTimes.value
	end

	if _data.rewardStatus then
		self._rewardStatus = _data.rewardStatus
	end

	if _data.status then
		self._status = _data.status
	end

	if _data.matchedPlayers then
		self._matchedPlayers = _data.matchedPlayers
	end

	if _data.lastClientCalHurt then
		self._lastClientCalHurt = _data.lastClientCalHurt
	end
end

function WorldBoss:clearData()
	self._rankMap = {}
	self._matchBollList = {}
	self._attackBollList = {}
end
