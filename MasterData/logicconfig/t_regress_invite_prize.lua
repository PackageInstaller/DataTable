-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_regress_invite_prize.lua

module("logicconfig.config.t_regress_invite_prize", package.seeall)

local title = {
	prizeId = 2,
	needCount = 3,
	planId = 1,
	prize = 4
}
local dataList = {
	{
		1,
		1,
		1,
		"4:31:1"
	},
	{
		1,
		2,
		2,
		"4:31:2"
	},
	{
		1,
		3,
		3,
		"4:31:2"
	},
	{
		1,
		4,
		4,
		"4:31:5"
	},
	{
		1,
		5,
		5,
		"104:2:2000"
	},
	{
		1,
		6,
		6,
		"4:111:1"
	},
	{
		1,
		7,
		7,
		"4:111:2"
	},
	{
		1,
		8,
		8,
		"4:111:2"
	},
	{
		1,
		9,
		9,
		"4:111:5"
	}
}
local t_regress_invite_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_regress_invite_prize.dataList = dataList

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

return t_regress_invite_prize
