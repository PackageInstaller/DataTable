-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_event_medal.lua

module("logicconfig.config.t_season_mode_pve_event_medal", package.seeall)

local title = {
	id = 2,
	medalId = 3,
	seasonId = 1
}
local dataList = {
	{
		1,
		1,
		1
	},
	{
		1,
		2,
		2
	},
	{
		1,
		3,
		3
	},
	{
		1,
		4,
		4
	},
	{
		1,
		5,
		5
	},
	{
		1,
		6,
		6
	},
	{
		1,
		7,
		7
	},
	{
		1,
		8,
		8
	},
	{
		1,
		9,
		9
	},
	{
		1,
		10,
		10
	},
	{
		2,
		1,
		1
	},
	{
		2,
		2,
		2
	},
	{
		2,
		3,
		3
	},
	{
		2,
		4,
		4
	},
	{
		2,
		5,
		5
	},
	{
		2,
		6,
		6
	},
	{
		2,
		7,
		7
	},
	{
		2,
		8,
		8
	},
	{
		2,
		9,
		9
	},
	{
		2,
		10,
		10
	},
	{
		3,
		1,
		1
	},
	{
		3,
		2,
		2
	},
	{
		3,
		3,
		3
	},
	{
		3,
		4,
		4
	},
	{
		3,
		5,
		5
	},
	{
		3,
		6,
		6
	},
	{
		3,
		7,
		7
	},
	{
		3,
		8,
		8
	},
	{
		3,
		9,
		9
	},
	{
		3,
		10,
		10
	}
}
local t_season_mode_pve_event_medal = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	},
	{
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26],
		dataList[27],
		dataList[28],
		dataList[29],
		dataList[30]
	}
}

t_season_mode_pve_event_medal.dataList = dataList

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

return t_season_mode_pve_event_medal
