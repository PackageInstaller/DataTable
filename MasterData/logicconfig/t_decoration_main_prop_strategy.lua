-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_decoration_main_prop_strategy.lua

module("logicconfig.config.t_decoration_main_prop_strategy", package.seeall)

local title = {
	id = 1,
	propertyType = 2,
	levelStrategy = 3
}
local dataList = {
	{
		1,
		"生命",
		101
	},
	{
		1,
		"攻击",
		102
	},
	{
		1,
		"物防",
		103
	},
	{
		1,
		"魔防",
		104
	},
	{
		1,
		"速度",
		105
	},
	{
		2,
		"生命",
		201
	},
	{
		2,
		"攻击",
		202
	},
	{
		2,
		"物防",
		203
	},
	{
		2,
		"魔防",
		204
	},
	{
		2,
		"速度",
		205
	},
	{
		3,
		"生命",
		301
	},
	{
		3,
		"攻击",
		302
	},
	{
		3,
		"物防",
		303
	},
	{
		3,
		"魔防",
		304
	},
	{
		3,
		"速度",
		305
	},
	{
		4,
		"生命",
		401
	},
	{
		4,
		"攻击",
		402
	},
	{
		4,
		"物防",
		403
	},
	{
		4,
		"魔防",
		404
	},
	{
		4,
		"速度",
		405
	},
	{
		5,
		"生命",
		501
	},
	{
		5,
		"攻击",
		502
	},
	{
		5,
		"物防",
		503
	},
	{
		5,
		"魔防",
		504
	},
	{
		5,
		"速度",
		505
	}
}
local t_decoration_main_prop_strategy = {
	{
		生命 = dataList[1],
		攻击 = dataList[2],
		物防 = dataList[3],
		魔防 = dataList[4],
		速度 = dataList[5]
	},
	{
		生命 = dataList[6],
		攻击 = dataList[7],
		物防 = dataList[8],
		魔防 = dataList[9],
		速度 = dataList[10]
	},
	{
		生命 = dataList[11],
		攻击 = dataList[12],
		物防 = dataList[13],
		魔防 = dataList[14],
		速度 = dataList[15]
	},
	{
		生命 = dataList[16],
		攻击 = dataList[17],
		物防 = dataList[18],
		魔防 = dataList[19],
		速度 = dataList[20]
	},
	{
		生命 = dataList[21],
		攻击 = dataList[22],
		物防 = dataList[23],
		魔防 = dataList[24],
		速度 = dataList[25]
	}
}

t_decoration_main_prop_strategy.dataList = dataList

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

return t_decoration_main_prop_strategy
