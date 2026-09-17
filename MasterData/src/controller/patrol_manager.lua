local var_0_0 = {}
local network = require("network.network")
local playermodel = require("model.playermodel")
local time_check_manager = require("controller.time_check_manager")
local level_manager = require("controller.level_manager")
local array_manager = require("controller.array_manager")
local core_manager = require("controller.core_manager")
local chapter_data = require("data.chapter_data")
local city_data = require("data.city_data")
local patrol_condition_data = require("data.patrol_condition_data")
local servant_data = require("data.servant_data")
local model_data = require("data.model_data")
local var_0_13 = 3
local var_0_14 = 2
local var_0_15 = 1
local var_0_16 = 2
local var_0_17 = {}

var_0_0.timers = setmetatable({
	cleantimers = function()
		for iter_4_0, iter_4_1 in pairs(var_0_17) do
			if iter_4_1.__id then
				time_check_manager:removeUpdatePool(iter_4_1.__id)
			end

			var_0_17[iter_4_0] = nil
		end
	end,
	getAllKeys = function()
		local var_5_0 = {}

		for iter_5_0, iter_5_1 in pairs(var_0_17) do
			table.insert(var_5_0, iter_5_0)
		end

		return var_5_0
	end
}, {
	__index = function(arg_1_0, arg_1_1)
		return var_0_17[arg_1_1]
	end,
	__newindex = function(arg_2_0, arg_2_1, arg_2_2)
		if not arg_2_2 then
			if var_0_17[arg_2_1] and var_0_17[arg_2_1].__id then
				time_check_manager:removeUpdatePool(var_0_17[arg_2_1].__id)
			end

			var_0_17[arg_2_1] = nil

			return
		end

		assert(arg_2_2.time ~= nil, "Need Time in Patrol Info")

		if var_0_17[arg_2_1] and var_0_17[arg_2_1].__id then
			time_check_manager:removeUpdatePool(var_0_17[arg_2_1].__id)

			var_0_17[arg_2_1].__id = nil
		end

		local var_2_0 = arg_2_2

		if arg_2_2.time > 0 then
			var_2_0.__id = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(arg_2_2.time, function(arg_3_0)
				var_2_0.time = arg_3_0

				if arg_3_0 <= 0 then
					var_2_0.time = 0

					time_check_manager:removeUpdatePool(var_2_0.__id)

					var_2_0.__id = nil
				end
			end)))
		end

		var_0_17[arg_2_1] = var_2_0
	end
})

local function var_0_18(arg_6_0)
	return string.format("%02d:%02d:%02d", math.floor(arg_6_0 / 3600), math.floor(arg_6_0 % 3600 / 60), arg_6_0 % 60)
end

function var_0_0:init(arg_7_1)
	self.timers:cleantimers()

	self.canPatrolChapter = {}

	network:rpc("get_levelmode_patrol_info", {}, function(arg_8_0)
		if arg_8_0.result == 1 then
			local var_8_0 = false

			for iter_8_0, iter_8_1 in pairs(arg_8_0.patrolInfo) do
				self.timers[iter_8_1.mode .. "-" .. iter_8_1.chapter] = iter_8_1

				if iter_8_1.time <= 0 then
					var_8_0 = true
				end
			end

			if var_8_0 then
				local alert_manager = require("controller.alert_manager")

				alert_manager:register_alert(ALERT_PATROL)
				alert_manager:register_alert(ALERT_PATROL_FIGHT)
			end
		end

		if arg_7_1 then
			arg_7_1()
		end
	end)
end

function var_0_0.getAllPatrolCitys(arg_9_0, arg_9_1)
	network:rpc("get_all_can_patrol_chapter", nil, function(arg_10_0)
		print(dump(arg_10_0))

		if arg_10_0.patrol_citys then
			arg_9_0.canPatrolChapter = arg_10_0.patrol_citys
		end

		if arg_9_1 then
			arg_9_1(arg_10_0)
		end
	end)
end

function var_0_0.reset(arg_11_0, arg_11_1)
	network:rpc("get_levelmode_patrol_info", {}, function(arg_12_0)
		print(dump(arg_12_0.patrolInfo))
		arg_11_0.timers:cleantimers()

		if arg_12_0.result == 1 then
			for iter_12_0, iter_12_1 in pairs(arg_12_0.patrolInfo) do
				arg_11_0.timers[iter_12_1.mode .. "-" .. iter_12_1.chapter] = iter_12_1
			end

			if arg_11_1 then
				arg_11_1()
			end
		end
	end)
end

function var_0_0:getPatrolInfo(arg_13_1)
	return self.timers[arg_13_1]
end

function var_0_0:getAllPatrolInfo()
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in pairs((self.timers:getAllKeys())) do
		var_14_0[iter_14_1] = self:getPatrolInfo(iter_14_1)
	end

	return var_14_0
end

function var_0_0:getAllPatrolKey()
	return self.timers:getAllKeys()
end

function var_0_0:getPatrolState(arg_16_1)
	if not self.timers[arg_16_1] then
		return 1
	elseif self.timers[arg_16_1].time <= 0 then
		return 2
	else
		return 3
	end
end

function var_0_0:getModePatrolInfo()
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in pairs(self.timers:getAllKeys()) do
		local var_17_1 = self:getPatrolInfo(iter_17_1)

		var_17_0[var_17_1.mode] = var_17_1
	end

	return var_17_0
end

function var_0_0:isModeFinishedPatrol(arg_18_1, arg_18_2)
	if arg_18_2 then
		local var_18_0 = self:getPatrolInfo(arg_18_1 .. "-" .. arg_18_2)

		if var_18_0 and var_18_0.time <= 0 then
			return true
		else
			return false
		end
	else
		local var_18_1 = self:getModePatrolInfo()

		if var_18_1[arg_18_1] and var_18_1[arg_18_1].time <= 0 then
			return true
		else
			return false
		end
	end
