-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_sub_unit_base_ai.lua

module("logic.config.t_sub_unit_base_ai", package.seeall)

aiConfigData = {
	root = {
		aiTag = "Sequence_1",
		type = "Sequence",
		children = {
			{
				aiTag = "ParallelSelector_2",
				type = "ParallelSelector",
				children = {
					{
						maxWaitTime = 30,
						minWaitTime = 20,
						type = "Wait",
						aiTag = "Wait_3",
						isReset = true
					},
					{
						repeatForever = true,
						returnSuccess = false,
						count = 1,
						type = "Repeater",
						endOnFailure = false,
						aiTag = "Repeater_4",
						children = {
							{
								aiTag = "Sequence_5",
								type = "Sequence",
								children = {
									{
										maxWaitTime = 6,
										minWaitTime = 3,
										type = "Wait",
										aiTag = "Wait_6",
										isReset = false
									},
									{
										aiTag = "RandomWalk_7",
										type = "RandomWalk"
									}
								}
							}
						}
					}
				}
			},
			{
				actionNames = "drama|happy|sad",
				aiTag = "PlayRandomAction_8",
				isLoop = false,
				type = "PlayRandomAction"
			}
		}
	}
}
