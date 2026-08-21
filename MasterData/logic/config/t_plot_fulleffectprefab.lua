-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_plot_fulleffectprefab.lua

module("logic.config.t_plot_fulleffectprefab", package.seeall)

local title = {
	shake = 5,
	name = 2,
	particleID = 3,
	audioName = 4,
	code = 1
}
local dataList = {
	{
		1002,
		"睁眼",
		10023,
		"",
		10001
	},
	{
		1003,
		"闭眼",
		10024,
		"",
		10001
	},
	{
		1004,
		"紧迫",
		10025,
		"",
		10003
	},
	{
		1005,
		"血迹",
		10031,
		"",
		0
	},
	{
		1006,
		"理智丧失",
		10032,
		"",
		0
	},
	{
		1007,
		"理智丧失恶化",
		10033,
		"",
		0
	},
	{
		1008,
		"黑雾",
		10034,
		"",
		0
	},
	{
		1009,
		"雨",
		10035,
		"",
		0
	},
	{
		1010,
		"雪",
		10036,
		"",
		0
	},
	{
		1011,
		"警告",
		10037,
		"",
		0
	},
	{
		1012,
		"噪点掩盖",
		10038,
		"",
		0
	}
}
local t_plot_fulleffectprefab = {}

t_plot_fulleffectprefab.dataList = dataList

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
	t_plot_fulleffectprefab[v[1]] = v

	setmetatable(v, mt)
end

return t_plot_fulleffectprefab