end

function var_0_0:isCityFinishedPatrol(arg_19_1, arg_19_2)
	if not arg_19_1 or not city_data[arg_19_1] then
		return false
	end

	if arg_19_2 and not city_data[arg_19_1]["difficulty" .. arg_19_2] then
		return false
	end

	if arg_19_2 then
		return self:isModeFinishedPatrol(city_data[arg_19_1]["difficulty" .. arg_19_2])
	else
		for iter_19_0 = 1, 3 do
			if self:isModeFinishedPatrol(city_data[arg_19_1]["difficulty" .. iter_19_0]) then
				return true
			end
		end

		return false
	end
end

function var_0_0:isModeNewPatrol(arg_20_1, arg_20_2)
	local var_20_0, var_20_1 = level_manager:isModeValid(arg_20_1)

	if not var_20_0 then
		return false
	end

	local var_20_2 = self:getChapterIsNewInfo()

	if arg_20_2 then
		if var_20_2[arg_20_1 .. "-" .. arg_20_2] and level_manager:isChapterPass(arg_20_1, arg_20_2) then
			return true
		else
			return false
		end
	else
		local var_20_3 = {}

		for iter_20_0, iter_20_1 in pairs(var_20_2) do
			local var_20_4, var_20_5 = iter_20_0:match("([^-]+)-(.+)")

			if level_manager:isChapterPass(tonumber(var_20_4), tonumber(var_20_5)) then
				var_20_3[tonumber(var_20_4)] = true
			end
		end

		if var_20_3[arg_20_1] and level_manager:isModeValid(arg_20_1) then
			return true
		else
			return false
		end
	end
end

function var_0_0:isModeCanPatrol(arg_21_1, arg_21_2, arg_21_3)
	local var_21_0, var_21_1 = level_manager:isModeValid(arg_21_1)

	if not var_21_0 then
		return arg_21_3(false)
	end

	if not level_manager:isChapterPass(arg_21_1, arg_21_2) then
		arg_21_3(false)

		return
	end

	self:getPatrolTime(arg_21_1, arg_21_2, function(arg_22_0)
		arg_21_3(arg_22_0 > 0)
	end)
end

function var_0_0:isCityNewPatrol(arg_23_1, arg_23_2)
	if not arg_23_1 or not city_data[arg_23_1] then
		return false
	end

	if arg_23_2 and not city_data[arg_23_1]["difficulty" .. arg_23_2] then
		return false
	end

	if arg_23_2 then
		return self:isModeNewPatrol(city_data[arg_23_1]["difficulty" .. arg_23_2])
	else
		for iter_23_0 = 1, 3 do
			if self:isModeNewPatrol(city_data[arg_23_1]["difficulty" .. iter_23_0]) then
				return true
			end
		end

		return false
	end
end

function var_0_0.getChapterIsNewInfo(arg_24_0)
	local var_24_0 = {}
	local var_24_1 = RoleDefault:getInstance():getStringForKey("chapter_is_new")

	if var_24_1 then
		for iter_24_0 in var_24_1:gmatch("([^,]+),") do
			var_24_0[iter_24_0] = true
		end
	end

	return var_24_0
end

function var_0_0:markChapterNew(arg_25_1, arg_25_2)
	local var_25_0 = self:getChapterIsNewInfo()

	if var_25_0[arg_25_1 .. "-" .. arg_25_2] then
		return
	end

	var_25_0[arg_25_1 .. "-" .. arg_25_2] = true

	if next(var_25_0) == nil then
		return
	end

	local var_25_1 = ""

	for iter_25_0, iter_25_1 in pairs(var_25_0) do
		var_25_1 = var_25_1 .. iter_25_0 .. ","
	end

	RoleDefault:getInstance():setStringForKey("chapter_is_new", var_25_1)
end

function var_0_0:unMarkChapterNew(arg_26_1, arg_26_2)
	local var_26_0 = self:getChapterIsNewInfo()

	if not var_26_0[arg_26_1 .. "-" .. arg_26_2] then
		return
	end

	var_26_0[arg_26_1 .. "-" .. arg_26_2] = nil

	local var_26_1 = ""

	for iter_26_0, iter_26_1 in pairs(var_26_0) do
		var_26_1 = var_26_1 .. iter_26_0 .. ","
	end

	RoleDefault:getInstance():setStringForKey("chapter_is_new", var_26_1)
	level_manager:checkIsAlertNewChapter()
end

local function var_0_19()
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in RoleDefault:getInstance():getStringForKey("last_patrol_arrays"):gmatch("([^,]+)=([^,]+)") do
		var_27_0[iter_27_0] = tonumber(iter_27_1)
	end

	return var_27_0
end

function var_0_0.getPatrolArrayid(arg_28_0, arg_28_1, arg_28_2)
	local fight_capacity_manager = require("controller.fight_capacity_manager")
	local var_28_1 = chapter_data[arg_28_1 .. "-" .. arg_28_2].patrol_fight_power or 0
	local var_28_2 = var_0_19()

	if var_28_2[arg_28_1 .. "-" .. arg_28_2] and playermodel.arrays[var_28_2[arg_28_1 .. "-" .. arg_28_2]].stat == ARRAY_STAT_FREE then
		return var_28_2[arg_28_1 .. "-" .. arg_28_2]
	else
		local function var_28_3(arg_29_0)
			local var_29_0 = {}

			for iter_29_0 = 1, 4 do
				var_29_0[iter_29_0] = arg_29_0["pos_" .. iter_29_0]
			end

			return var_29_0
		end

		local var_28_4 = {}

		for iter_28_0, iter_28_1 in ipairs(playermodel.arrays) do
			if iter_28_1.stat == ARRAY_STAT_FREE then
				table.insert(var_28_4, {
					arrayid = iter_28_0,
					fight_power = fight_capacity_manager:getArrayFightCapacity(var_28_3(iter_28_1))
				})
			end
		end

		table.sort(var_28_4, function(arg_30_0, arg_30_1)
			return arg_30_0.fight_power > arg_30_1.fight_power
		end)

		if var_28_1 <= var_28_4[1].fight_power then
			for iter_28_2, iter_28_3 in ipairs(var_28_4) do
				if var_28_1 > iter_28_3.fight_power then
					return var_28_4[iter_28_2 - 1].arrayid
				elseif iter_28_2 == #var_28_4 then
					return var_28_4[iter_28_2].arrayid
				end
			end
		else
			return var_28_4[1].arrayid
		end
	end
