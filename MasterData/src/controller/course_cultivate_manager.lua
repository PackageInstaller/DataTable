local var_0_0 = {}
local course_mode_data = require("data.course.course_mode_data")
local course_basic_data = require("data.course.course_basic_data")
local course_basic_cost_data = require("data.course.course_basic_cost_data")
local course_dianci_data = require("data.course.course_dianci_data")
local course_dianci_cost_data = require("data.course.course_dianci_cost_data")
local course_an_data = require("data.course.course_an_data")
local course_an_cost_data = require("data.course.course_an_cost_data")
local course_liangzi_data = require("data.course.course_liangzi_data")
local course_liangzi_cost_data = require("data.course.course_liangzi_cost_data")
local course_guang_data = require("data.course.course_guang_data")
local course_guang_cost_data = require("data.course.course_guang_cost_data")
local course_reneng_data = require("data.course.course_reneng_data")
local course_reneng_cost_data = require("data.course.course_reneng_cost_data")
local course_devil_data = require("data.course.course_devil_data")
local course_devil_cost_data = require("data.course.course_devil_cost_data")
local course_mimicry_data = require("data.course.course_mimicry_data")
local course_mimicry_cost_data = require("data.course.course_mimicry_cost_data")
local course_imaginary_data = require("data.course.course_imaginary_data")
local course_imaginary_cost_data = require("data.course.course_imaginary_cost_data")
local course_positive_data = require("data.course.course_positive_data")
local course_positive_cost_data = require("data.course.course_positive_cost_data")
local course_other_data = require("data.course.course_other_data")
local course_other_cost_data = require("data.course.course_other_cost_data")
local playermodel = require("model.playermodel")
local buff_data = require("data.buff_data")

var_0_0.instance = nil

local var_0_26 = 12

var_0_0.COURSE_TYPE = {
	IMAGINARY = 7,
	BASE = 1,
	OTHER = 12,
	QUANTUM = 4,
	POSITIVE = 10,
	ZEROSUPPERESSION = 11,
	LIGHT_ENERGY = 2,
	MIMICRY = 9,
	DEVIL = 8,
	DRAK_MATTER = 6,
	THERMAL_ENERGY = 3,
	ELECTROMAGNETISM = 5
}
var_0_0.ATTRIBUTE_TYPE = {
	DODGE = "icon_dodge",
	CRITICAL = "icon_critical",
	HEALTH = "icon_health",
	REDUCTION = "icon_reduction",
	ATTACK = "icon_attack",
	ENERGY_DEFEND = "icon_energy_defend",
	CHARGE = "icon_charge",
	DEFEND = "icon_defend",
	DAMAGE = "icon_damage",
	TACTICS = "icon_tactics"
}
var_0_0.UNLOCK_TYPE = {
	SPECIFIED_COURSE_LEVEL = 1,
	OWN_SPECIFIED_SOUL_GIRL = 3,
	OWN_SOUL_GIRL_NUM = 2,
	PLAYER_LEVEL = 4
}

local var_0_27 = L_QUICKFORMATIONLAYER.MAPTEXT
local var_0_28 = {
	null = var_0_0.COURSE_TYPE.BASE,
	wind = var_0_0.COURSE_TYPE.ELECTROMAGNETISM,
	fire = var_0_0.COURSE_TYPE.THERMAL_ENERGY,
	water = var_0_0.COURSE_TYPE.QUANTUM,
	light = var_0_0.COURSE_TYPE.LIGHT_ENERGY,
	dark = var_0_0.COURSE_TYPE.DRAK_MATTER,
	devil = var_0_0.COURSE_TYPE.DEVIL,
	mimicry = var_0_0.COURSE_TYPE.MIMICRY,
	imaginary = var_0_0.COURSE_TYPE.IMAGINARY,
	positive = var_0_0.COURSE_TYPE.POSITIVE,
	zerosupperession = var_0_0.COURSE_TYPE.ZEROSUPPERESSION,
	other = var_0_0.COURSE_TYPE.OTHER
}

function var_0_0.new(arg_1_0, ...)
	local var_1_0 = {}

	setmetatable(var_1_0, arg_1_0)

	arg_1_0.__index = arg_1_0

	var_1_0:init(...)

	return var_1_0
end

function var_0_0.getInstance()
	var_0_0.instance = var_0_0.instance or var_0_0:new()

	return var_0_0.instance
end

