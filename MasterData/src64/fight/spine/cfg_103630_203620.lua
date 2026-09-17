local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203620_attack2",
					0.6
				}
			},
			{
				frame = 5,
				bullet = "attack"
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203620_attack1",
					0.6
				}
			},
			{
				frame = 5,
				bullet = "attack"
			},
			{
				frame = 20,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "103630_203620_effect",
	initpos = {
		offsetY = 0.3,
		offsetX = 1,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 17,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 203610010
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
var_0_0.useskill1 = {
	totalframe = 60,
	turnbacklimit = true,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"203620_skill",
				0.6
			}
		},
		{
			frame = 22,
			bullet = "skill1"
		},
		{
			frame = 43,
			bullet = "skill1_luodi"
		}
	},
	action_on_complete = {
		{
			method = "useSkill",
			param = "attack_shangdan"
		}
	}
}
var_0_0.extra.skill1 = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "103630_203620_effect",
	initpos = {
		offsetY = 1,
		offsetX = 0.1,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 17,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 203620010
			}
		}
	}
}
var_0_0.extra.skill1_luodi = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "103630_203620_effect",
	initpos = {
		offsetY = 0.24,
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
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 203620010
			}
		}
	}
}
var_0_0.attack_shangdan = {
	turnbacklimit = true,
	totalframe = 30,
	animation = "skill_shangdan"
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
	turnbacklimit = true,
	xpeffect = "xp_effect",
	totalframe = 115,
	animation = "xp",
	action_on_start = {
		{
			startframe = 15,
			action = {
				{
					method = "rush_forward",
					param = {
						distance = 350,
						time = 0.3
					}
				}
			}
		}
	},
	exe_tbl = {
		{
			frame = 20,
			sound = {
				"203620_xp",
				1
			}
		},
		{
			frame = 12,
			id = 203630011
		},
		{
			frame = 5,
			effect = {
				{
					ani = "xp1",
					name = "103630_203620_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 0,
					object = "self"
				}
			}
		},
		{
			frame = 30,
			bullet = "xp1"
		},
		{
			frame = 30,
			bullet = "xp2"
		},
		{
			id = 203630010,
			frame = 31,
			effect = {
				{
					ani = "attack",
					name = "103630_203620_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0.5,
					object = "target"
				}
			},
			shake = {
				period = 5,
				time = 0.2,
				x = 10,
				y = 20
			}
		},
		{
			id = 203630010,
			frame = 39,
			effect = {
				{
					ani = "attack",
					name = "103630_203620_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0.5,
					object = "target"
				}
			},
			shake = {
				period = 5,
				time = 0.2,
				x = 10,
				y = 20
			}
		},
		{
			id = 203630010,
			frame = 75,
			effect = {
				{
					ani = "attack",
					name = "103630_203620_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0.5,
					object = "target"
				}
			},
			shake = {
				period = 5,
				time = 0.2,
				x = 10,
				y = 20
			}
		},
		{
			id = 203630010,
			behitted = "hitdown",
			frame = 86,
			effect = {
				{
					ani = "attack",
					name = "103630_203620_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0.5,
					object = "target"
				}
			},
			shake = {
				period = 5,
				time = 0.2,
				x = 10,
				y = 20
			}
		}
	},
	action_on_complete = {
		{
			method = "useSkill",
			param = "xuwu"
		}
	}
}
var_0_0.extra.xp1 = {
	movingani = "run",
	maxdistance = 100,
	movingtype = "lockdirection",
	speed = 50,
	offsetZ = 1,
	filename = "26100_effect",
	initpos = {
		offsetY = 0,
		offsetX = 1,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "carry",
		direction = 1
	},
	attack = {
		animation = "skill2",
		totalframe = 60
	}
}
var_0_0.skill_back = {
	{
		{
			method = "useSkill",
			param = "useback"
		}
	}
}
var_0_0.extra.xp2 = {
	movingani = "run",
	maxdistance = 60,
	movingtype = "lockdirection",
	speed = 30,
	offsetZ = 1,
	filename = "26100_effect",
	initpos = {
		offsetY = 0,
		offsetX = -1,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "carry",
		direction = -1
	},
	attack = {
		animation = "skill2",
		totalframe = 60
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	totalframe = 127,
	bgfile = "203620_bg",
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "bg"
		}
	},
	locktarget = {
		locktargetpool = "oponent"
	},
	inserteffect = {
		{
			texture = "role/203620.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 10,
			startframe = 68,
			timescale = 0.5
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 40,
				startframe = 30
			},
			{
				scale = 1.2,
				totalframe = 30,
				startframe = 70
			}
		},
		move = {
			{
				distance = 200,
				totalframe = 80,
				startframe = 15,
				time = 0.4
			}
		}
	}
}
var_0_0.xuwu = {
	totalframe = 12,
	animation = "xp2",
	action_on_start = {
		{
			startframe = 1,
			action = {
				{
					method = "rush_forward",
					param = {
						distance = -350,
						time = 0.4
					}
				}
			}
		}
	}
}

return var_0_0
