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
					"26720_attack",
					0.6
				}
			},
			{
				frame = 18,
				bullet = "attack",
				effect = {
					{
						ani = "attack1",
						name = "103120_203120_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.5,
						object = "target"
					}
				}
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "103120_203120_effect",
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
		totalframe = 17,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				id = 203110010
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
	totalframe = 45,
	turnbacklimit = true,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"25320_skill",
				1
			}
		},
		{
			frame = 8,
			id = 203120011
		},
		{
			frame = 8,
			bullet = "skill1"
		},
		{
			frame = 16,
			bullet = "skill1"
		},
		{
			frame = 24,
			bullet = "skill1"
		}
	}
}
var_0_0.extra.skill1 = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "103120_203120_effect",
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
		totalframe = 17,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				id = 203120010
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
var_0_0.usexp = {
	totalframe = 70,
	xpeffect = "xp_effect",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"203120_xp",
				1
			}
		},
		{
			frame = 1,
			id = 203130011
		},
		{
			behitted = "hitdown",
			id = 203130010,
			frame = 39,
			effect = {
				{
					ani = "skill",
					name = "103120_203120_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0.5,
					object = "target"
				}
			},
			shake = {
				x = 6,
				y = 6
			}
		},
		{
			behitted = "hitdown",
			id = 203130010,
			frame = 49,
			effect = {
				{
					ani = "skill",
					name = "103120_203120_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0.5,
					object = "target"
				}
			},
			shake = {
				x = 6,
				y = 6
			}
		},
		{
			behitted = "hitdown",
			id = 203130010,
			frame = 60,
			effect = {
				{
					ani = "skill",
					name = "103120_203120_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0.5,
					object = "target"
				}
			},
			shake = {
				x = 6,
				y = 6
			}
		},
		{
			frame = 60,
			id = 203130012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	focusoffset = 0,
	bgfilescale = 1.1,
	bgfile = "203120_bg",
	totalframe = 70,
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "bg"
		}
	},
	locktarget = {
		locktarget = "openent"
	},
	inserteffect = {
		{
			texture = "role/203120.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/203120_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 5,
			timescale = 0.5
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.1,
				totalframe = 25,
				startframe = 5
			},
			{
				scale = 0.9,
				totalframe = 30,
				startframe = 30
			}
		},
		move = {
			{
				distance = 100,
				totalframe = 25,
				startframe = 30,
				time = 1
			}
		}
	}
}

return var_0_0
