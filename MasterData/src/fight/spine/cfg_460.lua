local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"460100-attack",
					0.6
				}
			},
			{
				frame = 5,
				bullet = "attack"
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
		totalframe = 30,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"460200-skill1",
					0.6
				}
			},
			{
				id = 46020001,
				frame = 21,
				shake = {
					x = 4,
					y = 0
				},
				effect = {
					{
						ani = "skill2_attack",
						name = "46000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	useskill2 = {
		totalframe = 20,
		animation = "skill3",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"460210-skill2",
					0.6
				}
			},
			{
				id = 46021001,
				frame = 15
			}
		}
	},
	useskill3 = {
		totalframe = 39,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"460220-skill3",
					0.6
				}
			},
			{
				frame = 5,
				bullet = "skill3_1",
				shake = {
					x = 6,
					y = 0
				}
			},
			{
				frame = 28,
				bullet = "skill3_2"
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 50,
	bgfile = "46000_bg",
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
			texture = "role/46000.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 25,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 30,
				startframe = 10
			}
		},
		move = {
			{
				distance = 200,
				totalframe = 30,
				startframe = 10,
				time = 0.1
			}
		}
	}
}
var_0_0.xp = {
	{
		{
			method = "useSkill",
			param = "qianyao"
		}
	}
}
var_0_0.qianyao = {
	totalframe = 22,
	nextani = true,
	animation = "win",
	action_on_start = {
		{
			startframe = 1,
			action = {
				{
					method = "rush_forward",
					param = {
						distance = -50,
						time = 0.33
					}
				}
			}
		}
	},
	xpeffect = {
		conf = "xp_effect",
		startframe = 30
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
			param = "usexp"
		}
	}
}
var_0_0.usexp = {
	totalframe = 51,
	xpeffect = "xp_effect",
	animation = "xp2",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"460300-xp",
				0.6
			}
		},
		{
			id = 46030001,
			frame = 20,
			shake = {
				x = 4,
				y = 4
			},
			effect = {
				{
					ani = "xp_attack",
					name = "46000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 46030001,
			frame = 29,
			shake = {
				x = 4,
				y = 4
			},
			effect = {
				{
					ani = "xp_attack",
					name = "46000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 46030001,
			frame = 35,
			shake = {
				x = 4,
				y = 4
			},
			effect = {
				{
					ani = "xp_attack",
					name = "46000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 46030001,
			frame = 42,
			shake = {
				x = 4,
				y = 4
			},
			effect = {
				{
					ani = "xp_attack",
					name = "46000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "46000_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 0.35,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 7,
		animation = "attack",
		exe_tbl = {
			{
				id = 46010001,
				frame = 1
			}
		}
	}
}
var_0_0.extra.skill3_1 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "46000_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 0.35,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 7,
		animation = "skill2_attack",
		exe_tbl = {
			{
				frame = 1,
				id = 46022001,
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 300,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.skill3_2 = {
	movingani = "xp_run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "46000_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 0.35,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 7,
		animation = "skill2_attack",
		exe_tbl = {
			{
				id = 46022002,
				frame = 1
			}
		}
	}
}

return var_0_0
