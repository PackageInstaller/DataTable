local var_0_0 = {}
local var_0_1 = 12
local var_0_2 = 201912002
local activity_manager = require("controller.activity_manager")
local network = require("network.network")
local halloween_activity_level_data = require("data.halloween_activity_level_data")
local activity_plague_technology_data = require("data.activity_plague_technology_data")
local item_manager = require("controller.item_manager")
local activity_plague_other_data = require("data.activity_plague_other_data")
local playermodel = require("model.playermodel")
local christmas_activity_level_data = require("data.christmas_activity_level_data")
local var_0_11 = require("data.activity_plague_other_data").virus_recover_duration.rule

var_0_0.left_time = 0
var_0_0.recover_time = 0
var_0_0.contain = 0

function var_0_0.get_chiris_level_config(arg_1_0, arg_1_1)
	network:rpc("get_swim_level_config", {
		id = var_0_1
	}, function(arg_2_0)
		if arg_1_1 then
			arg_1_1(arg_2_0)
		end
	end)
end

function var_0_0.getActivityExploreConfData(arg_3_0)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in pairs(christmas_activity_level_data) do
		if iter_3_1.valid == 1 then
			var_3_0[iter_3_1.id] = iter_3_1
		end
	end

	return var_3_0
end

function var_0_0.get_worldcity_info(arg_4_0, arg_4_1, arg_4_2)
	network:rpc("get_plague_info", {
		id = arg_4_1
	}, function(arg_5_0)
		if arg_5_0.result == 1 then
			if arg_5_0.virusbuy then
				arg_4_0.left_time = arg_5_0.virusbuy
			end

			if arg_5_0.lastrecover then
				arg_4_0.recover_time = arg_5_0.lastrecover + var_0_11
			end

			arg_4_0:set_contain(arg_5_0.virusmax)

			if arg_4_2 then
				arg_4_2(arg_5_0)
			end
		elseif arg_4_2 then
			arg_4_2(arg_5_0)
		end
	end)
end

