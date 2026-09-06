-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_qicore.lua

module("logicconfig.config.t_qicore", package.seeall)

local title = {
	powerId = 7,
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
		"九宫八阵",
		96,
		{
			-11,
			-20
		},
		"btn_ah_04",
		1,
		9
	},
	{
		2,
		"精灵守护",
		173,
		{
			890
		},
		"btn_ah_05",
		2,
		13
	},
	{
		3,
		"收藏馆",
		174,
		{
			-19
		},
		"btn_ah_02",
		3,
		11
	},
	{
		4,
		"好感度",
		170,
		{
			68
		},
		"btn_ah_15",
		4,
		12
	},
	{
		5,
		"坐骑",
		101,
		{
			422
		},
		"btn_ah_17",
		5,
		10
	},
	{
		6,
		"图鉴",
		8,
		{
			26
		},
		"btn_ah_16",
		6,
		-1
	}
}
local t_qicore = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_qicore.dataList = dataList

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

return t_qicore
