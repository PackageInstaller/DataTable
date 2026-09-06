-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_emperor_subdue_buff.lua

module("logicconfig.config.t_emperor_subdue_buff", package.seeall)

local title = {
	activityId = 1,
	buffDesc = 5,
	buffId = 2,
	buffName = 4,
	buffIcon = 3
}
local dataList = {
	{
		547001,
		1,
		"icon_expedition_jingzhun01",
		"命中率+50%",
		"命中率+50%"
	},
	{
		547001,
		2,
		"icon_expedition_yisun01",
		"破击率+50%",
		"破击率+50%"
	},
	{
		547001,
		3,
		"icon_expedition_chushouqianjianshang",
		"攻击+20%",
		"攻击+20%"
	},
	{
		547001,
		4,
		"icon_expedition_shenqi_guang",
		"暴击率+30%",
		"暴击率+30%"
	},
	{
		547001,
		5,
		"icon_expedition_wugong3",
		"闪避率+20%",
		"闪避率+20%"
	},
	{
		547001,
		6,
		"icon_expedition_wugong1",
		"闪避率-50%",
		"闪避率-50%"
	},
	{
		547001,
		7,
		"icon_expedition_chaoshahoumianyi",
		"格挡率-50%",
		"格挡率-50%"
	},
	{
		547001,
		8,
		"icon_expedition_danggelv",
		"攻击-20%",
		"攻击-20%"
	},
	{
		547001,
		9,
		"icon_expedition_shenqi_cao",
		"暴击率-30%",
		"暴击率-30%"
	},
	{
		547001,
		10,
		"icon_expedition_jingzhun01",
		"命中率-20%",
		"命中率-20%"
	}
}
local t_emperor_subdue_buff = {
	[547001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_emperor_subdue_buff.dataList = dataList

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

return t_emperor_subdue_buff
