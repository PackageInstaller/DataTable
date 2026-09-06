-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_skillflow_ai.lua

module("logicconfig.config.t_skillflow_ai", package.seeall)

behaviorConfigData = {
	root = {
		type = "Sequence",
		children = {
			{
				type = "AlwaysTrue",
				children = {
					{
						type = "Sequence",
						children = {
							{
								type = "CheckUltSkill"
							},
							{
								type = "ShowPreUtlSkillEffect"
							}
						}
					}
				}
			},
			{
				type = "AlwaysTrue",
				children = {
					{
						type = "Sequence",
						children = {
							{
								type = "CheckMeleeAtk"
							},
							{
								type = "MoveToTarget"
							}
						}
					}
				}
			},
			{
				type = "ReleaseSkill"
			},
			{
				type = "AlwaysTrue",
				children = {
					{
						type = "Sequence",
						children = {
							{
								type = "CheckMeleeAtk"
							},
							{
								type = "ComeBackSeat"
							}
						}
					}
				}
			}
		}
	}
}
