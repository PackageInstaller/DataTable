-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dark_dragon_preheat_progress.lua

module("logicconfig.config.t_dark_dragon_preheat_progress", package.seeall)

local title = {
	id = 2,
	needScore = 3,
	prize = 4,
	progressPlanId = 1
}
local dataList = {
	{
		1,
		1,
		1,
		"4:36:1"
	},
	{
		1,
		2,
		2,
		"4:36:1"
	},
	{
		1,
		3,
		4,
		"4:36:1"
	}
}
local t_dark_dragon_preheat_progress = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_dark_dragon_preheat_progress.dataList = dataList

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

return t_dark_dragon_preheat_progress
