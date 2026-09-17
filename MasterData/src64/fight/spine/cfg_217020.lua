local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 25,
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
	filename = "217020_effect",
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
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				id = 217010010,
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
	filename = "217020_effect",
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
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				id = 217020010,
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
			id = 217020011
		},
		{
			frame = 21,
			id = 217020012
		},
		{
			frame = 23,
			bullet = "attack3",
			effect = {
				{
					ani = "attack2",
					name = "217020_effect",
					offsetZ = 0,
					offsetY = 0,
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
			frame = 19,
			id = 217030011
		},
		{
			frame = 20,
			id = 217030010
		},
		{
			frame = 25,
			id = 217030010
		},
		{
			frame = 30,
			id = 217030010
		},
		{
			frame = 35,
			id = 217030010
		},
		{
			frame = 40,
			id = 217030010
		},
		{
			frame = 45,
			id = 217030010
		},
		{
			frame = 50,
			id = 217030010
		},
		{
			frame = 55,
			id = 217030010
		},
		{
			frame = 60,
			id = 217030010
		},
		{
			frame = 65,
			id = 217030010
		},
		{
			frame = 70,
			id = 217030013
		},
		{
			frame = 75,
			id = 217030012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 90,
	bgfile = "217020_bg",
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
			texture = "role/217020.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/217020_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {}
}

return var_0_0
