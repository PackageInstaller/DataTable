local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 15,
				bullet = "attack"
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
	useskill1 = {
		totalframe = 35,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 21,
				bullet = "skill1"
			}
		}
	},
	useskill2 = {
		totalframe = 35,
		animation = "skill2",
		exe_tbl = {
			{
				shake = {
					x = 4,
					y = 4
				},
				effect,
				frame = 25,
				id = 43321001
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 95,
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
			texture = "role/43302.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 27,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 43,
				startframe = 32
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 43,
				startframe = 32,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp = {
	totalframe = 96,
	xpeffect = "xp_effect",
	animation = "xp",
	exe_tbl = {
		{
			frame = 45,
			id = 43330001,
			sound = "20400_attack",
			shake = {
				x = 6,
				y = 6
			},
			force = {
				{
					time = 0.1,
					shutdown = false,
					distance = 20,
					object = "target"
				}
			}
		},
		{
			frame = 50,
			id = 43330001,
			sound = "20400_attack",
			shake = {
				x = 6,
				y = 6
			},
			force = {
				{
					time = 0.1,
					shutdown = false,
					distance = 20,
					object = "target"
				}
			}
		},
		{
			frame = 55,
			id = 43330001,
			sound = "20400_attack",
			shake = {
				x = 6,
				y = 6
			},
			force = {
				{
					time = 0.1,
					shutdown = false,
					distance = 20,
					object = "target"
				}
			}
		},
		{
			frame = 60,
			id = 43330001,
			sound = "20400_attack",
			shake = {
				x = 6,
				y = 6
			},
			force = {
				{
					time = 0.1,
					shutdown = false,
					distance = 20,
					object = "target"
				}
			}
		},
		{
			frame = 65,
			id = 43330001,
			sound = "20400_attack",
			shake = {
				x = 6,
				y = 6
			},
			force = {
				{
					time = 0.1,
					shutdown = false,
					distance = 20,
					object = "target"
				}
			}
		},
		{
			frame = 70,
			id = 43330001,
			sound = "20400_attack",
			shake = {
				x = 6,
				y = 6
			},
			force = {
				{
					time = 0.1,
					shutdown = false,
					distance = 160,
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
	speed = 500,
	offsetZ = 1,
	filename = "43302_effect",
	initpos = {
		offsetY = 0.45,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.45,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 7,
		animation = "attack",
		exe_tbl = {
			{
				id = 43310001,
				frame = 1
			}
		}
	}
}
var_0_0.extra.skill1 = {
	movingani = "skill_run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 500,
	offsetZ = 1,
	filename = "43302_effect",
	initpos = {
		offsetY = 0.45,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.45,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 12,
		animation = "skill_attack",
		exe_tbl = {
			{
				frame = 4,
				id = 43320001,
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 300,
						object = "target"
					}
				},
				shake = {
					x = 8,
					y = 0
				}
			}
		}
	}
}

return var_0_0
