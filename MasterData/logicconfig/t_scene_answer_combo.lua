-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_scene_answer_combo.lua

module("logicconfig.config.t_scene_answer_combo", package.seeall)

local title = {
	score = 2,
	comboTimes = 1
}
local dataList = {
	{
		0,
		100
	},
	{
		1,
		100
	},
	{
		2,
		100
	},
	{
		3,
		110
	},
	{
		4,
		110
	},
	{
		5,
		110
	},
	{
		6,
		120
	},
	{
		7,
		120
	},
	{
		8,
		120
	},
	{
		9,
		130
	},
	{
		10,
		130
	},
	{
		11,
		130
	},
	{
		12,
		140
	},
	{
		13,
		140
	},
	{
		14,
		140
	},
	{
		15,
		140
	},
	{
		16,
		150
	},
	{
		17,
		150
	},
	{
		18,
		150
	},
	{
		19,
		150
	},
	{
		20,
		150
	}
}
local t_scene_answer_combo = {
	[0] = dataList[1],
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
	dataList[16],
	dataList[17],
	dataList[18],
	dataList[19],
	dataList[20],
	dataList[21]
}

t_scene_answer_combo.dataList = dataList

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

return t_scene_answer_combo
