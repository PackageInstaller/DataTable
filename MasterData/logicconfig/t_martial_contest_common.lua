-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_martial_contest_common.lua

module("logicconfig.config.t_martial_contest_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"QUALIFIER_RANK_SHOW_COUNT",
		"500"
	},
	{
		"RACE_STATIC_RANK_VIEW_COUNT",
		"50"
	}
}
local t_martial_contest_common = {
	QUALIFIER_RANK_SHOW_COUNT = dataList[1],
	RACE_STATIC_RANK_VIEW_COUNT = dataList[2]
}

t_martial_contest_common.dataList = dataList

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

return t_martial_contest_common
