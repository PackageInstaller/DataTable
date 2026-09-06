-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_game_percent.lua

module("logicconfig.config.t_season_mode_pve_game_percent", package.seeall)

local title = {
	param = 3,
	percent = 4,
	seasonId = 1,
	type = 2,
	limit = 5
}
local dataList = {
	{
		1,
		1,
		1,
		0.0156,
		1.9344
	},
	{
		1,
		1,
		2,
		0.0311,
		4.6339
	},
	{
		1,
		1,
		3,
		0.0467,
		8.2659
	},
	{
		1,
		1,
		4,
		0.0622,
		7.8994
	},
	{
		1,
		1,
		5,
		0.0778,
		15.171
	},
	{
		1,
		1,
		6,
		0.0933,
		18.1002
	},
	{
		1,
		2,
		4,
		5,
		5
	},
	{
		1,
		2,
		5,
		5,
		5
	},
	{
		1,
		2,
		6,
		5,
		5
	},
	{
		1,
		2,
		7,
		10,
		10
	},
	{
		1,
		3,
		1,
		1,
		10
	},
	{
		1,
		4,
		1,
		1,
		10
	},
	{
		2,
		1,
		1,
		0.0044,
		4.4024
	},
	{
		2,
		1,
		2,
		0.0088,
		5.0324
	},
	{
		2,
		1,
		3,
		0.0132,
		9.0948
	},
	{
		2,
		1,
		4,
		0.0176,
		10.032
	},
	{
		2,
		1,
		5,
		0.022,
		14.344
	},
	{
		2,
		1,
		6,
		0.0263,
		18.0944
	},
	{
		2,
		2,
		6,
		5,
		5
	},
	{
		2,
		2,
		7,
		5,
		5
	},
	{
		2,
		2,
		8,
		10,
		10
	},
	{
		2,
		3,
		1,
		1,
		10
	},
	{
		2,
		4,
		1,
		1,
		9
	},
	{
		3,
		1,
		1,
		0.0108290431386473,
		2.18746671400675
	},
	{
		3,
		1,
		2,
		0.0216580862772945,
		4.39659151429079
	},
	{
		3,
		1,
		3,
		0.0324871294159418,
		6.9197585655956
	},
	{
		3,
		1,
		4,
		0.043316172554589,
		6.93058760873424
	},
	{
		3,
		1,
		5,
		0.0541452156932363,
		13.2114326291497
	},
	{
		3,
		1,
		6,
		0.0649742588318835,
		27.354162968223
	},
	{
		3,
		2,
		3,
		5,
		5
	},
	{
		3,
		2,
		4,
		5,
		5
	},
	{
		3,
		2,
		5,
		10,
		10
	},
	{
		3,
		3,
		1,
		1,
		10
	},
	{
		3,
		4,
		1,
		1,
		9
	}
}
local t_season_mode_pve_game_percent = {
	{
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5],
			dataList[6]
		},
		{
			[4] = dataList[7],
			[5] = dataList[8],
			[6] = dataList[9],
			[7] = dataList[10]
		},
		{
			dataList[11]
		},
		{
			dataList[12]
		}
	},
	{
		{
			dataList[13],
			dataList[14],
			dataList[15],
			dataList[16],
			dataList[17],
			dataList[18]
		},
		{
			[6] = dataList[19],
			[7] = dataList[20],
			[8] = dataList[21]
		},
		{
			dataList[22]
		},
		{
			dataList[23]
		}
	},
	{
		{
			dataList[24],
			dataList[25],
			dataList[26],
			dataList[27],
			dataList[28],
			dataList[29]
		},
		{
			[3] = dataList[30],
			[4] = dataList[31],
			[5] = dataList[32]
		},
		{
			dataList[33]
		},
		{
			dataList[34]
		}
	}
}

t_season_mode_pve_game_percent.dataList = dataList

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

return t_season_mode_pve_game_percent