function var_0_0.get_worldnode_info(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	network:rpc("get_plague_city_info", {
		id = arg_6_1,
		cityid = arg_6_2
	}, function(arg_7_0)
		if arg_7_0.result == 1 then
			if arg_6_3 then
				arg_6_3(arg_7_0)
			end
		elseif arg_6_3 then
			arg_6_3(arg_7_0)
		end
	end)
end

function var_0_0.push_virus(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6)
	network:rpc("plague_delivery_virus", {
		id = arg_8_1,
		cityid = arg_8_2,
		nodeid = arg_8_3,
		virusid = arg_8_4,
		num = arg_8_5
	}, function(arg_9_0)
		if arg_9_0.result == 1 then
			if arg_8_6 then
				arg_8_6(arg_9_0)
			end
		elseif arg_8_6 then
			arg_8_6(arg_9_0)
		end
	end)
end

function var_0_0.finish_citystory(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	network:rpc("plague_finish_city_story", {
		id = arg_10_1,
		cityid = arg_10_2
	}, function(arg_11_0)
		if arg_11_0.result == 1 then
			arg_10_0:set_contain(arg_11_0.virusmax)

			if arg_10_3 then
				arg_10_3(arg_11_0)
			end
		elseif arg_10_3 then
			arg_10_3(arg_11_0)
		end
	end)
end

function var_0_0.get_achievement_info(arg_12_0, arg_12_1, arg_12_2)
	network:rpc("get_plague_achievement_info", {
		id = arg_12_1
	}, function(arg_13_0)
		if arg_13_0.result ~= 0 then
			if arg_12_2 then
				arg_12_2(arg_13_0)
			end
		elseif arg_12_2 then
			arg_12_2(arg_13_0)
		end
	end)
end

function var_0_0.get_cityaward(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	network:rpc("get_plague_achievement_reward", {
		id = arg_14_1,
		cityid = arg_14_2
	}, function(arg_15_0)
		if arg_15_0.result == 1 then
			if arg_14_3 then
				arg_14_3(arg_15_0)
			end
		elseif arg_14_3 then
			arg_14_3(arg_15_0)
		end
	end)
end

function var_0_0.get_new_info(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	network:rpc("get_plague_news", {
		id = arg_16_1,
		start = arg_16_2,
		count = arg_16_3
	}, function(arg_17_0)
		if arg_17_0.result ~= 0 then
			if arg_16_4 then
				arg_16_4(arg_17_0)
			end
		elseif arg_16_4 then
			arg_16_4(arg_17_0)
		end
	end)
end

function var_0_0.get_techtree_info(arg_18_0, arg_18_1, arg_18_2)
	network:rpc("get_plague_tech_info", {
		id = arg_18_1
	}, function(arg_19_0)
		if arg_18_2 then
			arg_18_2(arg_19_0.result, arg_19_0.list)
		end
	end)
end

function var_0_0.levelup_tree(arg_20_0, arg_20_1, arg_20_2)
	network:rpc("plague_tech_levelup", {
		id = var_0_1,
		techid = arg_20_1
	}, function(arg_21_0)
		if arg_20_2 then
			arg_20_2(arg_21_0.result, arg_21_0)
		end
	end)
end

function var_0_0.reset_tree(arg_22_0, arg_22_1)
	network:rpc("plague_tech_reset", {
		id = var_0_1
	}, function(arg_23_0)
		if arg_22_1 then
			arg_22_1(arg_23_0.result, arg_23_0.vif, arg_23_0.diamond)
		end
	end)
end

function var_0_0.reset_city(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	network:rpc("plague_city_reset", {
		id = arg_24_1,
		cityid = arg_24_2
	}, function(arg_25_0)
		if arg_25_0.result ~= 0 then
			if arg_24_3 then
				arg_24_3(arg_25_0)
			end
		elseif arg_24_3 then
			arg_24_3(arg_25_0)
		end
	end)
end

function var_0_0.get_skill_info(arg_26_0, arg_26_1, arg_26_2)
	network:rpc("plague_skill_info", {
		id = arg_26_1
	}, function(arg_27_0)
		if arg_27_0.result ~= 0 then
			if arg_26_2 then
				arg_26_2(arg_27_0)
			end
		elseif arg_26_2 then
			arg_26_2(arg_27_0)
		end
	end)
end

function var_0_0.use_skill(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4, arg_28_5)
	network:rpc("plague_use_skill", {
		id = arg_28_1,
		cityid = arg_28_2,
		nodeid = arg_28_3,
		skillid = arg_28_4
	}, function(arg_29_0)
		if arg_29_0.result ~= 0 then
			if arg_28_5 then
				arg_28_5(arg_29_0)
			end
		elseif arg_28_5 then
			arg_28_5(arg_29_0)
		end
	end)
end

function var_0_0.clear_skill_cd(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	network:rpc("plague_clear_skillcd", {
		id = arg_30_1,
		skillid = arg_30_2
	}, function(arg_31_0)
		if arg_31_0.result ~= 0 then
			if arg_30_3 then
				arg_30_3(arg_31_0)
			end
		elseif arg_30_3 then
			arg_30_3(arg_31_0)
		end
	end)
end

function var_0_0.clear_skill_cd(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	network:rpc("plague_clear_skillcd", {
		id = arg_32_1,
		skillid = arg_32_2
	}, function(arg_33_0)
		if arg_33_0.result ~= 0 then
			if arg_32_3 then
				arg_32_3(arg_33_0)
			end
		elseif arg_32_3 then
			arg_32_3(arg_33_0)
		end
	end)
end

function var_0_0.recover_virus(arg_34_0, arg_34_1, arg_34_2)
	print("|||||||||||||||recover_virus||||||||||||||||||", arg_34_1)
	network:rpc("plague_recover_virus", {
		id = arg_34_1
	}, function(arg_35_0)
		print("||||||||||||||||recover_virus|||||||||||||||||", arg_34_1)

		if arg_35_0.result ~= 0 then
			if arg_35_0.virusbuy then
				arg_34_0.left_time = arg_35_0.virusbuy
			end

			if arg_35_0.lastrecover then
				arg_34_0.recover_time = arg_35_0.lastrecover + var_0_11
			end

			if arg_34_2 then
				arg_34_2(arg_35_0)
			end
		elseif arg_34_2 then
			arg_34_2(arg_35_0)
		end
	end)
end

function var_0_0.add_virus(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	network:rpc("plague_add_virus", {
		id = arg_36_1,
		type = arg_36_2
	}, function(arg_37_0)
		if arg_37_0.result ~= 0 then
			if arg_37_0.virusbuy then
				arg_36_0.left_time = arg_37_0.virusbuy
			end

			if arg_36_3 then
				arg_36_3(arg_37_0)
			end
		elseif arg_36_3 then
			arg_36_3(arg_37_0)
		end
	end)
end

function var_0_0:get_left_time()
	return self.left_time
end

function var_0_0:get_recover_time()
	return self.recover_time
end

function var_0_0.set_recover_time(arg_40_0, arg_40_1)
	if arg_40_1 then
		arg_40_0.recover_time = arg_40_1
	end
end

function var_0_0.set_contain(arg_41_0, arg_41_1)
	arg_41_0.contain = arg_41_1
end

function var_0_0:get_contain()
	return self.contain
end

function var_0_0.reset_contain(arg_43_0)
	return
end

function var_0_0:getTechtreeInfoFormServer()
	self:get_techtree_info(var_0_1, function(arg_45_0, arg_45_1)
		if arg_45_0 ~= 1 then
			global_ShowBlockWords(L_ACTIVITY_DOULE_HOLIDAY.GET_DATA_FAIL)

			return
		end

		self.techtreeInfo = {}

		for iter_45_0, iter_45_1 in pairs(arg_45_1) do
			self.techtreeInfo[iter_45_1.techid] = iter_45_1.level
		end

		activity_manager:fireEvent(activity_manager.activityEventId.TECHNOLOGY_TREE_DATA_UPDATE)
	end)
end

function var_0_0:getAllTechnologyId()
	if not self.technologyIds then
		self.technologyIds = {}

		for iter_46_0, iter_46_1 in pairs(activity_plague_technology_data) do
			table.insert(self.technologyIds, iter_46_0)
		end
	end

	return self.technologyIds
end

function var_0_0:queryTechnologyData(arg_47_1, arg_47_2)
	if not arg_47_1 or not activity_plague_technology_data[arg_47_1] then
		return L_ACTIVITY_DOULE_HOLIDAY.CEHUA_TIANBIOA
	end

	if not arg_47_2 then
		return activity_plague_technology_data[arg_47_1]
	end

	if arg_47_2 == "desc" then
		return self:getPlagueTechnologyDesc(arg_47_1) or L_ACTIVITY_DOULE_HOLIDAY.CEHUA_TIANBIOA
	end

	return activity_plague_technology_data[arg_47_1][arg_47_2] or L_ACTIVITY_DOULE_HOLIDAY.CEHUA_TIANBIOA
end

function var_0_0:getPlagueTechnologyDesc(arg_48_1)
	local var_48_1 = (self.techtreeInfo[arg_48_1] or 0) + 1
	local var_48_2 = ""

	if (self.techtreeInfo[arg_48_1] or 0) + 1 > activity_plague_technology_data[arg_48_1].level then
		var_48_1 = activity_plague_technology_data[arg_48_1].level
		var_48_2 = L_ACTIVITY_DOULE_HOLIDAY.FULL_LEVEL
	end

	return activity_plague_technology_data[arg_48_1]["desc" .. var_48_1] .. var_48_2
end

function var_0_0:levelUpTechnologyFromSever(arg_49_1)
	self:levelup_tree(arg_49_1, function(arg_50_0, arg_50_1)
		if arg_50_0 == 0 then
			global_ShowBlockWords(L_ACTIVITY_DOULE_HOLIDAY.LEVEL_UP_FAIL)

			return
		elseif arg_50_0 == 2 then
			global_ShowBlockWords(L_ACTIVITY_DOULE_HOLIDAY.NEED_UP_FRONT)

			return
		elseif arg_50_0 == 3 then
			global_ShowBlockWords(L_ACTIVITY_DOULE_HOLIDAY.LEVEL_MAX)

			return
		elseif arg_50_0 == 4 then
			global_ShowBlockWords(L_ACTIVITY_DOULE_HOLIDAY.COST_NOT_ENOUGT)

			return
		elseif arg_50_0 == 5 then
			global_ShowBlockWords(L_ACTIVITY_DOULE_HOLIDAY.CEHUA_TIANBIOA)

			return
		elseif arg_50_0 == 6 then
			global_ShowBlockWords(L_ACTIVITY_DOULE_HOLIDAY.NEED_UP_FRONT_LAYER)

			return
		elseif arg_50_0 ~= 1 then
			global_ShowBlockWords(L_ACTIVITY_DOULE_HOLIDAY.CEHUA_TIANBIOA)

			return
		end

		self.techtreeInfo = self.techtreeInfo or {}
		self.techtreeInfo[arg_49_1] = arg_50_1.level

		for iter_50_0, iter_50_1 in pairs(arg_50_1.cost_items) do
			item_manager:deleteItem(iter_50_1.entityid, iter_50_1.num)
		end

		self:showLevelUpWord(arg_49_1)
		activity_manager:fireEvent(activity_manager.activityEventId.TECHNOLOGY_LEVEL_UP_SECCESS, {
			id = arg_49_1
		})
	end)
end

function var_0_0:resetTreeFromSever()
	if self.techtreeInfo and next(self.techtreeInfo) then
		self:reset_tree(function(arg_52_0, arg_52_1, arg_52_2)
			if arg_52_0 == 2 then
				global_ShowBlockWords(L_ACTIVITY_DOULE_HOLIDAY.DIM_NOT_ENOUGH)
				LayerManager:pushInLayer("PopGoBuyGiftTicketLayer", {
					targetlayer = "PopSupermarketLayer"
				})

				return
			elseif arg_52_0 ~= 1 then
				global_ShowBlockWords(L_ACTIVITY_DOULE_HOLIDAY.CEHUA_TIANBIOA)

				return
			end

			self.techtreeInfo = {}

			global_gain({
				items = {
					arg_52_1
				}
			})

			if arg_52_2 then
				playermodel.diamond = playermodel.diamond - arg_52_2

				global_update_gold_stone_diamond(nil, nil, arg_52_2)
			end

			activity_manager:fireEvent(activity_manager.activityEventId.TECHNOLOGY_TREE_DATA_UPDATE)
		end)
	else
		global_ShowBlockWords(L_ACTIVITY_DOULE_HOLIDAY.NOT_HAVE_TEC)
	end
end

function var_0_0:getTecLevel(arg_53_1)
	return self.techtreeInfo[arg_53_1] or 0
end

function var_0_0.getResetTecCost(arg_54_0)
	return activity_plague_other_data.techtree_reset_cost.rule
end

function var_0_0.showLevelUpWord(arg_55_0, arg_55_1)
	if not arg_55_1 then
		return
	end

	if activity_plague_technology_data[arg_55_1].passive == 1 then
		global_ShowBlockWords((string.format(L_ACTIVITY_DOULE_HOLIDAY.PASSIVE_LEVEL_UP_SUCCESS, activity_plague_technology_data[arg_55_1].name)))
	else
		global_ShowBlockWords(string.format(L_ACTIVITY_DOULE_HOLIDAY.PASSIVE_LEVEL_UP_SUCCESS, activity_plague_technology_data[arg_55_1].name) .. string.format(L_ACTIVITY_DOULE_HOLIDAY.UNPASSIVE_UNLOCK, activity_plague_technology_data[arg_55_1].name))
	end
end

function var_0_0:row_level(arg_56_1)
	local var_56_0 = 0

	for iter_56_0, iter_56_1 in pairs(self.techtreeInfo) do
		if arg_56_1 == iter_56_0 % 10 then
			var_56_0 = var_56_0 + iter_56_1
		end
	end

	return var_56_0
end

function var_0_0:canTecLevelUp(arg_57_1)
	if not self.techtreeInfo[arg_57_1] then
		-- block empty
	end

	local var_57_1 = activity_plague_technology_data[arg_57_1]

	if not activity_plague_technology_data[arg_57_1] then
		return false, 5
	end

	if var_57_1.prerow_level and self:row_level(var_57_1.row - 1) < var_57_1.prerow_level then
		return false, 6
	end

	if item_manager:getItemNumber(var_0_2) < var_57_1.cost then
		return false, 4
	end

	for iter_57_0, iter_57_1 in ipairs(var_57_1.preid or {}) do
		if (self.techtreeInfo[iter_57_1.id] or 0) < iter_57_1.level then
			return false, 2
		end
	end

	return true
end

return var_0_0
