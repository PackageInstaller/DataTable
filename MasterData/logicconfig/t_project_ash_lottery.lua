-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_project_ash_lottery.lua

module("logicconfig.config.t_project_ash_lottery", package.seeall)

local title = {
	prize = 3,
	id = 2,
	limitTimes = 4,
	activityId = 1,
	isShow = 5
}
local dataList = {
	{
		265001,
		1,
		"4:7008:25",
		4,
		1
	},
	{
		265001,
		2,
		"4:90145:1",
		1,
		1
	},
	{
		265001,
		3,
		"4:510022:1",
		5,
		1
	},
	{
		265001,
		4,
		"4:400002:25",
		4,
		1
	},
	{
		265001,
		5,
		"4:30006:50",
		4,
		1
	},
	{
		265001,
		6,
		"8:1:10000",
		99,
		0
	}
}
local t_project_ash_lottery = {
	[265001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_project_ash_lottery.dataList = dataList

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

return t_project_ash_lottery
