local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22900_attack",
					0.6
				}
			},
			{
				frame = 18,
				bullet = "attack"
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
		totalframe = 45,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20220-skill",
					0.6
				}
			},
			{
				frame = 30,
				id = 27120011
			},
			{
				id = 27120010,
				frame = 33,
				behitted = "hitdown",
				effect = {
					{
						ani = "skill",
						name = "17110_27120_effect",
						offsetZ = 0,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 35,
				id = 27120010
			},
			{
				id = 27120010,
				behitted = "hitdown",
				frame = 37
			},
			{
				frame = 39,
				id = 27120010
			},
			{
				id = 27120010,
				behitted = "hitdown",
				frame = 41
			}
		}
	},
	usexp = {
		totalframe = 104,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22900_xp",
					0.6
				},
				effect = {
					{
						ani = "xp",
						name = "17110_27120_effect",
						offsetZ = 0,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 68,
				id = 27130010
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 105,
	bgfile = "marry_bg",
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "animationp"
		}
	},
	inserteffect = {
		{
			texture = "role/27120.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 80,
			startframe = 50,
			timescale = 1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 25,
				startframe = 50
			}
		},
		move = {
			{
				distance = 200,
				totalframe = 54,
				startframe = 50,
				time = 1.5
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 600,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "17110_27120_effect",
	initpos = {
		offsetY = 0.4,
		offsetX = 1.2,
		object = "self"
	},
	finalpos = {
		offsetY = 0.4,
		offsetX = 0.1,
		object = "target"
	},
	attack = {
		totalframe = 11,
		animation = "attack",
		exe_tbl = {
			{
				frame = 6,
				id = 27110010,
				effect = {
					{
						ani = "attack",
						name = "17110_27120_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	}
}

return var_0_0
