local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203020_attack",
					0.6
				}
			},
			{
				id = 214110010,
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
		turnbacklimit = true,
		totalframe = 60,
		animation = "skill",
		action_on_start = {
			{
				startframe = 16,
				action = {
					{
						method = "grab",
						param = {
							bonename = "role",
							finaloffset = cc.p(60, 0)
						}
					}
				}
			},
			{
				startframe = 52,
				action = {
					{
						method = "releasegrab"
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27720_skill_xp",
					0.7
				}
			},
			{
				frame = 50,
				id = 214120010
			},
			{
				frame = 52,
				id = 214120011
			},
			{
				frame = 54,
				id = 214120012
			}
		}
	},
	usexp = {
		totalframe = 93,
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
				frame = 79,
				id = 214130010
			},
			{
				frame = 81,
				id = 214130010
			},
			{
				frame = 82,
				id = 214130010
			},
			{
				frame = 84,
				id = 214130010
			},
			{
				frame = 90,
				id = 214130011
			},
			{
				frame = 91,
				id = 214130012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 93,
	bgfile = "214120_bg",
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
			texture = "role/214120.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/214120_xp",
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
				distance = 250,
				time = 2,
				distanceY = 0,
				totalframe = 65,
				startframe = 25
			}
		}
	}
}

return var_0_0
