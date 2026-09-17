require("fight.fightcharacter.FightCharacterDefine")

local skill_data = require("data.skill_data")
local encrypt_data = require("data.encrypt_data")
local buff_data = require("data.buff_data")
local trigger_manager = require("fight.trigger_manager")
local fightstatus_manager = require("fight.fightstatus.fightstatus_manager")

return function(arg_1_0, arg_1_1)
	local var_1_0 = {
		[MAKE_ATTACK] = true,
		[MAKE_ENERGY_ATTACK] = true,
		[MAKE_HOLY_ATTACK] = true,
		[OLDMAKE_ATTACK] = true,
		[RECOVERY] = true
	}

	local function var_1_1(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
		local var_2_0 = fightstatus_manager:getTriggerMethod(arg_2_2, true)
		local var_2_1 = {
			refrencecount = 1,
			paramtbl = arg_2_3,
			exetarget = arg_2_4,
			sourceindex = arg_1_0.index,
			statustarget = arg_2_5
		}

		if var_1_0[arg_2_2] then
			local var_2_2 = fightstatus_manager:getRealSourceParam(arg_2_3, arg_1_0) or fightstatus_manager:getTriggerSourceParam(arg_2_3, arg_1_0)

			if arg_2_4 == OWNERSELF then
				var_2_0(arg_2_1, arg_1_0.index, arg_1_0.index, var_2_2, var_2_1, arg_2_0)
			elseif arg_2_4 == TARGET then
				var_2_0(arg_2_1, arg_1_0.index, arg_1_1.index, var_2_2, var_2_1, arg_2_0)
			end
		end

		error("no meaning of the exetarget: " .. arg_2_4 .. " in the skill")
	end

	local var_1_2 = {
		[126] = true
	}

	local function var_1_3(arg_3_0, arg_3_1)
		if type(arg_3_1) ~= "number" then
			return arg_3_1
		end

		if var_1_2[arg_3_0] then
			return arg_3_1
		end

		return bit.bxor(arg_3_1, 11471007) / 10000
	end

	local function var_1_4(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		var_1_1(arg_4_0, arg_4_1, encrypt_data[arg_4_1].status_type, {
			param1 = encrypt_data[arg_4_1].param1,
			value1 = var_1_3(encrypt_data[arg_4_1].status_type, encrypt_data[arg_4_1].value1),
			target1 = encrypt_data[arg_4_1].target1,
			max1 = encrypt_data[arg_4_1].max1,
			param2 = encrypt_data[arg_4_1].param2,
			value2 = var_1_3(encrypt_data[arg_4_1].status_type, encrypt_data[arg_4_1].value2),
			target2 = encrypt_data[arg_4_1].target2,
			max2 = encrypt_data[arg_4_1].max2,
			param3 = encrypt_data[arg_4_1].param3,
			value3 = var_1_3(encrypt_data[arg_4_1].status_type, encrypt_data[arg_4_1].value3),
			target3 = encrypt_data[arg_4_1].target3,
			max3 = encrypt_data[arg_4_1].max3,
			param4 = encrypt_data[arg_4_1].param4,
			value4 = var_1_3(encrypt_data[arg_4_1].status_type, encrypt_data[arg_4_1].value4),
			target4 = encrypt_data[arg_4_1].target4,
			max4 = encrypt_data[arg_4_1].max4,
			param5 = encrypt_data[arg_4_1].param5,
			value5 = encrypt_data[arg_4_1].value5,
			target5 = encrypt_data[arg_4_1].target5,
			max5 = encrypt_data[arg_4_1].max5,
			param6 = encrypt_data[arg_4_1].param6,
			value6 = encrypt_data[arg_4_1].value6,
			target6 = encrypt_data[arg_4_1].target6,
			max6 = encrypt_data[arg_4_1].max6
		}, arg_4_2, encrypt_data[arg_4_1].statustarget)
	end

	local function var_1_5(arg_5_0, arg_5_1)
		if arg_5_1 == OWNERSELF then
			arg_1_0:addBuff(arg_5_0, arg_1_0.index)
		elseif arg_5_1 == TARGET then
			arg_1_1:addBuff(arg_5_0, arg_1_0.index)
		end
	end

	local function var_1_6(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
		arg_6_3 = arg_6_3 or 1

		if arg_6_3 < math.random() then
			return
		end

		if arg_6_4 then
			local var_6_0 = trigger_manager.decode_judge_conditions(arg_6_4, arg_6_5, arg_6_6)

			if not trigger_manager.judge_conditions(var_6_0.conditions, var_6_0.param, var_6_0.target, arg_1_0, arg_1_1) then
				return
			end
		end

		local var_6_1 = encrypt_data[arg_6_1]

		if not encrypt_data[arg_6_1] then
			if config._DEBUG then
				assert(var_6_1, "status " .. arg_6_1 .. " is nil")
			else
				return
			end
		end

		local var_6_2 = {
			param1 = var_6_1.param1,
			value1 = var_1_3(var_6_1.status_type, var_6_1.value1),
			target1 = var_6_1.target1,
			param2 = var_6_1.param2,
			value2 = var_1_3(var_6_1.status_type, var_6_1.value2),
			target2 = var_6_1.target2,
			param3 = var_6_1.param3,
			value3 = var_1_3(var_6_1.status_type, var_6_1.value3),
			target3 = var_6_1.target3,
			param4 = var_6_1.param4,
			value4 = var_1_3(var_6_1.status_type, var_6_1.value4),
			target4 = var_6_1.value4,
			param5 = var_6_1.param5,
			value5 = var_6_1.value5,
			target5 = var_6_1.target5,
			param6 = var_6_1.param6,
			value6 = var_6_1.value6,
			target6 = var_6_1.target6
		}

		if var_6_1.status_type == ADD_STATUS then
			for iter_6_0 in var_6_2.value:gmatch("([^&]+)") do
				var_1_4(arg_6_0, tonumber(iter_6_0), arg_6_2, area)
			end
		elseif var_6_1.status_type == ADD_STATUS_BUFF then
			local var_6_3, var_6_4 = var_6_2.value:match("status=(.+)/buff=(.+)")

			for iter_6_1 in var_6_3:gmatch("([^&]+)") do
				var_1_4(arg_6_0, tonumber(iter_6_1), arg_6_2)
			end

			for iter_6_2 in var_6_4:gmatch("([^&]+)") do
				var_1_5(tonumber(iter_6_2), arg_6_2)
			end
		else
			var_1_1(arg_6_0, arg_6_1, var_6_1.status_type, var_6_2, arg_6_2, var_6_1.statustarget)
		end
	end

	local function var_1_7(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6)
		arg_7_2 = arg_7_2 or 1

		if arg_7_2 < math.random() then
			return
		end

		if arg_7_3 then
			local var_7_0 = trigger_manager.decode_judge_conditions(arg_7_3, arg_7_4, arg_7_5)

			if not trigger_manager.judge_conditions(var_7_0.conditions, var_7_0.param, var_7_0.target, arg_1_0, arg_1_1) then
				return
			end
		end

		local var_7_1 = arg_1_0:getExertBuffTimeAdd(arg_7_0)
		local var_7_2 = arg_1_0:getExertBuffTimeFac(buff_data[arg_7_0].buff_or_debuff)
		local var_7_3 = arg_1_0:getExertBuffStackAdd(arg_7_0)

		if arg_7_1 == OWNERSELF then
			arg_1_0:addBuff(arg_7_0, arg_1_0.index, var_7_1, var_7_2, var_7_3, arg_7_6)
		elseif arg_7_1 == TARGET then
			arg_1_1:addBuff(arg_7_0, arg_1_0.index, var_7_1, var_7_2, var_7_3, arg_7_6)
		end
	end

	return {
		runSkill = function(arg_8_0, arg_8_1)
			if (skill_data[arg_8_0].status_union_prob or 1) < math.random() then
				return
			end

			local var_8_1 = 1

			while skill_data[arg_8_0]["status_add" .. var_8_1] do
				var_1_6(arg_8_1, skill_data[arg_8_0]["status_add" .. var_8_1], skill_data[arg_8_0]["status_target" .. var_8_1], skill_data[arg_8_0]["status_prob" .. var_8_1], skill_data[arg_8_0]["status_judge_type" .. var_8_1], skill_data[arg_8_0]["status_judge_target" .. var_8_1], skill_data[arg_8_0]["status_judge_param" .. var_8_1])

				var_8_1 = var_8_1 + 1
			end

			local var_8_2 = 1

			while skill_data[arg_8_0]["buff_add" .. var_8_2] do
				var_1_7(skill_data[arg_8_0]["buff_add" .. var_8_2], skill_data[arg_8_0]["buff_target" .. var_8_2], skill_data[arg_8_0]["buff_prob" .. var_8_2], skill_data[arg_8_0]["buff_judge_type" .. var_8_2], skill_data[arg_8_0]["buff_judge_target" .. var_8_2], skill_data[arg_8_0]["buff_judge_param" .. var_8_2], skill_data[arg_8_0]["buff_count" .. var_8_2])

				var_8_2 = var_8_2 + 1
			end
		end
	}
end
