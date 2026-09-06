-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_king_order_clg_kong_buff.lua

module("logicconfig.config.t_divine_king_order_clg_kong_buff", package.seeall)

local title = {
	activityId = 1,
	soulCount = 2,
	desc = 3
}
local dataList = {
	{
		357001,
		1,
		"该精灵生命-33%"
	},
	{
		357001,
		2,
		"该精灵生命-66%"
	},
	{
		357001,
		3,
		"该精灵生命-99%"
	},
	{
		357002,
		1,
		"该精灵生命-33%"
	},
	{
		357002,
		2,
		"该精灵生命-66%"
	},
	{
		357002,
		3,
		"该精灵生命-99%"
	}
}
local t_divine_king_order_clg_kong_buff = {
	[357001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[357002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_divine_king_order_clg_kong_buff.dataList = dataList

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

return t_divine_king_order_clg_kong_buff
