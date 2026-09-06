-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annual_fuben_clue_prize.lua

module("logicconfig.config.t_annual_fuben_clue_prize", package.seeall)

local title = {
	prizeId = 2,
	clueNum = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		546001,
		1,
		2,
		"10:546001:200"
	},
	{
		546001,
		2,
		4,
		"10:546001:200"
	},
	{
		546001,
		3,
		6,
		"10:546001:200"
	},
	{
		546001,
		4,
		8,
		"10:546001:200"
	},
	{
		546001,
		5,
		10,
		"10:546001:200"
	},
	{
		546001,
		6,
		12,
		"10:546001:200"
	},
	{
		546001,
		7,
		14,
		"10:546001:200"
	},
	{
		546001,
		8,
		16,
		"10:546001:200"
	}
}
local t_annual_fuben_clue_prize = {
	[546001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_annual_fuben_clue_prize.dataList = dataList

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

return t_annual_fuben_clue_prize
