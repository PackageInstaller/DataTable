-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_aocore.lua

module("logicconfig.config.t_aocore", package.seeall)

local title = {
	name = 2,
	funcId = 3,
	id = 1,
	icon = 5,
	redpointID = 4,
	order = 6
}
local dataList = {
	{
		1,
		"精灵进化",
		375,
		nil,
		"btn_ah_12",
		3
	},
	{
		2,
		"时间之轮",
		65,
		{
			-65
		},
		"btn_ah_06",
		1
	},
	{
		3,
		"精灵排行",
		608,
		{
			-236
		},
		"btn_ah_14",
		8
	},
	{
		4,
		"冒险回忆",
		104,
		{
			142
		},
		"btn_ah_07",
		2
	},
	{
		5,
		"精灵契约",
		264,
		nil,
		"btn_ah_09",
		5
	},
	{
		6,
		"炼金工坊",
		253,
		nil,
		"btn_ah_11",
		6
	},
	{
		7,
		"时光机",
		282,
		nil,
		"btn_ah_10",
		7
	}
}
local t_aocore = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7]
}

t_aocore.dataList = dataList

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

return t_aocore
