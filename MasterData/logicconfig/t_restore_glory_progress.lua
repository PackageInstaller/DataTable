-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_restore_glory_progress.lua

module("logicconfig.config.t_restore_glory_progress", package.seeall)

local title = {
	progressId = 2,
	progress = 4,
	prize = 3,
	progressPlanId = 1
}
local dataList = {
	{
		1,
		1,
		"8:1:1000000",
		15000
	},
	{
		1,
		2,
		"4:111:5",
		30000
	},
	{
		1,
		3,
		"4:111:5",
		45000
	},
	{
		1,
		4,
		"4:400002:100",
		60000
	}
}
local t_restore_glory_progress = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_restore_glory_progress.dataList = dataList

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

return t_restore_glory_progress
