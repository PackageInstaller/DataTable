-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_scene_answer_open_time.lua

module("logicconfig.config.t_scene_answer_open_time", package.seeall)

local title = {
	endTime = 3,
	seasonId = 1,
	startTime = 2
}
local dataList = {
	{
		1,
		"2021-10-29T05:00:00",
		"2021-11-12T05:00:00"
	},
	{
		2,
		"2022-09-02T05:00:00",
		"2022-09-17T05:00:00"
	}
}
local t_scene_answer_open_time = {
	dataList[1],
	dataList[2]
}

t_scene_answer_open_time.dataList = dataList

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

return t_scene_answer_open_time
