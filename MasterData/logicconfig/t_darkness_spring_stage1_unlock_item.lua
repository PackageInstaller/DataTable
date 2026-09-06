-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_darkness_spring_stage1_unlock_item.lua

module("logicconfig.config.t_darkness_spring_stage1_unlock_item", package.seeall)

local title = {
	cost = 3,
	activityId = 1,
	itemId = 2,
	effectPath = 5,
	prize = 4
}
local dataList = {
	{
		430001,
		1,
		"10:430001:1",
		"8:1:500000",
		"20241220/anshizhiquan/fx_ui_sidai_03"
	},
	{
		430001,
		2,
		"10:430001:1",
		"4:30006:40",
		"20241220/anshizhiquan/fx_ui_sidai_02"
	},
	{
		430001,
		3,
		"10:430001:1",
		"4:112:5",
		"20241220/anshizhiquan/fx_ui_sidai_01"
	},
	{
		430001,
		4,
		"10:430001:1",
		"4:90316:1",
		"20241220/anshizhiquan/fx_ui_sidai_04"
	},
	{
		430001,
		5,
		"10:430001:1",
		"4:510394:1",
		"20241220/anshizhiquan/fx_ui_sidai_05"
	}
}
local t_darkness_spring_stage1_unlock_item = {
	[430001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_darkness_spring_stage1_unlock_item.dataList = dataList

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

return t_darkness_spring_stage1_unlock_item
