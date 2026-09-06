-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_activity_reward_page.lua

module("logicconfig.config.t_activity_reward_page", package.seeall)

local title = {
	isUseRole = 10,
	modelId = 6,
	pageName = 4,
	roleDressIds = 11,
	textContent = 9,
	activityType = 3,
	modelScale = 8,
	delayDays = 5,
	pageId = 2,
	activityId = 1,
	modelPos = 7
}
local dataList = {
	{
		17011,
		1,
		17,
		"精灵",
		0,
		14002,
		{
			-70,
			-200
		},
		{
			-0.9,
			0.9
		},
		"<color=#556fb5><size=24>哥哥最厉害了，跟哥哥关系这么好的你，肯定也很厉害！</size></color>",
		false,
		""
	},
	{
		17011,
		2,
		17,
		"装备/星神",
		0,
		14002,
		{
			-70,
			-200
		},
		{
			-0.9,
			0.9
		},
		"<color=#556fb5><size=24>哥哥最厉害了，跟哥哥关系这么好的你，肯定也很厉害！</size></color>",
		false,
		""
	},
	{
		17011,
		3,
		17,
		"收藏品",
		0,
		14002,
		{
			-70,
			-200
		},
		{
			-0.9,
			0.9
		},
		"<color=#556fb5><size=24>哥哥最厉害了，跟哥哥关系这么好的你，肯定也很厉害！</size></color>",
		false,
		""
	},
	{
		17011,
		4,
		17,
		"钻石",
		0,
		14002,
		{
			-70,
			-200
		},
		{
			-0.9,
			0.9
		},
		"<color=#556fb5><size=24>哥哥最厉害了，跟哥哥关系这么好的你，肯定也很厉害！</size></color>",
		false,
		""
	},
	{
		17015,
		1,
		17,
		"精灵",
		0,
		14003,
		{
			-10,
			-125
		},
		{
			-0.7,
			0.7
		},
		"<color=#556fb5><size=24>嘿嘿，遇见你真开心！</size></color>",
		false,
		""
	},
	{
		17015,
		2,
		17,
		"装备/星神",
		0,
		14003,
		{
			-10,
			-125
		},
		{
			-0.7,
			0.7
		},
		"<color=#556fb5><size=24>嘿嘿，遇见你真开心！</size></color>",
		false,
		""
	},
	{
		17015,
		3,
		17,
		"收藏品",
		0,
		14003,
		{
			-10,
			-125
		},
		{
			-0.7,
			0.7
		},
		"<color=#556fb5><size=24>嘿嘿，遇见你真开心！</size></color>",
		false,
		""
	},
	{
		17018,
		1,
		17,
		"精灵",
		0,
		0,
		nil,
		nil,
		"",
		false,
		""
	},
	{
		17018,
		2,
		17,
		"精灵养成",
		0,
		0,
		nil,
		nil,
		"",
		false,
		""
	},
	{
		17018,
		3,
		17,
		"个性装扮",
		0,
		0,
		nil,
		nil,
		"",
		false,
		""
	},
	{
		17019,
		1,
		17,
		"精灵",
		0,
		0,
		nil,
		nil,
		"",
		false,
		""
	},
	{
		17019,
		2,
		17,
		"精灵养成",
		0,
		0,
		nil,
		nil,
		"",
		false,
		""
	},
	{
		17019,
		3,
		17,
		"个性装扮",
		0,
		0,
		nil,
		nil,
		"",
		false,
		""
	}
}
local t_activity_reward_page = {
	[17011] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	[17015] = {
		dataList[5],
		dataList[6],
		dataList[7]
	},
	[17018] = {
		dataList[8],
		dataList[9],
		dataList[10]
	},
	[17019] = {
		dataList[11],
		dataList[12],
		dataList[13]
	}
}

t_activity_reward_page.dataList = dataList

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

return t_activity_reward_page
