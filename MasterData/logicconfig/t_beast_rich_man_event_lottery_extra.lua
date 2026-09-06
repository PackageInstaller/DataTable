-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_beast_rich_man_event_lottery_extra.lua

module("logicconfig.config.t_beast_rich_man_event_lottery_extra", package.seeall)

local title = {
	name = 3,
	skinId = 4,
	id = 2,
	activityId = 1,
	posAndSize = 5
}
local dataList = {
	{
		558001,
		1,
		"青丘国轮盘",
		"1803101",
		{
			-70,
			-430,
			0.8
		}
	},
	{
		558001,
		2,
		"扶桑树轮盘",
		"1202105",
		{
			-90,
			-395,
			0.8
		}
	},
	{
		558001,
		3,
		"昆仑墟轮盘",
		"1204503",
		{
			-205,
			-610,
			1
		}
	}
}
local t_beast_rich_man_event_lottery_extra = {
	[558001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_beast_rich_man_event_lottery_extra.dataList = dataList

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

return t_beast_rich_man_event_lottery_extra
