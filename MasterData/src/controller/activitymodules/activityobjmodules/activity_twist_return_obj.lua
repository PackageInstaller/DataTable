local network = require("network.network")
local drop_manager = require("controller.drop_manager")
local time_check_manager = require("controller.time_check_manager")
local activity_manager = require("controller.activity_manager")
local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local activity_newbee_investment_conf_data = require("data.activity_309.activity_newbee_investment_conf_data")

function ACTIVITY_OBJ_NEW:get_activity_newbee_twist_return_info()
	network:rpc("get_activity_newbee_twist_return_info", {
		activityid = self._id
	}, function(arg_2_0)
		if arg_2_0.result == 1 then
			self.twist_return_end_time = arg_2_0.end_time

			activity_manager:updateActivityAlert("twistreturn", self._id, arg_2_0.reward_today > 0)
			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_TWIST_RETURN_DATA_UPDATE, arg_2_0)
		end
	end)
end

function ACTIVITY_OBJ_NEW:get_activity_newbee_twist_return_reward(arg_3_1)
	network:rpc("get_activity_newbee_twist_return_reward", {
		activityid = self._id
	}, function(arg_4_0)
		if arg_4_0.result == 1 then
			global_gain(arg_4_0)
			self:get_activity_newbee_twist_return_info()
		else
			global_ShowBlockWords(L_TWIST_RETURN_GET_REWARD[arg_4_0.result])
		end
	end)
end

function ACTIVITY_OBJ_NEW:getTwistReturnEndTime()
	if not self.twist_return_end_time then
		return 1
	end

	return self.twist_return_end_time - time_check_manager:getCurTime()
end
