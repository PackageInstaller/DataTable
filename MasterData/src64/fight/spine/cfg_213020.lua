local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 26,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203020_attack",
					0.6
				}
			},
			{
				id = 213010010,
				frame = 11
			}
		}
	},
	attack2 = {
		totalframe = 26,
		animation = "attack",
		exe_tbl = {
			{
				frame = 3,
				sound = {
					"202420_atk",
					0.6
				}
			},
			{
				frame = 11,
				bullet = "attack_1"
			}
		}
	}
}

var_0_0.extra.attack_1 = {
	movingani = "run_attack",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 1600,
	offsetZ = 1,
	filename = "213020_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.25,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 11,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 213010011
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
var_0_0.skill1_xp = {
	{
		{
			method = "useSkill",
			param = "useskill1_xp"
		}
	}
}
var_0_0.xp_xp = {
	{
		{
			method = "useSkill",
			param = "usexp_xp"
		}
	}
}
var_0_0.useskill1 = {
	turnbacklimit = false,
	totalframe = 52,
	animation = "skill",
	action_on_start = {
		{
			startframe = 8,
			action = {
				{
					method = "rush_to_target",
					param = {
						frame = 2,
						posx = 50
					}
				}
			}
		}
	},
	exe_tbl = {
		{
			frame = 8,
			sound = {
				"203020_skill",
				0.6
			}
		},
		{
			frame = 10,
			id = 213020013
		},
		{
			frame = 20,
			id = 213020010
		},
		{
			frame = 32,
			id = 213020010
		},
		{
			frame = 42,
			id = 213020010
		},
		{
			frame = 44,
			id = 213020010
		}
	}
}
var_0_0.useskill1_xp = {
	turnbacklimit = false,
	totalframe = 53,
	animation = "skill",
	action_on_start = {
		{
			startframe = 8,
			action = {
				{
					method = "rush_to_target",
					param = {
						frame = 2,
						posx = 50
					}
				}
			}
		}
	},
	exe_tbl = {
		{
			frame = 8,
			sound = {
				"203020_skill",
				0.6
			}
		},
		{
			frame = 10,
			id = 213020013
		},
		{
			frame = 20,
			id = 213020011
		},
		{
			frame = 32,
			id = 213020011
		},
		{
			frame = 42,
			id = 213020011
		},
		{
			frame = 44,
			id = 213020011
		},
		{
			frame = 46,
			id = 213020012
		}
	}
}
var_0_0.usexp = {
	totalframe = 98,
	xpeffect = "xp_effect",
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"27420_xp",
				0.6
			}
		},
		{
			frame = 30,
			id = 213030011
		},
		{
			frame = 31,
			id = 213030010
		},
		{
			frame = 72,
			id = 213030012
		},
		{
			frame = 77,
			id = 213030012
		},
		{
			frame = 83,
			id = 213030012
		},
		{
			frame = 89,
			id = 213030012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 98,
	bgfile = "213020_bg",
	locktarget = {
		locktargetpool = "oponent"
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
			texture = "role/213020.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/213020_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {},
		move = {}
	}
}
var_0_0.usexp_xp = {
	totalframe = 98,
	xpeffect = "xp_xp_effect",
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"27420_xp",
				0.6
			}
		},
		{
			frame = 30,
			id = 213030011
		},
		{
			frame = 72,
			id = 213030012
		},
		{
			frame = 77,
			id = 213030012
		},
		{
			frame = 83,
			id = 213030012
		},
		{
			frame = 89,
			id = 213030012
		},
		{
			frame = 92,
			id = 213030013
		}
	}
}
var_0_0.xpeffect.xp_xp_effect = {
	totalframe = 98,
	bgfile = "213020_bg",
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "bg_xp"
		}
	},
	inserteffect = {
		{
			texture = "role/213020.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/213020_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {},
		move = {}
	}
}

return var_0_0