function var_0_0:init(...)
	self.basicCourseDatas = self:readCourseDatas(course_basic_data, course_basic_cost_data)
	self.darkMatterCourseDatas = self:readCourseDatas(course_an_data, course_an_cost_data)
	self.lightEnergyCourseDatas = self:readCourseDatas(course_guang_data, course_guang_cost_data)
	self.quantumCourseDatas = self:readCourseDatas(course_liangzi_data, course_liangzi_cost_data)
	self.thermalEnergyCourseDatas = self:readCourseDatas(course_reneng_data, course_reneng_cost_data)
	self.electromagnetismCourseDatas = self:readCourseDatas(course_dianci_data, course_dianci_cost_data)
	self.devilCourseDatas = self:readCourseDatas(course_devil_data, course_devil_cost_data)
	self.mimicryCourseDatas = self:readCourseDatas(course_mimicry_data, course_mimicry_cost_data)
	self.imaginaryCourseDatas = self:readCourseDatas(course_imaginary_data, course_imaginary_cost_data)
	self.positiveCourseDatas = self:readCourseDatas(course_positive_data, course_positive_cost_data)
	self.otherCourseDatas = self:readCourseDatas(course_other_data, course_other_cost_data)

	self:requestCourseDatas()
end

function var_0_0.requestCourseDatas(arg_4_0)
	local network = require("network.network")

	for iter_4_0, iter_4_1 in pairs(var_0_0.COURSE_TYPE) do
		if iter_4_1 < var_0_26 then
			network:rpc("get_course_data", {
				class_type = iter_4_1
			}, function(arg_5_0)
				if arg_5_0.result and arg_5_0.result == 1 then
					arg_4_0:updateCourseDatas(arg_5_0.course_data or {}, iter_4_1)
				end
			end)
		end
	end
end

