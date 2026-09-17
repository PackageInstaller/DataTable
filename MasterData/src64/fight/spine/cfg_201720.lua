local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"201720_attack",
					0.6
				}
			},
			{
				frame = 17,
				bullet = "attack",
				sound = {
					"20400_attack",
					0.6
				}
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
				frame = 30,
				id = 201720010,
				effect = {
					{
						ani = "skill",
						name = "201720_effect",
						offsetZ = 1,
						offsetY = 1,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	usexp = {
		totalframe = 110,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"201720_xp",
					0.6
				}
			},
			{
				frame = 80,
				effect = {
					{
						ani = "xp",
						name = "201720_effect",
						offsetZ = 1,
						offsetY = 1,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 100,
				id = 201730010
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "201720_bg",
	totalframe = 110,
	locktarget = {
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
			texture = "role/201720.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/Shilfin_05",
				1
			}
		}
	},
	bgaction = {
		{
			param = 0,
			startframe = 0,
			action = "setZOrder"
		}
	},
	lockframe = {},
	camera = {
		{
			startframe = 0,
			scale = 1,
			anchory = 200,
			outtime = 0.1,
			totalframe = 110,
			intime = 0.2
		},
		move = {
			{
				pos = "self",
				totalframe = 110,
				startframe = 0,
				time = 0.8
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 600,
	movingtype = "locktarget",
	speed = 500,
	offsetZ = 1,
	filename = "201720_effect",
	initpos = {
		offsetY = 0.4,
		offsetX = 0.6,
		object = "self"
	},
	finalpos = {
		offsetY = 0.4,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 201710010
			}
		}
	}
}

return var_0_0
