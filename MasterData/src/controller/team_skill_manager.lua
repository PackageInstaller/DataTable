local var_0_0 = {}
local servant_data = require("data.servant_data")
local model_data = require("data.model_data")
local team_skill_data = require("data.team_skill_data")
local total_skill_data = require("data.total_skill_data")
local npc_fightconfig_data = require("data.npc_fightconfig_data")
local npc_data = require("data.npc_data")
local array_manager = require("controller.array_manager")
local var_0_9 = {
	mimicry = true,
	shiling = false,
	positive = true,
	umaru = true,
	water = false,
	light = false,
	dark = false,
	imaginary = false,
	fire = false,
	wind = false,
	outlander = true,
	zerosupperession = true,
	devil = true
}
local var_0_11 = {
	"devil",
	"shiling",
	"umaru",
	"zerosupperession",
	"positive",
	"mimicry",
	"outlander"
}

local function var_0_12(arg_1_0, arg_1_1, arg_1_2)
	for iter_1_0, iter_1_1 in pairs((split(arg_1_0, ","))) do
		if arg_1_1[iter_1_1] and arg_1_1[iter_1_1] > 0 then
			arg_1_1[iter_1_1] = arg_1_1[iter_1_1] - 1
			arg_1_1[arg_1_2] = arg_1_1[arg_1_2] + 1
		end
	end

	return arg_1_1[arg_1_2]
end

