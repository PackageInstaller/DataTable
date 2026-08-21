-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/guide_config/guide_battle_tec.lua

local configData = {
	step1 = {
		tips = "特殊技及限制技在释放过后都会进入冷却状态，冷却状态结束才可再次释放",
		img = "battle_coldtime",
		mask = true,
		imgKuang = {
			{
				324.7867,
				-99.83586,
				0,
				105.7576,
				110.3286
			}
		},
		leftHint = {
			{
				565.7281,
				-188.4725,
				0,
				"冷却时间"
			}
		},
		rightHint = {}
	},
	step2 = {
		tips = "理智有正、零、负共三种状态，当角色处于负理智状态时，受到的伤害必定暴击",
		img = "battle_lowpower_crit1",
		mask = true,
		imgKuang = {
			{
				-323.5028,
				-46.05794,
				0,
				248.044,
				77.0722
			},
			{
				164.489,
				-163.7103,
				0,
				162.2648,
				125.6804
			}
		},
		leftHint = {
			{
				389.9,
				-248,
				0,
				"负理智状态"
			}
		},
		rightHint = {}
	},
	step3 = {
		tips = "当攻击方灵感超过被攻击目标5点时，造成的伤害必定暴击",
		img = "battle_crit2",
		mask = true,
		imgKuang = {
			{
				-304.4,
				-48,
				0,
				173.702,
				56.1039
			}
		},
		leftHint = {},
		rightHint = {}
	}
}

return configData