end

function var_0_0.setPatrolLastArrayid(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = var_0_19()

	var_31_0[arg_31_1 .. "-" .. arg_31_2] = arg_31_3

	local var_31_1 = ""

	for iter_31_0, iter_31_1 in pairs(var_31_0) do
		var_31_1 = var_31_1 .. iter_31_0 .. "=" .. iter_31_1 .. ","
	end

	cc.UserDefault:getInstance():setStringForKey("last_patrol_arrays", var_31_1)
end

function var_0_0.beginPatrol(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4)
	if not level_manager:isChapterPass(arg_32_1, arg_32_2) then
		global_ShowBlockWords(string.format(L_PATROL_CONDITION, level_manager:getChapterName(arg_32_1, arg_32_2)))

		if arg_32_4 then
			arg_32_4(2)
		end

		return
	end

	local var_32_1 = true

	for iter_32_0 = 1, 4 do
		if arg_32_3[iter_32_0] then
			var_32_1 = false

			break
		end
	end

	if var_32_1 then
		global_ShowBlockWords(L_TEAM_Array_WARNING.Team_Empty)

		if arg_32_4 then
			arg_32_4(5)
		end

		return
	end

	network:rpc("begin_levelmode_patrol", {
		mode = arg_32_1,
		chapter = arg_32_2,
		array = arg_32_3
	}, function(arg_33_0)
		if arg_33_0.result == 1 then
			arg_32_0:updatePatrolModel(arg_33_0.patrolInfo)
			AnalyticManager.begin_patrol({
				mode_chapter = arg_32_1 .. "-" .. arg_32_2,
				arrayid = arrayid
			})
		elseif arg_33_0.result == 0 then
			cclog("章节数据错误")
		elseif arg_33_0.result == 2 then
			cclog("未解锁前置章节")
			global_ShowBlockWords(string.format(L_PATROL_CONDITION, arg_32_0:getChapterName(arg_32_1, arg_32_2)))
		elseif arg_33_0.result == 3 then
			cclog("此章节正在挂机")
		elseif arg_33_0.result == 4 then
			cclog("此章节驻守次数已用完")
			global_ShowBlockWords(L_PATROL_TIMES_USEDOUT)
		elseif arg_33_0.result == 5 then
			cclog("阵容无效")
		elseif arg_33_0.result == 6 then
			cclog("阵容为空")
			global_ShowBlockWords(L_TEAM_Array_WARNING.Team_Empty)
		elseif arg_33_0.result == 7 then
			cclog("当前阵容忙碌")
		elseif arg_33_0.result == 8 then
			cclog("挂机阵容已达上限")
			global_ShowBlockWords(L_TEAM_Array_WARNING.Team_HangUp_Max)
		elseif arg_33_0.result == 9 then
			cclog("不满足驻守条件")
			global_ShowBlockWords(L_TEAM_Array_WARNING.CONDITION_ERROR)
		end

		if arg_32_4 then
			arg_32_4(arg_33_0.result)
		end
	end)
end

local function var_0_20(arg_34_0)
	for iter_34_0 = 1, 4 do
		if arg_34_0[iter_34_0] then
			return arg_34_0[iter_34_0]
		end
	end
end

function var_0_0.finishPatrol(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	network:rpc("finish_levelmode_patrol", {
		mode = arg_35_1,
		chapter = arg_35_2
	}, function(arg_36_0)
		if arg_36_0.result == 1 then
			if arg_36_0.diamond and arg_36_0.diamond < 0 then
				playermodel.diamond = playermodel.diamond + arg_36_0.diamond

				global_update_gold_stone_diamond(nil, nil, playermodel.diamond)

				arg_36_0.diamond = 0
			end

			local var_36_0, var_36_1, var_36_2, var_36_3, var_36_4, var_36_5, var_36_6, var_36_7 = global_get(arg_36_0)

			if var_36_0 ~= 0 or var_36_1 ~= 0 or next(var_36_4) ~= nil then
				require("view.Layer.Pops.PopBaseLayer")
				LayerManager:pushInLayer("PopPatrolResult", {
					gold = var_36_0,
					diamond = var_36_1,
					honor = var_36_2,
					sp = var_36_3,
					energy = var_36_5,
					items = var_36_4,
					name = chapter_data[arg_35_1 .. "-" .. arg_35_2].name,
					servantid = var_0_20(arg_35_0.timers[arg_35_1 .. "-" .. arg_35_2].array),
					time = var_0_18(arg_36_0.costtime),
					updateUICallback = arg_35_4
				})
			end

			if arg_36_0.eventid then
				require("controller.event_manager"):trigger_event_by_server({
					arg_36_0.eventid
				})
			end

			if arg_36_0.plotinfo then
				PlotManager:trigger_plot_by_server({
					arg_36_0.plotinfo
				})
			end

			if arg_35_0:getPatrolState(arg_35_1 .. "-" .. arg_35_2) == var_0_13 then
				AnalyticManager.quick_finish_patrol({
					mode_chapter = arg_35_1 .. "-" .. arg_35_2
				})
			elseif arg_35_0:getPatrolState(arg_35_1 .. "-" .. arg_35_2) == var_0_14 then
				AnalyticManager.finish_patrol({
					mode_chapter = arg_35_1 .. "-" .. arg_35_2
				})
			end

			arg_35_0:updatePatrolModel(arg_36_0.patrolInfo)
		elseif arg_36_0.result == 0 then
			cclog("关卡数据错误")
		elseif arg_36_0.result == 2 then
			cclog("当前区域巡逻状态不对")
		elseif arg_36_0.result == 3 then
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 0
			})
		end

		if arg_35_3 then
			arg_35_3(arg_36_0.result)
		end
	end)
