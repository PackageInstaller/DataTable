-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_family_battle_pillar_entry.lua

module("logicconfig.config.t_new_family_battle_pillar_entry", package.seeall)

local title = {
	bigIcon = 5,
	midIcon = 6,
	name = 3,
	pillarPlanId = 1,
	posParams = 10,
	headIcon = 7,
	pos = 9,
	pillarId = 2,
	smallIcon = 4,
	energyEffPaths = 8
}
local dataList = {
	{
		1,
		1,
		"智慧神柱",
		"familynesttower/bg_llzz_05",
		"familynesttower/board_llzz_13",
		"familynesttower/board_llzz_06",
		"ui/icon/headicon/com_play_shenzhu03",
		{
			"20220602/jiazuzhan/fx_ui_jiazuzhan_yan",
			"20220602/jiazuzhan/fx_ui_jiazuzhan_glow_white"
		},
		{
			-359,
			216
		},
		{
			params = {
				{
					obj = "imgPillar",
					pos = {
						0,
						0
					}
				},
				{
					obj = "effRoot",
					pos = {
						-36,
						35
					}
				},
				{
					obj = "name",
					pos = {
						-35,
						-35
					}
				},
				{
					obj = "energy",
					pos = {
						-35,
						-65
					}
				}
			}
		}
	},
	{
		1,
		2,
		"生命神柱",
		"familynesttower/bg_llzz_06",
		"familynesttower/board_llzz_11",
		"familynesttower/board_llzz_04",
		"ui/icon/headicon/com_play_shenzhu04",
		{
			"20220602/jiazuzhan/fx_ui_jiazuzhan_yan",
			"20220602/jiazuzhan/fx_ui_jiazuzhan_glow_green"
		},
		{
			-417,
			-72
		},
		{
			params = {
				{
					obj = "imgPillar",
					pos = {
						0,
						0
					}
				},
				{
					obj = "effRoot",
					pos = {
						-50,
						35
					}
				},
				{
					obj = "name",
					pos = {
						-50,
						-35
					}
				},
				{
					obj = "energy",
					pos = {
						-50,
						-65
					}
				}
			}
		}
	},
	{
		1,
		3,
		"是非神柱",
		"familynesttower/bg_llzz_04",
		"familynesttower/board_llzz_12",
		"familynesttower/board_llzz_05",
		"ui/icon/headicon/com_play_shenzhu02",
		{
			"20220602/jiazuzhan/fx_ui_jiazuzhan_yan",
			"20220602/jiazuzhan/fx_ui_jiazuzhan_glow_purple"
		},
		{
			430,
			-123
		},
		{
			params = {
				{
					obj = "imgPillar",
					pos = {
						0,
						0
					}
				},
				{
					obj = "effRoot",
					pos = {
						-100,
						60
					}
				},
				{
					obj = "name",
					pos = {
						-100,
						-30
					}
				},
				{
					obj = "energy",
					pos = {
						-100,
						-60
					}
				}
			}
		}
	},
	{
		1,
		4,
		"时间神柱",
		"familynesttower/bg_llzz_03",
		"familynesttower/board_llzz_14",
		"familynesttower/board_llzz_07",
		"ui/icon/headicon/com_play_shenzhu05",
		{
			"20220602/jiazuzhan/fx_ui_jiazuzhan_yan",
			"20220602/jiazuzhan/fx_ui_jiazuzhan_glow_blue"
		},
		{
			326,
			192
		},
		{
			params = {
				{
					obj = "imgPillar",
					pos = {
						0,
						0
					}
				},
				{
					obj = "effRoot",
					pos = {
						-20,
						35
					}
				},
				{
					obj = "name",
					pos = {
						-15,
						-30
					}
				},
				{
					obj = "energy",
					pos = {
						-10,
						-60
					}
				}
			}
		}
	},
	{
		1,
		5,
		"力量神柱",
		"familynesttower/bg_llzz_02",
		"familynesttower/board_llzz_10",
		"familynesttower/board_llzz_03",
		"ui/icon/headicon/com_play_shenzhu01",
		{
			"20220602/jiazuzhan/fx_ui_jiazuzhan_yan",
			"20220602/jiazuzhan/fx_ui_jiazuzhan_glow_red"
		},
		{
			-39,
			-176
		},
		{
			params = {
				{
					obj = "imgPillar",
					pos = {
						0,
						0
					}
				},
				{
					obj = "effRoot",
					pos = {
						-110,
						35
					}
				},
				{
					obj = "name",
					pos = {
						-100,
						-50
					}
				},
				{
					obj = "energy",
					pos = {
						-100,
						-80
					}
				}
			}
		}
	}
}
local t_new_family_battle_pillar_entry = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_new_family_battle_pillar_entry.dataList = dataList

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

return t_new_family_battle_pillar_entry
