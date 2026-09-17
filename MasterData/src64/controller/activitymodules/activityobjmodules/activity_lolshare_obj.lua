local network = require("network.network")
local time_check_manager = require("controller.time_check_manager")
local activity_manager = require("controller.activity_manager")
local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")

local function var_0_5(arg_1_0)
	if arg_1_0 >= 86400 then
		return string.format(L_TIME_TEXT[1], math.floor(arg_1_0 / 86400), math.floor(arg_1_0 % 86400 / 3600))
	elseif arg_1_0 >= 3600 then
		return string.format(L_TIME_TEXT[2], math.floor(arg_1_0 / 3600), math.floor(arg_1_0 % 3600 / 60))
	else
		return string.format(L_TIME_TEXT[3], math.floor(arg_1_0 / 60), math.floor(arg_1_0 % 60))
	end
end

function ACTIVITY_OBJ_NEW:get_activity_share_info()
	network:rpc("get_activity_newyear2022_info", {
		activityid = self._id
	}, function(arg_3_0)
		activity_manager:fireEvent(activity_manager.activityEventId.LOL_SHARE_DATA_UPDATE, arg_3_0)
	end)
end

function ACTIVITY_OBJ_NEW:choose_activity_newyear2022_reward(arg_4_1)
	network:rpc("choose_activity_newyear2022_reward", {
		activityid = self._id,
		rewardIndex = arg_4_1
	}, function(arg_5_0)
		if arg_5_0.result == 1 then
			global_ShowBlockWords(L_UNLOCK_SUCCESS)
			self:get_activity_share_info()
		end
	end)
end

function ACTIVITY_OBJ_NEW:recv_activity_newyear2022_reward()
	network:rpc("recv_activity_newyear2022_reward", {
		activityid = self._id
	}, function(arg_7_0)
		if arg_7_0.result == 1 then
			global_gain(arg_7_0)
			self:get_activity_share_info()
		end
	end)
end

function ACTIVITY_OBJ_NEW:write_activity_newyear2022_code(arg_8_1)
	network:rpc("write_activity_newyear2022_code", {
		activityid = self._id,
		redCode = arg_8_1
	}, function(arg_9_0)
		if arg_9_0.result == 1 then
			self:get_activity_share_info()
			global_ShowBlockWords(L_ORDRE_REFSH_DES.SUCCESS)
		elseif arg_9_0.result == 2 then
			global_ShowBlockWords(L_EXPLORE_EVENT_RESULT_ERROR[5])
		elseif arg_9_0.result == 3 then
			global_ShowBlockWords(L_SETTING_CDK_WARNING[3])
		elseif arg_9_0.result == 4 then
			global_ShowBlockWords(L_SETTING_CDK_WARNING[2])
		elseif arg_9_0.result == 5 then
			global_ShowBlockWords(L_SETTING_CDK_WARNING[3])
		elseif arg_9_0.result == 6 then
			global_ShowBlockWords(L_SETTING_CDK_WARNING[4])
		end
	end)
end

function ACTIVITY_OBJ_NEW:get_activity_newyear2022_share(arg_10_1, arg_10_2)
	network:rpc("get_activity_newyear2022_share", {
		activityid = self._id,
		redIndex = arg_10_1
	}, function(arg_11_0)
		if arg_11_0.result == 1 and arg_10_2 then
			arg_10_2(arg_11_0)
		end
	end)
end

function ACTIVITY_OBJ_NEW:recv_activity_newyear2022_share(arg_12_1, arg_12_2)
	network:rpc("recv_activity_newyear2022_share", {
		activityid = self._id,
		redIndex = arg_12_1,
		rewardIndex = arg_12_2
	}, function(arg_13_0)
		if arg_13_0.result == 1 then
			global_gain(arg_13_0)
			self:get_activity_share_info()
		end
	end)
end

function ACTIVITY_OBJ_NEW:getLolShareLockTime(arg_14_1)
	local var_14_0 = global_get_time_by_date(require(string.format("data.activity_%s.activity_newyear2022_const_data", self._id))["unlockredtime" .. arg_14_1].value)
	local var_14_1 = time_check_manager:getCurTime()

	if var_14_0 < var_14_1 then
		return
	end

	return var_0_5(var_14_0 - var_14_1)
end
