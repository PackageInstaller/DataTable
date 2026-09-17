local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 5,
				id = 10048121
			},
			{
				frame = 15,
				id = 10048121
			},
			{
				frame = 25,
				id = 10048121
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
		animation = "skill1",
		exe_tbl = {
			{
				id = 10048131,
				frame = 29,
				effect = {
					{
						ani = "buff",
						name = "100481_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
						object = "self"
					}
				}
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
	useskill2 = {
		totalframe = 60,
		animation = "skill2",
		exe_tbl = {
			{
				id = 10048141,
				behitted = "hitdown",
				frame = 28
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
	useskill3 = {
		totalframe = 60,
		animation = "skill3",
		exe_tbl = {
			{
				frame = 1,
				sound = "100481_skill"
			},
			{
				id = 10048151,
				frame = 26,
				force = {
					{
						shotdown = false,
						time = 0.5,
						distance = 400,
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
		totalframe = 120,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = "100481_xp"
			},
			{
				id = 10048161,
				frame = 37,
				force = {
					{
						shotdown = false,
						time = 0.1,
						distance = 100,
						object = "target"
					}
				},
				effect = {
					{
						ani = "attack",
						name = "100200_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
						object = "target"
					}
				}
			},
			{
				id = 10048161,
				frame = 57,
				force = {
					{
						shotdown = false,
						time = 0.1,
						distance = 100,
						object = "target"
					}
				},
				effect = {
					{
						ani = "attack",
						name = "100200_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
						object = "target"
					}
				}
			},
			{
				id = 10048161,
				frame = 70,
				force = {
					{
						shotdown = false,
						time = 0.1,
						distance = 100,
						object = "target"
					}
				},
				effect = {
					{
						ani = "attack",
						name = "100200_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
						object = "target"
					}
				}
			},
			{
				id = 10048161,
				frame = 83,
				force = {
					{
						shotdown = false,
						time = 0.1,
						distance = 100,
						object = "target"
					}
				},
				effect = {
					{
						ani = "attack",
						name = "100200_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
						object = "target"
					}
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 120,
	bgfile = "22700_bg",
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
	lockframe = {
		{
			totalframe = 6,
			startframe = 63,
			timescale = 0.5
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.75,
				totalframe = 78,
				startframe = 15
			}
		},
		move = {
			{
				distance = 250,
				totalframe = 55,
				startframe = 33,
				time = 0.3
			}
		}
	}
}

return var_0_0