function var_0_0.readCourseDatas(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		local var_6_1 = iter_6_1.course_id
		local var_6_2 = {
			courseLevel = 0,
			unlock = false,
			courseId = iter_6_1.course_id,
			courseName = iter_6_1.course_name,
			courseType = iter_6_1.class_type
		}

		var_6_2.courseIcon = iter_6_1.course_icon or var_0_0.ATTRIBUTE_TYPE.ATTACK
		var_6_2.diamond = iter_6_1.diamond
		var_6_2.isRoot = iter_6_1.course_id % 10 == 0

		local var_6_3 = 1
		local var_6_4 = {}

		while iter_6_1["unlock_type_" .. var_6_3] do
			local var_6_5 = iter_6_1["unlock_con_" .. var_6_3] or nil
			local var_6_6 = iter_6_1["unlock_num_" .. var_6_3] or 0

			var_6_4[#var_6_4 + 1] = {
				type = iter_6_1["unlock_type_" .. var_6_3],
				num = var_6_6,
				conf = var_6_5
			}
			var_6_3 = var_6_3 + 1
		end

		var_6_2.conditions = var_6_4

		local var_6_7 = {}
		local var_6_8 = 1

		while arg_6_2["" .. var_6_1 * 10 + var_6_8] do
			if not arg_6_2["" .. var_6_1 * 10 + var_6_8] then
				break
			end

			var_6_7[#var_6_7 + 1] = {
				level = arg_6_2["" .. var_6_1 * 10 + var_6_8].level,
				needItem = arg_6_2["" .. var_6_1 * 10 + var_6_8].item_id,
				needNum = arg_6_2["" .. var_6_1 * 10 + var_6_8].item_num,
				refBuff = arg_6_2["" .. var_6_1 * 10 + var_6_8].buff,
				returnItem = arg_6_2["" .. var_6_1 * 10 + var_6_8].return_item_id,
				returnNum = arg_6_2["" .. var_6_1 * 10 + var_6_8].return_item_num
			}
			var_6_8 = var_6_8 + 1
		end

		var_6_2.courses = var_6_7
		var_6_0[var_6_1] = var_6_2
	end

	return var_6_0
end

function var_0_0.convertListToTree(arg_7_0, arg_7_1)
	local var_7_0 = {}
	local var_7_1 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		local var_7_2 = math.floor(iter_7_1.courseId / 10)

		var_7_0[var_7_2] = var_7_0[var_7_2] or {
			leafs = {},
			contrast = var_7_2
		}

		if iter_7_1.isRoot then
			var_7_0[var_7_2].root = iter_7_1
		else
			var_7_0[var_7_2].leafs[iter_7_1.courseId % 10] = iter_7_1
		end
	end

	for iter_7_2, iter_7_3 in pairs(var_7_0) do
		var_7_1[#var_7_1 + 1] = iter_7_3
	end

	table.sort(var_7_1, function(arg_8_0, arg_8_1)
		return arg_8_0.contrast < arg_8_1.contrast
	end)

	return var_7_1
end

function var_0_0:getCourseDatasByType(arg_9_1, arg_9_2)
	if arg_9_1 == var_0_0.COURSE_TYPE.BASE then
		return arg_9_2 and self:convertListToTree(self.basicCourseDatas) or self.basicCourseDatas
	elseif arg_9_1 == var_0_0.COURSE_TYPE.DRAK_MATTER then
		return arg_9_2 and self:convertListToTree(self.darkMatterCourseDatas) or self.darkMatterCourseDatas
	elseif arg_9_1 == var_0_0.COURSE_TYPE.LIGHT_ENERGY then
		return arg_9_2 and self:convertListToTree(self.lightEnergyCourseDatas) or self.lightEnergyCourseDatas
	elseif arg_9_1 == var_0_0.COURSE_TYPE.ELECTROMAGNETISM then
		return arg_9_2 and self:convertListToTree(self.electromagnetismCourseDatas) or self.electromagnetismCourseDatas
	elseif arg_9_1 == var_0_0.COURSE_TYPE.QUANTUM then
		return arg_9_2 and self:convertListToTree(self.quantumCourseDatas) or self.quantumCourseDatas
	elseif arg_9_1 == var_0_0.COURSE_TYPE.THERMAL_ENERGY then
		return arg_9_2 and self:convertListToTree(self.thermalEnergyCourseDatas) or self.thermalEnergyCourseDatas
	elseif arg_9_1 == var_0_0.COURSE_TYPE.DEVIL then
		return arg_9_2 and self:convertListToTree(self.devilCourseDatas) or self.devilCourseDatas
	elseif arg_9_1 == var_0_0.COURSE_TYPE.IMAGINARY then
		return arg_9_2 and self:convertListToTree(self.imaginaryCourseDatas) or self.imaginaryCourseDatas
	elseif arg_9_1 == var_0_0.COURSE_TYPE.MIMICRY then
		return arg_9_2 and self:convertListToTree(self.mimicryCourseDatas) or self.mimicryCourseDatas
	elseif arg_9_1 == var_0_0.COURSE_TYPE.POSITIVE then
		return arg_9_2 and self:convertListToTree(self.positiveCourseDatas) or self.positiveCourseDatas
	elseif arg_9_1 == var_0_0.COURSE_TYPE.ZEROSUPPERESSION then
		return arg_9_2 and self:convertListToTree(self.otherCourseDatas) or self.otherCourseDatas
	end

	return {}
end

function var_0_0:canUnlockCourse(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1.conditions) do
		if not self:queryConditionComplete(iter_10_1) then
			return false
		end
	end

	if self:hadLeafCourseLevelUp(arg_10_1) then
		return false
	end

	return true
end

function var_0_0:hadLeafCourseLevelUp(arg_11_1)
	if arg_11_1.isRoot then
		return false
	end

	local var_11_0 = arg_11_1.courseId - arg_11_1.courseId % 10
	local var_11_1 = self:getCourseDatasByType(arg_11_1.courseType)

	while var_11_1[var_11_0 + 1] do
		if var_11_0 + 1 ~= arg_11_1.courseId and var_11_1[var_11_0 + 1].courseLevel > 0 then
			return true
		end
	end

	return false
end

function var_0_0:getDependentRootCourse(arg_12_1)
	if arg_12_1.isRoot then
		return nil
	end

	return (self:getCourseDataById(arg_12_1.courseId - arg_12_1.courseId % 10))
end

function var_0_0:queryConditionComplete(arg_13_1)
	if arg_13_1.type == var_0_0.UNLOCK_TYPE.SPECIFIED_COURSE_LEVEL then
		return self:getCourseDataById(arg_13_1.conf).courseLevel >= arg_13_1.num
	elseif arg_13_1.type == var_0_0.UNLOCK_TYPE.OWN_SOUL_GIRL_NUM then
		return playermodel:getHavedServantNum() >= arg_13_1.num
	elseif arg_13_1.type == var_0_0.UNLOCK_TYPE.OWN_SPECIFIED_SOUL_GIRL then
		return playermodel:getSpecifiedAttributeServantNum(ATTR_ID[arg_13_1.conf] or "null") >= arg_13_1.num
	elseif arg_13_1.type == var_0_0.UNLOCK_TYPE.PLAYER_LEVEL then
		return playermodel.grade > arg_13_1.num
	end

	return true
end

function var_0_0:transformConditionToString(arg_14_1)
	local var_14_0 = self:queryConditionComplete(arg_14_1) and cc.c3b(0, 243, 173) or cc.c3b(255, 0, 0)

	if arg_14_1.type == var_0_0.UNLOCK_TYPE.SPECIFIED_COURSE_LEVEL then
		local var_14_1 = self:getCourseDataById(arg_14_1.conf)

		return {
			{
				str = string.format(L_COURSEMGR[1], var_14_1.courseName, arg_14_1.num)
			},
			{
				str = "" .. var_14_1.courseLevel,
				color = var_14_0
			},
			{
				str = "/"
			},
			{
				str = "" .. arg_14_1.num,
				color = cc.c3b(0, 243, 173)
			},
			{
				str = ")"
			}
		}
	elseif arg_14_1.type == var_0_0.UNLOCK_TYPE.OWN_SOUL_GIRL_NUM then
		return {
			{
				str = string.format(L_COURSEMGR[2], arg_14_1.num)
			},
			{
				str = "" .. playermodel:getHavedServantNum(),
				color = var_14_0
			},
			{
				str = "/"
			},
			{
				str = "" .. arg_14_1.num,
				color = cc.c3b(0, 243, 173)
			},
			{
				str = ")"
			}
		}
	elseif arg_14_1.type == var_0_0.UNLOCK_TYPE.OWN_SPECIFIED_SOUL_GIRL then
		local var_14_2 = ATTR_ID[arg_14_1.conf] or "null"

		return {
			{
				str = string.format(L_COURSEMGR[3], arg_14_1.num, var_0_27[var_14_2])
			},
			{
				str = "" .. playermodel:getSpecifiedAttributeServantNum(var_14_2),
				color = var_14_0
			},
			{
				str = "/"
			},
			{
				str = "" .. arg_14_1.num,
				color = cc.c3b(0, 243, 173)
			},
			{
				str = ")"
			}
		}
	elseif arg_14_1.type == var_0_0.UNLOCK_TYPE.PLAYER_LEVEL then
		return {
			{
				str = string.format(L_COURSEMGR[4], arg_14_1.num)
			},
			{
				str = "" .. playermodel.grade,
				color = var_14_0
			},
			{
				str = "/"
			},
			{
				str = "" .. arg_14_1.num,
				color = cc.c3b(0, 243, 173)
			},
			{
				str = ")"
			}
		}
	end

	return {}
end

function var_0_0:getCourseDataById(arg_15_1)
	return self:getCourseDatasByType(math.floor(arg_15_1 / 100000), false)[arg_15_1] or {}
end

function var_0_0:updateCourseDatas(arg_16_1, arg_16_2)
	local var_16_0 = self:getCourseDatasByType(arg_16_2, false)

	self:resetCourseDatas(var_16_0)

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		if var_16_0[iter_16_1.id] then
			var_16_0[iter_16_1.id].courseLevel = iter_16_1.lv
		else
			print("unkonwn course id", iter_16_1.id)
		end
	end

	self:updateCourseDataStatus(var_16_0)
end

function var_0_0.resetCourseDatas(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in pairs(arg_17_1) do
		iter_17_1.unlock = false
		iter_17_1.courseLevel = 0
	end
end

function var_0_0:updateCourseDataStatus(arg_18_1)
	for iter_18_0, iter_18_1 in pairs(arg_18_1) do
		iter_18_1.unlock = not not self:canUnlockCourse(iter_18_1)
	end
end

function var_0_0:getResetCost(arg_19_1)
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in pairs((self:getCourseDatasByType(arg_19_1, false))) do
		if iter_19_1.unlock and iter_19_1.courseLevel > 0 then
			var_19_0 = var_19_0 + iter_19_1.diamond or 0
		end
	end

	return math.min(var_19_0, 100)
end

function var_0_0.getBuffInfo(arg_20_0, arg_20_1)
	return buff_data[arg_20_1] or {}
end

function var_0_0:getEffectiveBuffs(arg_21_1)
	local var_21_0 = {}

	self:queryEffectiveBuffs(self.basicCourseDatas, var_21_0)
	self:queryEffectiveBuffs(self:getCourseDatasByType(var_0_28[global_get_model_attr(arg_21_1)]), var_21_0)
	print(dump(var_21_0))

	return var_21_0
end

function var_0_0.queryEffectiveBuffs(arg_22_0, arg_22_1, arg_22_2)
	for iter_22_0, iter_22_1 in pairs(arg_22_1) do
		if iter_22_1.unlock and iter_22_1.courseLevel > 0 then
			for iter_22_2, iter_22_3 in ipairs(iter_22_1.courses) do
				if iter_22_3.level == iter_22_1.courseLevel then
					arg_22_2[#arg_22_2 + 1] = iter_22_3.refBuff
				end
			end
		end
	end
end

function var_0_0:getEffectBuffType(arg_23_1)
	local var_23_0 = require("data.servant_data")[arg_23_1].modelid
	local var_23_1 = {}
	local var_23_2 = {}

	self:queryEffectiveBuffs(self.basicCourseDatas, var_23_2)

	if #var_23_2 > 0 then
		var_23_1[#var_23_1 + 1] = "basic"
	end

	local var_23_3

	if not var_23_0 then
		do return var_23_1 end

		var_23_3 = {}
	end

	self:queryEffectiveBuffs(self:getCourseDatasByType(var_0_28[global_get_model_attr(var_23_0)]), var_23_3)

	if #var_23_3 > 0 then
		var_23_1[#var_23_1 + 1] = "element"
	end

	return var_23_1
end

return var_0_0
