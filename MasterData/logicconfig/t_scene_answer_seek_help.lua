-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_scene_answer_seek_help.lua

module("logicconfig.config.t_scene_answer_seek_help", package.seeall)

local title = {
	times = 2,
	name = 3,
	effPath = 5,
	type = 1,
	desc = 4
}
local dataList = {
	{
		1,
		3,
		"是非之王",
		"帮您去掉一个错误答案",
		"scene/answerscene/answerscene_wrong_sign"
	},
	{
		2,
		3,
		"女仆助手",
		"给您提供一个小提示",
		""
	}
}
local t_scene_answer_seek_help = {
	dataList[1],
	dataList[2]
}

t_scene_answer_seek_help.dataList = dataList

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

return t_scene_answer_seek_help
