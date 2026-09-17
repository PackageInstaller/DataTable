local var_0_0 = {}
local drop_data = require("data.drop_data")
local item_data = require("data.item_data")

local function var_0_3(arg_1_0)
	local var_1_0 = {
		arg_1_0[1]
	}

	for iter_1_0 = 2, #arg_1_0 do
		var_1_0[iter_1_0] = var_1_0[iter_1_0 - 1] + arg_1_0[iter_1_0]
	end

	local var_1_1 = math.random()

	for iter_1_1 = 1, #var_1_0 do
		if var_1_1 <= var_1_0[iter_1_1] then
			return iter_1_1
		end
	end

	return #arg_1_0 + 1
end

function var_0_0.getEquipDrops(arg_2_0, arg_2_1)
	local var_2_0 = {}

	if drop_data[arg_2_1].drop_id1 then
		local var_2_1 = {}
		local var_2_2 = 1

		while drop_data[arg_2_1]["drop_id" .. var_2_2] do
			if var_2_1[drop_data[arg_2_1]["drop_id" .. var_2_2]] == nil then
				var_2_1[drop_data[arg_2_1]["drop_id" .. var_2_2]] = {}
			end

			if var_2_1[drop_data[arg_2_1]["drop_id" .. var_2_2]].nums == nil then
				var_2_1[drop_data[arg_2_1]["drop_id" .. var_2_2]].nums = {}
			end

			if var_2_1[drop_data[arg_2_1]["drop_id" .. var_2_2]].rates == nil then
				var_2_1[drop_data[arg_2_1]["drop_id" .. var_2_2]].rates = {}
			end

			if var_2_1[drop_data[arg_2_1]["drop_id" .. var_2_2]].item_attrs == nil then
				var_2_1[drop_data[arg_2_1]["drop_id" .. var_2_2]].item_attrs = {}
			end

			var_2_1[drop_data[arg_2_1]["drop_id" .. var_2_2]]._index = var_2_2
			var_2_1[drop_data[arg_2_1]["drop_id" .. var_2_2]].nums[#var_2_1[drop_data[arg_2_1]["drop_id" .. var_2_2]].nums + 1] = drop_data[arg_2_1]["drop_num" .. var_2_2]
			var_2_1[drop_data[arg_2_1]["drop_id" .. var_2_2]].rates[#var_2_1[drop_data[arg_2_1]["drop_id" .. var_2_2]].rates + 1] = drop_data[arg_2_1]["drop_rate" .. var_2_2]
			var_2_1[drop_data[arg_2_1]["drop_id" .. var_2_2]].item_attrs[#var_2_1[drop_data[arg_2_1]["drop_id" .. var_2_2]].item_attrs + 1] = drop_data[arg_2_1]["drop_extra" .. var_2_2]
			var_2_2 = var_2_2 + 1
		end

		for iter_2_0, iter_2_1 in pairs(var_2_1) do
			iter_2_1.nums[#iter_2_1.nums + 1] = 0

			local var_2_3 = var_0_3(iter_2_1.rates)

			if iter_2_1.nums[var_2_3] > 0 then
				var_2_0[#var_2_0 + 1] = {}
				var_2_0[#var_2_0 + 1].dropid = iter_2_0
				var_2_0[#var_2_0 + 1].dropNum = iter_2_1.nums[var_2_3]
				var_2_0[#var_2_0 + 1]._index = iter_2_1._index
				var_2_0[#var_2_0 + 1].item_attr = iter_2_1.item_attrs[var_2_3]
			end
		end
	end

	if drop_data[arg_2_1].rd_drop_id1 then
		local var_2_4 = {}
		local var_2_5 = 0
		local var_2_6 = {}

		while drop_data[arg_2_1]["rd_drop_id" .. 1] do
			var_2_4[1] = {}
			var_2_4[1].dropid = drop_data[arg_2_1]["rd_drop_id" .. 1]
			var_2_4[1].nums = drop_data[arg_2_1]["rd_drop_num" .. 1]
			var_2_5 = var_2_5 + drop_data[arg_2_1]["rd_drop_weight" .. 1]
			var_2_4[1]._index = 1
			var_2_4[1].item_attr = drop_data[arg_2_1]["rd_drop_extra" .. 1]
			var_2_6[1] = var_2_5
		end

		local var_2_8 = math.random(var_2_5)

		for iter_2_2 = 1, #var_2_6 do
			if var_2_8 <= var_2_6[iter_2_2] then
				var_2_0[#var_2_0 + 1] = {}
				var_2_0[#var_2_0 + 1].dropid = var_2_4[iter_2_2].dropid
				var_2_0[#var_2_0 + 1].dropNum = var_2_4[iter_2_2].nums
				var_2_0[#var_2_0 + 1]._index = var_2_4[iter_2_2]._index
				var_2_0[#var_2_0 + 1].item_attr = var_2_4[iter_2_2].item_attr

				break
			end
		end
	end

	table.sort(var_2_0, function(arg_3_0, arg_3_1)
		return arg_3_0._index < arg_3_1._index
	end)

	return var_2_0
end

function var_0_0.getEquipAllDrops(arg_4_0, arg_4_1)
	local var_4_0 = {}

	if drop_data[arg_4_1].drop_id1 then
		local var_4_1 = {}
		local var_4_2 = 1

		while drop_data[arg_4_1]["drop_id" .. var_4_2] do
			if var_4_1[drop_data[arg_4_1]["drop_id" .. var_4_2]] == nil then
				var_4_1[drop_data[arg_4_1]["drop_id" .. var_4_2]] = {}
			end

			if var_4_1[drop_data[arg_4_1]["drop_id" .. var_4_2]].nums == nil then
				var_4_1[drop_data[arg_4_1]["drop_id" .. var_4_2]].nums = {}
			end

			if var_4_1[drop_data[arg_4_1]["drop_id" .. var_4_2]].rates == nil then
				var_4_1[drop_data[arg_4_1]["drop_id" .. var_4_2]].rates = {}
			end

			if var_4_1[drop_data[arg_4_1]["drop_id" .. var_4_2]].item_attr == nil then
				var_4_1[drop_data[arg_4_1]["drop_id" .. var_4_2]].item_attr = {}
			end

			var_4_1[drop_data[arg_4_1]["drop_id" .. var_4_2]].nums[#var_4_1[drop_data[arg_4_1]["drop_id" .. var_4_2]].nums + 1] = drop_data[arg_4_1]["drop_num" .. var_4_2]
			var_4_1[drop_data[arg_4_1]["drop_id" .. var_4_2]].rates[#var_4_1[drop_data[arg_4_1]["drop_id" .. var_4_2]].rates + 1] = drop_data[arg_4_1]["drop_rate" .. var_4_2]
			var_4_1[drop_data[arg_4_1]["drop_id" .. var_4_2]].item_attr[#var_4_1[drop_data[arg_4_1]["drop_id" .. var_4_2]].item_attr + 1] = drop_data[arg_4_1]["drop_extra" .. var_4_2]
			var_4_2 = var_4_2 + 1
		end

		for iter_4_0 = 1, var_4_2 - 1 do
			var_4_0[iter_4_0] = {}
			var_4_0[iter_4_0].dropid = drop_data[arg_4_1]["drop_id" .. iter_4_0]
			var_4_0[iter_4_0].dropNum = drop_data[arg_4_1]["drop_num" .. iter_4_0]
			var_4_0[iter_4_0].item_attr = drop_data[arg_4_1]["drop_extra" .. iter_4_0]
			var_4_0[iter_4_0].index = iter_4_0
		end
	end

	if drop_data[arg_4_1].rd_drop_id1 then
		local var_4_3 = {}
		local var_4_4 = 0
		local var_4_5 = {}

		while drop_data[arg_4_1]["rd_drop_id" .. 1] do
			var_4_3[1] = {}
			var_4_3[1].dropid = drop_data[arg_4_1]["rd_drop_id" .. 1]
			var_4_3[1].nums = drop_data[arg_4_1]["rd_drop_num" .. 1]
			var_4_4 = var_4_4 + drop_data[arg_4_1]["rd_drop_weight" .. 1]
			var_4_5[1] = var_4_4
		end

		for iter_4_1 = 1, #var_4_5 do
			var_4_0[iter_4_1] = {}
			var_4_0[iter_4_1].dropid = var_4_3[iter_4_1].dropid
			var_4_0[iter_4_1].dropNum = var_4_3[iter_4_1].nums
			var_4_0[iter_4_1].index = var_4_3[iter_4_1].index
		end
	end

	return var_4_0
end

function var_0_0.getEquipDropsByCount(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = {}

	if drop_data[arg_5_1].drop_id1 then
		local var_5_2 = 1

		while drop_data[arg_5_1]["drop_id" .. var_5_2] do
			local var_5_3 = math.floor(arg_5_2 * drop_data[arg_5_1]["drop_rate" .. var_5_2])

			if var_5_3 > 0 then
				table.insert(var_5_0, {
					dropid = drop_data[arg_5_1]["drop_id" .. var_5_2],
					dropNum = drop_data[arg_5_1]["drop_num" .. var_5_2] * var_5_3
				})
			elseif math.random() <= drop_data[arg_5_1]["drop_rate" .. var_5_2] * arg_5_2 then
				table.insert(var_5_0, {
					dropNum = 1,
					dropid = drop_data[arg_5_1]["drop_id" .. var_5_2]
				})
			end

			var_5_2 = var_5_2 + 1
		end
	end

	if drop_data[arg_5_1].rd_drop_id1 then
		local var_5_4 = 0
		local var_5_5 = 1

		while drop_data[arg_5_1]["rd_drop_id" .. var_5_5] do
			var_5_4 = var_5_4 + drop_data[arg_5_1]["rd_drop_weight" .. var_5_5]
			var_5_5 = var_5_5 + 1
		end

		for iter_5_0 = 1, var_5_5 - 1 do
			local var_5_6 = math.floor(arg_5_2 * drop_data[arg_5_1]["rd_drop_weight" .. iter_5_0] / var_5_4)

			if var_5_6 > 0 then
				table.insert(var_5_0, {
					dropid = drop_data[arg_5_1]["rd_drop_id" .. iter_5_0],
					dropNum = drop_data[arg_5_1]["rd_drop_num" .. iter_5_0] * var_5_6
				})
			elseif math.random() <= arg_5_2 * drop_data[arg_5_1]["rd_drop_weight" .. iter_5_0] / var_5_4 then
				table.insert(var_5_0, {
					dropNum = 1,
					dropid = drop_data[arg_5_1]["rd_drop_id" .. iter_5_0]
				})
			end
		end
	end

	return var_5_0
end

function var_0_0.getEquipDropsByMonsterId(arg_6_0, arg_6_1)
	return var_0_0:getEquipDrops(require("data.monster_data")[arg_6_1].equip_drop)
end

function var_0_0.getGold(arg_7_0, arg_7_1)
	assert(drop_data[arg_7_1], "invalid dropid: " .. arg_7_1)

	if drop_data[arg_7_1].gold then
		return drop_data[arg_7_1].gold
	end

	return 0
end

function var_0_0.getDiamond(arg_8_0, arg_8_1)
	if drop_data[arg_8_1].diamond then
		return drop_data[arg_8_1].diamond
	end

	return 0
end

function var_0_0.getHonor(arg_9_0, arg_9_1)
	return
end

function var_0_0.getExp(arg_10_0, arg_10_1)
	if drop_data[arg_10_1].exp then
		return drop_data[arg_10_1].exp
	end

	return 0
end

function var_0_0.getSp(arg_11_0, arg_11_1)
	if drop_data[arg_11_1].sp then
		return drop_data[arg_11_1].sp
	end

	return 0
end

function var_0_0.getEnergy(arg_12_0, arg_12_1)
	if drop_data[arg_12_1].energy then
		return drop_data[arg_12_1].energy
	end

	return 0
end

function var_0_0.getNormalDrops(arg_13_0, arg_13_1)
	return {
		gold = var_0_0:getGold(arg_13_1),
		diamond = var_0_0:getDiamond(arg_13_1),
		equips = var_0_0:getEquipDrops(arg_13_1),
		exp = var_0_0:getExp(arg_13_1),
		sp = var_0_0:getSp(arg_13_1),
		energy = var_0_0:getEnergy(arg_13_1)
	}
end

function var_0_0.getModelDrops(arg_14_0, arg_14_1)
	local var_14_0 = {}

	if drop_data[arg_14_1].dropmodel_id1 then
		local var_14_1 = 1

		while drop_data[arg_14_1]["dropmodel_id" .. var_14_1] do
			if math.random() <= drop_data[arg_14_1]["dropmodel_rate" .. var_14_1] then
				for iter_14_0 = 1, drop_data[arg_14_1]["dropmodel_num" .. var_14_1] do
					table.insert(var_14_0, (var_0_0:getNormalDrops(drop_data[arg_14_1]["dropmodel_id" .. var_14_1])))
				end
			end

			var_14_1 = var_14_1 + 1
		end
	end

	if drop_data[arg_14_1].rd_dropmodel_id1 then
		local var_14_2 = 1
		local var_14_3 = {}
		local var_14_4 = {}
		local var_14_5 = 0
		local var_14_6 = {}

		while drop_data[arg_14_1]["rd_dropmodel_id" .. var_14_2] do
			table.insert(var_14_3, drop_data[arg_14_1]["rd_dropmodel_id" .. var_14_2])
			table.insert(var_14_4, drop_data[arg_14_1]["rd_dropmodel_num" .. var_14_2])

			var_14_5 = var_14_5 + drop_data[arg_14_1]["rd_dropmodel_rate" .. var_14_2]
			var_14_6[var_14_2] = var_14_5
			var_14_2 = var_14_2 + 1
		end

		local var_14_7 = math.random(var_14_5)

		for iter_14_1 = 1, #var_14_6 do
			if var_14_7 <= var_14_6[iter_14_1] then
				for iter_14_2 = 1, var_14_4[iter_14_1] do
					table.insert(var_14_0, (var_0_0:getNormalDrops(var_14_3[iter_14_1])))
				end

				break
			end
		end
	end

	return var_14_0
end

function var_0_0.getDropMsg(arg_15_0, arg_15_1)
	local var_15_1 = var_0_0:getNormalDrops(arg_15_1)

	for iter_15_0, iter_15_1 in pairs((var_0_0:getModelDrops(arg_15_1))) do
		if iter_15_1.gold then
			var_15_1.gold = var_15_1.gold + iter_15_1.gold
		end

		if iter_15_1.diamond then
			var_15_1.diamond = var_15_1.diamond + iter_15_1.diamond
		end

		if iter_15_1.stone then
			var_15_1.stone = var_15_1.stone + iter_15_1.stone
		end

		for iter_15_2, iter_15_3 in pairs(iter_15_1.equips) do
			table.insert(var_15_1.equips, iter_15_3)
		end
	end

	return var_15_1
end

function var_0_0.getNormalDropsByCount(arg_16_0, arg_16_1, arg_16_2)
	return {
		gold = var_0_0:getGold(arg_16_1) * arg_16_2,
		diamond = var_0_0:getDiamond(arg_16_1) * arg_16_2,
		stone = var_0_0:getStone(arg_16_1) * arg_16_2,
		exp = var_0_0:getExp(arg_16_1) * arg_16_2,
		favor = var_0_0:getFavor(arg_16_1) * arg_16_2,
		activity = var_0_0:getActivity(arg_16_1) * arg_16_2,
		equips = var_0_0:getEquipDropsByCount(arg_16_1, arg_16_2)
	}
end

function var_0_0.getModelDropsByCount(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = {}

	if drop_data[arg_17_1].dropmodel_id1 then
		local var_17_1 = 1

		while drop_data[arg_17_1]["dropmodel_id" .. var_17_1] do
			local var_17_2 = math.floor(arg_17_2 * drop_data[arg_17_1]["dropmodel_rate" .. var_17_1])

			if var_17_2 > 0 then
				table.insert(var_17_0, (var_0_0:getNormalDropsByCount(drop_data[arg_17_1]["dropmodel_id" .. var_17_1], var_17_2)))
			elseif math.random() <= arg_17_2 * drop_data[arg_17_1]["dropmodel_rate" .. var_17_1] then
				table.insert(var_17_0, (var_0_0:getNormalDropsByCount(drop_data[arg_17_1]["dropmodel_id" .. var_17_1], 1)))
			end

			var_17_1 = var_17_1 + 1
		end
	end

	if drop_data[arg_17_1].rd_dropmodel_id then
		local var_17_3 = 1
		local var_17_4 = 0

		while drop_data[arg_17_1]["rd_dropmodel_id" .. var_17_3] do
			var_17_4 = var_17_4 + drop_data[arg_17_1]["rd_dropmodel_rate" .. var_17_3]
			var_17_3 = var_17_3 + 1
		end

		for iter_17_0 = 1, var_17_3 - 1 do
			local var_17_5 = math.floor(arg_17_2 * drop_data[arg_17_1]["rd_dropmodel_rate" .. iter_17_0] / var_17_4)

			if var_17_5 > 0 then
				table.insert(var_17_0, (var_0_0:getNormalDropsByCount(drop_data[arg_17_1]["rd_dropmodel_id" .. iter_17_0], var_17_5)))
			elseif math.random() <= arg_17_2 * drop_data[arg_17_1]["rd_dropmodel_rate" .. iter_17_0] / var_17_4 then
				table.insert(var_17_0, (var_0_0:getNormalDropsByCount(drop_data[arg_17_1]["rd_dropmodel_id" .. iter_17_0], 1)))
			end
		end
	end

	return var_17_0
end

function var_0_0.getDropMsgByCount(arg_18_0, arg_18_1, arg_18_2)
	local var_18_1 = var_0_0:getNormalDropsByCount(arg_18_1, arg_18_2)

	for iter_18_0, iter_18_1 in pairs((var_0_0:getModelDropsByCount(arg_18_1, arg_18_2))) do
		if iter_18_1.gold then
			var_18_1.gold = var_18_1.gold + iter_18_1.gold
		end

		if iter_18_1.diamond then
			var_18_1.diamond = var_18_1.diamond + iter_18_1.diamond
		end

		if iter_18_1.stone then
			var_18_1.stone = var_18_1.stone + iter_18_1.stone
		end

		for iter_18_2, iter_18_3 in pairs(iter_18_1.equips) do
			table.insert(var_18_1.equips, iter_18_3)
		end
	end

	return var_18_1
end

function var_0_0.getAllModelDropIds(arg_19_0, arg_19_1)
	local var_19_0 = {}

	if drop_data[arg_19_1].dropmodel_id1 then
		local var_19_1 = 1

		while drop_data[arg_19_1]["dropmodel_id" .. var_19_1] do
			table.insert(var_19_0, drop_data[arg_19_1]["dropmodel_id" .. var_19_1])

			var_19_1 = var_19_1 + 1
		end
	end

	if drop_data[arg_19_1].rd_dropmodel_id1 then
		local var_19_2 = 1

		while drop_data[arg_19_1]["rd_dropmodel_id" .. var_19_2] do
			table.insert(var_19_0, drop_data[arg_19_1]["rd_dropmodel_id" .. var_19_2])

			var_19_2 = var_19_2 + 1
		end
	end

	return var_19_0
end

function var_0_0:getAllDrops(arg_20_1)
	local var_20_0 = self:getEquipAllDrops(arg_20_1)

	for iter_20_0, iter_20_1 in pairs((self:getAllModelDropIds(arg_20_1))) do
		for iter_20_2, iter_20_3 in pairs((self:getEquipAllDrops(iter_20_1))) do
			table.insert(var_20_0, iter_20_3)
		end
	end

	local var_20_1 = {}
	local var_20_2 = 1

	while var_20_0[var_20_2] do
		if not var_20_1[var_20_0[var_20_2].dropid] then
			var_20_1[var_20_0[var_20_2].dropid] = {
				index = var_20_2,
				dropNum = var_20_0[var_20_2].dropNum
			}
			var_20_2 = var_20_2 + 1
		else
			var_20_1[var_20_0[var_20_2].dropid].dropNum = var_20_1[var_20_0[var_20_2].dropid].dropNum + var_20_0[var_20_2].dropNum

			table.remove(var_20_0, var_20_2)
		end
	end

	for iter_20_4, iter_20_5 in pairs(var_20_1) do
		var_20_0[iter_20_5.index].dropNum = iter_20_5.dropNum
	end

	table.sort(var_20_0, function(arg_21_0, arg_21_1)
		if item_data[arg_21_0.dropid].equip_quality == item_data[arg_21_1.dropid].equip_quality then
			return (arg_21_0.index or -99999) < (arg_21_1.index or -99999)
		else
			return item_data[arg_21_0.dropid].equip_quality > item_data[arg_21_1.dropid].equip_quality
		end
	end)

	return var_20_0
end

function var_0_0:getAllDropsNotMerge(arg_22_1)
	local var_22_0 = self:getEquipAllDrops(arg_22_1)

	for iter_22_0, iter_22_1 in pairs((self:getAllModelDropIds(arg_22_1))) do
		for iter_22_2, iter_22_3 in pairs((self:getEquipAllDrops(iter_22_1))) do
			table.insert(var_22_0, iter_22_3)
		end
	end

	return var_22_0
end

return var_0_0
