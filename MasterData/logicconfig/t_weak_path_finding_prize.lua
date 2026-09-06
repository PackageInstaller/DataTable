-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_weak_path_finding_prize.lua

module("logicconfig.config.t_weak_path_finding_prize", package.seeall)

local title = {
	id = 2,
	progress = 3,
	prize = 4,
	prizePlanId = 1
}
local dataList = {
	{
		1,
		1,
		1,
		"4:90228:1"
	},
	{
		1,
		2,
		2,
		"4:90228:1"
	},
	{
		1,
		3,
		3,
		"4:90228:1"
	},
	{
		1,
		4,
		4,
		"4:90229:1"
	},
	{
		1,
		5,
		5,
		"4:90229:1"
	},
	{
		1,
		6,
		8,
		"4:90229:1"
	},
	{
		1,
		7,
		10,
		"4:90229:1"
	},
	{
		1,
		8,
		13,
		"4:90230:1"
	},
	{
		1,
		9,
		16,
		"4:90230:1"
	},
	{
		1,
		10,
		20,
		"4:90230:1"
	}
}
local t_weak_path_finding_prize = {
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

t_weak_path_finding_prize.dataList = dataList

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

return t_weak_path_finding_prize
