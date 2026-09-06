-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_loading_pics.lua

module("logicconfig.config.t_loading_pics", package.seeall)

local title = {
	id = 1,
	weight = 2,
	funcId = 3
}
local dataList = {
	{
		1,
		10,
		0
	},
	{
		2,
		10,
		0
	},
	{
		3,
		10,
		0
	},
	{
		4,
		10,
		0
	},
	{
		5,
		10,
		0
	},
	{
		6,
		10,
		9
	},
	{
		7,
		10,
		9
	},
	{
		8,
		10,
		9
	},
	{
		9,
		10,
		9
	},
	{
		10,
		10,
		9
	},
	{
		11,
		10,
		9
	},
	{
		12,
		10,
		9
	},
	{
		13,
		10,
		9
	},
	{
		14,
		10,
		9
	},
	{
		15,
		10,
		9
	},
	{
		16,
		10,
		9
	}
}
local t_loading_pics = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14],
	dataList[15],
	dataList[16]
}

t_loading_pics.dataList = dataList

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

return t_loading_pics
