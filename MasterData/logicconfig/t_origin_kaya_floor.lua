-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_kaya_floor.lua

module("logicconfig.config.t_origin_kaya_floor", package.seeall)

local title = {
	activityId = 1,
	attributeId = 5,
	floorId = 2,
	needUseSeed = 4,
	attributeNum = 6,
	prize = 3
}
local dataList = {
	{
		548001,
		1,
		"4:510682:20",
		{
			1,
			2
		},
		{
			1
		},
		{
			2
		}
	},
	{
		548001,
		2,
		"4:510682:30",
		{
			1,
			2,
			3,
			4
		},
		{
			1,
			2,
			3
		},
		{
			2,
			1,
			1
		}
	},
	{
		548001,
		3,
		"4:510682:50",
		{
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8
		},
		{
			1,
			2,
			3
		},
		{
			4,
			2,
			2
		}
	}
}
local t_origin_kaya_floor = {
	[548001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_origin_kaya_floor.dataList = dataList

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

return t_origin_kaya_floor
