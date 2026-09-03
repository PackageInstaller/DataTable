-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/ActivityClubBoss.lua

ActivityClubBoss = class(" ActivityClubBoss", BaseActivity, _M)

ActivityClubBoss:has("_developSystem", {
	is = "rw"
}):injectWith("DevelopSystem")
ActivityClubBoss:has("_getHurtAward", {
	is = "rw"
})
ActivityClubBoss:has("_activityId", {
	is = "rw"
})
ActivityClubBoss:has("_todayOpen", {
	is = "rw"
})
ActivityClubBoss:has("_getAwards", {
	is = "rw"
})
ActivityClubBoss:has("_lastFightTime", {
	is = "rw"
})
ActivityClubBoss:has("_readTipTime", {
	is = "rw"
})
ActivityClubBoss:has("_joinPoint", {
	is = "rw"
})
ActivityClubBoss:has("_lastteam", {
	is = "rw"
})
ActivityClubBoss:has("_team", {
	is = "rw"
})
ActivityClubBoss:has("_timeStamp", {
	is = "rw"
})
ActivityClubBoss:has("_tiredHero", {
	is = "rw"
})
ActivityClubBoss:has("_bossFightTimes", {
	is = "rw"
})
ActivityClubBoss:has("_allData", {
	is = "r"
})

function ActivityClubBoss:initialize()
	super.initialize(self)

	self._getHurtAward = ""
	self._activityId = ""
	self._todayOpen = {}
	self._getAwards = {}
	self._lastFightTime = ""
	self._readTipTime = ""
	self._joinPoint = ""
	self._lastteam = ""
	self._team = ""
	self._timeStamp = ""
	self._tiredHero = ""
	self._bossFightTimes = ""
	self._allData = nil
end

function ActivityClubBoss:dispose()
	super.dispose(self)
end

function ActivityClubBoss:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)

	self._allData = data

	if data.getHurtAward then
		self._getHurtAward = data.getHurtAward
	end

	if data.todayOpen then
		self._todayOpen = data.todayOpen
	end

	if data.timeStamp then
		self._timeStamp = data.timeStamp
	end

	if data.activityId then
		self._activityId = data.activityId
	end
end
