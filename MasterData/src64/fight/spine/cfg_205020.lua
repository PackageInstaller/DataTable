local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack2 = {
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
				id = 205010010,
				frame = 15
			}
		}
	},
	attack = {
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
				id = 205010010,
				frame = 9
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
		totalframe = 45,
		animation = "skill",
		action_on_start = {
			{
				startframe = 20,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 450,
							frame = 12
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
				frame = 8,
				bullet = "attack1"
			},
			{
				frame = 32,
				id = 205020011
			},
			{
				frame = 33,
				id = 205020012
			}
		}
	}
}

var_0_0.extra.attack1 = {
	movingani = "run_skill",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 1500,
	offsetZ = 1,
	filename = "205020_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0,
		offsetX = -0.5,
		object = "target"
	},
	attack = {
		totalframe = 14,
		animation = "skill",
		exe_tbl = {
			{
				frame = 2,
				id = 205020010
			}
		}
	}
}
var_0_0.usexp = {
	totalframe = 102,
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
			frame = 15,
			id = 205030012
		},
		{
			frame = 16,
			id = 205030012
		},
		{
			frame = 17,
			id = 205030012
		},
		{
			frame = 18,
			id = 205030012
		},
		{
			frame = 41,
			id = 205030010
		},
		{
			frame = 52,
			id = 205030010
		},
		{
			frame = 58,
			id = 205030010
		},
		{
			frame = 79,
			id = 205030010
		},
		{
			frame = 80,
			id = 205030011
		},
		{
			frame = 85,
			id = 205030013
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 102,
	bgfile = "205020_bg",
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
			texture = "role/205020.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/205020_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 37,
			timescale = 0.3
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.9,
				totalframe = 90,
				startframe = 0
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
