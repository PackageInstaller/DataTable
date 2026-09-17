local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack2 = {
		totalframe = 25,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203020_attack",
					0.6
				}
			},
			{
				id = 209510010,
				frame = 9
			}
		}
	},
	attack1 = {
		totalframe = 23,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203020_attack",
					0.6
				}
			},
			{
				id = 209510010,
				frame = 12
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "usexp"
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
		totalframe = 48,
		turnbacklimit = false,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203020_skill",
					0.6
				}
			},
			{
				frame = 3,
				id = 209520010
			},
			{
				frame = 24,
				id = 209520011
			},
			{
				frame = 28,
				id = 209520011
			},
			{
				frame = 35,
				id = 209520011
			}
		}
	},
	usexp = {
		totalframe = 75,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27420_xp",
					0.6
				}
			},
			{
				frame = 1,
				id = 209530011
			},
			{
				frame = 53,
				id = 209530010
			},
			{
				frame = 56,
				id = 209530010
			},
			{
				frame = 59,
				id = 209530010
			},
			{
				frame = 62,
				id = 209530010
			},
			{
				frame = 65,
				id = 209530010
			},
			{
				frame = 66,
				id = 209530012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 74,
	bgfile = "209520_bg",
	locktarget = {
		locktargetpool = "oponent"
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
			texture = "role/209520.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/209520_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {
			{
				scale = 1.1,
				totalframe = 90,
				startframe = 2
			}
		},
		move = {
			{
				distance = 0,
				time = 0.5,
				distanceY = 0,
				totalframe = 90,
				startframe = 0
			}
		}
	}
}

return var_0_0
