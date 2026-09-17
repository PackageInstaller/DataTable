local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 28,
		animation = "attack",
		exe_tbl = {
			{
				id = 220810010,
				frame = 14,
				sound = {
					"203020_attack",
					0.6
				}
			}
		}
	}
}

var_0_0.extra.skill = {
	movingani = "run_skill",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "220820_effect",
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
		totalframe = 48,
		animation = "skill",
		exe_tbl = {
			{
				frame = 12,
				id = 220820010
			},
			{
				frame = 20,
				id = 220820010
			},
			{
				frame = 40,
				id = 220820010
			},
			{
				frame = 41,
				id = 220820010
			},
			{
				frame = 42,
				id = 220820011
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
				"203020_skill",
				0.6
			}
		},
		{
			frame = 2,
			bullet = "skill"
		},
		{
			frame = 45,
			id = 220820012
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
	totalframe = 107,
	xpeffect = "xp_effect",
	turnbacklimit = true,
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
			frame = 25,
			id = 220830010
		},
		{
			frame = 30,
			id = 220830010
		},
		{
			frame = 40,
			id = 220830010
		},
		{
			frame = 45,
			id = 220830010
		},
		{
			frame = 50,
			id = 220830010
		},
		{
			frame = 60,
			id = 220830011
		},
		{
			frame = 80,
			id = 220830012
		},
		{
			frame = 100,
			id = 220830013
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	focusoffset = 100,
	totalframe = 107,
	bgfile = "220820_bg",
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
			texture = "role/220820.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/23820_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		zoom = {},
		move = {}
	}
}

return var_0_0
