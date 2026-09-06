-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_longyan_xixi_skin.lua

module("logicconfig.config.t_longyan_xixi_skin", package.seeall)

local title = {
	skinName = 3,
	normalPrice = 6,
	extraPrize = 7,
	skinId = 2,
	id = 1,
	discountCost = 4,
	discountPrice = 5,
	isHideSkin = 8
}
local dataList = {
	{
		1,
		1014301,
		"龙炎",
		"",
		"",
		"rmb_88",
		"",
		true
	},
	{
		2,
		1030901,
		"茜茜",
		"",
		"",
		"rmb_68",
		"",
		true
	},
	{
		3,
		1032201,
		"伊丽莎白",
		"10:17009:1",
		"rmb_18",
		"rmb_30",
		"10:17009:1",
		false
	},
	{
		4,
		1014601,
		"修尔",
		"10:17009:1",
		"rmb_18",
		"rmb_30",
		"10:17009:1",
		false
	},
	{
		5,
		1032401,
		"夏日清泉·黄金神女",
		"4:90088:1",
		"rmb_40",
		"rmb_45",
		"4:36:10#104:2:1000",
		false
	},
	{
		6,
		1032001,
		"白色死神",
		"",
		"",
		"rmb_30",
		"4:36:2#4:90062:100",
		false
	},
	{
		7,
		1002701,
		"流光溢彩·圣光神女",
		"4:91006:1",
		"rmb_40",
		"rmb_45",
		"4:36:10#4:90062:150",
		false
	},
	{
		8,
		1009701,
		"满江红·末炎",
		"",
		"",
		"rmb_30",
		"4:36:2#4:90062:100",
		false
	},
	{
		9,
		1038101,
		"异形未来·王也",
		"10:17011:1",
		"rmb_18",
		"rmb_30",
		"10:17011:1",
		false
	},
	{
		10,
		1038001,
		"异形未来·冯宝宝",
		"10:17011:1",
		"rmb_18",
		"rmb_30",
		"10:17011:1",
		false
	},
	{
		11,
		1100102,
		"暗夜双子•希妮安",
		"4:90108:1",
		"rmb_40",
		"rmb_45",
		"4:36:10#104:2:1000#17:1100103:-1:1",
		true
	}
}
local t_longyan_xixi_skin = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11]
}

t_longyan_xixi_skin.dataList = dataList

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

return t_longyan_xixi_skin
