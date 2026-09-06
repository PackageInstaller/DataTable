-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_formation_grade_content.lua

module("logicconfig.config.t_formation_grade_content", package.seeall)

local title = {
	id = 1,
	score = 3,
	desc = 2
}
local dataList = {
	{
		"p1",
		"克制敌阵精灵属性",
		10
	},
	{
		"p2",
		"被敌阵精灵克制属性",
		-10
	},
	{
		"p4",
		"我方输出放置在肉盾身后",
		10
	},
	{
		"p5",
		"我方输出放置在肉盾身后",
		10
	}
}
local t_formation_grade_content = {
	p1 = dataList[1],
	p2 = dataList[2],
	p4 = dataList[3],
	p5 = dataList[4]
}

t_formation_grade_content.dataList = dataList

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

return t_formation_grade_content
