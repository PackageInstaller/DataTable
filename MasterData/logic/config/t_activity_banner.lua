-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_activity_banner.lua

module("logic.config.t_activity_banner", package.seeall)

local title = {
	jumpId = 7,
	priority = 2,
	level = 8,
	config = 6,
	Image = 9,
	logic = 5,
	endTime = 4,
	bannerId = 1,
	startTime = 3
}
local dataList = {
	{
		10000,
		0,
		"",
		"",
		0,
		0,
		"",
		0,
		"main_banner_wxh"
	},
	{
		10001,
		30,
		"",
		"",
		2,
		1,
		"10900002",
		999,
		"main_banner_qrqd"
	},
	{
		10002,
		20,
		"2023-01-01-05",
		"2023-03-01-05",
		1,
		1001,
		"22000000",
		0,
		"main_banner_smrjs"
	},
	{
		10003,
		45,
		"",
		"",
		10,
		100001,
		"80100001",
		0,
		"main_banner_hx"
	},
	{
		10004,
		50,
		"",
		"",
		11,
		110001,
		"80110001",
		0,
		"main_banner_zmbj"
	},
	{
		10005,
		60,
		"",
		"",
		1,
		1002,
		"40011002",
		0,
		"main_banner_edps"
	},
	{
		10006,
		80,
		"",
		"",
		1,
		1003,
		"40011003",
		0,
		"main_banner_kln"
	},
	{
		10007,
		70,
		"",
		"",
		12,
		120001,
		"80120001",
		0,
		"main_banner_yntz"
	},
	{
		10008,
		75,
		"2023-05-26-05",
		"2023-06-09-05",
		0,
		0,
		"11301001",
		0,
		"main_banner_kqgf"
	}
}
local t_activity_banner = {}

t_activity_banner.dataList = dataList

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
	t_activity_banner[v[1]] = v

	setmetatable(v, mt)
end

return t_activity_banner
