local var_0_0 = {}
local network = require("network.network")
local item_manager = require("controller.item_manager")
local time_check_manager = require("controller.time_check_manager")
local item_data = require("data.item_data")
local major_factor_data = require("data.major_factor_data")
local twist_config_data = require("data.twist_config_data")
local twist_item_up_data = require("data.twist_item_up_data")
local servant_data = require("data.servant_data")
local model_data = require("data.model_data")

function var_0_0.get_free_times(arg_1_0, arg_1_1)
	network:rpc("get_free_twist_time", nil, function(arg_2_0)
		if arg_2_0.result == 1 then
			arg_1_1(arg_2_0.freetime)
		else
			l2Log("get free twist time fail")
		end
	end)
end

local var_0_12 = {}

local function var_0_13()
	local playermodel = require("model.playermodel")

	if item_manager:haveItem(6800110) then
		return true
	end

	return false
end

local function var_0_14(arg_4_0)
	var_0_12 = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_0) do
		local var_4_0 = json.decode(iter_4_1)

		if var_4_0.id ~= 26 or var_0_13() then
			var_0_12[var_4_0.id] = var_4_0
		end
	end
end

local var_0_15 = {
	{},
	{},
	{},
	{},
	{}
}
local var_0_16 = {}
local var_0_17 = {}

local function var_0_18(arg_5_0)
	var_0_15 = {
		{},
		{},
		{},
		{},
		{}
	}
	var_0_16 = {}

	local var_5_0 = {
		{},
		{},
		{},
		{},
		{}
	}
	local var_5_1

	for iter_5_0, iter_5_1 in ipairs(arg_5_0) do
		if iter_5_1.twisttype == 2 or iter_5_1.twisttype == 26 or iter_5_1.twisttype == 27 or iter_5_1.twisttype == 28 then
			var_5_1 = iter_5_1
		else
			table.insert(var_5_0[var_0_12[iter_5_1.twisttype].showtype or 2], iter_5_1)
		end
	end

	local function var_5_3(arg_6_0, arg_6_1)
		local var_6_0 = true
		local var_6_1 = true

		if arg_6_0.items and arg_6_0.items[1] then
			var_6_0 = item_manager:haveItem(arg_6_0.items[1])
		end

		if arg_6_1.items and arg_6_1.items[1] then
			var_6_1 = item_manager:haveItem(arg_6_1.items[1])
		end

		if var_6_0 == var_6_1 then
			return arg_6_0.pos < arg_6_1.pos
		else
			return not var_6_0 and var_6_1
		end
	end

	for iter_5_2, iter_5_3 in ipairs(var_5_0) do
		table.sort(iter_5_3, var_5_3)
	end

	if var_5_1 and (var_5_1.twisttype ~= 26 or var_0_13()) then
		table.insert(var_5_0[1], 1, var_5_1)
	end

	for iter_5_4 = 1, 5 do
		for iter_5_5, iter_5_6 in ipairs(var_5_0[iter_5_4]) do
			table.insert(var_0_15[iter_5_4], {
				pos = iter_5_5,
				upitems = iter_5_6.items,
				guaranteeitems = iter_5_6.guarantee_items,
				twistType = iter_5_6.twisttype,
				img = iter_5_6.img,
				time = iter_5_6.time,
				twistcount = iter_5_6.twistcount,
				upid = iter_5_6.upid,
				upcount = iter_5_6.upcount,
				updes = iter_5_6.updes,
				upcount2 = iter_5_6.upcount2,
				uppos2 = iter_5_6.uppos2,
				costtype = iter_5_6.costtype,
				costone = iter_5_6.costone,
				costten = iter_5_6.costten,
				dailyfreeforone = iter_5_6.dailyfreeforone,
				totalfreeforone = iter_5_6.totalfreeforone,
				dailyfreeforten = iter_5_6.dailyfreeforten,
				totalfreeforten = iter_5_6.totalfreeforten,
				naivemark = iter_5_6.naivemark,
				blackcard_type = iter_5_6.blackcard_type,
				twist_remain_count = iter_5_6.twist_remain_count,
				once_twist_ticket = iter_5_6.once_twist_ticket,
				once_twist_ticket_1 = iter_5_6.once_twist_ticket_1,
				upstarttime = iter_5_6.upstarttime,
				upfinishtime = iter_5_6.upfinishtime,
				guaranteeprob = iter_5_6.guaranteeprob,
				selectups = iter_5_6.selectups,
				select_twists = iter_5_6.select_twists,
				no_dropup_stat = iter_5_6.no_dropup_stat,
				totalCount = iter_5_6.totalCount,
				no_updrop_count = iter_5_6.no_updrop_count,
				curLevel = iter_5_6.curLevel,
				levelup_turns = iter_5_6.levelup_turns,
				levelup_dropids = iter_5_6.levelup_dropids,
				selectup_force_weightUp = iter_5_6.selectup_force_weightUp,
				selectup_force_count = iter_5_6.selectup_force_count
			})

			if iter_5_6.select_twists then
				for iter_5_7, iter_5_8 in pairs(iter_5_6.select_twists) do
					for iter_5_9, iter_5_10 in pairs(iter_5_8.items) do
						local var_5_4 = tonumber(item_data[iter_5_10].targetlayer1)

						if var_5_4 and var_5_4 >= 1800001 and var_5_4 <= 1899999 then
							if not var_0_16[var_5_4 - 1800000] then
								var_0_17[var_5_4 - 1800000] = {
									sourcetype = iter_5_6.twisttype,
									targettype = var_5_4 - 1800000,
									showtype = var_0_12[iter_5_6.twisttype].showtype,
									index = iter_5_5
								}
							end
						end
					end
				end
			end

			var_0_16[iter_5_6.twisttype] = iter_5_5
		end
	end

	for iter_5_11, iter_5_12 in pairs(var_0_15) do
		for iter_5_13, iter_5_14 in pairs(iter_5_12) do
			if iter_5_14.twistType == 2 then
				RoleDefault:getInstance():setIntegerForKey("twistType2_remain_count", iter_5_14.twist_remain_count)
			end
		end
	end
