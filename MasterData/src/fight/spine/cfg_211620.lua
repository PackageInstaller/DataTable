local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 30,
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
				id = 211610010,
				frame = 21
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
				id = 211610011,
				frame = 1
			},
			{
				id = 211610012,
				frame = 22
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
		totalframe = 54,
		animation = "skill1",
		action_on_start = {
			{
				startframe = 30,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 11,
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
				id = 211620010
			},
			{
				frame = 32,
				id = 211620011
			},
			{
				frame = 35,
				id = 211620012
			},
			{
				frame = 47,
				id = 211620013
			}
		}
	},
	usexp = {
		totalframe = 100,
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
				id = 211630010
			},
			{
				frame = 40,
				id = 211630011
			},
			{
				frame = 49,
				id = 211630011
			},
			{
				frame = 55,
				id = 211630011
			},
			{
				frame = 59,
				id = 211630011
			},
			{
				frame = 64,
				id = 211630011
			},
			{
				frame = 65,
				id = 211630011
			},
			{
				frame = 51,
				id = 211630012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 99,
	bgfile = "211620_bg",
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
			texture = "role/211620.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/211620_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {},
		move = {
			{
				distance = 150,
				time = 0.2,
				distanceY = 0,
				totalframe = 33,
				startframe = 37
			}
		}
	}
}

return var_0_0
