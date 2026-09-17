local var_0_0 = {
	attack1 = {
		totalframe = 30,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"440100-attack1",
					0.6
				}
			},
			{
				frame = 14,
				id = 44910002,
				effect = {
					{
						ani = "attack",
						name = "44000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"440100-attack2",
					0.6
				}
			},
			{
				frame = 14,
				id = 44910001,
				effect = {
					{
						ani = "attack",
						name = "44000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
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
	skill2 = {
		{
			{
				method = "useSkill",
				param = "useskill2"
			}
		}
	},
	skill3 = {
		{
			{
				method = "useSkill",
				param = "useskill3"
			}
		}
	},
	useskill1 = {
		totalframe = 22,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"440200-skill1",
					0.6
				}
			},
			{
				id = 44920001,
				frame = 10
			}
		}
	},
	useskill2 = {
		totalframe = 28,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"440210-skill2",
					0.6
				}
			},
			{
				frame = 13,
				behitted = "hitdown",
				id = 44930001,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 50,
						object = "target"
					}
				}
			}
		}
	},
	useskill3 = {
		totalframe = 25,
		animation = "skill3",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"440220-skill3",
					0.6
				}
			},
			{
				frame = 15,
				id = 44940001,
				effect = {
					{
						ani = "attack",
						name = "44000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 17,
				id = 44940002,
				effect = {
					{
						ani = "attack",
						name = "44000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "usexp"
			}
		}
	},
	xpeffect = {}
}

var_0_0.xpeffect.test = {
	totalframe = 75,
	bgfile = "44080_bg",
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	},
	inserteffect = {
		{
			texture = "role/44020.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 55,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 32,
				startframe = 28
			}
		},
		move = {
			{
				distance = 400,
				totalframe = 40,
				startframe = 30,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp = {
	exe_crash_type = "carry",
	animation = "xp2",
	exe_crash_bound = 75,
	exe_type = "crash",
	totalframe = 80,
	nextani = true,
	lock_screen = {
		startframe = 60,
		lastframe = 105
	},
	action_on_start = {
		{
			startframe = 60,
			action = {
				{
					method = "rush_forward",
					param = {
						distance = 400,
						time = 0.6
					}
				}
			}
		}
	},
	sound = {
		frame = 15,
		volume = 0.6,
		file = "440300-xp"
	},
	xpeffect = {
		conf = "test",
		startframe = 30
	},
	exe_tbl = {
		{
			id = 44950001
		}
	},
	exe_tbl = {
		{
			id = 44900000,
			frame = 1,
			sound = {
				"invalid",
				1.6
			}
		}
	},
	action_on_complete = {
		{
			method = "useSkill",
			param = "usexp2"
		}
	}
}
var_0_0.usexp2 = {
	totalframe = 26,
	exe_tbl = {
		{
			behitted = "hitdown",
			frame = 5,
			id = 44960001,
			shake = {
				x = 4,
				y = 10
			},
			sound = {
				"zaxia",
				0.4
			}
		}
	}
}

return var_0_0
