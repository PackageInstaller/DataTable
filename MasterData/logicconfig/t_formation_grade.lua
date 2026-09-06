-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_formation_grade.lua

module("logicconfig.config.t_formation_grade", package.seeall)

local title = {
	score = 1,
	grade = 2
}
local dataList = {
	{
		"100",
		"S"
	},
	{
		"80",
		"A"
	},
	{
		"60",
		"B"
	},
	{
		"40",
		"C"
	},
	{
		"0",
		"D"
	}
}
local t_formation_grade = {
	["100"] = dataList[1],
	["80"] = dataList[2],
	["60"] = dataList[3],
	["40"] = dataList[4],
	["0"] = dataList[5]
}

t_formation_grade.dataList = dataList

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

return t_formation_grade
