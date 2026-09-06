-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_knowledge_answer_seek_help.lua

module("logicconfig.config.t_knowledge_answer_seek_help", package.seeall)

local title = {
	desc = 5,
	name = 4,
	effPath = 6,
	type = 2,
	activityId = 1,
	times = 3
}
local dataList = {
	{
		449001,
		1,
		3,
		"是非之王",
		"帮您去掉一个错误答案",
		"scene/answerscene/answerscene_wrong_sign"
	},
	{
		449001,
		2,
		3,
		"女仆助手",
		"给您提供一个小提示",
		""
	}
}
local t_knowledge_answer_seek_help = {
	[449001] = {
		dataList[1],
		dataList[2]
	}
}

t_knowledge_answer_seek_help.dataList = dataList

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

return t_knowledge_answer_seek_help
