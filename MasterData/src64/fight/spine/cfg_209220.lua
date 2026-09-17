local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 24,
		animation = "attack",
		exe_tbl = {
			{
				frame = 10,
				sound = {
					"202420_atk",
					0.6
				}
			},
			{
				frame = 14,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run_attack",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 450,
	offsetZ = 1,
	filename = "209220_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = -0.5,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 209210010
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
	totalframe = 45,
	turnbacklimit = true,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"28020_skill",
				0.6
			}
		},
		{
			id = 209220010,
			frame = 17,
			force = {
				{
					time = 0.3,
					shutdown = false,
					distance = 150,
					object = "nearest"
				}
			}
		},
		{
			id = 209220010,
			frame = 24,
			force = {
				{
					time = 0.3,
					shutdown = false,
					distance = 150,
					object = "nearest"
				}
			}
		},
		{
			id = 209220010,
			frame = 33,
			force = {
				{
					time = 0.3,
					shutdown = false,
					distance = 150,
					object = "nearest"
				}
			}
		},
		{
			frame = 36,
			id = 209220011
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
	totalframe = 98,
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
			frame = 36,
			id = 209230010
		},
		{
			frame = 37,
			id = 209230011
		},
		{
			frame = 45,
			id = 209230012
		},
		{
			frame = 60,
			id = 209230012
		},
		{
			frame = 75,
			id = 209230012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "209220_bg",
	totalframe = 97,
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
			texture = "role/209220.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/209220_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		move = {
			{
				distance = 200,
				totalframe = 66,
				startframe = 33,
				time = 0.8
			}
		}
	}
}

return var_0_0
