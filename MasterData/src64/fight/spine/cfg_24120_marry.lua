local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 12,
				bullet = "attack",
				sound = {
					"24120-attack",
					0.6
				}
			},
			{
				frame = 18,
				bullet = "attack",
				sound = {
					"24120-attack",
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
	filename = "14110_24120_effect",
	initpos = {
		offsetY = 0.15,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.3,
		offsetX = -0.5,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				id = 24110001,
				frame = 1
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
var_0_0.skill1_1 = {
	{
		{
			method = "useSkill",
			param = "useskill1_1"
		}
	}
}
var_0_0.skill1_2 = {
	{
		{
			method = "useSkill",
			param = "useskill1_2"
		}
	}
}
var_0_0.skill1_3 = {
	{
		{
			method = "useSkill",
			param = "useskill1_3"
		}
	}
}
var_0_0.useskill1 = {
	skillattackframe = 45,
	totalframe = 48,
	animation = "skill",
	exe_tbl = {
		{
			frame = 8,
			sound = {
				"241_skill",
				0.6
			}
		},
		{
			frame = 20,
			id = 241601002
		},
		{
			frame = 21,
			id = 24120003
		},
		{
			id = 24120002,
			frame = 21,
			force = {
				{
					time = 0.4,
					shutdown = false,
					distance = 200,
					object = "target"
				}
			}
		},
		{
			id = 24120001,
			frame = 21,
			force = {
				{
					time = 0.3,
					shutdown = false,
					distance = 100,
					object = "target"
				}
			}
		}
	}
}
var_0_0.skill2 = {
	{
		{
			method = "useSkill",
			param = "useskill2"
		}
	}
}
var_0_0.useskill2 = {
	totalframe = 31,
	animation = "attack",
	exe_tbl = {
		{
			frame = 2,
			sound = {
				"24120-attack",
				1
			}
		},
		{
			frame = 3,
			id = 241601002
		},
		{
			id = 24120401,
			frame = 5,
			effect = {
				{
					ani = "skill_attack",
					name = "14110_24120_effect",
					offsetZ = 0,
					offsetY = 0,
					offsetX = 1,
					object = "self"
				}
			},
			force = {
				{
					time = 0.5,
					shutdown = true,
					distance = 300,
					object = "target"
				}
			}
		}
	}
}
var_0_0.useskill1_1 = {
	totalframe = 57,
	animation = "skill",
	exe_tbl = {
		{
			frame = 8,
			sound = {
				"241_skill",
				0.6
			}
		},
		{
			id = 24120101,
			frame = 35,
			effect = {
				{
					ani = "skill_attack",
					name = "14110_24120_effect",
					offsetZ = 1,
					offsetY = 0.3,
					offsetX = -0.3,
					object = "target"
				}
			}
		},
		{
			frame = 35,
			id = 24120102
		}
	}
}
var_0_0.useskill1_2 = {
	totalframe = 57,
	animation = "skill",
	exe_tbl = {
		{
			frame = 8,
			sound = {
				"241_skill",
				0.6
			}
		},
		{
			id = 24120201,
			frame = 35,
			effect = {
				{
					ani = "skill_attack",
					name = "14110_24120_effect",
					offsetZ = 1,
					offsetY = 0.3,
					offsetX = -0.3,
					object = "target"
				}
			}
		},
		{
			frame = 35,
			id = 24120202
		}
	}
}
var_0_0.useskill1_3 = {
	totalframe = 57,
	animation = "skill",
	exe_tbl = {
		{
			frame = 8,
			sound = {
				"241_skill",
				0.6
			}
		},
		{
			id = 24120301,
			frame = 35,
			effect = {
				{
					ani = "skill_attack",
					name = "14110_24120_effect",
					offsetZ = 1,
					offsetY = 0.3,
					offsetX = -0.3,
					object = "target"
				}
			}
		},
		{
			frame = 35,
			id = 24120302
		}
	}
}
var_0_0.usexp = {
	turnbacklimit = false,
	xpeffect = "xp_effect",
	totalframe = 104,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"241_xp",
				0.6
			}
		},
		{
			frame = 60,
			id = 24130001
		},
		{
			frame = 60,
			id = 24130002
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfileflipx = true,
	focusoffset = 100,
	totalframe = 104,
	bgfile = "marry_bg",
	locktarget = {
		locktargetpool = "teammate",
		locktarget = false
	},
	inserteffect = {
		{
			texture = "role/14110_24120.png",
			ani = "xp",
			donotlock = false,
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/24120_xp"
			}
		}
	},
	bgani = {
		{
			isloop = true,
			startframe = 1,
			ani = "BG1"
		}
	},
	show = {
		{
			action = "show",
			startframe = 70,
			target = "target"
		}
	},
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
		move = {
			{
				pos = "self",
				time = 0.5,
				distance = 0,
				totalframe = 130,
				startframe = 0
			}
		}
	}
}

return var_0_0
