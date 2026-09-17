return {
	extra = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 10,
				id = 10079120,
				effect = {
					{
						ani = "attack",
						name = "100791_effect",
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
		totalframe = 45,
		animation = "skill",
		action_on_start = {
			{
				startframe = 15,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 200,
							time = 0.1
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 10079130,
				frame = 25,
				force = {
					{
						time = 0.7,
						shutdown = false,
						distance = 200,
						object = "target"
					}
				},
				forceY = {
					{
						speed = 700
					}
				},
				effect = {
					{
						ani = "skill",
						name = "100791_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 25,
				id = 10079131
			}
		}
	}
}
