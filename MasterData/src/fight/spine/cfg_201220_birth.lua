local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"201220_attack",
					0.6
				}
			},
			{
				id = 201210010,
				frame = 20,
				effect = {
					{
						ani = "attack",
						name = "101250_201220_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"201220_attack",
					0.6
				}
			},
			{
				id = 201210010,
				frame = 20,
				effect = {
					{
						ani = "attack",
						name = "101250_201220_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
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
	skill1 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	useskill1 = {
		totalframe = 60,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"201220_skill",
					0.6
				}
			},
			{
				id = 201220010,
				behitted = "hitdown",
				frame = 28,
				forceY = {
					{
						speed = 400
					}
				},
				force = {
					{
						time = 0.1,
						distance = 0,
						object = "target"
					}
				}
			},
			{
				id = 201220011,
				frame = 44,
				forceY = {
					{
						speed = -400
					}
				}
			},
			{
				frame = 55,
				id = 201220013
			},
			{
				frame = 56,
				id = 201220014
			}
		}
	},
	usexp = {
		turnbacklimit = true,
		xpeffect = "xp_effect",
		totalframe = 90,
		animation = "xp4",
		action_on_start = {
			{
				method = "rush_to_target",
				param = {
					frame = 5,
					posx = 50
				}
			},
			startframe = 10
		},
		exe_tbl = {
			{
				frame = 4,
				bullet = "xp",
				sound = {
					"22320_skill",
					1
				}
			},
			{
				frame = 20,
				sound = {
					"201220_xp",
					1
				}
			},
			{
				id = 201230010,
				behitted = "hitdown",
				frame = 17,
				forceY = {
					{
						speed = 1000
					}
				},
				force = {
					{
						time = 0.1,
						distance = 0,
						object = "target"
					}
				}
			},
			{
				id = 201230010,
				behitted = "hitdown",
				frame = 30,
				forceY = {
					{
						speed = 400
					}
				}
			},
			{
				id = 201230010,
				behitted = "hitdown",
				frame = 40,
				forceY = {
					{
						speed = 400
					}
				},
				force = {
					{
						time = 0.1,
						distance = 0,
						object = "target"
					}
				}
			},
			{
				id = 201230010,
				behitted = "hitdown",
				frame = 50,
				forceY = {
					{
						speed = -300
					}
				},
				force = {
					{
						time = 0.1,
						distance = 0,
						object = "target"
					}
				}
			},
			{
				frame = 70,
				behitted = "hitdown",
				id = 201230011,
				force = {
					{
						time = 0.1,
						distance = 150,
						object = "target"
					}
				},
				forceY = {
					{
						speed = 500
					}
				}
			},
			{
				frame = 91,
				id = 201230013
			},
			{
				frame = 92,
				id = 201220014
			},
			{
				frame = 85,
				id = 201230012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 90,
	bgfile = "201220_bg",
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
			texture = "role/201220.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/201220_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 7,
			startframe = 15,
			timescale = 0.3
		},
		{
			totalframe = 5,
			startframe = 55,
			timescale = 0.3
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.95,
				totalframe = 70,
				startframe = 15
			}
		},
		move = {
			{
				distance = 300,
				totalframe = 80,
				startframe = 5,
				time = 2
			}
		},
		moveY = {
			{
				distance = 300,
				totalframe = 80,
				startframe = 5,
				time = 2
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "run",
	maxdistance = 200,
	movingtype = "lockdirection",
	speed = 200,
	offsetZ = 1,
	filename = "26100_effect",
	initpos = {
		offsetY = 0,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "carry",
		direction = 1
	},
	attack = {
		animation = "skill2",
		totalframe = 15
	}
}

return var_0_0
