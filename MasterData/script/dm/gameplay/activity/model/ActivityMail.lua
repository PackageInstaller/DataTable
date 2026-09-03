-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/ActivityMail.lua

ActivityMail = class("ActivityMail", BaseActivity, _M)

ActivityMail:has("_maillist", {
	is = "rw"
})

function ActivityMail:initialize()
	super.initialize(self)
end

function ActivityMail:dispose()
	super.dispose(self)
end

function ActivityMail:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)
	self:initMailList()
end

function ActivityMail:reset()
	super.reset(self)
end

function ActivityMail:hasRedPoint()
	local list = self:getMailList()

	for index, value in ipairs(list) do
		if value.status == 1 then
			return true
		end
	end

	return false
end

function ActivityMail:initMailList()
	if not self._maillist then
		self._maillist = {}
		self._timer = {}

		for mailId, data in pairs(self:getActivityConfig().maillist) do
			local times = data.time

			self._maillist[mailId] = data
			self._maillist[mailId].id = mailId
			self._maillist[mailId].startTime = self:getRemoteMills(times.start)
			self._maillist[mailId].endTime = self:getRemoteMills(times["end"])
			self._maillist[mailId].status = cc.UserDefault:getInstance():getIntegerForKey(self:getUserId(mailId), 0)

			local curTime = DmGame:getInstance()._injector:getInstance("GameServerAgent"):remoteTimestamp()

			if curTime < data.startTime then
				local function checkTimeFunc()
					curTime = DmGame:getInstance()._injector:getInstance("GameServerAgent"):remoteTimestamp()

					if curTime >= data.startTime then
						self._timer[mailId]:stop()

						self._timer[mailId] = nil

						local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)

						developSystem:dispatch(Event:new(EVT_ACTIVITY_MAIL_NEW))
					end
				end

				self._timer[mailId] = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)
			end
		end
	end
end

function ActivityMail:getRemoteMills(times)
	local _, _, y, mon, d, h, m, s = string.find(times, "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")

	return (TimeUtil:timeByRemoteDate({
		year = y,
		month = mon,
		day = d,
		hour = h,
		min = m,
		sec = s
	}))
end

function ActivityMail:getMailList()
	local list = {}

	for mailId, data in pairs(self._maillist) do
		local curTime = DmGame:getInstance()._injector:getInstance("GameServerAgent"):remoteTimestamp()

		if curTime >= data.startTime and curTime <= data.endTime then
			data.status = cc.UserDefault:getInstance():getIntegerForKey(self:getUserId(mailId), 1)
			list[#list + 1] = data
		end
	end

	table.sort(list, function(a, b)
		if a.status == b.status then
			return a.startTime > b.startTime
		else
			return a.status < b.status
		end
	end)

	return list
end

function ActivityMail:getUserId(mailId)
	local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)

	return "ActivityMailStauts_" .. developSystem:getPlayer():getRid() .. mailId
end

function ActivityMail:setMailStatus(mailId)
	cc.UserDefault:getInstance():setIntegerForKey(self:getUserId(mailId), 2)
end

function ActivityMail:getMailStatus(mailId)
	return cc.UserDefault:getInstance():getIntegerForKey(self:getUserId(mailId), 1)
end
