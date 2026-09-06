-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_beast_rich_man_event_lottery.lua

module("logicconfig.config.t_beast_rich_man_event_lottery", package.seeall)

local title = {
	id = 2,
	round = 3,
	activityId = 1
}
local dataList = {
	{
		558001,
		1,
		1
	},
	{
		558001,
		1,
		2
	},
	{
		558001,
		1,
		3
	},
	{
		558001,
		2,
		1
	},
	{
		558001,
		2,
		2
	},
	{
		558001,
		2,
		3
	},
	{
		558001,
		3,
		1
	},
	{
		558001,
		3,
		2
	},
	{
		558001,
		3,
		3
	}
}
local t_beast_rich_man_event_lottery = {
	[558001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6]
		},
		{
			dataList[7],
			dataList[8],
			dataList[9]
		}
	}
}

t_beast_rich_man_event_lottery.dataList = dataList

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

return t_beast_rich_man_event_lottery
