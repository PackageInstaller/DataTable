-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_answer_problem_plot_chapter.lua

module("logicconfig.config.t_answer_problem_plot_chapter", package.seeall)

local title = {
	plotPlanId = 1,
	chapterName = 3,
	chapterId = 2
}
local dataList = {
	{
		1,
		1,
		"大师兄"
	},
	{
		1,
		2,
		"二师兄"
	}
}
local t_answer_problem_plot_chapter = {
	{
		dataList[1],
		dataList[2]
	}
}

t_answer_problem_plot_chapter.dataList = dataList

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

return t_answer_problem_plot_chapter
