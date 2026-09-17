local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 27,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 3,
				sound = {
					"202420_atk",
					0.6
				}
			},
			{
				frame = 14,
				bullet = "attack1"
			}
		}
	},
	attack2 = {
		totalframe = 27,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 3,
				sound = {
					"202420_atk",
					0.6
				}
			},
			{
				frame = 14,
				bullet = "attack2"
			}
		}
	}
}

var_0_0.extra.attack1 = {
	movingani = "run_attack1",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 1600,
	offsetZ = 1,
	filename = "215720_effect",
	initpos = {
		offsetY = 0.3,
		offsetX = 1.7,
		object = "self"
	},
	finalpos = {
		offsetY = 0.25,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 11,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 2,
				id = 215710010
			}
		}
	}
}
var_0_0.extra.attack2 = {
	movingani = "run_attack2",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 1600,
	offsetZ = 1,
	filename = "215720_effect",
	initpos = {
		offsetY = 0.3,
		offsetX = 1.7,
		object = "self"
	},
	finalpos = {
		offsetY = 0.25,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 16,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 2,
				id = 215710010
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
			frame = 38,
			id = 215720010
		},
		{
			frame = 39,
			id = 215720011
		},
		{
			frame = 40,
			id = 215720012
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
	totalframe = 128,
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
			frame = 1,
			id = 215730010
		},
		{
			frame = 2,
			id = 215730011
		},
		{
			frame = 52,
			id = 215730012
		},
		{
			frame = 60,
			id = 215730012
		},
		{
			frame = 66,
			id = 215730012
		},
		{
			frame = 84,
			id = 215730012
		},
		{
			frame = 91,
			id = 215730012
		},
		{
			frame = 116,
			id = 215730012
		},
		{
			frame = 117,
			id = 215730013
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "215720_bg",
	totalframe = 128,
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
			texture = "role/215720.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/215720_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		move = {
			{
				distance = 150,
				totalframe = 85,
				startframe = 42,
				time = 0.1
			}
		}
	}
}

return var_0_0
