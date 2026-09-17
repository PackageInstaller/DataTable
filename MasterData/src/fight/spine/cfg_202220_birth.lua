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
					"202220_attack",
					0.6
				}
			},
			{
				id = 202210010,
				frame = 18,
				effect = {
					{
						ani = "attack",
						name = "102250_202220_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
						object = "target"
					}
				}
			}
		}
	},
	attack2 = {
		{
			{
				method = "useSkill",
				param = "attack2_1"
			}
		}
	},
	attack2_1 = {
		turnbacklimit = true,
		exe_crash_type = "carry",
		exe_type = "crash",
		totalframe = 30,
		animation = "attack2",
		action_on_start = {
			{
				startframe = 15,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 150,
							time = 0.2
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"202220_attack",
					0.6
				}
			},
			{
				id = 202210011,
				frame = 17,
				shake = {
					x = 2,
					y = 0
				},
				effect = {
					{
						ani = "attack",
						name = "102250_202220_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
						object = "target"
					}
				}
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
		totalframe = 45,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"202220_skill",
					0.6
				}
			},
			{
				id = 202220010,
				frame = 19,
				effect = {
					{
						ani = "attack",
						name = "102250_202220_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
						object = "target"
					}
				}
			},
			{
				id = 202220010,
				frame = 39,
				effect = {
					{
						ani = "attack",
						name = "102250_202220_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
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
	usexp = {
		totalframe = 90,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 20,
				sound = {
					"202220_xp",
					1
				}
			},
			{
				behitted = "hitdown",
				id = 202230010,
				frame = 26,
				forceY = {
					{
						speed = 600
					}
				},
				shake = {
					x = 6,
					y = 6
				}
			},
			{
				behitted = "hitdown",
				id = 202230010,
				frame = 37,
				forceY = {
					{
						speed = 400
					}
				},
				shake = {
					x = 6,
					y = 6
				}
			},
			{
				behitted = "hitdown",
				id = 202230010,
				frame = 39,
				forceY = {
					{
						speed = 400
					}
				},
				shake = {
					x = 6,
					y = 6
				}
			},
			{
				id = 202230010,
				behitted = "hitdown",
				frame = 51,
				shake = {
					x = 6,
					y = 6
				}
			},
			{
				id = 202230011,
				behitted = "hitdown",
				frame = 72,
				forceY = {
					{
						speed = 600
					}
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	totalframe = 90,
	bgfile = "102250_202220_bg",
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
			texture = "role/202220.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/202220_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 10,
			startframe = 65,
			timescale = 0.6
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
				distance = 100,
				totalframe = 80,
				startframe = 5,
				time = 2
			}
		},
		moveY = {
			{
				distance = 200,
				totalframe = 80,
				startframe = 5,
				time = 2
			}
		}
	}
}
var_0_0.xp1 = {
	{
		{
			method = "useSkill",
			param = "usexp1"
		}
	}
}
var_0_0.usexp1 = {
	turnbacklimit = true,
	xpeffect = "xp_effect1",
	totalframe = 30,
	nextani = true,
	animation = "chong",
	action_on_start = {
		{
			startframe = 15,
			action = {
				{
					method = "rush_forward",
					param = {
						distance = 150,
						time = 0.5
					}
				}
			}
		}
	},
	action_on_complete = {
		{
			method = "useSkill",
			param = "realxp"
		}
	}
}
var_0_0.realxp = {
	totalframe = 90,
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 20,
			sound = {
				"202220_xp",
				1
			}
		},
		{
			behitted = "hitdown",
			id = 202230010,
			frame = 26,
			forceY = {
				{
					speed = 600
				}
			},
			shake = {
				x = 6,
				y = 6
			}
		},
		{
			behitted = "hitdown",
			id = 202230010,
			frame = 37,
			forceY = {
				{
					speed = 400
				}
			},
			shake = {
				x = 6,
				y = 6
			}
		},
		{
			behitted = "hitdown",
			id = 202230010,
			frame = 39,
			forceY = {
				{
					speed = 400
				}
			},
			shake = {
				x = 6,
				y = 6
			}
		},
		{
			id = 202230010,
			behitted = "hitdown",
			frame = 51,
			shake = {
				x = 6,
				y = 6
			}
		},
		{
			id = 202230011,
			behitted = "hitdown",
			frame = 72,
			forceY = {
				{
					speed = 600
				}
			}
		}
	}
}
var_0_0.xpeffect.xp_effect1 = {
	bgfilescale = 1,
	totalframe = 120,
	bgfile = "202220_bg",
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
			texture = "role/202220.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/202220_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 10,
			startframe = 95,
			timescale = 0.3
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.95,
				totalframe = 70,
				startframe = 45
			}
		},
		move = {
			{
				distance = 100,
				totalframe = 80,
				startframe = 35,
				time = 2
			}
		},
		moveY = {
			{
				distance = 200,
				totalframe = 80,
				startframe = 35,
				time = 2
			}
		}
	}
}

return var_0_0
