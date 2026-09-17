local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 4,
				sound = {
					"23120_attack",
					0.6
				}
			},
			{
				frame = 12,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run_attack",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "202320_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 9,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 202310010
			}
		}
	}
}
var_0_0.attack2 = {
	totalframe = 30,
	animation = "attack",
	exe_tbl = {
		{
			frame = 4,
			sound = {
				"23120_attack",
				0.6
			}
		},
		{
			frame = 12,
			bullet = "attack"
		},
		{
			frame = 18,
			bullet = "attack2"
		}
	}
}
var_0_0.extra.attack2 = {
	movingani = "run_attack",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "202320_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 9,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 202310011
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
	totalframe = 45,
	turnbacklimit = true,
	animation = "skill",
	exe_tbl = {
		{
			frame = 33,
			sound = {
				"27620_skill2",
				1
			}
		},
		{
			frame = 36,
			id = 202320012
		},
		{
			id = 202320010,
			frame = 36,
			effect = {
				{
					ani = "skill",
					name = "202320_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0.5,
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
	totalframe = 45,
	turnbacklimit = true,
	animation = "skill2",
	exe_tbl = {
		{
			frame = 20,
			sound = {
				"26220_skill",
				1
			}
		},
		{
			frame = 26,
			id = 202320013
		},
		{
			frame = 27,
			bullet = "skill2"
		}
	}
}
var_0_0.extra.skill2 = {
	movingani = "run_skill2",
	maxdistance = 640,
	movingtype = "lockdirection",
	speed = 600,
	offsetZ = 1,
	filename = "202320_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "cross",
		direction = 1
	},
	attack = {
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 202320011
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
	totalframe = 100,
	xpeffect = "xp_effect",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 10,
			sound = {
				"28420_xp",
				1
			}
		},
		{
			id = 202330010,
			frame = 71,
			effect = {
				{
					ani = "xp",
					name = "202320_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0.5,
					object = "target"
				}
			},
			shake = {
				period = 2,
				time = 0.2,
				x = 10,
				y = 10
			}
		},
		{
			id = 202330010,
			frame = 82,
			effect = {
				{
					ani = "xp",
					name = "202320_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0.5,
					object = "target"
				}
			}
		},
		{
			id = 202330010,
			frame = 91,
			effect = {
				{
					ani = "xp",
					name = "202320_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0.5,
					object = "target"
				}
			},
			shake = {
				period = 2,
				time = 0.2,
				x = 10,
				y = 10
			}
		}
	}
}
var_0_0.xp_zhimang = {
	{
		{
			method = "useSkill",
			param = "usexp_zhimang"
		}
	}
}
var_0_0.usexp_zhimang = {
	totalframe = 100,
	xpeffect = "xp_effect",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 10,
			sound = {
				"28420_xp",
				1
			}
		},
		{
			id = 202330010,
			frame = 71,
			effect = {
				{
					ani = "xp",
					name = "202320_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0.5,
					object = "target"
				}
			},
			shake = {
				period = 2,
				time = 0.2,
				x = 10,
				y = 10
			}
		},
		{
			id = 202330010,
			frame = 82,
			effect = {
				{
					ani = "xp",
					name = "202320_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0.5,
					object = "target"
				}
			}
		},
		{
			id = 202330011,
			frame = 91,
			effect = {
				{
					ani = "xp",
					name = "202320_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0.5,
					object = "target"
				}
			},
			shake = {
				period = 2,
				time = 0.2,
				x = 10,
				y = 10
			}
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	focusoffset = 0,
	bgfilescale = 1,
	bgfile = "202320_bg",
	totalframe = 100,
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "bg"
		}
	},
	locktarget = {
		locktarget = "openent"
	},
	inserteffect = {
		{
			texture = "role/202320.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/202320_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 1,
			startframe = 55,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.9,
				totalframe = 53,
				startframe = 42
			}
		},
		move = {
			{
				distance = 250,
				time = 0.4,
				distanceY = 200,
				totalframe = 58,
				startframe = 42
			},
			{
				distanceY = -200,
				totalframe = 30,
				startframe = 65,
				time = 0.3
			}
		}
	}
}

return var_0_0