end

function var_0_0.delete_deperecate_twist(arg_7_0, arg_7_1)
	local var_7_0 = var_0_12[arg_7_1].showtype or 2

	table.remove(var_0_15[var_7_0], var_0_16[arg_7_1])

	var_0_16[arg_7_1] = nil

	for iter_7_0, iter_7_1 in pairs(var_0_15[var_7_0]) do
		var_0_16[iter_7_1.twistType] = iter_7_0
	end
end

function var_0_0.insert_new_twist(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = json.decode(arg_8_1.data)

	var_0_12[var_8_0.id] = var_8_0

	local var_8_1 = var_0_12[arg_8_1.config.twisttype].showtype or 2

	if arg_8_2 then
		var_0_16[var_0_15[var_8_1][arg_8_2].twistType] = nil
		var_0_15[var_8_1][arg_8_2].upitems = arg_8_1.config.items
		var_0_15[var_8_1][arg_8_2].guaranteeitems = arg_8_1.config.guarantee_items
		var_0_15[var_8_1][arg_8_2].twistType = arg_8_1.config.twisttype
		var_0_15[var_8_1][arg_8_2].img = arg_8_1.config.img
		var_0_15[var_8_1][arg_8_2].time = arg_8_1.config.time
		var_0_15[var_8_1][arg_8_2].twistcount = arg_8_1.config.twistcount
		var_0_15[var_8_1][arg_8_2].upid = arg_8_1.config.upid
		var_0_15[var_8_1][arg_8_2].upcount = arg_8_1.config.upcount
		var_0_15[var_8_1][arg_8_2].updes = arg_8_1.config.updes
		var_0_15[var_8_1][arg_8_2].upcount2 = arg_8_1.config.upcount2
		var_0_15[var_8_1][arg_8_2].uppos2 = arg_8_1.config.uppos2
		var_0_15[var_8_1][arg_8_2].costtype = arg_8_1.config.costtype
		var_0_15[var_8_1][arg_8_2].costone = arg_8_1.config.costone
		var_0_15[var_8_1][arg_8_2].costten = arg_8_1.config.costten
		var_0_15[var_8_1][arg_8_2].dailyfreeforone = arg_8_1.config.dailyfreeforone
		var_0_15[var_8_1][arg_8_2].totalfreeforone = arg_8_1.config.totalfreeforone
		var_0_15[var_8_1][arg_8_2].dailyfreeforten = arg_8_1.config.dailyfreeforten
		var_0_15[var_8_1][arg_8_2].totalfreeforten = arg_8_1.config.totalfreeforten
		var_0_15[var_8_1][arg_8_2].naivemark = arg_8_1.config.naivemark
		var_0_15[var_8_1][arg_8_2].blackcard_type = arg_8_1.config.blackcard_type
		var_0_15[var_8_1][arg_8_2].twist_remain_count = arg_8_1.config.twist_remain_count
		var_0_15[var_8_1][arg_8_2].once_twist_ticket = arg_8_1.config.once_twist_ticket
		var_0_15[var_8_1][arg_8_2].once_twist_ticket_1 = arg_8_1.config.once_twist_ticket_1
		var_0_15[var_8_1][arg_8_2].upstarttime = arg_8_1.config.upstarttime
		var_0_15[var_8_1][arg_8_2].upfinishtime = arg_8_1.config.upfinishtime
		var_0_15[var_8_1][arg_8_2].guaranteeprob = arg_8_1.config.guaranteeprob
		var_0_15[var_8_1][arg_8_2].selectups = arg_8_1.config.selectups
		var_0_15[var_8_1][arg_8_2].select_twists = var_0_15[var_8_1][arg_8_2].select_twists
		var_0_16[arg_8_1.config.twisttype] = arg_8_2
	else
		local var_8_2 = #var_0_15[var_8_1] + 1

		table.insert(var_0_15[var_8_1], {
			pos = #var_0_15[var_8_1] + 1,
			upitems = arg_8_1.config.items,
			guaranteeitems = arg_8_1.config.guarantee_items,
			twistType = arg_8_1.config.twisttype,
			img = arg_8_1.config.img,
			time = arg_8_1.config.time,
			twistcount = arg_8_1.config.twistcount,
			upid = arg_8_1.config.upid,
			upcount = arg_8_1.config.upcount,
			updes = arg_8_1.config.updes,
			upcount2 = arg_8_1.config.upcount2,
			uppos2 = arg_8_1.config.uppos2,
			costtype = arg_8_1.config.costtype,
			costone = arg_8_1.config.costone,
			costten = arg_8_1.config.costten,
			dailyfreeforone = arg_8_1.config.dailyfreeforone,
			totalfreeforone = arg_8_1.config.totalfreeforone,
			dailyfreeforten = arg_8_1.config.dailyfreeforten,
			totalfreeforten = arg_8_1.config.totalfreeforten,
			naivemark = arg_8_1.config.naivemark,
			blackcard_type = arg_8_1.config.blackcard_type,
			twist_remain_count = arg_8_1.config.twist_remain_count,
			once_twist_ticket = arg_8_1.config.once_twist_ticket,
			once_twist_ticket_1 = arg_8_1.config.once_twist_ticket_1,
			upstarttime = arg_8_1.config.upstarttime,
			upfinishtime = arg_8_1.config.upfinishtime,
			guaranteeprob = arg_8_1.config.guaranteeprob,
			selectups = arg_8_1.config.selectups,
			select_twists = arg_8_1.config.select_twists
		})

		var_0_16[arg_8_1.config.twisttype] = var_8_2
	end
end

function var_0_0.chang_config(arg_9_0, arg_9_1, arg_9_2)
	var_0_12[arg_9_2.twiststatus.twisttype] = var_0_12[arg_9_2.twiststatus.twisttype] or json.decode(arg_9_2.twistConfig)

	local var_9_0 = var_0_16[arg_9_1]

	if var_0_16[arg_9_1] then
		var_0_16[var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].twistType] = nil
		var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].upitems = arg_9_2.twiststatus.items
		var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].guaranteeitems = arg_9_2.twiststatus.guarantee_items
		var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].twistType = arg_9_2.twiststatus.twisttype
		var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].img = arg_9_2.twiststatus.img
		var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].time = arg_9_2.twiststatus.time
		var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].twistcount = arg_9_2.twiststatus.twistcount
		var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].upid = arg_9_2.twiststatus.upid
		var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].upcount = arg_9_2.twiststatus.upcount
		var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].updes = arg_9_2.twiststatus.updes
		var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].upcount2 = arg_9_2.twiststatus.upcount2
		var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].uppos2 = arg_9_2.twiststatus.uppos2
		var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].costtype = arg_9_2.twiststatus.costtype
		var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].costone = arg_9_2.twiststatus.costone
		var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].costten = arg_9_2.twiststatus.costten
		var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].dailyfreeforone = arg_9_2.twiststatus.dailyfreeforone
		var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].totalfreeforone = arg_9_2.twiststatus.totalfreeforone
		var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].dailyfreeforten = arg_9_2.twiststatus.dailyfreeforten
		var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].totalfreeforten = arg_9_2.twiststatus.totalfreeforten
		var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].naivemark = arg_9_2.twiststatus.naivemark
		var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].blackcard_type = arg_9_2.twiststatus.blackcard_type
		var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].twist_remain_count = arg_9_2.twiststatus.twist_remain_count
		var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].once_twist_ticket = arg_9_2.twiststatus.once_twist_ticket
		var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].once_twist_ticket_1 = arg_9_2.twiststatus.once_twist_ticket_1
		var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].upstarttime = arg_9_2.twiststatus.upstarttime
		var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].upfinishtime = arg_9_2.twiststatus.upfinishtime
		var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].guaranteeprob = arg_9_2.twiststatus.guaranteeprob
		var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].selectups = arg_9_2.twiststatus.selectups
		var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].select_twists = var_0_15[var_0_12[arg_9_2.twiststatus.twisttype].showtype or 2][var_9_0].select_twists
		var_0_16[arg_9_2.twiststatus.twisttype] = var_9_0
	end
