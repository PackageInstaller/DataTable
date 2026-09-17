local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 22,
				bullet = "attack",
				sound = {
					"20400_attack",
					0.6
				},
				sound = {
					"20400_attack",
					0.6
				}
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 12,
				bullet = "attack2",
				sound = {
					"20400_attack",
					0.6
				},
				sound = {
					"20400_attack",
					0.6
				}
			}
		}
	},
	ocskill1 = {
		{
			{
				method = "useSkill",
				param = "useocskill1"
			}
		}
	},
	ocskill2 = {
		{
			{
				method = "useSkill",
				param = "useocskill2"
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
	useocskill1 = {
		totalframe = 45,
		animation = "skill",
		exe_tbl = {
			{
				id = 2016601010,
				frame = 25
			}
		}
	},
	useocskill2 = {
		totalframe = 45,
		animation = "skill2",
		exe_tbl = {
			{
				id = 2016601011,
				frame = 35
			}
		}
	},
	useskill1 = {
		totalframe = 60,
		animation = "skill3",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"201620_skill",
					0.6
				}
			},
			{
				behitted = "hitdown",
				id = 201620010,
				frame = 25,
				force = {
					{
						time = 0.6,
						shutdown = false,
						distance = 150,
						object = "target"
					}
				}
			},
			{
				id = 201620011,
				frame = 50
			}
		}
	},
	usexp = {
		totalframe = 160,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"201620_xp",
					0.6
				}
			},
			{
				frame = 90,
				effect = {
					{
						ani = "xp",
						name = "101600_201620_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 100,
				behitted = "hitdown",
				id = 201630010,
				forceY = {
					{
						speed = 300
					}
				},
				sound = {
					"horn_fire",
					0.6
				}
			},
			{
				frame = 105,
				behitted = "hitdown",
				id = 201630010,
				forceY = {
					{
						speed = 400
					}
				},
				sound = {
					"horn_fire",
					0.6
				}
			},
			{
				frame = 110,
				behitted = "hitdown",
				id = 201630010,
				forceY = {
					{
						speed = 600
					}
				},
				sound = {
					"horn_fire",
					0.6
				}
			},
			{
				id = 201630010,
				behitted = "hitdown",
				frame = 115,
				forceY = {
					{
						speed = 800
					}
				},
				sound = {
					"horn_fire",
					0.6
				}
			},
			{
				id = 201630011,
				behitted = "hitdown",
				frame = 120,
				forceY = {
					{
						speed = 600
					}
				},
				sound = {
					"horn_fire",
					0.6
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "201620_bg",
	totalframe = 160,
	locktarget = {
		locktargetpool = "oponent",
		locktarget = false
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "xp"
		}
	},
	inserteffect = {
		{
			texture = "role/201620.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/Umaru_05",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		zoom = {
			{
				startframe = 0,
				scale = 0.8,
				anchory = 200,
				outtime = 0.1,
				totalframe = 160,
				intime = 0.2
			}
		},
		move = {
			{
				distance = 1,
				time = 0,
				distanceY = -50,
				totalframe = 55,
				startframe = 0
			},
			{
				pos = "target",
				totalframe = 60,
				startframe = 100,
				time = 0.4
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run_1",
	maxdistance = 600,
	movingtype = "locktarget",
	speed = 900,
	offsetZ = 1,
	filename = "101630_201620_effect",
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
				id = 201610010
			}
		}
	}
}
var_0_0.extra.attack2 = {
	movingani = "run",
	maxdistance = 600,
	movingtype = "locktarget",
	speed = 900,
	offsetZ = 1,
	filename = "101630_201620_effect",
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
				id = 201610010
			},
			{
				id = 201610011,
				behitted = "hitdown",
				frame = 3
			}
		}
	}
}

return var_0_0
