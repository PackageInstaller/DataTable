-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_beast_rich_man_boss_grid.lua

module("logicconfig.config.t_beast_rich_man_boss_grid", package.seeall)

local title = {
	beastType = 3,
	skinId = 7,
	zoneId = 2,
	uniqueId = 5,
	bossImgName = 6,
	beastId = 4,
	activityId = 1,
	posAndSize = 8
}
local dataList = {
	{
		558001,
		1,
		2,
		1,
		96,
		"board_ruishoudamaoxian_boss01",
		"1803101",
		{
			-360,
			-100,
			1
		}
	},
	{
		558001,
		1,
		1,
		2,
		104,
		"board_ruishoudamaoxian_boss02",
		"1604503",
		{
			-280,
			-410,
			0.8
		}
	},
	{
		558001,
		1,
		1,
		1,
		302,
		"board_ruishoudamaoxian_boss03",
		"1602802",
		{
			-225,
			-480,
			0.8
		}
	},
	{
		558001,
		2,
		1,
		3,
		132,
		"board_ruishoudamaoxian_boss04",
		"1302803",
		{
			-285,
			-600,
			1
		}
	},
	{
		558001,
		2,
		2,
		2,
		302,
		"board_ruishoudamaoxian_boss05",
		"1202105",
		{
			-360,
			-100,
			1
		}
	},
	{
		558001,
		3,
		2,
		3,
		85,
		"board_ruishoudamaoxian_boss07",
		"1204503",
		{
			-360,
			-100,
			1
		}
	},
	{
		558001,
		3,
		1,
		4,
		293,
		"board_ruishoudamaoxian_boss06",
		"1204402",
		{
			-300,
			-630,
			1
		}
	}
}
local t_beast_rich_man_boss_grid = {
	[558001] = {
		{
			[2] = {
				dataList[1]
			},
			{
				[2] = dataList[2],
				dataList[3]
			}
		},
		{
			{
				[3] = dataList[4]
			},
			{
				[2] = dataList[5]
			}
		},
		{
			[2] = {
				[3] = dataList[6]
			},
			{
				[4] = dataList[7]
			}
		}
	}
}

t_beast_rich_man_boss_grid.dataList = dataList

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

return t_beast_rich_man_boss_grid
