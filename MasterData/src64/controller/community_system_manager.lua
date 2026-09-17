local var_0_0 = {}
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local network = require("network.network")
local family_privilege_data = require("data.family_privilege_data")
local family_tag_data = require("data.family_tag_data")
local family_level_data = require("data.family_level_data")
local family_other_data = require("data.family_other_data")
local family_donate_data = require("data.family_donate_data")
local family_building_data = require("data.family_building_data")
local family_role_talk_data = require("data.family_role_talk_data")
local family_pt_data = require("data.family_pt_data")
local family_wish_data = require("data.family_wish_data")
local task_family_data = require("data.task_family_data")
local task_index_dailyfamily_data = require("data.task_index_dailyfamily_data")
local task_data = require("data.task_data")
local playermodel = require("model.playermodel")
local chat_system_manager = require("controller.chat_system_manager")
local task_manager = require("controller.task_manager")
local drop_data = require("data.drop_data")
local item_manager = require("controller.item_manager")

var_0_0.recommend_list = {}
var_0_0.search_list = {}
var_0_0.search_left_list = {}
var_0_0.applying_list = {}
var_0_0.community_applying_list = {}
var_0_0.community_member_list = {}
var_0_0.commity_chat_data_list = {}
var_0_0.isrepateonline = true

local var_0_21 = 1201001

var_0_0.exp = 0
var_0_0.money = 0
var_0_0.level = 1
var_0_0.curfamilyid = nil
var_0_0.isptaward = false
var_0_0.isauditnew = false
var_0_0.nextapplytime = 0
var_0_0.curposition = 10
var_0_0.curawardstatus = 0
var_0_0.active_weekly = 0
var_0_0.danationstayus = 0
var_0_0.danations_times = {
	0,
	0,
	0
}
var_0_0.buildings = {
	0,
	0,
	0
}
var_0_0.slogan = ""
var_0_0.commity_chat_cd = 0
var_0_0.record_list_sz = {}
var_0_0.record_list_jz = {}
var_0_0.sortdownup = 1
var_0_0.sorttype = 1
var_0_0.labelindex = {}
var_0_0.verityid = nil
var_0_0.wishfilterparam = {
	0,
	0
}
var_0_0.membersortdownup = 1
var_0_0.membersorttype = 1
var_0_0.search_num = 1

function var_0_0.get_family_recommend_list(arg_1_0, arg_1_1)
	network:rpc("get_family_recommend_list", nil, function(arg_2_0)
		if arg_2_0.result == 1 then
			arg_1_0.recommend_list = arg_2_0.list

			if arg_1_1 then
				arg_1_1(arg_2_0)
			end
		elseif arg_1_1 then
			arg_1_1(arg_2_0)
		end
	end)
end

