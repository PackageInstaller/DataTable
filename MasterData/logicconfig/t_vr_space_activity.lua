-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_vr_space_activity.lua

module("logicconfig.config.t_vr_space_activity", package.seeall)

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
		531001,
		"func#618#13023",
		"mibao#jinglingyangcheng",
		"func#43#132",
		"",
		"",
		15041
	},
	{
		531002,
		"func#618#13023",
		"mibao#jinglingyangcheng",
		"func#43#132",
		"",
		"",
		15041
	}
}
local t_vr_space_activity = {
	[531001] = dataList[1],
	[531002] = dataList[2]
}

t_vr_space_activity.dataList = dataList

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

return t_vr_space_activity
