-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_martial_contest_qualifier_match.lua

module("logicconfig.config.t_martial_contest_qualifier_match", package.seeall)

local title = {
	quaMatchingPlanId = 1,
	quaMatchingId = 2
}
local dataList = {
	{
		1,
		1
	},
	{
		1,
		2
	},
	{
		1,
		3
	},
	{
		1,
		4
	},
	{
		1,
		5
	},
	{
		1,
		6
	},
	{
		1,
		7
	},
	{
		1,
		8
	},
	{
		1,
		9
	},
	{
		1,
		10
	}
}
local t_martial_contest_qualifier_match = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_martial_contest_qualifier_match.dataList = dataList

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

return t_martial_contest_qualifier_match
