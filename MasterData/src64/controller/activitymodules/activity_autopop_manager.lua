local activity_base_manager = require("controller.activitymodules.activity_base_manager")
local var_0_2 = 2

activity_base_manager.activityAutoPopQueue = {}

activity_base_manager:registerEventListener("activity_manager", activity_base_manager.activityEventId.MAIN_LAYER_NEED_POP, function()
	activity_base_manager:createActivityAutoPopQueue()
end)

function activity_base_manager:createActivityAutoPopQueue()
	if not self.activities or not next(self.activities) then
		self:autoPopActivity()

		return
	end

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs(self.activities) do
		if iter_2_1:getAutoPopOrder() ~= nil and iter_2_1:getStatus() == var_0_2 then
			var_2_0[1] = iter_2_1
		end
	end

	if not var_2_0 or not next(var_2_0) then
		self:autoPopActivity()

		return
	end

	table.sort(var_2_0, function(arg_3_0, arg_3_1)
		return arg_3_0:getAutoPopOrder() >= arg_3_1:getAutoPopOrder()
	end)

	for iter_2_2, iter_2_3 in pairs(var_2_0) do
		activity_base_manager:inActivityAutoPopQueue(iter_2_3._id)
		self:firstUseAutoPop()
	end
end

function activity_base_manager:autoPopActivity()
	if self.activityAutoPopQueue then
		if not next(self.activityAutoPopQueue) then
			local var_4_0 = os.date("*t", (require("controller.time_check_manager"):getCurTime()))
			local var_4_1 = RoleDefault:getInstance():setIntegerForKey("nextAutoPoptime", (os.time({
				hour = 23,
				min = 59,
				sec = 59,
				year = var_4_0.year,
				month = var_4_0.month,
				day = var_4_0.day
			})))

			self:fireEvent(activity_base_manager.activityEventId.MAIN_LAYER_ACTIVITY_POP_END)

			return
		end
	end

	local var_4_2 = self:getActivityAutoPopQueueHead()
	local var_4_3 = self:getActivityObj(var_4_2)

	if not var_4_3 then
		return
	end

	local var_4_4 = var_4_3:getJumpToConfig()

	function var_4_4.callback()
		activity_base_manager:autoPopActivity()
	end

	var_4_4.activityID = var_4_2

	var_4_3:getAutoPopLayerFunc()(var_4_4)
	self:outActivityAutoPopQueue()
end

function activity_base_manager:firstUseAutoPop()
	if not self.usedAutoPop then
		self:autoPopActivity()
	end

	self.usedAutoPop = true
end

function activity_base_manager:getActivityAutoPopQueueHead()
	return self.activityAutoPopQueue[1]
end

function activity_base_manager:inActivityAutoPopQueue(arg_8_1)
	table.insert(self.activityAutoPopQueue, arg_8_1)
end

function activity_base_manager:outActivityAutoPopQueue()
	table.remove(self.activityAutoPopQueue, 1)
end
