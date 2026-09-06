-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_material_challenge_buy.lua

module("logicconfig.config.t_material_challenge_buy", package.seeall)

local title = {
	cost = 3,
	times = 2,
	chapterId = 1
}
local dataList = {
	{
		1,
		1,
		"105:9:20"
	},
	{
		1,
		2,
		"105:9:20"
	},
	{
		1,
		3,
		"105:9:50"
	},
	{
		2,
		1,
		"105:9:20"
	},
	{
		2,
		2,
		"105:9:20"
	},
	{
		2,
		3,
		"105:9:50"
	},
	{
		3,
		1,
		"105:9:20"
	},
	{
		3,
		2,
		"105:9:20"
	},
	{
		3,
		3,
		"105:9:50"
	},
	{
		4,
		1,
		"105:9:20"
	},
	{
		4,
		2,
		"105:9:20"
	},
	{
		4,
		3,
		"105:9:50"
	}
}
local t_material_challenge_buy = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9]
	},
	{
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_material_challenge_buy.dataList = dataList

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

return t_material_challenge_buy
