-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_eternal_dragon_clg_buff.lua

module("logicconfig.config.t_origin_eternal_dragon_clg_buff", package.seeall)

local title = {
	tagCount = 3,
	desc = 4,
	activityId = 1,
	type = 2
}
local dataList = {
	{
		551001,
		1,
		1,
		"每有一个春印记，己阵攻击力-25%"
	},
	{
		551001,
		1,
		2,
		"每有一个春印记，己阵攻击力-25%"
	},
	{
		551001,
		1,
		3,
		"每有一个春印记，己阵攻击力-25%"
	},
	{
		551001,
		2,
		1,
		"每有一个夏印记，己阵受到伤害+50%"
	},
	{
		551001,
		2,
		2,
		"每有一个夏印记，己阵受到伤害+50%"
	},
	{
		551001,
		2,
		3,
		"每有一个夏印记，己阵受到伤害+50%"
	},
	{
		551001,
		3,
		1,
		"每有一个秋印记，己阵最大生命值-20%"
	},
	{
		551001,
		3,
		2,
		"每有一个秋印记，己阵最大生命值-20%"
	},
	{
		551001,
		3,
		3,
		"每有一个秋印记，己阵最大生命值-20%"
	},
	{
		551001,
		4,
		1,
		"每有一个冬印记，己阵起始气势-30"
	},
	{
		551001,
		4,
		2,
		"每有一个冬印记，己阵起始气势-30"
	},
	{
		551001,
		4,
		3,
		"每有一个冬印记，己阵起始气势-30"
	}
}
local t_origin_eternal_dragon_clg_buff = {
	[551001] = {
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
}

t_origin_eternal_dragon_clg_buff.dataList = dataList

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

return t_origin_eternal_dragon_clg_buff
