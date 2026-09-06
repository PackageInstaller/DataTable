-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_make_snowman_pos.lua

module("logicconfig.config.t_make_snowman_pos", package.seeall)

local title = {
	posOffset = 2,
	pickRes = 3,
	showRes = 4,
	unitId = 1
}
local dataList = {
	{
		1,
		{
			30,
			50
		},
		"",
		""
	},
	{
		2,
		{
			30,
			50
		},
		"",
		""
	},
	{
		3,
		{
			30,
			50
		},
		"",
		""
	},
	{
		4,
		{
			30,
			50
		},
		"",
		""
	},
	{
		5,
		{
			30,
			50
		},
		"",
		""
	}
}
local t_make_snowman_pos = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_make_snowman_pos.dataList = dataList

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

return t_make_snowman_pos
