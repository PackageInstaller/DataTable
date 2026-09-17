local activity_base_manager = require("controller.activitymodules.activity_base_manager")

function activity_base_manager:get_activity_newbee_twist_return_info(arg_1_1)
	return self:getActivityObj(arg_1_1):get_activity_newbee_twist_return_info()
end

function activity_base_manager:get_activity_newbee_twist_return_reward(arg_2_1, arg_2_2)
	return self:getActivityObj(arg_2_1):get_activity_newbee_twist_return_reward(arg_2_2)
end

function activity_base_manager:getTwistReturnEndTime(arg_3_1)
	return self:getActivityObj(arg_3_1):getTwistReturnEndTime()
end
