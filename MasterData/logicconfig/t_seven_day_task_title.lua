-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_seven_day_task_title.lua

module("logicconfig.config.t_seven_day_task_title", package.seeall)

local title = {
	id = 1,
	desc = 2
}
local dataList = {
	{
		1,
		"玩法组合"
	},
	{
		2,
		"主线冒险"
	},
	{
		3,
		"精灵挑战"
	}
}
local t_seven_day_task_title = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_seven_day_task_title.dataList = dataList

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

return t_seven_day_task_title
