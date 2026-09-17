local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 33,
		animation = "attack",
		exe_tbl = {
			{
				frame = 10,
				sound = {
					"203020_attack",
					0.6
				}
			},
			{
				id = 215510010,
				frame = 11
			},
			{
				id = 215510011,
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
		totalframe = 47,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"23800_skill",
					0.6
				}
			},
			{
				frame = 34,
				id = 215520010
			},
			{
				frame = 36,
				id = 215520011
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
		totalframe = 119,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		action_on_start = {
			{
				startframe = 10,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 3,
							posx = -100
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"25320_xp",
					0.6
				}
			},
			{
				frame = 33,
				id = 215530010
			},
			{
				frame = 39,
				id = 215530010
			},
			{
				frame = 45,
				id = 215530010
			},
			{
				frame = 51,
				id = 215530010
			},
			{
				frame = 57,
				id = 215530010
			},
			{
				frame = 58,
				id = 215530011
			},
			{
				frame = 86,
				id = 215530012
			},
			{
				frame = 108,
				id = 215530013
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "215520_bg",
	totalframe = 118,
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
			texture = "role/215520.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/215520_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		zoom = {
			{
				startframe = 0,
				scale = 1,
				anchory = 200,
				outtime = 0.1,
				totalframe = 66,
				intime = 0.2
			}
		},
		move = {}
	}
}

return var_0_0
