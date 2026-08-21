-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_result_code.lua

module("logic.config.t_result_code", package.seeall)

local title = {
	contentjp = 5,
	key = 1,
	contentkr = 7,
	contenten = 6,
	contentth = 8,
	contenttw = 4,
	workType = 2,
	contentzh = 3
}
local dataList = {
	{
		"0",
		1,
		"成功",
		"",
		"",
		"Success",
		"",
		""
	},
	{
		"-1",
		1,
		"服务器错误",
		"",
		"",
		"",
		"",
		""
	},
	{
		"-2",
		1,
		"服务器异常，请重试",
		"",
		"",
		"",
		"",
		""
	},
	{
		"-3",
		1,
		"非法的管理员账号",
		"",
		"",
		"",
		"",
		""
	},
	{
		"-4",
		1,
		"用户挂起超时",
		"",
		"",
		"",
		"",
		""
	},
	{
		"-5",
		1,
		"您的账号在其他地方登陆",
		"",
		"",
		"",
		"",
		""
	},
	{
		"-6",
		1,
		"服务器维护",
		"",
		"",
		"",
		"",
		""
	},
	{
		"1",
		1,
		"非法操作",
		"",
		"",
		"",
		"",
		""
	},
	{
		"2",
		1,
		"非法参数",
		"",
		"",
		"",
		"",
		""
	},
	{
		"3",
		1,
		"用户不存在",
		"",
		"",
		"",
		"",
		""
	},
	{
		"4",
		1,
		"物品不存在",
		"",
		"",
		"",
		"",
		""
	},
	{
		"5",
		1,
		"物品未定义",
		"",
		"",
		"",
		"",
		""
	},
	{
		"6",
		1,
		"非法文本",
		"",
		"",
		"",
		"",
		""
	},
	{
		"101",
		1,
		"物品不足",
		"",
		"",
		"",
		"",
		""
	},
	{
		"102",
		1,
		"没有该物品对应的背包类型",
		"",
		"",
		"",
		"",
		""
	},
	{
		"103",
		1,
		"等级不足",
		"",
		"",
		"",
		"",
		""
	},
	{
		"104",
		1,
		"该物品不能使用",
		"",
		"",
		"",
		"",
		""
	},
	{
		"105",
		1,
		"配置参数错误",
		"",
		"",
		"",
		"",
		""
	},
	{
		"106",
		1,
		"次数不足",
		"",
		"",
		"",
		"",
		""
	},
	{
		"107",
		1,
		"角色不存在",
		"",
		"",
		"",
		"",
		""
	},
	{
		"108",
		1,
		"配置不存在",
		"",
		"",
		"",
		"",
		""
	},
	{
		"109",
		1,
		"不是好感度物品",
		"",
		"",
		"",
		"",
		""
	},
	{
		"110",
		1,
		"好感度等级不足",
		"",
		"",
		"",
		"",
		""
	},
	{
		"111",
		1,
		"已达到最大等级",
		"",
		"",
		"",
		"",
		""
	},
	{
		"112",
		1,
		"功能未解锁",
		"",
		"",
		"",
		"",
		""
	},
	{
		"113",
		1,
		"已激活",
		"",
		"",
		"",
		"",
		""
	},
	{
		"114",
		1,
		"角色等级不足",
		"",
		"",
		"",
		"",
		""
	},
	{
		"115",
		1,
		"角色好感度等级不足",
		"",
		"",
		"",
		"",
		""
	},
	{
		"116",
		1,
		"角色权限等级不足",
		"",
		"",
		"",
		"",
		""
	},
	{
		"117",
		1,
		"已购买",
		"",
		"",
		"",
		"",
		""
	}
}
local t_result_code = {
	["0"] = dataList[1],
	["-1"] = dataList[2],
	["-2"] = dataList[3],
	["-3"] = dataList[4],
	["-4"] = dataList[5],
	["-5"] = dataList[6],
	["-6"] = dataList[7],
	["1"] = dataList[8],
	["2"] = dataList[9],
	["3"] = dataList[10],
	["4"] = dataList[11],
	["5"] = dataList[12],
	["6"] = dataList[13],
	["101"] = dataList[14],
	["102"] = dataList[15],
	["103"] = dataList[16],
	["104"] = dataList[17],
	["105"] = dataList[18],
	["106"] = dataList[19],
	["107"] = dataList[20],
	["108"] = dataList[21],
	["109"] = dataList[22],
	["110"] = dataList[23],
	["111"] = dataList[24],
	["112"] = dataList[25],
	["113"] = dataList[26],
	["114"] = dataList[27],
	["115"] = dataList[28],
	["116"] = dataList[29],
	["117"] = dataList[30]
}

t_result_code.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_result_code
