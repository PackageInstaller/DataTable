local activity_base_manager = require("controller.activitymodules.activity_base_manager")

function activity_base_manager:get_activity_newbee_investment_info(arg_1_1)
	return self:getActivityObj(arg_1_1):get_activity_newbee_investment_info()
end

function activity_base_manager:activity_newbee_investment_invest(arg_2_1, arg_2_2)
	return self:getActivityObj(arg_2_1):activity_newbee_investment_invest(arg_2_2)
end

function activity_base_manager:activity_newbee_investment_reward(arg_3_1, arg_3_2)
	return self:getActivityObj(arg_3_1):activity_newbee_investment_reward(arg_3_2)
end

function activity_base_manager:getManageMoneyEndTime(arg_4_1)
	return self:getActivityObj(arg_4_1):getManageMoneyEndTime()
end

function activity_base_manager:getManageMoneyRewardType(arg_5_1, arg_5_2)
	return self:getActivityObj(arg_5_1):getManageMoneyRewardType(arg_5_2)
end

function activity_base_manager:getManageMoneyRewardNum(arg_6_1, arg_6_2)
	return self:getActivityObj(arg_6_1):getManageMoneyRewardNum(arg_6_2)
end

function activity_base_manager:getManageMoneyInvestNum(arg_7_1, arg_7_2)
	return self:getActivityObj(arg_7_1):getManageMoneyInvestNum(arg_7_2)
end

function activity_base_manager:getManageMoneyGetNum(arg_8_1, arg_8_2)
	return self:getActivityObj(arg_8_1):getManageMoneyGetNum(arg_8_2)
end
