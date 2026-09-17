return {
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				id = 10012161,
				frame = 10,
				effect = {
					{
						ani = "attack",
						name = "100121_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
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
		totalframe = 85,
		animation = "skill",
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 25,
							posx = 1
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 10012171,
				frame = 30,
				effect = {
					{
						ani = "attack",
						name = "100121_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 10012171,
				frame = 40,
				effect = {
					{
						ani = "attack",
						name = "100121_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 10012171,
				frame = 50,
				effect = {
					{
						ani = "attack",
						name = "100121_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 10012171,
				frame = 60,
				effect = {
					{
						ani = "attack",
						name = "100121_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 10012171,
				frame = 70,
				effect = {
					{
						ani = "attack",
						name = "100121_effect",
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
