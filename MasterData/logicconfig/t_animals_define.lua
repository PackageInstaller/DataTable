-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_animals_define.lua

module("logicconfig.config.t_animals_define", package.seeall)

local title = {
	isOnline = 3,
	name = 2,
	talk = 6,
	activateItem = 4,
	bubblePos2 = 8,
	modelId = 5,
	defineId = 1,
	bubblePos1 = 7
}
local dataList = {
	{
		1,
		"猪猪",
		true,
		"",
		3,
		"哼哼~"
	},
	{
		2,
		"洛世琦",
		true,
		"4:150001:1",
		9,
		"想被我调教吗？嗯~",
		{
			120,
			120
		},
		{
			60,
			80
		}
	},
	{
		3,
		"快乐柠檬",
		true,
		"4:130001:1",
		10,
		"lemon~lemon~"
	},
	{
		4,
		"潘多拉",
		true,
		"4:170001:1",
		11,
		"主人，能带我回家吗？",
		{
			120,
			120
		},
		{
			60,
			80
		}
	},
	{
		5,
		"末炎",
		true,
		"4:190001:1",
		12,
		"想每天看我穿裙子吗？嗯~",
		{
			120,
			120
		},
		{
			60,
			80
		}
	},
	{
		6,
		"诺雅",
		true,
		"4:210001:1",
		13,
		"诺雅能与你同行吗？",
		{
			120,
			120
		},
		{
			60,
			80
		}
	},
	{
		7,
		"冯宝宝",
		true,
		"4:230001:1",
		14,
		"从今天开始，我就是你的主人~",
		{
			120,
			120
		},
		{
			60,
			80
		}
	},
	{
		8,
		"小幽灵",
		true,
		"4:250001:1",
		15,
		"你有糖果吗？",
		{
			120,
			120
		},
		{
			60,
			80
		}
	},
	{
		9,
		"茜茜",
		true,
		"4:270001:1",
		16,
		"要尝尝我做的美食吗？",
		{
			120,
			120
		},
		{
			60,
			80
		}
	},
	{
		10,
		"伊丽莎白",
		true,
		"4:290001:1",
		17,
		"要来花园里看看嘛？",
		{
			120,
			120
		},
		{
			60,
			80
		}
	},
	{
		11,
		"修尔",
		true,
		"4:290002:1",
		18,
		"拥有同伴是什么感觉？",
		{
			120,
			120
		},
		{
			60,
			80
		}
	},
	{
		12,
		"冰灵王",
		true,
		"4:290003:1",
		19,
		"有我陪着你，你不会孤单的。",
		{
			120,
			120
		},
		{
			60,
			80
		}
	},
	{
		13,
		"彩灯",
		true,
		"4:290004:1",
		20,
		"你也想被我照亮吗？",
		{
			120,
			120
		},
		{
			60,
			80
		}
	},
	{
		14,
		"阿瑞斯",
		true,
		"4:290005:1",
		21,
		"是有什么好吃的在等着我吗？",
		{
			120,
			120
		},
		{
			60,
			80
		}
	}
}
local t_animals_define = {
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
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14]
}

t_animals_define.dataList = dataList

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

return t_animals_define
