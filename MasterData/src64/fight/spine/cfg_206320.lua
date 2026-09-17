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
					"26720_attack",
					0.6
				}
			},
			{
				frame = 20,
				bullet = "attack",
				effect = {
					{
						ani = "attack1",
						name = "206320_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.5,
						object = "target"
					}
				}
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
	filename = "206320_effect",
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
		totalframe = 17,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				id = 206310010
			}
		}
	}
}
var_0_0.attack2 = {
	totalframe = 30,
	animation = "attack",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"26720_attack",
				0.6
			}
		},
		{
			frame = 20,
			bullet = "attack2",
			effect = {
				{
					ani = "attack1",
					name = "206320_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 0.5,
					object = "target"
				}
			}
		}
	}
}
var_0_0.extra.attack2 = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "206320_effect",
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
		totalframe = 17,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				id = 206310011
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
	turnbacklimit = true,
	totalframe = 50,
	nextani = true,
	animation = "skill_go",
	action_on_start = {
		{
			startframe = 1,
			action = {
				{
					method = "rush_to_target",
					param = {
						frame = 10,
						posx = 60
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
				"25320_skill",
				1
			}
		},
		{
			id = 206320010,
			behitted = "hitdown",
			frame = 40
		}
	}
}
var_0_0.useskill_back = {
	totalframe = 25,
	nextani = true,
	animation = "skill_back",
	action_on_start = {
		{
			startframe = 1,
			action = {
				{
					method = "rush_forward",
					param = {
						distance = -300,
						frame = 5
					}
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
	totalframe = 105,
	xpeffect = "xp_effect",
	turnbacklimit = true,
	nextani = true,
	animation = "xp_go",
	action_on_start = {
		{
			startframe = 1,
			action = {
				{
					method = "rush_to_target",
					param = {
						frame = 10,
						posx = 60
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
				"206320_xp",
				1
			}
		},
		{
			frame = 40,
			behitted = "hitdown"
		},
		{
			frame = 70,
			id = 206330010
		},
		{
			frame = 73,
			id = 206330011
		},
		{
			frame = 76,
			id = 206330012
		}
	}
}
var_0_0.usexp_back = {
	totalframe = 25,
	nextani = true,
	animation = "xp_back",
	action_on_start = {
		{
			startframe = 1,
			action = {
				{
					method = "rush_forward",
					param = {
						distance = -300,
						frame = 5
					}
				}
			}
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	focusoffset = 0,
	bgfilescale = 0.7,
	totalframe = 130,
	bgfile = "206320_bg",
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
			texture = "role/206320.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/206320_xp",
				1
			}
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.1,
				totalframe = 25,
				startframe = 5
			},
			{
				scale = 0.9,
				totalframe = 30,
				startframe = 30
			}
		},
		move = {
			{
				distance = 100,
				totalframe = 25,
				startframe = 30,
				time = 1
			}
		}
	}
}

return var_0_0
