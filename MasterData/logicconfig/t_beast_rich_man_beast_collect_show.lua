-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_beast_rich_man_beast_collect_show.lua

module("logicconfig.config.t_beast_rich_man_beast_collect_show", package.seeall)

local title = {
	dealParam = 4,
	pos = 6,
	showPicPath = 5,
	id = 2,
	activityId = 1,
	dealType = 3
}
local dataList = {
	{
		558001,
		1,
		2,
		"1",
		"ui/bigbg/game/beastrichman/board_ruishoudamaoxian30",
		{
			314,
			10
		}
	},
	{
		558001,
		2,
		2,
		"2",
		"ui/bigbg/game/beastrichman/board_ruishoudamaoxian32",
		{
			-446,
			125
		}
	},
	{
		558001,
		3,
		2,
		"3",
		"ui/bigbg/game/beastrichman/board_ruishoudamaoxian34",
		{
			-298,
			-62
		}
	},
	{
		558001,
		4,
		3,
		"1",
		"ui/bigbg/game/beastrichman/board_ruishoudamaoxian36",
		{
			-638,
			-183
		}
	},
	{
		558001,
		5,
		3,
		"2",
		"ui/bigbg/game/beastrichman/board_ruishoudamaoxian31",
		{
			520,
			-179
		}
	},
	{
		558001,
		6,
		3,
		"3",
		"ui/bigbg/game/beastrichman/board_ruishoudamaoxian33",
		{
			-57,
			40
		}
	},
	{
		558001,
		7,
		3,
		"4",
		"ui/bigbg/game/beastrichman/board_ruishoudamaoxian35",
		{
			-181,
			-151
		}
	},
	{
		558001,
		8,
		1,
		"558004",
		"lang/zh/atlassource/ui/views2/game/beastrichmangame/board_ruishoudamaoxian16",
		{
			-199,
			258
		}
	},
	{
		558001,
		9,
		1,
		"558005",
		"lang/zh/atlassource/ui/views2/game/beastrichmangame/board_ruishoudamaoxian17",
		{
			-130,
			258
		}
	},
	{
		558001,
		10,
		1,
		"558006",
		"lang/zh/atlassource/ui/views2/game/beastrichmangame/board_ruishoudamaoxian18",
		{
			-64,
			258
		}
	},
	{
		558001,
		11,
		1,
		"558007",
		"lang/zh/atlassource/ui/views2/game/beastrichmangame/board_ruishoudamaoxian19",
		{
			-1,
			258
		}
	},
	{
		558001,
		12,
		1,
		"558008",
		"lang/zh/atlassource/ui/views2/game/beastrichmangame/board_ruishoudamaoxian20",
		{
			68,
			259
		}
	},
	{
		558001,
		13,
		1,
		"558009",
		"lang/zh/atlassource/ui/views2/game/beastrichmangame/board_ruishoudamaoxian21",
		{
			132,
			259
		}
	},
	{
		558001,
		14,
		1,
		"558010",
		"lang/zh/atlassource/ui/views2/game/beastrichmangame/board_ruishoudamaoxian22",
		{
			202,
			259
		}
	},
	{
		558001,
		15,
		1,
		"558011",
		"lang/zh/atlassource/ui/views2/game/beastrichmangame/board_ruishoudamaoxian23",
		{
			-109,
			194
		}
	},
	{
		558001,
		16,
		1,
		"558012",
		"lang/zh/atlassource/ui/views2/game/beastrichmangame/board_ruishoudamaoxian24",
		{
			-42,
			194
		}
	},
	{
		558001,
		17,
		1,
		"558013",
		"lang/zh/atlassource/ui/views2/game/beastrichmangame/board_ruishoudamaoxian25",
		{
			28,
			197
		}
	},
	{
		558001,
		18,
		1,
		"558014",
		"lang/zh/atlassource/ui/views2/game/beastrichmangame/board_ruishoudamaoxian26",
		{
			91,
			196
		}
	},
	{
		558001,
		19,
		1,
		"558015",
		"lang/zh/atlassource/ui/views2/game/beastrichmangame/board_ruishoudamaoxian27",
		{
			160,
			193
		}
	},
	{
		558001,
		20,
		1,
		"558016",
		"lang/zh/atlassource/ui/views2/game/beastrichmangame/board_ruishoudamaoxian28",
		{
			224,
			196
		}
	},
	{
		558001,
		21,
		1,
		"558017",
		"lang/zh/atlassource/ui/views2/game/beastrichmangame/board_ruishoudamaoxian29",
		{
			292,
			196
		}
	}
}
local t_beast_rich_man_beast_collect_show = {
	[558001] = {
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
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21]
	}
}

t_beast_rich_man_beast_collect_show.dataList = dataList

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

return t_beast_rich_man_beast_collect_show
