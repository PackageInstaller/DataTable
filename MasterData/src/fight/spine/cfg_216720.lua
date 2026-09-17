local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 28,
		animation = "attack",
		exe_tbl = {
			{
				frame = 12,
				sound = {
					"202420_atk",
					0.6
				}
			},
			{
				frame = 13,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run_attack",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "216720_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.25,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 7,
		animation = "attack",
		exe_tbl = {
			{
				frame = 3,
				id = 216710010
			}
		}
	}
}
var_0_0.skill1 = {
	{
		{
			method = "useSkill",
			param = "useskill1"
		}
	}
}
var_0_0.useskill1 = {
	totalframe = 50,
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
			frame = 10,
			id = 216720010
		},
		{
			frame = 24,
			id = 216720011
		},
		{
			frame = 25,
			id = 216720012
		},
		{
			frame = 32,
			id = 216720011
		},
		{
			frame = 33,
			id = 216720012
		},
		{
			frame = 40,
			id = 216720011
		},
		{
			frame = 41,
			id = 216720012
		}
	}
}
var_0_0.xp = {
	{
		{
			method = "useSkill",
			param = "usexp1"
		}
	}
}
var_0_0.usexp1 = {
	totalframe = 123,
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
			frame = 10,
			id = 216730010
		},
		{
			frame = 25,
			id = 216730011
		},
		{
			frame = 29,
			id = 216730012
		},
		{
			frame = 52,
			id = 216730012
		},
		{
			frame = 75,
			id = 216730012
		},
		{
			frame = 105,
			id = 216730012
		},
		{
			frame = 106,
			id = 216730013
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "216720_bg",
	totalframe = 123,
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
			texture = "role/216720.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/216720_xp",
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
