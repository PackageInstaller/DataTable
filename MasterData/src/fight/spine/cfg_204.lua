local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 14,
		animation = "attack",
		exe_tbl = {
			{
				frame = 8,
				bullet = "attack",
				sound = {
					"jiguang",
					0.6
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
	xp1 = {
		{
			{
				method = "useSkill",
				param = "usexp1"
			}
		}
	},
	xp2 = {
		{
			{
				method = "useSkill",
				param = "usexp2"
			}
		}
	},
	xp3 = {
		{
			{
				method = "useSkill",
				param = "usexp3"
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
		totalframe = 30,
		animation = "skill1",
		exe_tbl = {
			{
				id = 20420001,
				frame = 20,
				sound = {
					"jiguang1",
					0.6
				}
			}
		}
	},
	xpeffect = {}
}

var_0_0.xpeffect.test = {
	totalframe = 77,
	bgfile = "44000_bg",
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
			texture = "role/20405.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		totalframe = 3,
		startframe = 44,
		timescale = 0.1
	}
}
var_0_0.usexp = {
	xpeffect = "test",
	totalframe = 77,
	animation = "xp2",
	lock_screen = {
		texture = "role/20405.png",
		lastframe = 30,
		zorder = 200,
		file = "xp2",
		startframe = 0,
		ani = "xp"
	},
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"xp",
				0.6
			}
		},
		{
			behitted = "hitdown",
			id = 20430001,
			frame = 45,
			force = {
				{
					time = 0.1,
					shutdown = false,
					distance = 50,
					object = "target"
				}
			},
			shake = {
				x = 20,
				y = 0
			},
			sound = {
				"jiguang1",
				0.6
			}
		}
	}
}
var_0_0.usexp1 = {
	xpeffect = "test",
	totalframe = 77,
	animation = "xp2",
	lock_screen = {
		texture = "role/20403.png",
		lastframe = 30,
		zorder = 200,
		file = "xp2",
		startframe = 0,
		ani = "xp"
	},
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"xp",
				0.6
			}
		},
		{
			behitted = "hitdown",
			id = 20433001,
			frame = 45,
			force = {
				{
					time = 0.1,
					shutdown = false,
					distance = 50,
					object = "target"
				}
			},
			shake = {
				x = 20,
				y = 0
			},
			sound = {
				"jiguang1",
				0.6
			}
		}
	}
}
var_0_0.usexp2 = {
	xpeffect = "test",
	totalframe = 77,
	animation = "xp2",
	lock_screen = {
		texture = "role/20405.png",
		lastframe = 30,
		zorder = 200,
		file = "xp2",
		startframe = 0,
		ani = "xp"
	},
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"xp",
				0.6
			}
		},
		{
			behitted = "hitdown",
			id = 20430001,
			frame = 45,
			force = {
				{
					time = 0.1,
					shutdown = false,
					distance = 50,
					object = "target"
				}
			},
			shake = {
				x = 20,
				y = 0
			},
			sound = {
				"jiguang1",
				0.6
			}
		}
	}
}
var_0_0.usexp3 = {
	xpeffect = "test",
	totalframe = 77,
	animation = "xp2",
	lock_screen = {
		texture = "role/20410.png",
		lastframe = 30,
		zorder = 200,
		file = "xp2",
		startframe = 0,
		ani = "xp"
	},
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"xp",
				0.6
			}
		},
		{
			behitted = "hitdown",
			id = 20440001,
			frame = 45,
			force = {
				{
					time = 0.1,
					shutdown = false,
					distance = 50,
					object = "target"
				}
			},
			shake = {
				x = 20,
				y = 0
			},
			sound = {
				"jiguang1",
				0.6
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
	filename = "20400_effect",
	initpos = {
		offsetY = 0.65,
		offsetX = 1.75,
		object = "self"
	},
	finalpos = {
		offsetY = 0.65,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 13,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 20410001,
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 10,
						object = "target"
					}
				}
			}
		}
	}
}

return var_0_0
