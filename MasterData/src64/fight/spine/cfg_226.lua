local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				frame = 8,
				bullet = "attack",
				sound = {
					"nengliang",
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
	skill1 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	useskill1 = {
		totalframe = 20,
		animation = "skill",
		exe_tbl = {
			{
				id = 22620001,
				frame = 13,
				sound = {
					"jiguang1",
					0.6
				}
			}
		}
	},
	usexp = {
		totalframe = 106,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = "xp"
			},
			{
				id = 22630001,
				frame = 42,
				sound = {
					"fire2",
					0.6
				}
			},
			{
				id = 22630001,
				frame = 47,
				sound = {
					"fire2",
					0.6
				}
			},
			{
				id = 22630001,
				frame = 54,
				sound = {
					"fire2",
					0.6
				}
			},
			{
				id = 22630001,
				frame = 60,
				sound = {
					"fire2",
					0.6
				}
			},
			{
				id = 22630001,
				frame = 85,
				sound = {
					"fire2",
					0.6
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 105,
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
			texture = "role/22620.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		totalframe = 7,
		startframe = 85,
		timescale = 0.15
	},
	camera = {
		zoom = {
			{
				startframe = 25,
				scale = 0.8,
				outtime = 0.3,
				totalframe = 75,
				intime = 0.1
			}
		},
		move = {
			{
				distance = 220,
				totalframe = 65,
				startframe = 25,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp1 = {
	totalframe = 106,
	xpeffect = "xp_effect1",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = "xp"
		},
		{
			id = 22650001,
			frame = 42,
			shake = {
				x = 2,
				y = 5
			},
			sound = {
				"fire2",
				0.6
			}
		},
		{
			id = 22650001,
			frame = 47,
			shake = {
				x = 2,
				y = 5
			},
			sound = {
				"fire2",
				0.6
			}
		},
		{
			id = 22650001,
			frame = 54,
			shake = {
				x = 2,
				y = 5
			},
			sound = {
				"fire2",
				0.6
			}
		},
		{
			id = 22650001,
			frame = 60,
			shake = {
				x = 2,
				y = 5
			},
			sound = {
				"fire2",
				0.6
			}
		},
		{
			id = 22650001,
			frame = 78,
			shake = {
				x = 2,
				y = 5
			},
			sound = {
				"fire2",
				0.6
			}
		},
		{
			id = 22650001,
			frame = 81,
			shake = {
				x = 3,
				y = 5
			},
			sound = {
				"fire2",
				0.6
			}
		},
		{
			id = 22650001,
			frame = 85,
			shake = {
				x = 3,
				y = 5
			},
			sound = {
				"fire2",
				0.6
			}
		},
		{
			id = 22650001,
			frame = 89,
			shake = {
				x = 3,
				y = 5
			},
			sound = {
				"fire2",
				0.6
			}
		},
		{
			behitted = "hitdown",
			id = 22650001,
			frame = 96,
			shake = {
				x = 4,
				y = 6
			},
			sound = {
				"fire2",
				0.6
			}
		}
	}
}
var_0_0.xpeffect.xp_effect1 = {
	totalframe = 105,
	bgfile = "22600_bg",
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
			texture = "role/22620.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	bgaction = {
		{
			param = 99,
			startframe = 0,
			action = "setZOrder"
		},
		{
			param = 0,
			startframe = 27,
			action = "setZOrder"
		}
	},
	lockframe = {
		{
			totalframe = 2,
			startframe = 74,
			timescale = 0.2
		},
		{
			totalframe = 3,
			startframe = 96,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				startframe = 0,
				scale = 1.3,
				anchory = 200,
				outtime = 0.1,
				totalframe = 35,
				intime = 0.2
			},
			{
				startframe = 27,
				scale = 0.9,
				anchory = 300,
				outtime = 0.3,
				totalframe = 65,
				intime = 0.2
			},
			{
				startframe = 96,
				scale = 1,
				anchory = 300,
				outtime = 0.2,
				totalframe = 23,
				intime = 0.6
			}
		},
		move = {
			{
				distance = 110,
				totalframe = 50,
				startframe = 27,
				time = 0.2
			},
			{
				distance = 190,
				totalframe = 25,
				startframe = 77,
				time = 0.6
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 600,
	movingtype = "locktarget",
	speed = 900,
	offsetZ = 1,
	filename = "22600_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0.6,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.1,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 22610001
			}
		}
	}
}

return var_0_0