end

function var_0_0.finishPatrolOneKey(arg_37_0, arg_37_1, arg_37_2)
	network:rpc("finish_levelmode_patrol", {}, function(arg_38_0)
		if arg_38_0.result == 1 then
			if arg_38_0.diamond and arg_38_0.diamond < 0 then
				playermodel.diamond = playermodel.diamond + arg_38_0.diamond

				global_update_gold_stone_diamond(nil, nil, playermodel.diamond)

				arg_38_0.diamond = 0
			end

			local var_38_0, var_38_1, var_38_2, var_38_3, var_38_4, var_38_5, var_38_6, var_38_7 = global_get(arg_38_0)
			local var_38_8 = arg_37_0:getAllPatrolKey()
			local var_38_9 = ""

			for iter_38_0, iter_38_1 in pairs(var_38_8) do
				if chapter_data[iter_38_1] then
					var_38_9 = var_38_9 .. " " .. chapter_data[iter_38_1].name
				end

				if arg_37_0:getPatrolState(iter_38_1) == var_0_13 then
					AnalyticManager.quick_finish_patrol({
						mode_chapter = iter_38_1
					})
				elseif arg_37_0:getPatrolState(iter_38_1) == var_0_14 then
					AnalyticManager.finish_patrol({
						mode_chapter = iter_38_1
					})
				end
			end

			if var_38_0 ~= 0 or var_38_1 ~= 0 or next(var_38_4) ~= nil then
				require("view.Layer.Pops.PopBaseLayer")
				LayerManager:pushInLayer("PopPatrolResult", {
					gold = var_38_0,
					diamond = var_38_1,
					honor = var_38_2,
					sp = var_38_3,
					energy = var_38_5,
					items = var_38_4,
					name = var_38_9,
					servantid = var_0_20(arg_37_0.timers[var_38_8[1]].array),
					time = var_0_18(arg_38_0.costtime),
					updateUICallback = arg_37_2
				})
			end

			if arg_38_0.eventid then
				require("controller.event_manager"):trigger_event_by_server({
					arg_38_0.eventid
				})
			end

			if arg_38_0.plotinfo then
				PlotManager:trigger_plot_by_server({
					arg_38_0.plotinfo
				})
			end

			arg_37_0:updatePatrolModel(arg_38_0.patrolInfo)
		elseif arg_38_0.result == 2 then
			cclog("没有可领取的驻守")
		elseif arg_38_0.result == 3 then
			cclog("钻石不足")
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 0
			})
		end

		if arg_37_1 then
			arg_37_1(arg_38_0.result)
		end
	end)
end

function var_0_0:finishPatrolByArrayid(arg_39_1, arg_39_2)
	if not require("controller.array_manager"):isArrayPatrol(arg_39_1) then
		if arg_39_2 then
			arg_39_2(3)
		end

		cclog("此阵容没在挂机")

		return
	end

	local var_39_0
	local var_39_1

	for iter_39_0, iter_39_1 in pairs((self.timers:getAllKeys())) do
		local var_39_2 = self:getPatrolInfo(iter_39_1)

		if var_39_2.array == arg_39_1 then
			var_39_1 = var_39_2.chapter
			var_39_0 = var_39_2.mode
		end
	end

	if not var_39_0 or not var_39_1 then
		if arg_39_2 then
			arg_39_2(0)
		end

		return
	end

	local function var_39_3(arg_40_0)
		for iter_40_0 = 1, 4 do
			if playermodel.arrays[arg_40_0]["pos_" .. iter_40_0].fight_girl then
				return playermodel.arrays[arg_40_0]["pos_" .. iter_40_0].fight_girl
			end
		end
	end

	network:rpc("finish_levelmode_patrol", {
		mode = var_39_0,
		chapter = var_39_1
	}, function(arg_41_0)
		if arg_41_0.result == 1 then
			if arg_41_0.diamond and arg_41_0.diamond < 0 then
				playermodel.diamond = playermodel.diamond + arg_41_0.diamond

				global_update_gold_stone_diamond(nil, nil, playermodel.diamond)

				arg_41_0.diamond = 0
			end

			local var_41_0, var_41_1, var_41_2, var_41_3, var_41_4, var_41_5, var_41_6, var_41_7 = global_get(arg_41_0)

			if var_41_0 ~= 0 or var_41_1 ~= 0 or next(var_41_4) ~= nil then
				require("view.Layer.Pops.PopBaseLayer")
				LayerManager:pushInLayer("PopPatrolResult", {
					gold = var_41_0,
					diamond = var_41_1,
					honor = var_41_2,
					sp = var_41_3,
					energy = var_41_5,
					items = var_41_4,
					name = chapter_data[var_39_0 .. "-" .. var_39_1].name,
					servantid = var_39_3(self.timers[var_39_0 .. "-" .. var_39_1].array),
					time = var_0_18(arg_41_0.costtime)
				})
			end

			if arg_41_0.eventid then
				require("controller.event_manager"):trigger_event_by_server({
					arg_41_0.eventid
				})
			end

			if arg_41_0.plotinfo then
				PlotManager:trigger_plot_by_server({
					arg_41_0.plotinfo
				})
			end

			if self:getPatrolState(var_39_0 .. "-" .. var_39_1) == var_0_13 then
				AnalyticManager.quick_finish_patrol({
					mode_chapter = var_39_0 .. "-" .. var_39_1
				})
			elseif self:getPatrolState(var_39_0 .. "-" .. var_39_1) == var_0_14 then
				AnalyticManager.finish_patrol({
					mode_chapter = var_39_0 .. "-" .. var_39_1
				})
			end

			playermodel.arrays[self.timers[var_39_0 .. "-" .. var_39_1].array].stat = 0

			self:updatePatrolModel(arg_41_0.patrolInfo)
		elseif arg_41_0.result == 0 then
			cclog("关卡数据错误")
		elseif arg_41_0.result == 2 then
			cclog("当前区域巡逻状态不对")
		elseif arg_41_0.result == 3 then
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 0
			})
		end

		if arg_39_2 then
			arg_39_2(arg_41_0.result)
		end
	end)
