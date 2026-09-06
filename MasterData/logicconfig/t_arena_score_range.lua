-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_arena_score_range.lua

module("logicconfig.config.t_arena_score_range", package.seeall)

local title = {
	id = 1,
	beginZdl = 2
}
local dataList = {
	{
		1,
		-1
	},
	{
		2,
		0
	}
}
local t_arena_score_range = {
	dataList[1],
	dataList[2]
}

t_arena_score_range.dataList = dataList

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

return t_arena_score_range
