-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_notice_big_tab.lua

module("logicconfig.config.t_pet_notice_big_tab", package.seeall)

local title = {
	tabViewName = 6,
	name = 2,
	sortIndex = 4,
	isHide = 5,
	index = 1,
	childIndex = 3
}
local dataList = {
	{
		1,
		"最新精灵",
		{
			1,
			2,
			18,
			19,
			20,
			21
		},
		1,
		true,
		"petsummaryview"
	},
	{
		6,
		"常驻精灵",
		{
			16,
			17,
			14,
			10
		},
		2,
		true,
		"petsummaryview"
	},
	{
		5,
		"时间之门",
		{
			15
		},
		3,
		false,
		""
	},
	{
		2,
		"精灵皮肤",
		{
			3,
			4
		},
		4,
		false,
		""
	},
	{
		3,
		"神器技能",
		{
			7
		},
		7,
		false,
		""
	},
	{
		4,
		"精灵契约",
		{
			8
		},
		8,
		false,
		""
	},
	{
		7,
		"技能调整",
		{
			6
		},
		9,
		false,
		""
	}
}
local t_pet_notice_big_tab = {
	dataList[1],
	[6] = dataList[2],
	[5] = dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	[7] = dataList[7]
}

t_pet_notice_big_tab.dataList = dataList

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

return t_pet_notice_big_tab