end

function var_0_0.get_twist_list(arg_10_0, arg_10_1)
	arg_10_1 = arg_10_1 or 2

	return var_0_15[arg_10_1]
end

function var_0_0.get_twist_type_to_index(arg_11_0)
	return var_0_16
end

function var_0_0.get_change_twist_tbl(arg_12_0)
	return var_0_17
end

function var_0_0:change_selectup_twist(arg_13_1)
	if var_0_17[arg_13_1] then
		self:set_select_from_twistgroup(var_0_17[arg_13_1].sourcetype, nil, var_0_17[arg_13_1].targettype)
	end
end

function var_0_0.get_twist_showtype(arg_14_0, arg_14_1)
	return var_0_12[arg_14_1].showtype or 2
end

function var_0_0.get_twist_config_data(arg_15_0)
	return var_0_12
end

function var_0_0.is_have_twist(arg_16_0, arg_16_1)
	return next(var_0_15[arg_16_1]) ~= nil
end

function var_0_0:get_twist_upitem(arg_17_1)
	if not var_0_16[arg_17_1] then
		return nil
	end

	local var_17_0 = self:get_twist_list((self:get_twist_showtype(arg_17_1)))[var_0_16[arg_17_1]]

	if not var_17_0 then
		return nil
	end

	return var_17_0.upitems[1]
end

function var_0_0:get_twist_upitems(arg_18_1)
	if not var_0_16[arg_18_1] then
		return nil
	end

	local var_18_0 = self:get_twist_list((self:get_twist_showtype(arg_18_1)))[var_0_16[arg_18_1]]

	if not var_18_0 then
		return nil
	end

	return var_18_0.upitems
end

function var_0_0:get_init_show_twist()
	for iter_19_0, iter_19_1 in ipairs({
		4,
		2,
		3,
		1,
		5
	}) do
		if self:is_have_twist(iter_19_1) then
			return iter_19_1
		end
	end

	error("No Twist!!!!!!!!")
end

local var_0_19 = {}

function var_0_0.is_selectup_twist(arg_20_0, arg_20_1)
	if not var_0_12[arg_20_1] then
		return false
	end

	if not var_0_12[arg_20_1].selectup then
		return false
	end

	return true
end

