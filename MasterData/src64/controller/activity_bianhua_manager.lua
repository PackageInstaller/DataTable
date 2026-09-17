local var_0_0 = {}
local var_0_1 = 9
local activity_manager = require("controller.activity_manager")
local bianhua_activity_level_data = require("data.bianhua_activity_level_data")
local levelmode_data = require("data.levelmode_data")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local item_data = require("data.item_data")
local task_data = require("data.task_data")
local task_index_bianhua_data = require("data.task_index_bianhua_data")
local network = require("network.network")
local activity_conf_bianhua = require("data.activity_conf_bianhua")
local level_data_1009 = require("data.leveldata.level_data_1009")

function var_0_0.get_swim_level_config(arg_1_0, arg_1_1)
	network:rpc("get_swim_level_config", {
		id = var_0_1
	}, function(arg_2_0)
		print("12341213513543135131", dump(arg_2_0))

		if arg_1_1 then
			arg_1_1(arg_2_0)
		end

		arg_1_0:save_step(arg_2_0)
	end)
end

function var_0_0.save_step(arg_3_0, arg_3_1)
	if arg_3_1.finish_step > RoleDefault:getInstance():getIntegerForKey("BAH_activity_finish_level", 0) then
		AnalyticManager.BAH_activity_finish_level({
			level = arg_3_1.finish_step
		})
		RoleDefault:getInstance():setIntegerForKey("BAH_activity_finish_level", arg_3_1.finish_step)
	end
end

function var_0_0.finish_level_talk(arg_4_0, arg_4_1, arg_4_2)
	network:rpc("finish_level_talk", {
		id = var_0_1,
		activity_level = arg_4_1
	}, function(arg_5_0)
		print("msg====", dump(arg_5_0))

		if arg_4_2 then
			arg_4_2(arg_5_0.result, arg_5_0)
		end
	end)
end

function var_0_0.getActivityExploreConfData(arg_6_0)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(bianhua_activity_level_data) do
		if iter_6_1.valid == 1 then
			var_6_0[iter_6_1.id] = iter_6_1
		end
	end

	return var_6_0
end

function var_0_0:finishLevelTalkById(arg_7_1, arg_7_2)
	print("wfwertfwefwdfsdfsdfwaertfwertgr")
	self:finish_level_talk(arg_7_1, function(arg_8_0, arg_8_1)
		if arg_8_0 ~= 1 then
			return
		end

		activity_manager:fireEvent(activity_manager.activityEventId.EXIT_FORM_TALKLAYER_KAMILA, {
			finishStep = arg_8_1.finish_step,
			diamond = arg_8_1.diamond,
			items = arg_8_1.items,
			gold = arg_8_1.gold
		})

		if arg_7_2 then
			arg_7_2()
		end
	end)
end

