local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27620_atk",
					0.6
				}
			},
			{
				frame = 6,
				bullet = "attack"
			}
		}
	},
	attack2 = {
		totalframe = 20,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27620_atk",
					0.6
				}
			},
			{
				frame = 6,
				bullet = "attack2"
			}
		}
	},
	attack3 = {
		totalframe = 20,
		animation = "attack3",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27620_atk",
					0.6
				}
			},
			{
				frame = 6,
				bullet = "attack3"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "17650_27620_effect",
	initpos = {
		offsetY = 0.3,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.4,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				id = 27610010,
				frame = 7
			}
		}
	}
}
var_0_0.extra.attack2 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "17650_27620_effect",
	initpos = {
		offsetY = 0.7,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.4,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				id = 27610010,
				frame = 7
			}
		}
	}
}
var_0_0.extra.attack3 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "17650_27620_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.4,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				id = 27610010,
				frame = 7
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
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"27620_skill",
				0.6
			}
		},
		{
			frame = 21,
			bullet = "skill"
		}
	}
}
var_0_0.extra.skill = {
	movingani = "run2",
	maxdistance = 300,
	movingtype = "lockdirection",
	speed = 500,
	offsetZ = 1,
	filename = "17650_27620_effect",
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
		totalframe = 13,
		exe_tbl = {
			{
				id = 27620010,
				frame = 5
			}
		}
	},
	destroy = {
		totalframe = 25,
		animation = "run3",
		exe_tbl = {
			{
				behitted = "hitdown",
				frame = 10,
				id = 27620011,
				effect = {
					{
						ani = "skill",
						name = "17650_27620_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"27620_skill2",
					0.6
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
	totalframe = 120,
	xpeffect = "xp_effect",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 8,
			sound = {
				"27620_xp",
				0.6
			},
			effect = {
				{
					ani = "xp",
					name = "17650_27620_effect",
					offsetZ = 0,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 27630010,
			behitted = "hitdown",
			frame = 42,
			shake = {
				x = 0,
				y = 20
			}
		},
		{
			id = 27630010,
			behitted = "hitdown",
			frame = 48,
			shake = {
				x = 0,
				y = 20
			}
		},
		{
			id = 27630010,
			behitted = "hitdown",
			frame = 54,
			shake = {
				x = 0,
				y = 20
			}
		},
		{
			id = 27630010,
			behitted = "hitdown",
			frame = 60,
			shake = {
				x = 0,
				y = 20
			}
		},
		{
			id = 27630010,
			behitted = "hitdown",
			frame = 66,
			shake = {
				x = 0,
				y = 20
			}
		},
		{
			id = 27630010,
			behitted = "hitdown",
			frame = 72,
			shake = {
				x = 0,
				y = 20
			}
		},
		{
			id = 27630010,
			behitted = "hitdown",
			frame = 80,
			shake = {
				x = 0,
				y = 20
			}
		},
		{
			id = 27630011,
			behitted = "hitdown",
			frame = 105,
			shake = {
				x = 0,
				y = 20
			}
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 0.8,
	totalframe = 120,
	bgfile = "27620_bg",
	locktarget = {
		locktargetpool = "oponent",
		locktarget = false,
		mindistance = 300
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
			texture = "role/27620.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/27620_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 65,
			timescale = 0.5
		}
	},
	camera = {
		zoom = {},
		move = {
			{
				distance = 150,
				totalframe = 90,
				startframe = 30,
				time = 0.5
			}
		}
	}
}

return var_0_0
