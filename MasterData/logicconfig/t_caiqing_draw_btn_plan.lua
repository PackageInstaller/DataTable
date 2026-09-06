-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_caiqing_draw_btn_plan.lua

module("logicconfig.config.t_caiqing_draw_btn_plan", package.seeall)

local title = {
	gotoStr = 3,
	btnPlanId = 1,
	showTxt = 5,
	picPath = 7,
	id = 2,
	rpIds = 4,
	pos = 6,
	picPos = 8
}
local dataList = {
	{
		1,
		1,
		"func#690",
		"351",
		"生日口令",
		{
			-341,
			-80
		},
		"views/huodong/xiaonuogifbox/btn_xiaonuoshengrihui_05",
		{
			5,
			99.4
		}
	},
	{
		1,
		2,
		"push_story#4820032",
		"c51",
		"章节:过往",
		{
			-130.7,
			-17
		},
		"views/huodong/xiaonuogifbox/btn_xiaonuoshengrihui_08",
		{
			5,
			99.4
		}
	},
	{
		1,
		3,
		"func#1289",
		"",
		"源起福利",
		{
			80,
			-140
		},
		"views/huodong/xiaonuogifbox/btn_xiaonuoshengrihui_06",
		{
			5,
			99.4
		}
	},
	{
		2,
		1,
		"func#690",
		"351",
		"生日口令",
		{
			-341,
			-80
		},
		"views/huodong/xiaonuogifbox/btn_xiaonuoshengrihui_05",
		{
			5,
			99.4
		}
	},
	{
		2,
		2,
		"push_story#4820033",
		"c51",
		"章节:此刻",
		{
			-130.7,
			-17
		},
		"views/huodong/xiaonuogifbox/btn_xiaonuoshengrihui_07",
		{
			5,
			99.4
		}
	},
	{
		2,
		3,
		"func#1289",
		"",
		"源起福利",
		{
			80,
			-140
		},
		"views/huodong/xiaonuogifbox/btn_xiaonuoshengrihui_03",
		{
			5,
			99.4
		}
	},
	{
		3,
		1,
		"func#690",
		"351",
		"生日口令",
		{
			-341,
			-80
		},
		"views/huodong/xiaonuogifbox/btn_xiaonuoshengrihui_05",
		{
			5,
			99.4
		}
	},
	{
		3,
		2,
		"push_story#4820034",
		"c51",
		"章节:未来",
		{
			-130.7,
			-17
		},
		"views/huodong/xiaonuogifbox/btn_xiaonuoshengrihui_02",
		{
			5,
			99.4
		}
	},
	{
		3,
		3,
		"func#1289",
		"",
		"源起福利",
		{
			80,
			-140
		},
		"views/huodong/xiaonuogifbox/btn_xiaonuoshengrihui_06",
		{
			5,
			99.4
		}
	},
	{
		4,
		1,
		"func#690",
		"351",
		"生日口令",
		{
			-341,
			-80
		},
		"views/huodong/xiaonuogifbox/btn_xiaonuoshengrihui_05",
		{
			5,
			99.4
		}
	},
	{
		4,
		2,
		"push_story#4820035",
		"c51",
		"章节:陪伴",
		{
			-130.7,
			-17
		},
		"views/huodong/xiaonuogifbox/btn_xiaonuoshengrihui_01",
		{
			5,
			99.4
		}
	},
	{
		4,
		3,
		"func#1289",
		"",
		"源起福利",
		{
			80,
			-140
		},
		"views/huodong/xiaonuogifbox/btn_xiaonuoshengrihui_03",
		{
			5,
			99.4
		}
	}
}
local t_caiqing_draw_btn_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9]
	},
	{
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_caiqing_draw_btn_plan.dataList = dataList

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

return t_caiqing_draw_btn_plan
