-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_script_killing_npc.lua

module("logicconfig.config.t_script_killing_npc", package.seeall)

local title = {
	name = 3,
	npcId = 2,
	isMe = 5,
	icon = 4,
	activityId = 1
}
local dataList = {
	{
		365001,
		1,
		"奥奇",
		"icon_npc_zhentanaoqi",
		1
	},
	{
		365001,
		2,
		"帝释天",
		"icon_10142_dishitian01",
		0
	},
	{
		365001,
		3,
		"百序序",
		"icon_11020_shenyaowangzhezhixu02",
		0
	},
	{
		365001,
		4,
		"百莎莎",
		"icon_npc_beisha",
		0
	},
	{
		365001,
		5,
		"田星",
		"icon_41019_shenyaoxingjiang02",
		0
	},
	{
		365001,
		6,
		"小维",
		"icon_11022_shenyaoweiduoliya01",
		0
	},
	{
		365001,
		7,
		"小西",
		"icon_11003_mixixi",
		0
	},
	{
		365002,
		1,
		"奥奇",
		"icon_npc_zhentanaoqi",
		1
	},
	{
		365002,
		2,
		"诺亚",
		"icon_10140_xiaonuo",
		0
	},
	{
		365003,
		1,
		"次元",
		"icon_14045_yuanqiguangciyuan03",
		0
	},
	{
		365003,
		2,
		"黄金",
		"icon_14046_yuanqihuangjinshenglong03",
		0
	},
	{
		365003,
		3,
		"圣光",
		"icon_14049_yuanqishengguangfeilong03",
		0
	},
	{
		365003,
		4,
		"创世",
		"icon_18031_heichuang02",
		0
	},
	{
		365003,
		5,
		"尘",
		"icon_16046_yuanqichen03",
		0
	},
	{
		365003,
		6,
		"双生",
		"icon_16048_yuanqishuangshenglong07",
		0
	},
	{
		365003,
		7,
		"弥梦离",
		"icon_12047_yuanqimimengli03",
		0
	},
	{
		365003,
		8,
		"奥奇",
		"icon_npc_zhentanaoqi_02",
		1
	}
}
local t_script_killing_npc = {
	[365001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	[365002] = {
		dataList[8],
		dataList[9]
	},
	[365003] = {
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17]
	}
}

t_script_killing_npc.dataList = dataList

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

return t_script_killing_npc