function var_0_0:is_new_selectup_twist(arg_21_1)
	if not var_0_16[arg_21_1] then
		return false
	end

	local var_21_0 = self:get_twist_list((self:get_twist_showtype(arg_21_1)))[var_0_16[arg_21_1]]

	if not var_21_0 then
		return false
	end

	if var_21_0.select_twists then
		return true
	end
end

function var_0_0.get_twist_selectup_uitype(arg_22_0, arg_22_1)
	return var_0_12[arg_22_1].selectupui or 1
end

function var_0_0:need_set_selectups(arg_23_1)
	if not var_0_12[arg_23_1] then
		return false
	end

	local var_23_0
	local var_23_1

	if not var_0_12[arg_23_1].selectup then
		do return false end

		var_23_0 = var_0_16[arg_23_1]
		var_23_1 = next
	end

	return var_23_1(var_0_15[self:get_twist_showtype(arg_23_1)][var_23_0].selectups) == nil
end

function var_0_0:get_selectup_list(arg_24_1)
	return var_0_15[self:get_twist_showtype(arg_24_1)][var_0_16[arg_24_1]].upitems
end

function var_0_0:get_select_twists(arg_25_1)
	return var_0_15[self:get_twist_showtype(arg_25_1)][var_0_16[arg_25_1]].select_twists
end

function var_0_0:get_items_by_twisttype(arg_26_1)
	local var_26_0 = var_0_15[self:get_twist_showtype(arg_26_1)][var_0_16[arg_26_1]].select_twists
	local var_26_1 = {}

	if not var_26_0 then
		return nil
	end

	for iter_26_0, iter_26_1 in pairs(var_26_0) do
		table.insert(var_26_1, iter_26_1.items[1])
	end

	return var_26_1
end

function var_0_0:get_selected_up(arg_27_1)
	local var_27_0 = var_0_15[self:get_twist_showtype(arg_27_1)][var_0_16[arg_27_1]]

	if not var_27_0.selectups then
		return nil
	end

	return var_27_0.selectups[1]
end

function var_0_0:is_have_selectup(arg_28_1)
	if not var_0_12[arg_28_1] then
		return false
	end

	if not var_0_12[arg_28_1].selectup then
		return false
	end

	local var_28_0 = var_0_15[self:get_twist_showtype(arg_28_1)][var_0_16[arg_28_1]]

	if not var_28_0.selectups then
		return false
	end

	return var_28_0.selectups[1] ~= nil
end

function var_0_0.is_setting_selectup(arg_29_0, arg_29_1)
	return var_0_19[arg_29_1]
end

function var_0_0.set_selectups(arg_30_0, arg_30_1, arg_30_2)
	if not var_0_12[arg_30_1] then
		return
	end

	if not var_0_12[arg_30_1].selectup then
		return
	end

	if not arg_30_2 then
		return
	end

	var_0_19[arg_30_1] = true

	network:rpc("set_twistegg_select_ups", {
		twisttype = arg_30_1,
		selectups = {
			arg_30_2
		}
	}, function(arg_31_0)
		hx_print("msg.result")
		print(arg_31_0.result)

		var_0_19[arg_30_1] = nil

		if arg_31_0.result ~= 1 and arg_31_0.result ~= 8 then
			return
		end

		local var_31_0 = arg_30_0:get_twist_showtype(arg_30_1)

		if not var_0_16[arg_30_1] then
			return
		end

		local var_31_1 = var_0_15[var_31_0][var_0_16[arg_30_1]]

		if not var_0_15[var_31_0][var_0_16[arg_30_1]] then
			return
		end

		var_31_1.selectups = {
			arg_30_2
		}

		local var_31_2 = cc.EventCustom:new("ON_SET_TWIST_SELECTUP")

		var_31_2.twisttype = arg_30_1

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_31_2)
	end)
end

function var_0_0:set_select_from_twistgroup(arg_32_1, arg_32_2, arg_32_3)
	if not var_0_12[arg_32_1] then
		return
	end

	local var_32_0 = self:get_twisttype_by_itemid(arg_32_1, arg_32_2)

	if arg_32_3 then
		var_32_0 = arg_32_3
	end

	if not var_32_0 then
		return
	end

	if var_32_0 == arg_32_1 then
		return
	end

	var_0_19[arg_32_1] = true

	network:rpc("set_select_from_twistgroup", {
		twisttype = arg_32_1,
		targetid = var_32_0
	}, function(arg_33_0)
		var_0_19[arg_32_1] = nil

		if arg_33_0.result == 1 then
			local var_33_0 = self:get_twist_showtype(arg_32_1)

			if not var_0_16[arg_32_1] then
				return
			end

			local var_33_1 = var_0_15[var_33_0][var_0_16[arg_32_1]]

			if not var_0_15[var_33_0][var_0_16[arg_32_1]] then
				return
			end

			var_33_1.selectups = {
				arg_32_2
			}

			if not arg_33_0.twiststatus then
				return
			end

			if not var_0_16[var_32_0] then
				local var_33_2 = self:chang_config(arg_32_1, arg_33_0)
			end

			local playermodel = require("model.playermodel")

			if arg_33_0.cost_diamond then
				playermodel.diamond = playermodel.diamond - arg_33_0.cost_diamond

				global_update_gold_stone_diamond(nil, nil, arg_33_0.cost_diamond)
			end

			for iter_33_0, iter_33_1 in ipairs(arg_33_0.cost_items) do
				item_manager:deleteItem(iter_33_1.entityid, iter_33_1.num)
			end

			local var_33_4 = cc.EventCustom:new("ON_SET_TWIST_NEW_SELECTUP")

			var_33_4.index = var_0_16[var_32_0]

			cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_33_4)
		elseif arg_33_0.result == 2 then
			global_ShowBlockWords("失败，不能自选up")
		elseif arg_33_0.result == 3 then
			global_ShowBlockWords("砖石不足")
			LayerManager:pushInLayer("PopGoGainLayer", {
				item = 7777777
			})
		elseif arg_33_0.result == 4 then
			global_ShowBlockWords("失败，当前up不可用")
		end
	end)
