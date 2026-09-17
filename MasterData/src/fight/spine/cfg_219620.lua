local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 27,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"240_atk",
					0.6
				}
			},
			{
				id = 219610010,
				frame = 16
			}
		}
	},
	skill1 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	useskill1 = {
		totalframe = 54,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 10,
				sound = {
					"20120-skill",
					0.6
				}
			},
			{
				frame = 30,
				id = 219620010
			},
			{
				frame = 31,
				id = 219620011
			},
			{
				frame = 32,
				id = 219620011
			},
			{
				frame = 33,
				id = 219620012
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "usexp1"
			}
		}
	},
	usexp1 = {
		totalframe = 137,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"260_xp",
					0.6
				}
			},
			{
				frame = 95,
				id = 219630010
			},
			{
				id = 219630011,
				behitted = "hitdown",
				frame = 123
			},
			{
				frame = 133,
				id = 219630012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "219620_bg",
	totalframe = 134,
	locktarget = {
		locktargetpool = "oponent",
		locktarget = false
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "bg"
		}
	},
	inserteffect = {
		{
			texture = "role/219620.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 150,
			sound = {
				"role_voice/219620_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		move = {}
	}
}

return var_0_0
