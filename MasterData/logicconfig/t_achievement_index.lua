-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_achievement_index.lua

module("logicconfig.config.t_achievement_index", package.seeall)

local title = {
	leaf = 2,
	name = 3,
	root = 1
}
local dataList = {
	{
		0,
		0,
		"总 览"
	},
	{
		1,
		0,
		"精 灵"
	},
	{
		1,
		1,
		"皮肤"
	},
	{
		2,
		0,
		"养 成"
	},
	{
		2,
		1,
		"等 级"
	},
	{
		2,
		2,
		"天 赋"
	},
	{
		2,
		3,
		"装备"
	},
	{
		2,
		4,
		"升星"
	},
	{
		2,
		5,
		"星神"
	},
	{
		2,
		6,
		"收藏品"
	},
	{
		2,
		7,
		"精灵守护"
	},
	{
		3,
		0,
		"冒 险"
	},
	{
		3,
		1,
		"剧 情"
	},
	{
		3,
		3,
		"传说挑战"
	},
	{
		4,
		0,
		"玩 法"
	},
	{
		4,
		1,
		"勇者之塔"
	},
	{
		4,
		2,
		"破阵天下"
	},
	{
		4,
		5,
		"失落遗迹"
	},
	{
		4,
		6,
		"竞技场"
	},
	{
		5,
		0,
		"收 集"
	},
	{
		5,
		1,
		"金币"
	},
	{
		5,
		2,
		"召唤"
	},
	{
		5,
		3,
		"时装"
	},
	{
		5,
		4,
		"头像"
	},
	{
		5,
		5,
		"头像框"
	},
	{
		6,
		0,
		"家 族"
	},
	{
		6,
		1,
		"家族活动"
	},
	{
		6,
		2,
		"家族财富"
	}
}
local t_achievement_index = {
	[0] = {
		[0] = dataList[1]
	},
	{
		[0] = dataList[2],
		dataList[3]
	},
	{
		[0] = dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11]
	},
	{
		[0] = dataList[12],
		dataList[13],
		[3] = dataList[14]
	},
	{
		[0] = dataList[15],
		dataList[16],
		dataList[17],
		[5] = dataList[18],
		[6] = dataList[19]
	},
	{
		[0] = dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25]
	},
	{
		[0] = dataList[26],
		dataList[27],
		dataList[28]
	}
}

t_achievement_index.dataList = dataList

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

return t_achievement_index
