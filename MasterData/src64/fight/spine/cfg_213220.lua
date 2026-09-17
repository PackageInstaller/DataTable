local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 10,
				sound = {
					"201020_attack",
					0.6
				}
			},
			{
				frame = 15,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 450,
	offsetZ = 1,
	filename = "213220_effect",
	initpos = {
		offsetY = 0.3,
		offsetX = 1.1,
		object = "self"
	},
	finalpos = {
		offsetY = 0.3,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 8,
		animation = "attack",
		exe_tbl = {
			{
				id = 213210010,
				frame = 6
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
	totalframe = 60,
	turnbacklimit = true,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"201020_skill",
				0.6
			}
		},
		{
			frame = 18,
			id = 213220011
		},
		{
			frame = 38,
			id = 213220010
		},
		{
			frame = 43,
			id = 213220012
		}
	}
}
var_0_0.usexp = {
	totalframe = 100,
	xpeffect = "xp_effect",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"201020_xp",
				0.6
			}
		},
		{
			frame = 80,
			id = 213230011
		},
		{
			id = 213230010,
			behitted = "hitdown",
			frame = 81,
			shake = {
				x = 0,
				y = 20
			}
		},
		{
			frame = 82,
			id = 213230010
		},
		{
			frame = 83,
			id = 213230010
		},
		{
			frame = 84,
			id = 213230012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 100,
	bgfile = "213220_bg",
	bgfileflipX = true,
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
			texture = "role/213220.png",
			ani = "xp3",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/201020_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 80,
			timescale = 0.3
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.95,
				totalframe = 100,
				startframe = 0
			}
		},
		move = {
			{
				distance = 170,
				time = 0.5,
				distanceY = 120,
				totalframe = 100,
				startframe = 0
			}
		}
	}
}

return var_0_0
