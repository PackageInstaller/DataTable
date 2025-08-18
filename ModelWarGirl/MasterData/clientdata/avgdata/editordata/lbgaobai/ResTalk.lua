-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\LBgaobai\\ResTalk.lua

local indexMap = {
	id = 1,
	npc_id = 6,
	bg_blur = 10,
	play_delay = 14,
	scenery_id = 13,
	section = 4,
	clear_role = 15,
	bgm = 12,
	vocal = 11,
	bg_voice = 18,
	terminal_type = 27,
	extra_npc = 21,
	hide_name = 22,
	talk_in_ani = 24,
	terminal_effect = 25,
	page = 5,
	talk_type = 2,
	head_emoji = 9,
	action = 7,
	switch_show = 17,
	font_size = 23,
	terminal_bg = 26,
	bg_id = 19,
	mask_alpha = 20,
	special_effect = 28,
	talk = 3,
	branch_info = 29,
	switch_effect = 16,
	show_head = 8
}
local indexMapResTalkAction = {
	emoji = 5,
	pos = 1,
	action = 3,
	npc_id = 2,
	show = 4
}
local RTResTalkAction = {}

RTResTalkAction[1] = {
	1,
	1290,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 1290
}
RTResTalkAction[3] = {
	1,
	1290,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[4] = {
	1,
	1290,
	nil,
	nil,
	0
}
RTResTalkAction[5] = {
	1,
	1290,
	nil,
	nil,
	2
}
RTResTalkAction[6] = {
	[1] = 1,
	[2] = 1290,
	[3] = {
		0
	}
}
RTResTalkAction[7] = {
	[1] = 1,
	[2] = 1289,
	[3] = {
		1
	}
}
RTResTalkAction[8] = {
	[1] = 1,
	[2] = 1289
}
RTResTalkAction[9] = {
	1,
	1289,
	nil,
	nil,
	1
}
RTResTalkAction[10] = {
	1,
	1289,
	nil,
	nil,
	0
}
RTResTalkAction[11] = {
	1,
	1289,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[12] = {
	1,
	1289,
	{
		1
	},
	nil,
	3
}

local Data = {
	[41101001] = {
		41101001,
		0,
		Lang.get(109662),
		41101,
		1,
		1290,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3,
		nil,
		62,
		41101,
		nil,
		nil,
		nil,
		nil,
		nil,
		41101
	},
	[41101002] = {
		41101002,
		4,
		nil,
		41101,
		2,
		300,
		{
			RTResTalkAction[2]
		},
		[29] = {
			{
				id = 41101003,
				branch_content = Lang.get(109663)
			},
			{
				id = 41101003,
				branch_content = Lang.get(109664)
			}
		}
	},
	[41101003] = {
		41101003,
		0,
		"……？",
		41101,
		3,
		1290,
		{
			RTResTalkAction[2]
		}
	},
	[41101004] = {
		41101004,
		0,
		Lang.get(109665),
		41101,
		4,
		1290,
		{
			RTResTalkAction[2]
		}
	},
	[41101005] = {
		41101005,
		0,
		Lang.get(109666),
		41101,
		5,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[41101006] = {
		41101006,
		0,
		Lang.get(109667),
		41101,
		6,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[41101007] = {
		41101007,
		0,
		Lang.get(109668),
		41101,
		7,
		1290,
		{
			RTResTalkAction[2]
		}
	},
	[41101008] = {
		41101008,
		0,
		Lang.get(109669),
		41101,
		8,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[41101009] = {
		41101009,
		0,
		Lang.get(109670),
		41101,
		9,
		1290,
		{
			RTResTalkAction[2]
		}
	},
	[41101010] = {
		41101010,
		0,
		Lang.get(109671),
		41101,
		10,
		1290,
		{
			RTResTalkAction[2]
		}
	},
	[41101011] = {
		41101011,
		0,
		Lang.get(109672),
		41101,
		11,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[41101012] = {
		41101012,
		0,
		Lang.get(109673),
		41101,
		12,
		1290,
		{
			RTResTalkAction[2]
		}
	},
	[41101013] = {
		41101013,
		0,
		Lang.get(109674),
		41101,
		13,
		1290,
		{
			RTResTalkAction[3]
		}
	},
	[41101014] = {
		41101014,
		0,
		Lang.get(19646),
		41101,
		14,
		300,
		{
			RTResTalkAction[4]
		}
	},
	[41101015] = {
		41101015,
		0,
		Lang.get(109675),
		41101,
		15,
		300,
		{
			RTResTalkAction[4]
		}
	},
	[41101016] = {
		41101016,
		0,
		Lang.get(109676),
		41101,
		16,
		1290,
		{
			RTResTalkAction[2]
		}
	},
	[41101017] = {
		41101017,
		0,
		Lang.get(109677),
		41101,
		17,
		1290,
		{
			RTResTalkAction[2]
		}
	},
	[41101018] = {
		41101018,
		0,
		Lang.get(109678),
		41101,
		18,
		1290,
		{
			RTResTalkAction[2]
		}
	},
	[41101019] = {
		41101019,
		0,
		Lang.get(109679),
		41101,
		19,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[41102001] = {
		41102001,
		0,
		Lang.get(109680),
		41102,
		1,
		1290,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3,
		nil,
		62,
		41102,
		nil,
		nil,
		nil,
		nil,
		nil,
		41102
	},
	[41102002] = {
		41102002,
		0,
		Lang.get(109681),
		41102,
		2,
		1290,
		{
			RTResTalkAction[5]
		}
	},
	[41102003] = {
		41102003,
		4,
		nil,
		41102,
		3,
		300,
		{
			RTResTalkAction[4]
		},
		[29] = {
			{
				id = 41102004,
				branch_content = Lang.get(109682)
			},
			{
				id = 41102004,
				branch_content = Lang.get(109683)
			}
		}
	},
	[41102004] = {
		41102004,
		0,
		Lang.get(109684),
		41102,
		4,
		1290,
		{
			RTResTalkAction[4]
		}
	},
	[41102005] = {
		41102005,
		0,
		Lang.get(109685),
		41102,
		5,
		1290,
		{
			RTResTalkAction[2]
		}
	},
	[41102006] = {
		41102006,
		0,
		Lang.get(109686),
		41102,
		6,
		1290,
		{
			RTResTalkAction[2]
		}
	},
	[41102007] = {
		41102007,
		0,
		Lang.get(109687),
		41102,
		7,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[41102008] = {
		41102008,
		0,
		Lang.get(109688),
		41102,
		8,
		1290,
		{
			RTResTalkAction[2]
		}
	},
	[41102009] = {
		41102009,
		0,
		Lang.get(109689),
		41102,
		9,
		1290,
		{
			RTResTalkAction[2]
		}
	},
	[41102010] = {
		41102010,
		0,
		Lang.get(109690),
		41102,
		10,
		1290,
		{
			RTResTalkAction[2]
		}
	},
	[41102011] = {
		41102011,
		0,
		Lang.get(109691),
		41102,
		11,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[41102012] = {
		41102012,
		0,
		Lang.get(109692),
		41102,
		12,
		1290,
		{
			RTResTalkAction[2]
		}
	},
	[41102013] = {
		41102013,
		0,
		Lang.get(109693),
		41102,
		13,
		1290,
		{
			RTResTalkAction[2]
		}
	},
	[41102014] = {
		41102014,
		0,
		Lang.get(109694),
		41102,
		14,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[41102015] = {
		41102015,
		0,
		Lang.get(109695),
		41102,
		15,
		1290,
		{
			RTResTalkAction[2]
		}
	},
	[41102016] = {
		41102016,
		0,
		Lang.get(100686),
		41102,
		16,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[41102017] = {
		41102017,
		0,
		Lang.get(109696),
		41102,
		17,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[41103001] = {
		41103001,
		0,
		Lang.get(109697),
		41103,
		1,
		1290,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3,
		nil,
		62,
		41103,
		nil,
		nil,
		nil,
		nil,
		nil,
		41103
	},
	[41103002] = {
		41103002,
		0,
		Lang.get(109698),
		41103,
		2,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[41103003] = {
		41103003,
		0,
		Lang.get(109699),
		41103,
		3,
		1290,
		{
			RTResTalkAction[2]
		}
	},
	[41103004] = {
		41103004,
		0,
		Lang.get(109700),
		41103,
		4,
		1290,
		{
			RTResTalkAction[3]
		}
	},
	[41103005] = {
		41103005,
		0,
		Lang.get(109701),
		41103,
		5,
		300,
		{
			RTResTalkAction[4]
		}
	},
	[41103006] = {
		41103006,
		0,
		Lang.get(109702),
		41103,
		6,
		1290,
		{
			RTResTalkAction[4]
		}
	},
	[41103007] = {
		41103007,
		0,
		Lang.get(109703),
		41103,
		7,
		1290,
		{
			RTResTalkAction[6]
		}
	},
	[41103008] = {
		41103008,
		4,
		nil,
		41103,
		8,
		300,
		{
			RTResTalkAction[2]
		},
		[29] = {
			{
				id = 41103009,
				branch_content = Lang.get(109704)
			},
			{
				id = 41103009,
				branch_content = Lang.get(109705)
			}
		}
	},
	[41103009] = {
		41103009,
		0,
		Lang.get(109706),
		41103,
		9,
		1290,
		{
			RTResTalkAction[2]
		}
	},
	[41103010] = {
		41103010,
		0,
		Lang.get(109707),
		41103,
		10,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[41103011] = {
		41103011,
		0,
		Lang.get(109708),
		41103,
		11,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[41103012] = {
		41103012,
		0,
		Lang.get(109709),
		41103,
		12,
		1290,
		{
			RTResTalkAction[3]
		}
	},
	[41103013] = {
		41103013,
		0,
		Lang.get(109710),
		41103,
		13,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[41103014] = {
		41103014,
		0,
		Lang.get(109711),
		41103,
		14,
		1290,
		{
			RTResTalkAction[2]
		}
	},
	[41103015] = {
		41103015,
		0,
		Lang.get(109712),
		41103,
		15,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[41104001] = {
		41104001,
		0,
		Lang.get(109713),
		41104,
		1,
		1289,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3,
		nil,
		62,
		41104,
		nil,
		nil,
		nil,
		nil,
		nil,
		41104
	},
	[41104002] = {
		41104002,
		0,
		Lang.get(109714),
		41104,
		2,
		300,
		{
			RTResTalkAction[8]
		}
	},
	[41104003] = {
		41104003,
		0,
		Lang.get(109715),
		41104,
		3,
		1289,
		{
			RTResTalkAction[8]
		}
	},
	[41104004] = {
		41104004,
		0,
		Lang.get(87656),
		41104,
		4,
		300,
		{
			RTResTalkAction[8]
		}
	},
	[41104005] = {
		41104005,
		0,
		Lang.get(109716),
		41104,
		5,
		1289,
		{
			RTResTalkAction[9]
		}
	},
	[41104006] = {
		41104006,
		0,
		Lang.get(109717),
		41104,
		6,
		1289,
		{
			RTResTalkAction[9]
		}
	},
	[41104007] = {
		41104007,
		0,
		Lang.get(109718),
		41104,
		7,
		1289,
		{
			RTResTalkAction[10]
		}
	},
	[41104008] = {
		41104008,
		4,
		nil,
		41104,
		8,
		300,
		{
			RTResTalkAction[10]
		},
		[29] = {
			{
				id = 41104009,
				branch_content = Lang.get(109719)
			},
			{
				id = 41104009,
				branch_content = Lang.get(109720)
			}
		}
	},
	[41104009] = {
		41104009,
		0,
		Lang.get(108043),
		41104,
		9,
		1289,
		{
			RTResTalkAction[11]
		}
	},
	[41104010] = {
		41104010,
		0,
		Lang.get(109721),
		41104,
		10,
		1289,
		{
			RTResTalkAction[10]
		}
	},
	[41104011] = {
		41104011,
		0,
		Lang.get(109722),
		41104,
		11,
		300,
		{
			RTResTalkAction[8]
		}
	},
	[41104012] = {
		41104012,
		0,
		Lang.get(109723),
		41104,
		12,
		300,
		{
			RTResTalkAction[8]
		}
	},
	[41104013] = {
		41104013,
		0,
		Lang.get(109724),
		41104,
		13,
		1289,
		{
			RTResTalkAction[8]
		}
	},
	[41104014] = {
		41104014,
		0,
		Lang.get(109725),
		41104,
		14,
		1289,
		{
			RTResTalkAction[8]
		}
	},
	[41104015] = {
		41104015,
		0,
		Lang.get(109726),
		41104,
		15,
		1289,
		{
			RTResTalkAction[8]
		}
	},
	[41104016] = {
		41104016,
		0,
		Lang.get(109727),
		41104,
		16,
		300,
		{
			RTResTalkAction[8]
		}
	},
	[41104017] = {
		41104017,
		0,
		Lang.get(108043),
		41104,
		17,
		1289,
		{
			RTResTalkAction[8]
		}
	},
	[41104018] = {
		41104018,
		0,
		Lang.get(109728),
		41104,
		18,
		1289,
		{
			RTResTalkAction[11]
		}
	},
	[41105001] = {
		41105001,
		0,
		"3——2——1——",
		41105,
		1,
		1289,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3,
		nil,
		62,
		41105,
		nil,
		nil,
		nil,
		nil,
		nil,
		41105
	},
	[41105002] = {
		41105002,
		5,
		Lang.get(109729),
		41105,
		2,
		1289,
		{
			RTResTalkAction[11]
		}
	},
	[41105003] = {
		41105003,
		0,
		Lang.get(109730),
		41105,
		3,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[41105004] = {
		41105004,
		0,
		Lang.get(109731),
		41105,
		4,
		1289,
		{
			RTResTalkAction[10]
		}
	},
	[41105005] = {
		41105005,
		3,
		Lang.get(109732),
		41105,
		5,
		605,
		{
			RTResTalkAction[8]
		},
		[22] = 1
	},
	[41105006] = {
		41105006,
		0,
		Lang.get(109733),
		41105,
		6,
		1289,
		{
			RTResTalkAction[12]
		}
	},
	[41105007] = {
		41105007,
		4,
		nil,
		41105,
		7,
		300,
		{
			RTResTalkAction[8]
		},
		[29] = {
			{
				id = 41105008,
				branch_content = Lang.get(109734)
			},
			{
				id = 41105008,
				branch_content = Lang.get(109735)
			}
		}
	},
	[41105008] = {
		41105008,
		0,
		Lang.get(109736),
		41105,
		8,
		1289,
		{
			RTResTalkAction[8]
		}
	},
	[41105009] = {
		41105009,
		0,
		Lang.get(109737),
		41105,
		9,
		300,
		{
			RTResTalkAction[8]
		}
	},
	[41105010] = {
		41105010,
		0,
		Lang.get(109738),
		41105,
		10,
		1289,
		{
			RTResTalkAction[8]
		}
	},
	[41105011] = {
		41105011,
		0,
		Lang.get(109739),
		41105,
		11,
		300,
		{
			RTResTalkAction[8]
		}
	},
	[41105012] = {
		41105012,
		0,
		Lang.get(109740),
		41105,
		12,
		1289,
		{
			RTResTalkAction[11]
		}
	},
	[41105013] = {
		41105013,
		0,
		Lang.get(109741),
		41105,
		13,
		300,
		{
			RTResTalkAction[9]
		}
	},
	[41105014] = {
		41105014,
		0,
		Lang.get(109742),
		41105,
		14,
		300,
		{
			RTResTalkAction[9]
		}
	},
	[41105015] = {
		41105015,
		0,
		Lang.get(109743),
		41105,
		15,
		1289,
		{
			RTResTalkAction[8]
		}
	},
	[41105016] = {
		41105016,
		0,
		Lang.get(109744),
		41105,
		16,
		1289,
		{
			RTResTalkAction[10]
		}
	},
	[41106001] = {
		41106001,
		0,
		Lang.get(109745),
		41106,
		1,
		1289,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3,
		nil,
		62,
		41106,
		nil,
		nil,
		nil,
		nil,
		nil,
		41106
	},
	[41106002] = {
		41106002,
		0,
		Lang.get(109746),
		41106,
		2,
		300,
		{
			RTResTalkAction[8]
		}
	},
	[41106003] = {
		41106003,
		0,
		Lang.get(109747),
		41106,
		3,
		300,
		{
			RTResTalkAction[8]
		}
	},
	[41106004] = {
		41106004,
		0,
		Lang.get(109748),
		41106,
		4,
		1289,
		{
			RTResTalkAction[12]
		}
	},
	[41106005] = {
		41106005,
		0,
		Lang.get(109749),
		41106,
		5,
		1289,
		{
			RTResTalkAction[9]
		}
	},
	[41106006] = {
		41106006,
		0,
		Lang.get(109750),
		41106,
		6,
		300,
		{
			RTResTalkAction[8]
		}
	},
	[41106007] = {
		41106007,
		0,
		Lang.get(109751),
		41106,
		7,
		1289,
		{
			RTResTalkAction[8]
		}
	},
	[41106008] = {
		41106008,
		0,
		Lang.get(109752),
		41106,
		8,
		1289,
		{
			RTResTalkAction[8]
		}
	},
	[41106009] = {
		41106009,
		0,
		Lang.get(109753),
		41106,
		9,
		1289,
		{
			RTResTalkAction[8]
		}
	},
	[41106010] = {
		41106010,
		0,
		Lang.get(109754),
		41106,
		10,
		300,
		{
			RTResTalkAction[8]
		}
	},
	[41106011] = {
		41106011,
		0,
		Lang.get(109755),
		41106,
		11,
		300,
		{
			RTResTalkAction[8]
		}
	},
	[41106012] = {
		41106012,
		0,
		Lang.get(109756),
		41106,
		12,
		1289,
		{
			RTResTalkAction[10]
		}
	},
	[41106013] = {
		41106013,
		4,
		nil,
		41106,
		13,
		300,
		{
			RTResTalkAction[8]
		},
		[29] = {
			{
				id = 41106014,
				branch_content = Lang.get(109757)
			},
			{
				id = 41106014,
				branch_content = Lang.get(109758)
			}
		}
	},
	[41106014] = {
		41106014,
		0,
		Lang.get(109759),
		41106,
		14,
		1289,
		{
			RTResTalkAction[8]
		}
	},
	[41106015] = {
		41106015,
		0,
		Lang.get(109760),
		41106,
		15,
		1289,
		{
			RTResTalkAction[8]
		}
	},
	[41106016] = {
		41106016,
		0,
		Lang.get(109761),
		41106,
		16,
		300,
		{
			RTResTalkAction[8]
		}
	},
	[41106017] = {
		41106017,
		0,
		Lang.get(109762),
		41106,
		17,
		300,
		{
			RTResTalkAction[8]
		}
	},
	[41106018] = {
		41106018,
		0,
		Lang.get(109763),
		41106,
		18,
		1289,
		{
			RTResTalkAction[11]
		}
	},
	[41106019] = {
		41106019,
		0,
		Lang.get(109764),
		41106,
		19,
		300,
		{
			RTResTalkAction[8]
		}
	}
}
local metaTableResTalkAction = {
	__index = function(table, key)
		local keyIndexRT = indexMapResTalkAction[key]

		if not keyIndexRT then
			return nil
		end

		return table[keyIndexRT]
	end
}

for k, v in pairs(RTResTalkAction) do
	setmetatable(v, metaTableResTalkAction)
end

local metaTable = {
	__index = function(table, key)
		local keyIndex = indexMap[key]

		if not keyIndex then
			return nil
		end

		return table[keyIndex]
	end
}

for k, v in pairs(Data) do
	setmetatable(v, metaTable)
end

return Data
