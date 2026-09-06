-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fire_power_contest_progress.lua

module("logicconfig.config.t_fire_power_contest_progress", package.seeall)

local title = {
	scoreRange = 2,
	id = 1,
	progress = 3
}
local dataList = {
	{
		1,
		{
			0,
			200
		},
		120
	},
	{
		2,
		{
			201,
			400
		},
		240
	},
	{
		3,
		{
			401,
			700
		},
		360
	},
	{
		4,
		{
			701,
			9999
		},
		480
	}
}
local t_fire_power_contest_progress = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_fire_power_contest_progress.dataList = dataList

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

return t_fire_power_contest_progress
