-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_luo_tian_da_jiao_group.lua

module("logicconfig.config.t_luo_tian_da_jiao_group", package.seeall)

local title = {
	openTime = 3,
	groupPlanId = 1,
	group = 2,
	robotNum = 5,
	prize = 4,
	desc = 6
}
local dataList = {
	{
		1,
		1,
		1,
		"8:1:500000",
		12,
		128
	},
	{
		1,
		2,
		2,
		"4:11:120",
		12,
		64
	},
	{
		1,
		3,
		3,
		"4:10:120",
		12,
		32
	},
	{
		1,
		4,
		4,
		"4:503:20",
		12,
		16
	},
	{
		1,
		5,
		5,
		"4:36:10",
		12,
		8
	},
	{
		1,
		6,
		6,
		"14:26:1",
		7,
		0
	}
}
local t_luo_tian_da_jiao_group = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_luo_tian_da_jiao_group.dataList = dataList

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

return t_luo_tian_da_jiao_group
