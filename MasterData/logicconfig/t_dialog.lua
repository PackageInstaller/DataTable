-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dialog.lua

module("logicconfig.config.t_dialog", package.seeall)

local title = {
	bgPos = 9,
	name = 3,
	fingerPos = 8,
	desc = 4,
	skip = 12,
	textPos = 6,
	path = 5,
	paragraph = 2,
	speed = 11,
	next = 7,
	id = 1,
	bgWH = 10
}
local dataList = {
	{
		1,
		1,
		"小诺",
		"相信各位小奥奇在今年遇到了许多喜爱的精灵和皮肤",
		"xxjbp_role_3",
		{
			0,
			0,
			0
		},
		0,
		nil,
		{
			0,
			0,
			0
		},
		{
			0,
			0
		},
		20,
		false
	},
	{
		1,
		2,
		"小诺",
		"现在快来为ta们投票，选出你们最喜爱的ta吧~",
		"xxjbp_role_3",
		{
			0,
			0,
			0
		},
		0,
		nil,
		{
			0,
			0,
			0
		},
		{
			0,
			0
		},
		20,
		false
	},
	{
		1,
		3,
		"小诺",
		"如果有喜欢的皮肤风格、适配精灵，也可以手动填写，我们会认真参考你们提交的意见噢！",
		"xxjbp_role_3",
		{
			0,
			0,
			0
		},
		2,
		nil,
		{
			0,
			0,
			0
		},
		{
			0,
			0
		},
		20,
		false
	},
	{
		1,
		4,
		"小诺",
		"如果有想在后续版本遇见的精灵、想源起的精灵，就快来为他们投票吧~",
		"xxjbp_role_3",
		{
			0,
			0,
			0
		},
		2,
		nil,
		{
			0,
			0,
			0
		},
		{
			0,
			0
		},
		20,
		false
	},
	{
		2,
		1,
		"小诺",
		"来为皮肤投票吧！每次投票都可以获得奖励哦",
		"xxjbp_role_3",
		{
			0,
			0,
			0
		},
		0,
		nil,
		{
			0,
			0,
			0
		},
		{
			0,
			0
		},
		20,
		true
	},
	{
		3,
		1,
		"大橙子",
		"为你心仪的画师投票吧~\r\n我们将让人气最高的画师，负责人气最高的精灵皮肤绘制！",
		"xxjbp_role_1",
		{
			0,
			0,
			0
		},
		0,
		nil,
		{
			0,
			0,
			0
		},
		{
			0,
			0
		},
		20,
		true
	},
	{
		4,
		1,
		"大橙子",
		"最近发现搞擦边球被整治的国内比日本还暴露，感觉审核被批的太惨了",
		"xxjbp_role_1",
		{
			0,
			0,
			0
		},
		0,
		nil,
		{
			0,
			0,
			0
		},
		{
			0,
			0
		},
		20,
		true
	},
	{
		5,
		1,
		"念念",
		"远古奥奇，你来了\r\n我正好要打造一批崭新的装备，快来帮忙",
		"xxjbp_role_2",
		{
			0,
			0,
			0
		},
		0,
		nil,
		{
			0,
			0,
			0
		},
		{
			0,
			0
		},
		20,
		true
	},
	{
		5,
		2,
		"念念",
		"我需要收集进度点，用来升级打造炉",
		"xxjbp_role_2",
		{
			0,
			0,
			0
		},
		0,
		nil,
		{
			0,
			0,
			0
		},
		{
			0,
			0
		},
		20,
		true
	},
	{
		5,
		3,
		"念念",
		"当然，我不会让你白干活，升级成功之后你可以获得【火系橙+1自选*1】作为报酬，快和我一起出发吧",
		"xxjbp_role_2",
		{
			0,
			0,
			0
		},
		0,
		nil,
		{
			0,
			0,
			0
		},
		{
			0,
			0
		},
		20,
		true
	},
	{
		6,
		1,
		"念念",
		"内容于对话框表配置",
		"xxjbp_role_3",
		{
			0,
			0,
			0
		},
		0,
		nil,
		{
			0,
			0,
			0
		},
		{
			0,
			0
		},
		21,
		true
	}
}
local t_dialog = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5]
	},
	{
		dataList[6]
	},
	{
		dataList[7]
	},
	{
		dataList[8],
		dataList[9],
		dataList[10]
	},
	{
		dataList[11]
	}
}

t_dialog.dataList = dataList

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

return t_dialog