function var_0_0.search_family(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_2 = arg_3_2 or 1

	network:rpc("search_family", {
		word = arg_3_1,
		page = arg_3_2
	}, function(arg_4_0)
		if arg_4_0.result == 1 then
			if arg_4_0.list and next(arg_4_0.list) then
				for iter_4_0, iter_4_1 in pairs(arg_4_0.list) do
					table.insert(arg_3_0.search_list, iter_4_1)
				end
			end

			if arg_4_0.remain <= 0 then
				if arg_3_3 then
					arg_3_3(arg_4_0.result, arg_3_0.search_list)
				end
			else
				arg_3_0.search_num = arg_3_0.search_num + 1

				arg_3_0:search_family(arg_3_1, arg_3_0.search_num, arg_3_3)
			end
		elseif arg_3_3 then
			arg_3_3(arg_4_0.result)
		end
	end)
end

function var_0_0.get_family_base_info(arg_5_0, arg_5_1)
	network:rpc("get_family_base_info", nil, function(arg_6_0)
		if arg_6_0.result == 1 then
			arg_5_0.exp = arg_6_0.exp
			arg_5_0.money = arg_6_0.money
			arg_5_0.curfamilyid = arg_6_0.familyid
			arg_5_0.curposition = arg_6_0.title
			arg_5_0.curawardstatus = arg_6_0.award_flag
			arg_5_0.active_weekly = arg_6_0.active_weekly
			arg_5_0.danationstayus = arg_6_0.contribute
			arg_5_0.buildings = arg_6_0.buildings
			arg_5_0.level = arg_6_0.level
			arg_5_0.slogan = arg_6_0.slogan
			arg_5_0.threshold_type = arg_6_0.threshold_type
			arg_5_0.threshold_value = arg_6_0.threshold_value
			arg_5_0.audit_type = arg_6_0.audit_type

			arg_5_0:setDonationDaliyStatus()

			if arg_5_1 then
				arg_5_1(arg_6_0)
			end
		elseif arg_5_1 then
			arg_5_1(arg_6_0)
		end
	end)
end

function var_0_0.get_family_members(arg_7_0, arg_7_1, arg_7_2)
	network:rpc("get_family_members", {
		familyid = arg_7_1
	}, function(arg_8_0)
		if arg_8_0.result == 1 then
			arg_7_0.community_member_list = arg_8_0.list

			if arg_7_2 then
				arg_7_2(arg_8_0)
			end
		elseif arg_7_2 then
			arg_7_2(arg_8_0)
		end
	end)
end

function var_0_0.apply_join_family(arg_9_0, arg_9_1, arg_9_2)
	network:rpc("apply_join_family", {
		familyid = arg_9_1
	}, function(arg_10_0)
		if arg_10_0.result == 1 then
			if arg_9_2 then
				arg_9_2(arg_10_0)
			end
		elseif arg_9_2 then
			arg_9_2(arg_10_0)
		end
	end)
end

function var_0_0.cancel_family_application(arg_11_0, arg_11_1, arg_11_2)
	network:rpc("cancel_family_application", {
		familyid = arg_11_1
	}, function(arg_12_0)
		if arg_12_0.result == 1 then
			if arg_11_2 then
				arg_11_2(arg_12_0)
			end
		elseif arg_11_2 then
			arg_11_2(arg_12_0)
		end
	end)
end

function var_0_0.create_family(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6)
	network:rpc("create_family", {
		familyname = arg_13_1,
		flag = arg_13_2,
		threshold_type = arg_13_3,
		threshold_value = arg_13_4,
		audit_type = arg_13_5
	}, function(arg_14_0)
		if arg_14_0.result == 1 then
			if arg_14_0.consumes then
				for iter_14_0, iter_14_1 in ipairs(arg_14_0.consumes) do
					item_manager:deleteItem(iter_14_1.entityid, iter_14_1.num)
				end
			end

			if arg_14_0.diamond then
				playermodel.diamond = playermodel.diamond - arg_14_0.diamond

				global_update_gold_stone_diamond(nil, nil, arg_14_0.diamond)
			end

			if arg_13_6 then
				arg_13_6(arg_14_0)
			end
		elseif arg_13_6 then
			arg_13_6(arg_14_0)
		end
	end)
end

function var_0_0.update_family_setting(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	network:rpc("update_family_setting", {
		familyid = arg_15_1,
		setting = arg_15_2
	}, function(arg_16_0)
		if arg_16_0.result == 1 then
			if arg_16_0.consumes then
				for iter_16_0, iter_16_1 in ipairs(arg_16_0.consumes) do
					item_manager:deleteItem(iter_16_1.entityid, iter_16_1.num)
				end
			end

			if arg_16_0.diamond then
				playermodel.diamond = playermodel.diamond - arg_16_0.diamond

				global_update_gold_stone_diamond(nil, nil, arg_16_0.diamond)
			end

			if arg_15_3 then
				arg_15_3(arg_16_0)
			end
		elseif arg_15_3 then
			arg_15_3(arg_16_0)
		end
	end)
end

function var_0_0.get_family_applications(arg_17_0, arg_17_1)
	network:rpc("get_family_applications", nil, function(arg_18_0)
		if arg_18_0.result == 1 then
			arg_17_0.community_applying_list = arg_18_0.list

			arg_17_0:updateApplyStatus()

			if arg_17_1 then
				arg_17_1(arg_18_0)
			end
		elseif arg_17_1 then
			arg_17_1(arg_18_0)
		end
	end)
end

function var_0_0.audit_family_application(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	network:rpc("audit_family_application", {
		ids = arg_19_1,
		type = arg_19_2
	}, function(arg_20_0)
		if arg_20_0.result == 1 then
			if arg_19_3 then
				arg_19_3(arg_20_0)
			end
		elseif arg_19_3 then
			arg_19_3(arg_20_0)
		end
	end)
end

function var_0_0.manage_family_title(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	network:rpc("manage_family_title", {
		playerid = arg_21_1,
		title = arg_21_2
	}, function(arg_22_0)
		if arg_22_0.result == 1 then
			if arg_21_3 then
				arg_21_3(arg_22_0)
			end
		elseif arg_21_3 then
			arg_21_3(arg_22_0)
		end
	end)
end

function var_0_0.kick_family_member(arg_23_0, arg_23_1, arg_23_2)
	network:rpc("kick_family_member", {
		playerid = arg_23_1,
		title = title
	}, function(arg_24_0)
		if arg_24_0.result == 1 then
			if arg_23_2 then
				arg_23_2(arg_24_0)
			end
		elseif arg_23_2 then
			arg_23_2(arg_24_0)
		end
	end)
end

function var_0_0.leave_family(arg_25_0, arg_25_1)
	network:rpc("leave_family", nil, function(arg_26_0)
		if arg_26_0.result == 1 then
			if arg_25_1 then
				arg_25_1(arg_26_0)
			end
		elseif arg_25_1 then
			arg_25_1(arg_26_0)
		end
	end)
end

function var_0_0.get_family_player_applications(arg_27_0, arg_27_1)
	network:rpc("get_family_player_applications", nil, function(arg_28_0)
		if arg_28_0.result == 1 then
			arg_27_0.applying_list = arg_28_0.list

			if arg_27_1 then
				arg_27_1(arg_28_0)
			end
		elseif arg_27_1 then
			arg_27_1(arg_28_0)
		end
	end)
end

function var_0_0.get_family_log(arg_29_0, arg_29_1)
	network:rpc("get_family_log", nil, function(arg_30_0)
		if arg_30_0.result == 1 then
			if arg_29_1 then
				arg_29_1(arg_30_0)
			end
		elseif arg_29_1 then
			arg_29_1(arg_30_0)
		end
	end)
end

function var_0_0.make_family_contribute(arg_31_0, arg_31_1, arg_31_2)
	network:rpc("make_family_contribute", {
		type = arg_31_1
	}, function(arg_32_0)
		if arg_32_0.result == 1 then
			if arg_32_0.consumes then
				for iter_32_0, iter_32_1 in ipairs(arg_32_0.consumes) do
					item_manager:deleteItem(iter_32_1.entityid, iter_32_1.num)
				end
			end

			if arg_32_0.diamond_cost then
				playermodel.diamond = playermodel.diamond - arg_32_0.diamond_cost

				global_update_gold_stone_diamond(nil, nil, arg_32_0.diamond_cost)
			end

			if arg_32_0.gold_cost and arg_32_0.gold_cost > 0 then
				playermodel.gold = playermodel.gold - arg_32_0.gold_cost

				global_update_gold_stone_diamond(arg_32_0.gold_cost)
			end

			for iter_32_2, iter_32_3 in ipairs(arg_32_0.items) do
				if iter_32_3.itemtype and iter_32_3.itemtype == 120 and iter_32_3.itemid then
					iter_32_3.entityid = iter_32_3.itemid

					if iter_32_3.itemcount and iter_32_3.itemcount > 0 then
						arg_31_0:updaPlayerPtValue(iter_32_3.itemcount)
					end
				end
			end

			if arg_32_0.gold and arg_32_0.gold > 0 or arg_32_0.diamond and arg_32_0.diamond > 0 or arg_32_0.items then
				global_gain({
					sp = arg_32_0.gold,
					gold = arg_32_0.diamond,
					items = arg_32_0.items
				})
			end

			if arg_31_2 then
				arg_31_2(arg_32_0)
			end
		elseif arg_31_2 then
			arg_31_2(arg_32_0)
		end
	end)
end

function var_0_0.get_family_data(arg_33_0, arg_33_1)
	network:rpc("get_family_data", nil, function(arg_34_0)
		print("KKKKKKKKKKKKKKget_family_dataKKKKKKKKKKKKKKKKKKKKKKKK", dump(arg_34_0))

		arg_33_0.curfamilyid = arg_34_0.familyid
		arg_33_0.isptaward = arg_34_0.rp_award
		arg_33_0.isauditnew = arg_34_0.rp_audit
		arg_33_0.nextapplytime = arg_34_0.next_apply_time
		arg_33_0.closecommity = arg_34_0.result == 9999

		if arg_33_1 then
			arg_33_1(arg_34_0)
		end

		require("controller.alert_manager"):updataCommnityBtnAlert()
	end)
end

function var_0_0.get_family_pt_reward(arg_35_0, arg_35_1, arg_35_2)
	network:rpc("get_family_pt_reward", {
		index = arg_35_1
	}, function(arg_36_0)
		if arg_36_0.result == 1 then
			if arg_36_0.gold and arg_36_0.gold > 0 or arg_36_0.diamond and arg_36_0.diamond > 0 or arg_36_0.items then
				global_gain({
					gold = arg_36_0.gold,
					diamond = arg_36_0.diamond,
					items = arg_36_0.items
				})
			end

			if arg_35_2 then
				arg_35_2(arg_36_0)
			end
		elseif arg_35_2 then
			arg_35_2(arg_36_0)
		end
	end)
end

function var_0_0.get_family_chat_history(arg_37_0, arg_37_1, arg_37_2)
	network:rpc("get_family_chat_history", {
		msgid = arg_37_1
	}, function(arg_38_0)
		if arg_38_0.result == 1 then
			if arg_38_0.list and next(arg_38_0.list) then
				for iter_38_0, iter_38_1 in pairs(arg_38_0.list) do
					table.insert(arg_37_0.commity_chat_data_list, iter_38_1)
				end
			end

			if not arg_38_0.more then
				arg_37_0.isrepateonline = false

				if arg_37_2 then
					arg_37_2(arg_38_0.result, arg_37_0.commity_chat_data_list)
				end
			else
				local var_38_0 = (function(arg_39_0)
					if not arg_39_0 or not next(arg_39_0) then
						return false
					end

					local var_39_0 = arg_39_0[1].msgid

					for iter_39_0 = 2, #arg_39_0 do
						if arg_39_0[iter_39_0] and var_39_0 > arg_39_0[iter_39_0].msgid then
							var_39_0 = arg_39_0[iter_39_0].msgid
						end
					end

					return var_39_0
				end)(arg_38_0.list)

				if var_38_0 then
					arg_37_0:get_family_chat_history(var_38_0, arg_37_2)
				end
			end
		elseif arg_37_2 then
			arg_37_2(arg_38_0.result)
		end
	end)
end

function var_0_0.family_building_levelup(arg_40_0, arg_40_1, arg_40_2)
	network:rpc("family_building_levelup", {
		id = arg_40_1
	}, function(arg_41_0)
		if arg_41_0.result == 1 then
			arg_40_0.money = arg_41_0.familymoney

			arg_40_0:updateBuilding(arg_40_1, arg_41_0.lv)
		end

		if arg_40_2 then
			arg_40_2(arg_41_0)
		end
	end)
end

function var_0_0.family_chat(arg_42_0, arg_42_1, arg_42_2)
	network:rpc("family_chat", {
		msg = arg_42_1
	}, function(arg_43_0)
		if arg_43_0.result == 1 then
			arg_42_0.commity_chat_cd = time_check_manager:getCurTime() + chat_system_manager:getChatCD(2)
		end

		if arg_42_2 then
			arg_42_2(arg_43_0.result)
		end
	end)
end

function var_0_0.get_family_contribute_info(arg_44_0, arg_44_1)
	network:rpc("get_family_contribute_info", nil, function(arg_45_0)
		if arg_44_1 then
			arg_44_1(arg_45_0)
		end
	end)
end

function var_0_0.get_family_task_info(arg_46_0, arg_46_1)
	task_manager:get_player_tasks_by_type(TASK_TYPE_FAMILY_DAILY, function()
		task_manager:generate_commity_task_info()

		if arg_46_1 then
			arg_46_1()
		end
	end)
end

function var_0_0.get_family_task_award(arg_48_0, arg_48_1, arg_48_2)
	task_manager:getTaskReward(arg_48_1, function(arg_49_0, arg_49_1)
		if arg_49_0 == 1 then
			task_manager:generate_commity_task_info()

			if arg_48_2 then
				arg_48_2(arg_49_0, arg_49_1)
			end
		elseif arg_48_2 then
			arg_48_2(arg_49_0)
		end
	end)
end

function var_0_0.get_family_wish_info(arg_50_0, arg_50_1)
	network:rpc("get_family_wish_info", nil, function(arg_51_0)
		if arg_51_0.result == 1 then
			arg_50_0.wishlist = arg_51_0.list

			if arg_50_1 then
				arg_50_1(arg_51_0)
			end
		elseif arg_50_1 then
			arg_50_1(arg_51_0)
		end
	end)
end

function var_0_0.get_family_wish_num(arg_52_0, arg_52_1)
	network:rpc("get_family_wish_num", nil, function(arg_53_0)
		if arg_53_0.result == 1 then
			arg_52_0.rcw_num = arg_53_0.family_wish_count
			arg_52_0.rcz_num = arg_53_0.family_give_count
			arg_52_0.hdw_num = arg_53_0.activity_wish_count
			arg_52_0.hdz_num = arg_53_0.activity_give_count

			if arg_52_1 then
				arg_52_1(arg_53_0)
			end
		elseif arg_52_1 then
			arg_52_1(arg_53_0)
		end
	end)
end

function var_0_0.send_wish_to_member(arg_54_0, arg_54_1, arg_54_2)
	network:rpc("do_family_wish_give", {
		id = arg_54_1
	}, function(arg_55_0)
		if arg_55_0.result == 1 then
			if arg_55_0.consumes then
				for iter_55_0, iter_55_1 in ipairs(arg_55_0.consumes) do
					item_manager:deleteItem(iter_55_1.entityid, iter_55_1.num)
				end
			end

			if arg_55_0.diamond_cost then
				playermodel.diamond = playermodel.diamond - arg_55_0.diamond_cost

				global_update_gold_stone_diamond(nil, nil, arg_55_0.diamond_cost)
			end

			if arg_55_0.gold_cost and arg_55_0.gold_cost > 0 then
				playermodel.gold = playermodel.gold - arg_55_0.gold_cost

				global_update_gold_stone_diamond(arg_55_0.gold_cost)
			end

			if arg_55_0.gold and arg_55_0.gold > 0 or arg_55_0.diamond and arg_55_0.diamond > 0 or arg_55_0.items then
				global_gain({
					sp = arg_55_0.gold,
					gold = arg_55_0.diamond,
					items = arg_55_0.items
				})
			end

			arg_54_0:updateWishData(arg_54_1)

			if arg_54_2 then
				arg_54_2(arg_55_0)
			end
		elseif arg_54_2 then
			arg_54_2(arg_55_0)
		end
	end)
end

function var_0_0.make_wish_to_member(arg_56_0, arg_56_1, arg_56_2, arg_56_3, arg_56_4)
	network:rpc("do_family_wish_make", {
		wishid = arg_56_1
	}, function(arg_57_0)
		print("------------------------------------------>", dump(arg_57_0))

		if arg_57_0.result == 1 then
			arg_56_0:updateWishTimes(arg_56_2, arg_56_3)

			if arg_56_4 then
				arg_56_4(arg_57_0)
			end
		elseif arg_56_4 then
			arg_56_4(arg_57_0)
		end
	end)
end

function var_0_0.get_family_wish_record1(arg_58_0, arg_58_1)
	network:rpc("get_family_wish_record1", nil, function(arg_59_0)
		if arg_59_0.result == 1 then
			arg_58_0.record_list_sz = arg_59_0.list

			table.sort(arg_58_0.record_list_sz, function(arg_60_0, arg_60_1)
				return arg_60_0.record_time > arg_60_1.record_time
			end)
			arg_58_0:updateRecordRedStatus()

			if arg_58_1 then
				arg_58_1(arg_59_0)
			end
		elseif arg_58_1 then
			arg_58_1(arg_59_0)
		end
	end)
end

function var_0_0.get_family_wish_record2(arg_61_0, arg_61_1)
	network:rpc("get_family_wish_record2", nil, function(arg_62_0)
		if arg_62_0.result == 1 then
			arg_61_0.record_list_jz = arg_62_0.list

			table.sort(arg_61_0.record_list_jz, function(arg_63_0, arg_63_1)
				return arg_63_0.record_time > arg_63_1.record_time
			end)
			arg_61_0:updateRecordRedStatus()

			if arg_61_1 then
				arg_61_1(arg_62_0)
			end
		elseif arg_61_1 then
			arg_61_1(arg_62_0)
		end
	end)
end

function var_0_0.wish_management_operator(arg_64_0, arg_64_1, arg_64_2, arg_64_3)
	network:rpc("do_family_wish_other", {
		recordid = arg_64_1,
		tp = arg_64_2
	}, function(arg_65_0)
		if arg_65_0.result == 1 then
			if arg_65_0.gold and arg_65_0.gold > 0 or arg_65_0.diamond and arg_65_0.diamond > 0 or arg_65_0.items then
				global_gain({
					sp = arg_65_0.gold,
					gold = arg_65_0.diamond,
					items = arg_65_0.items
				})
			end

			arg_64_0:updateRecordData(arg_64_1, arg_64_2)

			if arg_64_3 then
				arg_64_3(arg_65_0)
			end
		elseif arg_64_3 then
			arg_64_3(arg_65_0)
		end
	end)
end

function var_0_0.resetCommunityListParam(arg_66_0)
	arg_66_0.commity_chat_data_list = {}
end

function var_0_0:getCommunityChatData()
	if self.commity_chat_data_list and next(self.commity_chat_data_list) then
		table.sort(self.commity_chat_data_list, function(arg_68_0, arg_68_1)
			return arg_68_0.msgid < arg_68_1.msgid
		end)
	end

	local var_67_0 = {}
	local var_67_1 = {}

	for iter_67_0, iter_67_1 in ipairs(self.commity_chat_data_list) do
		var_67_0[iter_67_1.msgid] = var_67_0[iter_67_1.msgid] or iter_67_1
	end

	for iter_67_2, iter_67_3 in pairs(var_67_0) do
		table.insert(var_67_1, iter_67_3)
	end

	if next(var_67_1) then
		table.sort(var_67_1, function(arg_69_0, arg_69_1)
			return arg_69_0.msgid < arg_69_1.msgid
		end)
	end

	self.commity_chat_data_list = var_67_1

	return self.commity_chat_data_list
end

function var_0_0:getCommunityChatFalg()
	return self.isrepateonline
end

function var_0_0.resetCommunityChatFalg(arg_71_0)
	arg_71_0.isrepateonline = true
end

function var_0_0:updateCommunityChatData(arg_72_1)
	if arg_72_1 and arg_72_1 == 2 then
		self.commity_chat_data_list = {}

		self:resetCommunityChatFalg()

		return
	end

	local var_72_0

	if self.commity_chat_data_list and next(self.commity_chat_data_list) then
		var_72_0 = self.commity_chat_data_list[#self.commity_chat_data_list]
	end

	if not arg_72_1 or not next(arg_72_1) then
		return
	end

	local var_72_2 = arg_72_1[1] or nil

	table.sort(arg_72_1, function(arg_73_0, arg_73_1)
		return arg_73_0.msgid < arg_73_1.msgid
	end)

	for iter_72_0, iter_72_1 in ipairs(arg_72_1) do
		table.insert(self.commity_chat_data_list, iter_72_1)
	end

	if var_72_0 and var_72_2 and var_72_0.msgid > var_72_2.msgid then
		self.commity_chat_data_list = {}

		self:resetCommunityChatFalg()
	end
end

function var_0_0:getRecommendList()
	return self.recommend_list
end

function var_0_0:getSearchList()
	return self.search_list
end

function var_0_0:getApplyingList()
	return self.applying_list
end

function var_0_0:getLevelExp()
	return self.exp
end

function var_0_0:getCommunityMoney()
	return self.money
end

function var_0_0:updateCommunityMoney(arg_79_1)
	if not arg_79_1 then
		return
	end

	self.money = arg_79_1 + self.money
end

function var_0_0:getCommunityMemberList()
	return self.community_member_list
end

function var_0_0:getCurfamilyid()
	return self.curfamilyid
end

function var_0_0:getCurfamilyPostion()
	return self.curposition
end

function var_0_0.updateCurfamilyPostion(arg_83_0, arg_83_1)
	if arg_83_1 then
		arg_83_0.curposition = arg_83_1
	end
end

function var_0_0.resetSearchListParam(arg_84_0)
	arg_84_0.search_list = {}
	arg_84_0.search_left_list = {}
	arg_84_0.search_num = 1
end

function var_0_0:getCommunityStatus(arg_85_1)
	if not arg_85_1 then
		return
	end

	for iter_85_0, iter_85_1 in ipairs(self.applying_list) do
		if iter_85_1.family and iter_85_1.family.familyid and iter_85_1.family.familyid == arg_85_1 then
			return iter_85_1.status
		end
	end
end

function var_0_0:updateCommunityStatus(arg_86_1, arg_86_2)
	if not arg_86_1 then
		return
	end

	local var_86_0 = false

	for iter_86_0, iter_86_1 in ipairs(self.applying_list) do
		if iter_86_1.family and iter_86_1.family.familyid and iter_86_1.family.familyid == arg_86_1 then
			var_86_0 = true
		end
	end

	if var_86_0 then
		for iter_86_2, iter_86_3 in ipairs(self.applying_list) do
			if iter_86_3.family and iter_86_3.family.familyid and iter_86_3.family.familyid == arg_86_1 then
				iter_86_3.status = arg_86_2

				break
			end
		end
	else
		table.insert(self.applying_list, {
			family = {
				familyid = arg_86_1
			},
			status = arg_86_2
		})
	end
end

function var_0_0:getCommunityApplyingNum()
	return #self.community_applying_list
end

function var_0_0:getCommunityMemberNum()
	return #self.community_member_list
end

function var_0_0.getNextLevelNeedExp(arg_89_0, arg_89_1)
	arg_89_1 = arg_89_1 or 1

	if arg_89_1 + 1 > #family_level_data then
		return family_level_data[#family_level_data].exp
	else
		return family_level_data[arg_89_1 + 1].exp
	end
end

function var_0_0.updateComminityFilterParm(arg_90_0, arg_90_1)
	if not arg_90_1 or not next(arg_90_1) then
		return
	end

	arg_90_0.sortdownup = arg_90_1.sortdownup
	arg_90_0.sorttype = arg_90_1.sorttype
	arg_90_0.labelindex = arg_90_1.labelindex
	arg_90_0.verityid = arg_90_1.verityid
end

function var_0_0:getComminityFilterParm()
	return {
		sortdownup = self.sortdownup,
		sorttype = self.sorttype,
		labelindex = self.labelindex,
		verityid = self.verityid,
		membersortdownup = self.membersortdownup,
		membersorttype = self.membersorttype
	}
end

function var_0_0.updateComminityMemberSortParm(arg_92_0, arg_92_1)
	if not arg_92_1 or not next(arg_92_1) then
		return
	end

	arg_92_0.membersortdownup = arg_92_1.membersortdownup
	arg_92_0.membersorttype = arg_92_1.membersorttype

	return arg_92_1
end

function var_0_0:filterComminityParmData(arg_93_1)
	if not arg_93_1 or not next(arg_93_1) then
		return {}
	end

	local var_93_0 = {}

	local function var_93_1(arg_94_0, arg_94_1)
		if not arg_94_1 or not next(arg_94_1) then
			return true
		end

		if not arg_94_0 or not next(arg_94_0) then
			return false
		end

		local var_94_0 = false

		for iter_94_0, iter_94_1 in pairs(arg_94_0) do
			for iter_94_2, iter_94_3 in pairs(arg_94_1) do
				if iter_94_3 == iter_94_1 then
					var_94_0 = true
				end
			end
		end

		return var_94_0
	end

	if self.labelindex and next(self.labelindex) and not self.verityid then
		for iter_93_0, iter_93_1 in ipairs(arg_93_1) do
			if var_93_1(self:deCodeTagsData(iter_93_1.tags), self.labelindex) then
				table.insert(var_93_0, iter_93_1)
			end
		end
	elseif (not self.labelindex or not next(self.labelindex)) and self.verityid then
		for iter_93_2, iter_93_3 in ipairs(arg_93_1) do
			if iter_93_3.audit_type == self.verityid - 1 then
				table.insert(var_93_0, iter_93_3)
			end
		end
	elseif self.labelindex and next(self.labelindex) and self.verityid then
		if var_93_1(self:deCodeTagsData(), self.labelindex) and v.audit_type == self.verityid - 1 then
			table.insert(var_93_0, v)
		end
	else
		var_93_0 = arg_93_1
	end

	if not self.sortdownup then
		-- block empty
	elseif self.sortdownup == 1 then
		if self.sorttype == 1 then
			-- block empty
		elseif self.sorttype == 2 then
			table.sort(var_93_0, function(arg_95_0, arg_95_1)
				return arg_95_0.level > arg_95_1.level
			end)
		elseif self.sorttype == 3 then
			table.sort(var_93_0, function(arg_96_0, arg_96_1)
				return arg_96_0.member > arg_96_1.member
			end)
		elseif self.sorttype == 4 then
			table.sort(var_93_0, function(arg_97_0, arg_97_1)
				return arg_97_0.active > arg_97_1.active
			end)
		end
	elseif self.sorttype == 1 then
		-- block empty
	elseif self.sorttype == 2 then
		table.sort(var_93_0, function(arg_98_0, arg_98_1)
			return arg_98_0.level < arg_98_1.level
		end)
	elseif self.sorttype == 3 then
		table.sort(var_93_0, function(arg_99_0, arg_99_1)
			return arg_99_0.member < arg_99_1.member
		end)
	elseif self.sorttype == 4 then
		table.sort(var_93_0, function(arg_100_0, arg_100_1)
			return arg_100_0.active > arg_100_1.active
		end)
	end

	return var_93_0
end

function var_0_0:filterComminityMemberData(arg_101_1)
	if not arg_101_1 or not next(arg_101_1) then
		return {}
	end

	local var_101_0 = {}

	for iter_101_0, iter_101_1 in ipairs(arg_101_1) do
		table.insert(var_101_0, iter_101_1)
	end

	if not self.membersortdownup then
		-- block empty
	elseif self.membersortdownup == 1 then
		if self.membersorttype == 1 then
			local var_101_1 = {}
			local var_101_2 = {}

			for iter_101_2, iter_101_3 in ipairs(arg_101_1) do
				if iter_101_3.lastlogin == "-1" then
					table.insert(var_101_1, iter_101_3)
				else
					table.insert(var_101_2, iter_101_3)
				end
			end

			var_101_0 = var_101_1

			if #var_101_2 > 0 then
				table.sort(var_101_2, function(arg_102_0, arg_102_1)
					return global_get_time_by_date(arg_102_0.lastlogin) > global_get_time_by_date(arg_102_1.lastlogin)
				end)
			end

			for iter_101_4, iter_101_5 in ipairs(var_101_2) do
				table.insert(var_101_0, iter_101_5)
			end
		elseif self.membersorttype == 2 then
			table.sort(var_101_0, function(arg_103_0, arg_103_1)
				return arg_103_0.active > arg_103_1.active
			end)
		elseif self.membersorttype == 3 then
			table.sort(var_101_0, function(arg_104_0, arg_104_1)
				return arg_104_0.active_total > arg_104_1.active_total
			end)
		end
	elseif self.membersorttype == 1 then
		local var_101_3 = {}
		local var_101_4 = {}

		for iter_101_6, iter_101_7 in ipairs(arg_101_1) do
			if iter_101_7.lastlogin == "-1" then
				table.insert(var_101_3, iter_101_7)
			else
				table.insert(var_101_4, iter_101_7)
			end
		end

		var_101_0 = var_101_3

		if #var_101_4 > 0 then
			table.sort(var_101_4, function(arg_105_0, arg_105_1)
				return global_get_time_by_date(arg_105_0.lastlogin) > global_get_time_by_date(arg_105_1.lastlogin)
			end)
		end

		for iter_101_8, iter_101_9 in ipairs(var_101_4) do
			table.insert(var_101_0, iter_101_9)
		end
	elseif self.membersorttype == 2 then
		table.sort(var_101_0, function(arg_106_0, arg_106_1)
			return arg_106_0.active < arg_106_1.active
		end)
	elseif self.membersorttype == 3 then
		table.sort(var_101_0, function(arg_107_0, arg_107_1)
			return arg_107_0.active_total < arg_107_1.active_total
		end)
	end

	if var_101_0 and next(var_101_0) then
		local var_101_5 = {}
		local var_101_6

		for iter_101_10, iter_101_11 in ipairs(var_101_0) do
			if iter_101_11 and iter_101_11.isauto then
				var_101_6 = iter_101_11
			else
				table.insert(var_101_5, iter_101_11)
			end
		end

		var_101_5[#var_101_5 + 1] = var_101_6 and var_101_6 or {
			fightpower = 1,
			name = "jiqiren",
			active = 0,
			title = 10,
			lastlogin = "-1",
			active_total = 0,
			class = 1,
			isauto = 1,
			playerid = -4,
			level = 1,
			head_sculpture = playermodel.head_sculpture
		}
		var_101_0 = var_101_5
	end

	return var_101_0
end

function var_0_0:getMaxMember()
	local var_108_0 = self:getFamilyBuilding()

	if var_108_0 and var_108_0[1] and var_108_0[1].lv and var_108_0[1].id == 1 then
		return family_building_data["1" .. "_" .. var_108_0[1].lv].max_member
	else
		return ""
	end
end

function var_0_0.getMaxLevel(arg_109_0)
	return family_level_data[#family_level_data].exp
end

function var_0_0.getMaxApplyNum(arg_110_0)
	return family_other_data.max_application.value
end

function var_0_0.getThePosition(arg_111_0, arg_111_1)
	if not arg_111_1 then
		return
	end

	if family_privilege_data[arg_111_1] and family_privilege_data[arg_111_1].id then
		if family_privilege_data[arg_111_1].id == 100 then
			return 1
		elseif family_privilege_data[arg_111_1].id == 90 then
			return 2
		else
			return 3
		end
	else
		return 3
	end
end

function var_0_0.enCodeTagsData(arg_112_0, arg_112_1)
	local function var_112_1(arg_113_0)
		local var_113_0 = 0
		local var_113_1 = 0
		local var_113_2 = 0
		local var_113_3 = 0

		for iter_113_0 = 0, 1 do
			for iter_113_1 = 0, 1 do
				for iter_113_2 = 0, 1 do
					for iter_113_3 = 0, 1 do
						if iter_113_0 * 8 + iter_113_1 * 4 + iter_113_2 * 2 + iter_113_3 == arg_113_0 then
							var_113_3 = iter_113_3
							var_113_2 = iter_113_2
							var_113_1 = iter_113_1
							var_113_0 = iter_113_0

							break
						end
					end
				end
			end
		end

		return var_113_0, var_113_1, var_113_2, var_113_3
	end

	if #arg_112_1 == 0 then
		return 0
	elseif #arg_112_1 == 1 then
		return arg_112_1[1]
	elseif #arg_112_1 == 2 then
		local var_112_2, var_112_3, var_112_4, var_112_5 = var_112_1(arg_112_1[1])

		return var_112_2 * 128 + var_112_3 * 64 + var_112_4 * 32 + var_112_4 * 16 + arg_112_1[2]
	elseif #arg_112_1 == 3 then
		local var_112_6, var_112_7, var_112_8, var_112_9 = var_112_1(arg_112_1[1])
		local var_112_10, var_112_11, var_112_12, var_112_13 = var_112_1(arg_112_1[2])

		return var_112_6 * 2048 + var_112_7 * 1024 + var_112_8 * 512 + var_112_9 * 256 + var_112_10 * 128 + var_112_11 * 64 + var_112_12 * 32 + var_112_13 * 16 + arg_112_1[3]
	end
end

function var_0_0.deCodeTagsData(arg_114_0, arg_114_1)
	local function var_114_0(arg_115_0, arg_115_1)
		local var_115_0 = 0
		local var_115_1 = 0
		local var_115_2 = 0
		local var_115_3 = 0

		for iter_115_0 = 0, 1 do
			for iter_115_1 = 0, 1 do
				for iter_115_2 = 0, 1 do
					for iter_115_3 = 0, 1 do
						if iter_115_0 * 2^(3 + arg_115_1 * 4) + iter_115_1 * 2^(2 + arg_115_1 * 4) + iter_115_2 * 2^(1 + arg_115_1 * 4) + iter_115_3 * 2^(arg_115_1 * 4) == arg_115_0 then
							var_115_3 = iter_115_3
							var_115_2 = iter_115_2
							var_115_1 = iter_115_1
							var_115_0 = iter_115_0

							break
						end
					end
				end
			end
		end

		return var_115_0 * 8 + var_115_1 * 4 + var_115_2 * 2 + var_115_3
	end

	if not arg_114_1 then
		return {}
	end

	if arg_114_1 == 0 then
		return {}
	elseif arg_114_1 > 0 and arg_114_1 <= 15 then
		return {
			arg_114_1
		}
	elseif arg_114_1 > 15 and arg_114_1 <= 255 then
		return {
			var_114_0(bit.band(arg_114_1, 240), 1),
			(var_114_0(bit.band(arg_114_1, 15), 0))
		}
	elseif arg_114_1 > 255 and arg_114_1 <= 4095 then
		return {
			var_114_0(bit.band(arg_114_1, 3840), 2),
			var_114_0(bit.band(arg_114_1, 240), 1),
			arg_114_1 - bit.band(arg_114_1, 3840) - bit.band(arg_114_1, 240)
		}
	else
		return {}
	end
end

function var_0_0.dealTheOnlineTime(arg_116_0, arg_116_1)
	if not arg_116_1 then
		return
	end

	if arg_116_1 == "-1" then
		return L_FRIEND_SYSTEM.online
	else
		local var_116_0 = time_check_manager:getCurTime() - global_get_time_by_date(arg_116_1)

		if var_116_0 < 60 then
			return L_FRIEND_SYSTEM.sec_online
		elseif var_116_0 >= 60 and var_116_0 < 3600 then
			return math.ceil(var_116_0 / 60) .. L_FRIEND_SYSTEM.min_online
		elseif var_116_0 >= 3600 and var_116_0 < 86400 then
			return math.ceil(var_116_0 / 3600) .. L_FRIEND_SYSTEM.hour_online
		elseif var_116_0 >= 86400 and var_116_0 < 604800 then
			return math.ceil(var_116_0 / 86400) .. L_FRIEND_SYSTEM.day_online
		else
			return "7" .. L_FRIEND_SYSTEM.max_onlie
		end
	end
end

function var_0_0.deCodeAwardStatus(arg_117_0, arg_117_1)
	if not arg_117_1 then
		return
	end

	local var_117_0 = #family_pt_data

	return ((function(arg_118_0)
		local var_118_0 = {}
		local var_118_1 = {}
		local var_118_2 = {}

		for iter_118_0 = var_117_0, 0, -1 do
			var_118_0[#var_118_0 + 1] = math.floor(arg_118_0 / 2^iter_118_0)
			arg_118_0 = arg_118_0 % 2^iter_118_0
		end

		for iter_118_1 = 1, #var_118_0 - 1 do
			var_118_2[iter_118_1] = var_118_0[iter_118_1]
		end

		for iter_118_2 = 1, #var_118_2 do
			var_118_1[iter_118_2] = var_118_2[#var_118_2 - iter_118_2 + 1]
		end

		return var_118_1
	end)(arg_117_1))
end

function var_0_0:getAwardStatus()
	if not self.curawardstatus then
		return
	end

	return (self:deCodeAwardStatus(self.curawardstatus))
end

function var_0_0:getPlayerPtValue()
	return self.active_weekly
end

function var_0_0:updaPlayerPtValue(arg_121_1)
	self.active_weekly = self.active_weekly + arg_121_1
end

function var_0_0:setDonationDaliyStatus()
	local function var_122_0(arg_123_0, arg_123_1)
		local var_123_0 = 0
		local var_123_1 = 0
		local var_123_2 = 0
		local var_123_3 = 0

		for iter_123_0 = 0, 1 do
			for iter_123_1 = 0, 1 do
				for iter_123_2 = 0, 1 do
					for iter_123_3 = 0, 1 do
						if iter_123_0 * 2^(3 + arg_123_1 * 4) + iter_123_1 * 2^(2 + arg_123_1 * 4) + iter_123_2 * 2^(1 + arg_123_1 * 4) + iter_123_3 * 2^(arg_123_1 * 4) == arg_123_0 then
							var_123_3 = iter_123_3
							var_123_2 = iter_123_2
							var_123_1 = iter_123_1
							var_123_0 = iter_123_0

							break
						end
					end
				end
			end
		end

		return var_123_0 * 8 + var_123_1 * 4 + var_123_2 * 2 + var_123_3
	end

	local var_122_1 = {
		0,
		0,
		0
	}

	if not self.danationstayus then
		var_122_1 = {
			0,
			0,
			0
		}
	end

	self.danations_times = self.danationstayus == 0 and {
		0,
		0,
		0
	} or self.danationstayus > 0 and self.danationstayus <= 15 and {
		self.danationstayus,
		0,
		0
	} or self.danationstayus > 15 and self.danationstayus <= 255 and {
		var_122_0(bit.band(self.danationstayus, 15), 0),
		var_122_0(bit.band(self.danationstayus, 240), 1),
		0
	} or self.danationstayus > 255 and self.danationstayus <= 4095 and {
		self.danationstayus - bit.band(self.danationstayus, 3840) - bit.band(self.danationstayus, 240),
		var_122_0(bit.band(self.danationstayus, 240), 1),
		(var_122_0(bit.band(self.danationstayus, 3840), 2))
	} or {
		0,
		0,
		0
	}
end

function var_0_0:getDonationDaliyStatus()
	return self.danations_times
end

function var_0_0:updateDonationDaliyStatus(arg_125_1)
	for iter_125_0, iter_125_1 in ipairs(self.danations_times) do
		if iter_125_0 == arg_125_1 then
			iter_125_1 = iter_125_1 + 1

			break
		end
	end
end

function var_0_0:resetDonationDaliyStatus()
	self.danations_times[id] = {
		0,
		0,
		0
	}
end

function var_0_0:queryDonationDaliyStatus(arg_127_1)
	return self.danations_times[arg_127_1]
end

function var_0_0.getDonationMaxNum(arg_128_0, arg_128_1)
	return family_donate_data[arg_128_1].max_count
end

function var_0_0:getFamilyBuilding()
	if not self.buildings or not next(self.buildings) then
		local var_129_0 = 1
		local var_129_1 = {}

		while family_building_data["" .. var_129_0 .. "_1"] do
			table.insert(var_129_1, {
				lv = 1,
				id = var_129_0
			})

			var_129_0 = var_129_0 + 1
		end

		table.sort(var_129_1, function(arg_130_0, arg_130_1)
			return arg_130_0.id < arg_130_1.id
		end)

		self.buildings = var_129_1

		return self.buildings
	else
		local var_129_2 = {}
		local var_129_3 = 1

		while family_building_data["" .. var_129_3 .. "_1"] do
			local var_129_4 = false
			local var_129_5

			for iter_129_0, iter_129_1 in pairs(self.buildings) do
				if iter_129_1 and iter_129_1.id and iter_129_1.lv and iter_129_1.id == var_129_3 then
					var_129_4 = true
					var_129_5 = iter_129_1

					break
				end
			end

			if var_129_4 and var_129_5 then
				table.insert(var_129_2, {
					id = var_129_3,
					lv = var_129_5.lv
				})
			else
				table.insert(var_129_2, {
					lv = 1,
					id = var_129_3
				})
			end

			var_129_3 = var_129_3 + 1
		end

		self.buildings = var_129_2

		table.sort(self.buildings, function(arg_131_0, arg_131_1)
			return arg_131_0.id < arg_131_1.id
		end)

		return self.buildings
	end
end

function var_0_0.getNextBuilding(arg_132_0, arg_132_1, arg_132_2)
	if family_building_data["" .. arg_132_1 .. "_" .. arg_132_2 + 1] then
		return {
			id = arg_132_1,
			lv = arg_132_2 + 1
		}
	else
		return false
	end
end

function var_0_0:checkIsLock(arg_133_1, arg_133_2)
	local var_133_0 = false

	if family_building_data["" .. arg_133_1 .. "_" .. arg_133_2]["build_id_" .. arg_133_1] and family_building_data["" .. arg_133_1 .. "_" .. arg_133_2]["build_lv_" .. arg_133_1] then
		for iter_133_0, iter_133_1 in pairs(self.buildings) do
			if family_building_data["" .. arg_133_1 .. "_" .. arg_133_2]["build_id_" .. arg_133_1] == iter_133_1.id and family_building_data["" .. arg_133_1 .. "_" .. arg_133_2]["build_lv_" .. arg_133_1] <= iter_133_1.lv then
				var_133_0 = true

				break
			end
		end
	else
		var_133_0 = true
	end

	return var_133_0
end

function var_0_0:updateBuilding(arg_134_1, arg_134_2)
	local var_134_0 = {}

	for iter_134_0, iter_134_1 in ipairs(self.buildings) do
		if iter_134_1.id == arg_134_1 then
			table.insert(var_134_0, {
				id = arg_134_1,
				lv = arg_134_2
			})
		else
			table.insert(var_134_0, iter_134_1)
		end
	end

	self.buildings = var_134_0
end

function var_0_0:getCommityLevel()
	return self.level
end

function var_0_0.getTalklayerDataByType(arg_136_0, arg_136_1)
	local var_136_0 = {}

	for iter_136_0, iter_136_1 in ipairs(family_role_talk_data) do
		if iter_136_1.type == arg_136_1 then
			table.insert(var_136_0, iter_136_1)
		end
	end

	return var_136_0
end

function var_0_0:getNextApplyTime()
	return self.nextapplytime
end

function var_0_0:getNextApplyTimeSting()
	local var_138_0 = self:getNextApplyTime()

	if var_138_0 == 0 then
		return ""
	end

	return (self:dealTimeSting(var_138_0))
end

function var_0_0.dealTimeSting(arg_139_0, arg_139_1)
	if not arg_139_1 then
		return ""
	end

	local var_139_1 = arg_139_1 + 30 - time_check_manager:getCurTime()

	if var_139_1 < 86400 then
		if var_139_1 < 60 then
			return string.format(COMMUNITY_MANAGER_SYSTEM.tips2, 1)
		elseif var_139_1 >= 60 and var_139_1 < 3600 then
			return string.format(COMMUNITY_MANAGER_SYSTEM.tips2, math.floor(var_139_1 / 60))
		else
			return string.format(COMMUNITY_MANAGER_SYSTEM.tips3, math.floor(var_139_1 / 3600))
		end
	else
		return string.format(COMMUNITY_MANAGER_SYSTEM.tips4, (math.floor(var_139_1 / 86400)))
	end
end

function var_0_0:getApplyStatus()
	return self.isauditnew
end

function var_0_0:updateApplyStatus()
	local var_141_0 = self:getCommunityApplyingNum()

	if not var_141_0 or var_141_0 == 0 then
		self.isauditnew = false
	end
end

function var_0_0.resetAllStatus(arg_142_0)
	arg_142_0.exp = 0
	arg_142_0.money = 0
	arg_142_0.level = 1
	arg_142_0.isptaward = false
	arg_142_0.isauditnew = false
	arg_142_0.curposition = 10
	arg_142_0.curawardstatus = 0
	arg_142_0.active_weekly = 0
	arg_142_0.danationstayus = 0
	arg_142_0.danations_times = {
		0,
		0,
		0
	}
	arg_142_0.buildings = {
		0,
		0,
		0
	}
	arg_142_0.sortdownup = 1
	arg_142_0.sorttype = 1
	arg_142_0.labelindex = {}
	arg_142_0.verityid = nil
	arg_142_0.membersortdownup = 1
	arg_142_0.membersorttype = 1
	arg_142_0.slogan = ""
	arg_142_0.commity_chat_cd = 0
	arg_142_0.commity_chat_data_list = {}
	arg_142_0.isrepateonline = true
	arg_142_0.wishfilterparam = {
		0,
		0
	}
	arg_142_0.record_list_sz = {}
	arg_142_0.record_list_jz = {}
end

function var_0_0:getInintJumpLayerName()
	if not self:getOpenCommitityStatus() then
		if self.curfamilyid then
			return "CommunityMainLayer"
		else
			return "joinCommunityLayer"
		end
	else
		return "MainLayer"
	end
end

function var_0_0:isHaveRewardget()
	local var_144_0 = self:getAwardStatus()
	local var_144_1 = self:getPlayerPtValue()

	if not self:getCurfamilyid() then
		return false
	end

	local var_144_2 = false
	local var_144_3 = (function(arg_145_0)
		local var_145_0 = 1

		for iter_145_0, iter_145_1 in ipairs(family_pt_data) do
			if arg_145_0 <= iter_145_1.pt_num then
				var_145_0 = iter_145_0

				break
			else
				var_145_0 = #family_pt_data
			end
		end

		return var_145_0
	end)(var_144_1)

	if var_144_3 == 1 then
		if family_pt_data[var_144_3].pt_num == var_144_1 and var_144_0[1] == 0 then
			var_144_2 = true
		end
	elseif family_pt_data[var_144_3].pt_num == var_144_1 then
		for iter_144_0 = 1, var_144_3 do
			if var_144_0[iter_144_0] == 0 then
				var_144_2 = true
			end
		end
	else
		for iter_144_1 = 1, var_144_3 - 1 do
			if var_144_0[iter_144_1] == 0 then
				var_144_2 = true
			end
		end
	end

	return var_144_2
end

function var_0_0.getCommityCoinNum(arg_146_0)
	return item_manager:getItemNumber(var_0_21) or 0
end

function var_0_0:checkchatIsCD()
	if not self.commity_chat_cd or self.commity_chat_cd == 0 then
		return false
	end

	if time_check_manager:getCurTime() >= self.commity_chat_cd then
		return false
	else
		return true
	end
end

function var_0_0:getChatLeftTimeString()
	local var_148_0 = self.commity_chat_cd - time_check_manager:getCurTime()

	if var_148_0 > 0 then
		if var_148_0 < 60 then
			return string.format(COMMUNITY_MANAGER_SYSTEM.tips1, var_148_0)
		elseif var_148_0 >= 60 and var_148_0 < 3600 then
			return string.format(COMMUNITY_MANAGER_SYSTEM.tips2, math.floor(var_148_0 / 60))
		elseif var_148_0 >= 3600 and var_148_0 < 86400 then
			return string.format(COMMUNITY_MANAGER_SYSTEM.tips3, math.floor(var_148_0 / 3600))
		elseif var_148_0 >= 86400 then
			return string.format(COMMUNITY_MANAGER_SYSTEM.tips4, math.floor(var_148_0 / 86400))
		end
	else
		return ""
	end
end

function var_0_0.getKickPepoleTime(arg_149_0)
	local var_149_0 = family_other_data.family_leave_cd.value or 300

	if var_149_0 > 0 and var_149_0 < 60 then
		return string.format(COMMUNITY_MANAGER_SYSTEM.tips1, var_149_0)
	elseif var_149_0 >= 60 and var_149_0 < 3600 then
		return string.format(COMMUNITY_MANAGER_SYSTEM.tips2, math.floor(var_149_0 / 60))
	elseif var_149_0 >= 3600 and var_149_0 < 86400 then
		return string.format(COMMUNITY_MANAGER_SYSTEM.tips3, math.floor(var_149_0 / 3600))
	elseif var_149_0 >= 86400 then
		return string.format(COMMUNITY_MANAGER_SYSTEM.tips3, math.floor(var_149_0 / 86400))
	else
		return ""
	end
end

function var_0_0.getMaxCommunityLevel(arg_150_0)
	return #family_level_data
end

function var_0_0:getOpenCommitityStatus()
	return self.closecommity
end

function var_0_0:getTaskData()
	local var_152_0 = {}
	local var_152_1 = {}

	for iter_152_0, iter_152_1 in ipairs(task_index_dailyfamily_data) do
		if iter_152_1.valid then
			table.insert(var_152_0, iter_152_1)
		end
	end

	local var_152_2 = {}
	local var_152_3 = {}

	for iter_152_2, iter_152_3 in ipairs(var_152_0) do
		local var_152_4 = false

		for iter_152_4, iter_152_5 in pairs(task_manager:getCommityTaskFishedInfo(iter_152_3.display_type) or {}) do
			if iter_152_5 == iter_152_3.taskid then
				var_152_4 = true

				break
			end
		end

		if var_152_4 then
			table.insert(var_152_2, iter_152_3)
		else
			table.insert(var_152_3, iter_152_3)
		end
	end

	if next(var_152_3) then
		var_152_1 = var_152_3
	end

	if next(var_152_2) then
		for iter_152_6, iter_152_7 in ipairs(var_152_2) do
			table.insert(var_152_1, iter_152_7)
		end
	end

	self.taskinfo = var_152_1

	return self.taskinfo
end

function var_0_0:updateCurTaskData(arg_153_1, arg_153_2)
	if not arg_153_1 or not arg_153_2 or not self.taskinfo then
		return
	end

	for iter_153_0, iter_153_1 in pairs(self.taskinfo) do
		if iter_153_1.taskid == arg_153_1 and arg_153_2 == 1 then
			iter_153_1.percent = nil

			break
		end
	end
end

function var_0_0:getNodeDataByTaskId(arg_154_1)
	if not arg_154_1 or not self.taskinfo then
		return
	end

	local var_154_0

	for iter_154_0, iter_154_1 in pairs(self.taskinfo) do
		if iter_154_1.taskid == arg_154_1 then
			var_154_0 = iter_154_1

			break
		end
	end

	return var_154_0
end

function var_0_0:getCommityWishList()
	local var_155_0 = {}
	local var_155_1 = {}
	local var_155_2 = {}

	for iter_155_0, iter_155_1 in ipairs(self.wishlist) do
		local var_155_3 = self:getWishDataByWishid(iter_155_1.wishid)

		if var_155_3 then
			if iter_155_1.count >= var_155_3.wish_num then
				table.insert(var_155_0, iter_155_1)
			else
				table.insert(var_155_1, iter_155_1)
			end
		end
	end

	if next(var_155_1) then
		var_155_2 = var_155_1
	end

	if next(var_155_0) then
		for iter_155_2, iter_155_3 in ipairs(var_155_0) do
			table.insert(var_155_2, iter_155_3)
		end
	end

	return var_155_2
end

function var_0_0:filterComminityWishListData(arg_156_1)
	if not arg_156_1 then
		return {}
	end

	if self.wishfilterparam then
		if self.wishfilterparam[1] == 1 and self.wishfilterparam[2] == 0 then
			local var_156_0 = {}

			for iter_156_0, iter_156_1 in ipairs(arg_156_1) do
				if self:getWishDataByWishid(iter_156_1.wishid).wish_type == 1 then
					table.insert(var_156_0, iter_156_1)
				end
			end

			return var_156_0
		elseif self.wishfilterparam[1] == 0 and self.wishfilterparam[2] == 1 then
			local var_156_1 = {}

			for iter_156_2, iter_156_3 in ipairs(arg_156_1) do
				if self:getWishDataByWishid(iter_156_3.wishid).wish_type == 2 then
					table.insert(var_156_1, iter_156_3)
				end
			end

			return var_156_1
		else
			return arg_156_1
		end
	else
		return arg_156_1
	end
end

function var_0_0.getCommityItemNum(arg_157_0, arg_157_1)
	if not arg_157_1 then
		return 0
	end

	return item_manager:getItemNumber(arg_157_1) or 0
end

function var_0_0:updateWishData(arg_158_1)
	if not arg_158_1 then
		return
	end

	if self.wishlist then
		for iter_158_0, iter_158_1 in pairs(self.wishlist) do
			if iter_158_1.id == arg_158_1 then
				iter_158_1.count = iter_158_1.count + 1
				iter_158_1.status = true
			end
		end
	end
end

function var_0_0:getWishRecordList(arg_159_1)
	if not arg_159_1 then
		return
	end

	if arg_159_1 == 1 then
		return self.record_list_sz
	else
		return self.record_list_jz
	end
end

function var_0_0:updateRecordData(arg_160_1, arg_160_2)
	if not arg_160_1 or not arg_160_2 then
		return
	end

	if arg_160_2 == 1 or arg_160_2 == 2 then
		if self.record_list_sz then
			for iter_160_0, iter_160_1 in pairs(self.record_list_sz) do
				if arg_160_1 == iter_160_1.recordid then
					if arg_160_2 == 1 then
						iter_160_1.is_recv = true
					elseif arg_160_2 == 2 then
						iter_160_1.is_thank = true
					end
				end
			end
		end
	elseif self.record_list_jz then
		for iter_160_2, iter_160_3 in pairs(self.record_list_jz) do
			if arg_160_1 == iter_160_3.recordid and arg_160_2 == 3 then
				iter_160_3.is_recv = true
			end
		end
	end

	self:updateRecordRedStatus()
end

function var_0_0.getMyWishData(arg_161_0, arg_161_1)
	if not arg_161_1 then
		return
	end

	local function var_161_0(arg_162_0)
		if not arg_162_0 then
			return true
		end

		if not arg_162_0.own_item1 then
			return true
		end

		local var_162_0 = false

		while arg_162_0["own_item" .. 1] do
			for iter_162_0, iter_162_1 in pairs(playermodel.items) do
				if iter_162_1.itemid == arg_162_0["own_item" .. 1] then
					var_162_0 = true

					break
				end
			end

			local var_162_1

			if var_162_0 then
				break
			else
				var_162_1 = 1 + 1
			end
		end

		return var_162_0
	end

	local var_161_1 = {}

	for iter_161_0, iter_161_1 in pairs(family_wish_data) do
		if iter_161_1.wish_type == arg_161_1 then
			if var_161_0(iter_161_1) then
				if iter_161_1.start_time then
					if iter_161_1.finish_time then
						local var_161_3 = time_check_manager:getCurTime()

						if global_get_time_by_date(iter_161_1.start_time) <= var_161_3 and var_161_3 <= global_get_time_by_date(iter_161_1.finish_time) then
							iter_161_1.ownstatus = 1
							iter_161_1.timestatus = 1

							table.insert(var_161_1, iter_161_1)
						else
							iter_161_1.ownstatus = 1
							iter_161_1.timestatus = 2

							table.insert(var_161_1, iter_161_1)
						end
					elseif time_check_manager:getCurTime() >= global_get_time_by_date(iter_161_1.start_time) then
						iter_161_1.ownstatus = 1
						iter_161_1.timestatus = 1

						table.insert(var_161_1, iter_161_1)
					else
						iter_161_1.ownstatus = 1
						iter_161_1.timestatus = 2

						table.insert(var_161_1, iter_161_1)
					end
				else
					iter_161_1.ownstatus = 1
					iter_161_1.timestatus = 1

					table.insert(var_161_1, iter_161_1)
				end
			else
				iter_161_1.ownstatus = 2
				iter_161_1.timestatus = 1

				table.insert(var_161_1, iter_161_1)
			end
		end
	end

	local var_161_16 = {}
	local var_161_17 = {}

	if next(var_161_1) then
		for iter_161_2, iter_161_3 in pairs(var_161_1) do
			if iter_161_3.ownstatus == 2 then
				table.insert(var_161_17, iter_161_3)
			elseif iter_161_3.ownstatus == 1 then
				table.insert(var_161_16, iter_161_3)
			end
		end
	end

	if next(var_161_16) then
		table.sort(var_161_16, function(arg_163_0, arg_163_1)
			return arg_163_0.id < arg_163_1.id
		end)
	end

	if next(var_161_17) then
		table.sort(var_161_17, function(arg_164_0, arg_164_1)
			return arg_164_0.id < arg_164_1.id
		end)
	end

	local var_161_18 = var_161_16

	for iter_161_4, iter_161_5 in ipairs(var_161_17) do
		table.insert(var_161_18, iter_161_5)
	end

	return var_161_18
end

function var_0_0:getComminityWishFilterParm()
	return {
		wishfilterparam = self.wishfilterparam
	}
end

function var_0_0.updateComminityWishFilterParm(arg_166_0, arg_166_1)
	if not arg_166_1 then
		return
	end

	arg_166_0.wishfilterparam = arg_166_1
end

function var_0_0.getWishDataByWishid(arg_167_0, arg_167_1)
	if not arg_167_1 then
		return
	end

	return family_wish_data[arg_167_1]
end

function var_0_0:getWishTimes(arg_168_1, arg_168_2)
	if not arg_168_1 or not arg_168_2 then
		return
	end

	if arg_168_1 == 1 then
		if arg_168_2 == 1 then
			return self.rcw_num
		else
			return self.rcz_num
		end
	elseif arg_168_1 == 2 then
		if arg_168_2 == 1 then
			return self.hdw_num
		else
			return self.hdz_num
		end
	end
end

function var_0_0:updateWishTimes(arg_169_1, arg_169_2)
	if not arg_169_1 or not arg_169_2 then
		return
	end

	if arg_169_1 == 1 then
		if arg_169_2 == 1 then
			self.rcw_num = self.rcw_num + 1
		else
			self.rcz_num = self.rcz_num + 1
		end
	elseif arg_169_1 == 2 then
		if arg_169_2 == 1 then
			self.hdw_num = self.hdw_num + 1
		else
			self.hdz_num = self.hdz_num + 1
		end
	end
end

function var_0_0.getMaxWishTimes(arg_170_0, arg_170_1, arg_170_2)
	if not arg_170_1 or not arg_170_2 then
		return
	end

	if arg_170_1 == 1 then
		if arg_170_2 == 1 then
			return family_other_data.family_wish_count.value
		else
			return family_other_data.family_give_count.value
		end
	elseif arg_170_1 == 2 then
		if arg_170_2 == 1 then
			return family_other_data.activity_wish_count.value
		else
			return family_other_data.activity_give_count.value
		end
	end
end

function var_0_0.dequeueTaskInfo(arg_171_0, arg_171_1, arg_171_2)
	local var_171_0 = task_manager:dequeueCommityTaskInfo(arg_171_1, arg_171_2)

	if type(var_171_0) == "table" then
		local var_171_1 = {
			taskid = var_171_0.taskid,
			name = task_data[var_171_0.taskid].name,
			des = task_data[var_171_0.taskid].task_des,
			percent = var_171_0.percent,
			jump = task_data[var_171_0.taskid].jump,
			drop = task_data[var_171_0.taskid].drop,
			order = task_data[var_171_0.taskid].order
		}

		var_171_1.img = task_data[var_171_0.taskid].image or 1
		var_171_1.medal_id = task_data[var_171_0.taskid].medal_id

		return var_171_1
	else
		local var_171_2 = {
			percent = -1,
			taskid = var_171_0,
			name = task_data[var_171_0].name,
			des = task_data[var_171_0].task_des,
			jump = task_data[var_171_0].jump,
			drop = task_data[var_171_0].drop,
			order = task_data[var_171_0].order
		}

		var_171_2.img = task_data[var_171_0].image or 1
		var_171_2.medal_id = task_data[var_171_0].medal_id

		return var_171_2
	end
end

function var_0_0.dealWishTime(arg_172_0, arg_172_1)
	if not arg_172_1 then
		return ""
	end

	local var_172_0 = time_check_manager:getCurTime() - arg_172_1

	if var_172_0 < 60 then
		return "1" .. L_FRIEND_SYSTEM.min_online
	elseif var_172_0 >= 60 and var_172_0 < 3600 then
		return math.ceil(var_172_0 / 60) .. L_FRIEND_SYSTEM.min_online
	elseif var_172_0 >= 3600 and var_172_0 < 86400 then
		return math.ceil(var_172_0 / 3600) .. L_FRIEND_SYSTEM.hour_online
	elseif var_172_0 >= 86400 and var_172_0 < 2592000 then
		return math.ceil(var_172_0 / 86400) .. L_FRIEND_SYSTEM.day_online
	else
		return "30" .. L_FRIEND_SYSTEM.day_online
	end
end

function var_0_0:getRecordRedStatus(arg_173_1)
	if not arg_173_1 then
		return self.isRecordHavered
	elseif arg_173_1 == 1 then
		return self.isSZHavered
	elseif arg_173_1 == 2 then
		return self.isJZHavered
	end
end

function var_0_0:updateRecordRedStatus(arg_174_1)
	if arg_174_1 then
		self.isRecordHavered = true

		if arg_174_1 == 1 then
			self.isSZHavered = true
		elseif arg_174_1 == 2 then
			self.isJZHavered = true
		end
	else
		self.isRecordHavered = false
		self.isSZHavered = false
		self.isJZHavered = false

		if self.record_list_sz and next(self.record_list_sz) then
			for iter_174_0, iter_174_1 in pairs(self.record_list_sz) do
				if not iter_174_1.is_recv then
					self.isRecordHavered = true
					self.isSZHavered = true

					break
				end
			end
		end

		if self.record_list_jz and next(self.record_list_jz) then
			for iter_174_2, iter_174_3 in pairs(self.record_list_jz) do
				if iter_174_3.can_recv and not iter_174_3.is_recv then
					self.isRecordHavered = true
					self.isJZHavered = true

					break
				end
			end
		end
	end
end

function var_0_0.haveCommpeletAwardTask(arg_175_0)
	local var_175_0 = task_manager:getCommityTaskInfo(2)
	local var_175_1 = false

	if var_175_0 and next(var_175_0) then
		for iter_175_0, iter_175_1 in ipairs(var_175_0) do
			if iter_175_1.percent and iter_175_1.percent == 100 then
				var_175_1 = true

				break
			end
		end
	end

	return var_175_1
end

function var_0_0.checkIsHaveActivityWish(arg_176_0)
	local var_176_0 = false

	for iter_176_0, iter_176_1 in pairs(family_wish_data) do
		if iter_176_1.wish_type == 2 then
			if iter_176_1.start_time and iter_176_1.finish_time then
				local var_176_2 = time_check_manager:getCurTime()

				if global_get_time_by_date(iter_176_1.start_time) <= var_176_2 and var_176_2 <= global_get_time_by_date(iter_176_1.finish_time) then
					var_176_0 = true

					break
				end
			else
				var_176_0 = true

				break
			end
		end
	end

	return var_176_0
end

function var_0_0:updateWishDataFriendStatus(arg_177_1)
	if not arg_177_1 then
		return
	end

	if self.wishlist and next(self.wishlist) then
		for iter_177_0, iter_177_1 in pairs(self.wishlist) do
			if iter_177_1.playerid and iter_177_1.playerid == arg_177_1 and iter_177_1.is_friend then
				iter_177_1.is_friend = false
			end
		end
	end
end

function var_0_0.getActivityWishTime(arg_178_0)
	local var_178_0 = {}

	for iter_178_0, iter_178_1 in pairs(family_wish_data) do
		if iter_178_1.wish_type and iter_178_1.wish_type == 2 then
			var_178_0 = iter_178_1

			break
		end
	end

	return var_178_0.start_time, var_178_0.finish_time
end

function var_0_0:getLastChatStr()
	local var_179_0 = self:getCommunityChatData()
	local var_179_1 = var_179_0[#var_179_0]

	if not var_179_0[#var_179_0] then
		return ""
	end

	if var_179_1.playerid and var_179_1.playerid < 0 then
		local var_179_4 = chat_system_manager:getSystemTipsTitle(var_179_1.playerid) .. ":" .. chat_system_manager:getSystemTipsText(var_179_1.playerid, json.decode(var_179_1.msg))

		if string.len(var_179_4) > 48 then
			return string.sub(var_179_4, 1, 45) .. "..."
		else
			return var_179_4
		end
	else
		local var_179_5 = var_179_1.nickname .. ":" .. (string.find(var_179_1.msg, "##icon##_") and "[表情]" or var_179_1.msg)

		if string.len(var_179_1.nickname .. ":" .. (string.find(var_179_1.msg, "##icon##_") and "[表情]" or var_179_1.msg)) > 49 then
			return string.sub(var_179_5, 1, 46) .. "..."
		else
			return var_179_5
		end
	end
end

return var_0_0
