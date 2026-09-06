-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_luyngarde_chapter2_boss_damage.lua

module("logicconfig.config.t_luyngarde_chapter2_boss_damage", package.seeall)

local title = {
	prizeId = 2,
	damage = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		466001,
		1,
		"50000000",
		"10:466003:2500"
	},
	{
		466001,
		2,
		"100000000",
		"10:466002:5000"
	},
	{
		466001,
		3,
		"150000000",
		"10:466003:2500"
	},
	{
		466001,
		4,
		"200000000",
		"10:466002:5000"
	},
	{
		466001,
		5,
		"250000000",
		"10:466003:2500"
	},
	{
		466001,
		6,
		"300000000",
		"10:466002:5000"
	},
	{
		466001,
		7,
		"400000000",
		"10:466003:2500"
	},
	{
		466001,
		8,
		"500000000",
		"10:466002:5000"
	}
}
local t_luyngarde_chapter2_boss_damage = {
	[466001] = {
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

t_luyngarde_chapter2_boss_damage.dataList = dataList

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

return t_luyngarde_chapter2_boss_damage
