-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_upcoming_unlock.lua

module("logicconfig.config.t_upcoming_unlock", package.seeall)

local title = {
	id = 2,
	cost = 3,
	activityId = 1
}
local dataList = {
	{
		181009,
		1,
		"10:181009:100"
	},
	{
		181009,
		2,
		"10:181009:100"
	},
	{
		181009,
		3,
		"10:181009:100"
	},
	{
		181009,
		4,
		"10:181009:100"
	},
	{
		181009,
		5,
		"10:181009:100"
	},
	{
		181009,
		6,
		"10:181009:100"
	},
	{
		181012,
		1,
		"10:181012:100"
	},
	{
		181012,
		2,
		"10:181012:100"
	},
	{
		181012,
		3,
		"10:181012:100"
	},
	{
		181012,
		4,
		"10:181012:100"
	},
	{
		181012,
		5,
		"10:181012:100"
	},
	{
		181012,
		6,
		"10:181012:100"
	}
}
local t_upcoming_unlock = {
	[181009] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[181012] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_upcoming_unlock.dataList = dataList

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

return t_upcoming_unlock
