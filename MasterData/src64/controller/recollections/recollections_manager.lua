local RecollectionsManager = class("RecollectionsManager", (require("controller.base_manager")))

RecollectionsManager.MULTITON_MSG = "RecollectionsManager instancealready constructed!"
RecollectionsManager.WATCH_HISTORY = "Recollections_Watch_History_Valentine_Day"
RecollectionsManager.OPEN_LAYER_TYPE = {
	RECOLLECTIONS = 0,
	RECOLLECTIONS_SHARE = 1
}

local major_factor_data = require("data.major_factor_data")
local servant_data = require("data.servant_data")
local var_0_3 = 260

function RecollectionsManager:ctor()
	RecollectionsManager.super.ctor(self)

	self._data = {}
	self._openLayerType = RecollectionsManager.OPEN_LAYER_TYPE.RECOLLECTIONS
end

function RecollectionsManager:requestInfo(arg_2_1)
	require("network.network"):rpc("get_activity_memory_data", {
		activityid = var_0_3
	}, function(arg_3_0)
		self:handlerInfo(arg_3_0)

		if arg_2_1 then
			arg_2_1(arg_3_0)
		end
	end)
end

function RecollectionsManager:requestOpenLayer()
	self._openLayerType = RoleDefault:getInstance():getBoolForKey(RecollectionsManager.WATCH_HISTORY, false) and RecollectionsManager.OPEN_LAYER_TYPE.RECOLLECTIONS_SHARE or RecollectionsManager.OPEN_LAYER_TYPE.RECOLLECTIONS

	self:requestInfo()
end

function RecollectionsManager:setDataShare(arg_5_1)
	self._data.share = arg_5_1
end

function RecollectionsManager:handlerInfo(arg_6_1)
	self._data = arg_6_1
	self._data.data = json.decode(self._data.data)

	if self._openLayerType == RecollectionsManager.OPEN_LAYER_TYPE.RECOLLECTIONS_SHARE then
		LayerManager:pushInLayer("RecollectionsSweepstakeLayer")
	elseif self._openLayerType == RecollectionsManager.OPEN_LAYER_TYPE.RECOLLECTIONS then
		LayerManager:pushInLayer("RecollectionsLayer")
	end
end

function RecollectionsManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function RecollectionsManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

local function var_0_5(arg_10_0, arg_10_1)
	if arg_10_1 ~= false then
		arg_10_1 = true
	end

	local var_10_0 = "<div fontsize=24 fontcolor=#151a31 fontname='fonts/name.ttf'>" .. arg_10_0

	if arg_10_1 then
		var_10_0 = var_10_0 .. "</div>"
	end

	return var_10_0
end

local function var_0_6(arg_11_0, arg_11_1)
	if arg_11_1 ~= false then
		arg_11_1 = true
	end

	local var_11_0 = "<div fontsize=36 fontcolor=#6422fe fontname='fonts/name.ttf'>" .. arg_11_0

	if arg_11_1 then
		var_11_0 = var_11_0 .. "</div>"
	end

	return var_11_0
end

function RecollectionsManager:getEnterTips()
	return "普通的一天,电子时钟“滴滴答答”作响\n你心血来潮，想要再次检查一下这个机器\n于是接通了电源……\n机器发出了低沉的“嗡嗡”声……\n似曾相识的感觉涌上心头……"
end

function RecollectionsManager:getCardStr(arg_13_1)
	local var_13_0 = ""

	if arg_13_1 == 1 then
		var_13_0 = self:getEnterTips1()
	elseif arg_13_1 == 2 then
		var_13_0 = self:getEnterTips2()
	end

	return var_13_0
end

