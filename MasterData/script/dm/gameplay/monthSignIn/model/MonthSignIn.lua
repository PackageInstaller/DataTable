-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/monthSignIn/model/MonthSignIn.lua

MonthSignIn = class("MonthSignIn", objectlua.Object, _M)

MonthSignIn:has("_checkinSum", {
	is = "rw"
})
MonthSignIn:has("_todayLuck", {
	is = "rw"
})
MonthSignIn:has("_totalLogin", {
	is = "rw"
})
MonthSignIn:has("_contiLogin", {
	is = "rw"
})
MonthSignIn:has("_todaySignTime", {
	is = "rw"
})
MonthSignIn:has("_dailyReset", {
	is = "rw"
})
MonthSignIn:has("_loginSet", {
	is = "rw"
})
MonthSignIn:has("_gotRewards", {
	is = "rw"
})
MonthSignIn:has("_todayReward", {
	is = "rw"
})

function MonthSignIn:initialize()
	super.initialize(self)

	self._checkinSum = 0
	self._todayLuck = 0
	self._totalLogin = 0
	self._contiLogin = 0
end

function MonthSignIn:synchronize(data)
	if data.checkinSum then
		self._checkinSum = data.checkinSum
	end

	if data.todayLuck then
		self._todayLuck = data.todayLuck
	end

	if data.totalLogin then
		self._totalLogin = data.totalLogin
	end

	if data.contiLogin then
		self._contiLogin = data.contiLogin
	end

	if data.loginSet then
		self._loginSet = data.loginSet
	end

	if data.dailyReset then
		self._dailyReset = data.dailyReset
	end

	if data.gotRewards then
		self._gotRewards = data.gotRewards
	end
end

function MonthSignIn:syncDelateData(data)
	self:synchronize(data)
end