end

function var_0_0.get_select_from_twistgroup_cost(arg_34_0, arg_34_1)
	return
end

function var_0_0:get_twisttype_by_itemid(arg_35_1, arg_35_2)
	if not var_0_12[arg_35_1] then
		return
	end

	if not arg_35_2 then
		return nil
	end

	for iter_35_0, iter_35_1 in pairs((self:get_select_twists(arg_35_1))) do
		if arg_35_2 == iter_35_1.items[1] then
			return iter_35_1.twisttype
		end
	end
end

function var_0_0:get_single_servantup(arg_36_1)
	if self:is_selectup_twist(arg_36_1) then
		return nil
	end

	local var_36_0 = var_0_15[self:get_twist_showtype(arg_36_1)][var_0_16[arg_36_1]]

	if not var_36_0.upitems then
		return nil
	end

	if #var_36_0.upitems > 1 then
		return nil
	end

	local var_36_1 = var_36_0.upitems[1]

	if item_data[var_36_0.upitems[1]].bag_item_type ~= kITEM_HERO then
		return nil
	end

	return item_data[var_36_1].servant
end

function var_0_0.is_overclock_twist(arg_37_0, arg_37_1)
	return var_0_12[arg_37_1].overclock ~= nil
end

function var_0_0:can_show_overclock_twist(arg_38_1)
	if not self:is_overclock_twist(arg_38_1) then
		return false
	end

	local var_38_0 = self:get_single_servantup(arg_38_1)

	if not var_38_0 then
		return false
	end

	return model_data[servant_data[var_38_0].modelid].over_clocking_skill ~= nil
end

local var_0_20 = {}

function var_0_0.is_showing_overclock_now(arg_39_0, arg_39_1)
	if var_0_20[arg_39_1] ~= nil then
		return var_0_20[arg_39_1]
	end

	var_0_20[arg_39_1] = true

	return var_0_20
end

function var_0_0.show_twist_overclock(arg_40_0, arg_40_1, arg_40_2)
	var_0_20[arg_40_1] = arg_40_2
end

function var_0_0.get_twist_status(arg_41_0, arg_41_1)
	network:rpc("get_twist_status", {}, function(arg_42_0)
		var_0_14(arg_42_0.twistConfigList)
		var_0_18(arg_42_0.config)

		if arg_41_1 then
			arg_41_1()
		end
	end)
end

function var_0_0.get_ai_twist_status(arg_43_0, arg_43_1)
	network:rpc("get_twist_status", {
		twistclass = 2
	}, function(arg_44_0)
		var_0_0.data = arg_44_0.config

		if arg_43_1 then
			arg_43_1(arg_44_0.config)
		end
	end)
end

function var_0_0.get_foolsday_twist_status(arg_45_0, arg_45_1)
	network:rpc("get_twist_status", {
		twistclass = 3
	}, function(arg_46_0)
		var_0_0.data = arg_46_0.config

		if arg_45_1 then
			arg_45_1(arg_46_0.config)
		end
	end)
end

function var_0_0.get_skin_twist_status(arg_47_0, arg_47_1)
	network:rpc("get_twist_status", {
		twistclass = 4
	}, function(arg_48_0)
		var_0_0.data = arg_48_0.config

		if arg_47_1 then
			arg_47_1(arg_48_0.config, arg_48_0.twistConfigList)
		end
	end)
end

function var_0_0.set_twist_status(arg_49_0, arg_49_1)
	if arg_49_1 then
		arg_49_1(var_0_0.data)
	end
end

function var_0_0.checkIsAlertNew(arg_50_0)
	local var_50_0 = time_check_manager:getCurTime() or os.time()
	local var_50_1 = RoleDefault:getInstance():getStringForKey("twist_new_mark", "nil")
	local var_50_2 = RoleDefault:getInstance():getStringForKey("twist_new_up_mark", "nil")

	if var_50_1 == "nil" and var_50_2 == "nil" then
		return false
	else
		if var_50_1 ~= "nil" then
			local var_50_3 = {}

			for iter_50_0 in var_50_1:gmatch("([^,]+),") do
				var_50_3[tonumber(iter_50_0)] = true
			end

			for iter_50_1, iter_50_2 in pairs(twist_config_data) do
				if (not iter_50_2.starttime or var_50_0 >= os.time(parse_time(iter_50_2.starttime))) and (not iter_50_2.finishtime or var_50_0 < os.time(parse_time(iter_50_2.finishtime))) and not var_50_3[iter_50_1] then
					return true
				end
			end
		end

		if var_50_2 ~= "nil" then
			local var_50_4 = {}

			for iter_50_3 in var_50_2:gmatch("([^,]+),") do
				var_50_4[tonumber(iter_50_3)] = true
			end

			for iter_50_4, iter_50_5 in pairs(twist_config_data) do
				if (not iter_50_5.starttime or var_50_0 >= os.time(parse_time(iter_50_5.starttime))) and (not iter_50_5.finishtime or var_50_0 < os.time(parse_time(iter_50_5.finishtime))) then
					for iter_50_6, iter_50_7 in pairs(twist_item_up_data) do
						if (not iter_50_7.starttime or var_50_0 >= os.time(parse_time(iter_50_7.starttime))) and (not iter_50_7.finishtime or var_50_0 < os.time(parse_time(iter_50_7.finishtime))) and iter_50_7.itemupid == iter_50_5.itemup and not var_50_4[iter_50_6] then
							return true
						end
					end
				end
			end
		end
	end
