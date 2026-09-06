-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_sk_liexin_progress_prize.lua

module("logicconfig.config.t_divine_sk_liexin_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	progress = 3,
	prize = 4,
	prizePlanId = 1
}
local dataList = {
	{
		1,
		1,
		1,
		"8:1:100000"
	},
	{
		1,
		2,
		2,
		"8:1:100000"
	},
	{
		1,
		3,
		3,
		"8:1:100000"
	},
	{
		1,
		4,
		4,
		"8:1:100000"
	},
	{
		1,
		5,
		5,
		"4:288:50"
	},
	{
		2,
		1,
		3,
		"8:1:100000"
	},
	{
		2,
		2,
		6,
		"8:1:100000"
	},
	{
		2,
		3,
		9,
		"8:1:100000"
	},
	{
		2,
		4,
		12,
		"8:1:100000"
	},
	{
		2,
		5,
		15,
		"4:288:50"
	}
}
local t_divine_sk_liexin_progress_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_divine_sk_liexin_progress_prize.dataList = dataList

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

return t_divine_sk_liexin_progress_prize
