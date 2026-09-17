local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		{
			{
				method = "useSkill",
				param = "attack1"
			}
		}
	},
	attack1 = {
		totalframe = 26,
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
	filename = "210020_effect",
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
		totalframe = 8,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 210010010
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
	totalframe = 46,
	turnbacklimit = false,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"203020_skill",
				0.6
			}
		},
		{
			frame = 12,
			id = 210020010
		},
		{
			frame = 14,
			id = 210020011
		}
	}
}
var_0_0.usexp = {
	totalframe = 107,
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
			frame = 40,
			id = 210030011
		},
		{
			frame = 90,
			id = 210030010
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 107,
	bgfile = "210020_bg",
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
			texture = "role/210020.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/210020_xp",
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
		move = {}
	}
}

return var_0_0
