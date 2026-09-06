-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_king_doppelganger_clg_rank.lua

module("logicconfig.config.t_dragon_king_doppelganger_clg_rank", package.seeall)

local title = {
	rankRange = 3,
	prize = 4,
	activityId = 1,
	subId = 2
}
local dataList = {
	{
		315001,
		1,
		{
			1,
			1
		},
		"104:2:2000"
	},
	{
		315001,
		2,
		{
			2,
			10
		},
		"104:2:1500"
	},
	{
		315001,
		3,
		{
			11,
			50
		},
		"104:2:1000"
	},
	{
		315001,
		4,
		{
			51,
			100
		},
		"104:2:500"
	}
}
local t_dragon_king_doppelganger_clg_rank = {
	[315001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_dragon_king_doppelganger_clg_rank.dataList = dataList

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

return t_dragon_king_doppelganger_clg_rank
