local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21020-attack",
					0.6
				}
			},
			{
				id = 21010001,
				frame = 10
			}
		}
	},
	attack2 = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21020-attack",
					0.6
				}
			},
			{
				id = 21010001,
				frame = 10
			}
		}
	},
	attack3 = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21020-attack",
					0.6
				}
			},
			{
				id = 21010001,
				frame = 10
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
		totalframe = 54,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21020-skill",
					0.6
				}
			},
			{
				frame = 17,
				behitted = "hit",
				id = 21022001
			},
			{
				frame = 37,
				behitted = "hit",
				id = 21022001
			}
		}
	},
	skill1_1 = {
		{
			{
				method = "useSkill",
				param = "useskill1_1"
			}
		}
	},
	useskill1_1 = {
		totalframe = 54,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21020-skill",
					0.6
				}
			},
			{
				frame = 17,
				behitted = "hit",
				id = 21022101
			},
			{
				frame = 37,
				behitted = "hit",
				id = 21022101
			}
		}
	},
	skill1_2 = {
		{
			{
				method = "useSkill",
				param = "useskill1_2"
			}
		}
	},
	useskill1_2 = {
		totalframe = 54,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21020-skill",
					0.6
				}
			},
			{
				frame = 17,
				behitted = "hit",
				id = 21022201
			},
			{
				frame = 37,
				behitted = "hit",
				id = 21022201
			}
		}
	},
	skill1_3 = {
		{
			{
				method = "useSkill",
				param = "useskill1_3"
			}
		}
	},
	useskill1_3 = {
		totalframe = 54,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21020-skill",
					0.6
				}
			},
			{
				frame = 17,
				behitted = "hit",
				id = 21022301
			},
			{
				frame = 37,
				behitted = "hit",
				id = 21022301
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
	usexp = {
		totalframe = 138,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21020-xp",
					0.6
				}
			},
			{
				frame = 5,
				shake = {
					x = 4,
					y = 8
				}
			},
			{
				frame = 70,
				bullet = "xp"
			},
			{
				frame = 85,
				bullet = "xp2"
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 137,
	bgfile = "21020_bg",
	locktarget = {
		mindistance = 150,
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "21020_bg"
		}
	},
	inserteffect = {
		{
			texture = "role/21020.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/21020_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {
			{
				scale = 1.2,
				totalframe = 62,
				startframe = 2
			},
			{
				scale = 0.8,
				totalframe = 59,
				startframe = 66
			}
		},
		move = {
			{
				distance = 240,
				totalframe = 59,
				startframe = 66,
				time = 0.1
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "xp_run",
	maxdistance = 300,
	movingtype = "lockdirection",
	speed = 600,
	offsetZ = 1,
	filename = "21020_effect",
	initpos = {
		offsetY = 0,
		offsetX = 0.75,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "carry",
		direction = 1
	},
	attack = {
		totalframe = 40,
		animation = "xp_attack",
		exe_tbl = {
			{
				id = 21050001,
				frame = 5,
				effect = {
					{
						ani = "attack",
						name = "21020_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.xp2 = {
	movingani = "xp_run",
	maxdistance = 100,
	movingtype = "lockdirection",
	speed = 1000,
	offsetZ = 1,
	filename = "21020_effect",
	initpos = {
		offsetY = 0,
		offsetX = 8,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "once",
		direction = 1
	},
	attack = {
		totalframe = 40,
		animation = "xp_attack",
		exe_tbl = {
			{
				id = 21050001,
				frame = 5,
				effect = {
					{
						ani = "attack",
						name = "21020_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0.3,
						shutdown = false,
						distance = 36,
						object = "target"
					}
				}
			},
			{
				id = 21050001,
				frame = 15,
				effect = {
					{
						ani = "attack",
						name = "21020_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0.3,
						shutdown = false,
						distance = 36,
						object = "target"
					}
				}
			},
			{
				id = 21050001,
				frame = 25,
				effect = {
					{
						ani = "attack",
						name = "21020_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0.3,
						shutdown = false,
						distance = 36,
						object = "target"
					}
				}
			},
			{
				id = 21050001,
				frame = 35,
				effect = {
					{
						ani = "attack",
						name = "21020_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0.3,
						shutdown = false,
						distance = 36,
						object = "target"
					}
				}
			}
		}
	}
}

return var_0_0
