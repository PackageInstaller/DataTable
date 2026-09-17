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
					"22320_attack",
					0.6
				}
			},
			{
				frame = 22,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run_attack",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "219320_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 9,
		animation = "attack",
		exe_tbl = {
			{
				frame = 4,
				id = 219310010
			}
		}
	}
}
var_0_0.attack1 = {
	totalframe = 42,
	turnbacklimit = true,
	animation = "attack1",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"22320_attack",
				0.6
			}
		},
		{
			frame = 32,
			bullet = "attack1"
		}
	}
}
var_0_0.extra.attack1 = {
	movingani = "run_attack1",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "219320_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 9,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 4,
				id = 219310011
			},
			{
				id = 219310012,
				frame = 5,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 75,
						object = "target"
					}
				}
			},
			{
				frame = 6,
				id = 219310013
			},
			{
				frame = 7,
				id = 219310014
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
	totalframe = 58,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"22820_skill",
				0.6
			}
		},
		{
			frame = 20,
			id = 219320010
		},
		{
			frame = 29,
			id = 219320010
		},
		{
			frame = 42,
			id = 219320010
		},
		{
			frame = 44,
			id = 219320011
		},
		{
			frame = 46,
			id = 219320012
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
	totalframe = 124,
	xpeffect = "xp_effect",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"28820_xp",
				0.6
			}
		},
		{
			frame = 60,
			id = 219330012
		},
		{
			frame = 94,
			id = 219330010
		},
		{
			frame = 98,
			id = 219330010
		},
		{
			frame = 102,
			id = 219330010
		},
		{
			id = 219330011,
			frame = 105,
			force = {
				{
					time = 0.5,
					shutdown = false,
					distance = 200,
					object = "target"
				}
			}
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "219320_bg",
	totalframe = 124,
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
			texture = "role/219320.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/219320_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		move = {}
	}
}

return var_0_0
