local var_0_0 = {}
local drop_manager = require("controller.drop_manager")
local item_manager = require("controller.item_manager")
local activity_manager = require("controller.activity_manager")
local var_0_4 = require("controller.item_manager")
local time_check_manager = require("controller.time_check_manager")
local network = require("network.network")
local playermodel = require("model.playermodel")
local adverture_random_enter_data = require("data.adverture_random_enter_data")
local var_0_9 = {
	[154] = {
		ui = true,
		bgm = SPRING_BGM
	},
	[173] = {
		ui = true
	},
	[208] = {
		ui = true
	},
	[230] = {
		ui = true,
		bgm = SPRING_BGM
	},
	[264] = {
		ui = true
	},
	[285] = {
		ui = true
	},
	[304] = {
		ui = true
	},
	[330] = {
		ui = true
	},
	[405] = {
		ui = true
	},
	[416] = {
		ui = true
	},
	[433] = {
		ui = true
	},
	[428] = {
		ui = true,
		bgm = SPRING_BGM
	},
	[436] = {
		ui = true
	},
	[451] = {
		ui = true
	},
	[457] = {
		ui = true
	},
	[462] = {
		ui = true
	},
	[471] = {
		ui = true
	},
	[481] = {
		ui = true
	},
	[490] = {
		ui = true
	},
	[492] = {
		ui = true
	},
	[500] = {
		ui = true
	},
	[507] = {
		ui = true
	},
	[511] = {
		ui = true
	}
}

function var_0_0.getCurModeType(arg_1_0)
	local var_1_0

	for iter_1_0, iter_1_1 in pairs(adverture_random_enter_data) do
		if iter_1_1.starttime and iter_1_1.finishtime then
			local var_1_1 = global_get_time_by_date(iter_1_1.finishtime)
			local var_1_2 = time_check_manager:getCurTime()

			if global_get_time_by_date(iter_1_1.starttime) <= var_1_2 and var_1_2 < var_1_1 then
				var_1_0 = iter_1_1.modetype

				break
			end
		end
	end

	return var_1_0
end

function var_0_0.getFightType(arg_2_0)
	local var_2_0

	for iter_2_0, iter_2_1 in pairs(adverture_random_enter_data) do
		if iter_2_1.starttime and iter_2_1.finishtime then
			local var_2_1 = global_get_time_by_date(iter_2_1.finishtime)
			local var_2_2 = time_check_manager:getCurTime()

			if global_get_time_by_date(iter_2_1.starttime) <= var_2_2 and var_2_2 < var_2_1 then
				var_2_0 = iter_2_1.fighttype

				break
			end
		end
	end

	return var_2_0
end

function var_0_0.getOpenTime(arg_3_0)
	local var_3_0

	for iter_3_0, iter_3_1 in pairs(adverture_random_enter_data) do
		if iter_3_1.starttime and iter_3_1.finishtime then
			local var_3_1 = global_get_time_by_date(iter_3_1.finishtime)
			local var_3_2 = time_check_manager:getCurTime()

			if global_get_time_by_date(iter_3_1.starttime) <= var_3_2 and var_3_2 < var_3_1 then
				var_3_0 = iter_3_1.starttime
			end
		end
	end

	return var_3_0, nil
end

