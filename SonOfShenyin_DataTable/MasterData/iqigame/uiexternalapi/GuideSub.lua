-- chunkname: @IQIGame\\UIExternalApi\\GuideSub.lua

local GuideType = {
	ClickArea = "ClickArea",
	Picture = "Picture",
	PlayEffect = "PlayEffect",
	StartStory = "StartStory",
	NpcTalk = "NpcTalk"
}
local CenterImgPath = {
	GuideMask_03 = "Assets/14_Effect/UI/Textures/GuideMask_03.png",
	GuideMask_04 = "Assets/14_Effect/UI/Textures/GuideMask_04.png",
	GuideMask_02 = "/GuideMaskImage/GuideMask_02.png"
}
local PunchingImgPath = {
	GuideMask_03 = "Assets/14_Effect/UI/Textures/GuideMask_03.png",
	GuideMask_04 = "Assets/14_Effect/UI/Textures/GuideMask_04.png"
}
local FXPath = {
	FX_UI_guide_click = "FX_UI/FX_UI_guide_click"
}

GuideSub = {
	{
		GuideSubShow = "sdf",
		PlotID = 100001,
		GuideSubID = 101,
		GuideName = "引导进入剧情",
		PlotEndID = 100001,
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.StartStory
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 201,
		GuideName = "引导交互",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				1,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				170,
				90,
				"MainUI(Clone)/StoryRoot/StoryPanel/Root/NPCNamePanel/NPCNamePrefab(Clone)",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321002,
				10001,
				0,
				0
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan_01",
				"MainUI(Clone)/StoryRoot/StoryPanel/Root/NPCNamePanel/NPCNamePrefab(Clone)",
				0,
				0,
				0,
				-1,
				7.7,
				4,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 202,
		GuideName = "引导交互",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				1,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				170,
				90,
				"MainUI(Clone)/StoryRoot/StoryPanel/Root/NPCNamePanel/NPCNamePrefab(Clone)",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321002,
				10002,
				0,
				0
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan_01",
				"MainUI(Clone)/StoryRoot/StoryPanel/Root/NPCNamePanel/NPCNamePrefab(Clone)",
				0,
				0,
				0,
				-1,
				7.7,
				4,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 301,
		GuideName = "引导律象之眼",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				1,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				90,
				90,
				"MainUI(Clone)/StoryRoot/StoryPanel/TopRoot/toggleRegular",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				10003,
				0,
				0
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"MainUI(Clone)/StoryRoot/StoryPanel/TopRoot/toggleRegular",
				0,
				0,
				0,
				-1,
				1,
				1,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 401,
		GuideName = "引导打开线索",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				1,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				150,
				85,
				"MainUI(Clone)/StoryRoot/StoryPanel/Root/buttonPuzzle",
				2,
				-10,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				10004,
				0,
				0
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"MainUI(Clone)/StoryRoot/StoryPanel/Root/buttonPuzzle",
				2,
				-10,
				0,
				-1,
				1.26,
				0.714,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "PuzzleUI(Clone)",
		GuideSubID = 402,
		GuideName = "旁白引导线索",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				1,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				570,
				190,
				"PuzzleUI(Clone)/Root/clueContent/gridContent/11002/buttonDetail",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				10005,
				-168,
				-171.63
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"PuzzleUI(Clone)/Root/clueContent/gridContent/11002/buttonDetail",
				0,
				0,
				0,
				-1,
				4.56,
				1.521201,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "PuzzleUI(Clone)",
		GuideSubID = 403,
		GuideName = "旁白引导线索",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				1,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				290,
				100,
				"PuzzleUI(Clone)/Root/clueDetailPanel/buttonSurvey",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				10006,
				0,
				0
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"PuzzleUI(Clone)/Root/clueDetailPanel/buttonSurvey",
				0,
				0,
				0,
				-1,
				12.7,
				4.4,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 501,
		GuideName = "引导打开线索",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				1,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				150,
				85,
				"MainUI(Clone)/StoryRoot/StoryPanel/Root/buttonPuzzle",
				2,
				-10,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				10007,
				0,
				0
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"MainUI(Clone)/StoryRoot/StoryPanel/Root/buttonPuzzle",
				2,
				-10,
				0,
				-1,
				1.26,
				0.714,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "PuzzleUI(Clone)",
		GuideSubID = 502,
		GuideName = "旁白引导线索",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				1,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				570,
				190,
				"PuzzleUI(Clone)/Root/clueContent/gridContent/11033/buttonDetail",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				10008,
				-168,
				-171.63
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"PuzzleUI(Clone)/Root/clueContent/gridContent/11033/buttonDetail",
				0,
				0,
				0,
				-1,
				4.56,
				1.521201,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "PuzzleUI(Clone)",
		GuideSubID = 503,
		GuideName = "旁白引导线索",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				1,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				570,
				190,
				"PuzzleUI(Clone)/Root/clueContent/gridContent/11036/buttonDetail",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				10009,
				-168,
				-171.63
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"PuzzleUI(Clone)/Root/clueContent/gridContent/11036/buttonDetail",
				0,
				0,
				0,
				-1,
				4.56,
				1.521201,
				"effect/fang"
			}
		}
	},
	{
		HideBattleButtons = true,
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 1001,
		GuideName = "点击普攻",
		BattleRoundStart = true,
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				135,
				135,
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/normalSkill/Icon",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				2100001,
				560,
				-172
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/normalSkill",
				0,
				0,
				0,
				-1,
				1,
				1,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 1002,
		GuideName = "旁白引导技能类型和技能描述1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-410,
				94,
				2100002,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 1003,
		GuideName = "旁白引导技能类型和技能描述2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-410,
				94,
				2100003,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 1004,
		GuideName = "旁白引导技能类型和技能描述3",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-410,
				94,
				2100004,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 1005,
		GuideName = "旁白引导技能类型和技能描述3",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-410,
				94,
				2100005,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 1006,
		GuideName = "引导点击释放目标头像",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				95,
				95,
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/CastButton",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				2100006,
				650,
				-182
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/CastButton",
				0,
				0,
				0,
				-1,
				1,
				1,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 1007,
		GuideName = "旁白说明弱点类型1",
		GuideShowTime = -1,
		BattleRoleActionOver = 131000303,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-323,
				-80,
				2100007,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 1008,
		GuideName = "旁白说明弱点类型2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-323,
				-80,
				2100008,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 1009,
		GuideName = "引导点击秘技",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				135,
				135,
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/ultimateSkill/Icon",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				2100009,
				580,
				-154
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/ultimateSkill/Icon",
				0,
				0,
				0,
				-1,
				1,
				1,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		BattleTapGesture = "1,5",
		GuideSubID = 1010,
		GuideName = "旁白说明咒誓1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-323,
				-80,
				2100010,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		BattleTapGesture = "1,5",
		GuideSubID = 1011,
		GuideName = "旁白说明咒誓2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-323,
				-80,
				2100011,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		BattleTapGesture = "1,5",
		GuideSubID = 1012,
		GuideName = "旁白说明咒誓2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-323,
				-80,
				2100012,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 1013,
		GuideName = "引导点击释放目标头像",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				95,
				95,
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/CastButton",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				2100006,
				650,
				-182
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/CastButton",
				0,
				0,
				0,
				-1,
				1,
				1,
				"effect/yuan"
			}
		}
	},
	{
		HideBattleButtons = true,
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2001,
		GuideName = "旁白引导弱点",
		BattleRoundStart = true,
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321004,
				1,
				1,
				-372,
				100,
				2001,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2002,
		GuideName = "旁白引导弱点",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321004,
				1,
				1,
				-395,
				21,
				2002,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2003,
		GuideName = "旁白引导弱点",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321004,
				1,
				1,
				-395,
				97,
				2003,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2004,
		GuideName = "旁白引导弱点",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321004,
				1,
				1,
				-372,
				100,
				2004,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2005,
		GuideName = "引导点击角色兆普通攻击",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				135,
				135,
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/displacementSkill/Icon",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321002,
				2005,
				550,
				-172
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/displacementSkill/Icon",
				0,
				0,
				0,
				-1,
				1,
				1,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2006,
		GuideName = "点击目标头像",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				100,
				100,
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/CastButton",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321002,
				2006,
				620,
				-182
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/CastButton",
				0,
				0,
				0,
				-1,
				1,
				1,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2007,
		GuideName = "旁白引导弱点",
		GuideShowTime = -1,
		BattleRoleActionOver = 131000203,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321004,
				1,
				1,
				-372,
				100,
				2007,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2008,
		GuideName = "旁白引导弱点",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321004,
				1,
				1,
				-372,
				100,
				2008,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2009,
		GuideName = "引导点击角色兆普通攻击",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				135,
				135,
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/ultimateSkill/Icon",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321002,
				2009,
				520,
				-172
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/ultimateSkill/Icon",
				0,
				0,
				0,
				-1,
				1,
				1,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2010,
		GuideName = "点击目标头像",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				100,
				100,
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/CastButton",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321002,
				2010,
				620,
				-182
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/CastButton",
				0,
				0,
				0,
				-1,
				1,
				1,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2011,
		GuideName = "旁白引导弱点",
		GuideShowTime = -1,
		BattleRoleActionOver = 131000204,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321007,
				1,
				1,
				-395,
				21,
				2011,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2012,
		GuideName = "旁白引导弱点",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321007,
				1,
				1,
				-395,
				21,
				2012,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2013,
		GuideName = "旁白引导弱点",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321004,
				1,
				1,
				-372,
				100,
				2013,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2014,
		GuideName = "旁白引导弱点",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321004,
				1,
				1,
				-372,
				100,
				2014,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2015,
		GuideName = "旁白引导弱点",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321004,
				1,
				1,
				-372,
				100,
				2015,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2016,
		GuideName = "旁白引导弱点",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321004,
				1,
				1,
				-372,
				100,
				2016,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2017,
		GuideName = "旁白引导弱点",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321004,
				1,
				1,
				-372,
				100,
				2017,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2018,
		GuideName = "旁白引导弱点",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321004,
				1,
				1,
				-372,
				100,
				2018,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2019,
		GuideName = "旁白引导弱点",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321011,
				1,
				1,
				-310,
				-46,
				2019,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2020,
		GuideName = "旁白引导弱点",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321004,
				1,
				1,
				-372,
				100,
				2020,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2021,
		GuideName = "旁白引导弱点",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321004,
				1,
				1,
				-372,
				100,
				2021,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2022,
		GuideName = "旁白引导弱点",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321007,
				1,
				1,
				-372,
				100,
				2022,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		BattleWaitResultWinGuide = true,
		GuideSubID = 2023
	},
	{
		HideBattleButtons = true,
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2101,
		GuideName = "旁白引导弱点",
		BattleRoundStart = true,
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-372,
				100,
				2101,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2102,
		GuideName = "旁白引导弱点",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-395,
				21,
				2102,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2103,
		GuideName = "点击普攻",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				135,
				135,
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/displacementSkill/Icon",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				2103,
				560,
				-172
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/displacementSkill",
				0,
				0,
				0,
				-1,
				1,
				1,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2104,
		GuideName = "旁白引导弱点",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-395,
				21,
				2104,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2105,
		GuideName = "旁白引导弱点",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-395,
				21,
				2105,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		FindObjWithPath = true,
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2106,
		GuideName = "点击普攻",
		BattlePosClickEvent = 2,
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				80,
				80,
				"BattleViewRoot(Clone)/heroPosition/2",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				2106,
				0,
				-0
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan_01",
				"BattleViewRoot(Clone)/heroPosition/2",
				0,
				0,
				0,
				-1,
				0.5,
				0.5,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2107,
		GuideName = "旁白引导弱点",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-395,
				21,
				2107,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2108,
		GuideName = "引导点击释放目标头像",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				95,
				95,
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/CastButton",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				2108,
				650,
				-182
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/CastButton",
				0,
				0,
				0,
				-1,
				1,
				1,
				"effect/yuan"
			}
		}
	},
	{
		BattleDialogCompleteWait = 10211,
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2109,
		GuideName = "旁白引导弱点",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-395,
				21,
				2201,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2110,
		GuideName = "旁白引导弱点",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-395,
				21,
				2201,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2111,
		GuideName = "旁白引导弱点",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-395,
				21,
				2202,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2112,
		GuideName = "点击普攻",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				135,
				135,
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/displacementSkill/Icon",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				2203,
				560,
				-172
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/displacementSkill",
				0,
				0,
				0,
				-1,
				1,
				1,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2113,
		GuideName = "引导点击释放目标头像",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				95,
				95,
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/CastButton",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				2204,
				650,
				-182
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/CastButton",
				0,
				0,
				0,
				-1,
				1,
				1,
				"effect/yuan"
			}
		}
	},
	{
		HideBattleButtons = true,
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2301,
		GuideName = "旁白引导弱点",
		BattleRoundStart = true,
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-372,
				100,
				2301,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 2302,
		GuideName = "旁白引导弱点",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-395,
				21,
				2302,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainFakeUI(Clone)",
		GuideSubID = 2501,
		GuideName = "引导从假主界面进入抽卡UI",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				100,
				100,
				"MainFakeUI(Clone)/Root/buttonLottery",
				0,
				10,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				2501,
				650,
				-200
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"MainFakeUI(Clone)/Root/buttonLottery",
				0,
				10,
				0,
				-1,
				4,
				4,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "LotteryUI(Clone)",
		GuideSubID = 3001,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				3008,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "LotteryUI(Clone)",
		GuideSubID = 3002,
		GuideName = "旁白说明降神2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				3009,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "LotteryUI(Clone)",
		GuideSubID = 3003,
		GuideName = "旁白说明降神3",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				3010,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "LotteryUI(Clone)",
		GuideSubID = 3004,
		GuideName = "引导点击常行世间卡池",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				200,
				100,
				"LotteryUI(Clone)/Root/Panel_UI/Center_Top/MainUI/Canvas/LeftGrid/Table_50300002",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				3011,
				-180,
				125
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"LotteryUI(Clone)/Root/Panel_UI/Center_Top/MainUI/Canvas/LeftGrid/Table_50300002",
				8,
				-10,
				0,
				-1,
				8,
				4,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "LotteryUI(Clone)",
		OpenMaskWhenTrigger = true,
		GuideSubID = 3005,
		GuideName = "引导点击单抽",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				280,
				80,
				"LotteryUI(Clone)/Root/Panel_UI/Center_Top/MainUI/Canvas/LotteryButtonsParent/Button_Once",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				3012,
				550,
				-180
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"LotteryUI(Clone)/Root/Panel_UI/Center_Top/MainUI/Canvas/LotteryButtonsParent/Button_Once",
				0,
				0,
				0,
				-1,
				12,
				3,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "LotteryUI(Clone)",
		WaitCustomEventTrigger = 101,
		GuideSubID = 3006,
		GuideName = "旁白说明降神",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				3013,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "LotteryUI(Clone)",
		GuideSubID = 3007,
		GuideName = "引导返回假主界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				80,
				80,
				"LotteryUI(Clone)/Root/Panel_UI/Center_Top/MainUI/Canvas/Com_ReturnBtn/ReturnBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				6011,
				-200,
				195
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"LotteryUI(Clone)/Root/Panel_UI/Center_Top/MainUI/Canvas/Com_ReturnBtn/ReturnBtn",
				0,
				0,
				0,
				-1,
				3,
				3,
				"effect/fang"
			}
		},
		TriggerStoryEvent = {
			eventName = "GuideLotteryUICloseEvent",
			treeName = "0-12-2 Start",
			npcID = 999
		}
	},
	{
		GuideSubShow = "MainFakeUI(Clone)",
		GuideSubID = 3501,
		GuideName = "引导点击假主界面祓禊按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				350,
				150,
				"MainFakeUI(Clone)/Root/chapterRoot/ExploreBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				3501,
				250,
				75
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"MainFakeUI(Clone)/Root/chapterRoot/ExploreBtn",
				0,
				0,
				0,
				-1,
				16,
				8,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "FormationUI(Clone)",
		GuideSubID = 4001,
		GuideName = "旁白说明如何编队1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-372,
				100,
				4001,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "FormationUI(Clone)",
		GuideSubID = 4002,
		GuideName = "旁白说明如何编队2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-395,
				21,
				4002,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "FormationUI(Clone)",
		GuideSubID = 4003,
		GuideName = "引导点击“编辑阵型”按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				140,
				50,
				"FormationUI(Clone)/Root/Panel_UI/Center_Top/GameFormation/BottomParent/SwitchHeroSelectPanelBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				4003,
				550,
				-172
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"FormationUI(Clone)/Root/Panel_UI/Center_Top/GameFormation/BottomParent/SwitchHeroSelectPanelBtn",
				0,
				0,
				0,
				-1,
				1.2,
				0.4,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "FormationUI(Clone)",
		GuideSubID = 4004,
		GuideName = "旁白说明如何编队3",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-395,
				21,
				4004,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "FormationUI(Clone)",
		GuideSubID = 4005,
		GuideName = "图片说明如何编队",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.Picture,
				"Assets/05_Images/DataResource/UIResource/GuideCommonImg/GuideCommonImg_08.png"
			}
		}
	},
	{
		GuideSubShow = "FormationUI(Clone)",
		GuideSubID = 4101,
		GuideName = "旁白说明如何编队1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-372,
				100,
				4101,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "FormationUI(Clone)",
		GuideSubID = 4102,
		GuideName = "旁白说明如何编队2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-395,
				21,
				4102,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "FormationUI(Clone)",
		GuideSubID = 4103,
		GuideName = "引导点击“编辑阵型”按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				140,
				50,
				"FormationUI(Clone)/Root/Panel_UI/Center_Top/GameFormation/BottomParent/SwitchHeroSelectPanelBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				4103,
				550,
				-172
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"FormationUI(Clone)/Root/Panel_UI/Center_Top/GameFormation/BottomParent/SwitchHeroSelectPanelBtn",
				0,
				0,
				0,
				-1,
				1.2,
				0.4,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "FormationUI(Clone)",
		GuideSubID = 4104,
		GuideName = "旁白说明如何编队3",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-395,
				21,
				4104,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		HideBattleButtons = true,
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 5001,
		GuideName = "旁白说明角色特点",
		BattleRoundStart = true,
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-372,
				100,
				5001,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 5002,
		GuideName = "旁白说明角色特点",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-395,
				21,
				5002,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 5003,
		GuideName = "引导点击角色安普通攻击",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				135,
				135,
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/normalSkill/NormalButton",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				5003,
				550,
				-172
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/normalSkill/NormalButton",
				0,
				0,
				0,
				-1,
				5.5,
				5.5,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 5004,
		GuideName = "点击目标头像",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				100,
				100,
				"BattleUI(Clone)/Root/BottomSelectState/SelectPanel/TargetsRoot/Template/Backgroun",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				5004,
				680,
				-182
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"BattleUI(Clone)/Root/BottomSelectState/SelectPanel/TargetsRoot/Template/Backgroun",
				0,
				0,
				0,
				-1,
				3.5,
				3.5,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 5005,
		GuideName = "点击目标头像",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				100,
				100,
				"BattleUI(Clone)/Root/BottomSelectState/SelectPanel/TargetsRoot/Template/Backgroun",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				5005,
				680,
				-182
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"BattleUI(Clone)/Root/BottomSelectState/SelectPanel/TargetsRoot/Template/Backgroun",
				0,
				0,
				0,
				-1,
				3.5,
				3.5,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 5006,
		GuideName = "安diy旁白1",
		BattleRoundStart = true,
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-395,
				21,
				5006,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 5007,
		GuideName = "安diy旁白2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-395,
				21,
				5007,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 5008,
		GuideName = "安diy旁白3",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-395,
				21,
				5009,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 5009,
		GuideName = "引导点击安秘技",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				135,
				135,
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/ultimateSkill/UltimateButton",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				5009,
				580,
				-154
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/ultimateSkill/UltimateButton",
				0,
				0,
				0,
				-1,
				5.5,
				5.5,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 5010,
		GuideName = "再次引导点击目标头像",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				95,
				95,
				"BattleUI(Clone)/Root/BottomSelectState/SelectPanel/TargetsRoot/Template (2)/Backgroun",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				5010,
				680,
				-193
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"BattleUI(Clone)/Root/BottomSelectState/SelectPanel/TargetsRoot/Template (2)/Backgroun",
				0,
				0,
				0,
				-1,
				3.5,
				3.5,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 5011,
		GuideName = "再次引导点击释放技能",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				100,
				100,
				"BattleUI(Clone)/Root/BottomSelectState/SelectPanel/TargetsRoot/Template (2)/Backgroun",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				5011,
				680,
				-193
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"BattleUI(Clone)/Root/BottomSelectState/SelectPanel/TargetsRoot/Template (2)/Backgroun",
				0,
				0,
				0,
				-1,
				3.5,
				3.5,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 5012,
		GuideName = "技能说明旁白",
		BattleRoundStart = true,
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-395,
				21,
				5012,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 6001,
		GuideName = "旁白引导进入任务界面1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-372,
				100,
				6001,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 6002,
		GuideName = "旁白引导进入任务界面2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-372,
				100,
				6002,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		FindObjWithPath = true,
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 6003,
		GuideName = "引导点击前往任务界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				200,
				80,
				"HomeMountPoint(Clone)/PartRoot/30401002/30401002/TaskBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				6003,
				620,
				-80
			}
		}
	},
	{
		GuideSubShow = "TaskSystemUI(Clone)",
		GuideSubID = 6004,
		GuideName = "旁白说明任务手册1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-372,
				100,
				6004,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "TaskSystemUI(Clone)",
		GuideSubID = 6005,
		GuideName = "旁白说明任务手册2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-372,
				100,
				6005,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "TaskSystemUI(Clone)",
		GuideSubID = 6006,
		GuideName = "引导领取任务奖励",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				200,
				100,
				"TaskSystemUI(Clone)/Root/Panel_UI/CenterContent/trunkRoot/ContentScroll/ScrollArea/Viewport/Index1/12000200/GetBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				6006,
				400,
				125
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"TaskSystemUI(Clone)/Root/Panel_UI/CenterContent/trunkRoot/ContentScroll/ScrollArea/Viewport/Index1/12000200/GetBtn/",
				0,
				0,
				0,
				-1,
				8,
				4,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "GetPanelUI(Clone)",
		GuideSubID = 6007,
		GuideName = "旁白说明任务完成1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-372,
				100,
				6007,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "GetPanelUI(Clone)",
		GuideSubID = 6008,
		GuideName = "旁白说明任务完成2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-372,
				100,
				6008,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "GetPanelUI(Clone)",
		GuideSubID = 6009,
		GuideName = "旁白说明返回事务所",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-372,
				100,
				6009,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "TaskSystemUI(Clone)",
		GuideSubID = 6010,
		GuideName = "引导点击空白按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				300,
				100,
				"GetPanelUI(Clone)/Root/Panel/confirmBtn",
				0,
				-300,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				6010,
				-180,
				-200
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"GetPanelUI(Clone)/Root/Panel/confirmBtn",
				0,
				-300,
				0,
				-1,
				8,
				4,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "TaskSystemUI(Clone)",
		GuideSubID = 6011,
		GuideName = "引导返回主界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				80,
				80,
				"TaskSystemUI(Clone)/Root/Panel_UI/Com_ReturnBtn/HomeBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				6011,
				-200,
				195
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"TaskSystemUI(Clone)/Root/Panel_UI/Com_ReturnBtn/HomeBtn",
				0,
				0,
				0,
				-1,
				3,
				3,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 7001,
		GuideName = "旁白说明角色DIY替换1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				7001,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 7002,
		GuideName = "旁白说明角色DIY替换2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				7002,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 7003,
		GuideName = "旁白说明角色DIY替换1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-560,
				70,
				7003,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 7004,
		GuideName = "旁白说明角色DIY替换1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-560,
				70,
				7004,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 7005,
		GuideName = "旁白说明角色DIY替换1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-560,
				70,
				7005,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 7006,
		GuideName = "引导点击角色管理界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				75,
				75,
				"MainUI(Clone)/Root/Panel_UI/Top/MainUIInfo/HeroBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				7006,
				470,
				-190
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"MainUI(Clone)/Root/Panel_UI/Top/MainUIInfo/HeroBtn",
				0,
				0,
				0,
				-1,
				3,
				3,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "WarlockChoosePanel(Clone)",
		GuideSubID = 7007,
		GuideName = "旁白说明角色界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-560,
				70,
				7007,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "WarlockChoosePanel(Clone)",
		GuideSubID = 7008,
		GuideName = "引导点击角色",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				320,
				500,
				"WarlockChoosePanel(Clone)/Root/ScroolRoot/ScrollAreaBig/Viewport/Index_0/Item1",
				20,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				7008,
				80,
				175
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"WarlockChoosePanel(Clone)/Root/ScroolRoot/ScrollAreaBig/Viewport/Index_0/Item1",
				0,
				0,
				0,
				-1,
				10,
				22,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 7009,
		GuideName = "旁白说明角色详情界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-560,
				70,
				7009,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 7010,
		GuideName = "引导点击角色",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				340,
				140,
				"RoleDevelopmentPanel(Clone)/ContentRoot/SubContent/InfoPanel/RoleInfoPanelRoot/RoleInfoPanel/RightParent/Parent",
				-90,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				7010,
				550,
				-70
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"RoleDevelopmentPanel(Clone)/ContentRoot/SubContent/InfoPanel/RoleInfoPanelRoot/RoleInfoPanel/RightParent/Parent",
				-90,
				0,
				0,
				-1,
				15,
				6,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 7011,
		GuideName = "旁白说明替换DIY1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-560,
				70,
				7011,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 7012,
		GuideName = "旁白说明替换DIY2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-560,
				70,
				7012,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 7013,
		GuideName = "图片说明如何替换DIY",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.Picture,
				"Assets/05_Images/DataResource/UIResource/GuideCommonImg/GuideCommonImg_11.png"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 7014,
		GuideName = "引导点击角色",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				175,
				50,
				"RoleDevelopmentPanel(Clone)/ContentRoot/SubContent/SkillPanel/DiySkillInfoPanel/DIYSkillInfoParentRoot/DIYSkillInfoParent/BottomBtnParent/openBagBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				7013,
				435,
				-190
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"RoleDevelopmentPanel(Clone)/ContentRoot/SubContent/SkillPanel/DiySkillInfoPanel/DIYSkillInfoParentRoot/DIYSkillInfoParent/BottomBtnParent/openBagBtn",
				0,
				0,
				0,
				-1,
				8,
				2,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 7015,
		GuideName = "旁白说明DIY背包",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-560,
				70,
				7014,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 7016,
		GuideName = "引导点击主动DIY",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				75,
				75,
				"RoleDevelopmentPanel(Clone)/ContentRoot/SubContent/SkillPanel/DiySkillInfoPanel/DIYBagContent/DIYBagParent/equipBagScroll/Viewport/Index_0/2",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				7015,
				-25,
				145
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"RoleDevelopmentPanel(Clone)/ContentRoot/SubContent/SkillPanel/DiySkillInfoPanel/DIYBagContent/DIYBagParent/equipBagScroll/Viewport/Index_0/2",
				0,
				0,
				0,
				-1,
				4,
				4,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 7017,
		GuideName = "引导点击替换按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				175,
				50,
				"RoleDevelopmentPanel(Clone)/ContentRoot/SubContent/SkillPanel/DiySkillInfoPanel/DIYSkillInfoParentRoot/DIYSkillInfoParent/BottomBtnParent/replaceButton",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				7016,
				435,
				-190
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"RoleDevelopmentPanel(Clone)/ContentRoot/SubContent/SkillPanel/DiySkillInfoPanel/DIYSkillInfoParentRoot/DIYSkillInfoParent/BottomBtnParent/replaceButton",
				0,
				0,
				0,
				-1,
				8,
				2,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 7018,
		GuideName = "旁白说明替换结果",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-560,
				70,
				7018,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 7019,
		GuideName = "引导点击返回主界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				80,
				80,
				"RoleDevelopmentPanel(Clone)/ContentRoot/Com_ReturnBtn/HomeBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				7020,
				-200,
				195
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"RoleDevelopmentPanel(Clone)/ContentRoot/Com_ReturnBtn/HomeBtn",
				0,
				0,
				0,
				-1,
				3,
				3,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 8001,
		GuideName = "旁白引导玩家进入关卡1-1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				8001,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 8002,
		GuideName = "旁白说明引导点击地图关卡2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				8002,
				"#0D0B0B50"
			}
		}
	},
	{
		FindObjWithPath = true,
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 8003,
		GuideName = "引导点击祓禊按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				350,
				150,
				"HomeMountPoint(Clone)/PartRoot/30401001/30401001/ExploreBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				8003,
				250,
				75
			}
		}
	},
	{
		GuideSubShow = "PlayingMethodUI(Clone)",
		GuideSubID = 8004,
		GuideName = "引导点击地图按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				600,
				300,
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/MapParent/MapBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				8004,
				500,
				125
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/MapParent/MapBtn",
				0,
				0,
				0,
				-1,
				27,
				14,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 8005,
		GuideName = "引导点击地图关卡",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				175,
				175,
				"ChapterStageMapUI(Clone)/Root/Map/Scroll View/MapObject/302",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				8005,
				120,
				139
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"ChapterStageMapUI(Clone)/Root/Map/Scroll View/MapObject/302/markItem",
				0,
				0,
				0,
				-1,
				8,
				8,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 8006,
		GuideName = "旁白说明引导点击开始按键1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				8006,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 8007,
		GuideName = "旁白说明引导点击开始按键2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				8007,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 8008,
		GuideName = "旁白说明引导点击开始按键3",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				8008,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 8009,
		GuideName = "引导点击地图关卡",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				200,
				200,
				"ChapterStageMapUI(Clone)/Root/MainChapterPanel/BottomParent/StartGamePanel/StartButton",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				8009,
				700,
				-135
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"ChapterStageMapUI(Clone)/Root/MainChapterPanel/BottomParent/StartGamePanel/StartButton/Image",
				-24,
				0,
				0,
				-1,
				8,
				8,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 9001,
		GuideName = "旁白说明引导点击地图关卡1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				9001,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 9002,
		GuideName = "旁白说明引导点击地图关卡2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				9002,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 9003,
		GuideName = "旁白说明引导点击地图关卡3",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				9003,
				"#0D0B0B50"
			}
		}
	},
	{
		FindObjWithPath = true,
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 9004,
		GuideName = "引导点击祓禊按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				350,
				150,
				"HomeMountPoint(Clone)/PartRoot/30401001/30401001/ExploreBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				9504,
				250,
				75
			}
		}
	},
	{
		GuideSubShow = "PlayingMethodUI(Clone)",
		GuideSubID = 9005,
		GuideName = "引导点击地图按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				600,
				300,
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/MapParent/MapBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				9505,
				500,
				125
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/MapParent/MapBtn",
				0,
				0,
				0,
				-1,
				27,
				14,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 9006,
		GuideName = "引导点击地图关卡",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				175,
				175,
				"ChapterStageMapUI(Clone)/Root/Map/Scroll View/MapObject/301",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				9004,
				120,
				139
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"ChapterStageMapUI(Clone)/Root/Map/Scroll View/MapObject/301/markItem",
				0,
				0,
				0,
				-1,
				8,
				8,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 9007,
		GuideName = "引导点击地图关卡",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				200,
				200,
				"ChapterStageMapUI(Clone)/Root/MainChapterPanel/BottomParent/StartGamePanel/StartButton",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				9006,
				700,
				-135
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"ChapterStageMapUI(Clone)/Root/MainChapterPanel/BottomParent/StartGamePanel/StartButton/Image",
				-24,
				0,
				0,
				-1,
				8,
				8,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 9501,
		GuideName = "1-2断线重连旁白1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				9501,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 9502,
		GuideName = "1-2断线重连旁白2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				9502,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 9503,
		GuideName = "1-2断线重连旁白2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				9503,
				"#0D0B0B50"
			}
		}
	},
	{
		FindObjWithPath = true,
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 9504,
		GuideName = "引导点击祓禊按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				350,
				150,
				"HomeMountPoint(Clone)/PartRoot/30401001/30401001/ExploreBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				9504,
				250,
				75
			}
		}
	},
	{
		GuideSubShow = "PlayingMethodUI(Clone)",
		GuideSubID = 9505,
		GuideName = "引导点击地图按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				600,
				300,
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/MapParent/MapBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				9505,
				500,
				125
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/MapParent/MapBtn",
				0,
				0,
				0,
				-1,
				27,
				14,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 9506,
		GuideName = "引导点击地图关卡",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				175,
				175,
				"ChapterStageMapUI(Clone)/Root/Map/Scroll View/MapObject/301",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				9004,
				120,
				139
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"ChapterStageMapUI(Clone)/Root/Map/Scroll View/MapObject/301/markItem",
				0,
				0,
				0,
				-1,
				8,
				8,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 9507,
		GuideName = "引导点击地图关卡",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				200,
				200,
				"ChapterStageMapUI(Clone)/Root/MainChapterPanel/BottomParent/StartGamePanel/StartButton",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				9006,
				700,
				-135
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"ChapterStageMapUI(Clone)/Root/MainChapterPanel/BottomParent/StartGamePanel/StartButton/Image",
				-24,
				0,
				0,
				-1,
				8,
				8,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "FormationUI(Clone)",
		GuideSubID = 9701,
		GuideName = "引导点击地图按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				100,
				100,
				"FormationUI(Clone)/Root/Panel_UI/Center_Top/GameFormation/StartBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				9701,
				685,
				-180
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"FormationUI(Clone)/Root/Panel_UI/Center_Top/GameFormation/StartBtn",
				0,
				0,
				0,
				-1,
				4,
				4,
				"effect/fang"
			}
		}
	},
	{
		HideBattleButtons = true,
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 11001,
		GuideName = "回合1旁白1",
		BattleRoundStart = true,
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-372,
				100,
				11001,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 11002,
		GuideName = "旁白说明角色特点",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-395,
				21,
				11002,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 11003,
		GuideName = "引导点击角色安普通攻击",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				135,
				135,
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/normalSkill/NormalButton",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				11003,
				550,
				-172
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/normalSkill/NormalButton",
				0,
				0,
				0,
				-1,
				5.5,
				5.5,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 11004,
		GuideName = "点击目标头像",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				100,
				100,
				"BattleUI(Clone)/Root/BottomSelectState/SelectPanel/TargetsRoot/Template (1)/Backgroun",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				11004,
				680,
				-182
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"BattleUI(Clone)/Root/BottomSelectState/SelectPanel/TargetsRoot/Template (1)/Backgroun",
				0,
				0,
				0,
				-1,
				3.5,
				3.5,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		OpenMaskWhenTrigger = true,
		GuideSubID = 11005,
		GuideName = "点击目标头像",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				100,
				100,
				"BattleUI(Clone)/Root/BottomSelectState/SelectPanel/TargetsRoot/Template (1)/Backgroun",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				11005,
				680,
				-182
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"BattleUI(Clone)/Root/BottomSelectState/SelectPanel/TargetsRoot/Template (1)/Backgroun",
				0,
				0,
				0,
				-1,
				3.5,
				3.5,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		OpenMaskWhenTrigger = true,
		GuideSubID = 11006,
		GuideName = "安diy旁白1",
		BattleRoundStart = true,
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-395,
				21,
				11006,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 11007,
		GuideName = "引导点击角色安diy",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				135,
				135,
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/UniqueButton/UniqueButton",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				11007,
				550,
				-172
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"BattleUI(Clone)/Root/BottomNormalState/BattleSkillUI/UniqueButton/UniqueButton",
				0,
				0,
				0,
				-1,
				5.5,
				5.5,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 11008,
		GuideName = "点击目标头像",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				100,
				100,
				"BattleUI(Clone)/Root/BottomSelectState/SelectPanel/TargetsRoot/Template (3)/Backgroun",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				11008,
				680,
				-182
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"BattleUI(Clone)/Root/BottomSelectState/SelectPanel/TargetsRoot/Template (3)/Backgroun",
				0,
				0,
				0,
				-1,
				3.5,
				3.5,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 11009,
		GuideName = "点击目标头像",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				100,
				100,
				"BattleUI(Clone)/Root/BottomSelectState/SelectPanel/TargetsRoot/Template (3)/Backgroun",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				11009,
				680,
				-182
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"BattleUI(Clone)/Root/BottomSelectState/SelectPanel/TargetsRoot/Template (3)/Backgroun",
				0,
				0,
				0,
				-1,
				3.5,
				3.5,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 11010,
		GuideName = "安diy旁白2",
		GuideShowTime = -1,
		BattleRoleActionOver = 130009001,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-395,
				21,
				11010,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 11011,
		GuideName = "安diy旁白3",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-395,
				21,
				11011,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 11012,
		GuideName = "安diy旁白3",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-395,
				21,
				11012,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 11013,
		GuideName = "图片说明主动DIY",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.Picture,
				"Assets/05_Images/DataResource/UIResource/GuideCommonImg/GuideCommonImg_09.png"
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		BattleWaitResultWinGuide = true,
		GuideSubID = 11014
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 12001,
		GuideName = "旁白说明引导点击返回主界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				12001,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 12002,
		GuideName = "引导点击返回主界面按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				100,
				100,
				"ChapterStageMapUI(Clone)/Root/Com_ReturnBtn/HomeBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				12002,
				-210,
				250
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"ChapterStageMapUI(Clone)/Root/Com_ReturnBtn/HomeBtn",
				0,
				0,
				0,
				-1,
				3.5,
				3.5,
				"effect/fang"
			}
		}
	},
	{
		FindObjWithPath = true,
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 12501,
		GuideName = "引导点击祓禊按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				200,
				100,
				"HomeMountPoint(Clone)/PartRoot/30401001/30401001/ExploreBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				9504,
				-180,
				125
			}
		}
	},
	{
		GuideSubShow = "PlayingMethodUI(Clone)",
		GuideSubID = 12502,
		GuideName = "引导点击地图按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				200,
				100,
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/MapParent/MapBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				9505,
				-180,
				125
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/MapParent/MapBtn",
				0,
				0,
				0,
				-1,
				8,
				4,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 13001,
		GuideName = "旁白说明商城开放1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				13001,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 13002,
		GuideName = "旁白说明商城开放2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				13002,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 13003,
		GuideName = "旁白说明商城开放3",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				13003,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 13004,
		GuideName = "引导点击返回主界面按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				100,
				100,
				"MainUI(Clone)/Root/Panel_UI/Top/MainUIInfo/ButtonSort/LeftGrid/ShopBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				13004,
				-210,
				250
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"MainUI(Clone)/Root/Panel_UI/Top/MainUIInfo/ButtonSort/LeftGrid/ShopBtn",
				0,
				0,
				0,
				-1,
				3.5,
				3.5,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "ShopUI(Clone)",
		GuideSubID = 13005,
		GuideName = "旁白说明商城内容1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				13005,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ShopUI(Clone)",
		GuideSubID = 13006,
		GuideName = "旁白说明商城内容2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				13006,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ShopUI(Clone)",
		GuideSubID = 13007,
		GuideName = "旁白说明商城内容3",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				13007,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ShopUI(Clone)",
		GuideSubID = 13008,
		GuideName = "引导点击返回主界面按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				100,
				100,
				"ShopUI(Clone)/Root/Com_ReturnBtn/HomeBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				13008,
				-210,
				250
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"ShopUI(Clone)/Root/Com_ReturnBtn/HomeBtn",
				0,
				0,
				0,
				-1,
				3.5,
				3.5,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 14001,
		GuideName = "旁白说明手机界面1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				14001,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 14002,
		GuideName = "引导点击返回主界面按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				100,
				100,
				"MainUI(Clone)/Root/Panel_UI/Top/MainUIInfo/SmallPhone/OpenPhoneBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				14002,
				525,
				-215
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"MainUI(Clone)/Root/Panel_UI/Top/MainUIInfo/SmallPhone/OpenPhoneBtn",
				0,
				0,
				0,
				-1,
				3.5,
				3.5,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 14003,
		GuideName = "旁白说明手机内界面1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				14003,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 14004,
		GuideName = "--旁白说明手机内界面2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				14004,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 14005,
		GuideName = "图片说明主界面相关",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.Picture,
				"Assets/05_Images/DataResource/UIResource/GuideCommonImg/GuideCommonImg_07.png"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 14006,
		GuideName = "引导点击关闭手机",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				400,
				5000,
				"MainUI(Clone)/Root/Panel_UI/Bottom_Left/PhonePanel/ClosePhoneBtn",
				-450,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				14006,
				-210,
				-5
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 15001,
		GuideName = "旁白说明新手10连抽1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				15001,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 15002,
		GuideName = "旁白说明新手10连抽2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				15002,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 15003,
		GuideName = "旁白说明新手10连抽3",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				15003,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 15004,
		GuideName = "引导点击降神按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				100,
				100,
				"MainUI(Clone)/Root/Panel_UI/Top/MainUIInfo/LotteryBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				15004,
				620,
				-182
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"MainUI(Clone)/Root/Panel_UI/Top/MainUIInfo/LotteryBtn/icon1_1",
				0,
				0,
				0,
				-1,
				4,
				4,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "LotteryUI(Clone)",
		GuideSubID = 15005,
		GuideName = "旁白说明新手10连抽3",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				15005,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "LotteryUI(Clone)",
		GuideSubID = 15006,
		GuideName = "旁白说明新手10连抽3",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				15006,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 16001,
		GuideName = "旁白说明自动战斗1",
		BattleRoundStart = true,
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-560,
				-10,
				16001,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 16002,
		GuideName = "旁白说明自动战斗2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-560,
				-10,
				16002,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 16003,
		GuideName = "旁白说明自动战斗3",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-560,
				-10,
				16003,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "BattleUI(Clone)",
		GuideSubID = 16004,
		GuideName = "图片说明自动战斗",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.Picture,
				"Assets/05_Images/DataResource/UIResource/GuideCommonImg/GuideCommonImg_10.png"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 17001,
		GuideName = "旁白说明引导前往日常副本1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				17001,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "PlayingMethodUI(Clone)",
		GuideSubID = 17002,
		GuideName = "旁白说明日常副本1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				17003,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "PlayingMethodUI(Clone)",
		GuideSubID = 17003,
		GuideName = "旁白说明日常副本2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				17004,
				"#0D0B0B50"
			}
		}
	},
	{
		FindObjWithPath = true,
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 17004,
		GuideName = "引导点击前往祓禊界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				350,
				200,
				"HomeMountPoint(Clone)/PartRoot/30401001/30401001/ExploreBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				17503,
				510,
				-95
			}
		}
	},
	{
		GuideSubShow = "PlayingMethodUI(Clone)",
		GuideSubID = 17005,
		GuideName = "引导点击前往祓禊界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				290,
				180,
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/BossParent/BossBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				17504,
				170,
				10
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/BossParent/BossBtn",
				0,
				0,
				0,
				-1,
				12,
				8,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "PlayingMethodUI(Clone)",
		GuideSubID = 17006,
		GuideName = "旁白说明日常副本3",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				17005,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ResourceStageUI(Clone)",
		GuideSubID = 17007,
		GuideName = "旁白说明日常副本产出1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				17007,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ResourceStageUI(Clone)",
		GuideSubID = 17008,
		GuideName = "旁白说明日常副本产出2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				17008,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ResourceStageUI(Clone)",
		GuideSubID = 17009,
		GuideName = "旁白说明日常副本产出3",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				17009,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ResourceStageUI(Clone)",
		GuideSubID = 17010,
		GuideName = "引导点击返回主界面按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				400,
				400,
				"ResourceStageUI(Clone)/Root/CenterInfo/baseResourceScroll/Viewport/stageContent/1/Image/buttonClick",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				17010,
				-210,
				250
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"ResourceStageUI(Clone)/Root/CenterInfo/baseResourceScroll/Viewport/stageContent/1/Image/buttonClick",
				0,
				0,
				0,
				-1,
				18,
				18,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 17011,
		GuideName = "引导点击返回主界面按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				250,
				100,
				"StageUI(Clone)/Root/CenterInfo/startBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				17011,
				580,
				-200
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"StageUI(Clone)/Root/CenterInfo/startBtn",
				0,
				0,
				0,
				-1,
				10,
				3,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 17501,
		GuideName = "旁白说明日常副本产出1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				17501,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 17502,
		GuideName = "旁白说明日常副本产出1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				17502,
				"#0D0B0B50"
			}
		}
	},
	{
		FindObjWithPath = true,
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 17503,
		GuideName = "引导点击前往祓禊界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				250,
				230,
				"HomeMountPoint(Clone)/PartRoot/30401001/30401001/ExploreBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				17503,
				510,
				-95
			}
		}
	},
	{
		GuideSubShow = "PlayingMethodUI(Clone)",
		GuideSubID = 17504,
		GuideName = "引导点击前往祓禊界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				550,
				300,
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/MapParent/MapBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				17504,
				170,
				-130
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/MapParent/MapBtn",
				0,
				0,
				0,
				-1,
				24,
				14,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "ResourceStageUI(Clone)",
		GuideSubID = 18001,
		GuideName = "旁白说明前往任务手册1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				18001,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 18002,
		GuideName = "引导点击神觉者按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				80,
				80,
				"MainUI(Clone)/Root/Panel_UI/Top/MainUIInfo/HeroBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				18004,
				535,
				-182
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"MainUI(Clone)/Root/Panel_UI/Top/MainUIInfo/HeroBtn",
				0,
				0,
				0,
				-1,
				3,
				3,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "WarlockChoosePanel(Clone)",
		GuideSubID = 18003,
		GuideName = "引导点击神觉者【环】",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				250,
				500,
				"WarlockChoosePanel(Clone)/Root/ScroolRoot/ScrollAreaBig/Viewport/Index_0/Item1",
				20,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				18005,
				-72,
				-72
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"WarlockChoosePanel(Clone)/Root/ScroolRoot/ScrollAreaBig/Viewport/Index_0/Item1",
				20,
				0,
				0,
				-1,
				10,
				22,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 18004,
		GuideName = "旁白说明引导点击升级按键1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				18006,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 18005,
		GuideName = "旁白说明引导点击升级按键2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				18007,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 18006,
		GuideName = "引导点击升级按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				130,
				130,
				"RoleDevelopmentPanel(Clone)/ContentRoot/SubContent/InfoPanel/RoleInfoPanelRoot/RoleInfoPanel/RightParent/topParent/UpgradedBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				18008,
				630,
				150
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"RoleDevelopmentPanel(Clone)/ContentRoot/SubContent/InfoPanel/RoleInfoPanelRoot/RoleInfoPanel/RightParent/topParent/UpgradedBtn/Image",
				0,
				0,
				0,
				-1,
				5,
				5,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 18007,
		GuideName = "旁白说明引导点击升级经验材料1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				18009,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 18008,
		GuideName = "旁白说明引导点击升级经验材料2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				18010,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 18501,
		GuideName = "旁白说明神觉者升级断线重连1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				18501,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 18502,
		GuideName = "旁白说明神觉者升级断线重连2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				18502,
				"#0D0B0B50"
			}
		}
	},
	{
		FindObjWithPath = true,
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 18503,
		GuideName = "引导点击前往祓禊界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				250,
				230,
				"HomeMountPoint(Clone)/PartRoot/30401001/30401001/ExploreBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				18503,
				510,
				-95
			}
		}
	},
	{
		GuideSubShow = "PlayingMethodUI(Clone)",
		GuideSubID = 18504,
		GuideName = "引导点击前往祓禊界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				550,
				300,
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/BossParent/BossBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				18504,
				170,
				-130
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/BossParent/BossBtn",
				0,
				0,
				0,
				-1,
				24,
				14,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 19001,
		GuideName = "旁白说明前往任务手册1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				19001,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 19002,
		GuideName = "旁白说明前往任务手册2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				19002,
				"#0D0B0B50"
			}
		}
	},
	{
		FindObjWithPath = true,
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 19003,
		GuideName = "引导点击前往任务界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				170,
				60,
				"HomeMountPoint(Clone)/PartRoot/30401002/30401002/TaskBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				19004,
				620,
				-115
			}
		}
	},
	{
		GuideSubShow = "TaskSystemUI(Clone)",
		GuideSubID = 19004,
		GuideName = "旁白说明日常和周常任务1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				19005,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "TaskSystemUI(Clone)",
		GuideSubID = 19005,
		GuideName = "旁白说明日常和周常任务2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				19006,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "TaskSystemUI(Clone)",
		GuideSubID = 19006,
		GuideName = "旁白说明日常和周常任务3",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				19007,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "TaskSystemUI(Clone)",
		GuideSubID = 19007,
		GuideName = "旁白说明日常和周常任务4",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				19008,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 19501,
		GuideName = "旁白说明日常副本产出1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				19501,
				"#0D0B0B50"
			}
		}
	},
	{
		FindObjWithPath = true,
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 19502,
		GuideName = "引导点击前往祓禊界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				250,
				230,
				"HomeMountPoint(Clone)/PartRoot/30401001/30401001/ExploreBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				19502,
				510,
				-95
			}
		}
	},
	{
		GuideSubShow = "PlayingMethodUI(Clone)",
		GuideSubID = 19503,
		GuideName = "引导点击前往祓禊界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				550,
				300,
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/MapParent/MapBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				19503,
				170,
				-130
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/MapParent/MapBtn",
				0,
				0,
				0,
				-1,
				24,
				14,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 20001,
		GuideName = "旁白说明潜能1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-560,
				-10,
				20001,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 20002,
		GuideName = "旁白说明潜能2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-560,
				-10,
				20002,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 20003,
		GuideName = "引导点击神觉者按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				100,
				100,
				"MainUI(Clone)/Root/Panel_UI/Top/MainUIInfo/HeroBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				20004,
				460,
				-250
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"MainUI(Clone)/Root/Panel_UI/Top/MainUIInfo/HeroBtn",
				0,
				0,
				0,
				-1,
				4,
				4,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "WarlockChoosePanel(Clone)",
		GuideSubID = 20004,
		GuideName = "引导点击神觉者【安】",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				250,
				500,
				"WarlockChoosePanel(Clone)/Root/ScroolRoot/ScrollAreaBig/Viewport/Index_0/Item1",
				20,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				20005,
				-72,
				-72
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"WarlockChoosePanel(Clone)/Root/ScroolRoot/ScrollAreaBig/Viewport/Index_0/Item1",
				20,
				0,
				0,
				-1,
				10,
				22,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "WarlockChoosePanel(Clone)",
		GuideSubID = 20005,
		GuideName = "引导点击神觉者【安】",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				120,
				50,
				"RoleDevelopmentPanel(Clone)/ContentRoot/LeftContent/TabListRoot/ToggleGroup/upGradationTabItem",
				-50,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				20006,
				28,
				-72
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"RoleDevelopmentPanel(Clone)/ContentRoot/LeftContent/TabListRoot/ToggleGroup/upGradationTabItem",
				-50,
				0,
				0,
				-1,
				6,
				2,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "WarlockChoosePanel(Clone)",
		GuideSubID = 20006,
		GuideName = "旁白说明潜能2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-560,
				-10,
				20007,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "WarlockChoosePanel(Clone)",
		GuideSubID = 20007,
		GuideName = "旁白说明潜能2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-560,
				-10,
				20008,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "WarlockChoosePanel(Clone)",
		GuideSubID = 20008,
		GuideName = "图片说明如何编队",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.Picture,
				"Assets/05_Images/DataResource/UIResource/GuideCommonImg/GuideCommonImg_13.png"
			}
		}
	},
	{
		GuideSubShow = "WarlockChoosePanel(Clone)",
		GuideSubID = 20009,
		GuideName = "引导点击返回主界面按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				100,
				100,
				"RoleDevelopmentPanel(Clone)/ContentRoot/SubContent/PersonalityPanel/ReturnBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				20010,
				-210,
				250
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"RoleDevelopmentPanel(Clone)/ContentRoot/SubContent/PersonalityPanel/ReturnBtn",
				0,
				0,
				0,
				-1,
				3.5,
				3.5,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "WarlockChoosePanel(Clone)",
		GuideSubID = 20010,
		GuideName = "引导点击返回主界面按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				100,
				100,
				"WarlockChoosePanel(Clone)/Root/Com_ReturnBtn/HomeBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				20011,
				-210,
				250
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"WarlockChoosePanel(Clone)/Root/Com_ReturnBtn/HomeBtn",
				0,
				0,
				0,
				-1,
				3.5,
				3.5,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 20501,
		GuideName = "旁白说明潜能引导重连1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-560,
				-10,
				20501,
				"#0D0B0B50"
			}
		}
	},
	{
		FindObjWithPath = true,
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 20502,
		GuideName = "引导点击前往祓禊界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				250,
				230,
				"HomeMountPoint(Clone)/PartRoot/30401001/30401001/ExploreBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				20502,
				510,
				-95
			}
		}
	},
	{
		GuideSubShow = "PlayingMethodUI(Clone)",
		GuideSubID = 20503,
		GuideName = "引导点击前往关卡界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				550,
				300,
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/MapParent/MapBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				20503,
				170,
				-130
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/MapParent/MapBtn",
				0,
				0,
				0,
				-1,
				24,
				14,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 21001,
		GuideName = "旁白说明引导前往金币副本1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				21001,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 21002,
		GuideName = "旁白说明引导前往日常副本1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				21002,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 21003,
		GuideName = "旁白说明引导前往日常副本1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				21003,
				"#0D0B0B50"
			}
		}
	},
	{
		FindObjWithPath = true,
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 21004,
		GuideName = "引导点击前往祓禊界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				350,
				200,
				"HomeMountPoint(Clone)/PartRoot/30401001/30401001/ExploreBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				21004,
				510,
				-95
			}
		}
	},
	{
		GuideSubShow = "PlayingMethodUI(Clone)",
		GuideSubID = 21005,
		GuideName = "引导点击进入日常副本",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				290,
				180,
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/BossParent/BossBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				21005,
				170,
				10
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/BossParent/BossBtn",
				0,
				0,
				0,
				-1,
				12,
				8,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "ResourceStageUI(Clone)",
		GuideSubID = 21006,
		GuideName = "旁白说明金币副本产出1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				21006,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ResourceStageUI(Clone)",
		GuideSubID = 21007,
		GuideName = "旁白说明金币副本产出1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				21007,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ResourceStageUI(Clone)",
		GuideSubID = 21008,
		GuideName = "引导点击返回主界面按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				400,
				400,
				"ResourceStageUI(Clone)/Root/CenterInfo/baseResourceScroll/Viewport/stageContent/2/Image/buttonClick",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				21008,
				-210,
				250
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"ResourceStageUI(Clone)/Root/CenterInfo/baseResourceScroll/Viewport/stageContent/2/Image/buttonClick",
				0,
				0,
				0,
				-1,
				18,
				18,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 21009,
		GuideName = "引导点击返回主界面按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				280,
				100,
				"StageUI(Clone)/Root/CenterInfo/startBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				21009,
				600,
				-200
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"StageUI(Clone)/Root/CenterInfo/startBtn",
				0,
				0,
				0,
				-1,
				11,
				3.5,
				"effect/fang"
			}
		}
	},
	{
		FindObjWithPath = true,
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 22001,
		GuideName = "引导点击前往祓禊界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				350,
				200,
				"HomeMountPoint(Clone)/PartRoot/30401001/30401001/ExploreBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				21004,
				510,
				-95
			}
		}
	},
	{
		GuideSubShow = "PlayingMethodUI(Clone)",
		GuideSubID = 22002,
		GuideName = "引导点击进入日常副本",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				290,
				180,
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/BossParent/BossBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				21005,
				170,
				10
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/BossParent/BossBtn",
				0,
				0,
				0,
				-1,
				12,
				8,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "StageUI(Clone)",
		GuideSubID = 22003,
		GuideName = "旁白说明多倍挑战1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				22001,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "StageUI(Clone)",
		GuideSubID = 22004,
		GuideName = "旁白说明多倍挑战1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				22002,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "StageUI(Clone)",
		GuideSubID = 22005,
		GuideName = "引导点击多倍挑战按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				400,
				400,
				"ResourceStageUI(Clone)/Root/CenterInfo/baseResourceScroll/Viewport/stageContent/2/Image/buttonClick",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				22003,
				50,
				75
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"ResourceStageUI(Clone)/Root/CenterInfo/baseResourceScroll/Viewport/stageContent/2/Image/buttonClick",
				0,
				0,
				0,
				-1,
				18,
				18,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "StageUI(Clone)",
		GuideSubID = 22006,
		GuideName = "旁白说明多倍挑战功能1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				22004,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "StageUI(Clone)",
		GuideSubID = 22007,
		GuideName = "旁白说明多倍挑战功能2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				22005,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "StageUI(Clone)",
		GuideSubID = 22008,
		GuideName = "旁白说明多倍挑战功能3",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				22006,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "StageUI(Clone)",
		GuideSubID = 22009,
		GuideName = "旁白说明多倍挑战功能4",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				22007,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 22501,
		GuideName = "旁白说明多倍挑战断线重连1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				22501,
				"#0D0B0B50"
			}
		}
	},
	{
		FindObjWithPath = true,
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 22502,
		GuideName = "引导点击前往祓禊界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				250,
				230,
				"HomeMountPoint(Clone)/PartRoot/30401001/30401001/ExploreBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				22503,
				510,
				-95
			}
		}
	},
	{
		GuideSubShow = "PlayingMethodUI(Clone)",
		GuideSubID = 22503,
		GuideName = "引导点击前往祓禊界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				550,
				300,
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/BossParent/BossBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				22503,
				170,
				-130
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/BossParent/BossBtn",
				0,
				0,
				0,
				-1,
				24,
				14,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "PlayingMethodUI(Clone)",
		GuideSubID = 22504,
		GuideName = "引导点击前往祓禊界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				550,
				300,
				"ResourceStageUI(Clone)/Root/CenterInfo/baseResourceScroll/Viewport/stageContent/2/buttonClick",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				22504,
				170,
				-130
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"ResourceStageUI(Clone)/Root/CenterInfo/baseResourceScroll/Viewport/stageContent/2/buttonClick",
				0,
				0,
				0,
				-1,
				24,
				14,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 23001,
		GuideName = "旁白说明引导前往日常副本1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				23001,
				"#0D0B0B50"
			}
		}
	},
	{
		FindObjWithPath = true,
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 23002,
		GuideName = "引导点击前往祓禊界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				350,
				200,
				"HomeMountPoint(Clone)/PartRoot/30401001/30401001/ExploreBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				22503,
				510,
				-95
			}
		}
	},
	{
		GuideSubShow = "PlayingMethodUI(Clone)",
		GuideSubID = 23003,
		GuideName = "引导点击进入技能材料副本",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				320,
				200,
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/EquipParent/EquipBtn",
				10,
				10,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				17006,
				300,
				110
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/EquipParent/EquipBtn",
				10,
				10,
				0,
				-1,
				14,
				9,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "ResourceStageUI(Clone)",
		GuideSubID = 23004,
		GuideName = "旁白说明技能材料副本产出1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				23004,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ResourceStageUI(Clone)",
		GuideSubID = 23005,
		GuideName = "旁白说明技能材料副本产出2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				23005,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ResourceStageUI(Clone)",
		GuideSubID = 23006,
		GuideName = "旁白说明日常副本产出3",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				23006,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ResourceStageUI(Clone)",
		GuideSubID = 23007,
		GuideName = "引导点击返回主界面按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				100,
				100,
				"ResourceStageUI(Clone)/Root/Com_ReturnBtn/HomeBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				23007,
				-210,
				250
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"ResourceStageUI(Clone)/Root/Com_ReturnBtn/HomeBtn",
				0,
				0,
				0,
				-1,
				3.5,
				3.5,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 23501,
		GuideName = "旁白说明印记副本断线重连1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				23501,
				"#0D0B0B50"
			}
		}
	},
	{
		FindObjWithPath = true,
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 23502,
		GuideName = "引导点击前往祓禊界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				250,
				230,
				"HomeMountPoint(Clone)/PartRoot/30401001/30401001/ExploreBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				22503,
				510,
				-95
			}
		}
	},
	{
		GuideSubShow = "PlayingMethodUI(Clone)",
		GuideSubID = 23503,
		GuideName = "引导点击前往神觉修行",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				550,
				300,
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/EquipParent/EquipBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				23503,
				170,
				-130
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/EquipParent/EquipBtn",
				0,
				0,
				0,
				-1,
				24,
				14,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 24001,
		GuideName = "引导点击神觉者按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				100,
				100,
				"MainUI(Clone)/Root/Panel_UI/Top/MainUIInfo/HeroBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				24001,
				450,
				-220
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"MainUI(Clone)/Root/Panel_UI/Top/MainUIInfo/HeroBtn",
				0,
				0,
				0,
				-1,
				3.5,
				3.5,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "WarlockChoosePanel(Clone)",
		GuideSubID = 24002,
		GuideName = "引导点击神觉者",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				250,
				500,
				"WarlockChoosePanel(Clone)/Root/ScroolRoot/ScrollAreaBig/Viewport/Index_0/Item1",
				20,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				24002,
				-72,
				-72
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"WarlockChoosePanel(Clone)/Root/ScroolRoot/ScrollAreaBig/Viewport/Index_0/Item1",
				20,
				0,
				0,
				-1,
				10,
				22,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 24003,
		GuideName = "旁白说明技能页签1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				24003,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 24004,
		GuideName = "引导点击神觉者",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				180,
				50,
				"RoleDevelopmentPanel(Clone)/ContentRoot/SubContent/InfoPanel/RoleInfoPanelRoot/RoleInfoPanel/RightParent/ToggleGroup/skillTabItem",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				24004,
				550,
				135
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"RoleDevelopmentPanel(Clone)/ContentRoot/SubContent/InfoPanel/RoleInfoPanelRoot/RoleInfoPanel/RightParent/ToggleGroup/skillTabItem",
				0,
				0,
				0,
				-1,
				8,
				2,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 24005,
		GuideName = "引导点击神觉者",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				75,
				75,
				"RoleDevelopmentPanel(Clone)/ContentRoot/SubContent/InfoPanel/RoleInfoPanelRoot/RoleInfoPanel/RightParent/skillParent/SkillBriefRoot/SkillItem3/buttonClick",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				24005,
				525,
				60
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"RoleDevelopmentPanel(Clone)/ContentRoot/SubContent/InfoPanel/RoleInfoPanelRoot/RoleInfoPanel/RightParent/skillParent/SkillBriefRoot/SkillItem3/buttonClick",
				0,
				0,
				0,
				-1,
				3.5,
				3.5,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 24006,
		GuideName = "旁白说明技能养成效果1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				24006,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 24007,
		GuideName = "旁白说明技能养成效果1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				24007,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 24008,
		GuideName = "旁白说明技能养成效果1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				24008,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 25001,
		GuideName = "旁白说明灵契1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-560,
				-10,
				25001,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 25002,
		GuideName = "旁白说明潜能2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-560,
				-10,
				25002,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 25003,
		GuideName = "引导点击神觉者按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				100,
				100,
				"MainUI(Clone)/Root/Panel_UI/Top/MainUIInfo/HeroBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				25004,
				430,
				-200
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"MainUI(Clone)/Root/Panel_UI/Top/MainUIInfo/HeroBtn",
				0,
				0,
				0,
				-1,
				4,
				4,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "WarlockChoosePanel(Clone)",
		GuideSubID = 25004,
		GuideName = "引导点击神觉者【安】",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				250,
				500,
				"WarlockChoosePanel(Clone)/Root/ScroolRoot/ScrollAreaBig/Viewport/Index_0/Item1",
				20,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				25005,
				-72,
				-72
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"WarlockChoosePanel(Clone)/Root/ScroolRoot/ScrollAreaBig/Viewport/Index_0/Item1",
				20,
				0,
				0,
				-1,
				10,
				22,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "WarlockChoosePanel(Clone)",
		GuideSubID = 25005,
		GuideName = "引导点击灵契页签",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				120,
				50,
				"RoleDevelopmentPanel(Clone)/ContentRoot/LeftContent/TabListRoot/ToggleGroup/equipTabItem",
				-50,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				25006,
				-72,
				-72
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"RoleDevelopmentPanel(Clone)/ContentRoot/LeftContent/TabListRoot/ToggleGroup/equipTabItem",
				-50,
				0,
				0,
				-1,
				6,
				2,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 25006,
		GuideName = "旁白说明灵契效果1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-560,
				-10,
				25007,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 25007,
		GuideName = "旁白说明灵契效果2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-560,
				-10,
				25008,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 25008,
		GuideName = "旁白说明灵契效果3",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-560,
				-10,
				25009,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 25009,
		GuideName = "旁白说明灵契效果3",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-560,
				-10,
				25010,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "FormationUI(Clone)",
		GuideSubID = 25010,
		GuideName = "图片说明如何编队",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.Picture,
				"Assets/05_Images/DataResource/UIResource/GuideCommonImg/GuideCommonImg_12.png"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 25501,
		GuideName = "旁白说明潜能引导重连1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321014,
				1,
				1,
				-560,
				-10,
				25501,
				"#0D0B0B50"
			}
		}
	},
	{
		FindObjWithPath = true,
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 25502,
		GuideName = "引导点击前往祓禊界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				350,
				200,
				"HomeMountPoint(Clone)/PartRoot/30401001/30401001/ExploreBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				25502,
				510,
				-95
			}
		}
	},
	{
		GuideSubShow = "PlayingMethodUI(Clone)",
		GuideSubID = 25503,
		GuideName = "引导点击前往关卡界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				550,
				300,
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/MapParent/MapBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				25503,
				170,
				-130
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/MapParent/MapBtn",
				0,
				0,
				0,
				-1,
				24,
				14,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 26001,
		GuideName = "旁白说明引导前往日常副本1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				26001,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 26002,
		GuideName = "旁白说明引导前往日常副本2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				26002,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ChapterStageMapUI(Clone)",
		GuideSubID = 26003,
		GuideName = "旁白说明引导前往日常副本3",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				26003,
				"#0D0B0B50"
			}
		}
	},
	{
		FindObjWithPath = true,
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 26004,
		GuideName = "引导点击前往祓禊界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				350,
				200,
				"HomeMountPoint(Clone)/PartRoot/30401001/30401001/ExploreBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321005,
				25502,
				510,
				-95
			}
		}
	},
	{
		GuideSubShow = "PlayingMethodUI(Clone)",
		GuideSubID = 26005,
		GuideName = "引导点击进入鬼神寻踪副本",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				400,
				220,
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/ResParent/ResBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				26005,
				-210,
				-50
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/ResParent/ResBtn",
				0,
				0,
				0,
				-1,
				18,
				12,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "ResourceStageUI(Clone)",
		GuideSubID = 26006,
		GuideName = "旁白说明鬼神寻踪副本产出1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				26006,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "ResourceStageUI(Clone)",
		GuideSubID = 26007,
		GuideName = "旁白说明鬼神寻踪副本产出2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				26007,
				"#0D0B0B50"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 26501,
		GuideName = "旁白说明印记副本断线重连1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				26501,
				"#0D0B0B50"
			}
		}
	},
	{
		FindObjWithPath = true,
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 26502,
		GuideName = "引导点击前往祓禊界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				250,
				230,
				"HomeMountPoint(Clone)/PartRoot/30401001/30401001/ExploreBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				26503,
				510,
				-95
			}
		}
	},
	{
		GuideSubShow = "PlayingMethodUI(Clone)",
		GuideSubID = 26503,
		GuideName = "引导点击前往主线地图",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				550,
				300,
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/MapParent/MapBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				26503,
				170,
				-130
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/MapParent/MapBtn",
				0,
				0,
				0,
				-1,
				24,
				14,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 30101,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				30101,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 30102,
		GuideName = "旁白说明降神2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				30102,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 30103,
		GuideName = "旁白说明降神3",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				30103,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 30104,
		GuideName = "引导点击常行世间卡池",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				90,
				90,
				"MainUI(Clone)/Root/Panel_UI/RpgRoot/RightBottom/SmallPhone/OpenPhoneBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				30104,
				300,
				-200
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_01",
				"MainUI(Clone)/Root/Panel_UI/RpgRoot/RightBottom/SmallPhone/OpenPhoneBtn",
				0,
				0,
				0,
				-1,
				0.9,
				0.9,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "MainPhoneUI(Clone)",
		GuideSubID = 30105,
		GuideName = "引导点击单抽",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				90,
				90,
				"MainUI(Clone)/MainPhoneUI/Root/menuPanel_UI/Top/Left/ButtonSort/ButtonRoot/LotteryBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				30105,
				0,
				-180
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_01",
				"MainUI(Clone)/MainPhoneUI/Root/menuPanel_UI/Top/Left/ButtonSort/ButtonRoot/LotteryBtn",
				0,
				0,
				0,
				-1,
				0.9,
				0.9,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "LotteryUI(Clone)",
		GuideSubID = 30106,
		GuideName = "旁白说明降神",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				30106,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "LotteryUI(Clone)",
		GuideSubID = 30107,
		GuideName = "引导点击单抽",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				280,
				80,
				"LotteryUI(Clone)/Root/Panel_UI/Center_Top/MainUI/Canvas/LeftBottomParent/RewardListBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				3012,
				550,
				-180
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"LotteryUI(Clone)/Root/Panel_UI/Center_Top/MainUI/Canvas/LeftBottomParent/RewardListBtn",
				0,
				0,
				0,
				-1,
				12,
				3,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "LotteryTipsUI(Clone)",
		WaitCustomEventTrigger = 101,
		GuideSubID = 30108,
		GuideName = "旁白说明降神",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				3013,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "LotteryTipsUI(Clone)",
		GuideSubID = 30109,
		GuideName = "引导点击单抽",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				280,
				80,
				"LotteryTipsUI(Clone)/Root/Content/ItemTabs/TabGroup/Tab2",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				3012,
				550,
				-180
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"LotteryTipsUI(Clone)/Root/Content/ItemTabs/TabGroup/Tab2",
				0,
				0,
				0,
				-1,
				12,
				3,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "LotteryTipsUI(Clone)",
		WaitCustomEventTrigger = 101,
		GuideSubID = 30110,
		GuideName = "旁白说明降神",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				3013,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "LotteryTipsUI(Clone)",
		GuideSubID = 30111,
		GuideName = "引导点击单抽",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				280,
				80,
				"LotteryTipsUI(Clone)/Root/Content/CloseBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				3012,
				550,
				-180
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"LotteryTipsUI(Clone)/Root/Content/CloseBtn",
				0,
				0,
				0,
				-1,
				12,
				3,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "LotteryUI(Clone)",
		WaitCustomEventTrigger = 101,
		GuideSubID = 30112,
		GuideName = "旁白说明降神",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				3013,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "LotteryUI(Clone)",
		GuideSubID = 30113,
		GuideName = "引导点击单抽",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				280,
				72,
				"LotteryUI(Clone)/Root/Panel_UI/Center_Top/MainUI/Canvas/LotteryButtonsParent/Button_Ten",
				5,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				30107,
				250,
				-180
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_02",
				"LotteryUI(Clone)/Root/Panel_UI/Center_Top/MainUI/Canvas/LotteryButtonsParent/Button_Ten",
				2.5,
				0,
				0,
				-1,
				1.83,
				0.75,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 30201,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				30201,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainPhoneUI(Clone)",
		GuideSubID = 30202,
		GuideName = "引导点击单抽",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				290,
				290,
				"MainPhoneUI(Clone)/Root/menuPanel_UI/Top/Right/StartGameParent/ExploreBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				30202,
				300,
				-180
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan_01",
				"MainPhoneUI(Clone)/Root/menuPanel_UI/Top/Right/StartGameParent/ExploreBtn",
				0,
				0,
				0,
				-1,
				8,
				8,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 30203,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				30203,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 30301,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				30301,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 30302,
		GuideName = "引导点击常行世间卡池",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				90,
				90,
				"MainUI(Clone)/Root/Panel_UI/RpgRoot/RightBottom/SmallPhone/OpenPhoneBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				30104,
				300,
				-200
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_01",
				"MainUI(Clone)/Root/Panel_UI/RpgRoot/RightBottom/SmallPhone/OpenPhoneBtn",
				0,
				0,
				0,
				-1,
				0.9,
				0.9,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "MainPhoneUI(Clone)",
		GuideSubID = 30303,
		GuideName = "引导点击单抽",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				90,
				90,
				"MainUI(Clone)/MainPhoneUI/Root/menuPanel_UI/Top/Left/ButtonSort/ButtonRoot/HeroBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				30303,
				0,
				-180
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_01",
				"MainUI(Clone)/MainPhoneUI/Root/menuPanel_UI/Top/Left/ButtonSort/ButtonRoot/HeroBtn",
				0,
				0,
				0,
				-1,
				0.9,
				0.9,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "WarlockChoosePanel(Clone)",
		GuideSubID = 30304,
		GuideName = "引导点击单抽",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				210,
				500,
				"WarlockChoosePanel(Clone)/Root/ScroolRoot/ScrollAreaBig/Viewport/Index_0/Item1",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				30304,
				0,
				-180
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_03",
				"WarlockChoosePanel(Clone)/Root/ScroolRoot/ScrollAreaBig/Viewport/Index_0/Item1",
				0,
				0,
				0,
				-1,
				16.25,
				0.95,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 30305,
		GuideName = "旁白说明引导点击升级按键1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				30305,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 30306,
		GuideName = "旁白说明引导点击升级按键2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				30306,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 30307,
		GuideName = "引导点击升级按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				80,
				80,
				"RoleDevelopmentPanel(Clone)/ContentRoot/SubContent/InfoPanel/RoleInfoPanelRoot/RoleInfoPanel/RightParent/topParent/UpgradedBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				30307,
				330,
				150
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan_01",
				"RoleDevelopmentPanel(Clone)/ContentRoot/SubContent/InfoPanel/RoleInfoPanelRoot/RoleInfoPanel/RightParent/topParent/UpgradedBtn/Image",
				0,
				0,
				0,
				-1,
				2,
				2,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 30308,
		GuideName = "旁白说明引导点击升级经验材料1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				30308,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 30309,
		GuideName = "引导点击单抽",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				170,
				48,
				"RoleDevelopmentPanel(Clone)/ContentRoot/SubContent/InfoPanel/RoleUpgradePanelRoot/RoleUpgradePanel/BottomParent/QuickAddBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				30309,
				700,
				0
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_01",
				"RoleDevelopmentPanel(Clone)/ContentRoot/SubContent/InfoPanel/RoleUpgradePanelRoot/RoleUpgradePanel/BottomParent/QuickAddBtn",
				0,
				0,
				0,
				-1,
				1.55,
				0.53,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 30310,
		GuideName = "旁白说明引导点击升级经验材料2",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				30310,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainPhoneUI(Clone)",
		GuideSubID = 30401,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				30401,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainPhoneUI(Clone)",
		GuideSubID = 30402,
		GuideName = "引导点击单抽",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				290,
				290,
				"MainPhoneUI(Clone)/Root/menuPanel_UI/Top/Right/StartGameParent/ExploreBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				30402,
				300,
				-180
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan_01",
				"MainPhoneUI(Clone)/Root/menuPanel_UI/Top/Right/StartGameParent/ExploreBtn",
				0,
				0,
				0,
				-1,
				8,
				8,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "MainPhoneUI(Clone)",
		GuideSubID = 30403,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				30403,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 30501,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				30501,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 30502,
		GuideName = "引导点击常行世间卡池",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				210,
				115,
				"MainUI(Clone)/Root/Panel_UI/RpgRoot/RPGInfoRoot/buttonMap",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				30502,
				-400,
				150
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_01",
				"MainUI(Clone)/Root/Panel_UI/RpgRoot/RPGInfoRoot/buttonMap",
				0,
				0,
				0,
				-1,
				1.9,
				1.3,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "WorldAreaUI(Clone)",
		GuideSubID = 30503,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				30503,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "WorldAreaUI(Clone)",
		GuideSubID = 30504,
		GuideName = "引导点击常行世间卡池",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				105,
				360,
				"WorldAreaUI(Clone)/Root/mapScroll/viewport/content/10300/buttonClick",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				30504,
				200,
				-200
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_03",
				"WorldAreaUI(Clone)/Root/mapScroll/viewport/content/10300/buttonClick",
				0,
				0,
				0,
				-1,
				8.5,
				0.7,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "WorldAreaUI(Clone)",
		GuideSubID = 30505,
		GuideName = "引导点击常行世间卡池",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				90,
				90,
				"WorldAreaUI(Clone)/Root/areaDetailPop/buttonEnter",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				30505,
				200,
				-200
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_01",
				"WorldAreaUI(Clone)/Root/areaDetailPop/buttonEnter",
				0,
				0,
				0,
				-1,
				0.7,
				0.7,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 30506,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				30506,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)/Root/Panel_UI/RpgRoot/RPGInfoRoot/buttonSwitchTime",
		GuideSubID = 30507,
		GuideName = "引导点击升级按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				80,
				80,
				"MainUI(Clone)/Root/Panel_UI/RpgRoot/RPGInfoRoot/buttonSwitchTime",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				30507,
				0,
				150
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan_01",
				"MainUI(Clone)/Root/Panel_UI/RpgRoot/RPGInfoRoot/buttonSwitchTime",
				0,
				0,
				0,
				-1,
				2,
				2,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 30508,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				30508,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 30509,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				30509,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 30510,
		GuideName = "引导点击常行世间卡池",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				300,
				80,
				"MainUI(Clone)/Root/Panel_UI/RpgRoot/RPGInfoRoot/taskInfo/buttonTask",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				30510,
				-200,
				0
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_01",
				"MainUI(Clone)/Root/Panel_UI/RpgRoot/RPGInfoRoot/taskInfo/buttonTask",
				0,
				0,
				0,
				-1,
				3.5,
				1,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "TaskSystemUI(Clone)",
		GuideSubID = 30511,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				30511,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "TaskSystemUI(Clone)",
		GuideSubID = 30512,
		GuideName = "引导点击常行世间卡池",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				150,
				90,
				"TaskSystemUI(Clone)/Root/Panel_UI/CenterContent/TapContent/TapContent/Period",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				30512,
				-180,
				-200
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_01",
				"TaskSystemUI(Clone)/Root/Panel_UI/CenterContent/TapContent/TapContent/Period",
				0,
				0,
				0,
				-1,
				1.5,
				0.9,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "TaskSystemUI(Clone)",
		GuideSubID = 30513,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				30513,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 30601,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				30601,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 30602,
		GuideName = "引导点击常行世间卡池",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				210,
				115,
				"MainUI(Clone)/Root/Panel_UI/RpgRoot/RPGInfoRoot/buttonMap",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				30602,
				-400,
				150
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_01",
				"MainUI(Clone)/Root/Panel_UI/RpgRoot/RPGInfoRoot/buttonMap",
				0,
				0,
				0,
				-1,
				1.9,
				1.3,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "WorldAreaUI(Clone)/Root/TapContent/TapContent/Day",
		GuideSubID = 30603,
		GuideName = "引导点击常行世间卡池",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				140,
				75,
				"WorldAreaUI(Clone)/Root/TapContent/TapContent/Day",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				30603,
				-200,
				-200
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_02",
				"WorldAreaUI(Clone)/Root/TapContent/TapContent/Day",
				0,
				0,
				0,
				-1,
				0.95,
				0.7,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "WorldAreaUI(Clone)/Root/Richang/button1",
		GuideSubID = 30604,
		GuideName = "引导点击常行世间卡池",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				100,
				100,
				"WorldAreaUI(Clone)/Root/Richang/button1",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				30604,
				-200,
				-100
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan_01",
				"WorldAreaUI(Clone)/Root/Richang/button1",
				0,
				0,
				0,
				-1,
				3.1,
				3.1,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "ResourceStageUI(Clone)",
		GuideSubID = 30605,
		GuideName = "引导点击常行世间卡池",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				330,
				380,
				"ResourceStageUI(Clone)/Root/CenterInfo/baseResourceScroll/Viewport/stageContent/1/Image/buttonClick",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				30605,
				-200,
				-300
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_03",
				"ResourceStageUI(Clone)/Root/CenterInfo/baseResourceScroll/Viewport/stageContent/1/Image/buttonClick",
				0,
				0,
				0,
				-1,
				27,
				0.73,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "StageUI(Clone)",
		GuideSubID = 30606,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				30606,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 100001,
		GuideName = "旁白说明夏日活动开启",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				100001,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 100002,
		GuideName = "旁白说明夏日活动开启",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				100002,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		FindObjWithPath = true,
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 100003,
		GuideName = "引导点击神觉者按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				175,
				200,
				"HomeMountPoint(Clone)/PartRoot/30401007/30401007/Btn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				100003,
				575,
				-87,
				true
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 100004,
		GuideName = "旁白说明夏日活动开启",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				100004,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 3121,
		GuideName = "旁白说明引导点击神觉者按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				3121,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 3122,
		GuideName = "旁白说明引导点击神觉者按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				3122,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 3123,
		GuideName = "引导点击神觉者按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				130,
				130,
				"MainUI(Clone)/Root/Panel_UI/Top/MainUIInfo/HeroBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				3123,
				535,
				-182
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"MainUI(Clone)/Root/Panel_UI/Top/MainUIInfo/HeroBtn/heroImg",
				0,
				0,
				0,
				-1,
				6,
				6,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "WarlockChoosePanel(Clone)",
		GuideSubID = 3124,
		GuideName = "旁白说明引导点击神觉者【环】",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				3124,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "WarlockChoosePanel(Clone)",
		GuideSubID = 3125,
		GuideName = "引导点击神觉者【环】",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				250,
				500,
				"WarlockChoosePanel(Clone)/Root/ScroolRoot/ScrollAreaBig/Viewport/Index_0/Item1",
				20,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				3125,
				-72,
				-72
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"WarlockChoosePanel(Clone)/Root/ScroolRoot/ScrollAreaBig/Viewport/Index_0/Item1",
				0,
				0,
				0,
				-1,
				10,
				22,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 3126,
		GuideName = "旁白说明引导点击升级按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				3126,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 3127,
		GuideName = "旁白说明引导点击升级按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				3127,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 3128,
		GuideName = "引导点击升级按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				130,
				130,
				"RoleDevelopmentPanel(Clone)/ContentRoot/SubContent/InfoPanel/RoleInfoPanelRoot/RoleInfoPanel/RightParent/topParent/UpgradedBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				3128,
				630,
				150
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan",
				"RoleDevelopmentPanel(Clone)/ContentRoot/SubContent/InfoPanel/RoleInfoPanelRoot/RoleInfoPanel/RightParent/topParent/UpgradedBtn/Image",
				0,
				0,
				0,
				-1,
				5,
				5,
				"effect/yuan"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 3129,
		GuideName = "旁白说明引导点击升级经验材料",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				3129,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 3130,
		GuideName = "旁白说明引导点击升级经验材料",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				3130,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 3131,
		GuideName = "引导点击升级材料",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				100,
				100,
				"RoleDevelopmentPanel(Clone)/ContentRoot/SubContent/InfoPanel/RoleUpgradePanelRoot/RoleUpgradePanel/ItemGrid/UpgradeMaterialsItem1",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				3131,
				630,
				-68
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"RoleDevelopmentPanel(Clone)/ContentRoot/SubContent/InfoPanel/RoleUpgradePanelRoot/RoleUpgradePanel/ItemGrid/UpgradeMaterialsItem1",
				0,
				0,
				0,
				-1,
				3.5,
				3.5,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 3132,
		GuideName = "引导点击升级按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				420,
				75,
				"RoleDevelopmentPanel(Clone)/ContentRoot/SubContent/InfoPanel/RoleUpgradePanelRoot/RoleUpgradePanel/BtnParent/UpgradeBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				3132,
				615,
				-170
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"RoleDevelopmentPanel(Clone)/ContentRoot/SubContent/InfoPanel/RoleUpgradePanelRoot/RoleUpgradePanel/BtnParent/UpgradeBtn/Image",
				0,
				0,
				0,
				-1,
				18,
				3,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 3133,
		GuideName = "旁白说明升级效果",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				3133,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		FindObjWithPath = true,
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 3201,
		GuideName = "引导点击前往祓禊界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				250,
				230,
				"200_1_Home_Screen_Daytime_PrefabMainCity(Clone)/mainCityWorldSpaceUI/StartGameParent/StartGameBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				3201,
				510,
				-95
			}
		}
	},
	{
		GuideSubShow = "PlayingMethodUI(Clone)",
		GuideSubID = 3202,
		GuideName = "引导点击前往祓禊界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				550,
				300,
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/MapParent/MapBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				3202,
				170,
				-130
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/MapParent/MapBtn",
				0,
				0,
				0,
				-1,
				24,
				14,
				"effect/fang"
			}
		}
	},
	{
		FindObjWithPath = true,
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 3251,
		GuideName = "引导点击前往祓禊界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				250,
				230,
				"200_1_Home_Screen_Daytime_PrefabMainCity(Clone)/mainCityWorldSpaceUI/StartGameParent/StartGameBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				3251,
				510,
				-95
			}
		}
	},
	{
		GuideSubShow = "PlayingMethodUI(Clone)",
		GuideSubID = 3252,
		GuideName = "引导点击前往祓禊界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				550,
				300,
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/MapParent/MapBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				3252,
				170,
				-130
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/MapParent/MapBtn",
				0,
				0,
				0,
				-1,
				24,
				14,
				"effect/fang"
			}
		}
	},
	{
		FindObjWithPath = true,
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 3271,
		GuideName = "引导点击前往祓禊界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				250,
				230,
				"200_1_Home_Screen_Daytime_PrefabMainCity(Clone)/mainCityWorldSpaceUI/StartGameParent/StartGameBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				3271,
				510,
				-95
			}
		}
	},
	{
		GuideSubShow = "PlayingMethodUI(Clone)",
		GuideSubID = 3272,
		GuideName = "引导点击前往祓禊界面",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				550,
				300,
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/MapParent/MapBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				3272,
				170,
				-130
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"PlayingMethodUI(Clone)/Root/Panel_UI/Center_Bottom/PlayingMethodParent/MapParent/MapBtn",
				0,
				0,
				0,
				-1,
				24,
				14,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "MazeMainUI(Clone)",
		GuideSubID = 4001,
		GuideName = "点击开始调查按钮",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				1,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				170,
				90,
				"MazeMainUI(Clone)/Root/CenterInfo/contentParent/startBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321002,
				4001,
				0,
				0
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"MazeMainUI(Clone)/Root/CenterInfo/contentParent/startBtn",
				0,
				0,
				0,
				-1,
				7.7,
				4,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "FormationUI(Clone)",
		GuideSubID = 4002,
		GuideName = "旁白引导技能类型和技能描述1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321004,
				1,
				1,
				-410,
				94,
				4002,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "StoryUI(Clone)",
		GuideSubID = 5001,
		GuideName = "点击异象仪按钮",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				1,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				170,
				90,
				"StoryUI(Clone)/MazeRoot/StoryMaze(Clone)/rightBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321002,
				5001,
				0,
				0
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"StoryUI(Clone)/MazeRoot/StoryMaze(Clone)/rightBtn",
				0,
				0,
				0,
				-1,
				7.7,
				4,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "MazeEquipUI(Clone)",
		GuideSubID = 5002,
		GuideName = "点击镶孔1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				1,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				100,
				100,
				"MazeEquipUI(Clone)/Root/CenterContent/equipPanel/equipGrid/EquipItem(Clone)/holeGrid/holeItem(Clone)",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321002,
				5002,
				0,
				0
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"MazeEquipUI(Clone)/Root/CenterContent/equipPanel/equipGrid/EquipItem(Clone)/holeGrid/holeItem(Clone)",
				0,
				0,
				0,
				-1,
				4.5,
				4.5,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "MazeEquipUI(Clone)",
		GuideSubID = 5003,
		GuideName = "点击矿石1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				1,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				110,
				110,
				"MazeEquipUI(Clone)/Root/CenterContent/equipPanel/rightPanel/GemOperationPanel/sort/gemScroll/Viewport/Index_0/holeItem(Clone)",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321002,
				5003,
				0,
				0
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"MazeEquipUI(Clone)/Root/CenterContent/equipPanel/rightPanel/GemOperationPanel/sort/gemScroll/Viewport/Index_0/holeItem(Clone)",
				0,
				0,
				0,
				-1,
				4.9,
				4.9,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "MazeEquipUI(Clone)",
		GuideSubID = 5004,
		GuideName = "展示矿石1信息",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				1,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				400,
				115,
				"MazeEquipUI/Root/CenterContent/equipPanel/rightPanel/GemOperationPanel/sort/GameObject",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321002,
				5004,
				0,
				0,
				true
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"MazeEquipUI/Root/CenterContent/equipPanel/rightPanel/GemOperationPanel/sort/GameObject",
				0,
				0,
				0,
				-1,
				18.1,
				5.1,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "MazeEquipUI(Clone)",
		GuideSubID = 5005,
		GuideName = "点击镶嵌按钮",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				1,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				200,
				54,
				"MazeEquipUI(Clone)/Root/CenterContent/equipPanel/rightPanel/GemOperationPanel/equipBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321002,
				5005,
				0,
				0
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"MazeEquipUI(Clone)/Root/CenterContent/equipPanel/rightPanel/GemOperationPanel/equipBtn",
				0,
				0,
				0,
				-1,
				9.1,
				2.5,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "MazeEquipUI(Clone)",
		GuideSubID = 5006,
		GuideName = "展示激活buff",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				1,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				402,
				100,
				"MazeEquipUI(Clone)/Root/CenterContent/equipPanel/rightPanel/ActivityBuffsPanel/ActivityBuffsScroll/Viewport/Index_0/activeItem(Clone)",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321002,
				5006,
				0,
				0,
				true
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"MazeEquipUI(Clone)/Root/CenterContent/equipPanel/rightPanel/ActivityBuffsPanel/ActivityBuffsScroll/Viewport/Index_0/activeItem(Clone)",
				0,
				0,
				0,
				-1,
				18.2,
				4.4,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "MazeEquipUI(Clone)",
		GuideSubID = 5007,
		GuideName = "点击图鉴按钮",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				1,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				270,
				96,
				"MazeEquipUI(Clone)/Root/LeftTab/buffTab",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321002,
				5007,
				0,
				0
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"MazeEquipUI(Clone)/Root/LeftTab/buffTab",
				0,
				0,
				0,
				-1,
				12.2,
				4.2,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "MazeEquipUI(Clone)",
		GuideSubID = 5008,
		GuideName = "点击退出按钮",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				1,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				58,
				59,
				"MazeEquipUI/Root/Com_ReturnBtn/ReturnBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321002,
				5008,
				0,
				0
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_fang",
				"MazeEquipUI/Root/Com_ReturnBtn/ReturnBtn",
				0,
				0,
				0,
				-1,
				2.7,
				2.7,
				"effect/fang"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 301201,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				301201,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 301202,
		GuideName = "引导点击常行世间卡池",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				90,
				90,
				"MainUI(Clone)/Root/Panel_UI/RpgRoot/RightBottom/SmallPhone/OpenPhoneBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				301202,
				300,
				-200
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_01",
				"MainUI(Clone)/Root/Panel_UI/RpgRoot/RightBottom/SmallPhone/OpenPhoneBtn",
				0,
				0,
				0,
				-1,
				0.9,
				0.9,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "MainPhoneUI(Clone)",
		GuideSubID = 301203,
		GuideName = "引导点击单抽",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				90,
				90,
				"MainUI(Clone)/MainPhoneUI/Root/menuPanel_UI/Top/Left/ButtonSort/ButtonRoot/HeroBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				301203,
				0,
				-180
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_01",
				"MainUI(Clone)/MainPhoneUI/Root/menuPanel_UI/Top/Left/ButtonSort/ButtonRoot/HeroBtn",
				0,
				0,
				0,
				-1,
				0.9,
				0.9,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "WarlockChoosePanel(Clone)",
		GuideSubID = 301204,
		GuideName = "引导点击单抽",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				210,
				500,
				"WarlockChoosePanel(Clone)/Root/ScroolRoot/ScrollAreaBig/Viewport/Index_0/Item1",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				301204,
				0,
				-180
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_03",
				"WarlockChoosePanel(Clone)/Root/ScroolRoot/ScrollAreaBig/Viewport/Index_0/Item1",
				0,
				0,
				0,
				-1,
				16.25,
				0.95,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 301205,
		GuideName = "旁白说明引导点击升级按键1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				301205,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 301206,
		GuideName = "引导点击升级按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				80,
				80,
				"RoleDevelopmentPanel(Clone)/ContentRoot/SubContent/InfoPanel/RoleInfoPanelRoot/RoleInfoPanel/RightParent/Parent/DiyskillParent/DiySkillBriefRoot/DiySkillItem/control/buttonClick",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				301206,
				330,
				150
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan_01",
				"RoleDevelopmentPanel(Clone)/ContentRoot/SubContent/InfoPanel/RoleInfoPanelRoot/RoleInfoPanel/RightParent/Parent/DiyskillParent/DiySkillBriefRoot/DiySkillItem/control/buttonClick",
				0,
				0,
				0,
				-1,
				2,
				2,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "DiySkillInfoUI(Clone)",
		GuideSubID = 301207,
		GuideName = "旁白说明引导点击升级按键1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				301207,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "DiySkillInfoUI(Clone)",
		GuideSubID = 301208,
		GuideName = "引导点击升级按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				80,
				80,
				"DiySkillInfoUI(Clone)/Root/DiySkillInfoPanel/DIYSkillInfoParentRoot/DIYSkillInfoParent/BottomBtnParent/IntensityButton",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				301208,
				330,
				150
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan_01",
				"DiySkillInfoUI(Clone)/Root/DiySkillInfoPanel/DIYSkillInfoParentRoot/DIYSkillInfoParent/BottomBtnParent/IntensityButton",
				0,
				0,
				0,
				-1,
				2,
				2,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "DiySkillStrengthenUI(Clone)",
		GuideSubID = 301209,
		GuideName = "旁白说明引导点击升级按键1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				301209,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 301401,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				301401,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 301402,
		GuideName = "引导点击常行世间卡池",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				90,
				90,
				"MainUI(Clone)/Root/Panel_UI/RpgRoot/RightBottom/SmallPhone/OpenPhoneBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				301402,
				300,
				-200
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_01",
				"MainUI(Clone)/Root/Panel_UI/RpgRoot/RightBottom/SmallPhone/OpenPhoneBtn",
				0,
				0,
				0,
				-1,
				0.9,
				0.9,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "MainPhoneUI(Clone)",
		GuideSubID = 301403,
		GuideName = "引导点击单抽",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				90,
				90,
				"MainUI(Clone)/MainPhoneUI/Root/menuPanel_UI/Top/Left/ButtonSort/ButtonRoot/HeroBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				301403,
				0,
				-180
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_01",
				"MainUI(Clone)/MainPhoneUI/Root/menuPanel_UI/Top/Left/ButtonSort/ButtonRoot/HeroBtn",
				0,
				0,
				0,
				-1,
				0.9,
				0.9,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "WarlockChoosePanel(Clone)",
		GuideSubID = 301404,
		GuideName = "引导点击单抽",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				210,
				500,
				"WarlockChoosePanel(Clone)/Root/ScroolRoot/ScrollAreaBig/Viewport/Index_0/Item1",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				301404,
				0,
				-180
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_03",
				"WarlockChoosePanel(Clone)/Root/ScroolRoot/ScrollAreaBig/Viewport/Index_0/Item1",
				0,
				0,
				0,
				-1,
				16.25,
				0.95,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 301405,
		GuideName = "旁白说明引导点击升级按键1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				301405,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 301406,
		GuideName = "引导点击升级按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				80,
				80,
				"RoleDevelopmentPanel(Clone)/ContentRoot/LeftContent/TabListRoot/ToggleGroup/baseSkillTabItem",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				301406,
				330,
				150
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan_01",
				"RoleDevelopmentPanel(Clone)/ContentRoot/LeftContent/TabListRoot/ToggleGroup/baseSkillTabItem",
				0,
				0,
				0,
				-1,
				2,
				2,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 301407,
		GuideName = "旁白说明引导点击升级按键1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				301407,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 301501,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				301501,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 301502,
		GuideName = "引导点击常行世间卡池",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				300,
				80,
				"MainUI(Clone)/Root/Panel_UI/RpgRoot/RPGInfoRoot/taskInfo/buttonTask",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				301502,
				-200,
				0
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_01",
				"MainUI(Clone)/Root/Panel_UI/RpgRoot/RPGInfoRoot/taskInfo/buttonTask",
				0,
				0,
				0,
				-1,
				3.5,
				1,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "TaskSystemUI(Clone)",
		GuideSubID = 301503,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				301503,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "TaskSystemUI(Clone)",
		GuideSubID = 301504,
		GuideName = "引导点击常行世间卡池",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				150,
				90,
				"TaskSystemUI(Clone)/Root/Panel_UI/CenterContent/TapContent/TapContent/Day",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				301504,
				-180,
				-200
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_01",
				"TaskSystemUI(Clone)/Root/Panel_UI/CenterContent/TapContent/TapContent/Day",
				0,
				0,
				0,
				-1,
				1.5,
				0.9,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "TaskSystemUI(Clone)",
		GuideSubID = 301505,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				301505,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 301601,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				301601,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 301602,
		GuideName = "引导点击常行世间卡池",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				90,
				90,
				"MainUI(Clone)/Root/Panel_UI/RpgRoot/RightBottom/SmallPhone/OpenPhoneBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				301602,
				300,
				-200
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_01",
				"MainUI(Clone)/Root/Panel_UI/RpgRoot/RightBottom/SmallPhone/OpenPhoneBtn",
				0,
				0,
				0,
				-1,
				0.9,
				0.9,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "MainPhoneUI(Clone)",
		GuideSubID = 301603,
		GuideName = "引导点击单抽",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				90,
				90,
				"MainUI(Clone)/MainPhoneUI/Root/menuPanel_UI/Top/Left/ButtonSort/ButtonRoot/HeroBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				301603,
				0,
				-180
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_01",
				"MainUI(Clone)/MainPhoneUI/Root/menuPanel_UI/Top/Left/ButtonSort/ButtonRoot/HeroBtn",
				0,
				0,
				0,
				-1,
				0.9,
				0.9,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "WarlockChoosePanel(Clone)",
		GuideSubID = 301604,
		GuideName = "引导点击单抽",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				210,
				500,
				"WarlockChoosePanel(Clone)/Root/ScroolRoot/ScrollAreaBig/Viewport/Index_0/Item1",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				301604,
				0,
				-180
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_03",
				"WarlockChoosePanel(Clone)/Root/ScroolRoot/ScrollAreaBig/Viewport/Index_0/Item1",
				0,
				0,
				0,
				-1,
				16.25,
				0.95,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 301605,
		GuideName = "旁白说明引导点击升级按键1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				301605,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 301606,
		GuideName = "引导点击升级按键",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				80,
				80,
				"RoleDevelopmentPanel(Clone)/ContentRoot/LeftContent/TabListRoot/ToggleGroup/upGradationTabItem",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				301606,
				330,
				150
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan_01",
				"RoleDevelopmentPanel(Clone)/ContentRoot/LeftContent/TabListRoot/ToggleGroup/upGradationTabItem",
				0,
				0,
				0,
				-1,
				2,
				2,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "RoleDevelopmentPanel(Clone)",
		GuideSubID = 301607,
		GuideName = "旁白说明引导点击升级按键1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				301607,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 301701,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				301701,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 301702,
		GuideName = "引导点击常行世间卡池",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				210,
				115,
				"MainUI(Clone)/Root/Panel_UI/RpgRoot/RPGInfoRoot/buttonMap",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				301702,
				-400,
				150
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_01",
				"MainUI(Clone)/Root/Panel_UI/RpgRoot/RPGInfoRoot/buttonMap",
				0,
				0,
				0,
				-1,
				1.9,
				1.3,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "WorldAreaUI(Clone)/Root/TapContent/TapContent/Day",
		GuideSubID = 301703,
		GuideName = "引导点击常行世间卡池",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				140,
				75,
				"WorldAreaUI(Clone)/Root/TapContent/TapContent/Activity",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				301703,
				400,
				-200
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_02",
				"WorldAreaUI(Clone)/Root/TapContent/TapContent/Activity",
				0,
				0,
				0,
				-1,
				0.95,
				0.7,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "WorldAreaUI(Clone)/Root/Richang/button1",
		GuideSubID = 301704,
		GuideName = "引导点击常行世间卡池",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				100,
				100,
				"WorldAreaUI(Clone)/Root/Wanfa/button1",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				301704,
				-200,
				-100
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan_01",
				"WorldAreaUI(Clone)/Root/Wanfa/button1",
				0,
				0,
				0,
				-1,
				3.1,
				3.1,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "LoopTowerDungeonUI(Clone)",
		GuideSubID = 301705,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				301705,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 301751,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				301751,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 301752,
		GuideName = "引导点击常行世间卡池",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				210,
				115,
				"MainUI(Clone)/Root/Panel_UI/RpgRoot/RPGInfoRoot/buttonMap",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				301752,
				-400,
				150
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_01",
				"MainUI(Clone)/Root/Panel_UI/RpgRoot/RPGInfoRoot/buttonMap",
				0,
				0,
				0,
				-1,
				1.9,
				1.3,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "WorldAreaUI(Clone)/Root/TapContent/TapContent/Day",
		GuideSubID = 301753,
		GuideName = "引导点击常行世间卡池",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				140,
				75,
				"WorldAreaUI(Clone)/Root/TapContent/TapContent/Activity",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				301753,
				400,
				-200
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_02",
				"WorldAreaUI(Clone)/Root/TapContent/TapContent/Activity",
				0,
				0,
				0,
				-1,
				0.95,
				0.7,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "WorldAreaUI(Clone)",
		GuideSubID = 301754,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				301754,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 301801,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				301801,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 301802,
		GuideName = "引导点击常行世间卡池",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				210,
				115,
				"MainUI(Clone)/Root/Panel_UI/RpgRoot/RPGInfoRoot/buttonMap",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				301802,
				-400,
				150
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_01",
				"MainUI(Clone)/Root/Panel_UI/RpgRoot/RPGInfoRoot/buttonMap",
				0,
				0,
				0,
				-1,
				1.9,
				1.3,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "WorldAreaUI(Clone)/Root/TapContent/TapContent/Day",
		GuideSubID = 301803,
		GuideName = "引导点击常行世间卡池",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_04,
				PunchingImgPath.GuideMask_04,
				140,
				75,
				"WorldAreaUI(Clone)/Root/TapContent/TapContent/Activity",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				301803,
				400,
				-200
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_kuang_02",
				"WorldAreaUI(Clone)/Root/TapContent/TapContent/Activity",
				0,
				0,
				0,
				-1,
				0.95,
				0.7,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "WorldAreaUI(Clone)/Root/Richang/button1",
		GuideSubID = 301804,
		GuideName = "引导点击常行世间卡池",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				100,
				100,
				"WorldAreaUI(Clone)/Root/Wanfa/ChallengeWorldBossBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				301804,
				400,
				-100
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan_01",
				"WorldAreaUI(Clone)/Root/Wanfa/ChallengeWorldBossBtn",
				0,
				0,
				0,
				-1,
				3.1,
				3.1,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "ChallengeWorldBossUI(Clone)",
		GuideSubID = 301805,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				301805,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "WarlockChoosePanel(Clone)/Root/Com_ReturnBtn/ReturnBtn",
		GuideSubID = 301901,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				301901,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "WarlockChoosePanel(Clone)/Root/Com_ReturnBtn/ReturnBtn",
		GuideSubID = 301902,
		GuideName = "引导点击常行世间卡池",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				100,
				100,
				"WarlockChoosePanel(Clone)/Root/Com_ReturnBtn/ReturnBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				301902,
				-200,
				100
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan_01",
				"WarlockChoosePanel(Clone)/Root/Com_ReturnBtn/ReturnBtn",
				0,
				0,
				0,
				-1,
				3.1,
				3.1,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 301903,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				301903,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)/MainPhoneUI/Root/menuPanel_UI/Top/Right/BottomBar/buttonMessage",
		GuideSubID = 301904,
		GuideName = "引导点击常行世间卡池",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				100,
				100,
				"MainUI(Clone)/MainPhoneUI/Root/menuPanel_UI/Top/Right/BottomBar/buttonMessage",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				301904,
				500,
				100
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan_01",
				"MainUI(Clone)/MainPhoneUI/Root/menuPanel_UI/Top/Right/BottomBar/buttonMessage",
				0,
				0,
				0,
				-1,
				2,
				2,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "AffinityChatUI(Clone)",
		GuideSubID = 301905,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				301905,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 302001,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				302001,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 302002,
		GuideName = "引导点击单抽",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				290,
				290,
				"MainUI(Clone)/MainPhoneUI/Root/menuPanel_UI/Top/Right/StartGameParent/ExploreBtn",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				302002,
				300,
				-180
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan_01",
				"MainUI(Clone)/MainPhoneUI/Root/menuPanel_UI/Top/Right/StartGameParent/ExploreBtn",
				0,
				0,
				0,
				-1,
				8,
				8,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 302003,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				302003,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 302004,
		GuideName = "图片说明如何编队",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.Picture,
				"Assets/05_Images/DataResource/UIResource/GuideCommonImg/GuideCommonImg_15.png"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 302101,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				302101,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 302102,
		GuideName = "引导点击单抽",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				290,
				290,
				"MainUI(Clone)/Root/Panel_UI/RpgRoot/RPGInfoRoot/buttonMap",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				302102,
				300,
				-180
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan_01",
				"MainUI(Clone)/Root/Panel_UI/RpgRoot/RPGInfoRoot/buttonMap",
				0,
				0,
				0,
				-1,
				8,
				8,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 302103,
		GuideName = "引导点击单抽",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				290,
				290,
				"WorldAreaUI(Clone)/Root/mapScroll/viewport/content/10100/buttonClick",
				0,
				0,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				302103,
				300,
				-180
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan_01",
				"WorldAreaUI(Clone)/Root/mapScroll/viewport/content/10100/buttonClick",
				0,
				0,
				0,
				-1,
				8,
				8,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 302104,
		GuideName = "引导点击单抽",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.ClickArea,
				0,
				CenterImgPath.GuideMask_03,
				PunchingImgPath.GuideMask_03,
				290,
				290,
				"WorldAreaUI(Clone)/Root/areaDetailPop/detailScroll/viewport/detailContent/roomPrefab(Clone)/buttonClick",
				0,
				-100,
				0,
				-1,
				"ClickOn",
				0.7,
				321013,
				302104,
				0,
				-250
			},
			{
				GuideType.PlayEffect,
				1,
				"FX_UI/FX_UI_tishi_yuan_01",
				"WorldAreaUI(Clone)/Root/areaDetailPop/detailScroll/viewport/detailContent/roomPrefab(Clone)/buttonClick",
				0,
				-100,
				0,
				-1,
				8,
				8,
				"effect/1"
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 302105,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				302105,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		GuideSubShow = "MainUI(Clone)",
		GuideSubID = 302106,
		GuideName = "旁白说明降神1",
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.NpcTalk,
				1,
				321012,
				0.4,
				0.4,
				-560,
				-10,
				302106,
				"#0D0B0B50",
				1,
				0
			}
		}
	},
	{
		ImagePath = "Assets/05_Images/DataResource/UIResource/GuideCommonImg/GuideCommonImg_14.png",
		GuideSubID = 1000001
	},
	{
		GuideSubShow = "随便填",
		PlotID = 401002,
		GuideSubID = 6001,
		GuideName = "迷宫首次激活剧情",
		PlotEndID = 401002,
		GuideShowTime = -1,
		GuideUIType = {
			{
				GuideType.StartStory
			}
		}
	}
}

return GuideSub
