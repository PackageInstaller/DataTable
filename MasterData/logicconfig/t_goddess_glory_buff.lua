-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_glory_buff.lua

module("logicconfig.config.t_goddess_glory_buff", package.seeall)

local title = {
	selfBuff = 3,
	desc = 4,
	buffId = 1,
	raceIds = 2
}
local dataList = {
	{
		1,
		{
			11009
		},
		"20019202:99",
		"上阵神曜极睿·哆啦梦梦，每只精灵每次出手前，使其相邻的精灵获得10气势"
	},
	{
		2,
		{
			11009
		},
		"20019202:99",
		"上阵神曜极睿·哆啦梦梦，每只精灵每次出手前，使其相邻的精灵获得10气势"
	},
	{
		3,
		{
			11009
		},
		"20019202:99",
		"上阵神曜极睿·哆啦梦梦，每只精灵每次出手前，使其相邻的精灵获得10气势"
	},
	{
		4,
		{
			11009
		},
		"20019202:99",
		"上阵神曜极睿·哆啦梦梦，每只精灵每次出手前，使其相邻的精灵获得10气势"
	},
	{
		5,
		{
			11009
		},
		"20019202:99",
		"上阵神曜极睿·哆啦梦梦，每只精灵每次出手前，使其相邻的精灵获得10气势"
	},
	{
		6,
		{
			11009
		},
		"20019202:99",
		"上阵神曜极睿·哆啦梦梦，每只精灵每次出手前，使其相邻的精灵获得10气势"
	}
}
local t_goddess_glory_buff = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_goddess_glory_buff.dataList = dataList

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

return t_goddess_glory_buff
