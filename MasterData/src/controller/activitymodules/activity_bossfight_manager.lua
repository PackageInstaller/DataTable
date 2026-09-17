local activity_base_manager = require("controller.activitymodules.activity_base_manager")

function activity_base_manager.get_adventure_score(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	net:rpc("get_adventure_score", {
		mode = arg_1_1,
		modetype = arg_1_2
	}, function(arg_2_0)
		if arg_2_0.result == 1 then
			if arg_1_3 then
				arg_1_3(arg_2_0.result, arg_2_0.score, arg_2_0.modescore, arg_2_0.rank)
			end
		elseif arg_1_3 then
			arg_1_3(arg_2_0.result)
		end
	end)
end

function activity_base_manager:isLockActivityBossFight(arg_3_1)
	local var_3_0 = require("data.levelmode_data")[arg_3_1].modetype
	local var_3_1 = math.floor(var_3_0 / 10)

	if not require("data.chapter_data")[arg_3_1 .. "-" .. 1].patrol_time then
		return false
	end

	if var_3_1 >= 500 then
		return self.activities[var_3_1] and ACTIVITY_ID_TO_MODETYPE_FUNC.boss_fight(var_3_1) == var_3_0
	end

	return false
end

function activity_base_manager:get_activity_bossfight_info(arg_4_1)
	return self.activities[arg_4_1]:get_activity_bossfight_info()
end

function activity_base_manager:getBossFightRewardIndex(arg_5_1)
	return self.activities[arg_5_1]:getBossFightRewardIndex()
end

function activity_base_manager:getBossFightRewardScore(arg_6_1)
	return self.activities[arg_6_1]:getBossFightRewardScore()
end

function activity_base_manager:getBossFightRewardpercent(arg_7_1, arg_7_2)
	return self.activities[arg_7_1]:getBossFightRewardpercent(arg_7_2)
end

function activity_base_manager:getBossFightRewardList(arg_8_1)
	return self.activities[arg_8_1]:getBossFightRewardList()
end

function activity_base_manager:getBossFightLevelList(arg_9_1)
	return self.activities[arg_9_1]:getBossFightLevelList()
end

function activity_base_manager:getBossFightPatrolList(arg_10_1)
	return self.activities[arg_10_1]:getBossFightPatrolList()
end

function activity_base_manager:get_activity_bossfight_reward(arg_11_1, arg_11_2, arg_11_3)
	return self.activities[arg_11_1]:get_activity_bossfight_reward(arg_11_2, arg_11_3)
end

function activity_base_manager.getBossfightUnlockServant(arg_12_0)
	return nil
end

function activity_base_manager:getBossfightLockServants(arg_13_1, arg_13_2, arg_13_3)
	return self.activities[arg_13_1]:getBossfightLockServants(arg_13_2, arg_13_3)
end

function activity_base_manager:get_adventure_score_awards(arg_14_1, arg_14_2)
	return self.activities[arg_14_1]:get_adventure_score_awards(arg_14_2)
end

function activity_base_manager.getBossFightSocreByMode(arg_15_0, arg_15_1)
	local chapter_data = require("data.chapter_data")
	local var_15_1 = arg_15_1 .. "-" .. require("model.playermodel").levelmode[arg_15_1].status - 1

	if not chapter_data[var_15_1] then
		return 0
	end

	return chapter_data[var_15_1].passscore
end

function activity_base_manager:canStartFightBoss(arg_16_1, arg_16_2)
	local var_16_0 = math.floor(require("data.levelmode_data")[arg_16_1].modetype / 10)

	if var_16_0 < 500 then
		return true
	end

	if not self.activities[var_16_0] then
		return true
	end

	return self.activities[var_16_0]:canStartFightBoss(arg_16_1, arg_16_2)
end

function activity_base_manager:getActivityBossFightFormation(arg_17_1, arg_17_2)
	return self.activities[math.floor(require("data.levelmode_data")[arg_17_1].modetype / 10)]:getActivityBossFightFormation(arg_17_1, arg_17_2)
end
