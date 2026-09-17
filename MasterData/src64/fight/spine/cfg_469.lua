local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"460100-attack",
					0.6
				}
			},
			{
				frame = 5,
				bullet = "attack"
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "qianyao"
			}
		}
	},
	qianyao = {
		totalframe = 22,
		nextani = true,
		animation = "win",
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = -50,
							time = 0.33
						}
					}
				}
			}
		},
		xpeffect = {
			conf = "xp_effect",
			startframe = 23
		},
		exe_tbl = {
			{
				id = 44900000,
				frame = 1,
				sound = {
					"invalid",
					1.6
				}
			}
		},
		action_on_complete = {
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
	skill3 = {
		{
			{
				method = "useSkill",
				param = "useskill3"
			}
		}
	},
	skill4 = {
		{
			{
				method = "useSkill",
				param = "useskill4"
			}
		}
	},
	useskill1 = {
		totalframe = 60,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"460200-skill1",
					0.6
				}
			},
			{
				behitted = "hitdown",
				id = 46920001,
				frame = 33,
				force = {
					{
						time = 0.6,
						shutdown = true,
						distance = 400,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 0
				},
				effect = {
					{
						ani = "skill2_attack",
						name = "46020_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	useskill2 = {
		totalframe = 45,
		animation = "skill3",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"460210-skill2",
					0.6
				}
			},
			{
				id = 46930001,
				frame = 18
			},
			{
				id = 46930001,
				frame = 29
			},
			{
				id = 46930001,
				frame = 40
			},
			{
				id = 46930001,
				frame = 51
			}
		}
	},
	useskill3 = {
		totalframe = 39,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"460220-skill3",
					0.6
				}
			},
			{
				frame = 28,
				bullet = "skill3"
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 90,
	bgfile = "46020_bg",
	locktarget = {
		locktarget = true
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
			texture = "role/46020.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 30,
				startframe = 10
			}
		},
		move = {
			{
				distance = 200,
				totalframe = 30,
				startframe = 10,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp = {
	totalframe = 90,
	xpeffect = "xp_effect",
	animation = "xp2",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"460300-xp",
				0.6
			}
		},
		{
			id = 46950001,
			frame = 40,
			shake = {
				x = 4,
				y = 4
			},
			effect = {
				{
					ani = "xp_attack",
					name = "46020_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 46950001,
			frame = 54,
			shake = {
				x = 4,
				y = 4
			},
			effect = {
				{
					ani = "xp_attack",
					name = "46020_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 46950001,
			frame = 63,
			shake = {
				x = 4,
				y = 4
			},
			effect = {
				{
					ani = "xp_attack",
					name = "46020_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 46950001,
			frame = 76,
			shake = {
				x = 4,
				y = 4
			},
			effect = {
				{
					ani = "xp_attack",
					name = "46020_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
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
	speed = 1000,
	offsetZ = 1,
	filename = "46020_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 0.35,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 7,
		animation = "attack",
		exe_tbl = {
			{
				id = 46910001,
				frame = 1
			}
		}
	}
}
var_0_0.extra.skill3 = {
	movingani = "xp_run",
	maxdistance = 250,
	movingtype = "lockdirection",
	speed = 350,
	offsetZ = 1,
	filename = "46020_effect",
	size = {
		width = 40,
		height = 80
	},
	initpos = {
		offsetY = 0.35,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "carry",
		direction = 1
	},
	attack = {
		exe_tbl = {
			{
				id = 46940002,
				behitted = "hitdown",
				frame = 15,
				shake = {
					x = 1,
					y = 0
				}
			}
		}
	},
	destroy = {
		animation = "xp_attack",
		totalframe = 7
	}
}

return var_0_0
