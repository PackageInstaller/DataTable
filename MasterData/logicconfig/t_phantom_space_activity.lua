-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_phantom_space_activity.lua

module("logicconfig.config.t_phantom_space_activity", package.seeall)

local title = {
	jumpStr3 = 4,
	jumpStr5 = 6,
	jumpStr2 = 3,
	skinId = 7,
	jumpStr1 = 2,
	activityId = 1,
	jumpStr4 = 5
}
local dataList = {
	{
		516001,
		"func#618#13023",
		"mibao#jinglingyangcheng",
		"func#43#132",
		"",
		"",
		13023
	},
	{
		516002,
		"func#618#13023",
		"mibao#jinglingyangcheng",
		"func#43#132",
		"",
		"",
		13023
	},
	{
		516003,
		"func#618#13023",
		"mibao#jinglingyangcheng",
		"func#43#132",
		"",
		"",
		13023
	},
	{
		516004,
		"func#618#13023",
		"mibao#jinglingyangcheng",
		"func#43#132",
		"",
		"",
		13023
	}
}
local t_phantom_space_activity = {
	[516001] = dataList[1],
	[516002] = dataList[2],
	[516003] = dataList[3],
	[516004] = dataList[4]
}

t_phantom_space_activity.dataList = dataList

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

return t_phantom_space_activity
