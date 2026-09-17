local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		{
			{
				operator = ">=",
				method = "random",
				param = {
					num = 5,
					range = 10
				}
			},
			{
				method = "useSkill",
				param = "attack1"
			}
		},
		{
			{
				method = "useSkill",
				param = "attack2"
			}
		}
	},
	attack1 = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"201820_attack",
					0.6
				}
			},
			{
				id = 201810010,
				frame = 16
			}
		}
	},
	attack2 = {
		totalframe = 20,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"201820_attack",
					0.6
				}
			},
			{
				id = 201810010,
				frame = 11
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "usexp1"
			}
		}
	},
	xp2 = {
		{
			{
				method = "useSkill",
				param = "usexp2"
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
	skill1_change = {
		{
			{
				method = "useSkill",
				param = "useskill2"
			}
		}
	},
	useskill1 = {
		totalframe = 30,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"201820_skill",
					0.6
				}
			},
			{
				frame = 13,
				id = 201820010
			}
		}
	},
	useskill2 = {
		totalframe = 30,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"201820_skill",
					0.6
				}
			},
			{
				frame = 13,
				id = 201820011
			}
		}
	},
	usexp1 = {
		totalframe = 80,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"201820_xp",
					0.6
				}
			},
			{
				frame = 50,
				id = 201830010
			},
			{
				frame = 60,
				id = 201820012
			}
		}
	},
	usexp2 = {
		totalframe = 80,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"201820_xp",
					0.6
				}
			},
			{
				frame = 50,
				id = 201830011
			},
			{
				id = 201820012,
				behitted = "hitdown",
				frame = 60,
				force = {
					{
						time = 0.6,
						shutdown = false,
						distance = 200,
						object = "target"
					}
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 0.75,
	bgfile = "201820_bg",
	totalframe = 80,
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
			texture = "role/201720.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/Ebina_05",
				1
			}
		}
	},
	bgaction = {},
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
				pos = "target",
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
	speed = 900,
	offsetZ = 1,
	filename = "201720_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0.6,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.1,
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
