-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annual_fee_preheat_prize.lua

module("logicconfig.config.t_annual_fee_preheat_prize", package.seeall)

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
		150000,
		"4:901:5000"
	},
	{
		1,
		2,
		300000,
		"4:901:5000"
	},
	{
		1,
		3,
		450000,
		"4:901:5000"
	},
	{
		1,
		4,
		600000,
		"4:901:5000"
	},
	{
		1,
		5,
		750000,
		"4:901:5000"
	},
	{
		1,
		6,
		1000000,
		"4:901:5000"
	}
}
local t_annual_fee_preheat_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_annual_fee_preheat_prize.dataList = dataList

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

return t_annual_fee_preheat_prize
