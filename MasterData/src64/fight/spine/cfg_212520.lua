local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 27,
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
				id = 212510010,
				frame = 15
			},
			{
				id = 212510011,
				frame = 16
			}
		}
	},
	attack2 = {
		totalframe = 30,
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
				id = 212510010,
				frame = 14
			},
			{
				id = 212510011,
				frame = 15
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
		turnbacklimit = false,
		totalframe = 47,
		animation = "skill",
		action_on_start = {
			{
				startframe = 28,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 3,
							posx = -120
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203020_skill",
					0.6
				}
			},
			{
				frame = 1,
				id = 212520010
			},
			{
				frame = 28,
				id = 212520011
			},
			{
				frame = 29,
				id = 212520012
			},
			{
				frame = 30,
				id = 212520013
			}
		}
	},
	usexp = {
		totalframe = 176,
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
				id = 212530010
			},
			{
				frame = 90,
				id = 212530011
			},
			{
				frame = 112,
				id = 212530011
			},
			{
				frame = 137,
				id = 212530011
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 176,
	bgfile = "212520_bg",
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
			texture = "role/212520.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/212520_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {},
		move = {}
	}
}

return var_0_0
