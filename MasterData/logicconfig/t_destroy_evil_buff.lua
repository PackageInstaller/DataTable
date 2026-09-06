-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_destroy_evil_buff.lua

module("logicconfig.config.t_destroy_evil_buff", package.seeall)

local title = {
	des = 3,
	buffPlanId = 1,
	days = 2
}
local dataList = {
	{
		1,
		1,
		{
			"14017,14018",
			" <color=#20B376FF>精灵属性+20%</color>"
		}
	},
	{
		1,
		2,
		{
			"14017,14018",
			" <color=#20B376FF>精灵属性+20%</color>"
		}
	},
	{
		1,
		3,
		{
			"14017,14018",
			" <color=#20B376FF>精灵属性+20%</color>"
		}
	},
	{
		1,
		4,
		{
			"14017,14018",
			" <color=#20B376FF>精灵属性+20%</color>"
		}
	},
	{
		1,
		5,
		{
			"14017,14018",
			" <color=#20B376FF>精灵属性+20%</color>"
		}
	},
	{
		1,
		6,
		{
			"14017,14018",
			" <color=#20B376FF>精灵属性+20%</color>"
		}
	},
	{
		1,
		7,
		{
			"14017,14018",
			" <color=#20B376FF>精灵属性+20%</color>"
		}
	},
	{
		2,
		1,
		{
			"16025,12022",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		2,
		2,
		{
			"16025,12022",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		2,
		3,
		{
			"16025,12022",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		2,
		4,
		{
			"16025,12022",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		2,
		5,
		{
			"16025,12022",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		2,
		6,
		{
			"16025,12022",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		2,
		7,
		{
			"16025,12022",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		2,
		8,
		{
			"13019,14025",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		2,
		9,
		{
			"13019,14025",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		2,
		10,
		{
			"13019,14025",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		2,
		11,
		{
			"13019,14025",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		2,
		12,
		{
			"13019,14025",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		2,
		13,
		{
			"13019,14025",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		2,
		14,
		{
			"13019,14025",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		2,
		15,
		{
			"11024",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		2,
		16,
		{
			"11024",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		2,
		17,
		{
			"11024",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		2,
		18,
		{
			"11024",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		2,
		19,
		{
			"11024",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		2,
		20,
		{
			"11024",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		2,
		21,
		{
			"11024",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		2,
		22,
		{
			"15025",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		2,
		23,
		{
			"15025",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		2,
		24,
		{
			"15025",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		2,
		25,
		{
			"15025",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		2,
		26,
		{
			"15025",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		2,
		27,
		{
			"15025",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		2,
		28,
		{
			"15025",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		3,
		1,
		{
			"12039",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		3,
		2,
		{
			"12039",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		3,
		3,
		{
			"12039",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		3,
		4,
		{
			"12039",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		3,
		5,
		{
			"12039",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		3,
		6,
		{
			"12039",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		3,
		7,
		{
			"12039",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		3,
		8,
		{
			"12039,14043",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		3,
		9,
		{
			"12039,14043",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		3,
		10,
		{
			"12039,14043",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		3,
		11,
		{
			"12039,14043",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		3,
		12,
		{
			"12039,14043",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		3,
		13,
		{
			"12039,14043",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		3,
		14,
		{
			"12039,14043",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		3,
		15,
		{
			"12039,14043",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		3,
		16,
		{
			"12039,14043",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		3,
		17,
		{
			"12039,14043",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		3,
		18,
		{
			"12039,14043",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		3,
		19,
		{
			"12039,14043",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		3,
		20,
		{
			"12039,14043",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		3,
		21,
		{
			"12039,14043",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		3,
		22,
		{
			"12039,14043",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		3,
		23,
		{
			"12039,14043",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		3,
		24,
		{
			"12039,14043",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		3,
		25,
		{
			"12039,14043",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		3,
		26,
		{
			"12039,14043",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		3,
		27,
		{
			"12039,14043",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	},
	{
		3,
		28,
		{
			"12039,14043",
			" <color=#50B376FF>精灵属性+50%</color>"
		}
	}
}
local t_destroy_evil_buff = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	{
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26],
		dataList[27],
		dataList[28],
		dataList[29],
		dataList[30],
		dataList[31],
		dataList[32],
		dataList[33],
		dataList[34],
		dataList[35]
	},
	{
		dataList[36],
		dataList[37],
		dataList[38],
		dataList[39],
		dataList[40],
		dataList[41],
		dataList[42],
		dataList[43],
		dataList[44],
		dataList[45],
		dataList[46],
		dataList[47],
		dataList[48],
		dataList[49],
		dataList[50],
		dataList[51],
		dataList[52],
		dataList[53],
		dataList[54],
		dataList[55],
		dataList[56],
		dataList[57],
		dataList[58],
		dataList[59],
		dataList[60],
		dataList[61],
		dataList[62],
		dataList[63]
	}
}

t_destroy_evil_buff.dataList = dataList

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

return t_destroy_evil_buff
