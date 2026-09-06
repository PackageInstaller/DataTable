-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xingjiang_formula_challenge_task_page.lua

module("logicconfig.config.t_xingjiang_formula_challenge_task_page", package.seeall)

local title = {
	pagePicture = 4,
	pageTips = 5,
	pageName = 3,
	pageId = 2,
	taskPlanId = 1
}
local dataList = {
	{
		1,
		1,
		"神唤任务",
		"icon_shenhuanjuan",
		"最多可获得<quad name=4:136|icon size=25 width=1 offsetY=-5/> x 25"
	},
	{
		1,
		2,
		"召唤任务",
		"icon_quan",
		"最多可获得<quad name=4:136|icon size=25 width=1 offsetY=-5/> x 13"
	}
}
local t_xingjiang_formula_challenge_task_page = {
	{
		dataList[1],
		dataList[2]
	}
}

t_xingjiang_formula_challenge_task_page.dataList = dataList

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

return t_xingjiang_formula_challenge_task_page
