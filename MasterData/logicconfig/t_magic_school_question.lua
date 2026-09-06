-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_magic_school_question.lua

module("logicconfig.config.t_magic_school_question", package.seeall)

local title = {
	campId = 2,
	id = 3,
	activityId = 1,
	content = 4
}
local dataList = {
	{
		514001,
		1,
		1,
		"在魔杖选择仪式上，你更倾向于选择哪一种木材制作的魔杖？"
	},
	{
		514001,
		1,
		2,
		" 在元素魔法实践课上，哪种元素让你感到最得心应手？"
	},
	{
		514001,
		1,
		3,
		" 魔药课上，老师不慎多分配了一份危险的破坏药剂原料，你会？"
	},
	{
		514001,
		1,
		4,
		"你希望你的魔法守护兽是什么类型？"
	},
	{
		514001,
		1,
		5,
		"在处理一个复杂的古魔法阵时，你的首要策略是？"
	},
	{
		514001,
		2,
		1,
		"在魔杖选择仪式上，你更倾向于选择哪一种木材制作的魔杖？"
	},
	{
		514001,
		2,
		2,
		" 在元素魔法实践课上，哪种元素让你感到最得心应手？"
	},
	{
		514001,
		2,
		3,
		" 魔药课上，老师不慎多分配了一份危险的破坏药剂原料，你会？"
	},
	{
		514001,
		2,
		4,
		"你希望你的魔法守护兽是什么类型？"
	},
	{
		514001,
		2,
		5,
		"在处理一个复杂的古魔法阵时，你的首要策略是？"
	}
}
local t_magic_school_question = {
	[514001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5]
		},
		{
			dataList[6],
			dataList[7],
			dataList[8],
			dataList[9],
			dataList[10]
		}
	}
}

t_magic_school_question.dataList = dataList

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

return t_magic_school_question
