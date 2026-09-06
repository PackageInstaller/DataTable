-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_unique_world_box_event.lua

module("logicconfig.config.t_unique_world_box_event", package.seeall)

local title = {
	effects = 2,
	eventId = 1,
	prize = 3
}
local dataList = {
	{
		1001,
		"addItem$1#10",
		""
	},
	{
		1002,
		"addItem$2#1",
		""
	},
	{
		1003,
		"addItem$3#1",
		""
	},
	{
		1004,
		"addItem$4#1",
		""
	},
	{
		1005,
		"addItem$5#1",
		""
	},
	{
		1006,
		"addItem$6#1",
		""
	},
	{
		1007,
		"addItem$6#1",
		""
	},
	{
		1008,
		"addItem$6#1",
		""
	},
	{
		1009,
		"addItem$6#1",
		""
	},
	{
		1010,
		"addItem$6#1",
		""
	},
	{
		1011,
		"",
		"10:583020:200"
	},
	{
		1012,
		"",
		"10:583008:10"
	},
	{
		1013,
		"",
		"10:583009:10"
	},
	{
		1014,
		"",
		"10:583010:10"
	},
	{
		1015,
		"",
		"10:583011:10"
	}
}
local t_unique_world_box_event = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7],
	[1008] = dataList[8],
	[1009] = dataList[9],
	[1010] = dataList[10],
	[1011] = dataList[11],
	[1012] = dataList[12],
	[1013] = dataList[13],
	[1014] = dataList[14],
	[1015] = dataList[15]
}

t_unique_world_box_event.dataList = dataList

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

return t_unique_world_box_event
