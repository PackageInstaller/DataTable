-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_hold_report_desc.lua

module("logic.config.t_house_hold_report_desc", package.seeall)

local title = {
	code = 2,
	result = 4,
	id = 1,
	touch = 3,
	weight = 5,
	desc = 6
}
local dataList = {
	{
		1,
		101,
		0,
		0,
		10,
		"这是id[1] code[101] 权重[10]的描述"
	},
	{
		2,
		101,
		0,
		0,
		10,
		"这是id[2] code[101] 权重[10]的描述"
	},
	{
		3,
		101,
		0,
		0,
		10,
		"这是id[3] code[101] 权重[10]的描述"
	},
	{
		4,
		101,
		0,
		0,
		10,
		"这是id[4] code[101] 权重[10]的描述"
	},
	{
		5,
		101,
		1,
		0,
		30,
		"这是id[5] code[101] 权重[30]的描述"
	},
	{
		6,
		101,
		0,
		1,
		30,
		"这是id[6] code[101] 权重[30]的描述"
	},
	{
		7,
		101,
		0,
		1,
		30,
		"这是id[7] code[101] 权重[30]的描述"
	},
	{
		8,
		101,
		0,
		1,
		30,
		"这是id[8] code[101] 权重[30]的描述"
	},
	{
		9,
		101,
		0,
		0,
		0,
		"这是id[9] code[101] 权重[10]的描述"
	},
	{
		10,
		101,
		0,
		0,
		0,
		"这是id[10] code[101] 权重[10]的描述"
	},
	{
		11,
		101,
		0,
		0,
		0,
		"这是id[11] code[101] 权重[10]的描述"
	},
	{
		12,
		101,
		0,
		0,
		0,
		"这是id[12] code[101] 权重[10]的描述"
	},
	{
		13,
		101,
		0,
		0,
		0,
		"这是id[13] code[101] 权重[10]的描述"
	},
	{
		14,
		101,
		0,
		0,
		0,
		"这是id[14] code[101] 权重[10]的描述"
	},
	{
		15,
		101,
		0,
		0,
		0,
		"这是id[15] code[101] 权重[10]的描述"
	},
	{
		16,
		101,
		0,
		5,
		10,
		"失效描述：这是id[16] code[101] 权重[10]的描述"
	},
	{
		17,
		101,
		0,
		5,
		10,
		"失效描述：这是id[17] code[101] 权重[10]的描述"
	},
	{
		18,
		101,
		0,
		5,
		10,
		"失效描述：这是id[18] code[101] 权重[10]的描述"
	},
	{
		19,
		101,
		0,
		5,
		10,
		"失效描述：这是id[19] code[101] 权重[10]的描述"
	},
	{
		20,
		101,
		0,
		5,
		10,
		"失效描述：这是id[20] code[101] 权重[10]的描述"
	}
}
local t_house_hold_report_desc = {}

t_house_hold_report_desc.dataList = dataList

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
	t_house_hold_report_desc[v[1]] = v

	setmetatable(v, mt)
end

return t_house_hold_report_desc
