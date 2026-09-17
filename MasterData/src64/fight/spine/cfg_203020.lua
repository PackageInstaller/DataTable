local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		{
			{
				operator = "<=",
				method = "random",
				param = {
					num = 10,
					range = 20
				}
			},
			{
				method = "useSkill",
				param = "attack1"
			}
		},
		{
			{
				method = "useSkill",
				param = "attack2"
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
					"203020_attack",
					0.6
				}
			},
			{
				frame = 14,
				id = 203010010,
				effect = {
					{
						ani = "attack",
						name = "203020_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	attack3 = {
		totalframe = 30,
		animation = "attack3",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203020_attack",
					0.6
				}
			},
			{
				frame = 14,
				id = 203010011,
				effect = {
					{
						ani = "attack",
						name = "203020_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	attack1 = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203020_attack",
					0.6
				}
			},
			{
				frame = 14,
				id = 203010010,
				effect = {
					{
						ani = "attack",
						name = "203020_effect",
						offsetZ = 1,
						offsetY = 0.5,
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
		turnbacklimit = true,
		totalframe = 45,
		nextani = true,
		animation = "skill",
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 10,
							posx = -0.1
						}
					}
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "useskill_back"
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203020_skill",
					0.6
				}
			},
			{
				frame = 1,
				id = 203020012
			},
			{
				frame = 15,
				id = 203020012
			},
			{
				id = 203020010,
				frame = 30,
				forceY = {
					{
						speed = 500,
						distance = 300,
						time = 0.1
					}
				}
			},
			{
				frame = 31,
				id = 203020011
			}
		}
	},
	useskill_back = {
		totalframe = 7,
		nextani = true,
		animation = "skill",
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 5,
							posx = -250
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				id = 203020012
			}
		}
	},
	usexp = {
		totalframe = 90,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203020_xp",
					0.6
				}
			},
			{
				behitted = "hitdown",
				id = 203030010,
				frame = 31,
				shake = {
					x = 0,
					y = 20
				},
				forceY = {
					{
						speed = 600,
						distance = 500,
						time = 0.1
					}
				}
			},
			{
				frame = 89,
				id = 203030011
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 90,
	bgfile = "203020_bg",
	locktarget = {
		locktargetpool = "oponent"
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
			texture = "role/203020.png",
			ani = "xp3",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/203020_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 37,
			timescale = 0.3
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.9,
				totalframe = 90,
				startframe = 0
			}
		},
		move = {
			{
				distance = 0,
				time = 0.5,
				distanceY = 0,
				totalframe = 90,
				startframe = 0
			}
		}
	}
}

return var_0_0
