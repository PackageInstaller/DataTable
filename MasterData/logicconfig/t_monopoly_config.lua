-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_monopoly_config.lua

module("logicconfig.config.t_monopoly_config", package.seeall)

local title = {
	activityId = 1,
	diamond = 5,
	limit = 6,
	pointedDecMp = 4,
	commonDecMp = 3,
	planId = 2
}
local dataList = {
	{
		1001,
		1,
		"10:1001:1",
		"10:1101:1",
		"20",
		10
	},
	{
		1002,
		2,
		"10:1002:1",
		"10:1102:1",
		"20",
		10
	},
	{
		1003,
		3,
		"10:1003:1",
		"10:1103:1",
		"20",
		10
	},
	{
		1004,
		3,
		"10:1003:1",
		"10:1103:1",
		"20",
		10
	}
}
local t_monopoly_config = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4]
}

t_monopoly_config.dataList = dataList

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

return t_monopoly_config
