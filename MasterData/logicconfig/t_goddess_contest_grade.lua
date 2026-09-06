-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_contest_grade.lua

module("logicconfig.config.t_goddess_contest_grade", package.seeall)

local title = {
	name = 2,
	gradeId = 1,
	pressVote = 4,
	reviseDeclaration = 3
}
local dataList = {
	{
		1,
		"团长",
		true,
		true
	},
	{
		2,
		"副团长",
		true,
		true
	},
	{
		3,
		"精英",
		false,
		false
	},
	{
		4,
		"团员",
		false,
		false
	}
}
local t_goddess_contest_grade = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_goddess_contest_grade.dataList = dataList

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

return t_goddess_contest_grade