function RecollectionsManager:getEnterTips1()
	local var_14_3 = {}

	table.insert(var_14_3, var_0_5(""))
	table.insert(var_14_3, var_0_5(""))
	table.insert(var_14_3, var_0_5(""))
	table.insert(var_14_3, var_0_5("           阳光正好，而你的思绪也开始翩跹"))
	table.insert(var_14_3, var_0_5("               时至今日，在你的努力下"))
	table.insert(var_14_3, var_0_5("    \t\t      已有", false) .. var_0_6(self._data.data.inroom_count, false) .. var_0_5("位学员正式入住你管理的宿舍"))
	table.insert(var_14_3, var_0_5("        无论是在课堂、战斗，亦或是日常生活中"))
	table.insert(var_14_3, var_0_5("  你对每位学员的关心与包容，都给她们带来了诸多温暖"))
	table.insert(var_14_3, var_0_5(""))
	table.insert(var_14_3, var_0_5(""))
	table.insert(var_14_3, var_0_5(""))
	table.insert(var_14_3, var_0_5(""))

	if self._data.data.avg_favor_level >= 20 then
		table.insert(var_14_3, var_0_5("            拥有良好的人际关系是非常重要的"))

		local var_14_4 = ""

		for iter_14_0 = 1, 14 do
			var_14_4 = var_14_4 .. " "
		end

		table.insert(var_14_3, var_0_5(var_14_4 .. "你在学员中的平均好感度已达到"))

		local var_14_5 = ""

		for iter_14_1 = 1, 26 do
			var_14_5 = var_14_5 .. " "
		end

		table.insert(var_14_3, var_0_5(string.sub(var_14_5, 1, string.len(var_14_5) - math.ceil(string.len(self._data.data.avg_favor_level) / 1)) .. "", false) .. var_0_6(self._data.data.avg_favor_level, false) .. var_0_5(""))
		table.insert(var_14_3, var_0_5("               所有学员都对你青睐有加！"))
		table.insert(var_14_3, var_0_5("             学员们近乎是无条件的信任你"))
		table.insert(var_14_3, var_0_5("           你的一言一行都将产生未知的影响"))
	elseif self._data.data.avg_favor_level >= 10 then
		table.insert(var_14_3, var_0_5("            拥有良好的人际关系是非常重要的"))

		local var_14_6 = ""

		for iter_14_2 = 1, 14 do
			var_14_6 = var_14_6 .. " "
		end

		table.insert(var_14_3, var_0_5(var_14_6 .. "你在学员中的平均好感度已达到"))

		local var_14_7 = ""

		for iter_14_3 = 1, 26 do
			var_14_7 = var_14_7 .. " "
		end

		table.insert(var_14_3, var_0_5(string.sub(var_14_7, 1, string.len(var_14_7) - math.ceil(string.len(self._data.data.avg_favor_level) / 1)) .. "", false) .. var_0_6(self._data.data.avg_favor_level, false) .. var_0_5(""))
		table.insert(var_14_3, var_0_5("               所有学员都对你颇有好感~"))
		table.insert(var_14_3, var_0_5("              支持你、信赖你的人越来越多"))
		table.insert(var_14_3, var_0_5("                你的一言一行都备受关注"))
	else
		table.insert(var_14_3, var_0_5("            拥有良好的人际关系是非常重要的"))

		local var_14_8 = ""

		for iter_14_4 = 1, 14 do
			var_14_8 = var_14_8 .. " "
		end

		table.insert(var_14_3, var_0_5(var_14_8 .. "你在学员中的平均好感度已达到", true))

		local var_14_9 = ""

		for iter_14_5 = 1, 26 do
			var_14_9 = var_14_9 .. " "
		end

		table.insert(var_14_3, var_0_5(string.sub(var_14_9, 1, string.len(var_14_9) - math.ceil(string.len(self._data.data.avg_favor_level) / 1)) .. "", false) .. var_0_6(self._data.data.avg_favor_level, false) .. var_0_5(""))
		table.insert(var_14_3, var_0_5("               所有学员都对你有点印象。"))
		table.insert(var_14_3, var_0_5("                但也仅限于有点印象……"))
		table.insert(var_14_3, var_0_5("             你的一言一行能引起的波澜甚小"))
	end

	return (table.concat(var_14_3))
end