function var_0_0.getChapterMsg(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = {
		repeatLevel = {},
		nowChapter = {},
		chapterTitle = {}
	}

	for iter_9_0 = 1, #bianhua_activity_level_data do
		local var_9_2

		if arg_9_1 >= bianhua_activity_level_data[iter_9_0].limit_state then
			var_9_0.nowChapter.finishType = bianhua_activity_level_data[iter_9_0].finish_type
			var_9_0.nowChapter.dropDes = bianhua_activity_level_data[iter_9_0].drop_des
			var_9_0.nowChapter.id = 1

			if bianhua_activity_level_data[iter_9_0].chapter_id then
				var_9_0.chapterTitle[1] = bianhua_activity_level_data[iter_9_0].chapter_id
			end

			if bianhua_activity_level_data[iter_9_0].loop then
				local var_9_1 = {
					id = bianhua_activity_level_data[iter_9_0].id,
					materialMsg = {}
				}

				var_9_1.materialMsg.need_item1 = bianhua_activity_level_data[iter_9_0].need_item1
				var_9_1.materialMsg.need_num1 = bianhua_activity_level_data[iter_9_0].need_num1

				table.insert(var_9_0.repeatLevel, var_9_1)

				var_9_2 = 1 + 1
			end
		else
			if arg_9_2 then
				arg_9_2(var_9_0)
			end

			return var_9_0
		end
	end

	return var_9_0
end

function var_0_0.getTalkConfig(arg_10_0, arg_10_1)
	local var_10_0 = {}

	for iter_10_0 = 1, #bianhua_activity_level_data do
		if bianhua_activity_level_data[iter_10_0].chapter_id == arg_10_1 then
			var_10_0.talkid = bianhua_activity_level_data[iter_10_0].talkid
			var_10_0.levelid = iter_10_0

			return var_10_0
		end
	end

	return var_10_0
end

function var_0_0.getExploreConfig(arg_11_0, arg_11_1)
	local var_11_0 = {}

	for iter_11_0 = 1, #bianhua_activity_level_data do
		if bianhua_activity_level_data[iter_11_0].chapter_id == arg_11_1 then
			var_11_0.aimid = bianhua_activity_level_data[iter_11_0].aimid
			var_11_0.levelid = iter_11_0

			return var_11_0
		end
	end

	return var_11_0
end

function var_0_0.getRepeatLevelMsg(arg_12_0, arg_12_1)
	local var_12_0 = 0
	local var_12_1 = {}

	if arg_12_1 == 1 then
		return var_12_1
	end

	for iter_12_0 = 1, #bianhua_activity_level_data do
		if bianhua_activity_level_data[iter_12_0].loop then
			var_12_0 = var_12_0 + 1
		end

		if var_12_0 == arg_12_1 then
			var_12_1.id = bianhua_activity_level_data[iter_12_0].aimid
			var_12_1.drop = bianhua_activity_level_data[iter_12_0].drop_des
			var_12_1.needItem1 = bianhua_activity_level_data[iter_12_0].need_item1
			var_12_1.needNum1 = bianhua_activity_level_data[iter_12_0].need_num1

			return var_12_1
		end
	end
end

function var_0_0.getUnlockTime(arg_13_0, arg_13_1)
	return {
		bianhua_activity_level_data[3].starttime,
		bianhua_activity_level_data[3].starttime,
		bianhua_activity_level_data[7].starttime,
		bianhua_activity_level_data[11].starttime
	}
end

function var_0_0.totalTimesOfExtra(arg_14_0)
	return bianhua_activity_level_data[2].levelid
end

function var_0_0.restTimesOfExtra(arg_15_0)
	return 2
end

function var_0_0.isPhoneLight(arg_16_0, arg_16_1)
	if arg_16_1 >= 1 then
		return true
	else
		return false
	end
end

function var_0_0.getExtraData(arg_17_0)
	return levelmode_data[bianhua_activity_level_data[2].levelid]
end

function var_0_0.getTicketData(arg_18_0)
	return level_data_1009["1009-1-1"].ticket, level_data_1009["1009-1-1"].ticketnum
end

function var_0_0.getAchieveData(arg_19_0, arg_19_1)
	return task_data[arg_19_1]
end

function var_0_0.getActivityId(arg_20_0)
	return var_0_1
end

function var_0_0.getDataLength(arg_21_0)
	return #bianhua_activity_level_data
end

function var_0_0.getLevelModeid(arg_22_0)
	return bianhua_activity_level_data[2].levelid
end

function var_0_0.getTicketNum(arg_23_0)
	return item_manager:getItemNumber(level_data_1009["1009-1-1"].ticket)
end

function var_0_0:getLevelModelModetype()
	local levelmode_data = require("data.levelmode_data")

	return levelmode_data[self:getLevelModeid()].modetype
end

function var_0_0.activity_buy_explore_times(arg_25_0, arg_25_1)
	activity_manager:getActivityObj(var_0_1):activity_buy_explore_times(arg_25_1)
end

function var_0_0.get_explore_daily_times(arg_26_0, ...)
	return activity_conf_bianhua.explore_daily_times
end

function var_0_0.get_explore_daily_buy_times(arg_27_0, ...)
	return activity_conf_bianhua.explore_daily_buy_times
end

function var_0_0.get_buy_times_cost(arg_28_0, arg_28_1)
	return activity_conf_bianhua.buy_times_cost * arg_28_1
end

function var_0_0.getHideTaskDes(arg_29_0)
	local var_29_0 = {}

	for iter_29_0 = 1, #bianhua_activity_level_data do
		if bianhua_activity_level_data[iter_29_0].loop then
			var_29_0[1] = {}

			table.insert(var_29_0[1], bianhua_activity_level_data[iter_29_0].hide_task_des1)
			table.insert(var_29_0[1], bianhua_activity_level_data[iter_29_0].hide_task_des2)
		end
	end

	return var_29_0
end

function var_0_0.checkHideTask(arg_30_0, arg_30_1)
	if task_index_bianhua_data[task_data[arg_30_1].index].hide then
		return true
	else
		return false
	end
end

function var_0_0.checkIfHead(arg_31_0, arg_31_1)
	if item_data[arg_31_1].bag_item_type == kITEM_SCULTURE then
		return true
	else
		return false
	end
end

function var_0_0.getHeadPath(arg_32_0, arg_32_1)
	return "roleimage/role/wuji/" .. item_data[arg_32_1].image_id .. ".png"
end

function var_0_0.getFlowerNum(arg_33_0, arg_33_1)
	return drop_manager:getDropMsg(task_data[arg_33_1].drop).equips[1].dropNum
end

return var_0_0
