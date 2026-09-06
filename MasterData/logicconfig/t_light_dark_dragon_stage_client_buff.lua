-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_light_dark_dragon_stage_client_buff.lua

module("logicconfig.config.t_light_dark_dragon_stage_client_buff", package.seeall)

local title = {
	id = 2,
	stageBuffPlanId = 1,
	desc = 3
}
local dataList = {
	{
		1,
		1,
		"上阵任意一个龙族时，全阵属性+10%"
	},
	{
		1,
		2,
		"上阵2个水属性精灵时，全阵暴击+10%"
	},
	{
		1,
		3,
		"上阵2个光属性精灵时，全阵闪避+10%"
	},
	{
		2,
		4,
		"上阵任意一个龙族时，全阵属性+10%"
	},
	{
		2,
		5,
		"上阵2个草属性精灵时，全阵暴击+10%"
	},
	{
		2,
		6,
		"上阵2个光属性精灵时，全阵闪避+10%"
	},
	{
		3,
		7,
		"上阵任意一个龙族时，全阵属性+10%"
	},
	{
		3,
		8,
		"上阵2个火属性精灵时，全阵暴击+10%"
	},
	{
		3,
		9,
		"上阵2个暗属性精灵时，全阵闪避+10%"
	},
	{
		4,
		10,
		"上阵任意一个龙族时，全阵属性+10%"
	},
	{
		4,
		11,
		"上阵3个草属性精灵时，全阵暴击+10%"
	},
	{
		5,
		12,
		"上阵2个龙族时，全阵属性+15%"
	},
	{
		5,
		13,
		"上阵3个火属性精灵时，全阵暴击+10%"
	},
	{
		6,
		14,
		"上阵2个龙族时，全阵属性+15%"
	},
	{
		7,
		15,
		"上阵1个空属性精灵时，全阵属性+10%"
	},
	{
		7,
		16,
		"上阵2个水属性精灵时，全阵暴击+10%"
	},
	{
		8,
		17,
		"上阵1个空属性精灵时，全阵属性+10%"
	},
	{
		8,
		18,
		"上阵2个火属性精灵时，全阵暴击+10%"
	},
	{
		9,
		19,
		"上阵2个空属性精灵时，全阵属性+10%"
	},
	{
		9,
		20,
		"上阵2个草属性精灵时，全阵暴击+10%"
	},
	{
		10,
		21,
		"上阵3个空属性精灵时，全阵属性+10%"
	},
	{
		10,
		22,
		"上阵2个光属性精灵时，全阵暴击+10%"
	},
	{
		11,
		23,
		"上阵4个空属性精灵时，全阵属性+15%"
	},
	{
		11,
		24,
		"上阵2个暗属性精灵时，全阵暴击+10%"
	},
	{
		12,
		25,
		"上阵5个空属性精灵时，全阵属性+20%"
	},
	{
		13,
		26,
		"上阵5个梦之队时，全阵属性增加25%"
	},
	{
		14,
		28,
		"上阵5个梦之队时，全阵属性增加25%"
	},
	{
		15,
		30,
		"上阵5个梦之队时，全阵属性增加25%"
	},
	{
		16,
		32,
		"上阵3个水属性精灵时，全阵属性+10%"
	},
	{
		16,
		33,
		"上阵3个暗属性精灵时，全阵暴击+10%"
	},
	{
		17,
		34,
		"上阵4个水属性精灵时，全阵属性+10%"
	},
	{
		18,
		35,
		"上阵5个水属性精灵时，全阵属性+10%"
	}
}
local t_light_dark_dragon_stage_client_buff = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		[4] = dataList[4],
		[5] = dataList[5],
		[6] = dataList[6]
	},
	{
		[7] = dataList[7],
		[8] = dataList[8],
		[9] = dataList[9]
	},
	{
		[10] = dataList[10],
		[11] = dataList[11]
	},
	{
		[12] = dataList[12],
		[13] = dataList[13]
	},
	{
		[14] = dataList[14]
	},
	{
		[15] = dataList[15],
		[16] = dataList[16]
	},
	{
		[17] = dataList[17],
		[18] = dataList[18]
	},
	{
		[19] = dataList[19],
		[20] = dataList[20]
	},
	{
		[21] = dataList[21],
		[22] = dataList[22]
	},
	{
		[23] = dataList[23],
		[24] = dataList[24]
	},
	{
		[25] = dataList[25]
	},
	{
		[26] = dataList[26]
	},
	{
		[28] = dataList[27]
	},
	{
		[30] = dataList[28]
	},
	{
		[32] = dataList[29],
		[33] = dataList[30]
	},
	{
		[34] = dataList[31]
	},
	{
		[35] = dataList[32]
	}
}

t_light_dark_dragon_stage_client_buff.dataList = dataList

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

return t_light_dark_dragon_stage_client_buff
