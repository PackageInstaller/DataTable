-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_plot_area.lua

module("logicconfig.config.t_plot_area", package.seeall)

local title = {
	id = 1,
	chapterIds = 2
}
local dataList = {
	{
		1,
		{
			1001,
			1002,
			1003,
			1004,
			1008,
			1009,
			1010,
			1011
		}
	},
	{
		2,
		{
			1005,
			1006,
			1007
		}
	},
	{
		3,
		{
			1012,
			1013,
			1014,
			1015
		}
	},
	{
		4,
		{
			1016,
			1017,
			1018,
			1019
		}
	},
	{
		5,
		{
			1020,
			1021,
			1022,
			1023,
			1024,
			1025
		}
	},
	{
		6,
		{
			1026,
			1027,
			1028,
			1029,
			1030
		}
	}
}
local t_plot_area = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_plot_area.dataList = dataList

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

return t_plot_area
