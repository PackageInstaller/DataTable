-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_main_interact_element.lua

module("logic.config.t_main_interact_element", package.seeall)

local title = {
	resAct = 8,
	name = 3,
	animPrefixAct = 9,
	dynPath = 7,
	typeAct = 11,
	interactPoint = 2,
	path = 5,
	animPrefix = 4,
	weightAct = 10,
	id = 1,
	weight = 6,
	planIdAct = 12
}
local dataList = {
	{
		101,
		1,
		"秋千",
		"qiuqian",
		"obj_swing",
		0,
		"",
		"",
		"",
		0,
		0,
		0
	},
	{
		102,
		1,
		"红绿灯",
		"honglvdeng",
		"obj_trafficlight",
		0,
		"",
		"",
		"",
		0,
		0,
		0
	},
	{
		201,
		2,
		"画板",
		"huaban",
		"obj_easel",
		0,
		"",
		"",
		"",
		0,
		0,
		0
	},
	{
		202,
		2,
		"沙丘城堡",
		"chengbao",
		"obj_sandcastle_p",
		0,
		"",
		"",
		"",
		0,
		0,
		0
	},
	{
		203,
		2,
		"烟花",
		"yanhua",
		"s001_effect_yanhua_character",
		0,
		"",
		"",
		"",
		0,
		0,
		0
	},
	{
		204,
		2,
		"沙滩椅",
		"shatanyi",
		"obj_bed",
		0,
		"",
		"",
		"",
		0,
		0,
		0
	},
	{
		301,
		3,
		"钢琴",
		"gangqin",
		"obj_piano",
		0,
		"",
		"",
		"",
		0,
		0,
		0
	},
	{
		302,
		3,
		"破旧车子",
		"che",
		"obj_car",
		0,
		"",
		"",
		"",
		0,
		0,
		0
	},
	{
		10001,
		0,
		"沙发",
		"shafa",
		"obj_sofa",
		0,
		"",
		"",
		"",
		0,
		0,
		0
	},
	{
		10002,
		0,
		"贩卖机",
		"shafa",
		"obj_vendingmachine",
		0,
		"",
		"",
		"",
		0,
		0,
		0
	},
	{
		10003,
		0,
		"加油机",
		"shafa",
		"obj_oiltank",
		0,
		"",
		"",
		"",
		0,
		0,
		0
	},
	{
		10004,
		0,
		"邮箱",
		"shafa",
		"obj_postbox",
		0,
		"",
		"",
		"",
		0,
		0,
		0
	},
	{
		10005,
		0,
		"加油桶",
		"shafa",
		"obj_oilbarrel",
		0,
		"",
		"",
		"",
		0,
		0,
		0
	},
	{
		10006,
		0,
		"吧台椅",
		"shafa",
		"obj_barchair",
		0,
		"",
		"",
		"",
		0,
		0,
		0
	},
	{
		10007,
		0,
		"靠背高脚椅",
		"shafa",
		"obj_highchair",
		0,
		"",
		"",
		"",
		0,
		0,
		0
	},
	{
		15000,
		0,
		"无座椅",
		"shafa",
		"obj_zuoyi",
		0,
		"",
		"",
		"",
		0,
		0,
		0
	},
	{
		20001,
		0,
		"(动)沙发",
		"shafa",
		"obj_zuoyi",
		0,
		"s001_obj_zuoyi_a",
		"",
		"",
		0,
		0,
		0
	},
	{
		20002,
		0,
		"(动)木箱",
		"shafa",
		"obj_zuoyi",
		0,
		"s001_obj_woodbox_tmp",
		"",
		"",
		0,
		0,
		0
	},
	{
		20003,
		0,
		"(动)油桶",
		"shafa",
		"obj_zuoyi",
		0,
		"s001_obj_tong_tmp",
		"",
		"",
		0,
		0,
		0
	},
	{
		30001,
		-1,
		"密室时钟",
		"",
		"obj_clock",
		0,
		"",
		"",
		"",
		0,
		0,
		0
	},
	{
		30002,
		-1,
		"电视机",
		"",
		"obj_television",
		0,
		"",
		"",
		"",
		0,
		0,
		0
	}
}
local t_main_interact_element = {}

t_main_interact_element.dataList = dataList

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
	t_main_interact_element[v[1]] = v

	setmetatable(v, mt)
end

return t_main_interact_element
