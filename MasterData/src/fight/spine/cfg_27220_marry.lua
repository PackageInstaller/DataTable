local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 20,
		animation = "attack4",
		exe_tbl = {
			{
				frame = 5,
				bullet = "attack",
				sound = {
					"20400_attack",
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
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "17210_27220_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0.8,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				id = 27210010,
				frame = 7
			}
		}
	}
}
var_0_0.extra.attack3 = {
	movingani = "run2",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "17210_27220_effect",
	initpos = {
		offsetY = 0.55,
		offsetX = 0.8,
		object = "self"
	},
	finalpos = {
		offsetY = 0.55,
		offsetX = 0.2,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				id = 27210011,
				frame = 7
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
	skillattackframe = 45,
	totalframe = 40,
	turnbacklimit = true,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"27220_skill",
				0.6
			}
		},
		{
			frame = 20,
			id = 27220010
		},
		{
			frame = 23,
			bullet = "attack3",
			effect = {
				{
					ani = "attack2",
					name = "17210_27220_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			frame = 26,
			bullet = "attack3"
		},
		{
			frame = 29,
			bullet = "attack3"
		},
		{
			frame = 32,
			bullet = "attack3"
		},
		{
			frame = 35,
			bullet = "attack3"
		},
		{
			frame = 38,
			bullet = "attack3"
		}
	}
}
var_0_0.usexp = {
	totalframe = 90,
	xpeffect = "xp_effect",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"27220_xp",
				0.6
			}
		},
		{
			frame = 20,
			id = 27230010
		},
		{
			frame = 25,
			id = 27230010
		},
		{
			frame = 30,
			id = 27230010
		},
		{
			frame = 35,
			id = 27230010
		},
		{
			frame = 40,
			id = 27230010
		},
		{
			frame = 45,
			id = 27230010
		},
		{
			frame = 50,
			id = 27230010
		},
		{
			frame = 55,
			id = 27230010
		},
		{
			frame = 60,
			id = 27230010
		},
		{
			frame = 65,
			id = 27230010
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 90,
	bgfile = "marry_bg",
	locktarget = {
		mindistance = 300,
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
			texture = "role/27220.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/27220_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {}
}

return var_0_0
