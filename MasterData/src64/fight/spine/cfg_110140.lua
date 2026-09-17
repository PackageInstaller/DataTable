return {
	xpeffect = {},
	["attack-fly"] = {
		totalframe = 32,
		animation = "attack",
		exe_tbl = {
			{
				frame = 7,
				sound = {
					"shilian",
					0.8
				}
			},
			{
				id = 11014021,
				frame = 8,
				effect = {
					{
						ani = "attack",
						name = "110140_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = -0.3,
						object = "target"
					}
				}
			},
			{
				id = 11014021,
				frame = 14,
				effect = {
					{
						ani = "attack",
						name = "26020_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = -0.3,
						object = "target"
					}
				}
			},
			{
				id = 11014021,
				frame = 20,
				effect = {
					{
						ani = "attack",
						name = "26020_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = -0.3,
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
	skill2 = {
		{
			{
				method = "useSkill",
				param = "useskill2"
			}
		}
	},
	useskill1 = {
		totalframe = 93,
		animation = "skill",
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 7,
							posx = 1
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 18,
				sound = {
					"ufo",
					0.3
				}
			},
			{
				frame = 30,
				id = 11014031
			},
			{
				frame = 60,
				id = 11014031
			},
			{
				frame = 90,
				id = 11014031
			}
		}
	},
	useskill2 = {
		totalframe = 93,
		animation = "xp",
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 7,
							posx = 1
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 18,
				sound = {
					"ufo",
					0.4
				}
			},
			{
				frame = 30,
				id = 11014041,
				forceY = {
					{
						distance = 80,
						time = 1
					}
				}
			},
			{
				frame = 60,
				id = 11014041,
				forceY = {
					{
						distance = 10,
						time = 1
					}
				}
			},
			{
				frame = 90,
				id = 11014041,
				forceY = {
					{
						distance = 10,
						time = 0.5
					}
				}
			}
		}
	}
}
