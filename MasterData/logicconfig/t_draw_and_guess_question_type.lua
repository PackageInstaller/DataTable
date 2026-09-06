-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_draw_and_guess_question_type.lua

module("logicconfig.config.t_draw_and_guess_question_type", package.seeall)

local title = {
	desc = 2,
	typeId = 1
}
local dataList = {
	{
		1,
		"美食"
	},
	{
		2,
		"清洁洗护"
	},
	{
		3,
		"厨房用品"
	},
	{
		4,
		"文具办公"
	},
	{
		5,
		"交通工具"
	},
	{
		6,
		"职业"
	},
	{
		7,
		"运动"
	},
	{
		8,
		"节日"
	},
	{
		9,
		"植物"
	},
	{
		10,
		"穿戴类"
	},
	{
		11,
		"武器"
	},
	{
		12,
		"医疗用品"
	},
	{
		13,
		"容器"
	},
	{
		14,
		"果蔬"
	},
	{
		15,
		"动物"
	}
}
local t_draw_and_guess_question_type = {
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
	dataList[15]
}

t_draw_and_guess_question_type.dataList = dataList

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

return t_draw_and_guess_question_type
