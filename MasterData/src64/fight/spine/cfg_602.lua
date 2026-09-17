local var_0_0 = {
	xpeffect = {},
	attack1 = {
		totalframe = 20,
		animation = "attack1",
		exe_tbl = {
			{
				id = 60210001,
				frame = 10
			}
		}
	},
	attack2 = {
		totalframe = 20,
		animation = "attack2",
		exe_tbl = {
			{
				id = 60210002,
				frame = 10
			}
		}
	},
	attack3 = {
		totalframe = 25,
		animation = "attack3",
		exe_tbl = {
			{
				id = 60210003,
				behitted = "hitdown",
				frame = 19
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
							distance = 20,
							time = 0.1
						}
					}
				}
			}
		},
		xpeffect = {
			conf = "xp_effect",
			startframe = 30
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
				param = "xp_begin"
			}
		}
	},
	useskill1 = {
		totalframe = 23,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 11,
				id = 60220001,
				effect = {
					{
						ani = "attack",
						name = "60200_effect",
						offsetZ = 1,
						offsetY = 0.3,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	useskill2 = {
		totalframe = 25,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 17,
				id = 60221001,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 200,
						object = "target"
					}
				}
			}
		}
	},
	useskill3 = {
		totalframe = 20,
		animation = "skill3",
		exe_tbl = {
			{
				id = 60222001,
				frame = 5
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 50,
	bgfile = "47000_bg",
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
			texture = "role/60200.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 9,
			startframe = 15,
			timescale = 0.3
		},
		{
			totalframe = 3,
			startframe = 24,
			timescale = 0.08
		},
		{
			totalframe = 10,
			startframe = 31,
			timescale = 0.7
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 21,
				startframe = 30
			}
		},
		move = {
			{
				distance = 400,
				totalframe = 21,
				startframe = 30,
				time = 1
			}
		}
	}
}
var_0_0.xp_begin = {
	xpeffect = "xp_effect",
	totalframe = 30,
	nextani = true,
	animation = "xp_begin",
	effect = {
		{
			ani = "attack",
			name = "60200_effect",
			offsetZ = 1,
			offsetY = 1,
			offsetX = 0,
			object = "self"
		}
	},
	action_on_complete = {
		{
			method = "useSkill",
			param = "xp_attack"
		}
	}
}
var_0_0.xp_attack = {
	turnbacklimit = true,
	exe_crash_type = "carry",
	animation = "xp_attack",
	exe_crash_bound = 75,
	exe_type = "crash",
	totalframe = 10,
	nextani = true,
	action_on_start = {
		{
			method = "rush_forward",
			param = {
				distance = 400,
				time = 0.5
			}
		}
	},
	exe_tbl = {
		{
			id = 60230001,
			frame = 5,
			sound = {
				"horn_fire",
				1
			}
		}
	},
	action_on_complete = {
		{
			method = "useSkill",
			param = "xp_end"
		}
	}
}
var_0_0.xp_end = {
	totalframe = 11,
	animation = "xp_end",
	exe_tbl = {
		{
			behitted = "hit",
			frame = 1,
			force = {
				{
					time = 0.1,
					shutdown = true,
					distance = 150,
					object = "target"
				}
			}
		}
	}
}

return var_0_0