function var_0_0.isStepAward(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1 or nil
	local var_4_1 = false

	if arg_4_1 or nil then
		local var_4_2 = require("data.adventure_score_awards.adventure_score_awards_" .. var_4_0 .. ".lua")

		if var_4_2 and var_4_2["awardmodetype_" .. var_4_0 .. "_1"] and var_4_2["awardmodetype_" .. var_4_0 .. "_1"].score then
			var_4_1 = true
		end
	end

	return var_4_1
end

function var_0_0:getRuleKey()
	local var_5_0 = self:getCurModeType()

	if not var_5_0 then
		return
	end

	local var_5_1

	for iter_5_0, iter_5_1 in pairs(adverture_random_enter_data) do
		if iter_5_1.modetype == var_5_0 and iter_5_1.rule then
			var_5_1 = iter_5_1.rule

			break
		end
	end

	return var_5_1
end

function var_0_0.getModeTypeByFightType(arg_6_0, arg_6_1)
	local var_6_0

	for iter_6_0, iter_6_1 in pairs(adverture_random_enter_data) do
		if iter_6_1.starttime and iter_6_1.finishtime and iter_6_1.fighttype and iter_6_1.fighttype == arg_6_1 and iter_6_1.fighttype and not iter_6_1.activityid then
			local var_6_1 = global_get_time_by_date(iter_6_1.finishtime)
			local var_6_2 = time_check_manager:getCurTime()

			if global_get_time_by_date(iter_6_1.starttime) <= var_6_2 and var_6_2 < var_6_1 then
				var_6_0 = iter_6_1.modetype

				break
			end
		end
	end

	return var_6_0
end

function var_0_0.getOpenTimeByModeType(arg_7_0, arg_7_1)
	local var_7_0 = -1
	local var_7_1 = -1

	if arg_7_1 then
		for iter_7_0, iter_7_1 in pairs(adverture_random_enter_data) do
			if iter_7_1.starttime and iter_7_1.finishtime and iter_7_1.modetype and iter_7_1.modetype == arg_7_1 then
				var_7_1 = iter_7_1.finishtime
				var_7_0 = iter_7_1.starttime
			end
		end
	end

	return var_7_0, var_7_1
end

function var_0_0.getRuleKeyByModeType(arg_8_0, arg_8_1)
	local var_8_0

	if arg_8_1 then
		for iter_8_0, iter_8_1 in pairs(adverture_random_enter_data) do
			if iter_8_1.rule and iter_8_1.modetype and iter_8_1.modetype == arg_8_1 then
				var_8_0 = iter_8_1.rule
			end
		end
	end

	return var_8_0
end

function var_0_0.checkIsOpenByModeType(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return false
	end

	local var_9_0 = false

	for iter_9_0, iter_9_1 in pairs(adverture_random_enter_data) do
		if iter_9_1.starttime and iter_9_1.finishtime and iter_9_1.modetype and iter_9_1.modetype == arg_9_1 then
			local var_9_1 = global_get_time_by_date(iter_9_1.finishtime)
			local var_9_2 = time_check_manager:getCurTime()

			if global_get_time_by_date(iter_9_1.starttime) <= var_9_2 and var_9_2 < var_9_1 then
				var_9_0 = true

				break
			end
		end
	end

	return var_9_0
end

function var_0_0.getFightTypeByModeType(arg_10_0, arg_10_1)
	local var_10_0

	if arg_10_1 then
		for iter_10_0, iter_10_1 in pairs(adverture_random_enter_data) do
			if iter_10_1.modetype == arg_10_1 and iter_10_1.fighttype then
				var_10_0 = iter_10_1.fighttype
			end
		end
	end

	return var_10_0
end

function var_0_0.getModeTypeByActivityId(arg_11_0, arg_11_1)
	local var_11_0

	if arg_11_1 then
		for iter_11_0, iter_11_1 in pairs(adverture_random_enter_data) do
			if iter_11_1.starttime and iter_11_1.finishtime and iter_11_1.activityid and iter_11_1.activityid == arg_11_1 and iter_11_1.modetype then
				local var_11_1 = global_get_time_by_date(iter_11_1.finishtime)
				local var_11_2 = time_check_manager:getCurTime()

				if global_get_time_by_date(iter_11_1.starttime) <= var_11_2 and var_11_2 < var_11_1 then
					var_11_0 = iter_11_1.modetype

					break
				end
			end
		end
	end

	return var_11_0
end

function var_0_0.getMaXEndTime(arg_12_0)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(adverture_random_enter_data) do
		if iter_12_1.starttime and iter_12_1.finishtime and not iter_12_1.activityid then
			local var_12_1 = global_get_time_by_date(iter_12_1.finishtime)
			local var_12_2 = time_check_manager:getCurTime()

			if global_get_time_by_date(iter_12_1.starttime) <= var_12_2 and var_12_2 < var_12_1 then
				table.insert(var_12_0, iter_12_1.finishtime)
			end
		end
	end

	local var_12_3

	if next(var_12_0) then
		for iter_12_2, iter_12_3 in pairs(var_12_0) do
			if 0 < global_get_time_by_date(iter_12_3) then
				local var_12_4 = global_get_time_by_date(iter_12_3)

				var_12_3 = iter_12_3
			end
		end
	end

	return var_12_3
end

function var_0_0.getRuleKeyByModeType(arg_13_0, arg_13_1)
	local var_13_0

	if arg_13_1 then
		for iter_13_0, iter_13_1 in pairs(adverture_random_enter_data) do
			if iter_13_1.starttime and iter_13_1.finishtime and iter_13_1.modetype and iter_13_1.modetype == arg_13_1 and iter_13_1.rule then
				var_13_0 = iter_13_1.rule

				break
			end
		end
	end

	return var_13_0
end

function var_0_0.isHaveNewUI(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return false
	end

	local var_14_0 = false

	for iter_14_0, iter_14_1 in pairs(adverture_random_enter_data) do
		if iter_14_1.modetype and iter_14_1.modetype == arg_14_1 and iter_14_1.activityid then
			var_14_0 = iter_14_1.activityid
		end
	end

	return (var_14_0 and var_0_9[var_14_0] and var_0_9[var_14_0].ui or nil) and true, var_14_0
end

function var_0_0:getActivityBgm(arg_15_1)
	if not arg_15_1 then
		return false
	end

	local var_15_1, var_15_2 = self:isHaveNewUI(arg_15_1)

	return (var_15_1 and var_15_2 and var_0_9[var_15_2] and var_0_9[var_15_2].bgm or nil) and var_0_9[var_15_2].bgm
end

return var_0_0
