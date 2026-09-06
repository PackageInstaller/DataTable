-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_luyngarde_chapter3_explore.lua

module("logicconfig.config.t_luyngarde_chapter3_explore", package.seeall)

local title = {
	activityId = 1,
	typeId = 3,
	posId = 2,
	title = 4
}
local dataList = {
	{
		466001,
		1,
		1,
		"boss"
	},
	{
		466001,
		2,
		2,
		"破阵"
	},
	{
		466001,
		3,
		2,
		"破阵"
	}
}
local t_luyngarde_chapter3_explore = {
	[466001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_luyngarde_chapter3_explore.dataList = dataList

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

return t_luyngarde_chapter3_explore
