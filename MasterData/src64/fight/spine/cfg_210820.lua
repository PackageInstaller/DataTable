local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		{
			{
				method = "useSkill",
				param = "attack"
			}
		}
	},
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
				id = 210810010,
				frame = 11
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
		totalframe = 25,
		animation = "skill",
		action_on_start = {
			{
				startframe = 2,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 300,
							frame = 19
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
				id = 210820012
			},
			{
				frame = 5,
				id = 210820010
			},
			{
				frame = 9,
				id = 210820010
			},
			{
				frame = 16,
				id = 210820010
			},
			{
				frame = 17,
				id = 210820011
			}
		}
	},
	usexp = {
		totalframe = 113,
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
				id = 210830010
			},
			{
				frame = 2,
				id = 210830013
			},
			{
				frame = 44,
				id = 210830011
			},
			{
				frame = 54,
				id = 210830011
			},
			{
				frame = 61,
				id = 210830011
			},
			{
				frame = 87,
				id = 210830011
			},
			{
				frame = 88,
				id = 210830012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 112,
	bgfile = "210820_bg",
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
			texture = "role/210820.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/210820_xp",
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
				distance = 100,
				time = 2,
				distanceY = 0,
				totalframe = 43,
				startframe = 47
			}
		}
	}
}

return var_0_0