end

function var_0_0.cancelPatrol(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	local function var_42_0(arg_43_0)
		for iter_43_0 = 1, 4 do
			if arg_43_0[iter_43_0] then
				return arg_43_0[iter_43_0]
			end
		end
	end

	network:rpc("cancel_levelmode_patrol", {
		mode = arg_42_1,
		chapter = arg_42_2
	}, function(arg_44_0)
		if arg_44_0.result == 1 then
			if arg_44_0.diamond and arg_44_0.diamond < 0 then
				playermodel.diamond = playermodel.diamond + arg_44_0.diamond

				global_update_gold_stone_diamond(nil, nil, playermodel.diamond)

				arg_44_0.diamond = 0
			end

			local var_44_0, var_44_1, var_44_2, var_44_3, var_44_4, var_44_5, var_44_6, var_44_7 = global_get(arg_44_0)

			if var_44_0 ~= 0 or var_44_1 ~= 0 or next(var_44_4) ~= nil then
				local var_44_8 = {
					gold = var_44_0,
					diamond = var_44_1,
					honor = var_44_2,
					sp = var_44_3,
					energy = var_44_5,
					items = var_44_4,
					name = chapter_data[arg_42_1 .. "-" .. arg_42_2].name,
					servantid = var_42_0(arg_42_0.timers[arg_42_1 .. "-" .. arg_42_2].array),
					time = var_0_18(arg_44_0.costtime)
				}

				require("view.Layer.Pops.PopBaseLayer")
				LayerManager:pushInLayer("PopPatrolResult", var_44_8)
			end

			arg_42_0:updatePatrolModel(arg_44_0.patrolInfo)
			AnalyticManager.cancel_patrol({
				mode_chapter = arg_42_1 .. "-" .. arg_42_2
			})
		elseif arg_44_0.result == 0 then
			cclog("关卡数据错误")
		elseif arg_44_0.result == 2 then
			cclog("当前区域巡逻状态不对")
		end

		if arg_42_3 then
			arg_42_3(arg_44_0.result)
		end
	end)
end

function var_0_0:cancelPatrolByArrayid(arg_45_1, arg_45_2)
	if not require("controller.array_manager"):isArrayPatrol(arg_45_1) then
		if arg_45_2 then
			arg_45_2(3)
		end

		cclog("此阵容没在挂机")

		return
	end

	local var_45_0
	local var_45_1

	for iter_45_0, iter_45_1 in pairs((self.timers:getAllKeys())) do
		local var_45_2 = self:getPatrolInfo(iter_45_1)

		if var_45_2.array == arg_45_1 then
			var_45_1 = var_45_2.chapter
			var_45_0 = var_45_2.mode
		end
	end

	if not var_45_0 or not var_45_1 then
		if arg_45_2 then
			arg_45_2(0)
		end

		return
	end

	local function var_45_3(arg_46_0)
		for iter_46_0 = 1, 3 do
			if playermodel.arrays[arg_46_0]["pos_" .. iter_46_0].fight_girl then
				return playermodel.arrays[arg_46_0]["pos_" .. iter_46_0].fight_girl
			end
		end
	end

	network:rpc("cancel_levelmode_patrol", {
		mode = var_45_0,
		chapter = var_45_1
	}, function(arg_47_0)
		if arg_47_0.result == 1 then
			if arg_47_0.diamond and arg_47_0.diamond < 0 then
				playermodel.diamond = playermodel.diamond + arg_47_0.diamond

				global_update_gold_stone_diamond(nil, nil, playermodel.diamond)

				arg_47_0.diamond = 0
			end

			local var_47_0, var_47_1, var_47_2, var_47_3, var_47_4, var_47_5, var_47_6, var_47_7 = global_get(arg_47_0)

			if var_47_0 ~= 0 or var_47_1 ~= 0 or next(var_47_4) ~= nil then
				local var_47_8 = {
					gold = var_47_0,
					diamond = var_47_1,
					honor = var_47_2,
					sp = var_47_3,
					energy = var_47_5,
					items = var_47_4,
					name = chapter_data[var_45_0 .. "-" .. var_45_1].name,
					servantid = var_45_3(self.timers[var_45_0 .. "-" .. var_45_1].array),
					time = var_0_18(arg_47_0.costtime)
				}

				require("view.Layer.Pops.PopBaseLayer")
				LayerManager:pushInLayer("PopPatrolResult", var_47_8)
			end

			playermodel.arrays[self.timers[var_45_0 .. "-" .. var_45_1].array].stat = 0

			self:updatePatrolModel(arg_47_0.patrolInfo)
			AnalyticManager.cancel_patrol({
				mode_chapter = var_45_0 .. "-" .. var_45_1
			})
		elseif arg_47_0.result == 0 then
			cclog("关卡数据错误")
		elseif arg_47_0.result == 2 then
			cclog("当前区域巡逻状态不对")
		end

		if arg_45_2 then
			arg_45_2(arg_47_0.result)
		end
	end)
end

function var_0_0:updatePatrolModel(arg_48_1)
	self.timers:cleantimers()

	local var_48_0

	for iter_48_0, iter_48_1 in pairs(arg_48_1) do
		self.timers[iter_48_1.mode .. "-" .. iter_48_1.chapter] = iter_48_1

		if iter_48_1.time == 0 then
			var_48_0 = true
		end
	end

	local alert_manager = require("controller.alert_manager")

	if var_48_0 then
		alert_manager:register_alert(ALERT_PATROL)
		alert_manager:register_alert(ALERT_PATROL_FIGHT)
	else
		alert_manager:unregister_alert(ALERT_PATROL, true)
		alert_manager:unregister_alert(ALERT_PATROL_FIGHT, not alert_manager.alertsys[ALERT_NEW_EVENT])
	end
end

function var_0_0:removePatrolModel(arg_49_1, arg_49_2)
	self.timers[arg_49_1 .. "-" .. arg_49_2] = nil
end

function var_0_0:getCurPatrolArrayNum()
	return #self.timers:getAllKeys()
end

function var_0_0:isModePatroling(arg_51_1)
	return not not self:getModePatrolInfo()[arg_51_1]
end

function var_0_0:isLevelModePatroling(arg_52_1, arg_52_2)
	return self:getPatrolState(arg_52_1 .. "-" .. arg_52_2) == var_0_13
end

function var_0_0.getPatrolTime(arg_53_0, arg_53_1, arg_53_2, arg_53_3)
	network:rpc("get_quick_pass_used_time", {
		quicktype = 2,
		mode = arg_53_1,
		chapter = arg_53_2
	}, function(arg_54_0)
		if arg_53_3 then
			arg_53_3(arg_54_0.times)
		end
	end)
end

function var_0_0:getPatrolInfoByServantid(arg_55_1)
	for iter_55_0, iter_55_1 in pairs((self:getAllPatrolKey())) do
		local var_55_0 = self:getPatrolInfo(iter_55_1)

		for iter_55_2, iter_55_3 in pairs(var_55_0.array) do
			if arg_55_1 == iter_55_3 then
				return var_55_0
			end
		end
	end
end

function var_0_0.getPatrolingArray(arg_56_0)
	return {}
end

function var_0_0:getCurArrayPatrolChpater(arg_57_1)
	for iter_57_0, iter_57_1 in pairs((self.timers:getAllKeys())) do
		local var_57_0 = self:getPatrolInfo(iter_57_1)

		if var_57_0.array == arg_57_1 then
			return var_57_0.mode, var_57_0.chapter
		end
	end
end

function var_0_0:getCanPatrolMode()
	local var_58_0 = {}

	for iter_58_0, iter_58_1 in pairs(self.timers:getAllKeys()) do
		var_58_0[iter_58_1] = true
	end

	local var_58_1 = {}

	for iter_58_2, iter_58_3 in ipairs(city_data) do
		for iter_58_4 = 1, 4 do
			for iter_58_5, iter_58_6 in ipairs({
				5,
				10
			}) do
				if chapter_data[iter_58_3["difficulty" .. iter_58_4] .. "-" .. iter_58_6] and chapter_data[iter_58_3["difficulty" .. iter_58_4] .. "-" .. iter_58_6].stronghold == 2 and level_manager:isChapterPass(iter_58_3["difficulty" .. iter_58_4], iter_58_6) then
					table.insert(var_58_1, iter_58_3["difficulty" .. iter_58_4] .. "-" .. iter_58_6)
				end
			end
		end
	end

	return var_58_1
end

function var_0_0:getShowTotalLevel(arg_59_1, arg_59_2)
	local var_59_0, var_59_1, var_59_2, var_59_3 = self:get_patrol_condition(arg_59_1, arg_59_2)

	return var_59_0 * 100 + var_59_1
end

function var_0_0.getArrayonekey(arg_60_0, arg_60_1, arg_60_2, arg_60_3)
	local var_60_1 = 0
	local var_60_2 = 0
	local var_60_3 = 0
	local var_60_4 = 0
	local var_60_5 = {}
	local var_60_6 = {}
	local var_60_7 = false

	;(function()
		var_60_1, var_60_2, var_60_3, var_60_4 = arg_60_0:get_patrol_condition(arg_60_1, arg_60_2)
	end)()
	;(function()
		local function var_62_0(arg_63_0)
			for iter_63_0, iter_63_1 in pairs(ATTR_ID) do
				if model_data[servant_data[arg_63_0].modelid][iter_63_1] == 1 then
					return iter_63_1
				end
			end
		end

		local function var_62_1(arg_64_0, arg_64_1)
			local var_64_0 = servant_data[arg_64_0].modelid

			if model_data[servant_data[arg_64_0].modelid].imaginary then
				return true
			end

			return model_data[var_64_0][arg_64_1] ~= nil
		end

		local function var_62_2(arg_65_0)
			if not arg_60_3 then
				return true
			end

			if core_manager:getCoreLv(arg_65_0) >= var_60_2 then
				return true
			else
				return false
			end
		end

		local function var_62_3(arg_66_0, arg_66_1)
			if not arg_66_0 then
				return false
			end

			return arg_66_0[arg_66_1]
		end

		for iter_62_0, iter_62_1 in pairs(playermodel.haveServant) do
			if iter_62_1 and not var_62_3(arg_60_3, iter_62_0) and not arg_60_0:isServantPatrolNow(iter_62_0) and var_62_2(iter_62_0) and var_62_1(iter_62_0, var_60_4) then
				table.insert(var_60_5, iter_62_0)
			end
		end

		table.sort(var_60_5, function(arg_67_0, arg_67_1)
			local var_67_0, var_67_1 = arg_60_0:get_patrol_condition(arg_60_1, arg_60_2)
			local var_67_2, var_67_3 = arg_60_0:get_patrol_condition(arg_60_1, arg_60_2)
			local var_67_4 = core_manager:getCoreLv(arg_67_0)
			local var_67_5 = core_manager:getCoreLv(arg_67_1)
			local var_67_6 = arg_60_0:check_core_lv(arg_60_1, arg_60_2, arg_67_0) and 1 or 0
			local var_67_7 = arg_60_0:check_core_lv(arg_60_1, arg_60_2, arg_67_1) and 1 or 0

			if var_67_6 == var_67_7 then
				if var_67_6 == 1 and var_67_7 == 1 then
					local var_67_8 = var_62_0(arg_67_0) == "imaginary" and 1 or 0
					local var_67_9 = var_62_0(arg_67_1) == "imaginary" and 1 or 0

					if var_67_8 == var_67_9 then
						return core_manager:getServantCoreRank(arg_67_0) < core_manager:getServantCoreRank(arg_67_1)
					else
						return var_67_8 < var_67_9
					end
				else
					local var_67_12 = var_62_0(arg_67_0) == "imaginary" and 1 or 0
					local var_67_13 = var_62_0(arg_67_1) == "imaginary" and 1 or 0

					if var_67_12 == var_67_13 then
						return core_manager:getServantCoreRank(arg_67_0) < core_manager:getServantCoreRank(arg_67_1)
					else
						return var_67_12 < var_67_13
					end
				end
			else
				return var_67_7 < var_67_6
			end
		end)
	end)()
	;(function()
		for iter_68_0 = 1, var_60_3 do
			if var_60_5[iter_68_0] then
				table.insert(var_60_6, var_60_5[iter_68_0])
			else
				if arg_60_3 then
					var_60_7 = true
				end

				break
			end
		end
	end)()

	if next(var_60_6) == nil and not arg_60_3 then
		global_ShowBlockWords(L_PATROL_ARRAY_ONEKEY)
	end

	return var_60_6
end

function var_0_0.check_core_lv(arg_69_0, arg_69_1, arg_69_2, arg_69_3)
	local var_69_0 = 0
	local var_69_1 = 0
	local var_69_2 = 0
	local var_69_3 = 0

	;(function()
		var_69_0, var_69_1, var_69_2, var_69_3 = arg_69_0:get_patrol_condition(arg_69_1, arg_69_2)
	end)()

	if 0 <= (playermodel.cores[arg_69_3].afk_lv or core_manager:getCoreLv(arg_69_3)) then
		return true
	else
		return false
	end
end

function var_0_0.get_patrol_condition(arg_71_0, arg_71_1, arg_71_2)
	local var_71_0 = 0
	local var_71_1 = 0
	local var_71_2 = 1
	local var_71_3 = 0
	local var_71_4 = {
		[var_0_15] = function(arg_72_0, arg_72_1)
			var_71_0, var_71_1 = 0, tonumber(arg_72_0)
			var_71_2 = tonumber(arg_72_1)
		end,
		[var_0_16] = function(arg_73_0, arg_73_1)
			var_71_3 = arg_73_0
		end
	}

	while patrol_condition_data[arg_71_1 .. "-" .. arg_71_2]["condition_" .. 1] do
		var_71_4[tonumber(patrol_condition_data[arg_71_1 .. "-" .. arg_71_2]["condition_" .. 1])](patrol_condition_data[arg_71_1 .. "-" .. arg_71_2]["param_" .. 1 .. "_1"], patrol_condition_data[arg_71_1 .. "-" .. arg_71_2]["param_" .. 1 .. "_2"])
	end

	return 0, 0, 1, 0
end

function var_0_0:isServantPatrolNow(arg_74_1)
	for iter_74_0, iter_74_1 in pairs(self.timers:getAllKeys()) do
		for iter_74_2, iter_74_3 in pairs(self:getPatrolInfo(iter_74_1).array) do
			if arg_74_1 == iter_74_3 then
				return true
			end
		end
	end

	return false
end

function var_0_0.genReadyPatrolInfo(arg_75_0, arg_75_1)
	local var_75_0 = {}

	while chapter_data[arg_75_1.mode .. "-" .. arg_75_1.chapter]["rare_item" .. 1] do
		table.insert(var_75_0, {
			rare = 1,
			itemid = chapter_data[arg_75_1.mode .. "-" .. arg_75_1.chapter]["rare_item" .. 1]
		})
	end

	return {
		cityid = arg_75_1.cityid,
		mode = arg_75_1.mode,
		chapter = arg_75_1.chapter,
		dropinfo = var_75_0
	}
end

function var_0_0:get_can_get_reward_num()
	local var_76_0 = 0
	local var_76_1 = 0

	for iter_76_0, iter_76_1 in pairs((self:getAllPatrolInfo())) do
		if iter_76_1.time and iter_76_1.time > 0 then
			var_76_0 = var_76_0 + 1
		elseif iter_76_1.time and iter_76_1.time <= 0 then
			var_76_1 = var_76_1 + 1
		end
	end

	return var_76_0, var_76_1
end

function var_0_0.rewardOneKey(arg_77_0, arg_77_1)
	network:rpc("finish_patrol_one_key", {}, function(arg_78_0)
		if arg_78_0.result == 1 then
			local var_78_0 = arg_77_0:getAllPatrolKey()
			local var_78_1 = ""

			for iter_78_0, iter_78_1 in pairs(var_78_0) do
				if chapter_data[iter_78_1] then
					var_78_1 = var_78_1 .. " " .. chapter_data[iter_78_1].name
				end

				if arg_77_0:getPatrolState(iter_78_1) == var_0_13 then
					AnalyticManager.quick_finish_patrol({
						mode_chapter = iter_78_1
					})
				elseif arg_77_0:getPatrolState(iter_78_1) == var_0_14 then
					AnalyticManager.finish_patrol({
						mode_chapter = iter_78_1
					})
				end
			end

			if arg_78_0.events and next(arg_78_0.events) then
				for iter_78_2, iter_78_3 in ipairs(arg_78_0.events) do
					if iter_78_3.eventid then
						require("controller.event_manager"):trigger_event_by_server({
							iter_78_3.eventid
						})
					end

					if iter_78_3.plotinfo then
						PlotManager:trigger_plot_by_server({
							iter_78_3.plotinfo
						})
					end
				end
			end

			local var_78_2, var_78_3, var_78_4, var_78_5, var_78_6, var_78_7, var_78_8, var_78_9 = global_get(arg_78_0)

			if var_78_2 ~= 0 or var_78_3 ~= 0 or next(var_78_6) ~= nil then
				require("view.Layer.Pops.PopBaseLayer")
				LayerManager:pushInLayer("PopPatrolResult", {
					isOneKey = true,
					gold = var_78_2,
					diamond = var_78_3,
					honor = var_78_4,
					sp = var_78_5,
					energy = var_78_7,
					items = var_78_6,
					name = var_78_1,
					servantid = var_0_20(arg_77_0.timers[var_78_0[1]].array),
					completeNum = arg_78_0.num
				})
			end

			print("reward num", arg_78_0.num)
			arg_77_0:updatePatrolModel(arg_78_0.patrolInfo)
		else
			global_ShowBlockWords("没有奖励可以领取")
		end

		if arg_77_1 then
			arg_77_1(arg_78_0)
		end
	end)
end

function var_0_0.getModeDifficulty(arg_79_0, arg_79_1, arg_79_2)
	if not city_data[arg_79_1] then
		return 0
	end

	local var_79_0 = 1

	while city_data[arg_79_1]["difficulty" .. var_79_0] do
		if city_data[arg_79_1]["difficulty" .. var_79_0] == arg_79_2 then
			return var_79_0
		end

		var_79_0 = var_79_0 + 1
	end

	return 0
end

function var_0_0:queryCanPatrolModes(arg_80_1)
	local var_80_0 = {}
	local Utility = require("common.Utility")
	local var_80_2 = {}

	for iter_80_0, iter_80_1 in ipairs(self.canPatrolChapter) do
		for iter_80_2 = 1, level_manager:getUnlockedDifficultyInCity(iter_80_1.cityid) do
			if level_manager:isChapterPass(city_data[iter_80_1.cityid]["difficulty" .. iter_80_2], iter_80_1.chapter) then
				var_80_2[#var_80_2 + 1] = {
					mode = city_data[iter_80_1.cityid]["difficulty" .. iter_80_2],
					chapter = iter_80_1.chapter,
					difficulty = iter_80_2,
					cityid = iter_80_1.cityid
				}
			end
		end
	end

	for iter_80_3, iter_80_4 in ipairs(var_80_2) do
		if Utility:indexOf(arg_80_1, iter_80_4.difficulty) > 0 then
			var_80_0[#var_80_0 + 1] = iter_80_4
		end
	end

	table.sort(var_80_0, function(arg_81_0, arg_81_1)
		if arg_81_0.cityid == arg_81_1.cityid then
			if arg_81_0.difficulty == arg_81_1.difficulty then
				return arg_81_0.chapter > arg_81_1.chapter
			else
				return arg_81_0.difficulty > arg_81_1.difficulty
			end
		else
			return arg_81_0.cityid > arg_81_1.cityid
		end
	end)

	return var_80_0
end

function var_0_0:filterPatrolArray(arg_82_1)
	local var_82_0 = {}
	local var_82_1 = {}
	local var_82_2 = {}

	for iter_82_0, iter_82_1 in ipairs(arg_82_1) do
		if not var_82_2[iter_82_1.cityid .. "_" .. iter_82_1.chapter] then
			local var_82_3 = self:getArrayonekey(iter_82_1.mode, iter_82_1.chapter, var_82_1)

			if next(var_82_3) then
				var_82_2[iter_82_1.cityid .. "_" .. iter_82_1.chapter] = true
			end

			for iter_82_2, iter_82_3 in ipairs(var_82_3) do
				var_82_1[iter_82_3] = true
			end

			if next(var_82_3) then
				var_82_0[#var_82_0 + 1] = {
					mode = iter_82_1.mode,
					chapter = iter_82_1.chapter,
					array = var_82_3
				}
			end
		end
	end

	return var_82_0
end

function var_0_0.patrolOneKey(arg_83_0, arg_83_1, arg_83_2)
	if not arg_83_1 or not next(arg_83_1) then
		global_ShowBlockWords("没有可派遣的队伍，请班长仔细检查人员配置")

		return
	end

	network:rpc("begin_patrol_one_key", {
		list = arg_83_1
	}, function(arg_84_0)
		if arg_84_0.result == 1 then
			print("patrol num", arg_84_0.num)
			global_ShowBlockWords("已成功派遣队伍驻守")
			arg_83_0:updatePatrolModel(arg_84_0.patrolInfo)
		else
			global_ShowBlockWords("没有可派遣的队伍，请班长仔细检查人员配置")
		end

		if arg_83_2 then
			arg_83_2(arg_84_0)
		end
	end)
end

return var_0_0
