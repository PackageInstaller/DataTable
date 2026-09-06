-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_time_limit_rank_common.lua

module("logicconfig.config.t_time_limit_rank_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"NOT_OPEN_TIP",
		"该试炼未开启"
	},
	{
		"NOT_OPEN_JUMP",
		""
	},
	{
		"PUBLIC_END",
		"该排行榜公示期已过"
	}
}
local t_time_limit_rank_common = {
	NOT_OPEN_TIP = dataList[1],
	NOT_OPEN_JUMP = dataList[2],
	PUBLIC_END = dataList[3]
}

t_time_limit_rank_common.dataList = dataList

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

return t_time_limit_rank_common
