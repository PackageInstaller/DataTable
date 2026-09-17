local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 10085121,
				frame = 14
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 10085121,
				frame = 14
			},
			{
				id = 10085121,
				frame = 20
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
		totalframe = 50,
		animation = "skill",
		action_on_start = {
			{
				startframe = 5,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 300,
							time = 0.5
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 33,
				behitted = "hitdown",
				id = 10085131,
				effect = {
					{
						ani = "skill",
						name = "100851_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
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
		totalframe = 55,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				id = 10085161,
				behitted = "hitdown",
				frame = 15,
				effect = {
					{
						ani = "xp",
						name = "100851_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
						object = "target"
					}
				}
			},
			{
				id = 10085161,
				behitted = "hitdown",
				frame = 20,
				effect = {
					{
						ani = "xp",
						name = "100851_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
						object = "target"
					}
				}
			},
			{
				id = 10085161,
				behitted = "hitdown",
				frame = 25,
				effect = {
					{
						ani = "xp",
						name = "100851_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
						object = "target"
					}
				}
			},
			{
				id = 10085161,
				behitted = "hitdown",
				frame = 30,
				effect = {
					{
						ani = "xp",
						name = "100851_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
						object = "target"
					}
				}
			},
			{
				id = 10085161,
				behitted = "hitdown",
				frame = 35,
				effect = {
					{
						ani = "xp",
						name = "100851_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
						object = "target"
					}
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 55,
	bgfile = "45080_bg",
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	}
}

return var_0_0
