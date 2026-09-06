-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_best_dragon_soul_like.lua

module("logicconfig.config.t_best_dragon_soul_like", package.seeall)

local title = {
	id = 2,
	pos = 4,
	activityId = 1,
	desc = 3
}
local dataList = {
	{
		358001,
		1,
		"额外出手",
		{
			60.5,
			181.8
		}
	},
	{
		358001,
		2,
		"变身回血",
		{
			234.5,
			89.5
		}
	},
	{
		358001,
		3,
		"复活加气",
		{
			60.5,
			-3.8
		}
	}
}
local t_best_dragon_soul_like = {
	[358001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_best_dragon_soul_like.dataList = dataList

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

return t_best_dragon_soul_like