function RecollectionsManager:getEnterTips2()
	local var_15_2 = self._data.data.marry_total_count
	local var_15_3 = {}

	table.insert(var_15_3, var_0_5(""))
	table.insert(var_15_3, var_0_5(""))
	table.insert(var_15_3, var_0_5(""))

	if self._data.data.first_marry_time > 0 then
		table.insert(var_15_3, var_0_5("       如果记忆是块木雕，这是雕琢最精细的地方"))
		table.insert(var_15_3, var_0_5("            阳光、花香、誓言、戒指与她……"))
		table.insert(var_15_3, var_0_5("      你们约定——彼此依靠、相互扶持、共同成长"))

		local var_15_4 = ""

		for iter_15_0 = 1, 24 do
			var_15_4 = var_15_4 .. " "
		end

		table.insert(var_15_3, var_0_5(string.sub(var_15_4, 1, string.len(var_15_4) - math.ceil(string.len(major_factor_data[self._data.data.first_marry_soulid].easy_name) / 3)) .. "", false) .. var_0_6(major_factor_data[self._data.data.first_marry_soulid].easy_name, false) .. var_0_5(""))
		table.insert(var_15_3, var_0_5("                与你缔结了首个誓约"))

		local var_15_5 = ""

		for iter_15_1 = 1, 17 do
			var_15_5 = var_15_5 .. " "
		end

		local var_15_6 = math.floor((require("controller.time_check_manager"):getCurTime() - self._data.data.first_marry_time) / 86400)

		table.insert(var_15_3, var_0_5(string.sub(var_15_5, 1, string.len(var_15_5) - math.ceil(string.len(var_15_6) / 1)) .. "在", false) .. var_0_6(var_15_6, false) .. var_0_5("天的漫长旅途中"))
		table.insert(var_15_3, var_0_5("                总有一些生活的小惊喜"))
		table.insert(var_15_3, var_0_5("                 让你回响起来的时候"))
		table.insert(var_15_3, var_0_5("                  不自觉地绽放笑颜~"))
	else
		table.insert(var_15_3, var_0_5("        你的记忆里似乎没有特别印象深刻的一幕"))
		table.insert(var_15_3, var_0_5("                   每一天都很平淡"))
		table.insert(var_15_3, var_0_5("                  你最期待的那个她"))
		table.insert(var_15_3, var_0_5("             不知在何时、何处，才能遇见"))
	end

	table.insert(var_15_3, var_0_5(""))
	table.insert(var_15_3, var_0_5(""))
	table.insert(var_15_3, var_0_5(""))
	table.insert(var_15_3, var_0_5(""))

	if var_15_2 > 100 then
		table.insert(var_15_3, var_0_5("         你对此不甚上心，但似乎总是桃运连连"))

		local var_15_7 = ""

		for iter_15_2 = 1, 8 do
			var_15_7 = var_15_7 .. " "
		end

		table.insert(var_15_3, var_0_5(string.sub(var_15_7, 1, string.len(var_15_7) - math.ceil(string.len(var_15_2) / 1)) .. "截止今日，总共有", false) .. var_0_6(var_15_2, false) .. var_0_5("位学员与你缔结了誓约"))
		table.insert(var_15_3, var_0_5("                 你已是“完美”的化身"))
		table.insert(var_15_3, var_0_5("          学院大街小巷上都在传颂你的“事迹”"))
	elseif var_15_2 > 0 then
		table.insert(var_15_3, var_0_5("         你从未刻意追求，但似乎偶能寻得桃花"))

		local var_15_8 = ""

		for iter_15_3 = 1, 8 do
			var_15_8 = var_15_8 .. " "
		end

		table.insert(var_15_3, var_0_5(string.sub(var_15_8, 1, string.len(var_15_8) - math.ceil(string.len(var_15_2) / 1)) .. "截止今日，总共有", false) .. var_0_6(var_15_2, false) .. var_0_5("位学员与你缔结了誓约"))
		table.insert(var_15_3, var_0_5("       你的“事迹”也常常被人谈起，令人艳羡不已"))
	else
		table.insert(var_15_3, var_0_5("               似乎还没有学员与你熟识……"))
		table.insert(var_15_3, var_0_5("           闲暇之余，还是要与学员们多聊聊天~"))
		table.insert(var_15_3, var_0_5("      赠送学员喜欢的礼物，可以快速促进感情升温哟~"))
	end

	return (table.concat(var_15_3))
end

function RecollectionsManager:getData()
	return self._data
end

return RecollectionsManager
