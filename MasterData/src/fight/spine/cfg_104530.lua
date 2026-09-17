local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 40,
		animation = "attack",
		exe_tbl = {
			{
				frame = 4,
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
	speed = 600,
	offsetZ = 1,
	filename = "104530_204520_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 204510010
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
	totalframe = 55,
	turnbacklimit = true,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"201720_skill",
				0.6
			}
		},
		{
			frame = 28,
			id = 204520010
		},
		{
			frame = 29,
			id = 204520011
		},
		{
			frame = 30,
			id = 204520012
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
	totalframe = 85,
	xpeffect = "xp_effect",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 20,
			sound = {
				"201720_xp",
				0.6
			}
		},
		{
			frame = 10,
			id = 204530010
		},
		{
			frame = 49,
			id = 204530011
		},
		{
			frame = 50,
			id = 204530012
		},
		{
			frame = 51,
			id = 204530013
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 0.75,
	bgfile = "204520_bg",
	totalframe = 85,
	locktarget = {
		locktargetpool = "oponent",
		locktarget = true
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
			texture = "role/104530.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/204520_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		zoom = {
			{
				scale = 1.2,
				totalframe = 25,
				startframe = 0
			},
			{
				scale = 1,
				totalframe = 35,
				startframe = 30
			}
		},
		move = {
			{
				pos = "self",
				totalframe = 40,
				startframe = 0,
				time = 0.1
			},
			{
				pos = "target",
				totalframe = 30,
				startframe = 30,
				time = 0.5
			}
		}
	}
}

return var_0_0
