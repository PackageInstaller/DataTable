require("controller.activitymodules.activity_base_manager").get_activity_rogue_explore_conf = function(self, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = self:getActivityObj(arg_1_1)

	if not var_1_0 then
		return
	end

	return var_1_0:get_activity_rogue_explore_conf(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
end