local function var_0_13(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in pairs((split(arg_2_1, ","))) do
		if arg_2_0[iter_2_1] > 1 then
			return false
		end
	end

	return true
end

local var_0_14 = {
	same_ele_type = function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_1 = var_0_9[team_skill_data[arg_3_0].ele_type] or false
		local var_3_2 = arg_3_1.same_ele_type[arg_3_2.same_ele_type[team_skill_data[arg_3_0].ele_type]].num
		local var_3_3 = {}
		local var_3_4 = {}
		local var_3_5 = 1

		while team_skill_data[arg_3_0]["need_num_" .. var_3_5] do
			if not var_3_1 then
				if var_3_2 == team_skill_data[arg_3_0]["need_num_" .. var_3_5] then
					local var_3_6 = 1

					while team_skill_data[arg_3_0]["effect_skill_level_" .. var_3_5 .. "_count_" .. var_3_6] do
						table.insert(var_3_4, team_skill_data[arg_3_0].ele_type)
						table.insert(var_3_3, team_skill_data[arg_3_0]["effect_skill_level_" .. var_3_5 .. "_count_" .. var_3_6])

						var_3_6 = var_3_6 + 1
					end
				end
			elseif team_skill_data[arg_3_0]["need_num_" .. var_3_5] <= var_3_2 then
				local var_3_7 = 1

				while team_skill_data[arg_3_0]["effect_skill_level_" .. var_3_5 .. "_count_" .. var_3_7] do
					table.insert(var_3_4, team_skill_data[arg_3_0].ele_type)
					table.insert(var_3_3, team_skill_data[arg_3_0]["effect_skill_level_" .. var_3_5 .. "_count_" .. var_3_7])

					var_3_7 = var_3_7 + 1
				end
			end

			var_3_5 = var_3_5 + 1
		end

		return var_3_3, var_3_4, cancelId
	end,
	diff_ele_type = function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = {}
		local var_4_1 = {}
		local var_4_2 = team_skill_data[arg_4_0].cancel_skill and split(team_skill_data[arg_4_0].cancel_skill, ",")

		if team_skill_data[arg_4_0].effect_element ~= "none" then
			local var_4_3 = var_0_12(team_skill_data[arg_4_0].effect_element, arg_4_1.diff_ele_type, team_skill_data[arg_4_0].ele_type)
			local var_4_4 = 1

			while team_skill_data[arg_4_0]["need_num_" .. var_4_4] do
				if not isSkillAccumulate then
					if var_4_3 == team_skill_data[arg_4_0]["need_num_" .. var_4_4] then
						local var_4_5 = 1

						while team_skill_data[arg_4_0]["effect_skill_level_" .. var_4_4 .. "_count_" .. var_4_5] do
							table.insert(var_4_1, team_skill_data[arg_4_0].ele_type)
							table.insert(var_4_0, team_skill_data[arg_4_0]["effect_skill_level_" .. var_4_4 .. "_count_" .. var_4_5])

							var_4_5 = var_4_5 + 1
						end
					end
				elseif team_skill_data[arg_4_0]["need_num_" .. var_4_4] <= var_4_3 then
					local var_4_6 = 1

					while team_skill_data[arg_4_0]["effect_skill_level_" .. var_4_4 .. "_count_" .. var_4_6] do
						table.insert(var_4_1, team_skill_data[arg_4_0].ele_type)
						table.insert(var_4_0, team_skill_data[arg_4_0]["effect_skill_level_" .. var_4_4 .. "_count_" .. var_4_6])

						var_4_6 = var_4_6 + 1
					end
				end

				var_4_4 = var_4_4 + 1
			end
		elseif var_0_13(arg_4_1.diff_ele_type, team_skill_data[arg_4_0].mutex_element) and arg_4_1.diff_ele_type[team_skill_data[arg_4_0].ele_type] > 0 then
			table.insert(var_4_1, team_skill_data[arg_4_0].ele_type)
			table.insert(var_4_0, team_skill_data[arg_4_0].effect_skill_none)
		else
			var_4_2 = nil
		end

		return var_4_0, var_4_1, var_4_2
	end
}

function var_0_0:getTeamskillByArrayId(arg_5_1)
	return self:getTeamskillByArrayTbl((array_manager:getBattleArrayData(arg_5_1)))
end

function var_0_0:getTeamskillByArrayTbl(arg_6_1)
	if not arg_6_1 then
		return
	end

	local var_6_0, var_6_1 = self:getArrayTransformData(arg_6_1)

	return self:getTeamskillByTransdata(var_6_0, var_6_1)
end

function var_0_0:getArrayTransformData(arg_7_1)
	local var_7_0 = {
		same_ele_type = {},
		diff_ele_type = {}
	}
	local var_7_1
	local var_7_2 = {}

	for iter_7_0, iter_7_1 in pairs(ATTR_ID) do
		if iter_7_0 ~= 0 then
			var_7_2[iter_7_1] = 0
		end
	end

	for iter_7_2, iter_7_3 in pairs(arg_7_1) do
		local var_7_4 = iter_7_3.modelid

		if not iter_7_3.modelid then
			var_7_4 = iter_7_3.fight_girl

			if iter_7_3.fight_girl then
				if servant_data[iter_7_3.fight_girl] then
					var_7_4 = servant_data[iter_7_3.fight_girl].modelid or iter_7_3.fight_girl

					if iter_7_3.npcid then
						if npc_fightconfig_data[iter_7_3.npcid].npcsoulid then
							local var_7_5 = global_get_all_model_attrs(npc_data[npc_fightconfig_data[iter_7_3.npcid].npcsoulid].model)

							var_7_1 = var_7_1 or var_7_5.main
							var_7_2[var_7_5.main] = var_7_2[var_7_5.main] + 1

							if var_7_5.sub then
								for iter_7_4, iter_7_5 in ipairs(var_7_5.sub) do
									var_7_2[iter_7_5] = var_7_2[iter_7_5] + 1
								end
							end
						else
							local var_7_6 = global_get_all_model_attrs(servant_data[npc_fightconfig_data[iter_7_3.npcid].servantid].modelid)

							var_7_1 = var_7_1 or var_7_6.main
							var_7_2[var_7_6.main] = var_7_2[var_7_6.main] + 1

							if var_7_6.sub then
								for iter_7_6, iter_7_7 in ipairs(var_7_6.sub) do
									var_7_2[iter_7_7] = var_7_2[iter_7_7] + 1
								end
							end
						end
					elseif var_7_4 then
						local var_7_7 = global_get_all_model_attrs(var_7_4)

						if not var_7_7.main then
							print("modelid not attr", var_7_4)

							var_7_7.main = "imaginary"
						end

						if not var_7_1 and var_7_7.main ~= "imaginary" then
							var_7_1 = var_7_7.main
						end

						if self:isSpecialAttr(var_7_1) and not self:isSpecialAttr(var_7_7.main) then
							var_7_1 = var_7_7.main
						end

						var_7_2[var_7_7.main] = var_7_2[var_7_7.main] + 1

						if var_7_7.sub then
							for iter_7_8, iter_7_9 in ipairs(var_7_7.sub) do
								var_7_2[iter_7_9] = var_7_2[iter_7_9] + 1
							end
						end
					end
				end
			end
		end
	end

	for iter_7_10, iter_7_11 in pairs(var_7_2) do
		var_7_0.diff_ele_type[iter_7_10] = iter_7_11
	end

	local var_7_8 = 0
	local var_7_9 = "wind"

	for iter_7_12, iter_7_13 in pairs(var_7_2) do
		if iter_7_12 ~= "imaginary" and not self:isSpecialAttr(iter_7_12) then
			if var_7_8 < iter_7_13 then
				var_7_9 = iter_7_12
				var_7_8 = iter_7_13
			elseif iter_7_13 == var_7_8 and iter_7_12 == var_7_1 then
				var_7_9 = iter_7_12
			end
		end
	end

	if var_7_8 ~= 0 then
		var_7_2[var_7_9] = var_7_2[var_7_9] + var_7_2.imaginary
		var_7_2.imaginary = 0
	end

	for iter_7_14, iter_7_15 in pairs(ATTR_INDEX) do
		local var_7_10 = {
			attr = iter_7_14
		}

		var_7_10.num = var_7_2[iter_7_14] or 0

		table.insert(var_7_0.same_ele_type, var_7_10)
	end

	local var_7_11 = {
		same_ele_type = {}
	}

	table.sort(var_7_0.same_ele_type, function(arg_8_0, arg_8_1)
		return arg_8_0.num > arg_8_1.num
	end)

	for iter_7_16, iter_7_17 in pairs(var_7_0.same_ele_type) do
		var_7_11.same_ele_type[iter_7_17.attr] = iter_7_16
	end

	return var_7_0, var_7_11
end

function var_0_0:getTeamskillByTransdata(arg_9_1, arg_9_2)
	local var_9_0 = {}
	local var_9_1 = {}
	local var_9_2 = {}

	for iter_9_0, iter_9_1 in pairs(team_skill_data) do
		if var_0_14[iter_9_1.effect_type] then
			local var_9_3, var_9_4, var_9_5 = var_0_14[iter_9_1.effect_type](iter_9_1.id, arg_9_1, arg_9_2)

			for iter_9_2, iter_9_3 in pairs(var_9_3) do
				table.insert(var_9_1, {
					id = iter_9_1.id,
					skillid = iter_9_3,
					element = var_9_4[iter_9_2]
				})
			end

			if var_9_5 and next(var_9_5) then
				for iter_9_4, iter_9_5 in pairs(var_9_5) do
					var_9_2[iter_9_5] = var_9_2[iter_9_5] or true
				end
			end
		end
	end

	local var_9_6, var_9_7, var_9_8 = self:mergeTeamSkill(var_9_1, var_9_2)

	for iter_9_6, iter_9_7 in pairs(var_9_6) do
		for iter_9_8, iter_9_9 in ipairs(var_9_8[iter_9_6]) do
			table.insert(var_9_0, {
				skillid = iter_9_6,
				eleIcon = iter_9_9,
				skillNum = var_9_7[iter_9_6]
			})
		end
	end

	print("--------------------------【生效团队技能】----------------------\n")

	for iter_9_10, iter_9_11 in pairs(var_9_0) do
		print("【" .. total_skill_data[iter_9_11.skillid].name .. "】" .. "    id:" .. iter_9_11.skillid .. "    " .. iter_9_11.eleIcon .. "      " .. iter_9_11.skillNum)
	end

	print("----------------------------------------------------------------\n")

	return var_9_0
end

function var_0_0:getTeamskillByConf(arg_10_1)
	local var_10_0, var_10_1 = self:getArrayTransformData(arg_10_1)

	return self:getTeamskillByTransdata(var_10_0, var_10_1)
end

function var_0_0:getTeamskillByArena(arg_11_1)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(arg_11_1) do
		table.insert(var_11_0, {
			fight_girl = iter_11_1.majorlist.servantid
		})
	end

	local var_11_1, var_11_2 = self:getArrayTransformData(var_11_0)

	return self:getTeamskillByTransdata(var_11_1, var_11_2)
end

function var_0_0:getTeamskillByGuide(arg_12_1)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_1) do
		table.insert(var_12_0, {
			modelid = iter_12_1.majorlist.modelid
		})
	end

	local var_12_1, var_12_2 = self:getArrayTransformData(var_12_0)

	return self:getTeamskillByTransdata(var_12_1, var_12_2)
end

function var_0_0.getSkillDes(arg_13_0, arg_13_1)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(arg_13_1) do
		table.insert(var_13_0, {
			des = total_skill_data[iter_13_1.skillid].description,
			icon = iter_13_1.eleIcon
		})
	end

	return var_13_0
end

function var_0_0.isSpecialAttr(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(var_0_11) do
		if arg_14_1 == iter_14_1 then
			return true
		end
	end

	return false
end

function var_0_0.mergeTeamSkill(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = {}
	local var_15_1 = {}
	local var_15_2 = {}

	for iter_15_0, iter_15_1 in pairs(arg_15_1) do
		if not arg_15_2[tostring(iter_15_1.id)] then
			var_15_0[iter_15_1.skillid] = true
			var_15_2[iter_15_1.skillid] = (var_15_2[iter_15_1.skillid] or 0) + 1
			var_15_1[iter_15_1.skillid] = var_15_1[iter_15_1.skillid] or {}

			table.insert(var_15_1[iter_15_1.skillid], iter_15_1.element)
		end
	end

	return var_15_0, var_15_2, var_15_1
end

return var_0_0
