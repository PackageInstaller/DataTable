local network = require("network.network")
local time_check_manager = require("controller.time_check_manager")
local activity_conf_data = require("data.activity_conf_data")
local activity_explore_conf = require("data.activity_modules.activity_explore_conf")

function ACTIVITY_OBJ_NEW:get_activity_explore(arg_1_1)
	if not self:isHaveModule("explore") then
		if arg_1_1 then
			arg_1_1({
				result = 0
			})
		end

		return
	end

	if self:getStatus() ~= ACTIVITY_ACTIVING then
		if arg_1_1 then
			arg_1_1({
				result = 0
			})
		end

		return
	end

	network:rpc("get_activity_explore", {
		id = self._id
	}, function(arg_2_0)
		if arg_2_0.result == 1 then
			if arg_1_1 then
				arg_1_1(arg_2_0)
			end
		elseif arg_2_0.result == 2 then
			global_ShowBlockWords(L_ACTIVITY_OUT_OF_TIME)

			if arg_1_1 then
				arg_1_1(arg_2_0)
			end
		elseif arg_2_0.result == 0 then
			global_ShowBlockWords(L_ACTIVITY_CLOSE)

			if arg_1_1 then
				arg_1_1(arg_2_0)
			end
		else
			cclog("ERROR!!! get_activity_explore: " .. dump(arg_2_0))
		end
	end)
end

function ACTIVITY_OBJ_NEW:getExploreFinishTime()
	return activity_explore_conf[self._id].finishtime
end

function ACTIVITY_OBJ_NEW:activity_buy_explore_times(arg_4_1)
	network:rpc("activity_buy_explore_times", {
		id = self._id
	}, function(arg_5_0)
		if arg_5_0.result == 1 then
			playerModel.diamond = playerModel.diamond - arg_5_0.cost_diamond

			global_update_gold_stone_diamond(nil, nil, playerModel.diamond)

			if arg_4_1 then
				arg_4_1(arg_5_0.result, arg_5_0.buy_times)
			end

			AnalyticManager.liuli_buy_explore_times({
				cost_diamond = arg_5_0.cost_diamond
			})
		elseif arg_5_0.result == 0 then
			global_ShowBlockWords(L_ACTIVITY_CLOSE)

			if arg_4_1 then
				arg_4_1(arg_5_0.result)
			end
		elseif arg_5_0.result == 2 then
			global_ShowBlockWords(L_ACTIVITY_OUT_OF_TIME)

			if arg_4_1 then
				arg_4_1(arg_5_0.result)
			end
		elseif arg_5_0.result == 3 then
			global_ShowBlockWords(L_ACTIVITY_EXPLORE_BUY_TIMES.Used_Out)

			if arg_4_1 then
				arg_4_1(arg_5_0.result)
			end
		elseif arg_5_0.result == 4 then
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 1
			})
		end
	end)
end

function ACTIVITY_OBJ_NEW:getExplorefile()
	if self._id >= 222 then
		return string.format("activity_%s.%s", self._id, activity_explore_conf[self._id].explorefile)
	end

	return "activity_explore.activitydata." .. activity_explore_conf[self._id].explorefile
end

function ACTIVITY_OBJ_NEW:getActivityExploreConfData()
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs((require("data." .. self:getExplorefile()))) do
		if iter_7_1.valid == 1 then
			var_7_0[iter_7_1.id] = iter_7_1
		end
	end

	return var_7_0
end

function ACTIVITY_OBJ_NEW:isHasExploreMapLayer()
	return not activity_explore_conf[self._id].access_show_pop
end

function ACTIVITY_OBJ_NEW:getCurExploreId()
	for iter_9_0, iter_9_1 in pairs((require(string.format("data.activity_%s.%s", self._id, activity_explore_conf[self._id].explorefile)))) do
		local var_9_0 = time_check_manager:getCurTime()

		if (not iter_9_1.starttime or var_9_0 > global_get_time_by_date(iter_9_1.starttime)) and (not iter_9_1.finishtime or var_9_0 < global_get_time_by_date(iter_9_1.finishtime)) then
			return iter_9_1.id
		end
	end

	return 1
end
