local var_0_0 = {
	xpeffect = {},
	extra = {},
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 15,
				bullet = "attack",
				sound = {
					"240_atk",
					1
				}
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1500,
	offsetZ = 1,
	filename = "110150_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 0.31,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.66,
		offsetX = 0.3,
		object = "target"
	},
	attack = {
		totalframe = 9,
		animation = "attack",
		exe_tbl = {
			{
				id = 11015021,
				frame = 1,
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
var_0_0.useskill1 = {
	totalframe = 30,
	turnbacklimit = true,
	animation = "skill2",
	exe_tbl = {
		{
			id = 11015031,
			frame = 20,
			sound = {
				"11970_21900_skill",
				0.6
			}
		}
	}
}
var_0_0.useskill2 = {
	totalframe = 40,
	animation = "skill3",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"21000_skill",
				1
			}
		},
		{
			id = 11015041,
			frame = 20,
			shake = {
				x = 4,
				y = 4
			}
		},
		{
			behitted = "hitdown",
			frame = 22,
			force = {
				{
					time = 0.3,
					shutdown = false,
					distance = 300,
					object = "target"
				}
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
	totalframe = 102,
	xpeffect = "xp_effect",
	animation = "xp",
	exe_tbl = {
		{
			frame = 30,
			sound = {
				"boom",
				1
			},
			forceY = {
				{
					speed = 1200
				}
			}
		},
		{
			id = 11015052,
			behitted = "hit",
			frame = 40,
			forceY = {
				{
					speed = 400
				}
			}
		},
		{
			id = 11015052,
			behitted = "hit",
			frame = 50,
			forceY = {
				{
					speed = 400
				}
			}
		},
		{
			id = 11015052,
			behitted = "hitdown",
			frame = 60,
			forceY = {
				{
					speed = 300
				}
			}
		},
		{
			frame = 63,
			forceY = {
				{
					speed = -1600
				}
			}
		},
		{
			behitted = "hitdown",
			frame = 85,
			id = 11015051,
			shake = {
				x = 4,
				y = 4
			},
			sound = {
				"20500_XP2",
				0.6
			}
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 110,
	bgfile = "43000_bg",
	locktarget = {
		locktarget = true
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
			texture = "role/110150.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 7,
			startframe = 61,
			timescale = 0.2
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 30,
				startframe = 15
			}
		},
		move = {
			{
				distance = 150,
				totalframe = 65,
				startframe = 15,
				time = 0.2
			}
		}
	}
}

return var_0_0
