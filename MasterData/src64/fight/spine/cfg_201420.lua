local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22120_attack",
					0.6
				}
			},
			{
				frame = 12,
				id = 201410011
			}
		}
	},
	attack2 = {
		totalframe = 40,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20100_attack",
					0.6
				}
			},
			{
				frame = 25,
				id = 201410010
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
		totalframe = 45,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"240_skill",
					0.6
				}
			},
			{
				frame = 1,
				id = 201420010
			},
			{
				frame = 2,
				id = 201420016
			},
			{
				frame = 31,
				id = 201420011
			},
			{
				frame = 33,
				id = 201420012
			},
			{
				frame = 34,
				id = 201420013
			},
			{
				frame = 35,
				id = 201420014
			},
			{
				frame = 36,
				id = 201420015
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
		totalframe = 120,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"241_xp",
					0.6
				}
			},
			{
				frame = 15,
				id = 201430010
			},
			{
				frame = 29,
				id = 201430010
			},
			{
				frame = 91,
				id = 201430011
			},
			{
				frame = 93,
				id = 201430017
			},
			{
				frame = 100,
				id = 201430012
			},
			{
				frame = 102,
				id = 201430013
			},
			{
				frame = 108,
				id = 201430014
			},
			{
				frame = 114,
				id = 201430015
			},
			{
				frame = 115,
				id = 201430016
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 0.75,
	bgfile = "201420_bg",
	totalframe = 120,
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
			texture = "role/201420.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/201420_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		{
			startframe = 0,
			scale = 1,
			anchory = 200,
			outtime = 0.1,
			totalframe = 66,
			intime = 0.2
		}
	}
}

return var_0_0
