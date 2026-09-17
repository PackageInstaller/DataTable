local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 28,
		animation = "attack",
		exe_tbl = {
			{
				frame = 7,
				sound = {
					"201020_attack",
					0.6
				}
			},
			{
				frame = 14,
				bullet = "attack1"
			}
		}
	}
}

var_0_0.extra.attack1 = {
	movingani = "run_attack",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 1200,
	offsetZ = 1,
	filename = "215020_effect",
	initpos = {
		offsetY = 1,
		offsetX = -0.1,
		object = "self"
	},
	finalpos = {
		offsetY = 0.4,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 7,
		animation = "attack",
		exe_tbl = {
			{
				id = 215010010,
				frame = 3
			}
		}
	}
}
var_0_0.xp = {
	{
		{
			method = "useSkill",
			param = "usexp"
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
	totalframe = 47,
	turnbacklimit = false,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"222500_skill",
				1
			}
		},
		{
			frame = 34,
			id = 215020010
		},
		{
			frame = 36,
			id = 215020010
		},
		{
			frame = 38,
			id = 215020010
		},
		{
			frame = 40,
			id = 215020010
		},
		{
			frame = 43,
			id = 215020011
		},
		{
			frame = 45,
			id = 215020012
		}
	}
}
var_0_0.usexp = {
	totalframe = 110,
	xpeffect = "xp_effect",
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"22220_xp",
				2
			}
		},
		{
			frame = 20,
			id = 215030010
		},
		{
			frame = 39,
			id = 215030011
		},
		{
			frame = 44,
			id = 215030011
		},
		{
			frame = 49,
			id = 215030011
		},
		{
			frame = 55,
			id = 215030011
		},
		{
			frame = 63,
			id = 215030011
		},
		{
			frame = 96,
			id = 215030012
		},
		{
			frame = 100,
			id = 215030013
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 110,
	bgfile = "215020_bg",
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
			texture = "role/215020.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/215020_xp",
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
