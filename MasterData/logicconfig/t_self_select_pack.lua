-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_self_select_pack.lua

module("logicconfig.config.t_self_select_pack", package.seeall)

local title = {
	packId = 2,
	packName = 3,
	limitType = 7,
	payGoodsId = 4,
	selectNum = 6,
	fixedPrize = 5,
	activityId = 1,
	buyLimit = 8
}
local dataList = {
	{
		57001,
		1,
		"6元超值礼包",
		"rmb_6",
		"4:36:2",
		2,
		"weekly",
		2
	},
	{
		57001,
		2,
		"18元超值礼包",
		"rmb_18",
		"4:36:5",
		2,
		"weekly",
		2
	},
	{
		57001,
		3,
		"30元超值礼包",
		"rmb_30",
		"4:36:8",
		2,
		"weekly",
		2
	},
	{
		57002,
		1,
		"6元超值礼包",
		"rmb_6",
		"4:36:2",
		2,
		"weekly",
		2
	},
	{
		57002,
		2,
		"18元超值礼包",
		"rmb_18",
		"4:36:5",
		2,
		"weekly",
		2
	},
	{
		57002,
		3,
		"30元超值礼包",
		"rmb_30",
		"4:36:8",
		2,
		"weekly",
		2
	},
	{
		57003,
		1,
		"6元超值礼包",
		"rmb_6",
		"4:36:2",
		2,
		"weekly",
		2
	},
	{
		57003,
		2,
		"18元超值礼包",
		"rmb_18",
		"4:36:5",
		2,
		"weekly",
		2
	},
	{
		57003,
		3,
		"30元超值礼包",
		"rmb_30",
		"4:36:8",
		2,
		"weekly",
		2
	}
}
local t_self_select_pack = {
	[57001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[57002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[57003] = {
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_self_select_pack.dataList = dataList

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

return t_self_select_pack
