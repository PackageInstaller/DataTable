local var_0_0 = {}
local network = require("network.network")

var_0_0.eventHandlers = {}
var_0_0.EVENT_IDS = require("common.Utility"):enumeration({
	"DECOMPOSE_ITEMS",
	"COMPOUND_ITEM_ONE_KEY",
	"GET_COURSE_DATA",
	"COURSE_LEVEL_UP",
	"COURSE_RESET",
	"GET_ACTIVITY_TASK_LIST",
	"GET_ACTIVITY_TASK_REWARD",
	"GET_SERVANT_RANK",
	"GET_SERVANT_BEST_TEAMMATE",
	"GET_INVITE_INFO",
	"BIND_INVITE_UID",
	"TERMINATE_BIND_UID",
	"GET_INVITE_TASK_INFO",
	"GET_INVITE_TASK_REWARD",
	"GET_DAILY_RECHARGE_NUM",
	"GET_WEEKLY_TOWER_INFO",
	"SET_WEEKLY_TOWER_SKILL",
	"GET_VISIT_CARD_INFO",
	"SET_VISITCARD",
	"GET_DAILY_TASK_INFO",
	"GET_DAILY_TASK_ACTIVE_NUM",
	"GET_DAILY_TASK_REWARD"
})

function var_0_0:subscribe(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.eventHandlers = self.eventHandlers or {}
	self.eventHandlers[arg_1_1] = self.eventHandlers[arg_1_1] or {}
	self.eventHandlers[arg_1_1][arg_1_2] = {
		func = arg_1_3,
		priority = arg_1_4 or 0
	}
end

function var_0_0:triggerEvent(arg_2_1, ...)
	if not self.eventHandlers then
		return
	end

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs(self.eventHandlers) do
		if iter_2_1[arg_2_1] then
			var_2_0[#var_2_0 + 1] = iter_2_1[arg_2_1]
		end
	end

	table.sort(var_2_0, function(arg_3_0, arg_3_1)
		return arg_3_0.priority > arg_3_1.priority
	end)

	for iter_2_2, iter_2_3 in ipairs(var_2_0) do
		iter_2_3.func(...)
	end
end

function var_0_0:unsubscribe(arg_4_1, arg_4_2)
	if not arg_4_1 then
		return
	end

	if arg_4_2 then
		self.eventHandlers[arg_4_1][arg_4_2] = nil
	else
		self.eventHandlers[arg_4_1] = nil
	end
end

function var_0_0.unsubscribeAll(arg_5_0)
	arg_5_0.eventHandlers = {}
end

function var_0_0.requestDecomposeItems(arg_6_0, arg_6_1, arg_6_2)
	network:rpc("operate_item", {
		id = arg_6_1,
		num = arg_6_2
	}, function(...)
		arg_6_0:triggerEvent(var_0_0.EVENT_IDS.DECOMPOSE_ITEMS, ...)
	end)
end

function var_0_0.requestCompoundItemOneKey(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	network:rpc("compound_item_one_key", {
		tp = arg_8_1,
		id = arg_8_2,
		num = arg_8_3
	}, function(...)
		arg_8_0:triggerEvent(var_0_0.EVENT_IDS.COMPOUND_ITEM_ONE_KEY, ...)
	end)
end

function var_0_0.requestActivityTaskList(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	network:rpc("get_activity_tasklist", {
		id = arg_10_1,
		stage = arg_10_2,
		isautoget = arg_10_3,
		statkey = arg_10_4,
		usemodule = arg_10_5
	}, function(...)
		arg_10_0:triggerEvent(var_0_0.EVENT_IDS.GET_ACTIVITY_TASK_LIST, ...)
	end)
end

function var_0_0.requestActivityTaskReward(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	network:rpc("get_activity_task_award", {
		id = arg_12_1,
		taskid = arg_12_2,
		show_type = arg_12_3
	}, function(...)
		arg_12_0:triggerEvent(var_0_0.EVENT_IDS.GET_ACTIVITY_TASK_REWARD, ...)
	end)
end

function var_0_0.requestGetServantRank(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6)
	network:rpc("get_servant_rank", {
		type = arg_14_1,
		mode = arg_14_2,
		chapter = arg_14_3,
		subpvp = arg_14_4,
		offset = arg_14_5,
		count = arg_14_6
	}, function(...)
		arg_14_0:triggerEvent(var_0_0.EVENT_IDS.GET_SERVANT_RANK, ...)
	end)
end

function var_0_0.requestGetServantBestTeammate(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6)
	network:rpc("get_servant_best_teammate", {
		type = arg_16_1,
		mode = arg_16_2,
		chapter = arg_16_3,
		subpvp = arg_16_4,
		servantid = arg_16_5,
		count = arg_16_6
	}, function(...)
		arg_16_0:triggerEvent(var_0_0.EVENT_IDS.GET_SERVANT_BEST_TEAMMATE, ...)
	end)
end

function var_0_0.requestGetCourseData(arg_18_0, arg_18_1)
	network:rpc("get_course_data", {
		class_type = arg_18_1
	}, function(...)
		arg_18_0:triggerEvent(var_0_0.EVENT_IDS.GET_COURSE_DATA, ...)
	end)
end

function var_0_0.requestCourseLevleUp(arg_20_0, arg_20_1)
	network:rpc("course_levelup", {
		courseid = arg_20_1
	}, function(...)
		arg_20_0:triggerEvent(var_0_0.EVENT_IDS.COURSE_LEVEL_UP, ...)
	end)
end

function var_0_0.requestCourseReset(arg_22_0, arg_22_1, arg_22_2)
	network:rpc("course_reset", {
		class_type = arg_22_1,
		courseid = arg_22_2
	}, function(...)
		arg_22_0:triggerEvent(var_0_0.EVENT_IDS.COURSE_RESET, ...)
	end)
end

function var_0_0.requestGetInviteInfo(arg_24_0)
	network:rpc("get_invite_info", {}, function(...)
		arg_24_0:triggerEvent(var_0_0.EVENT_IDS.GET_INVITE_INFO, ...)
	end)
end

function var_0_0.requestBindInviteUID(arg_26_0, arg_26_1)
	network:rpc("invite_binduid", {
		binduid = arg_26_1
	}, function(...)
		arg_26_0:triggerEvent(var_0_0.EVENT_IDS.BIND_INVITE_UID, ...)
	end)
end

function var_0_0.requestTerminateBindUID(arg_28_0, arg_28_1)
	network:rpc("terminate_binduid", {
		binduid = arg_28_1
	}, function(...)
		arg_28_0:triggerEvent(var_0_0.EVENT_IDS.TERMINATE_BIND_UID, ...)
	end)
end

function var_0_0.requestGetInviteTaskInfo(arg_30_0, arg_30_1)
	network:rpc("get_invite_task_info", {
		type = arg_30_1
	}, function(...)
		arg_30_0:triggerEvent(var_0_0.EVENT_IDS.GET_INVITE_TASK_INFO, ...)
	end)
end

function var_0_0.requestGetInviteTaskReward(arg_32_0, arg_32_1)
	network:rpc("get_task_reward", {
		taskid = arg_32_1
	}, function(...)
		arg_32_0:triggerEvent(var_0_0.EVENT_IDS.GET_INVITE_TASK_REWARD, ...)
	end)
end

function var_0_0.requestGetDailyRechargeNum(arg_34_0)
	network:rpc("get_recharge_money", {}, function(...)
		arg_34_0:triggerEvent(var_0_0.EVENT_IDS.GET_DAILY_RECHARGE_NUM, ...)
	end)
end

function var_0_0.requestGetWeeklyTowerInfo(arg_36_0)
	network:rpc("get_weektower_info", {}, function(...)
		arg_36_0:triggerEvent(var_0_0.EVENT_IDS.GET_WEEKLY_TOWER_INFO, ...)
	end)
end

function var_0_0.requestSetWeeklyTowerSkill(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	network:rpc("set_weektower_skill", {
		cityid = arg_38_1,
		chapterid = arg_38_2,
		skillid = arg_38_3
	}, function(...)
		arg_38_0:triggerEvent(var_0_0.EVENT_IDS.SET_WEEKLY_TOWER_SKILL, ...)
	end)
end

function var_0_0.requestGetVisitcardInfo(arg_40_0)
	network:rpc("get_visitcard_info", {}, function(...)
		arg_40_0:triggerEvent(var_0_0.EVENT_IDS.GET_VISIT_CARD_INFO, ...)
	end)
end

function var_0_0.requestSetVisitCard(arg_42_0, arg_42_1)
	network:rpc("set_visitcard", {
		cardid = arg_42_1
	}, function(...)
		arg_42_0:triggerEvent(var_0_0.EVENT_IDS.SET_VISITCARD, ...)
	end)
end

function var_0_0.requestGetDailyTaskInfo(arg_44_0)
	network:rpc("get_daily_task_info", {}, function(...)
		arg_44_0:triggerEvent(var_0_0.EVENT_IDS.GET_DAILY_TASK_INFO, ...)
	end)
end

function var_0_0.requestGetDailyTaskActiveNum(arg_46_0, arg_46_1)
	network:rpc("get_daily_task_active_num", {
		taskid = arg_46_1
	}, function(...)
		arg_46_0:triggerEvent(var_0_0.EVENT_IDS.GET_DAILY_TASK_ACTIVE_NUM, ...)
	end)
end

function var_0_0.requestGetDailyTaskReward(arg_48_0)
	network:rpc("get_daily_task_reward", {}, function(...)
		arg_48_0:triggerEvent(var_0_0.EVENT_IDS.GET_DAILY_TASK_REWARD, ...)
	end)
end

return var_0_0