end

function var_0_0.isTwistNew(arg_51_0, arg_51_1)
	if not time_check_manager:getCurTime() then
		local var_51_0 = os.time()
	end

	local var_51_1 = RoleDefault:getInstance():getStringForKey("twist_new_mark", "nil")

	if var_51_1 ~= "nil" then
		local var_51_2 = {}

		for iter_51_0 in var_51_1:gmatch("([^,]+),") do
			var_51_2[tonumber(iter_51_0)] = true
		end

		if var_51_2[arg_51_1] then
			return false
		else
			return true
		end
	elseif var_51_1 == "nil" then
		return true
	end
end

function var_0_0.isTwistUpNew(arg_52_0, arg_52_1)
	if not arg_52_1 then
		return false
	end

	local var_52_0 = time_check_manager:getCurTime() or os.time()
	local var_52_1 = RoleDefault:getInstance():getStringForKey("twist_new_up_mark", "nil")

	if var_52_1 ~= "nil" then
		local var_52_2 = {}

		for iter_52_0 in var_52_1:gmatch("([^,]+),") do
			var_52_2[tonumber(iter_52_0)] = true
		end

		if var_52_2[arg_52_1] then
			return false
		else
			return true
		end
	elseif var_52_1 == "nil" then
		local var_52_3 = ""

		for iter_52_1, iter_52_2 in pairs(twist_item_up_data) do
			if (not iter_52_2.starttime or var_52_0 >= os.time(parse_time(iter_52_2.starttime))) and (not iter_52_2.finishtime or var_52_0 < os.time(parse_time(iter_52_2.finishtime))) then
				var_52_3 = var_52_3 .. iter_52_1 .. ","
			end
		end

		RoleDefault:getInstance():setStringForKey("twist_new_up_mark", var_52_3)

		return false
	end
end

function var_0_0.markTwistOld(arg_53_0, arg_53_1)
	print("MarkTwistOld: ", arg_53_1)

	local var_53_0 = RoleDefault:getInstance():getStringForKey("twist_new_mark")

	if var_53_0 then
		local var_53_1 = {}

		for iter_53_0 in var_53_0:gmatch("([^,]+),") do
			var_53_1[iter_53_0] = true
		end

		if var_53_1[arg_53_1] then
			return
		else
			var_53_1[arg_53_1] = true
		end

		local var_53_2 = ""

		for iter_53_1, iter_53_2 in pairs(var_53_1) do
			var_53_2 = var_53_2 .. iter_53_1 .. ","
		end

		print("MarkStr: ", var_53_2)
		RoleDefault:getInstance():setStringForKey("twist_new_mark", var_53_2)
	end
end

function var_0_0.markUpOld(arg_54_0, arg_54_1)
	local var_54_0 = RoleDefault:getInstance():getStringForKey("twist_new_up_mark")

	if var_54_0 then
		local var_54_1 = {}

		for iter_54_0 in var_54_0:gmatch("([^,]+),") do
			var_54_1[iter_54_0] = true
		end

		if var_54_1[arg_54_1] then
			return
		else
			var_54_1[arg_54_1] = true
		end

		local var_54_2 = ""

		for iter_54_1, iter_54_2 in pairs(var_54_1) do
			var_54_2 = var_54_2 .. iter_54_1 .. ","
		end

		RoleDefault:getInstance():setStringForKey("twist_new_up_mark", var_54_2)
	end
end

local function var_0_21(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = {
		type_tbl = {}
	}

	if arg_55_0 == 4 then
		var_55_0[1] = {
			attribute = 1,
			content = {}
		}
		var_55_0[2] = {
			attribute = 2,
			content = {}
		}
		var_55_0[3] = {
			attribute = 3,
			content = {}
		}
		var_55_0[4] = {
			attribute = 4,
			content = {}
		}

		local var_55_1 = {
			[65] = 2,
			[17] = 3,
			[67] = 1
		}

		setmetatable(var_55_1, {
			__index = function(arg_56_0, arg_56_1)
				return 4
			end
		})

		for iter_55_0, iter_55_1 in ipairs(arg_55_1) do
			table.insert(var_55_0[var_55_1[item_data[iter_55_1.itemid].bag_item_type]].content, {
				itemid = iter_55_1.itemid
			})
		end
	else
		local var_55_2 = {
			attribute = 999,
			content = {}
		}
		local var_55_3 = {
			attribute = 1,
			content = {}
		}

		for iter_55_2, iter_55_3 in ipairs(arg_55_1) do
			if item_data[iter_55_3.itemid].bag_item_type ~= kITEM_HORCRUX or arg_55_2 then
				table.insert(var_55_3.content, {
					itemid = iter_55_3.itemid
				})

				if iter_55_3.isup then
					table.insert(var_55_2.content, {
						itemid = iter_55_3.itemid
					})
				end
			end
		end

		if #var_55_2.content > 0 then
			var_55_0[#var_55_0 + 1] = var_55_2
		end

		var_55_0[#var_55_0 + 1] = var_55_3
	end

	return var_55_0
end

local drop_words_data = require("data.drop_words_data")

local function var_0_23(arg_57_0)
	local var_57_0 = {
		type_tbl = {}
	}
	local var_57_1 = {
		attribute = 1,
		content = {}
	}

	table.insert(var_57_1.content, {
		itemid = string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(drop_words_data[arg_57_0].type1_words1, "SP", "独特"), "UR", "精英"), "MR", "超凡"), "SR", "普通"), "UP", "概率提升"), "up", "概率提升")
	})
	table.insert(var_57_0, var_57_1)

	return var_57_0
