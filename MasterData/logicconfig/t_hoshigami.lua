-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hoshigami.lua

module("logicconfig.config.t_hoshigami", package.seeall)

local title = {
	mainPropPlan = 5,
	name = 2,
	quality = 6,
	type = 3,
	id = 1,
	icon = 7,
	positionType = 4
}
local dataList = {
	{
		100001,
		"战神",
		1,
		1,
		1,
		1,
		"icon_xz_01"
	},
	{
		100002,
		"战神",
		1,
		2,
		1,
		1,
		"icon_xz_01"
	},
	{
		100003,
		"战神",
		1,
		3,
		1,
		1,
		"icon_xz_01"
	},
	{
		100004,
		"战神",
		1,
		4,
		1,
		1,
		"icon_xz_01"
	},
	{
		100005,
		"战神",
		1,
		5,
		1,
		1,
		"icon_xz_01"
	},
	{
		100006,
		"战神",
		1,
		6,
		1,
		1,
		"icon_xz_01"
	},
	{
		100007,
		"无敌",
		2,
		1,
		2,
		2,
		"icon_hudun"
	},
	{
		100008,
		"无敌",
		2,
		2,
		2,
		2,
		"icon_hudun"
	},
	{
		100009,
		"无敌",
		2,
		3,
		2,
		2,
		"icon_hudun"
	},
	{
		100010,
		"无敌",
		2,
		4,
		2,
		2,
		"icon_hudun"
	},
	{
		100011,
		"无敌",
		2,
		5,
		2,
		2,
		"icon_hudun"
	},
	{
		100012,
		"无敌",
		2,
		6,
		2,
		2,
		"icon_hudun"
	}
}
local t_hoshigami = {
	[100001] = dataList[1],
	[100002] = dataList[2],
	[100003] = dataList[3],
	[100004] = dataList[4],
	[100005] = dataList[5],
	[100006] = dataList[6],
	[100007] = dataList[7],
	[100008] = dataList[8],
	[100009] = dataList[9],
	[100010] = dataList[10],
	[100011] = dataList[11],
	[100012] = dataList[12]
}

t_hoshigami.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_hoshigami
