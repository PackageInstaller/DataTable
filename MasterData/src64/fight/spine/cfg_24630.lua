local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 33,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22720_attack",
					0.6
				}
			},
			{
				id = 24610110,
				frame = 23
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
		totalframe = 45,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				bullet = "push",
				sound = {
					"24620_skill",
					0.6
				}
			},
			{
				id = 24620110,
				frame = 10,
				sound = {
					"20000_attack",
					0.6
				}
			},
			{
				id = 24620111,
				frame = 17,
				sound = {
					"20000_attack",
					0.6
				}
			}
		}
	}
}

var_0_0.extra.push = {
	movingani = "run",
	maxdistance = 150,
	movingtype = "lockdirection",
	speed = 150,
	offsetZ = 1,
	filename = "26100_effect",
	initpos = {
		offsetY = 0,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "carry",
		direction = 1
	},
	attack = {
		animation = "skill2",
		totalframe = 15
	}
}
var_0_0.xp = {
	{
		{
			method = "useSkill",
			param = "xp_begin"
		}
	}
}
var_0_0.xp_begin = {
	exe_crash_by_frame = 1,
	turnbacklimit = true,
	exe_crash_type = "carry",
	animation = "xp",
	exe_crash_bound = 80,
	exe_type = "crash",
	totalframe = 60,
	nextani = true,
	action_on_start = {
		{
			startframe = 0,
			action = {
				{
					method = "add_anti_hitdown"
				}
			}
		},
		{
			startframe = 1,
			action = {
				{
					method = "rush_forward",
					param = {
						distance = 200,
						time = 0.3
					}
				}
			}
		}
	},
	xpeffect = {
		conf = "xp_effect",
		startframe = 60
	},
	exe_tbl = {
		{
			frame = 2,
			sound = {
				"24620_xp1",
				0.6
			}
		},
		{
			frame = 32,
			sound = {
				"24620_xp1",
				0.6
			}
		},
		{
			frame = 1,
			id = 24630111
		},
		{
			frame = 51,
			forceY = {
				{
					speed = 400
				}
			}
		}
	},
	action_on_complete = {
		{
			method = "remove_anti_hitdown"
		},
		{
			method = "useSkill",
			param = "xp_attack"
		}
	}
}
var_0_0.xp_attack = {
	turnbacklimit = true,
	totalframe = 66,
	animation = "xp2",
	action_on_start = {
		{
			startframe = 6,
			action = {
				{
					method = "rush_forward",
					param = {
						distance = 100,
						time = 1
					}
				}
			}
		}
	},
	exe_tbl = {
		{
			frame = 1,
			bullet = "push",
			sound = {
				"24620_xp2",
				0.6
			}
		},
		{
			id = 24630112,
			behitted = "hitdown",
			frame = 15,
			forceY = {
				{
					distance = 100,
					time = 0.4
				}
			}
		},
		{
			id = 24630113,
			behitted = "hitdown",
			frame = 36,
			forceY = {
				{
					distance = 100,
					time = 0.2
				}
			}
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 66,
	bgfile = "24630_bg",
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
			texture = "role/24630.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/24620_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 2,
			startframe = 15,
			timescale = 0.2
		},
		{
			totalframe = 3,
			startframe = 35,
			timescale = 0.2
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 66,
				startframe = 1
			}
		},
		move = {
			{
				distance = 200,
				totalframe = 61,
				startframe = 1,
				time = 0.15
			}
		}
	}
}

return var_0_0
