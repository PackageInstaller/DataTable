local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 15,
				bullet = "attack",
				sound = {
					"23800_atk1",
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
	speed = 500,
	offsetZ = 1,
	filename = "220220_effect",
	initpos = {
		offsetY = 0.65,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.65,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 11,
		animation = "attack",
		exe_tbl = {
			{
				id = 220210010,
				frame = 1,
				sound = {
					"23800_atk2",
					0.6
				},
				effect = {
					{
						ani = "attack",
						name = "220220_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
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
	totalframe = 51,
	turnbacklimit = true,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"23800_skill",
				0.6
			}
		},
		{
			id = 220220010,
			behitted = "hitdown",
			frame = 30,
			effect = {
				{
					ani = "skill_attack",
					name = "220220_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			frame = 31,
			id = 220220011
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
	totalframe = 106,
	xpeffect = "xp_effect",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"23800_xp",
				0.6
			}
		},
		{
			id = 220230010,
			frame = 52,
			effect = {
				{
					ani = "xp",
					name = "220220_effect",
					offsetZ = 1,
					offsetY = 0.4,
					offsetX = 1,
					object = "target"
				}
			}
		},
		{
			frame = 53,
			id = 220230011
		},
		{
			id = 220230010,
			frame = 60,
			effect = {
				{
					ani = "xp",
					name = "220220_effect",
					offsetZ = 1,
					offsetY = 0.4,
					offsetX = 1,
					object = "target"
				}
			}
		},
		{
			id = 220230010,
			frame = 68,
			effect = {
				{
					ani = "xp",
					name = "220220_effect",
					offsetZ = 1,
					offsetY = 0.4,
					offsetX = 1,
					object = "target"
				}
			}
		},
		{
			id = 220230010,
			frame = 76,
			effect = {
				{
					ani = "xp",
					name = "220220_effect",
					offsetZ = 1,
					offsetY = 0.4,
					offsetX = 1,
					object = "target"
				}
			}
		},
		{
			id = 220230010,
			frame = 84,
			effect = {
				{
					ani = "xp",
					name = "220220_effect",
					offsetZ = 1,
					offsetY = 0.4,
					offsetX = 1,
					object = "target"
				}
			}
		},
		{
			frame = 90,
			id = 220230010
		},
		{
			frame = 105,
			id = 220230012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	focusoffset = 100,
	bgfilescale = 0.35,
	bgfile = "220220_bg",
	totalframe = 106,
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
			texture = "role/220220.png",
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
		zoom = {
			{
				startframe = 52,
				scale = 0.8,
				outtime = 0.3,
				totalframe = 43,
				intime = 0.1
			}
		},
		move = {}
	}
}

return var_0_0
