-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_unique_world_buff.lua

module("logicconfig.config.t_unique_world_buff", package.seeall)

local title = {
	itemId = 3,
	buffId = 1,
	desc = 2
}
local dataList = {
	{
		1,
		"己阵精灵全属性+50%",
		3
	},
	{
		2,
		"己阵精灵获得50气势",
		4
	},
	{
		3,
		"己阵精灵暴击率+50%",
		5
	},
	{
		4,
		"己阵精灵闪避率+50%",
		6
	}
}
local t_unique_world_buff = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_unique_world_buff.dataList = dataList

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

return t_unique_world_buff
