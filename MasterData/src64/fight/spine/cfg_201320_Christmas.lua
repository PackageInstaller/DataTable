local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"201320_attack",
					0.6
				}
			},
			{
				frame = 15,
				id = 201310010
			}
		}
	},
	attack2 = {
		{
			{
				method = "useSkill",
				param = "useattack2"
			}
		}
	},
	useattack2 = {
		turnbacklimit = true,
		totalframe = 30,
		animation = "attack2",
		action_on_start = {
			{
				startframe = 10,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 600,
							time = 0.1
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"201320_attack",
					0.6
				}
			},
			{
				frame = 22,
				effect = {
					{
						ani = "buff2",
						name = "101380_201320_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
						object = "self"
					}
				}
			},
			{
				frame = 17,
				id = 201310011
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
		totalframe = 60,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"201320_skill",
					0.6
				}
			},
			{
				frame = 26,
				bullet = "skill1"
			}
		}
	}
}

var_0_0.extra.skill1 = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "101380_201320_effect",
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
		totalframe = 17,
		animation = "skill",
		exe_tbl = {
			{
				id = 201320010,
				behitted = "hitdown",
				frame = 1
			}
		}
	}
}
var_0_0.xp = {
	{
		{
			method = "useSkill",
			param = "use_xp"
		}
	}
}
var_0_0.use_xp = {
	xpeffect = "test",
	totalframe = 100,
	nextani = true,
	animation = "xp",
	action_on_start = {
		{
			startframe = 25,
			action = {
				{
					method = "rush_to_target",
					param = {
						frame = 5,
						posx = -120
					}
				}
			}
		}
	},
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"201320_xp",
				0.6
			}
		},
		{
			frame = 8,
			effect = {
				{
					ani = "buff2",
					name = "101380_201320_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0.5,
					object = "self"
				}
			}
		},
		{
			id = 201330010,
			frame = 50,
			effect = {
				{
					ani = "xp",
					name = "101380_201320_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 201330010,
			frame = 58,
			effect = {
				{
					ani = "xp",
					name = "101380_201320_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 201330010,
			frame = 66,
			effect = {
				{
					ani = "xp",
					name = "101380_201320_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 201330010,
			frame = 72,
			effect = {
				{
					ani = "xp",
					name = "101380_201320_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 201330011,
			frame = 80,
			effect = {
				{
					ani = "xp",
					name = "101380_201320_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		}
	}
}
var_0_0.xpeffect = {}
var_0_0.xpeffect.test = {
	focusoffset = 100,
	bgfilescale = 0.9,
	initpos = 0,
	bgfile = "2020shengdan_bg",
	totalframe = 100,
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
			texture = "role/201320.png",
			ani = "xp3",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/201320_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 13,
			startframe = 31,
			timescale = 0.6
		}
	},
	camera = {
		zoom = {
			{
				startframe = 32,
				scale = 0.8,
				anchory = 0,
				outtime = 0.3,
				totalframe = 58,
				intime = 0.1
			}
		},
		move = {
			{
				pos = "target",
				time = 0.2,
				distance = -150,
				totalframe = 75,
				startframe = 25
			}
		}
	}
}

return var_0_0
