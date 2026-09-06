-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_red_lotus_gala_sxgame.lua

module("logicconfig.config.t_red_lotus_gala_sxgame", package.seeall)

local title = {
	stageId = 1,
	supplyWeight = 5,
	supplyAddType = 6,
	supplyAddRate = 7,
	supplyType = 4,
	layoutId = 2,
	isRamdonColor = 8,
	supplyCount = 3
}
local dataList = {
	{
		1,
		{
			1,
			2
		},
		4,
		{},
		{
			100,
			100
		},
		{
			2
		},
		{
			0
		},
		true
	},
	{
		2,
		{
			1,
			2
		},
		4,
		{},
		{
			200,
			200
		},
		{
			2
		},
		{
			0
		},
		true
	},
	{
		3,
		{
			3
		},
		5,
		{},
		{
			50,
			50,
			100,
			100
		},
		{
			2
		},
		{
			0
		},
		true
	},
	{
		4,
		{
			3
		},
		5,
		{},
		{
			100,
			100,
			100,
			100
		},
		{
			2
		},
		{
			0
		},
		true
	},
	{
		5,
		{
			1,
			2
		},
		4,
		{},
		{
			200,
			200
		},
		{
			2
		},
		{
			0
		},
		true
	}
}
local t_red_lotus_gala_sxgame = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_red_lotus_gala_sxgame.dataList = dataList

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

return t_red_lotus_gala_sxgame
