-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/FreeStaminaActivity.lua

FreeStaminaActivity = class("FreeStaminaActivity", BaseActivity, _M)

FreeStaminaActivity:has("_receiveList", {
	is = "rw"
})

StaminaRewardTimeStatus = {
	kNow = 2,
	kAfter = 1,
	kBefore = 0
}

function FreeStaminaActivity:initialize()
	super.initialize(self)

	self._receiveList = {}
end

function FreeStaminaActivity:dispose()
	super.dispose(self)
end

function FreeStaminaActivity:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)

	if data.received then
		self._receiveList = {}

		local config = self:getActivityConfig()

		if config and config.FreeStamina then
			for i = 1, #config.FreeStamina do
				self._receiveList[i] = ActivityTaskStatus.kUnfinish
			end
		end

		for k, v in pairs(data.received) do
			self._receiveList[v] = ActivityTaskStatus.kGet
		end
	end
end

function FreeStaminaActivity:getRewardStatusByIndex(index)
	return self._receiveList[index]
end

function FreeStaminaActivity:getDayMaxTimeList()
	local config = self:getActivityConfig()

	if config and config.FreeStamina then
		for i = 1, #config.FreeStamina do
			local data = config.FreeStamina[i]

			if data.Order == #config.FreeStamina then
				return data.Time
			end
		end
	end

	return false
end

function FreeStaminaActivity:hasRedPoint()
	local config = self:getActivityConfig()
	local activitySystem = self:getActivitySystem()

	if config then
		local curList = config.FreeStamina

		if curList then
			for i = 1, #curList do
				local status = activitySystem:isCanGetStamina(curList[i].Time, curList[i].Order)

				if status == StaminaRewardTimeStatus.kNow then
					return true
				end
			end
		end
	end

	return false
end

function FreeStaminaActivity:getTotalTimeSlot()
	local config = self:getActivityConfig()

	if config and config.FreeStamina then
		return #config.FreeStamina
	end

	return 3
end
