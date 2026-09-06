-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_season_rank_params.lua

module("logicconfig.config.t_family_season_rank_params", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"INHERIT_RATE",
		"0.15"
	},
	{
		"TOP_NUM_LIMIT",
		"200000"
	},
	{
		"VIEW_TOP_NUM_LIMIT",
		"50"
	}
}
local t_family_season_rank_params = {
	INHERIT_RATE = dataList[1],
	TOP_NUM_LIMIT = dataList[2],
	VIEW_TOP_NUM_LIMIT = dataList[3]
}

t_family_season_rank_params.dataList = dataList

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

return t_family_season_rank_params