end

function var_0_0:get_twist_drop_info(arg_58_1, arg_58_2)
	local var_58_0 = var_0_12[arg_58_1].is_horcrux_show_in_dropdetails == 1
	local var_58_1 = var_0_15[self:get_twist_showtype(arg_58_1)][var_0_16[arg_58_1]]
	local var_58_2 = var_58_1.upstarttime
	local var_58_3 = var_58_1.upfinishtime

	network:rpc("get_twistegg_drop_info", {
		twisttype = arg_58_1
	}, function(arg_59_0)
		local var_59_0 = {
			category = {
				type = 2,
				egg_pool_type = arg_58_1,
				is_limit_twist_pool = var_0_12[arg_58_1].is_limit_twist_pool,
				data = arg_59_0.list,
				Items_Uptime = {
					startTime = var_58_2,
					finishTime = var_58_3
				}
			},
			items_tbl = var_0_21(arg_58_1, arg_59_0.list, var_58_0)
		}

		var_59_0.words_tbl = var_0_23(arg_59_0.dropwordid or arg_58_1)

		if arg_58_2 then
			arg_58_2(arg_59_0.result, var_59_0)
		end
	end)
end

function var_0_0.generate_twist_drop_probs(arg_60_0, arg_60_1)
	local var_60_0 = {}
	local var_60_1 = {
		horcrux = {},
		girls = {},
		skins = {},
		others = {}
	}
	local var_60_2 = {}
	local var_60_3 = {}
	local var_60_4 = {}
	local var_60_5 = {}

	local function var_60_6(arg_61_0, arg_61_1, arg_61_2, arg_61_3)
		table.insert(var_60_3, {
			prob = 0,
			haveup = false,
			itemtype = arg_61_0,
			rarity = arg_61_1,
			word = arg_61_2,
			itemid = arg_61_3,
			list = {}
		})
	end

	local var_60_7 = {
		[kITEM_HERO] = function(arg_64_0)
			return servant_data[item_data[arg_64_0].servant].roll_rarity or 2
		end,
		[kITEM_HORCRUX] = function(arg_65_0)
			return item_data[arg_65_0].rarity
		end
	}

	local function var_60_8(arg_66_0)
		local var_66_0 = tonumber(arg_66_0.prob)
		local var_66_1 = var_60_5[arg_66_0.itemid] or var_60_4[item_data[arg_66_0.itemid].bag_item_type]

		if type(var_66_1) == "table" then
			var_66_1 = var_60_4[item_data[arg_66_0.itemid].bag_item_type][var_60_7[item_data[arg_66_0.itemid].bag_item_type](arg_66_0.itemid)]
		end

		table.insert(var_60_3[var_66_1].list, {
			itemid = arg_66_0.itemid,
			prob = var_66_0,
			star = arg_66_0.star,
			isup = arg_66_0.isup
		})

		var_60_3[var_66_1].prob = var_60_3[var_66_1].prob + var_66_0

		if arg_66_0.isup then
			table.insert(var_60_2, arg_66_0.itemid)

			var_60_3[var_66_1].haveup = true
		end
	end

	local function var_60_9(arg_67_0)
		local var_67_0 = {}

		for iter_67_0 = 1, 5 do
			if item_data[arg_67_0]["star_weight_" .. iter_67_0] and item_data[arg_67_0]["star_weight_" .. iter_67_0] > 0 then
				table.insert(var_67_0, iter_67_0)
			end
		end

		if #var_67_0 == 1 then
			return var_67_0[1] .. L_QUALITY_STAR
		else
			return string.format("%d~%d%s", var_67_0[1], var_67_0[#var_67_0], L_QUALITY_STAR)
		end
	end

	local function var_60_10(arg_68_0)
		local var_68_0 = arg_68_0.prob
		local var_68_2 = arg_68_0.star
		local var_68_3 = item_data[arg_68_0.itemid].bag_item_type

		if item_data[arg_68_0.itemid].bag_item_type == kITEM_HERO then
			table.insert(var_60_1.girls, {
				itemid = arg_68_0.itemid,
				probability = var_68_0,
				rarityWeight = var_60_7[var_68_3](arg_68_0.itemid) == 5 and 1 or 0
			})
		elseif var_68_3 == kITEM_HORCRUX then
			local var_68_4 = {
				itemid = arg_68_0.itemid,
				probability = var_68_0,
				rarityWeight = var_60_7[var_68_3](arg_68_0.itemid) == 5 and 1 or 0
			}

			var_68_4.start = var_68_2 and var_68_2 .. L_QUALITY_STAR or var_60_9(arg_68_0.itemid)

			table.insert(var_60_1.horcrux, var_68_4)
		elseif var_68_3 == kITEM_SKIN then
			table.insert(var_60_1.skins, {
				rarityWeight = 1,
				itemid = arg_68_0.itemid,
				probability = var_68_0
			})
		else
			table.insert(var_60_1.others, {
				itemid = arg_68_0.itemid,
				probability = var_68_0,
				rarityWeight = var_68_3 == kITEM_SKIN and 1 or 0
			})
		end
	end

	var_60_6(kITEM_HERO, 5, "独特学员")
	var_60_6(kITEM_HERO, 4, "超凡学员")
	var_60_6(kITEM_HERO, 3, "精英学员")
	var_60_6(kITEM_HERO, 2, "普通学员")
	var_60_6(kITEM_HORCRUX, 5, "独特魂器")
	var_60_6(kITEM_HORCRUX, 4, "超凡魂器")
	var_60_6(kITEM_HORCRUX, 3, "精英魂器")
	var_60_6(kITEM_HORCRUX, 2, "普通魂器")
	var_60_6(kITEM_SKIN, nil, "服装")
	var_60_6(kITEM_GIFT_FOR_FRIEND, nil, "礼物")
	var_60_6(kITEM_FURNITURE, nil, "家具")
	var_60_6(kITEM_MATRIAL, nil, "科研材料")
	var_60_6(kITEM_WEAPON_UPGRADE, nil, "魂武核心")
	var_60_6(kITEM_HORCRUX_CHIP, nil, "魂器碎片")
	var_60_6(nil, nil, "科研补给箱", 1600001)
	var_60_6(nil, nil, "特殊道具")
	;(function()
		for iter_62_0, iter_62_1 in ipairs(var_60_3) do
			if iter_62_1.itemid then
				var_60_5[iter_62_1.itemid] = iter_62_0
			elseif iter_62_1.itemtype then
				if iter_62_1.rarity then
					var_60_4[iter_62_1.itemtype] = var_60_4[iter_62_1.itemtype] or {}
					var_60_4[iter_62_1.itemtype][iter_62_1.rarity] = iter_62_0
				else
					var_60_4[iter_62_1.itemtype] = iter_62_0
				end
			end
		end

		local var_62_0 = #var_60_3

		setmetatable(var_60_4, {
			__index = function()
				return var_62_0
			end
		})
	end)()

	for iter_60_0, iter_60_1 in ipairs(arg_60_1) do
		var_60_8(iter_60_1)
	end

	for iter_60_2, iter_60_3 in ipairs(var_60_3) do
		if iter_60_3.haveup then
			local var_60_11 = 0
			local var_60_12 = 0

			for iter_60_4, iter_60_5 in ipairs(iter_60_3.list) do
				var_60_10(iter_60_5)

				if iter_60_5.isup then
					var_60_11 = var_60_11 + iter_60_5.prob
				else
					var_60_12 = var_60_12 + iter_60_5.prob
				end
			end

			if var_60_11 > 0 then
				table.insert(var_60_0, {
					probability = var_60_11,
					name = iter_60_3.word .. "(概率提升)"
				})
			end

			if var_60_12 > 0 then
				table.insert(var_60_0, {
					probability = var_60_12,
					name = iter_60_3.word .. "(正常概率)"
				})
			end
		else
			local var_60_13 = 0

			for iter_60_6, iter_60_7 in ipairs(iter_60_3.list) do
				var_60_10(iter_60_7)

				var_60_13 = var_60_13 + 1
			end

			if var_60_13 > 0 then
				table.insert(var_60_0, {
					probability = iter_60_3.prob,
					name = iter_60_3.word
				})
			end
		end
	end

	return var_60_0, var_60_1, var_60_2
end

function var_0_0.get_data_by_type(arg_69_0, arg_69_1)
	return var_0_12[arg_69_1]
end

function var_0_0.getStatData(arg_70_0, arg_70_1, arg_70_2, arg_70_3)
	local var_70_0 = {}
	local var_70_1 = require("data.activity_" .. arg_70_1 .. ".activity_task_index_" .. arg_70_1 .. "_data")

	if var_70_1 then
		for iter_70_0, iter_70_1 in pairs(var_70_1) do
			if string.find(iter_70_1.usemodule, "total_twist") then
				table.insert(var_70_0, iter_70_1.taskid)
			end
		end
	end

	local var_70_2 = twist_config_data[arg_70_2].activity_task_group or arg_70_2

	network:rpc("activity_get_stat_data", {
		activityid = arg_70_1,
		stat_list = {
			"twist_count_activity" .. var_70_2
		}
	}, function(arg_71_0)
		if arg_71_0.result == 1 then
			local var_71_0
			local var_71_1 = require("data.activity_" .. arg_70_1 .. ".activity_task_" .. arg_70_1 .. "_data")

			for iter_71_0, iter_71_1 in pairs(var_70_0) do
				if arg_71_0.list[1].value < var_71_1[iter_71_1].needs_num then
					var_71_0 = var_71_1[iter_71_1].needs_num - arg_71_0.list[1].value

					break
				elseif var_71_1[iter_71_1].needs_num == arg_71_0.list[1].value then
					if var_71_1[var_70_0[iter_71_0 + 1]] then
						var_71_0 = var_71_1[var_70_0[iter_71_0 + 1]].needs_num - arg_71_0.list[1].value

						break
					end

					var_71_0 = nil

					break
				elseif iter_71_0 == #var_70_0 and var_71_1[iter_71_1].needs_num < arg_71_0.list[1].value then
					var_71_0 = nil

					break
				end
			end

			if var_71_0 and var_71_0 <= 0 then
				var_71_0 = nil
			end

			arg_70_3(var_71_0)
		end
	end)
end

return var_0_0
