local network = require("network.network")
local time_check_manager = require("controller.time_check_manager")
local rogue_explore_manager = require("controller.rogue_explore_manager")
local activity_conf_data = require("data.activity_conf_data")

function ACTIVITY_OBJ_NEW:get_activity_rogue_explore_conf(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	network:rpc("get_activity_rogue_explore_conf", {
		activityid = self._id,
		levelid = arg_1_2,
		array = arg_1_3
	}, function(arg_2_0)
		if arg_2_0.result == 1 then
			rogue_explore_manager:beginExplore({
				activityid = arg_1_1,
				levelid = arg_1_2,
				aimid = arg_1_4,
				array = arg_1_3,
				server_info = arg_2_0
			})
		elseif arg_2_0.result == 2 then
			global_ShowBlockWords(L_FLOP_BUY_KEY_WARNING[2])
		elseif arg_2_0.result == 3 then
			print("不存在肉鸽探险活动")
			global_ShowBlockWords(L_FLOP_BUY_KEY_WARNING[2] .. "msg:3")
		elseif arg_2_0.result == 4 then
			global_ShowBlockWords("未通关简单")
		end
	end)
end
