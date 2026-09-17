local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 40,
		animation = "attack3",
		exe_tbl = {
			{
				frame = 15,
				bullet = "attack",
				sound = {
					"20400_attack",
					0.6
				}
			}
		}
	},
	attack2 = {
		totalframe = 40,
		animation = "attack4",
		exe_tbl = {
			{
				frame = 15,
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
	speed = 600,
	offsetZ = 1,
	filename = "19250_29220_effect",
	initpos = {
		offsetY = 0.6,
		offsetX = 0.8,
		object = "self"
	},
	finalpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 7,
		animation = "attack",
		exe_tbl = {
			{
				id = 29210010,
				frame = 3
			}
		}
	}
}
var_0_0.attack3 = {
	totalframe = 30,
	animation = "attack",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"23720-attack",
				0.6
			}
		},
		{
			frame = 15,
			id = 29210011
		}
	}
}
var_0_0.attack4 = {
	totalframe = 30,
	animation = "attack2",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"23720-attack",
				0.6
			}
		},
		{
			frame = 15,
			id = 29210011
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
var_0_0.skill2 = {
	{
		{
			method = "useSkill",
			param = "useskill2"
		}
	}
}
var_0_0.skill3 = {
	{
		{
			method = "useSkill",
			param = "useskill3"
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
				"23720-skill",
				0.6
			}
		},
		{
			id = 29220010,
			behitted = "hitdown",
			frame = 28,
			force = {
				{
					time = 0.2,
					shutdown = false,
					distance = 100,
					object = "target"
				}
			}
		}
	}
}
var_0_0.useskill2 = {
	skillattackframe = 30,
	totalframe = 40,
	turnbacklimit = true,
	animation = "skill2",
	exe_tbl = {
		{
			frame = 1
		},
		{
			frame = 30,
			behitted = "hitdown",
			id = 29220011,
			force = {
				{
					time = 0.4,
					shutdown = false,
					distance = 300,
					object = "target"
				}
			},
			sound = {
				"20100_attack",
				0.6
			}
		}
	}
}
var_0_0.useskill3 = {
	skillattackframe = 25,
	totalframe = 40,
	turnbacklimit = true,
	animation = "skill3",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"28020_skill",
				0.6
			}
		},
		{
			id = 29220012,
			frame = 25,
			forceY = {
				{
					distance = 100,
					time = 0.1
				}
			}
		},
		{
			frame = 30,
			forceY = {
				{
					distance = 20,
					time = 0.4
				}
			}
		},
		{
			frame = 40,
			forceY = {
				{
					distance = 20,
					time = 0.5
				}
			}
		}
	}
}
var_0_0.usexp = {
	totalframe = 125,
	xpeffect = "xp_effect",
	turnbacklimit = true,
	nextani = true,
	animation = "xp2",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"29220_xp",
				0.6
			}
		},
		{
			id = 29230011,
			frame = 50,
			forceY = {
				{
					time = 1,
					distance = 200,
					object = "target"
				}
			}
		},
		{
			frame = 85,
			forceY = {
				{
					time = 0.3,
					distance = 200,
					object = "target"
				}
			}
		},
		{
			id = 29230010,
			frame = 88,
			shake = {
				x = 0,
				y = 40
			}
		},
		{
			frame = 95,
			behitted = "hitdown",
			shake = {
				x = 0,
				y = 40
			}
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 125,
	bgfile = "29220_bg",
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
			texture = "role/29220.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/29220_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 75,
			timescale = 0.3
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 80,
				startframe = 40
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 80,
				startframe = 40,
				time = 0.4
			}
		}
	}
}

return var_0_0
