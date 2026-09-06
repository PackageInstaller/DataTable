-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_excellent_class_score.lua

module("logicconfig.config.t_excellent_class_score", package.seeall)

local title = {
	prize = 2,
	needScore = 1
}
local dataList = {
	{
		300,
		"4:80001:1"
	},
	{
		600,
		"4:80001:1"
	},
	{
		900,
		"4:80001:1"
	},
	{
		1200,
		"4:80001:1"
	},
	{
		1500,
		"4:80001:1"
	},
	{
		1800,
		"4:80001:1"
	}
}
local t_excellent_class_score = {
	[300] = dataList[1],
	[600] = dataList[2],
	[900] = dataList[3],
	[1200] = dataList[4],
	[1500] = dataList[5],
	[1800] = dataList[6]
}

t_excellent_class_score.dataList = dataList

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

return t_excellent_class_score
