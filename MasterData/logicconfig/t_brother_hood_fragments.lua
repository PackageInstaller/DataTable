-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_brother_hood_fragments.lua

module("logicconfig.config.t_brother_hood_fragments", package.seeall)

local title = {
	name = 3,
	fragmentsId = 2,
	plotPlan = 1,
	resource = 4
}
local dataList = {
	{
		1,
		101,
		"剧情碎片1",
		"icon_juqingsuipian"
	},
	{
		1,
		102,
		"剧情碎片2",
		"icon_juqingsuipian"
	},
	{
		1,
		103,
		"剧情碎片3",
		"icon_juqingsuipian"
	},
	{
		1,
		104,
		"剧情碎片4",
		"icon_juqingsuipian"
	},
	{
		2,
		201,
		"剧情碎片5",
		"icon_juqingsuipian"
	},
	{
		2,
		202,
		"剧情碎片6",
		"icon_juqingsuipian"
	},
	{
		2,
		203,
		"剧情碎片7",
		"icon_juqingsuipian"
	},
	{
		2,
		204,
		"剧情碎片8",
		"icon_juqingsuipian"
	},
	{
		3,
		301,
		"剧情碎片9",
		"icon_juqingsuipian"
	},
	{
		3,
		302,
		"剧情碎片10",
		"icon_juqingsuipian"
	},
	{
		3,
		303,
		"剧情碎片11",
		"icon_juqingsuipian"
	},
	{
		3,
		304,
		"剧情碎片12",
		"icon_juqingsuipian"
	},
	{
		4,
		401,
		"剧情碎片13",
		"icon_juqingsuipian"
	},
	{
		4,
		402,
		"剧情碎片14",
		"icon_juqingsuipian"
	},
	{
		4,
		403,
		"剧情碎片15",
		"icon_juqingsuipian"
	},
	{
		4,
		404,
		"剧情碎片16",
		"icon_juqingsuipian"
	},
	{
		5,
		501,
		"剧情碎片17",
		"icon_juqingsuipian"
	},
	{
		5,
		502,
		"剧情碎片18",
		"icon_juqingsuipian"
	},
	{
		5,
		503,
		"剧情碎片19",
		"icon_juqingsuipian"
	},
	{
		5,
		504,
		"剧情碎片20",
		"icon_juqingsuipian"
	},
	{
		6,
		601,
		"碎片1",
		"com_icon_xingshi_01"
	},
	{
		6,
		602,
		"碎片6",
		"com_icon_xingshi_02"
	},
	{
		6,
		603,
		"碎片5",
		"com_icon_xingshi_03"
	},
	{
		6,
		604,
		"碎片2",
		"com_icon_xingshi_05"
	},
	{
		6,
		605,
		"碎片4",
		"com_icon_xingshi_06"
	},
	{
		6,
		606,
		"碎片3",
		"com_icon_xingshi_07"
	}
}
local t_brother_hood_fragments = {
	{
		[101] = dataList[1],
		[102] = dataList[2],
		[103] = dataList[3],
		[104] = dataList[4]
	},
	{
		[201] = dataList[5],
		[202] = dataList[6],
		[203] = dataList[7],
		[204] = dataList[8]
	},
	{
		[301] = dataList[9],
		[302] = dataList[10],
		[303] = dataList[11],
		[304] = dataList[12]
	},
	{
		[401] = dataList[13],
		[402] = dataList[14],
		[403] = dataList[15],
		[404] = dataList[16]
	},
	{
		[501] = dataList[17],
		[502] = dataList[18],
		[503] = dataList[19],
		[504] = dataList[20]
	},
	{
		[601] = dataList[21],
		[602] = dataList[22],
		[603] = dataList[23],
		[604] = dataList[24],
		[605] = dataList[25],
		[606] = dataList[26]
	}
}

t_brother_hood_fragments.dataList = dataList

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

return t_brother_hood_fragments
